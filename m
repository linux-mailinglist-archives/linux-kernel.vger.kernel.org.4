Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F355FCD98
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 23:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiJLV5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 17:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJLV5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 17:57:22 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 652E610451A;
        Wed, 12 Oct 2022 14:57:21 -0700 (PDT)
Received: from localhost.localdomain (unknown [76.135.50.127])
        by linux.microsoft.com (Postfix) with ESMTPSA id 179C920F0F77;
        Wed, 12 Oct 2022 14:57:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 179C920F0F77
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1665611841;
        bh=cBwmnLdZr7+xCHkswbZxO11VOAXb4IRb/2OCDhqD//U=;
        h=From:To:Cc:Subject:Date:From;
        b=nujnO1WCLnkK/yPReail5/fe+pehA5rL172rcM82lvRtobSLGnke5+syFW3Q3VsXu
         zpuobY5doRb0jp5sPS7efPFbuhftxXGC2bIe6vFlvMNcGxW3iqHlVgOnbccu229v6u
         DrSf1k/WpWuPaF4/73FaGy3KQfmcp/slGT8SDcrY=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tracing: Track event ref in tracefs enable/disable
Date:   Wed, 12 Oct 2022 14:57:17 -0700
Message-Id: <20221012215717.10492-1-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When events are enabled via the "enable" file within tracefs there is no
get or put ref. Add these to ensure modules and dynamic events do not
unload while the event is enabled via tracefs.

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 kernel/trace/trace_events.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 0356cae0cf74..f0b17adba1bc 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -634,6 +634,8 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 			}
 
 			call->class->reg(call, TRACE_REG_UNREGISTER, file);
+
+			trace_event_put_ref(call);
 		}
 		/* If in SOFT_MODE, just set the SOFT_DISABLE_BIT, else clear it */
 		if (file->flags & EVENT_FILE_FL_SOFT_MODE)
@@ -659,7 +661,7 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 		}
 
 		if (!(file->flags & EVENT_FILE_FL_ENABLED)) {
-			bool cmd = false, tgid = false;
+			bool cmd = false, tgid = false, put = false;
 
 			/* Keep the event disabled, when going to SOFT_MODE. */
 			if (soft_disable)
@@ -677,14 +679,22 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 				set_bit(EVENT_FILE_FL_RECORDED_TGID_BIT, &file->flags);
 			}
 
+			if (!trace_event_try_get_ref(call))
+				goto error_enabling;
+
+			put = true;
+
 			ret = call->class->reg(call, TRACE_REG_REGISTER, file);
 			if (ret) {
+error_enabling:
+				pr_info("event trace: Could not enable event "
+					"%s\n", trace_event_name(call));
 				if (cmd)
 					tracing_stop_cmdline_record();
 				if (tgid)
 					tracing_stop_tgid_record();
-				pr_info("event trace: Could not enable event "
-					"%s\n", trace_event_name(call));
+				if (put)
+					trace_event_put_ref(call);
 				break;
 			}
 			set_bit(EVENT_FILE_FL_ENABLED_BIT, &file->flags);

base-commit: 6c0f39e87b6ab1a3009e3a49d3e6f6db8dc756a8
-- 
2.25.1


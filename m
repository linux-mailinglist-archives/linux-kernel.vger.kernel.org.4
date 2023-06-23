Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6F773AE55
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 03:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjFWBds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 21:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjFWBdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 21:33:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CED01FE9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 18:33:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F044261949
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 01:33:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51067C433C8;
        Fri, 23 Jun 2023 01:33:37 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qCVg8-002M7B-0W;
        Thu, 22 Jun 2023 21:33:36 -0400
Message-ID: <20230623013335.974523605@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 22 Jun 2023 21:31:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        sunliming <sunliming@kylinos.cn>,
        Beau Belgrave <beaub@linux.microsoft.com>
Subject: [for-linus][PATCH 1/3] tracing/user_events: Fix incorrect return value for writing operation
 when events are disabled
References: <20230623013152.037225511@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: sunliming <sunliming@kylinos.cn>

The writing operation return the count of writes regardless of whether events
are enabled or disabled. Switch it to return 0 to indicates that the event
is disabled.

Link: https://lore.kernel.org/linux-trace-kernel/20230621060827.151564-2-sunliming@kylinos.cn

Signed-off-by: sunliming <sunliming@kylinos.cn>
Acked-by: Beau Belgrave <beaub@linux.microsoft.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_user.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 8df0550415e7..902cae005df4 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -2096,7 +2096,8 @@ static ssize_t user_events_write_core(struct file *file, struct iov_iter *i)
 
 		if (unlikely(faulted))
 			return -EFAULT;
-	}
+	} else
+		return 0;
 
 	return ret;
 }
-- 
2.39.2

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8EA63D012
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 09:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234162AbiK3IDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 03:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbiK3IDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 03:03:34 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656ED4384B
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 00:03:33 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NMWtC5PVGz8RV7H;
        Wed, 30 Nov 2022 16:03:31 +0800 (CST)
Received: from szxlzmapp01.zte.com.cn ([10.5.231.85])
        by mse-fl1.zte.com.cn with SMTP id 2AU83Mb7028919;
        Wed, 30 Nov 2022 16:03:22 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp02[null])
        by mapi (Zmail) with MAPI id mid14;
        Wed, 30 Nov 2022 16:03:25 +0800 (CST)
Date:   Wed, 30 Nov 2022 16:03:25 +0800 (CST)
X-Zmail-TransId: 2b0463870e4dffffffffb593ad86
X-Mailer: Zmail v1.0
Message-ID: <202211301603255479087@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <rostedt@goodmis.org>
Cc:     <mhiramat@kernel.org>, <linux-kernel@vger.kernel.org>,
        <xu.panda@zte.com.cn>, <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIHRyYWNpbmc6IHVzZSBzdHJzY3B5KCkgdG8gaW5zdGVhZCBvZiBzdHJsY3B5KCk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2AU83Mb7028919
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 63870E53.003 by FangMail milter!
X-FangMail-Envelope: 1669795411/4NMWtC5PVGz8RV7H/63870E53.003/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<yang.yang29@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63870E53.003/4NMWtC5PVGz8RV7H
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu Panda <xu.panda@zte.com.cn>

The implementation of strscpy() is more robust and safer.
That's now the recommended way to copy NUL terminated strings.

Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
Signed-off-by: Yang Yang <yang.yang29@zte.com>
---
 kernel/trace/trace_events.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 3bfaf560ecc4..e2314d7f4d83 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2813,7 +2813,7 @@ static __init int setup_trace_triggers(char *str)
 	char *buf;
 	int i;

-	strlcpy(bootup_trigger_buf, str, COMMAND_LINE_SIZE);
+	strscpy(bootup_trigger_buf, str, COMMAND_LINE_SIZE);
 	ring_buffer_expanded = true;
 	disable_tracing_selftest("running event triggers");

@@ -3608,7 +3608,7 @@ static char bootup_event_buf[COMMAND_LINE_SIZE] __initdata;

 static __init int setup_trace_event(char *str)
 {
-	strlcpy(bootup_event_buf, str, COMMAND_LINE_SIZE);
+	strscpy(bootup_event_buf, str, COMMAND_LINE_SIZE);
 	ring_buffer_expanded = true;
 	disable_tracing_selftest("running event tracing");

-- 
2.15.2

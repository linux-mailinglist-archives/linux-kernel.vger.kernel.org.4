Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6085BBDC8
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 14:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiIRM3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 08:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiIRM3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 08:29:33 -0400
Received: from out199-17.us.a.mail.aliyun.com (out199-17.us.a.mail.aliyun.com [47.90.199.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EB2BD8
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 05:29:30 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=chentao.kernel@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VQ2EdcT_1663504150;
Received: from VM20210331-5.tbsite.net(mailfrom:chentao.kernel@linux.alibaba.com fp:SMTPD_---0VQ2EdcT_1663504150)
          by smtp.aliyun-inc.com;
          Sun, 18 Sep 2022 20:29:25 +0800
From:   Tao Chen <chentao.kernel@linux.alibaba.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Tao Chen <chentao.kernel@linux.alibaba.com>
Subject: [PATCH] tracing/eprobe: Fix alloc event dir failed when event name no set
Date:   Sun, 18 Sep 2022 20:29:08 +0800
Message-Id: <1663504148-40723-1-git-send-email-chentao.kernel@linux.alibaba.com>
X-Mailer: git-send-email 2.2.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The event dir will alloc failed when event name no set, using the
command:
"echo "e:esys/ syscalls/sys_enter_openat file=\$filename:string"
>> dynamic_events"
It seems that dir name="syscalls/sys_enter_openat" is not allowed
in debugfs. So just use the "sys_enter_openat" as the event name.

Fixes: 7491e2c44278 ("tracing: Add a probe that attaches to trace
events")
Signed-off-by: Tao Chen <chentao.kernel@linux.alibaba.com>
---
 kernel/trace/trace_eprobe.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 1783e3478912..a8938e54cd34 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -968,8 +968,7 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 	}
 
 	if (!event) {
-		strscpy(buf1, argv[1], MAX_EVENT_NAME_LEN);
-		sanitize_event_name(buf1);
+		strscpy(buf1, sys_event, MAX_EVENT_NAME_LEN);
 		event = buf1;
 	}
 
-- 
2.32.0


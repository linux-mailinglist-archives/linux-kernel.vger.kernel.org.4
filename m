Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C775EC8E7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbiI0QCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbiI0QBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:01:41 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5222258531
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:01:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 31853CE19D0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 16:01:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B832C433D7;
        Tue, 27 Sep 2022 16:01:35 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1odD2j-00G2sK-37;
        Tue, 27 Sep 2022 12:02:45 -0400
Message-ID: <20220927160245.524291097@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 27 Sep 2022 12:02:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>
Subject: [for-next][PATCH 09/20] tracepoint: Optimize the critical region of mutex_lock in
 tracepoint_module_coming()
References: <20220927160216.349640304@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhen Lei <thunder.leizhen@huawei.com>

The memory allocation of 'tp_mod' does not require mutex_lock()
protection, move it out.

Link: https://lkml.kernel.org/r/20220914061416.1630-1-thunder.leizhen@huawei.com

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/tracepoint.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index ef42c1a11920..f23144af5743 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -640,7 +640,6 @@ static void tp_module_going_check_quiescent(struct tracepoint *tp, void *priv)
 static int tracepoint_module_coming(struct module *mod)
 {
 	struct tp_module *tp_mod;
-	int ret = 0;
 
 	if (!mod->num_tracepoints)
 		return 0;
@@ -652,19 +651,18 @@ static int tracepoint_module_coming(struct module *mod)
 	 */
 	if (trace_module_has_bad_taint(mod))
 		return 0;
-	mutex_lock(&tracepoint_module_list_mutex);
+
 	tp_mod = kmalloc(sizeof(struct tp_module), GFP_KERNEL);
-	if (!tp_mod) {
-		ret = -ENOMEM;
-		goto end;
-	}
+	if (!tp_mod)
+		return -ENOMEM;
 	tp_mod->mod = mod;
+
+	mutex_lock(&tracepoint_module_list_mutex);
 	list_add_tail(&tp_mod->list, &tracepoint_module_list);
 	blocking_notifier_call_chain(&tracepoint_notify_list,
 			MODULE_STATE_COMING, tp_mod);
-end:
 	mutex_unlock(&tracepoint_module_list_mutex);
-	return ret;
+	return 0;
 }
 
 static void tracepoint_module_going(struct module *mod)
-- 
2.35.1

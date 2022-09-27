Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493B25EC8E8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbiI0QCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbiI0QBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:01:42 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2121114B
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:01:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 10D6DCE19D1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 16:01:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 792CBC433B5;
        Tue, 27 Sep 2022 16:01:37 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1odD2m-00G2u5-04;
        Tue, 27 Sep 2022 12:02:48 -0400
Message-ID: <20220927160247.410787337@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 27 Sep 2022 12:02:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        <linux-riscv@lists.infradead.org>, <mingo@redhat.com>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <zanussi@kernel.org>,
        <liaochang1@huawei.com>, <chris.zjh@huawei.com>,
        Yipeng Zou <zouyipeng@huawei.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: [for-next][PATCH 12/20] tracing: kprobe: Fix kprobe event gen test module on exit
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

From: Yipeng Zou <zouyipeng@huawei.com>

Correct gen_kretprobe_test clr event para on module exit.
This will make it can't to delete.

Link: https://lkml.kernel.org/r/20220919125629.238242-2-zouyipeng@huawei.com

Cc: <linux-riscv@lists.infradead.org>
Cc: <mingo@redhat.com>
Cc: <paul.walmsley@sifive.com>
Cc: <palmer@dabbelt.com>
Cc: <aou@eecs.berkeley.edu>
Cc: <zanussi@kernel.org>
Cc: <liaochang1@huawei.com>
Cc: <chris.zjh@huawei.com>
Fixes: 64836248dda2 ("tracing: Add kprobe event command generation test module")
Signed-off-by: Yipeng Zou <zouyipeng@huawei.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/kprobe_event_gen_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/kprobe_event_gen_test.c b/kernel/trace/kprobe_event_gen_test.c
index 18b0f1cbb947..e023154be0f8 100644
--- a/kernel/trace/kprobe_event_gen_test.c
+++ b/kernel/trace/kprobe_event_gen_test.c
@@ -206,7 +206,7 @@ static void __exit kprobe_event_gen_test_exit(void)
 	WARN_ON(kprobe_event_delete("gen_kprobe_test"));
 
 	/* Disable the event or you can't remove it */
-	WARN_ON(trace_array_set_clr_event(gen_kprobe_test->tr,
+	WARN_ON(trace_array_set_clr_event(gen_kretprobe_test->tr,
 					  "kprobes",
 					  "gen_kretprobe_test", false));
 
-- 
2.35.1

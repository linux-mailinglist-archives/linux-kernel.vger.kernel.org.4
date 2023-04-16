Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28BC6E3998
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 17:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjDPPF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 11:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjDPPF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 11:05:27 -0400
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4106C5
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 08:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1681657522;
        bh=AhOIysLciGfF0MAR/cFkglmUP9qKvl8+zowFKTu98wA=;
        h=From:To:Cc:Subject:Date;
        b=GUTb7GyxRM+ISPrkAnHkynBFRCbAPecCjQIZ76jDEjJTMNwtEs1O9W1QgwxVNHNoY
         moRw/akn1f/NpSXBLSMWAbBhdLIdvavRfoKdVFCeHvqlY/zGi3jZ18THpfQ3873i7r
         Yk/p/tSeRkUPG4PnGtn4WQ/3YiVFrHes5L7Hwthg=
Received: from rtoax.. ([111.199.190.121])
        by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
        id 15381C4E; Sun, 16 Apr 2023 23:05:19 +0800
X-QQ-mid: xmsmtpt1681657519t1yn8m3ow
Message-ID: <tencent_D547A5F2B576141E11CCA04308252BE61205@qq.com>
X-QQ-XMAILINFO: OGZxhFXqN7PJZuDu2qLVR7tT0Pg4S8kZaW5M4pPypjhb0eoKJBqdbOwaw1tZtF
         EWSqFEOOWf61NJVhXKj8tKvLUF8LBVvf5gvwPjEOGxi/JOlJ001Zsa7N0j4lI+cA2dizYhQGP1GR
         sI5YJA7MZan/LaqC+SpbZzL7bAtq+BkABthI4b5fIKQRdEzywmJzc+XkbqS61xoXWC5JuDGo2+yw
         wxGTI3mh9JA5lhg/VRI7jSZErw0Xp0syplsNNd7SUutAD+OBV+5ByweiagIKkks1s2AfIvHhoAh8
         gU5ZPODtl5ZsKafGG7XquXauukx9aOOfHbCPZ6RLhOowyNjNNCWvMNm+9eIDFaK/jWlHUHlELoCI
         T6G0DqjFQx3crS9ADbqUqroKJ2iu9X4c5G+aI2T3JPwZZ+Di269UJ2NUdqRxXdF01qy/A8BTZnQk
         MwCu/Snl+4hF1epRK6s1eo7q7wg/9PiOCjGwCpKLJR3YJ5E4zOxdUdnzsfwnI9Tvom3DNRrXWpKU
         +g4qrox7fO5aTLILpF+rg7JgcYsBh5UF7r2rNXFdGSyO56oZddddJP+sVavT8+JLsL2ciiLtQG/P
         Vuf4Mhm1IKKJmNY7HOT12BSNplSGvGmq0Lsf3N7EXsLd6w7Dkyfsa7V5vrTB/ycVS9Y2b1ayUsMd
         Vtncir6amFJdG4nEHenrLkyw0bVK6q5IIh/jTwIMgkiY7oYAkgmTAJrEY2iEftxic94kK7N3nwhX
         TsqA+vjtULDcxK3s1RSOe1RjaL9p0RH7EoSwk0G5PyifulfTGfSsFUO7UcKOGa/st6hlrEtJ6Yyy
         tN98UARMREuKLrHPTcv1Mqefqh2cC7NwNJduN0cu9BNt+qy2suauExgpsDQyGQFbcxjzRHB/AAe4
         QOIf0cywZ4UeS6aSJvIsyFN4kRjDE05jdbO6Lk6TLx2fukWCv/E035ib2nNYTjsqUMunK3eGdpU9
         yuApCg5dUz7aE/FZd4ZqofFVlHqeOP6ABRNcxnEeA=
From:   Rong Tao <rtoax@foxmail.com>
To:     will@kernel.org
Cc:     prasad@linux.vnet.ibm.com, tglx@linutronix.de,
        gregkh@linuxfoundation.org, frederic@kernel.org,
        qperret@google.com, ast@kernel.org, mbenes@suse.cz,
        pmladek@suse.com, rongtao@cestc.cn,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] samples/hw_breakpoint: Fix kernel BUG 'invalid opcode: 0000'
Date:   Sun, 16 Apr 2023 23:05:17 +0800
X-OQ-MSGID: <20230416150518.90156-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

Macro symbol_put() is defined as __symbol_put(__stringify(x))

    ksym_name = "jiffies"
    symbol_put(ksym_name)

will be resolved as

    __symbol_put("ksym_name")

which is clearly wrong. So symbol_put must be replaced with __symbol_put.

When we uninstall hw_breakpoint.ko (rmmod), a kernel bug occurs with the
following error:

[11381.854152] kernel BUG at kernel/module/main.c:779!
[11381.854159] invalid opcode: 0000 [#2] PREEMPT SMP PTI
[11381.854163] CPU: 8 PID: 59623 Comm: rmmod Tainted: G      D    OE      6.2.9-200.fc37.x86_64 #1
[11381.854167] Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./B360M-HDV, BIOS P3.20 10/23/2018
[11381.854169] RIP: 0010:__symbol_put+0xa2/0xb0
[11381.854175] Code: 00 e8 92 d2 f7 ff 65 8b 05 c3 2f e6 78 85 c0 74 1b 48 8b 44 24 30 65 48 2b 04 25 28 00 00 00 75 12 48 83 c4 38 c3 cc cc cc cc <0f> 0b 0f 1f 44 00 00 eb de e8 c0 df d8 00 90 90 90 90 90 90 90 90
[11381.854178] RSP: 0018:ffffad8ec6ae7dd0 EFLAGS: 00010246
[11381.854181] RAX: 0000000000000000 RBX: ffffffffc1fd1240 RCX: 000000000000000c
[11381.854184] RDX: 000000000000006b RSI: ffffffffc02bf7c7 RDI: ffffffffc1fd001c
[11381.854186] RBP: 000055a38b76e7c8 R08: ffffffff871ccfe0 R09: 0000000000000000
[11381.854188] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[11381.854190] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[11381.854192] FS:  00007fbf7c62c740(0000) GS:ffff8c5badc00000(0000) knlGS:0000000000000000
[11381.854195] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[11381.854197] CR2: 000055a38b7793f8 CR3: 0000000363e1e001 CR4: 00000000003726e0
[11381.854200] DR0: ffffffffb3407980 DR1: 0000000000000000 DR2: 0000000000000000
[11381.854202] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[11381.854204] Call Trace:
[11381.854207]  <TASK>
[11381.854212]  s_module_exit+0xc/0xff0 [symbol_getput]
[11381.854219]  __do_sys_delete_module.constprop.0+0x198/0x2f0
[11381.854225]  do_syscall_64+0x58/0x80
[11381.854231]  ? exit_to_user_mode_prepare+0x180/0x1f0
[11381.854237]  ? syscall_exit_to_user_mode+0x17/0x40
[11381.854241]  ? do_syscall_64+0x67/0x80
[11381.854245]  ? syscall_exit_to_user_mode+0x17/0x40
[11381.854248]  ? do_syscall_64+0x67/0x80
[11381.854252]  ? exc_page_fault+0x70/0x170
[11381.854256]  entry_SYSCALL_64_after_hwframe+0x72/0xdc

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 samples/hw_breakpoint/data_breakpoint.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/hw_breakpoint/data_breakpoint.c b/samples/hw_breakpoint/data_breakpoint.c
index 418c46fe5ffc..9debd128b2ab 100644
--- a/samples/hw_breakpoint/data_breakpoint.c
+++ b/samples/hw_breakpoint/data_breakpoint.c
@@ -70,7 +70,7 @@ static int __init hw_break_module_init(void)
 static void __exit hw_break_module_exit(void)
 {
 	unregister_wide_hw_breakpoint(sample_hbp);
-	symbol_put(ksym_name);
+	__symbol_put(ksym_name);
 	printk(KERN_INFO "HW Breakpoint for %s write uninstalled\n", ksym_name);
 }
 
-- 
2.39.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA70761EB99
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 08:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbiKGHSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 02:18:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbiKGHSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 02:18:16 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE2C13D44
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 23:17:37 -0800 (PST)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4N5MtN52fyzJnW5;
        Mon,  7 Nov 2022 15:14:36 +0800 (CST)
Received: from huawei.com (10.175.100.227) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 7 Nov
 2022 15:17:35 +0800
From:   Shang XiaoJing <shangxiaojing@huawei.com>
To:     <rostedt@goodmis.org>, <mhiramat@kernel.org>, <zanussi@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <shangxiaojing@huawei.com>
Subject: [PATCH 2/2] tracing: kprobe: Fix potential null-ptr-deref on trace_array in kprobe_event_gen_test_exit()
Date:   Mon, 7 Nov 2022 15:16:17 +0800
Message-ID: <20221107071617.21644-3-shangxiaojing@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221107071617.21644-1-shangxiaojing@huawei.com>
References: <20221107071617.21644-1-shangxiaojing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When test_gen_kprobe_cmd() failed after kprobe_event_gen_cmd_end(), it
will goto delete, which will call kprobe_event_delete() and release the
corresponding resource. However, the trace_array in gen_kretprobe_test
will point to the invalid resource. Set gen_kretprobe_test->tr to NULL
after called kprobe_event_delete() and add NULL check when releasing
the module.

BUG: kernel NULL pointer dereference, address: 0000000000000070
PGD 0 P4D 0
Oops: 0000 [#1] SMP PTI
CPU: 0 PID: 246 Comm: modprobe Tainted: G        W
6.1.0-rc1-00174-g9522dc5c87da-dirty #248
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
RIP: 0010:__ftrace_set_clr_event_nolock+0x53/0x1b0
Code: e8 82 26 fc ff 49 8b 1e c7 44 24 0c ea ff ff ff 49 39 de 0f 84 3c
01 00 00 c7 44 24 18 00 00 00 00 e8 61 26 fc ff 48 8b 6b 10 <44> 8b 65
70 4c 8b 6d 18 41 f7 c4 00 02 00 00 75 2f
RSP: 0018:ffffc9000159fe00 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88810971d268 RCX: 0000000000000000
RDX: ffff8881080be600 RSI: ffffffff811b48ff RDI: ffff88810971d058
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
R10: ffffc9000159fe58 R11: 0000000000000001 R12: ffffffffa0001064
R13: ffffffffa000106c R14: ffff88810971d238 R15: 0000000000000000
FS:  00007f89eeff6540(0000) GS:ffff88813b600000(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000070 CR3: 000000010599e004 CR4: 0000000000330ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __ftrace_set_clr_event+0x3e/0x60
 trace_array_set_clr_event+0x35/0x50
 ? 0xffffffffa0000000
 kprobe_event_gen_test_exit+0xcd/0x10b [kprobe_event_gen_test]
 __x64_sys_delete_module+0x206/0x380
 ? lockdep_hardirqs_on_prepare+0xd8/0x190
 ? syscall_enter_from_user_mode+0x1c/0x50
 do_syscall_64+0x3f/0x90
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f89eeb061b7

Fixes: 64836248dda2 ("tracing: Add kprobe event command generation test module")
Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
---
 kernel/trace/kprobe_event_gen_test.c | 29 +++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/kernel/trace/kprobe_event_gen_test.c b/kernel/trace/kprobe_event_gen_test.c
index 1c98fafcf333..277e21e4a63e 100644
--- a/kernel/trace/kprobe_event_gen_test.c
+++ b/kernel/trace/kprobe_event_gen_test.c
@@ -145,6 +145,8 @@ static int __init test_gen_kprobe_cmd(void)
  delete:
 	/* We got an error after creating the event, delete it */
 	ret = kprobe_event_delete("gen_kprobe_test");
+	if (trace_event_file_is_valid(gen_kprobe_test))
+		gen_kprobe_test->tr = NULL;
 	goto out;
 }
 
@@ -208,6 +210,8 @@ static int __init test_gen_kretprobe_cmd(void)
  delete:
 	/* We got an error after creating the event, delete it */
 	ret = kprobe_event_delete("gen_kretprobe_test");
+	if (trace_event_file_is_valid(gen_kretprobe_test))
+		gen_kretprobe_test->tr = NULL;
 	goto out;
 }
 
@@ -222,9 +226,10 @@ static int __init kprobe_event_gen_test_init(void)
 	ret = test_gen_kretprobe_cmd();
 	if (ret) {
 		if (trace_event_file_is_valid(gen_kretprobe_test)) {
-			WARN_ON(trace_array_set_clr_event(gen_kretprobe_test->tr,
-							  "kprobes",
-							  "gen_kretprobe_test", false));
+			if (gen_kretprobe_test->tr)
+				WARN_ON(trace_array_set_clr_event(gen_kretprobe_test->tr,
+								  "kprobes",
+								  "gen_kretprobe_test", false));
 			trace_put_event_file(gen_kretprobe_test);
 		}
 		WARN_ON(kprobe_event_delete("gen_kretprobe_test"));
@@ -236,10 +241,11 @@ static int __init kprobe_event_gen_test_init(void)
 static void __exit kprobe_event_gen_test_exit(void)
 {
 	if (trace_event_file_is_valid(gen_kprobe_test)) {
-		/* Disable the event or you can't remove it */
-		WARN_ON(trace_array_set_clr_event(gen_kprobe_test->tr,
-						  "kprobes",
-						  "gen_kprobe_test", false));
+		if (gen_kprobe_test->tr)
+			/* Disable the event or you can't remove it */
+			WARN_ON(trace_array_set_clr_event(gen_kprobe_test->tr,
+							  "kprobes",
+							  "gen_kprobe_test", false));
 
 		/* Now give the file and instance back */
 		trace_put_event_file(gen_kprobe_test);
@@ -250,10 +256,11 @@ static void __exit kprobe_event_gen_test_exit(void)
 	WARN_ON(kprobe_event_delete("gen_kprobe_test"));
 
 	if (trace_event_file_is_valid(gen_kretprobe_test)) {
-		/* Disable the event or you can't remove it */
-		WARN_ON(trace_array_set_clr_event(gen_kretprobe_test->tr,
-						  "kprobes",
-						  "gen_kretprobe_test", false));
+		if (gen_kretprobe_test->tr)
+			/* Disable the event or you can't remove it */
+			WARN_ON(trace_array_set_clr_event(gen_kretprobe_test->tr,
+							  "kprobes",
+							  "gen_kretprobe_test", false));
 
 		/* Now give the file and instance back */
 		trace_put_event_file(gen_kretprobe_test);
-- 
2.17.1


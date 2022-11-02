Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20212615CFA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 08:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbiKBHbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 03:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiKBHbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 03:31:06 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A2F23150
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 00:31:05 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N2JTJ07JNzHvSF;
        Wed,  2 Nov 2022 15:30:43 +0800 (CST)
Received: from huawei.com (10.175.100.227) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 15:31:02 +0800
From:   Shang XiaoJing <shangxiaojing@huawei.com>
To:     <rostedt@goodmis.org>, <mhiramat@kernel.org>, <zanussi@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <shangxiaojing@huawei.com>
Subject: [PATCH] tracing: kprobe: Fix memory leak in test_gen_kprobe/kretprobe_cmd()
Date:   Wed, 2 Nov 2022 15:29:54 +0800
Message-ID: <20221102072954.26555-1-shangxiaojing@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

test_gen_kprobe_cmd() only free buf in fail path, hence buf will leak
when there is no failure. Move kfree(buf) from fail path to common path
to prevent the memleak. The same reason and solution in
test_gen_kretprobe_cmd().

unreferenced object 0xffff888143b14000 (size 2048):
  comm "insmod", pid 52490, jiffies 4301890980 (age 40.553s)
  hex dump (first 32 bytes):
    70 3a 6b 70 72 6f 62 65 73 2f 67 65 6e 5f 6b 70  p:kprobes/gen_kp
    72 6f 62 65 5f 74 65 73 74 20 64 6f 5f 73 79 73  robe_test do_sys
  backtrace:
    [<000000006d7b836b>] kmalloc_trace+0x27/0xa0
    [<0000000009528b5b>] 0xffffffffa059006f
    [<000000008408b580>] do_one_initcall+0x87/0x2a0
    [<00000000c4980a7e>] do_init_module+0xdf/0x320
    [<00000000d775aad0>] load_module+0x3006/0x3390
    [<00000000e9a74b80>] __do_sys_finit_module+0x113/0x1b0
    [<000000003726480d>] do_syscall_64+0x35/0x80
    [<000000003441e93b>] entry_SYSCALL_64_after_hwframe+0x46/0xb0

Fixes: 64836248dda2 ("tracing: Add kprobe event command generation test module")
Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
---
 kernel/trace/kprobe_event_gen_test.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/kernel/trace/kprobe_event_gen_test.c b/kernel/trace/kprobe_event_gen_test.c
index 80e04a1e1977..d81f7c51025c 100644
--- a/kernel/trace/kprobe_event_gen_test.c
+++ b/kernel/trace/kprobe_event_gen_test.c
@@ -100,20 +100,20 @@ static int __init test_gen_kprobe_cmd(void)
 					 KPROBE_GEN_TEST_FUNC,
 					 KPROBE_GEN_TEST_ARG0, KPROBE_GEN_TEST_ARG1);
 	if (ret)
-		goto free;
+		goto out;
 
 	/* Use kprobe_event_add_fields to add the rest of the fields */
 
 	ret = kprobe_event_add_fields(&cmd, KPROBE_GEN_TEST_ARG2, KPROBE_GEN_TEST_ARG3);
 	if (ret)
-		goto free;
+		goto out;
 
 	/*
 	 * This actually creates the event.
 	 */
 	ret = kprobe_event_gen_cmd_end(&cmd);
 	if (ret)
-		goto free;
+		goto out;
 
 	/*
 	 * Now get the gen_kprobe_test event file.  We need to prevent
@@ -136,13 +136,11 @@ static int __init test_gen_kprobe_cmd(void)
 		goto delete;
 	}
  out:
+	kfree(buf);
 	return ret;
  delete:
 	/* We got an error after creating the event, delete it */
 	ret = kprobe_event_delete("gen_kprobe_test");
- free:
-	kfree(buf);
-
 	goto out;
 }
 
@@ -170,14 +168,14 @@ static int __init test_gen_kretprobe_cmd(void)
 					    KPROBE_GEN_TEST_FUNC,
 					    "$retval");
 	if (ret)
-		goto free;
+		goto out;
 
 	/*
 	 * This actually creates the event.
 	 */
 	ret = kretprobe_event_gen_cmd_end(&cmd);
 	if (ret)
-		goto free;
+		goto out;
 
 	/*
 	 * Now get the gen_kretprobe_test event file.  We need to
@@ -201,13 +199,11 @@ static int __init test_gen_kretprobe_cmd(void)
 		goto delete;
 	}
  out:
+	kfree(buf);
 	return ret;
  delete:
 	/* We got an error after creating the event, delete it */
 	ret = kprobe_event_delete("gen_kretprobe_test");
- free:
-	kfree(buf);
-
 	goto out;
 }
 
-- 
2.17.1


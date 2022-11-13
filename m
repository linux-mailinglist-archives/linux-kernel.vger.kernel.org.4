Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85875626DFC
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 08:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbiKMHKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 02:10:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiKMHKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 02:10:52 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495F9D2D1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 23:10:50 -0800 (PST)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4N93Rf5522zJn1g;
        Sun, 13 Nov 2022 15:07:42 +0800 (CST)
Received: from huawei.com (10.175.100.227) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sun, 13 Nov
 2022 15:10:47 +0800
From:   Shang XiaoJing <shangxiaojing@huawei.com>
To:     <rostedt@goodmis.org>, <mhiramat@kernel.org>, <zanussi@kernel.org>,
        <fengguang.wu@intel.com>, <linux-kernel@vger.kernel.org>
CC:     <shangxiaojing@huawei.com>
Subject: [PATCH v2 1/2] tracing: Fix memory leak in test_gen_synth_cmd() and test_empty_synth_event()
Date:   Sun, 13 Nov 2022 15:09:19 +0800
Message-ID: <20221113070920.26236-2-shangxiaojing@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221113070920.26236-1-shangxiaojing@huawei.com>
References: <20221113070920.26236-1-shangxiaojing@huawei.com>
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

test_gen_synth_cmd() only free buf in fail path, hence buf will leak
when there is no failure. Add kfree(buf) to prevent the memleak. The
same reason and solution in test_empty_synth_event().

unreferenced object 0xffff8881127de000 (size 2048):
  comm "modprobe", pid 247, jiffies 4294972316 (age 78.756s)
  hex dump (first 32 bytes):
    20 67 65 6e 5f 73 79 6e 74 68 5f 74 65 73 74 20   gen_synth_test
    20 70 69 64 5f 74 20 6e 65 78 74 5f 70 69 64 5f   pid_t next_pid_
  backtrace:
    [<000000004254801a>] kmalloc_trace+0x26/0x100
    [<0000000039eb1cf5>] 0xffffffffa00083cd
    [<000000000e8c3bc8>] 0xffffffffa00086ba
    [<00000000c293d1ea>] do_one_initcall+0xdb/0x480
    [<00000000aa189e6d>] do_init_module+0x1cf/0x680
    [<00000000d513222b>] load_module+0x6a50/0x70a0
    [<000000001fd4d529>] __do_sys_finit_module+0x12f/0x1c0
    [<00000000b36c4c0f>] do_syscall_64+0x3f/0x90
    [<00000000bbf20cf3>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
unreferenced object 0xffff8881127df000 (size 2048):
  comm "modprobe", pid 247, jiffies 4294972324 (age 78.728s)
  hex dump (first 32 bytes):
    20 65 6d 70 74 79 5f 73 79 6e 74 68 5f 74 65 73   empty_synth_tes
    74 20 20 70 69 64 5f 74 20 6e 65 78 74 5f 70 69  t  pid_t next_pi
  backtrace:
    [<000000004254801a>] kmalloc_trace+0x26/0x100
    [<00000000d4db9a3d>] 0xffffffffa0008071
    [<00000000c31354a5>] 0xffffffffa00086ce
    [<00000000c293d1ea>] do_one_initcall+0xdb/0x480
    [<00000000aa189e6d>] do_init_module+0x1cf/0x680
    [<00000000d513222b>] load_module+0x6a50/0x70a0
    [<000000001fd4d529>] __do_sys_finit_module+0x12f/0x1c0
    [<00000000b36c4c0f>] do_syscall_64+0x3f/0x90
    [<00000000bbf20cf3>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

Fixes: 9fe41efaca08 ("tracing: Add synth event generation test module")
Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
---
changes in v2:
- adjust code for clean.
---
 kernel/trace/synth_event_gen_test.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/synth_event_gen_test.c b/kernel/trace/synth_event_gen_test.c
index 0b15e975d2c2..8d77526892f4 100644
--- a/kernel/trace/synth_event_gen_test.c
+++ b/kernel/trace/synth_event_gen_test.c
@@ -120,15 +120,13 @@ static int __init test_gen_synth_cmd(void)
 
 	/* Now generate a gen_synth_test event */
 	ret = synth_event_trace_array(gen_synth_test, vals, ARRAY_SIZE(vals));
- out:
+ free:
+	kfree(buf);
 	return ret;
  delete:
 	/* We got an error after creating the event, delete it */
 	synth_event_delete("gen_synth_test");
- free:
-	kfree(buf);
-
-	goto out;
+	goto free;
 }
 
 /*
@@ -227,15 +225,13 @@ static int __init test_empty_synth_event(void)
 
 	/* Now trace an empty_synth_test event */
 	ret = synth_event_trace_array(empty_synth_test, vals, ARRAY_SIZE(vals));
- out:
+ free:
+	kfree(buf);
 	return ret;
  delete:
 	/* We got an error after creating the event, delete it */
 	synth_event_delete("empty_synth_test");
- free:
-	kfree(buf);
-
-	goto out;
+	goto free;
 }
 
 static struct synth_field_desc create_synth_test_fields[] = {
-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2354668EA79
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 10:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjBHJG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 04:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjBHJGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 04:06:21 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122031CAF9;
        Wed,  8 Feb 2023 01:06:18 -0800 (PST)
Received: from dggpeml100012.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4PBYs03BbRzJqyM;
        Wed,  8 Feb 2023 17:01:40 +0800 (CST)
Received: from localhost.localdomain (10.67.175.61) by
 dggpeml100012.china.huawei.com (7.185.36.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 8 Feb 2023 17:06:16 +0800
From:   Zheng Yejian <zhengyejian1@huawei.com>
To:     <rostedt@goodmis.org>, <mhiramat@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <zhengyejian1@huawei.com>,
        <wanghai38@huawei.com>
Subject: [PATCH] tracing/ring-buffer: Remove integrity check at end of iter read
Date:   Wed, 8 Feb 2023 17:08:14 +0800
Message-ID: <20230208090814.869242-1-zhengyejian1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.61]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Concurrently closing "trace" file and writing into ring buffer [1] can
cause WARNINGs [2]. It has been reported in
Link: https://lore.kernel.org/all/20230203035608.2336906-1-zhengyejian1@huawei.com/

It seems a data race between ring_buffer writing and integrity check.
That is, RB_FLAG of head_page is been updating, while at same time RB_FLAG
was cleared when doing integrity check:
  rb_check_pages()            rb_handle_head_page():
  --------                    --------
  rb_head_page_deactivate()
                              rb_head_page_set_normal()
  rb_head_page_activate()

Integrity check at end of iter read was added since commit 659f451ff213
("ring-buffer: Add integrity check at end of iter read"). As it's commit
message said:
  > As reading via an iterator requires disabling the ring buffer, it
  > is a perfect place to have it.
However, since commit 1039221cc278 ("ring-buffer: Do not disable recording
when there is an iterator"), ring buffer was not disabled at that place,
so that integrity check should be removed.

1:
``` read_trace.sh
  while true;
  do
    # the "trace" file is closed after read
    head -1 /sys/kernel/tracing/trace > /dev/null
  done
```
``` repro.sh
  sysctl -w kernel.panic_on_warn=1
  # function tracer will writing enough data into ring_buffer
  echo function > /sys/kernel/tracing/current_tracer
  ./read_trace.sh &
  ./read_trace.sh &
  ./read_trace.sh &
  ./read_trace.sh &
  ./read_trace.sh &
  ./read_trace.sh &
  ./read_trace.sh &
  ./read_trace.sh &
```

2:
------------[ cut here ]------------
WARNING: CPU: 9 PID: 62 at kernel/trace/ring_buffer.c:2653
rb_move_tail+0x450/0x470
Modules linked in:
CPU: 9 PID: 62 Comm: ksoftirqd/9 Tainted: G        W          6.2.0-rc6+
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
RIP: 0010:rb_move_tail+0x450/0x470
Code: ff ff 4c 89 c8 f0 4d 0f b1 02 48 89 c2 48 83 e2 fc 49 39 d0 75 24
83 e0 03 83 f8 02 0f 84 e1 fb ff ff 48 8b 57 10 f0 ff 42 08 <0f> 0b 83
f8 02 0f 84 ce fb ff ff e9 db
RSP: 0018:ffffb5564089bd00 EFLAGS: 00000203
RAX: 0000000000000000 RBX: ffff9db385a2bf81 RCX: ffffb5564089bd18
RDX: ffff9db281110100 RSI: 0000000000000fe4 RDI: ffff9db380145400
RBP: ffff9db385a2bf80 R08: ffff9db385a2bfc0 R09: ffff9db385a2bfc2
R10: ffff9db385a6c000 R11: ffff9db385a2bf80 R12: 0000000000000000
R13: 00000000000003e8 R14: ffff9db281110100 R15: ffffffffbb006108
FS:  0000000000000000(0000) GS:ffff9db3bdcc0000(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005602323024c8 CR3: 0000000022e0c000 CR4: 00000000000006e0
Call Trace:
 <TASK>
 ring_buffer_lock_reserve+0x136/0x360
 ? __do_softirq+0x287/0x2df
 ? __pfx_rcu_softirq_qs+0x10/0x10
 trace_function+0x21/0x110
 ? __pfx_rcu_softirq_qs+0x10/0x10
 ? __do_softirq+0x287/0x2df
 function_trace_call+0xf6/0x120
 0xffffffffc038f097
 ? rcu_softirq_qs+0x5/0x140
 rcu_softirq_qs+0x5/0x140
 __do_softirq+0x287/0x2df
 run_ksoftirqd+0x2a/0x30
 smpboot_thread_fn+0x188/0x220
 ? __pfx_smpboot_thread_fn+0x10/0x10
 kthread+0xe7/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x2c/0x50
 </TASK>
---[ end trace 0000000000000000 ]---

Fixes: 1039221cc278 ("ring-buffer: Do not disable recording when there is an iterator")
Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
---
 kernel/trace/ring_buffer.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index c366a0a9ddba..34e955bd1e59 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5203,17 +5203,6 @@ void
 ring_buffer_read_finish(struct ring_buffer_iter *iter)
 {
 	struct ring_buffer_per_cpu *cpu_buffer = iter->cpu_buffer;
-	unsigned long flags;
-
-	/*
-	 * Ring buffer is disabled from recording, here's a good place
-	 * to check the integrity of the ring buffer.
-	 * Must prevent readers from trying to read, as the check
-	 * clears the HEAD page and readers require it.
-	 */
-	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
-	rb_check_pages(cpu_buffer);
-	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 
 	atomic_dec(&cpu_buffer->resize_disabled);
 	kfree(iter->event);
-- 
2.25.1


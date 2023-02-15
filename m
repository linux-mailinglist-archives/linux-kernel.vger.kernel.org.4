Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1AB969876F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 22:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjBOViW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 16:38:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjBOViS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 16:38:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6BE2B098
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 13:38:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A21461DB2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:38:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0444C433D2;
        Wed, 15 Feb 2023 21:38:14 +0000 (UTC)
Date:   Wed, 15 Feb 2023 16:38:13 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [GIT PULL] tracing: Handle race between rb_move_tail and
 rb_check_pages
Message-ID: <20230215163813.4b473604@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mukesh Ojha <quic_mojha@quicinc.com>

Linus,

tracing: Fix race that causes a warning of corrupt ring buffer

With the change that allows to read the "trace" file without disabling
writing to the ring buffer, there was an integrity check of the ring
buffer in the iterator read code, that expected the ring buffer to be
write disabled. This caused the integrity check to trigger when stress
reading the "trace" file while writing was happening.

The integrity check is a bit aggressive (and has never triggered in
practice). Change it so that it checks just the integrity of the linked
pages without clearing the flags inside the pointers. This removes the
warning that was being triggered.

Note, this was added on top of my last pull request here:

   https://lore.kernel.org/lkml/20230213100836.33d2b0b0@rorschach.local.home/

Please pull the latest trace-v6.2-rc7-3 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.2-rc7-3

Tag SHA1: cae6c6648a7a9c3a52d1aa5f7beeee9b19a9f059
Head SHA1: 8843e06f67b14f71c044bf6267b2387784c7e198


Mukesh Ojha (1):
      ring-buffer: Handle race between rb_move_tail and rb_check_pages

----
 kernel/trace/ring_buffer.c | 42 ++++++++++--------------------------------
 1 file changed, 10 insertions(+), 32 deletions(-)
---------------------------
commit 8843e06f67b14f71c044bf6267b2387784c7e198
Author: Mukesh Ojha <quic_mojha@quicinc.com>
Date:   Tue Feb 14 17:36:43 2023 +0530

    ring-buffer: Handle race between rb_move_tail and rb_check_pages
    
    It seems a data race between ring_buffer writing and integrity check.
    That is, RB_FLAG of head_page is been updating, while at same time
    RB_FLAG was cleared when doing integrity check rb_check_pages():
    
      rb_check_pages()            rb_handle_head_page():
      --------                    --------
      rb_head_page_deactivate()
                                  rb_head_page_set_normal()
      rb_head_page_activate()
    
    We do intergrity test of the list to check if the list is corrupted and
    it is still worth doing it. So, let's refactor rb_check_pages() such that
    we no longer clear and set flag during the list sanity checking.
    
    [1] and [2] are the test to reproduce and the crash report respectively.
    
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
    
    [ crash report and test reproducer credit goes to Zheng Yejian]
    
    Link: https://lore.kernel.org/linux-trace-kernel/1676376403-16462-1-git-send-email-quic_mojha@quicinc.com
    
    Cc: <mhiramat@kernel.org>
    Cc: stable@vger.kernel.org
    Fixes: 1039221cc278 ("ring-buffer: Do not disable recording when there is an iterator")
    Reported-by: Zheng Yejian <zhengyejian1@huawei.com>
    Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
    Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index c366a0a9ddba..b641cab2745e 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1580,19 +1580,6 @@ static int rb_check_bpage(struct ring_buffer_per_cpu *cpu_buffer,
 	return 0;
 }
 
-/**
- * rb_check_list - make sure a pointer to a list has the last bits zero
- */
-static int rb_check_list(struct ring_buffer_per_cpu *cpu_buffer,
-			 struct list_head *list)
-{
-	if (RB_WARN_ON(cpu_buffer, rb_list_head(list->prev) != list->prev))
-		return 1;
-	if (RB_WARN_ON(cpu_buffer, rb_list_head(list->next) != list->next))
-		return 1;
-	return 0;
-}
-
 /**
  * rb_check_pages - integrity check of buffer pages
  * @cpu_buffer: CPU buffer with pages to test
@@ -1602,36 +1589,27 @@ static int rb_check_list(struct ring_buffer_per_cpu *cpu_buffer,
  */
 static int rb_check_pages(struct ring_buffer_per_cpu *cpu_buffer)
 {
-	struct list_head *head = cpu_buffer->pages;
-	struct buffer_page *bpage, *tmp;
+	struct list_head *head = rb_list_head(cpu_buffer->pages);
+	struct list_head *tmp;
 
-	/* Reset the head page if it exists */
-	if (cpu_buffer->head_page)
-		rb_set_head_page(cpu_buffer);
-
-	rb_head_page_deactivate(cpu_buffer);
-
-	if (RB_WARN_ON(cpu_buffer, head->next->prev != head))
-		return -1;
-	if (RB_WARN_ON(cpu_buffer, head->prev->next != head))
+	if (RB_WARN_ON(cpu_buffer,
+			rb_list_head(rb_list_head(head->next)->prev) != head))
 		return -1;
 
-	if (rb_check_list(cpu_buffer, head))
+	if (RB_WARN_ON(cpu_buffer,
+			rb_list_head(rb_list_head(head->prev)->next) != head))
 		return -1;
 
-	list_for_each_entry_safe(bpage, tmp, head, list) {
+	for (tmp = rb_list_head(head->next); tmp != head; tmp = rb_list_head(tmp->next)) {
 		if (RB_WARN_ON(cpu_buffer,
-			       bpage->list.next->prev != &bpage->list))
+				rb_list_head(rb_list_head(tmp->next)->prev) != tmp))
 			return -1;
+
 		if (RB_WARN_ON(cpu_buffer,
-			       bpage->list.prev->next != &bpage->list))
-			return -1;
-		if (rb_check_list(cpu_buffer, &bpage->list))
+				rb_list_head(rb_list_head(tmp->prev)->next) != tmp))
 			return -1;
 	}
 
-	rb_head_page_activate(cpu_buffer);
-
 	return 0;
 }
 

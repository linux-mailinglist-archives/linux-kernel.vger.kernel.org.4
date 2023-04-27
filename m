Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD34D6F08E3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 17:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244228AbjD0P7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 11:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243864AbjD0P7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 11:59:41 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FE9F9;
        Thu, 27 Apr 2023 08:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=Cuucxv7D/U/64Bqs7uWjVu3OA9YWTZvXVvV+4QELO6Q=; t=1682611180; x=1683820780; 
        b=B5Binqu88hbf3CBRFF0zAu3u6eA/cgIo5oaHBcOa8Sm1CmCAIrrgW1k9P+U+G8EZnom8VEF/1uj
        aP45T570CoJ+h/YnbGpC/C39gqrS0RixK/BAMN+59ZBMhNOzTd6KdfFeMu76wG3DsNhEqD/bmLjJv
        Wsi5114MfdzWF8ktrzBCXhT70Y+GbSWeJDihA/V0ZE6TXRWq4HRq1thHSZ+Pa13g45m4OlfAz1YjK
        mAN23mqHe3A8jhhghUfFQ6KiK8ia7jdjZbulFcbAbzAJDYiVKK+KnA8CGTabpEKHouDXp4ACZrbWM
        8AepqrFXFj1Nx5SoaQ0vluz6cdlBwaOjRqOQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ps41k-00AJvd-1D;
        Thu, 27 Apr 2023 17:59:24 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-trace-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] tracing: ring-buffer: sync IRQ works before buffer destruction
Date:   Thu, 27 Apr 2023 17:59:20 +0200
Message-Id: <20230427175920.a76159263122.I8295e405c44362a86c995e9c2c37e3e03810aa56@changeid>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If something was written to the buffer just before destruction,
it may be possible (maybe not in a real system, but it did
happen in ARCH=um with time-travel) to destroy the ringbuffer
before the IRQ work ran, leading this KASAN report (or a crash
without KASAN):

    BUG: KASAN: slab-use-after-free in irq_work_run_list+0x11a/0x13a
    Read of size 8 at addr 000000006d640a48 by task swapper/0

    CPU: 0 PID: 0 Comm: swapper Tainted: G        W  O       6.3.0-rc1 #7
    Stack:
     60c4f20f 0c203d48 41b58ab3 60f224fc
     600477fa 60f35687 60c4f20f 601273dd
     00000008 6101eb00 6101eab0 615be548
    Call Trace:
     [<60047a58>] show_stack+0x25e/0x282
     [<60c609e0>] dump_stack_lvl+0x96/0xfd
     [<60c50d4c>] print_report+0x1a7/0x5a8
     [<603078d3>] kasan_report+0xc1/0xe9
     [<60308950>] __asan_report_load8_noabort+0x1b/0x1d
     [<60232844>] irq_work_run_list+0x11a/0x13a
     [<602328b4>] irq_work_tick+0x24/0x34
     [<6017f9dc>] update_process_times+0x162/0x196
     [<6019f335>] tick_sched_handle+0x1a4/0x1c3
     [<6019fd9e>] tick_sched_timer+0x79/0x10c
     [<601812b9>] __hrtimer_run_queues.constprop.0+0x425/0x695
     [<60182913>] hrtimer_interrupt+0x16c/0x2c4
     [<600486a3>] um_timer+0x164/0x183
     [...]

    Allocated by task 411:
     save_stack_trace+0x99/0xb5
     stack_trace_save+0x81/0x9b
     kasan_save_stack+0x2d/0x54
     kasan_set_track+0x34/0x3e
     kasan_save_alloc_info+0x25/0x28
     ____kasan_kmalloc+0x8b/0x97
     __kasan_kmalloc+0x10/0x12
     __kmalloc+0xb2/0xe8
     load_elf_phdrs+0xee/0x182
     [...]

    The buggy address belongs to the object at 000000006d640800
     which belongs to the cache kmalloc-1k of size 1024
    The buggy address is located 584 bytes inside of
     freed 1024-byte region [000000006d640800, 000000006d640c00)

Add the appropriate irq_work_sync() so the work finishes before
the buffers are destroyed.

Prior to the commit in the Fixes tag below, there was only a
single global IRQ work, so this issue didn't exist.

Fixes: 15693458c4bc ("tracing/ring-buffer: Move poll wake ups into ring buffer code")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 kernel/trace/ring_buffer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index af50d931b020..271997076029 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1778,6 +1778,8 @@ static void rb_free_cpu_buffer(struct ring_buffer_per_cpu *cpu_buffer)
 	struct list_head *head = cpu_buffer->pages;
 	struct buffer_page *bpage, *tmp;
 
+	irq_work_sync(&cpu_buffer->irq_work.work);
+
 	free_buffer_page(cpu_buffer->reader_page);
 
 	if (head) {
@@ -1884,6 +1886,8 @@ ring_buffer_free(struct trace_buffer *buffer)
 
 	cpuhp_state_remove_instance(CPUHP_TRACE_RB_PREPARE, &buffer->node);
 
+	irq_work_sync(&buffer->irq_work.work);
+
 	for_each_buffer_cpu(buffer, cpu)
 		rb_free_cpu_buffer(buffer->buffers[cpu]);
 
-- 
2.40.0


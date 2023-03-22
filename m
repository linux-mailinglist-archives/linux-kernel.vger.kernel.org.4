Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D912E6C3F44
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 01:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjCVAph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 20:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjCVAp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 20:45:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099BC3E606
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 17:45:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A386561EED
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 00:45:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67F00C433EF;
        Wed, 22 Mar 2023 00:45:26 +0000 (UTC)
Date:   Tue, 21 Mar 2023 20:45:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH] context_tracking: Have ct_state() use
 preempt_disable_notrace()
Message-ID: <20230321204524.44733a13@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

One of my tests triggered:

 ------------[ cut here ]------------
 WARNING: CPU: 0 PID: 1 at include/trace/events/preemptirq.h:51 trace_preempt_off+0x7c/0x80
 Modules linked in:
 CPU: 0 PID: 1 Comm: init Not tainted 6.3.0-rc3-test-00011-ge11b521a7b69-dirty #31
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
 RIP: 0010:trace_preempt_off+0x7c/0x80
 Code: 74 0f 48 8b 78 08 48 89 f2 48 89 de e8 5d f9 ff ff 65 ff 0d 6e d6 ce 68 75 a2 0f 1f 44 00 00 eb 9b e8 28 ea f3 ff 84 c0 75 a5 <0f> 0b eb a1 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f
 RSP: 0000:ffffaf0880013f00 EFLAGS: 00010046
 RAX: 0000000000000000 RBX: ffffffff97fafe59 RCX: 0000000000000001
 RDX: 0000000000000000 RSI: ffffffff986f4b71 RDI: ffffffff986fa0dd
 RBP: ffffffff97fafe59 R08: 0000000000000000 R09: 0000000000000000
 R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
 R13: 0000000000000014 R14: 0000000000000000 R15: 0000000000000000
 FS:  0000000000000000(0000) GS:ffff8adf7bc00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007f125de099c0 CR3: 000000010498a001 CR4: 0000000000170ef0
 Call Trace:
  <TASK>
  irqentry_enter_from_user_mode+0x39/0x80
  irqentry_enter+0x51/0x60
  exc_page_fault+0x3d/0x200
  asm_exc_page_fault+0x26/0x30
 RIP: 0033:0x7f125de099c0
 Code: Unable to access opcode bytes at 0x7f125de09996.
 RSP: 002b:00007ffd1fdbf220 EFLAGS: 00010202
 RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
 RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
 RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
 R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
 R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
  </TASK>
 irq event stamp: 13182054
 hardirqs last  enabled at (13182053): [<ffffffff97002e3f>] ret_from_fork+0x1f/0x50
 hardirqs last disabled at (13182054): [<ffffffff97faff01>] irqentry_enter+0x51/0x60
 softirqs last  enabled at (13181978): [<ffffffff97fc97d2>] __do_softirq+0x322/0x429
 softirqs last disabled at (13181969): [<ffffffff971c2cce>] irq_exit_rcu+0xe/0x30
 ---[ end trace 0000000000000000 ]---
 ------------[ cut here ]------------

It appears that ct_state() can be called in noinst mode. Do not trace the
disabling of preemption.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/context_tracking_state.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index 4a4d56f77180..38e269174a7f 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -130,9 +130,9 @@ static __always_inline int ct_state(void)
 	if (!context_tracking_enabled())
 		return CONTEXT_DISABLED;
 
-	preempt_disable();
+	preempt_disable_notrace();
 	ret = __ct_state();
-	preempt_enable();
+	preempt_enable_notrace();
 
 	return ret;
 }
-- 
2.39.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEF36C0BB3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 09:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjCTIER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 04:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjCTIEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 04:04:15 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6736A3C07;
        Mon, 20 Mar 2023 01:04:12 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Pg6h80ytJz9sx1;
        Mon, 20 Mar 2023 09:04:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001;
        t=1679299448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=bTYHukQgUX4nzP26XOdQWPxkwbbqFAk7D0BpCeYCkSE=;
        b=kOMYnrqhCvK5YtABjE7vZcjQbdzAKuibr4CkPWDpinjcWO3NPh0elKeCpku3eglaXAY8LH
        atk5d3oeqiH/vEb20+PJGadSjC5o03eQ7hkAjrFeoae3v+T/qmZWgJ6jnbQAdexRTJt1dt
        DC36HewVs5jr9y0sMaJGkXOblANyMP02CqGzZBxc/s0e+H6gIeXtf9Dnukn9/uHeFPZxo4
        lp91q8Bv1oGqvxFZZJjTvD/26C7Go6dUqXVUkoDPbfvu3vgAY5Se55Vf6u39saY3zAcCQB
        CGnNvOARSgd5vlykhmo1n/wxSVQohL+a5peLTQ2hQMl+fJgfG2JXWCFr9QxL7g==
From:   linux@steffen.cc
To:     "Luis Claudio R . Goncalves" <lgoncalv@redhat.com>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
Subject: [PATCH v5.10-rt] kernel: fork: set wake_q_sleeper.next=NULL again in dup_task_struct
Date:   Mon, 20 Mar 2023 09:03:47 +0100
Message-Id: <20230320080347.32434-1-linux@steffen.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4Pg6h80ytJz9sx1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>

Without this we get system hangs within a couple of days.
It's also reproducible in minutes with "stress-ng --exec 20".

Example error in dmesg:
INFO: task stress-ng:163916 blocked for more than 120 seconds.
      Not tainted 5.10.168-rt83 #2
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:stress-ng       state:D stack:    0 pid:163916 ppid: 72833 flags:0x00004000
Call Trace:
 __schedule+0x2bd/0x940
 preempt_schedule_lock+0x23/0x50
 rt_spin_lock_slowlock_locked+0x117/0x2c0
 rt_spin_lock_slowlock+0x51/0x80
 rt_write_lock+0x1e/0x1c0
 do_exit+0x3ac/0xb20
 do_group_exit+0x39/0xb0
 get_signal+0x145/0x960
 ? wake_up_new_task+0x21f/0x3c0
 arch_do_signal_or_restart+0xf1/0x830
 ? __x64_sys_futex+0x146/0x1d0
 exit_to_user_mode_prepare+0x116/0x1a0
 syscall_exit_to_user_mode+0x28/0x190
 entry_SYSCALL_64_after_hwframe+0x61/0xc6
RIP: 0033:0x7f738d9074a7
RSP: 002b:00007ffdafda3cb0 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00000000000000ca RCX: 00007f738d9074a7
RDX: 0000000000028051 RSI: 0000000000000000 RDI: 00007f738be949d0
RBP: 00007ffdafda3d88 R08: 0000000000000000 R09: 00007f738be94700
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000028051
R13: 00007f738be949d0 R14: 00007ffdafda51e0 R15: 00007f738be94700

Fixes: 1ba44dcf789d ("Merge tag 'v5.10.162' into v5.10-rt")
Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
---
 kernel/fork.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/fork.c b/kernel/fork.c
index c6e0d555fca9..0c4c20eb762c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -949,6 +949,7 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	tsk->splice_pipe = NULL;
 	tsk->task_frag.page = NULL;
 	tsk->wake_q.next = NULL;
+	tsk->wake_q_sleeper.next = NULL;
 	tsk->pf_io_worker = NULL;
 
 	account_kernel_stack(tsk, 1);
-- 
2.40.0


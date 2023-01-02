Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4170B65B323
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 15:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236126AbjABOFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 09:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236117AbjABOFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 09:05:13 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D862765D5
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 06:05:03 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 290CE1EC02FE;
        Mon,  2 Jan 2023 15:05:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1672668302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=EAFH1bkxulCJplaM4lVdTR5QaYOVifDwenlAFQy7El4=;
        b=EgdTbZG6VEgIbwT47wZr/wnscIpGOUmgWVoJO259FO0v2P2c0xYUIlZHwQv+lU/Qm8UYcp
        G0DCiRRb8zs8ILD68ZogWrtC6K8Zemfy3djf3r7ErTSG6LS4WYpF7RAWqNZ0EDjbJUIhrS
        Pc0el0v617zfRzdPDZdIZFB1UKDAhdc=
Date:   Mon, 2 Jan 2023 15:04:58 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     kernel test robot <yujie.liu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-mm@kvack.org
Subject: Re: [tip:sched/core] [sched] af7f588d8f:
 WARNING:at_kernel/sched/core.c:#sched_mm_cid_after_execve
Message-ID: <Y7Lkis8vjfUgYcQL@zn.tnic>
References: <202212301353.5c959d72-yujie.liu@intel.com>
 <fb7343a9-dc48-52f6-e899-d0283046a011@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fb7343a9-dc48-52f6-e899-d0283046a011@efficios.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2022 at 08:46:25AM -0500, Mathieu Desnoyers wrote:
> void sched_mm_cid_after_execve(struct task_struct *t)
> {
>         struct mm_struct *mm = t->mm;
>         unsigned long flags;
> 
>         WARN_ON_ONCE((t->flags & PF_KTHREAD) || !t->mm);

Yeah, it is that check and it reproduces here trivially in my guest so much so
so that I can't even boot current tip/master in it due to the constant flood
from it.

Also, there's a null ptr deref there:

[    1.694051] Initialise system trusted keyrings
[    1.694915] ------------[ cut here ]------------
[    1.695689] BUG: kernel NULL pointer dereference, address: 000000000000005c
[    1.695714] #PF: supervisor write access in kernel mode
[    1.695721] #PF: error_code(0x0002) - not-present page
[    1.695728] PGD 0 P4D 0 
[    1.695739] Oops: 0002 [#1] PREEMPT SMP
[    1.695747] CPU: 0 PID: 126 Comm: kworker/u32:1 Not tainted 6.2.0-rc2+ #2
[    1.695754] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[    1.695760] RIP: 0010:_raw_spin_lock+0x17/0x30
[    1.702127] WARNING: CPU: 13 PID: 115 at kernel/sched/core.c:11346 sched_mm_cid_after_execve+0xd5/0xf0
[    1.699309] Code: 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 65 ff 05 c8 ea 64 7e 31 c0 ba 01 00 00 00 <f0> 0f b1 17 75 05 c3 cc cc cc cc 89 c6 e9 97 00 00 00 0f 1f 80 00
[    1.702857] Modules linked in:
[    1.699309] RSP: 0018:ffffc900004afe78 EFLAGS: 00010046
[    1.703670] 
[    1.699309] 
[    1.704665] CPU: 13 PID: 115 Comm: kworker/u32:0 Not tainted 6.2.0-rc2+ #2
[    1.699309] RAX: 0000000000000000 RBX: ffff88800d323d00 RCX: 0000000000000000
[    1.699309] RDX: 0000000000000001 RSI: ffff88800d323d00 RDI: 000000000000005c
[    1.699309] RBP: 000000000000005c R08: 0000000000000064 R09: ffffc900004afb30
[    1.699309] R10: 0000000000000000 R11: fffffffffffffffe R12: 0000000000000246
[    1.699309] R13: 0000000000000000 R14: 00000000fffffffe R15: ffff88800d323d00
[    1.699309] FS:  0000000000000000(0000) GS:ffff88807da00000(0000) knlGS:0000000000000000
[    1.699309] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.699309] CR2: 000000000000005c CR3: 000000000220a000 CR4: 00000000003506f0
[    1.699309] Call Trace:
[    1.699309]  <TASK>
[    1.699309]  sched_mm_cid_after_execve+0x52/0xf0
[    1.706650] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[    1.699309]  bprm_execve+0x323/0x600
[    1.707390] RIP: 0010:sched_mm_cid_after_execve+0xd5/0xf0
[    1.699309]  kernel_execve+0x15f/0x1c0
[    1.707967] Code: 00 00 74 04 f0 80 0b 02 48 8b 1c 24 48 8b 6c 24 08 4c 8b 64 24 10 4c 8b 6c 24 18 4c 8b 74 24 20 48 83 c4 28 c3 cc cc cc cc 90 <0f> 0b 90 e9 65 ff ff ff 41 be ff ff ff ff eb 9d 66 66 2e 0f 1f 84
[    1.699309]  call_usermodehelper_exec_async+0xd1/0x190
[    1.708882] RSP: 0018:ffffc90000457e80 EFLAGS: 00010246
[    1.699309]  ? __pfx_call_usermodehelper_exec_async+0x10/0x10
[    1.709839] 
[    1.699309]  ret_from_fork+0x2c/0x50
[    1.710739] RAX: fffffffffffffffe RBX: ffff88800cad8f40 RCX: 0000000000000000
[    1.699309]  </TASK>
[    1.714247] RDX: ffffc90000457dc8 RSI: ffff88800cad8f40 RDI: ffff88800cad8f40
[    1.699309] Modules linked in:
[    1.715270] RBP: ffff88800dd35400 R08: 0000000000000064 R09: ffffc90000457b30
[    1.699309] CR2: 000000000000005c
[    1.699309] ---[ end trace 0000000000000000 ]---

... flood of the above...

> is too strict. AFAIU the usermodehelper thread is a kernel thread, which
> happens to have a non-NULL mm after execve. We want to allow usermodehelper
> threads to use rseq, so I think the appropriate approach here would be to
> just warn if !t->mm:
> 
>         WARN_ON_ONCE(!t->mm);

You need at least this to avoid the null ptr deref too:

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 048ec2417990..5c920c94a6b2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11340,10 +11340,13 @@ void sched_mm_cid_before_execve(struct task_struct *t)
 
 void sched_mm_cid_after_execve(struct task_struct *t)
 {
-	struct mm_struct *mm = t->mm;
+	struct mm_struct *mm;
 	unsigned long flags;
 
-	WARN_ON_ONCE((t->flags & PF_KTHREAD) || !t->mm);
+	if (WARN_ON_ONCE(!t->mm))
+		return;
+
+	mm = t->mm;
 
 	local_irq_save(flags);
 	t->mm_cid = mm_cid_get(mm);
---

which gives the below.

I'm not sure though how the rules are about those kworker threads and them
having a ->mm...

[    1.734104] ------------[ cut here ]------------
[    1.734144] Initialise system trusted keyrings
[    1.734553] WARNING: CPU: 9 PID: 109 at kernel/sched/core.c:11346 sched_mm_cid_after_execve+0xcb/0xe0
[    1.752756] workingset: timestamp_bits=61 max_order=19 bucket_order=0
[    1.754187] Modules linked in:
[    1.768160] 9p: Installing v9fs 9p2000 file system support
[    1.768640] 
[    1.768876] Key type asymmetric registered
[    1.769048] CPU: 9 PID: 109 Comm: kworker/u32:1 Not tainted 6.2.0-rc2+ #9
[    1.769207] Asymmetric key parser 'x509' registered
[    1.769397] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[    1.769651] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 249)
[    1.769833] RIP: 0010:sched_mm_cid_after_execve+0xcb/0xe0
[    1.770162] io scheduler mq-deadline registered
[    1.770462] Code: 00 00 74 04 f0 80 0b 02 48 8b 1c 24 48 8b 6c 24 08 4c 8b 64 24 10 4c 8b 6c 24 18 4c 8b 74 24 20 48 83 c4 28 c3 cc cc cc cc 90 <0f> 0b 90 eb d9 41 be ff ff ff ff eb a0 0f 1f 84 00 00 00 00 00 90
[    1.810713] RSP: 0018:ffffc90000427e80 EFLAGS: 00010246
[    1.823527] RAX: fffffffffffffffe RBX: ffff88800cb88000 RCX: 0000000000000000
[    1.824425] RDX: ffffc90000427dc8 RSI: ffff88800cb88000 RDI: ffff88800cb88000
[    1.825266] acpiphp_ibm: ibm_acpiphp_init: acpi_walk_namespace failed
[    1.825564] RBP: ffff88800d2d8200 R08: 0000000000000064 R09: ffffc90000427b30
[    1.825914] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    1.826068] R10: 0000000000000000 R11: fffffffffffffffe R12: fffffffffffffffe
[    1.839784] ACPI: button: Power Button [PWRF]
[    1.840327] R13: 0000000000000000 R14: 00000000fffffffe R15: ffff88800cb88000
[    1.855532] FS:  0000000000000000(0000) GS:ffff88807dc40000(0000) knlGS:0000000000000000
[    1.856681] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.857403] CR2: 0000000000000000 CR3: 000000000220a000 CR4: 00000000003506e0
[    1.858264] Call Trace:
[    1.858643]  <TASK>
[    1.871528]  bprm_execve+0x323/0x600
[    1.872027]  kernel_execve+0x15f/0x1c0
[    1.872505]  call_usermodehelper_exec_async+0xd1/0x190
[    1.873120]  ? __pfx_call_usermodehelper_exec_async+0x10/0x10
[    1.873800]  ret_from_fork+0x2c/0x50
[    1.874259]  </TASK>
[    1.874582] ---[ end trace 0000000000000000 ]---



-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97D460C31F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 07:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbiJYFKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 01:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiJYFJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 01:09:53 -0400
Received: from mailgw.kylinos.cn (unknown [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109EA13F19
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 22:09:45 -0700 (PDT)
X-UUID: 29c4e3aaf9eb42c4abfc68ec4ad85c03-20221025
X-CPASD-INFO: f7d22ba293254d10ac6d946669cd51fc@r4eeUl-Uj2JlU3SBg6d8aoGUZpRpYFa
        FeHODlGNhkoOVhH5xTV5uYFV9fWtVYV9dYVR6eGxQYmBgZFJ4i3-XblBgXoZgUZB3tXmeUmKQkQ==
X-CLOUD-ID: f7d22ba293254d10ac6d946669cd51fc
X-CPASD-SUMMARY: SIP:-1,APTIP:-2.0,KEY:0.0,FROMBLOCK:1,OB:0.0,URL:-5,TVAL:185.
        0,ESV:0.0,ECOM:-5.0,ML:0.0,FD:0.0,CUTS:244.0,IP:-2.0,MAL:-5.0,PHF:-5.0,PHC:-5
        .0,SPF:4.0,EDMS:-5,IPLABEL:4480.0,FROMTO:0,AD:0,FFOB:0.0,CFOB:0.0,SPC:0,SIG:-
        5,AUF:13,DUF:6811,ACD:121,DCD:121,SL:0,EISP:0,AG:0,CFC:0.318,CFSR:0.158,UAT:0
        ,RAF:0,IMG:-5.0,DFA:0,DTA:0,IBL:-2.0,ADI:-5,SBL:0,REDM:0,REIP:0,ESB:0,ATTNUM:
        0,EAF:0,CID:-5.0,VERSION:2.3.17
X-CPASD-ID: 29c4e3aaf9eb42c4abfc68ec4ad85c03-20221025
X-CPASD-BLOCK: 1000
X-CPASD-STAGE: 1
X-UUID: 29c4e3aaf9eb42c4abfc68ec4ad85c03-20221025
X-User: chenzhang@kylinos.cn
Received: from localhost.localdomain [(111.48.58.12)] by mailgw
        (envelope-from <chenzhang@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1443972045; Tue, 25 Oct 2022 13:09:40 +0800
From:   chen zhang <chenzhang@kylinos.cn>
To:     oleg@redhat.com
Cc:     chenzhang_0901@163.com, linux-kernel@vger.kernel.org,
        chen zhang <chenzhang@kylinos.cn>
Subject: [PATCH v2] ptrace: disable single step in __ptrace_unlink for protecting init task
Date:   Tue, 25 Oct 2022 13:10:32 +0800
Message-Id: <20221025051032.280352-1-chenzhang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,T_SPF_PERMERROR,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I got below panic when doing fuzz test:

Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000005
CPU: 2 PID: 1 Comm: systemd Kdump: loaded Not tainted 6.1.0-rc1 #1
Hardware name: LENOVO 20L5A07XCD/20L5A07XCD, BIOS N24ET56W (1.31 ) 02/19/2020
Call Trace:
[  157.210356]  dump_stack_lvl+0x49/0x63
[  157.210364]  dump_stack+0x10/0x16
[  157.210368]  panic+0x10c/0x299
[  157.210375]  do_exit.cold+0x15/0x15
[  157.210381]  do_group_exit+0x35/0x90
[  157.210386]  get_signal+0x910/0x960
[  157.210390]  ? signal_wake_up_state+0x2e/0x40
[  157.210396]  ? complete_signal+0xd0/0x2c0
[  157.210402]  arch_do_signal_or_restart+0x37/0x7c0
[  157.210408]  ? send_signal_locked+0xf5/0x140
[  157.210416]  exit_to_user_mode_prepare+0x133/0x180
[  157.210423]  irqentry_exit_to_user_mode+0x9/0x20
[  157.210428]  noist_exc_debug+0xea/0x150
[  157.210433]  asm_exc_debug+0x34/0x40
[  157.210438] RIP: 0033:0x7fcf2a8e51c9
[  157.210442] Code: ff ff 73 01 c3 48 8b 0d c5 7c 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 ba 00 00 00 <0f> 05 c3 0f 1f 40 00 f3 0f 1e fa b8 ea 00 00 00 0f 05 48 3d 01 f0
[  157.210446] RSP: 002b:00007ffd7dc44678 EFLAGS: 00000302
[  157.210451] RAX: 00000000000000ba RBX: 000055f7c0363170 RCX: 000055f7c04d2820
[  157.210454] RDX: 00000000ffffffff RSI: ffffffffffffffff RDI: 000055f7c0363170
[  157.210457] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000001dd0
[  157.210460] R10: 00007ffd7ddc9090 R11: 000000000000d7da R12: 0000000000000001
[  157.210463] R13: ffffffffffffffff R14: 000055f7bf3557c1 R15: 0000000000000000

If a task attaches init task and is single stepping it, when this task
exits, ptrace value will be cleaned. It causes SIGNAL_UNKILLABLE flag
cleaned, and init task will lose the protection. Init task maybe be killed
by SIGTRAP signal because of stepping enabled. So syscall tracing and
stepping should be turned off for protecting init task before ptrace value
is cleaned.

Signed-off-by: chen zhang <chenzhang@kylinos.cn>
---
change for v2: remove _TIF_SINGLESTEP because of some architecture has not defined _TIF_SINGLESTEP such as mips.
 
Thanks for your reply. I think kernel should not panic when the application has a bug, or a fault operation such as ctrl+c,

or the attack to the kernel. I have debugged this panic for several weeks. This patch can really prevent kernel panic on

my x86 machine. I agree your describe about kernel panic case. But when debugger exits, SIGNAL_UNKILLABLE flag will protect

init task at the first time. The SIGTRAP signal can not kill init task. Because of this patch, it disabled single step debug on

time. So SIGTRAP signal will not be sent, and the kernel panic can not appear. 
---
 kernel/ptrace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 54482193e1ed..c8f7195bef1c 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -130,6 +130,8 @@ void __ptrace_unlink(struct task_struct *child)
 	put_cred(old_cred);
 
 	spin_lock(&child->sighand->siglock);
+	if (unlikely(child->signal->flags & SIGNAL_UNKILLABLE))
+		user_disable_single_step(child);
 	child->ptrace = 0;
 	/*
 	 * Clear all pending traps and TRAPPING.  TRAPPING should be
-- 
2.25.1


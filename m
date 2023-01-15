Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D4566B14E
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 14:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjAONo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 08:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjAONoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 08:44:55 -0500
X-Greylist: delayed 598 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 15 Jan 2023 05:44:54 PST
Received: from hyperium.qtmlabs.xyz (hyperium.qtmlabs.xyz [194.163.182.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C70EC61
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 05:44:54 -0800 (PST)
Received: from dong.kernal.eu (unknown [14.231.159.199])
        by hyperium.qtmlabs.xyz (Postfix) with ESMTPSA id 7F35B82002E;
        Sun, 15 Jan 2023 14:34:23 +0100 (CET)
Received: from localhost (unknown [27.67.17.21])
        by dong.kernal.eu (Postfix) with ESMTPSA id 243FA44496AC;
        Sun, 15 Jan 2023 20:34:15 +0700 (+07)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qtmlabs.xyz; s=syka;
        t=1673789655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=jjxt+FsgG+EBJq1B4OVQNkvSIphuNLp2z8Syfe3Ynng=;
        b=XYBDUDlb3m3V/40fMSwJ7HgEDj9fNDCfOmFPu3VZ6PFeJ2qZsFB7Ufo9ErkL99R2dM8Ckp
        9NBT9Saei/VXSOFPP2h9jSdaHyZbLMm55Y2J7w2rKTPzbEcPpeLlYvCK4ygueuUHVgkUHQ
        rRtnBlTypdUZGzTn1khCmhitbK6OB204VvA/nNua0KwlpWY/CC27gQqo8knZBmGbEuiomv
        yo2npnTETwwuxWUhcu9bMHKTBz/z/a2AfQx6oIvTHgUWTU/GKC4BkqLAFeekCRCugBoVB8
        QrogIzN9JghUvyVwAhy7Gsm1PelvP2n4RctOTuoXrZb4E8OQNsgq2TLQwKzW9w==
From:   msizanoen1 <msizanoen@qtmlabs.xyz>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Yu Zhao <yuzhao@google.com>, msizanoen <msizanoen@qtmlabs.xyz>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm: do not try to migrate lru_gen if it's not associated with a memcg
Date:   Sun, 15 Jan 2023 20:33:31 +0700
Message-Id: <20230115133330.28420-1-msizanoen@qtmlabs.xyz>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        FROM_SUSPICIOUS_NTLD_FP,SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: msizanoen <msizanoen@qtmlabs.xyz>

In some cases, memory cgroup migration can be initiated by userspace
right after a process was created and right before `lru_gen_add_mm()` is
called (e.g. by some program watching a cgroup and moving away any
processes it detects[1]), which results in the following sequence of
WARNs followed by an Oops as the kernel attempts to perform a
`lru_gen_add_mm()` twice on the same `mm`:

[26181.135304] ------------[ cut here ]------------
[26181.135309] WARNING: CPU: 0 PID: 57083 at mm/vmscan.c:3299 lru_gen_migrate_mm+0x76/0x80
[26181.135484] CPU: 0 PID: 57083 Comm: cgroupify Kdump: loaded Tainted: P           OE      6.1.5-200.fc37.x86_64 #1
[26181.135489] RIP: 0010:lru_gen_migrate_mm+0x76/0x80
[26181.135518] Call Trace:
[26181.135521]  <TASK>
[26181.135525]  mem_cgroup_attach+0x88/0x90
[26181.135531]  cgroup_migrate_execute+0x213/0x470
[26181.135536]  cgroup_attach_task+0x11c/0x1c0
[26181.135540]  ? cgroup_attach_permissions+0x159/0x1c0
[26181.135545]  __cgroup_procs_write+0x10e/0x140
[26181.135550]  cgroup_procs_write+0x13/0x20
[26181.135553]  kernfs_fop_write_iter+0x11e/0x1f0
[26181.135559]  vfs_write+0x222/0x3e0
[26181.135565]  ksys_write+0x5b/0xd0
[26181.135569]  do_syscall_64+0x5b/0x80
[26181.135573]  ? syscall_exit_to_user_mode+0x17/0x40
[26181.135578]  ? do_syscall_64+0x67/0x80
[26181.135581]  ? do_syscall_64+0x67/0x80
[26181.135584]  ? exc_page_fault+0x70/0x170
[26181.135588]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[26181.135592] RIP: 0033:0x7fd18996a0c4
[26181.135633]  </TASK>
[26181.135635] ---[ end trace 0000000000000000 ]---
[26181.135643] ------------[ cut here ]------------
[26181.135644] WARNING: CPU: 0 PID: 57083 at mm/vmscan.c:3300 lru_gen_migrate_mm+0x72/0x80
[26181.135804] CPU: 0 PID: 57083 Comm: cgroupify Kdump: loaded Tainted: P        W  OE      6.1.5-200.fc37.x86_64 #1
[26181.135808] RIP: 0010:lru_gen_migrate_mm+0x72/0x80
[26181.135835] Call Trace:
[26181.135837]  <TASK>
[26181.135838]  mem_cgroup_attach+0x88/0x90
[26181.135844]  cgroup_migrate_execute+0x213/0x470
[26181.135848]  cgroup_attach_task+0x11c/0x1c0
[26181.135852]  ? cgroup_attach_permissions+0x159/0x1c0
[26181.135857]  __cgroup_procs_write+0x10e/0x140
[26181.135861]  cgroup_procs_write+0x13/0x20
[26181.135864]  kernfs_fop_write_iter+0x11e/0x1f0
[26181.135870]  vfs_write+0x222/0x3e0
[26181.135876]  ksys_write+0x5b/0xd0
[26181.135880]  do_syscall_64+0x5b/0x80
[26181.135884]  ? syscall_exit_to_user_mode+0x17/0x40
[26181.135889]  ? do_syscall_64+0x67/0x80
[26181.135892]  ? do_syscall_64+0x67/0x80
[26181.135895]  ? exc_page_fault+0x70/0x170
[26181.135900]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[26181.135903] RIP: 0033:0x7fd18996a0c4
[26181.135985]  </TASK>
[26181.135986] ---[ end trace 0000000000000000 ]---
[26181.143062] ------------[ cut here ]------------
[26181.143066] WARNING: CPU: 0 PID: 57554 at mm/vmscan.c:3211 lru_gen_add_mm+0x159/0x180
[26181.143240] CPU: 0 PID: 57554 Comm: xdg-mime Kdump: loaded Tainted: P        W  OE      6.1.5-200.fc37.x86_64 #1
[26181.143246] RIP: 0010:lru_gen_add_mm+0x159/0x180
[26181.143274] Call Trace:
[26181.143277]  <TASK>
[26181.143281]  kernel_clone+0x20c/0x400
[26181.143285]  ? wp_page_copy+0x36f/0x6f0
[26181.143290]  __do_sys_clone+0x64/0x70
[26181.143295]  do_syscall_64+0x5b/0x80
[26181.143299]  ? syscall_exit_to_user_mode+0x17/0x40
[26181.143303]  ? do_syscall_64+0x67/0x80
[26181.143307]  ? syscall_exit_to_user_mode+0x17/0x40
[26181.143310]  ? do_syscall_64+0x67/0x80
[26181.143314]  ? handle_mm_fault+0xdb/0x2d0
[26181.143317]  ? do_user_addr_fault+0x1ef/0x690
[26181.143322]  ? _raw_spin_lock+0x13/0x40
[26181.143326]  ? exc_page_fault+0x70/0x170
[26181.143330]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[26181.143333] RIP: 0033:0x7fa3b7131d47
[26181.143379]  </TASK>
[26181.143380] ---[ end trace 0000000000000000 ]---
[26181.143387] ------------[ cut here ]------------
[26181.143388] WARNING: CPU: 0 PID: 57554 at mm/vmscan.c:3213 lru_gen_add_mm+0x16a/0x180
[26181.143535] CPU: 0 PID: 57554 Comm: xdg-mime Kdump: loaded Tainted: P        W  OE      6.1.5-200.fc37.x86_64 #1
[26181.143539] RIP: 0010:lru_gen_add_mm+0x16a/0x180
[26181.143564] Call Trace:
[26181.143565]  <TASK>
[26181.143567]  kernel_clone+0x20c/0x400
[26181.143570]  ? wp_page_copy+0x36f/0x6f0
[26181.143574]  __do_sys_clone+0x64/0x70
[26181.143578]  do_syscall_64+0x5b/0x80
[26181.143581]  ? syscall_exit_to_user_mode+0x17/0x40
[26181.143585]  ? do_syscall_64+0x67/0x80
[26181.143588]  ? syscall_exit_to_user_mode+0x17/0x40
[26181.143592]  ? do_syscall_64+0x67/0x80
[26181.143595]  ? handle_mm_fault+0xdb/0x2d0
[26181.143599]  ? do_user_addr_fault+0x1ef/0x690
[26181.143603]  ? _raw_spin_lock+0x13/0x40
[26181.143606]  ? exc_page_fault+0x70/0x170
[26181.143610]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[26181.143614] RIP: 0033:0x7fa3b7131d47
[26181.143638]  </TASK>
[26181.143639] ---[ end trace 0000000000000000 ]---
[26181.143641] list_add double add: new=ffff91c15edec3d8, prev=ffff91c15edec3d8, next=ffff91c1e3f48878.
[26181.143658] ------------[ cut here ]------------
[26181.143659] kernel BUG at lib/list_debug.c:33!
[26181.143667] invalid opcode: 0000 [#1] PREEMPT SMP PTI
[26181.143670] CPU: 0 PID: 57554 Comm: xdg-mime Kdump: loaded Tainted: P        W  OE      6.1.5-200.fc37.x86_64 #1
[26181.143675] RIP: 0010:__list_add_valid.cold+0x23/0x5b
[26181.143707] Call Trace:
[26181.143708]  <TASK>
[26181.143710]  lru_gen_add_mm+0x10a/0x180
[26181.143716]  kernel_clone+0x20c/0x400
[26181.143719]  ? wp_page_copy+0x36f/0x6f0
[26181.143723]  __do_sys_clone+0x64/0x70
[26181.143728]  do_syscall_64+0x5b/0x80
[26181.143732]  ? syscall_exit_to_user_mode+0x17/0x40
[26181.143736]  ? do_syscall_64+0x67/0x80
[26181.143740]  ? syscall_exit_to_user_mode+0x17/0x40
[26181.143744]  ? do_syscall_64+0x67/0x80
[26181.143748]  ? handle_mm_fault+0xdb/0x2d0
[26181.143753]  ? do_user_addr_fault+0x1ef/0x690
[26181.143757]  ? _raw_spin_lock+0x13/0x40
[26181.143761]  ? exc_page_fault+0x70/0x170
[26181.143765]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[26181.143769] RIP: 0033:0x7fa3b7131d47
[26181.143796]  </TASK>

Fix this by simply leaving the lru_gen alone if it has not been
associated with a memcg yet, as it should eventually be assigned to the
right cgroup anyway.

[1]: https://gitlab.freedesktop.org/benzea/uresourced/-/blob/master/cgroupify/cgroupify.c

Signed-off-by: N/A (patch should not be copyrightable)
---
 mm/vmscan.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index bd6637fcd8f9..0cac40e7484c 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3323,13 +3323,19 @@ void lru_gen_migrate_mm(struct mm_struct *mm)
 	if (mem_cgroup_disabled())
 		return;
 
+	/* This could happen if cgroup migration is invoked before the process
+	 * lru_gen is associated with a memcg (e.g. during process creation).
+	 * Simply ignore it in this case as the lru_gen will get assigned the
+	 * right cgroup later. */
+	if (!mm->lru_gen.memcg)
+		return;
+
 	rcu_read_lock();
 	memcg = mem_cgroup_from_task(task);
 	rcu_read_unlock();
 	if (memcg == mm->lru_gen.memcg)
 		return;
 
-	VM_WARN_ON_ONCE(!mm->lru_gen.memcg);
 	VM_WARN_ON_ONCE(list_empty(&mm->lru_gen.list));
 
 	lru_gen_del_mm(mm);
-- 
2.39.0


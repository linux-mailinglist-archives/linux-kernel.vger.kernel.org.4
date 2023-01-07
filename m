Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5900660CB6
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 08:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjAGHBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 02:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjAGHBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 02:01:16 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6E669B0C
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 23:01:14 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id w18-20020a5d9cd2000000b006e32359d7fcso1892463iow.15
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 23:01:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WNNiDRVnMpwR65nt0OPdZsgkxg3Sswa/jAC6EPgcxmE=;
        b=puryKtePMts/39/TEGzE5+zZfrEgtb27ht1GuwDyaQyWcZYQp/GKLEcxrLYmreZBnk
         V7olBVupM4PWJX3U9hQrgl/qLeFwReB9SKGyxqlMqSUt/FgbUPuN+Eky1IJh7hLPinAG
         Rfi40uHJOXOrzKbBHDTa2zRdHWfkVghM6zX7TmFDa96oMwY2whS5leXQ1Nl+oKBud786
         7rBexbPPWXFvSh04MhESM6aPDVTzafv1eZZmLC/INflQVBGz9zoyiQqWAa5U113ylueh
         JdBzuTq4oTRPnY6r9A8LoGqlXEirfrNr4S2g4vi9Au2tpZAFiQzHG2pqdpjH+T9VvkYQ
         fvAw==
X-Gm-Message-State: AFqh2kpJSrUo08/SXmf9VvLLWNt2hJS/uLYotsjk5nxmSDP27wKC+D2Y
        NdI/t5MtWxQvuOY7CsMGoMjVnhs5AIznqJ4cojQtADK4JsPB
X-Google-Smtp-Source: AMrXdXuO3CQY5ZjeenXmvbOdoUvbLs/X9bRWO+oPSB47FksOmzeDhVBd8C8HNskDHwoZ3HxB4DG32J6FBgWuSMNvcdSb1TF+bqGv
MIME-Version: 1.0
X-Received: by 2002:a02:3f01:0:b0:38a:95eb:e891 with SMTP id
 d1-20020a023f01000000b0038a95ebe891mr5095659jaa.51.1673074874239; Fri, 06 Jan
 2023 23:01:14 -0800 (PST)
Date:   Fri, 06 Jan 2023 23:01:14 -0800
In-Reply-To: <20230107063010.4809-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008fd3b705f1a719c8@google.com>
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in p9_client_disconnect
From:   syzbot <syzbot+ea8b28e8dca42fc3bcbe@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: unable to handle kernel paging request in percpu_ref_get_many

Unable to handle kernel paging request at virtual address 0000ffff64000000
Mem abort info:
  ESR = 0x0000000096000004
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x04: level 0 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000004
  CM = 0, WnR = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=000000010e408000
[0000ffff64000000] pgd=0000000000000000, p4d=0000000000000000
Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 3885 Comm: dhcpcd-run-hook Not tainted 6.1.0-rc2-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
pstate: 204000c5 (nzCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __ref_is_percpu include/linux/percpu-refcount.h:174 [inline]
pc : percpu_ref_get_many+0x64/0x140 include/linux/percpu-refcount.h:204
lr : rcu_read_lock include/linux/rcupdate.h:739 [inline]
lr : percpu_ref_get_many+0x2c/0x140 include/linux/percpu-refcount.h:202
sp : ffff800012ddba00
x29: ffff800012ddba00 x28: 0000000000000005 x27: 00000000fffffff8
x26: ffff80000d2de560 x25: ffff80000d37d050 x24: 0000000000000000
x23: ffff0001fefcc560 x22: 0000000000000001 x21: ffff0000d04e0080
x20: 0000ffff64000000 x19: 0000000000000001 x18: fffffffffffffff5
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000002 x12: 0000000000000701
x11: ff808000095d1078 x10: 0000000000000000 x9 : ffff80000d2dd658
x8 : 0000000100000000 x7 : 0000000000000000 x6 : ffff800008579b18
x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000002
x2 : 0000000000000000 x1 : ffff80000ce888e3 x0 : 0000000000000001
Call trace:
 rcu_read_lock include/linux/rcupdate.h:739 [inline]
 percpu_ref_get_many+0x64/0x140 include/linux/percpu-refcount.h:202
 percpu_ref_get include/linux/percpu-refcount.h:222 [inline]
 obj_cgroup_get include/linux/memcontrol.h:779 [inline]
 refill_obj_stock+0x8c/0x254 mm/memcontrol.c:3327
 obj_cgroup_uncharge+0x14/0x20 mm/memcontrol.c:3394
 memcg_slab_free_hook+0x118/0x188 mm/slab.h:569
 slab_free mm/slub.c:3656 [inline]
 kmem_cache_free+0xd8/0x3a4 mm/slub.c:3683
 vm_area_free+0x38/0xe8 kernel/fork.c:485
 remove_vma mm/mmap.c:144 [inline]
 exit_mmap+0x1f0/0x390 mm/mmap.c:3108
 __mmput+0x90/0x204 kernel/fork.c:1185
 mmput+0x64/0xa0 kernel/fork.c:1207
 exit_mm+0x16c/0x1c0 kernel/exit.c:516
 do_exit+0x264/0xcac kernel/exit.c:807
 __arm64_sys_exit_group+0x0/0x18 kernel/exit.c:950
 __do_sys_exit_group kernel/exit.c:961 [inline]
 __se_sys_exit_group kernel/exit.c:959 [inline]
 __wake_up_parent+0x0/0x40 kernel/exit.c:959
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
 el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581
Code: 913af042 52805c81 39285909 97f0ad5f (f9400289) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	913af042 	add	x2, x2, #0xebc
   4:	52805c81 	mov	w1, #0x2e4                 	// #740
   8:	39285909 	strb	w9, [x8, #2582]
   c:	97f0ad5f 	bl	0xffffffffffc2b588
* 10:	f9400289 	ldr	x9, [x20] <-- trapping instruction


Tested on:

commit:         247f34f7 Linux 6.1-rc2
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1695d26e480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa9bed8d6a8992a0
dashboard link: https://syzkaller.appspot.com/bug?extid=ea8b28e8dca42fc3bcbe
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1606acd2480000


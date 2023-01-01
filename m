Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB57165A90F
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 06:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjAAFa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 00:30:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjAAFaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 00:30:25 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA06063F6
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 21:30:24 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id o8-20020a17090a9f8800b00223de0364beso29720344pjp.4
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 21:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ftit7eHKmpp9COAivW7YvJwSHzCaElr3mvQr4opldlw=;
        b=cVwrdyd8RVZP3fP9sHIsNnAe1SFQrCN7S+0N3axvFmZVFN555UhEyFFa62C8BTcQJM
         GKqYnv6i7lw05eiIPqmo6cTEFIb1Raym6Yf6x0JjlVN4xQ6oHrAaoj7eZgF7sKEdIAp7
         rpEZg5O6nYv0aUmkjzgDM8I0h/9ql1atkL8e2vwofnVJ7aw0ea9EYuZ9RyvqykIwqQtI
         tJXJ2ovv5Vd1JGkxEGtaE4DA1PFKpEn8Hy22N9i7Lex+N0a6SWK6efg4BTKMjMFWBK41
         LfAQA/VAMAL9B7YGcbfEbJJ2xQp6SXySl6UK9e+moFyQueT21tFfaW7EdZxIFEavI82r
         Brhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftit7eHKmpp9COAivW7YvJwSHzCaElr3mvQr4opldlw=;
        b=gmdYLq+ImlMZMNx9QGe6NnKZv/9WnjGuSRRd9go2nUF3IRblZeSSXu7omJBzPeBSBs
         YM0rUpiGE/NrEfkgrAdGg84PflxARpiugS9aV0Mk6RujNGhJ+KaKWIrCrZ36Tg65a3dq
         K5BdmmafLcvR4PAISctwb8gSnVeHQIYLkdrm/9Gp6RIbKHswyOlKpzYsQEL1i8lEMS+M
         5mQaUDa8rYjvfHQMeV7V92KJ9CwAnE6AbXZgJ356mshw6SWfiLtchmv6uCuKET30bhGt
         FX0mCF9wXiZZnz+T2m1FQtDCO70zL7nKTdfIQXTdns5TUzPZ6zz1yqW6+g+SE8FYy1Qa
         mHfg==
X-Gm-Message-State: AFqh2kqbJm2oNjH26lw+aAnr675DgAhq3pPAjinIGCvqGv1fzf1zsqk4
        /VKStZ92/5vuGbJuY5t9HT95ScsCjjyHjg==
X-Google-Smtp-Source: AMrXdXtLz4TYlQIqEtzT1wpCY378IpDbpN6Rl4VrCanvcUaNyN1alG5ScPFK5bT3lwL2IvCmNChuLg==
X-Received: by 2002:a05:6a20:5487:b0:ad:b4a5:8d2f with SMTP id i7-20020a056a20548700b000adb4a58d2fmr58558321pzk.42.1672551024111;
        Sat, 31 Dec 2022 21:30:24 -0800 (PST)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id b23-20020a17090a551700b00218f9bd50c7sm14946883pji.50.2022.12.31.21.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 21:30:23 -0800 (PST)
Date:   Sun, 1 Jan 2023 14:30:17 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, oe-lkp@lists.linux.dev,
        lkp@intel.com, Mike Rapoport <rppt@linux.ibm.com>,
        Christoph Lameter <cl@linux.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [linus:master] [mm, slub]  0af8489b02:
 kernel_BUG_at_include/linux/mm.h
Message-ID: <Y7EaaXQV30SMp/S/@hyeyoo>
References: <202212312021.bc1efe86-oliver.sang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202212312021.bc1efe86-oliver.sang@intel.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 31, 2022 at 11:26:25PM +0800, kernel test robot wrote:
> 
> Greeting,
> 
> FYI, we noticed kernel_BUG_at_include/linux/mm.h due to commit (built with gcc-11):
> 
> commit: 0af8489b0216fa1dd83e264bef8063f2632633d7 ("mm, slub: remove percpu slabs with CONFIG_SLUB_TINY")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> [test failed on linux-next/master c76083fac3bae1a87ae3d005b5cb1cbc761e31d5]
> 
> in testcase: rcutorture
> version: 
> with following parameters:
> 
> 	runtime: 300s
> 	test: default
> 	torture_type: tasks-tracing
> 
> test-description: rcutorture is rcutorture kernel module load/unload test.
> test-url: https://www.kernel.org/doc/Documentation/RCU/torture.txt
> 
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> If you fix the issue, kindly add following tag
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Link: https://lore.kernel.org/oe-lkp/202212312021.bc1efe86-oliver.sang@intel.com
> 
> 

<snip>

> Failed to start Update UTMP about System Boot/Shutdown.
> See 'systemctl status systemd-update-utmp.service' for details.
> page:e660911a refcount:0 mapcount:0 mapping:00000000 index:0xedaeef00 pfn:0x2daee
> page:0946d53a refcount:0 mapcount:0 mapping:00000000 index:0x0 pfn:0x2daec
> flags: 0x0(zone=0)
> raw: 00000000 e764d494 e6f205b4 00000000 00000000 00020000 ffffffff 00000000
> raw: 00000000 00000000
> page dumped because: VM_BUG_ON_FOLIO(!folio_test_large(folio))
> page_owner tracks the page as freed

the page is freed state.

> page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 208, tgid 208 (systemd-udevd), ts 25780391126, free_ts 25780421356
> post_alloc_hook+0x1fa/0x280
> get_page_from_freelist+0x226/0x310
> __alloc_pages+0xdd/0x360
> alloc_slab_page+0x12d/0x200
> allocate_slab+0x6a/0x350
> new_slab+0x48/0xc0
> __slab_alloc_node+0xfb/0x270
> kmem_cache_alloc+0x8f/0x4e0
> getname_flags+0x33/0x2f0
> getname+0x1a/0x30
> do_sys_openat2+0xa5/0x1f0
> do_sys_open+0x8e/0xe0
> __ia32_sys_openat+0x2b/0x40
> __do_fast_syscall_32+0x72/0xd0
> do_fast_syscall_32+0x32/0x70
> do_SYSENTER_32+0x15/0x20

allocated by slab

> page last free stack trace:
> free_pcp_prepare+0x34f/0x940
> free_unref_page_prepare+0x29/0x210
> free_unref_page+0x3a/0x3b0
> __free_pages+0x187/0x1f0
> __free_slab+0x1fd/0x350
> free_slab+0x22/0x70
> free_to_partial_list+0x125/0x260
> do_slab_free+0x30/0x70
> kmem_cache_free+0x171/0x1e0
> putname+0x9f/0xf0
> do_sys_openat2+0xe2/0x1f0
> do_sys_open+0x8e/0xe0
> __ia32_sys_openat+0x2b/0x40
> __do_fast_syscall_32+0x72/0xd0
> do_fast_syscall_32+0x32/0x70
> do_SYSENTER_32+0x15/0x20

freed by slab

> ------------[ cut here ]------------
> kernel BUG at include/linux/mm.h:825!
> invalid opcode: 0000 [#1] SMP
> CPU: 0 PID: 214 Comm: udevadm Tainted: G S                 6.1.0-rc2-00014-g0af8489b0216 #2 1c4d7707ec0ce574ed62a77e82a8580202758048
> EIP: __dump_page.cold+0x282/0x369
> Code: ff ff 83 05 e8 5d bb c5 01 ba 4c c4 2f c4 89 f8 83 15 ec 5d bb c5 00 e8 f2 92 ed fd 83 05 f8 5d bb c5 01 83 15 fc 5d bb c5 00 <0f> 0b 83 05 00 5e bb c5 01 b8 ac 85 a3 c4 83 15 04 5e bb c5 00 e8
> EAX: 00000000 EBX: e764d530 ECX: 00000003 EDX: 4108888f
> ESI: e764d4e0 EDI: e764d4e0 EBP: ed89db3c ESP: ed89db00
> DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00210046
> CR0: 80050033 CR2: 00616abc CR3: 2d878000 CR4: 000406d0
> DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> DR6: fffe0ff0 DR7: 00000400
> Call Trace:
> dump_page+0x2a/0xc0
> ? _raw_spin_lock_irqsave+0x16/0x30
> folio_flags+0x23/0x70
> get_partial_node+0x89/0x290

a page freed by slab is in the partial list?
Sounds like use-after-free from SLUB_TINY but not sure yet how
that could happen :/

> __slab_alloc_node+0xbb/0x270
> kmem_cache_alloc_lru+0x8d/0x4e0
> ? __lock_release+0x3ec/0x410
> ? iget_locked+0x78/0x310
> alloc_inode+0x93/0x150
> iget_locked+0xdd/0x310
> ? lock_is_held_type+0x80/0xf0
> kernfs_get_inode+0x24/0xb0
> kernfs_iop_lookup+0xb5/0x1a0
> __lookup_slow+0xd9/0x2a0
> lookup_slow+0x50/0x90
> walk_component+0x19c/0x2c0
> path_lookupat+0xa3/0x270
> path_openat+0x307/0x3e0
> do_filp_open+0x7c/0x130
> do_sys_openat2+0x113/0x1f0
> do_sys_open+0x8e/0xe0
> __ia32_sys_openat+0x2b/0x40
> __do_fast_syscall_32+0x72/0xd0
> ? trace_hardirqs_on+0xa2/0x110
> ? __fput+0x19f/0x390
> ? lockdep_hardirqs_on_prepare+0x242/0x400
> ? syscall_exit_to_user_mode+0x5f/0x90
> ? __do_fast_syscall_32+0x7c/0xd0
> ? lockdep_hardirqs_on_prepare+0x242/0x400
> ? syscall_exit_to_user_mode+0x5f/0x90
> ? __do_fast_syscall_32+0x7c/0xd0
> ? __do_fast_syscall_32+0x7c/0xd0
> ? syscall_exit_to_user_mode+0x5f/0x90
> ? __do_fast_syscall_32+0x7c/0xd0
> ? __do_fast_syscall_32+0x7c/0xd0
> ? __do_fast_syscall_32+0x7c/0xd0
> ? irqentry_exit_to_user_mode+0x23/0x30
> ? irqentry_exit+0x7f/0xc0
> do_fast_syscall_32+0x32/0x70
> do_SYSENTER_32+0x15/0x20
> entry_SYSENTER_32+0xa2/0xfb
> EIP: 0xb7f8c549
> Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76
> EAX: ffffffda EBX: 00000006 ECX: 006142a1 EDX: 002a8000
> ESI: 00000000 EDI: 00000001 EBP: 00614024 ESP: bff3c4a0
> DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00200246
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> EIP: __dump_page.cold+0x282/0x369
> Code: ff ff 83 05 e8 5d bb c5 01 ba 4c c4 2f c4 89 f8 83 15 ec 5d bb c5 00 e8 f2 92 ed fd 83 05 f8 5d bb c5 01 83 15 fc 5d bb c5 00 <0f> 0b 83 05 00 5e bb c5 01 b8 ac 85 a3 c4 83 15 04 5e bb c5 00 e8
> EAX: 00000000 EBX: e764d530 ECX: 00000003 EDX: 4108888f
> ESI: e764d4e0 EDI: e764d4e0 EBP: ed89db3c ESP: ed89db00
> DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00210046
> CR0: 80050033 CR2: 00616abc CR3: 2d878000 CR4: 000406d0
> DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> DR6: fffe0ff0 DR7: 00000400
> Kernel panic - not syncing: Fatal exception
> Kernel Offset: disabled

-- 
Thanks,
Hyeonggon

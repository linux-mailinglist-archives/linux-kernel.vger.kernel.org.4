Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F3F65CF0A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 10:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234402AbjADJFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 04:05:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234559AbjADJEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 04:04:53 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10431183A3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 01:04:27 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id 6so19628228pfz.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 01:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GyVonFdq1D5RaXkFiX42EcuJDHeckoqo7WuA+2smW1s=;
        b=pdvpIH8QH3GhkjA295FTbvxp7p/g7EyaJKuHK/Ux16kdPo6TibWulHGmSHV1hSBxxX
         2sUQg5mXo1ahuAEhTsBH4DbuaF8V8sR5BNwWt97GYgA3GvLj1Il0uJWA2fq5lQRnMXlJ
         v8WU7Y8Sxu8vTL++Upd1ivSsJ1J+4PbqXgPqvllcN6gpwXD+LoZkbK75nH1XYngF1zbA
         nnFn4yivRpS1YQDyHrBQauXjPxH8mwuEm3Kbp70AW2c3WA16GSj5/777QkKvagd5rXnG
         mj4XSqaBSY90xrsoJEVKCn4FiGRziL5Ab70+cvzYm0oK9ibiqoQZTWBkEFqvUeKdzRAA
         8Opw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GyVonFdq1D5RaXkFiX42EcuJDHeckoqo7WuA+2smW1s=;
        b=iH+Rczje7EWGZfO2mX8t7v4N8Kt66QswgfZI3OQUe9rjI/5j/lfxCRvZ+avvOiLDW9
         ToBjWRPM2GD49JWWs1sekF8l7UBBX+XIf2nwg8384Wt2EPwBZUZ8no85377zDNsF/ejW
         2Sucah+PkWRmYOgyG9gQaSmt9jituBmswKSL/J9aD8WkPW0LFnr5fFe14XVCfDLfQIYX
         9X6MIrBTZxI4shBpe/M1Mmbty58ow44MHPRiFjEvW3RstV62an2tnipkJo7DNwZd6o6i
         Y3+zxx+SrjbO6yV5w/iMDUpApM237htTuBrXUSj83j2G4n4QqbghKFGnKHajSvUq7/Lq
         Zvsw==
X-Gm-Message-State: AFqh2krixr+V0Wpqb2+XhhLIIi6gIjfGoEruB7L4sz7G9mxB+2lIPVU5
        omQGuyRJHwuvO0dUbqwCgVk=
X-Google-Smtp-Source: AMrXdXsscESY+mRJy0Er+58Hze9HXrS770z1Tij7zCuZMK5NKEyqVTY1ZhgFZFH3IawCe59WTE9kzA==
X-Received: by 2002:a62:1887:0:b0:582:5886:e1b7 with SMTP id 129-20020a621887000000b005825886e1b7mr10329895pfy.14.1672823066370;
        Wed, 04 Jan 2023 01:04:26 -0800 (PST)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id v27-20020aa799db000000b00577c5915138sm556861pfi.128.2023.01.04.01.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 01:04:25 -0800 (PST)
Date:   Wed, 4 Jan 2023 18:04:20 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Oliver Sang <oliver.sang@intel.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, oe-lkp@lists.linux.dev,
        lkp@intel.com, Mike Rapoport <rppt@linux.ibm.com>,
        Christoph Lameter <cl@linux.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [linus:master] [mm, slub] 0af8489b02:
 kernel_BUG_at_include/linux/mm.h
Message-ID: <Y7VBFLHY/PMbb4XS@hyeyoo>
References: <202212312021.bc1efe86-oliver.sang@intel.com>
 <41276905-b8a5-76ae-8a17-a8ec6558e988@suse.cz>
 <Y7Qxucg5le7WOzr7@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7Qxucg5le7WOzr7@xsang-OptiPlex-9020>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 09:46:33PM +0800, Oliver Sang wrote:
> On Tue, Jan 03, 2023 at 11:42:11AM +0100, Vlastimil Babka wrote:
> > So the events leading up to this could be something like:
> > 
> > - 0x2daee is order-1 slab folio of the inode cache, sitting on the partial list
> > - despite being on partial list, it's freed ???
> > - somebody else allocates order-2 page 0x2daec and uses it for whatever,
> > then frees it
> > - 0x2daec is reallocated as order-1 slab from names_cache, then freed
> > - we try to allocate from the slab page 0x2daee and trip on the PageTail
> > 
> > Except, the freeing of order-2 page would have reset the PageTail and
> > compound_head in 0x2daec, so this is even more complicated or involves some
> > extra race?
> 
> FYI, we ran tests more up to 500 times, then saw different issues but rate is
> actually low
> 
> 56d5a2b9ba85a390 0af8489b0216fa1dd83e264bef8
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>            :500         12%          61:500   dmesg.invalid_opcode:#[##]
>            :500          3%          14:500   dmesg.kernel_BUG_at_include/linux/mm.h
>            :500          3%          17:500   dmesg.kernel_BUG_at_include/linux/page-flags.h
>            :500          5%          26:500   dmesg.kernel_BUG_at_lib/list_debug.c
>            :500          0%           2:500   dmesg.kernel_BUG_at_mm/page_alloc.c
>            :500          0%           2:500   dmesg.kernel_BUG_at_mm/usercopy.c
> 
> > 
> > In any case, this is something a debug_pagealloc kernel could have a chance
> > of catching earlier. Would it be possible to enable CONFIG_DEBUG_PAGEALLOC
> > and DEBUG_PAGEALLOC_ENABLE_DEFAULT additionally to the rest of the
> > configuration, and repeat the test?
> 
> ok, we are starting to test by these 2 additional configs now.

BTW it seems to be totally unrelated to rcutorture tests.
Are there similar reports in boot tests with the same config?

> > 
> > Separately we should also make the __dump_page() more resilient.
> > 
> > Thanks,
> > Vlastimil
> > 
> > > [   25.804432][  T214] ------------[ cut here ]------------
> > > [   25.804917][  T214] kernel BUG at include/linux/mm.h:825!
> > > [   25.805402][  T214] invalid opcode: 0000 [#1] SMP
> > > [   25.805820][  T214] CPU: 0 PID: 214 Comm: udevadm Tainted: G S                 6.1.0-rc2-00014-g0af8489b0216 #2 1c4d7707ec0ce574ed62a77e82a8580202758048
> > > [   25.806944][  T214] EIP: __dump_page.cold+0x282/0x369
> > > [   25.807376][  T214] Code: ff ff 83 05 e8 5d bb c5 01 ba 4c c4 2f c4 89 f8 83 15 ec 5d bb c5 00 e8 f2 92 ed fd 83 05 f8 5d bb c5 01 83 15 fc 5d bb c5 00 <0f> 0b 83 05 00 5e bb c5 01 b8 ac 85 a3 c4 83 15 04 5e bb c5 00 e8
> > > [   25.808960][  T214] EAX: 00000000 EBX: e764d530 ECX: 00000003 EDX: 4108888f
> > > [   25.809578][  T214] ESI: e764d4e0 EDI: e764d4e0 EBP: ed89db3c ESP: ed89db00
> > > [   25.810168][  T214] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00210046
> > > [   25.810803][  T214] CR0: 80050033 CR2: 00616abc CR3: 2d878000 CR4: 000406d0
> > > [   25.811407][  T214] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> > > [   25.811999][  T214] DR6: fffe0ff0 DR7: 00000400
> > > [   25.812390][  T214] Call Trace:
> > > [   25.812675][  T214]  dump_page+0x2a/0xc0
> > > [   25.813025][  T214]  ? _raw_spin_lock_irqsave+0x16/0x30
> > > [   25.813492][  T214]  folio_flags+0x23/0x70
> > > [   25.813945][  T214]  get_partial_node+0x89/0x290
> > > [   25.814357][  T214]  __slab_alloc_node+0xbb/0x270
> > > [   25.814860][  T214]  kmem_cache_alloc_lru+0x8d/0x4e0
> > > [   25.815289][  T214]  ? __lock_release+0x3ec/0x410
> > > [   25.815697][  T214]  ? iget_locked+0x78/0x310
> > > [   25.816096][  T214]  alloc_inode+0x93/0x150
> > > [   25.816469][  T214]  iget_locked+0xdd/0x310
> > > [   25.816829][  T214]  ? lock_is_held_type+0x80/0xf0
> > > [   25.817264][  T214]  kernfs_get_inode+0x24/0xb0
> > > [   25.817670][  T214]  kernfs_iop_lookup+0xb5/0x1a0
> > > [   25.818087][  T214]  __lookup_slow+0xd9/0x2a0
> > > [   25.818479][  T214]  lookup_slow+0x50/0x90
> > > [   25.818847][  T214]  walk_component+0x19c/0x2c0
> > > [   25.819244][  T214]  path_lookupat+0xa3/0x270
> > > [   25.819627][  T214]  path_openat+0x307/0x3e0
> > > [   25.820007][  T214]  do_filp_open+0x7c/0x130
> > > [   25.820409][  T214]  do_sys_openat2+0x113/0x1f0
> > > [   25.820807][  T214]  do_sys_open+0x8e/0xe0
> > > [   25.821211][  T214]  __ia32_sys_openat+0x2b/0x40
> > > [   25.821622][  T214]  __do_fast_syscall_32+0x72/0xd0
> > > [   25.822057][  T214]  ? trace_hardirqs_on+0xa2/0x110
> > > [   25.822480][  T214]  ? __fput+0x19f/0x390
> > > [   25.822842][  T214]  ? lockdep_hardirqs_on_prepare+0x242/0x400
> > > [   25.823346][  T214]  ? syscall_exit_to_user_mode+0x5f/0x90
> > > [   25.823823][  T214]  ? __do_fast_syscall_32+0x7c/0xd0
> > > [   25.824259][  T214]  ? lockdep_hardirqs_on_prepare+0x242/0x400
> > > [   25.824767][  T214]  ? syscall_exit_to_user_mode+0x5f/0x90
> > > [   25.825254][  T214]  ? __do_fast_syscall_32+0x7c/0xd0
> > > [   25.825696][  T214]  ? __do_fast_syscall_32+0x7c/0xd0
> > > [   25.826155][  T214]  ? syscall_exit_to_user_mode+0x5f/0x90
> > > [   25.826627][  T214]  ? __do_fast_syscall_32+0x7c/0xd0
> > > [   25.827056][  T214]  ? __do_fast_syscall_32+0x7c/0xd0
> > > [   25.827486][  T214]  ? __do_fast_syscall_32+0x7c/0xd0
> > > [   25.827929][  T214]  ? irqentry_exit_to_user_mode+0x23/0x30
> > > [   25.828423][  T214]  ? irqentry_exit+0x7f/0xc0
> > > [   25.828812][  T214]  do_fast_syscall_32+0x32/0x70
> > > [   25.829223][  T214]  do_SYSENTER_32+0x15/0x20
> > > [   25.829589][  T214]  entry_SYSENTER_32+0xa2/0xfb
> > > [   25.830003][  T214] EIP: 0xb7f8c549
> > > [   25.830330][  T214] Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76
> > > [   25.831929][  T214] EAX: ffffffda EBX: 00000006 ECX: 006142a1 EDX: 002a8000
> > > [   25.832522][  T214] ESI: 00000000 EDI: 00000001 EBP: 00614024 ESP: bff3c4a0
> > > [   25.833123][  T214] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00200246
> > > [   25.833738][  T214] Modules linked in:
> > > [   25.834062][  T214] ---[ end trace 0000000000000000 ]---
> > > [   25.834522][  T214] EIP: __dump_page.cold+0x282/0x369
> > > [   25.834960][  T214] Code: ff ff 83 05 e8 5d bb c5 01 ba 4c c4 2f c4 89 f8 83 15 ec 5d bb c5 00 e8 f2 92 ed fd 83 05 f8 5d bb c5 01 83 15 fc 5d bb c5 00 <0f> 0b 83 05 00 5e bb c5 01 b8 ac 85 a3 c4 83 15 04 5e bb c5 00 e8
> > > [   25.836574][  T214] EAX: 00000000 EBX: e764d530 ECX: 00000003 EDX: 4108888f
> > > [   25.837183][  T214] ESI: e764d4e0 EDI: e764d4e0 EBP: ed89db3c ESP: ed89db00
> > > [   25.837772][  T214] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00210046
> > > [   25.838414][  T214] CR0: 80050033 CR2: 00616abc CR3: 2d878000 CR4: 000406d0
> > > [   25.839011][  T214] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> > > [   25.839597][  T214] DR6: fffe0ff0 DR7: 00000400
> > > [   25.839995][  T214] Kernel panic - not syncing: Fatal exception
> > > [   25.840554][  T214] Kernel Offset: disabled
> > 
> > 

-- 
Thanks,
Hyeonggon

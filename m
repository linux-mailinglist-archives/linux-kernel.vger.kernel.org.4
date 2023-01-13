Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B2B669AAD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 15:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjAMOkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 09:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjAMOh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 09:37:59 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5520DF8C
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 06:30:04 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0355B1EC04C1;
        Fri, 13 Jan 2023 15:30:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1673620203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=y5nrVNkdIKFt3IjkBQjPyJlUGJx3Jt/3D2yBOFVDFpI=;
        b=RmBQoBME0LYyBt+3ScyngohV4haQfHzZbn+jy71fVHsi+K9pcEBM4fuE4A46MAjsuMZGQl
        OOkUe1PG628NyYScbcVX/3wtE/uR5elAJRzG2T0Y/kvN1ay2GjRxnqCwipOTkae1hRieYT
        X9zQtkoHGTXesASyTfUuPrUbjXdtJXA=
Date:   Fri, 13 Jan 2023 15:29:58 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>
Cc:     Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Failure during Stack Depot allocating hash table of 1048576 entries
 with kvcalloc
Message-ID: <Y8Fq5m0CLfcFLCOY@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Lemme CC the stackdepot.c commit signers re the below splat.

Lemme know if you need more info.

Thx.

...
[    0.000000] software IO TLB: area num 4.
[    0.000000] Memory: 15612528K/16165300K available (12288K kernel code, 116072K rwdata, 5024K rodata, 2412K init, 3822
0K bss, 552516K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Stack Depot allocating hash table of 1048576 entries with kvcalloc
[    0.000000] swapper: vmalloc error: size 8388608, vm_struct allocation failed, mode:0xdc0(GFP_KERNEL|__GFP_ZERO), nod
emask=(null)
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 6.2.0-rc3+ #1
[    0.000000] Hardware name: HP HP EliteBook 745 G3/807E, BIOS N73 Ver. 01.39 04/16/2019
[    0.000000] Call Trace:
[    0.000000]  <TASK>
[    0.000000]  dump_stack_lvl+0x33/0x46
[    0.000000]  warn_alloc+0xff/0x120
[    0.000000]  ? __get_vm_area_node+0x173/0x180
[    0.000000]  __vmalloc_node_range+0x4d6/0x7d0
[    0.000000]  ? stack_depot_init.cold+0x5e/0x8f
[    0.000000]  ? __kmalloc_large_node+0xde/0x120
[    0.000000]  kvmalloc_node+0xb7/0xd0
[    0.000000]  ? stack_depot_init.cold+0x5e/0x8f
[    0.000000]  stack_depot_init.cold+0x5e/0x8f
[    0.000000]  kmemleak_init+0x17/0x106
[    0.000000]  start_kernel+0x3e8/0x64e
[    0.000000]  secondary_startup_64_no_verify+0xd3/0xdb
[    0.000000]  </TASK>
[    0.000000] Mem-Info:
[    0.000000] active_anon:0 inactive_anon:0 isolated_anon:0
                active_file:0 inactive_file:0 isolated_file:0
                unevictable:0 dirty:0 writeback:0
                slab_reclaimable:0 slab_unreclaimable:25
                mapped:0 shmem:0 pagetables:0
                sec_pagetables:0 bounce:0
                kernel_misc_reclaimable:0
                free:3903107 free_pcp:0 free_cma:0
[    0.000000] Node 0 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:0kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:0kB pagetables:0kB sec_pagetables:0kB all_unreclaimable? no
[    0.000000] Node 0 DMA free:15360kB boost:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15988kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[    0.000000] lowmem_reserve[]: 0 0 0 0
[    0.000000] Node 0 DMA32 free:2262644kB boost:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:2534208kB managed:2262644kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[    0.000000] lowmem_reserve[]: 0 0 0 0
[    0.000000] Node 0 Normal free:13334424kB boost:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:13615104kB managed:13334780kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[    0.000000] lowmem_reserve[]: 0 0 0 0
[    0.000000] Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
[    0.000000] Node 0 DMA32: 5*4kB (UM) 2*8kB (M) 3*16kB (M) 3*32kB (M) 3*64kB (M) 2*128kB (M) 2*256kB (M) 3*512kB (M) 3*1024kB (M) 2*2048kB (M) 550*4096kB (M) = 2262644kB
[    0.000000] Node 0 Normal: 6*4kB (UM) 6*8kB (UM) 5*16kB (UM) 0*32kB 0*64kB 2*128kB (UM) 4*256kB (M) 1*512kB (U) 2*1024kB (UM) 1*2048kB (U) 3254*4096kB (M) = 13334424kB
[    0.000000] 0 total pagecache pages
[    0.000000] 0 pages in swap cache
[    0.000000] Free swap  = 0kB
[    0.000000] Total swap = 0kB
[    0.000000] 4041325 pages RAM
[    0.000000] 0 pages HighMem/MovableOnly
[    0.000000] 138129 pages reserved
[    0.000000] 0 pages hwpoisoned
[    0.000000] Stack Depot hash table allocation failed, disabling
[    0.000000] ftrace: allocating 35561 entries in 139 pages
[    0.000000] ftrace: allocated 139 pages with 4 groups
[    0.000000] Dynamic Preempt: full



-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

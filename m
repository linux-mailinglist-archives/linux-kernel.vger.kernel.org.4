Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132676095E8
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 21:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbiJWTxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 15:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbiJWTxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 15:53:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFF569ED0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 12:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666554780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/E6NQBXNgV7SeHVt+P22OpRoKrABMUeHqy8wFj/J03Y=;
        b=SZBhrChhA3P/W65IacwOuI0cmykRziRyt6XJERNDUY2b9MnYiioQ+PW27JoYgaJL9Wajbs
        8auXoLacVWfuUBHx145ix62A27enrnptXR5QMsaGQbIqCD4PCgsxT/+zXA5TCf6+6IvjhW
        1B8hpA2vdqUpLv7Nim1tIUVSTqSyQ70=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-465-cQSoEQJaPM2QqTVVqCMFBg-1; Sun, 23 Oct 2022 15:52:58 -0400
X-MC-Unique: cQSoEQJaPM2QqTVVqCMFBg-1
Received: by mail-qt1-f199.google.com with SMTP id bq21-20020a05622a1c1500b0039cdae506e6so6003339qtb.10
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 12:52:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/E6NQBXNgV7SeHVt+P22OpRoKrABMUeHqy8wFj/J03Y=;
        b=XXATEP29ZSKIl4OoNaHMZwoNQt/VpiTEk9Nv7jvN/SWvUbQ1Gh/I6ZXYEo7ye70tVW
         1jTuY1uOm9C/lqEwqOHhBhUo+HOa1e9Jci6C2t+zExNomRXqPH/G1cwK04w8EOqCIypL
         QRWi+RLEnFRxOENCEH9Sc2IB9brbsUkjaSV/nRk7KtOXpy8pUUu9OiJNga+c3FQwZxPN
         f7LhEFdN2omfU6A44KptVqUkogxBInWPMlAya2m5d+R1Dw37Z4ukMpjCR7c8wYvBtCbj
         8+nBD0kzGR7Sj5FJikzMBejZI9o69Q5GX9r2Yl31YRZrnfbVUX1KraTgSZyU7xpwSND1
         1C5g==
X-Gm-Message-State: ACrzQf3tNysY//Q2DuPyVXG139JBSLhUFTuYnbw07Uawd4C5TZqc4BuW
        ziduDWX6+VNg1tSjc/9M0mD9hbphFZgQys54Uwx1EL7+KOD9B80+B4b81md7pZ+jFj3lIWyskGc
        /lR3q7+3twarI1ah8ZjosnBuO
X-Received: by 2002:a05:620a:c55:b0:6ee:3a2e:97a5 with SMTP id u21-20020a05620a0c5500b006ee3a2e97a5mr20891597qki.511.1666554777153;
        Sun, 23 Oct 2022 12:52:57 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5SB72Pga2YSfKYGYuPDdKBTAnU2a6NXCFYvz7XQhuWOfP/Bjxrx967t3ZTFWiBA49hJ7xTEA==
X-Received: by 2002:a05:622a:11cf:b0:39c:d63a:d79 with SMTP id n15-20020a05622a11cf00b0039cd63a0d79mr24832566qtk.260.1666554766594;
        Sun, 23 Oct 2022 12:52:46 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id u21-20020a05620a0c5500b006b5bf5d45casm13910308qki.27.2022.10.23.12.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 12:52:45 -0700 (PDT)
Date:   Sun, 23 Oct 2022 15:52:43 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Anatoly Pugachev <matorola@gmail.com>,
        David Miller <davem@davemloft.net>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Alistair Popple <apopple@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>, sparclinux@vger.kernel.org
Subject: Re: dpkg fails on sparc64 (was: [PATCH v4 4/7] mm/thp: Carry over
 dirty bit when thp splits on pmd)
Message-ID: <Y1Wbi4yyVvDtg4zN@x1n>
References: <20220811161331.37055-1-peterx@redhat.com>
 <20220811161331.37055-5-peterx@redhat.com>
 <20221021160603.GA23307@u164.east.ru>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="V+D6jZxSD7O649r4"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221021160603.GA23307@u164.east.ru>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--V+D6jZxSD7O649r4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Oct 21, 2022 at 07:06:03PM +0300, Anatoly Pugachev wrote:
> On Thu, Aug 11, 2022 at 12:13:28PM -0400, Peter Xu wrote:
> > Carry over the dirty bit from pmd to pte when a huge pmd splits.  It
> > shouldn't be a correctness issue since when pmd_dirty() we'll have the page
> > marked dirty anyway, however having dirty bit carried over helps the next
> > initial writes of split ptes on some archs like x86.
> > 
> > Reviewed-by: Huang Ying <ying.huang@intel.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  mm/huge_memory.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> 
> Hello!

Hi, Anatoly,

> 
> Tried to update my debian sparc64 sid (unstable) linux distro to latest
> version of available packages, got dpkg segfault... 
> 
> $ apt update -y
> ...
> Unpacking linux-image-sparc64-smp (6.0.2-1) ...
> E: Sub-process /usr/bin/dpkg received a segmentation fault.
> 
> Downgraded dpkg from 1.21.9 to 1.21.8 / 1.21.7 (2-3 monthes old
> versions) - still getting segfault on package install (which was never
> an issue before, even on this old dpkg versions).
> 
> Tried to gdb backtrace core file, which is unlucky :
> 
> 
> root@ttip:/# apt install -y linux-image-sparc64-smp ccache qemu-utils xdelta qemu-system-x86 distcc qemu-efi-aarch64 pkg-kde-tools
> ...
> Preparing to unpack .../2-linux-image-6.0.0-1-sparc64-smp_6.0.2-1_sparc64.deb ...
> Unpacking linux-image-6.0.0-1-sparc64-smp (6.0.2-1) ...
> Selecting previously unselected package linux-image-sparc64-smp.
> Preparing to unpack .../3-linux-image-sparc64-smp_6.0.2-1_sparc64.deb ...
> Unpacking linux-image-sparc64-smp (6.0.2-1) ...
> E: Sub-process /usr/bin/dpkg received a segmentation fault.
> root@ttip:/# ls -l core.4751
> -rw------- 1 root root 25042944 Oct 21 14:38 core.4751
> root@ttip:/# gdb -q -c core.4751
> GNU gdb (Debian 12.1-4) 12.1
> [New LWP 4751]
> Core was generated by `/usr/bin/dpkg --status-fd 15 --no-triggers --unpack --auto-deconfigure --recurs'.
> Program terminated with signal SIGSEGV, Segmentation fault.
> #0  0xfff800010089cde4 in ?? ()
> (gdb) bt
> #0  0xfff800010089cde4 in ?? ()
> Backtrace stopped: previous frame identical to this frame (corrupt stack?)
> (gdb)
> 
> 
> rebooted from my compiled kernel 6.1.0-rc1 to older (debian) kernel -
> 5.19.0-2-sparc64-smp
> 
> dpkg installed packages without any problems. Removed just installed
> packages, rebooted to 6.1.0-rc1 and tried to install packages, dpkg got
> segfault again.
> 
> Recompiled 6.1.0-rc1 with gcc-11 instead of gcc-12, still segfaults...
> ... bisect time ...
> 
> mator@ttip:~/linux-2.6$ git bisect log
> # bad: [9abf2313adc1ca1b6180c508c25f22f9395cc780] Linux 6.1-rc1
> # good: [4fe89d07dcc2804c8b562f6c7896a45643d34b2f] Linux 6.0
> git bisect start 'v6.1-rc1' 'v6.0'
> # good: [18fd049731e67651009f316195da9281b756f2cf] Merge tag 'arm64-upstream' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
> git bisect good 18fd049731e67651009f316195da9281b756f2cf
> # good: [4c540c92b46497dcda59203eea78e4620bc96f47] RISC-V: Add mvendorid, marchid, and mimpid to /proc/cpuinfo output
> git bisect good 4c540c92b46497dcda59203eea78e4620bc96f47
> # bad: [27bc50fc90647bbf7b734c3fc306a5e61350da53] Merge tag 'mm-stable-2022-10-08' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> git bisect bad 27bc50fc90647bbf7b734c3fc306a5e61350da53
> # good: [ada3bfb6492a6d0d3eca50f3b61315fe032efc72] Merge tag 'tpmdd-next-v6.1-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd
> git bisect good ada3bfb6492a6d0d3eca50f3b61315fe032efc72
> # bad: [5f7fa13fa858c17580ed513bd5e0a4b36d68fdd6] mm: add pageblock_align() macro
> git bisect bad 5f7fa13fa858c17580ed513bd5e0a4b36d68fdd6
> # bad: [54a611b605901c7d5d05b6b8f5d04a6ceb0962aa] Maple Tree: add new data structure
> git bisect bad 54a611b605901c7d5d05b6b8f5d04a6ceb0962aa
> # good: [59298997df89e19aad426d4ae0a7e5037074da5a] x86/uaccess: avoid check_object_size() in copy_from_user_nmi()
> git bisect good 59298997df89e19aad426d4ae0a7e5037074da5a
> # good: [04c6b79ae4f0bcbd96afd7cea5e1a8848162438e] btrfs: convert __process_pages_contig() to use filemap_get_folios_contig()
> git bisect good 04c6b79ae4f0bcbd96afd7cea5e1a8848162438e
> # good: [da29499124cd2221539b235c1f93c7d93faf6565] mm, hwpoison: use __PageMovable() to detect non-lru movable pages
> git bisect good da29499124cd2221539b235c1f93c7d93faf6565
> # bad: [eed9a328aa1ae6ac1edaa026957e6882f57de0dd] mm: x86: add CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG
> git bisect bad eed9a328aa1ae6ac1edaa026957e6882f57de0dd
> # bad: [f347c9d2697fcbbb64e077f7113a3887a181b8c0] filemap: make the accounting of thrashing more consistent
> git bisect bad f347c9d2697fcbbb64e077f7113a3887a181b8c0
> # good: [eba4d770efc86a3710e36b828190858abfa3bb74] mm/swap: comment all the ifdef in swapops.h
> git bisect good eba4d770efc86a3710e36b828190858abfa3bb74
> # bad: [2e3468778dbe3ec389a10c21a703bb8e5be5cfbc] mm: remember young/dirty bit for page migrations
> git bisect bad 2e3468778dbe3ec389a10c21a703bb8e5be5cfbc
> # bad: [0ccf7f168e17bb7eb5a322397ba5a841f4fbaccb] mm/thp: carry over dirty bit when thp splits on pmd
> git bisect bad 0ccf7f168e17bb7eb5a322397ba5a841f4fbaccb
> # good: [0d206b5d2e0d7d7f09ac9540e3ab3e35a34f536e] mm/swap: add swp_offset_pfn() to fetch PFN from swap entry
> git bisect good 0d206b5d2e0d7d7f09ac9540e3ab3e35a34f536e
> # first bad commit: [0ccf7f168e17bb7eb5a322397ba5a841f4fbaccb] mm/thp: carry over dirty bit when thp splits on pmd
> 
> 
> mator@ttip:~/linux-2.6$ git bisect good
> 0ccf7f168e17bb7eb5a322397ba5a841f4fbaccb is the first bad commit
> commit 0ccf7f168e17bb7eb5a322397ba5a841f4fbaccb
> Author: Peter Xu <peterx@redhat.com>
> Date:   Thu Aug 11 12:13:28 2022 -0400
> 
>     mm/thp: carry over dirty bit when thp splits on pmd
> 
>     Carry over the dirty bit from pmd to pte when a huge pmd splits.  It
>     shouldn't be a correctness issue since when pmd_dirty() we'll have the
>     page marked dirty anyway, however having dirty bit carried over helps the
>     next initial writes of split ptes on some archs like x86.
> 
>     Link: https://lkml.kernel.org/r/20220811161331.37055-5-peterx@redhat.com
> 
> 
> 
> So, v6.0-rc3-176-g0d206b5d2e0d) does not segfault dpkg,
> v6.0-rc3-177-g0ccf7f168e17 segfaults it on package install.
> 
> dpkg test was (apt) install/remove some packages, segfaults only on install
> (not remove).
> 
> Reverted 0ccf7f168e17bb7eb5a322397ba5a841f4fbaccb from top of v6.1-rc1 and
> tried to compile kernel, but got error 
> 
> mm/huge_memory.c: In function ‘__split_huge_pmd_locked’:
> mm/huge_memory.c:2129:17: error: ‘dirty’ undeclared (first use in this function)
>  2129 |                 dirty = is_migration_entry_dirty(entry);
>       |                 ^~~~~
> mm/huge_memory.c:2129:17: note: each undeclared identifier is reported only once for each function it appears in
> make[2]: *** [scripts/Makefile.build:250: mm/huge_memory.o] Error 1
> 
> So can't test v6.1-rc1 with patch reverted...

Sorry to know this, and thanks for the report and debugging.  The revert
won't work because dirty variable is used in later patch for the swap path
too.  I've attached a partial (and minimum) revert, feel free to try.

I had a feeling that it's somehow related to the special impl of sparc64
pte_mkdirty() where a kernel patching mechanism is used to share code
between sun4[uv].  I'd assume your machine is sun4v?  As that's the one
that needs the patching, iiuc.

The sparc64 impl goes back to commit cf627156c450 ("[SPARC64]: Use inline
patching for critical PTE operations.", 2006-03-20).  I believe it works
solidly for all these years, so I really have no quick clue on why that can
fail with the new code added.

I think the magic is done with sun4v_patch_2insn_range().  What I can think
of is this thp patch can definitely add much more places of the kernel that
will need patching, because both __split_huge_pmd() and split_huge_pmd()
are defined as macros not functions.  However I don't see a problem for it
so far, e.g., I don't see a limitation of __sun4v_2insn_patch_end growing
to satisfy all those new spots.

I'm copying David Miller who implemented the sparc64 pte operations.  I
know he's probably always very busy, but just in case there'll be quick
answers so we don't need the revert patch but just make it work for sparc64
too.  Currently with the revert patch we'll start to loose dirty bit again
like before on many archs when thp split, but I assume that's so far better
than breaking any arch or making an arch specific ifdef so we can revisit.

Thanks,

-- 
Peter Xu

--V+D6jZxSD7O649r4
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment;
	filename="0001-Partly-revert-mm-thp-carry-over-dirty-bit-when-thp-s.patch"

From 1ea9c520b3d0bb10cc4195893dd4326f451c3dad Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Sun, 23 Oct 2022 15:29:29 -0400
Subject: [PATCH] Partly revert "mm/thp: carry over dirty bit when thp splits
 on pmd"
Content-type: text/plain

Anatoly Pugachev <matorola@gmail.com> reported sparc64 breakage on the
patch:

https://lore.kernel.org/r/20221021160603.GA23307@u164.east.ru

The sparc64 impl of pte_mkdirty() is definitely slightly special in that it
leverages a code patching mechanism for sun4u/sun4v on relevant pgtable
entry operations.

Before having a clue of why the sparc64 is special and caused the patch to
SIGSEGV the processes, revert the patch for now.  The swap path of dirty
bit inheritage is kept because that's using the swap shared code so we
assume it'll not be affected.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/huge_memory.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index ad17c8d3c0fe..72b9b4622a38 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2160,9 +2160,12 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 				entry = pte_wrprotect(entry);
 			if (!young)
 				entry = pte_mkold(entry);
-			/* NOTE: this may set soft-dirty too on some archs */
-			if (dirty)
-				entry = pte_mkdirty(entry);
+			/*
+			 * NOTE: we don't do pte_mkdirty when dirty==true
+			 * because it breaks sparc64 which can sigsegv
+			 * random process.  Need to revisit when we figure
+			 * out what is special with sparc64.
+			 */
 			if (soft_dirty)
 				entry = pte_mksoft_dirty(entry);
 			if (uffd_wp)
-- 
2.37.3


--V+D6jZxSD7O649r4--


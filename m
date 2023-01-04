Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4F565CDDF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 08:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjADHuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 02:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233857AbjADHuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 02:50:40 -0500
X-Greylist: delayed 427 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 03 Jan 2023 23:50:39 PST
Received: from a27-19.smtp-out.us-west-2.amazonses.com (a27-19.smtp-out.us-west-2.amazonses.com [54.240.27.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A8A18E20;
        Tue,  3 Jan 2023 23:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ude52klaz7ukvnrchdbsicqdl2lnui6h; d=aaront.org; t=1672818212;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding;
        bh=Wj7klY86vgtWMpFXPcL7VhH5cXg34dvEywUtgtkdsuI=;
        b=QOWpEF16QFYnFtfERkKmMgaJ/pHcACnd9XRFlYJtdjcAS31G2mCxLvws0Zt6yC25
        yk2lE4dJp7fB4lxngj58j0n/gmqSG9kZKI8oGh3pzzJkTGrLPeRVc7oSW1pJuwnGbUS
        RANqHANUTWtmagTq7O2pb50MHmoKj2wl/mgsVaWk=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1672818212;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
        bh=Wj7klY86vgtWMpFXPcL7VhH5cXg34dvEywUtgtkdsuI=;
        b=Zpn6P8cOMw6L+wGAWZentm/sIjv+oHTVrNbQWl1qkIICnowu8Un8q/aFe2fzpB2N
        jbxUMu4uCqkynPLVHUqpx/6k+f6o34vJ73MdC+3+5M1YucUHMamM3KPFc+H3ShD33Md
        dBCCRPhkC3XxNs1U9hLmQ00rfP7whFKZRaFv/iUg=
From:   Aaron Thompson <dev@aaront.org>
To:     linux-mm@kvack.org, Mike Rapoport <rppt@kernel.org>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Darren Hart <dvhart@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>, Marco Elver <elver@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kasan-dev@googlegroups.com, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        x86@kernel.org, Aaron Thompson <dev@aaront.org>
Subject: [PATCH 0/1] Pages not released from memblock to the buddy allocator
Date:   Wed, 4 Jan 2023 07:43:31 +0000
Message-ID: <010101857bbc3a41-173240b3-9064-42ef-93f3-482081126ec2-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: 1.us-west-2.OwdjDcIoZWY+bZWuVZYzryiuW455iyNkDEZFeL97Dng=:AmazonSES
X-SES-Outgoing: 2023.01.04-54.240.27.19
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

(I've CC'ed the KMSAN and x86 EFI maintainers as an FYI; the only code change
I'm proposing is in memblock.)

I've run into a case where pages are not released from memblock to the buddy
allocator. If deferred struct page init is enabled, and memblock_free_late() is
called before page_alloc_init_late() has run, and the pages being freed are in
the deferred init range, then the pages are never released. memblock_free_late()
calls memblock_free_pages() which only releases the pages if they are not in the
deferred range. That is correct for free pages because they will be initialized
and released by page_alloc_init_late(), but memblock_free_late() is dealing with
reserved pages. If memblock_free_late() doesn't release those pages, they will
forever be reserved. All reserved pages were initialized by memblock_free_all(),
so I believe the fix is to simply have memblock_free_late() call
__free_pages_core() directly instead of memblock_free_pages().

In addition, there was a recent change (3c20650982609 "init: kmsan: call KMSAN
initialization routines") that added a call to kmsan_memblock_free_pages() in
memblock_free_pages(). It looks to me like it would also be incorrect to make
that call in the memblock_free_late() case, because the KMSAN metadata was
already initialized for all reserved pages by kmsan_init_shadow(), which runs
before memblock_free_all(). Having memblock_free_late() call __free_pages_core()
directly also fixes this issue.

I encountered this issue when I tried to switch some x86_64 VMs I was running
from BIOS boot to EFI boot. The x86 EFI code reserves all EFI boot services
ranges via memblock_reserve() (part of setup_arch()), and it frees them later
via memblock_free_late() (part of efi_enter_virtual_mode()). The EFI
implementation of the VM I was attempting this on, an Amazon EC2 t3.micro
instance, maps north of 170 MB in boot services ranges that happen to fall in
the deferred init range. I certainly noticed when that much memory went missing
on a 1 GB VM.

I've tested the patch on EC2 instances, qemu/KVM VMs with OVMF, and some real
x86_64 EFI systems, and they all look good to me. However, the physical systems
that I have don't actually trigger this issue because they all have more than 4
GB of RAM, so their deferred init range starts above 4 GB (it's always in the
highest zone and ZONE_DMA32 ends at 4 GB) while their EFI boot services mappings
are below 4 GB.

Deferred struct page init can't be enabled on x86_32 so those systems are
unaffected. I haven't found any other code paths that would trigger this issue,
though I can't promise that there aren't any. I did run with this patch on an
arm64 VM as a sanity check, but memblock=debug didn't show any calls to
memblock_free_late() so that system was unaffected as well.

I am guessing that this change should also go the stable kernels but it may not
apply cleanly (__free_pages_core() was __free_pages_boot_core() and
memblock_free_pages() was __free_pages_bootmem() when this issue was first
introduced). I haven't gone through that process before so please let me know if
I can help with that.

This is the end result on an EC2 t3.micro instance booting via EFI:

v6.2-rc2:
  # grep -E 'Node|spanned|present|managed' /proc/zoneinfo
  Node 0, zone      DMA
          spanned  4095
          present  3999
          managed  3840
  Node 0, zone    DMA32
          spanned  246652
          present  245868
          managed  178867

v6.2-rc2 + patch:
  # grep -E 'Node|spanned|present|managed' /proc/zoneinfo
  Node 0, zone      DMA
          spanned  4095
          present  3999
          managed  3840
  Node 0, zone    DMA32
          spanned  246652
          present  245868
          managed  222816


Aaron Thompson (1):
  mm: Always release pages to the buddy allocator in
    memblock_free_late().

 mm/memblock.c                     | 2 +-
 tools/testing/memblock/internal.h | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

-- 
2.30.2


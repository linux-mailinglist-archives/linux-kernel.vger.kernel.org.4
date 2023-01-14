Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58ED66ABA1
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 14:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjANNa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 08:30:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjANNa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 08:30:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7856B5243
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 05:30:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35D63B8049B
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 13:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02559C433EF;
        Sat, 14 Jan 2023 13:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673703022;
        bh=cF7w2WUjmCAVcs3N4RrigyXBTZrsAH/r+Y+h/2zIfU4=;
        h=Date:From:To:Cc:Subject:From;
        b=mrKXKdj+3eVMbtpQIdnTLPEtzap8aSycMgtqXjM0xlGQqRzfOsh65Iz7b3JZLKvgM
         BfjtbumvOcatP1JoyrMkwNXItaL87LCJaIGlkdAWqTl6rYvdW9ysn7l25K/Mdhs1fg
         AuFZ5D7sogO+3BMM3A3/KZZsy5CBzyuMdVwY9bbAOOlfgh5LWYYfp7Wv1A0Njdp0xw
         gVDRq0Di2DIwV8vYYSOxZSaPe7kwerjVhlWlsNBsfvw0Ht8+PaykuetAVcxLXbYZIL
         Ue5AGIhB65FmDFLuxGw89jls2Dz4rO1It/zDQ6MyzzZQnDG9fOM0JR9me+SQUJ5uJx
         xV+kmElfJf5Dw==
Date:   Sat, 14 Jan 2023 15:30:11 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Aaron Thompson <dev@aaront.org>, Mike Rapoport <rppt@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] memblock: fix release of deferred pages in
 memblock_free_late()
Message-ID: <Y8KuYwE9S3zLsqVl@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit fa81ab49bbe4e1ce756581c970486de0ddb14309:

  memblock: Fix doc for memblock_phys_free (2023-01-04 12:31:22 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/fixes-2023-01-14

for you to fetch changes up to 115d9d77bb0f9152c60b6e8646369fa7f6167593:

  mm: Always release pages to the buddy allocator in memblock_free_late(). (2023-01-08 18:49:33 +0200)

----------------------------------------------------------------
memblock: always release pages to the buddy allocator in memblock_free_late()

If CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled, memblock_free_pages()
only releases pages to the buddy allocator if they are not in the
deferred range. This is correct for free pages (as defined by
for_each_free_mem_pfn_range_in_zone()) because free pages in the
deferred range will be initialized and released as part of the deferred
init process. memblock_free_pages() is called by memblock_free_late(),
which is used to free reserved ranges after memblock_free_all() has
run. All pages in reserved ranges have been initialized at that point,
and accordingly, those pages are not touched by the deferred init
process. This means that currently, if the pages that
memblock_free_late() intends to release are in the deferred range, they
will never be released to the buddy allocator. They will forever be
reserved.

In addition, memblock_free_pages() calls kmsan_memblock_free_pages(),
which is also correct for free pages but is not correct for reserved
pages. KMSAN metadata for reserved pages is initialized by
kmsan_init_shadow(), which runs shortly before memblock_free_all().

For both of these reasons, memblock_free_pages() should only be called
for free pages, and memblock_free_late() should call __free_pages_core()
directly instead.

One case where this issue can occur in the wild is EFI boot on
x86_64. The x86 EFI code reserves all EFI boot services memory ranges
via memblock_reserve() and frees them later via memblock_free_late()
(efi_reserve_boot_services() and efi_free_boot_services(),
respectively). If any of those ranges happens to fall within the
deferred init range, the pages will not be released and that memory will
be unavailable.

For example, on an Amazon EC2 t3.micro VM (1 GB) booting via EFI:

v6.2-rc2:
Node 0, zone      DMA
      spanned  4095
      present  3999
      managed  3840
Node 0, zone    DMA32
      spanned  246652
      present  245868
      managed  178867

v6.2-rc2 + patch:
Node 0, zone      DMA
      spanned  4095
      present  3999
      managed  3840
Node 0, zone    DMA32
      spanned  246652
      present  245868
      managed  222816   # +43,949 pages

----------------------------------------------------------------
Aaron Thompson (1):
      mm: Always release pages to the buddy allocator in memblock_free_late().

 mm/memblock.c                     | 8 +++++++-
 tools/testing/memblock/internal.h | 4 ++++
 2 files changed, 11 insertions(+), 1 deletion(-)
-- 
Sincerely yours,
Mike.

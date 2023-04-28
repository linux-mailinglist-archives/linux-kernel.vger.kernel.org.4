Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47DC6F11A0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 08:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345355AbjD1GKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 02:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjD1GKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 02:10:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F4D273E
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 23:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=w00AD2RND4svXJ4bvhmsCWapD4KY7uMvXpZBcuXzcMg=; b=Of4PlOMoiK8lg+fqBSD6qB/Xqf
        lpEZaIEWVy2+q0uWrJQ5lqH4j/MoH0cXwDcxEm5kxXis/rxXiU/9qrp/1K9sk8JbsZc5dz7VqqPa5
        04W4UcjfQzyN+vbxpokKpYslciSu4rYEjx/+6GvG4LB2qoVq3xAs4nmc6HL9T9MK5eEaPbm6Sb0+s
        3pd+J5vGSwkHlWmMnP1xbac6PkoLaZTPGJ+q9TCr/hloQ9JBd60g5iNTOGSwONnvjNSe9dhqLsJ85
        ce7Sm3PikLGsRnI9zU3etZoN95mM7NbUecUfx49/yQS1pzerXpHqDKVwTQoGYXv5YYezjBgH0VsfW
        KQ3B5/Ng==;
Received: from [2001:4bb8:189:a74f:c914:942b:f941:7c82] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1psHJM-008Gt5-0C;
        Fri, 28 Apr 2023 06:10:28 +0000
Date:   Fri, 28 Apr 2023 08:10:25 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: [GIT PULL] dma-mapping updates for Linux 6.4
Message-ID: <ZEtjUWcp6qm4l+zl@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 0eee5ae1025699ea93d44fdb6ef2365505082103:

  swiotlb: fix slot alignment checks (2023-03-22 09:03:17 +0100)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.4-2023-04-28

for you to fetch changes up to ec274aff21b6a94c7973384ca80a503c1bc3b173:

  swiotlb: Omit total_used and used_hiwater if !CONFIG_DEBUG_FS (2023-04-20 14:51:41 +0200)

----------------------------------------------------------------
dma-mapping updates for Linux 6.4

 - fix a PageHighMem check in dma-coherent initialization (Doug Berger)
 - clean up the coherency defaul initialiation (Jiaxun Yang)
 - add cacheline to user/kernel dma-debug space dump messages
   (Desnes Nunes, Geert Uytterhoeve)
 - swiotlb statistics improvements (Michael Kelley)
 - misc cleanups (Petr Tesarik)

----------------------------------------------------------------
Desnes Nunes (2):
      dma-debug: small dma_debug_entry's comment and variable name updates
      dma-debug: add cacheline to user/kernel space dump messages

Doug Berger (1):
      swiotlb: relocate PageHighMem test away from rmem_swiotlb_setup

Geert Uytterhoeven (1):
      dma-debug: Use %pa to format phys_addr_t

Jiaxun Yang (3):
      dma-mapping: provide a fallback dma_default_coherent
      dma-mapping: provide CONFIG_ARCH_DMA_DEFAULT_COHERENT
      of: address: always use dma_default_coherent for default coherency

Michael Kelley (2):
      swiotlb: fix debugfs reporting of reserved memory pools
      swiotlb: track and report io_tlb_used high water marks in debugfs

Petr Tesarik (2):
      dma-direct: cleanup parameters to dma_direct_optimal_gfp_mask
      swiotlb: Omit total_used and used_hiwater if !CONFIG_DEBUG_FS

 arch/powerpc/Kconfig        |   2 +-
 arch/riscv/Kconfig          |   2 +-
 drivers/of/Kconfig          |   4 --
 drivers/of/address.c        |   2 +-
 include/linux/dma-map-ops.h |   2 +
 include/linux/swiotlb.h     |   9 +++
 kernel/dma/Kconfig          |   7 +++
 kernel/dma/debug.c          | 131 +++++++++++++++++++++++---------------------
 kernel/dma/direct.c         |  15 +++--
 kernel/dma/mapping.c        |   6 +-
 kernel/dma/swiotlb.c        |  97 ++++++++++++++++++++++++++++----
 11 files changed, 189 insertions(+), 88 deletions(-)

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A666774104D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 13:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbjF1LrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 07:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjF1LrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 07:47:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6470C2979
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 04:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=2pEg31ZnyjtROB4ZKSiPrA0/DPpd3rl4igfuPmOsT20=; b=DGQUiZUaTXhdpQPDRVkc6dYTh3
        9vbyUQM7Ckupdk2B3lLF3ZgM6Q2ONcYZ3cwc7Vw4paG+mgE2AjnETVckJBXzZCIYg0BKHpLrBsixI
        wNbUWcl170S5GKeoABWHz3gAzcBzz0HJy3SAwf26IcYPlL7C5KnRh+Pdlfg0CdiqV1WF7fpg2cnZv
        Ky3qDLJ0lstVzqS7t3C7X3Zaf0TAuVOJZLJRplpGUtFzzEfaxqPGeJu8Gd75VcDPzesQj80+yl8HD
        LkvNZ+14RIcdmPmuQPqiMxRKWUzGsR+ZtONzxaZoYD0gJ4GzonCtQjYeS5y5KZmbRFf52QCWLhs6V
        i0Es24Ww==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qETdR-00Fb8j-0K;
        Wed, 28 Jun 2023 11:46:57 +0000
Date:   Wed, 28 Jun 2023 13:46:52 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: [GIT PULL] dma-mapping updates for Linux 6.5
Message-ID: <ZJwdrJTHn8gaI5Zb@infradead.org>
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

The following changes since commit 9561de3a55bed6bdd44a12820ba81ec416e705a7:

  Linux 6.4-rc5 (2023-06-04 14:04:27 -0400)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.5-2023-06-28

for you to fetch changes up to 0a2f6372a43ff5e948b8b10be34d4473f6c2ef6c:

  drm/nouveau: stop using is_swiotlb_active (2023-06-07 15:11:26 +0200)

----------------------------------------------------------------
dma-mapping uodates for Linux 6.5

 - swiotlb cleanups (Petr Tesarik)
 - use kvmalloc_array (gaoxu)
 - a small step towards removing is_swiotlb_active (Christoph Hellwig)
 - fix a Kconfig typo Sui Jingfeng)

----------------------------------------------------------------
Christoph Hellwig (1):
      drm/nouveau: stop using is_swiotlb_active

Petr Tesarik (2):
      swiotlb: remove unused field "used" from struct io_tlb_mem
      swiotlb: use the atomic counter of total used slabs if available

Sui Jingfeng (1):
      dma-mapping: fix a Kconfig typo

gaoxu (1):
      dma-remap: use kvmalloc_array/kvfree for larger dma memory remap

 drivers/gpu/drm/nouveau/nouveau_ttm.c | 10 +++-------
 include/linux/swiotlb.h               |  2 --
 kernel/dma/Kconfig                    |  2 +-
 kernel/dma/remap.c                    |  4 ++--
 kernel/dma/swiotlb.c                  | 11 +++++++++++
 5 files changed, 17 insertions(+), 12 deletions(-)

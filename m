Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06D269EF15
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 08:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjBVHER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 02:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjBVHEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 02:04:14 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E747D24CBF
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 23:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=MNjuw99R4HgS/gXxR2rjHmB3r482Mpv9GRPW/CNskZA=; b=1jOsEuWgQSmtMaFWKT/scfSbVT
        lUFFM6ktVoaRkQFLyF2Dqnlavx3hi4StHJOm3DIiyzYMOpwbJ/WiD7wqWbLdQo8P/dysFa+u8qZ7/
        1MvcLDhfikHckihLkREpGhA4gg5GQtI2db0kGet+cg5T+sz0sQ/ewjGxM9k9gaU3BwTUUiMH+KfqD
        /s9h3kxBXjw459cZ0TTwSJpkRXO+OtKN2smJA1oX4s20l56bHONL4yKZUcHSqtuMVy0tWPTUh6Hu0
        Nv4I0pQkkr9AiEsRjrUIOEJtPb0FW/mnpre2CKXICO+75bn2r2Nmd+jrHN9UoGutp3RNYMgq/aOZW
        t6b7kSeg==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pUjAi-00B17L-2z; Wed, 22 Feb 2023 07:04:12 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Alexey Kardashevskiy <aik@amd.com>,
        Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev,
        Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org
Subject: [PATCH] swiotlb: mark swiotlb_memblock_alloc() as __init
Date:   Tue, 21 Feb 2023 23:04:11 -0800
Message-Id: <20230222070411.6186-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

swiotlb_memblock_alloc() calls memblock_alloc(), which calls
(__init) memblock_alloc_try_nid(). However, swiotlb_membloc_alloc()
can be marked as __init since it is only called by swiotlb_init_remap(),
which is already marked as __init. This prevents a modpost build
warning/error:

WARNING: modpost: vmlinux.o: section mismatch in reference: swiotlb_memblock_alloc (section: .text) -> memblock_alloc_try_nid (section: .init.text)
WARNING: modpost: vmlinux.o: section mismatch in reference: swiotlb_memblock_alloc (section: .text) -> memblock_alloc_try_nid (section: .init.text)

This fixes the build warning/error seen on ARM64, PPC64, S390, i386,
and x86_64.

Fixes: 8d58aa484920 ("swiotlb: reduce the swiotlb buffer size on allocation failure")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Alexey Kardashevskiy <aik@amd.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux.dev
Cc: Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org
---
 kernel/dma/swiotlb.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff -- a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -292,8 +292,9 @@ static void swiotlb_init_io_tlb_mem(stru
 	return;
 }
 
-static void *swiotlb_memblock_alloc(unsigned long nslabs, unsigned int flags,
-		int (*remap)(void *tlb, unsigned long nslabs))
+static void __init *swiotlb_memblock_alloc(unsigned long nslabs,
+			unsigned int flags,
+			int (*remap)(void *tlb, unsigned long nslabs))
 {
 	size_t bytes = PAGE_ALIGN(nslabs << IO_TLB_SHIFT);
 	void *tlb;

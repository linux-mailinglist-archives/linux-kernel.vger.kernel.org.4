Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E055FA08A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 16:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbiJJOxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 10:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJJOxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 10:53:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55408326E4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 07:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=OEunLaBEUuho03X0xTAoQPLgk7Xo56Zod+CuZdHS1VQ=; b=DIZyq3bgWGuH4vMaly7/H+lHd4
        QJ/XHrzu1DPeTAvE+JcjlpyVIqDQIli+5YxiF3YvpIvmYCRfmbKqtVCghJ4Gw8umpWS4ZWrqUDgwO
        b4ofhCEnuAbmKvCEmMnBVORi0N1JHdipWGXp04io35Isel+qRm8xZq3RzFcoPYfi3o3Fvb1v8gRM5
        0+qPSteRGBsSIWmNRXVW5xKkDRZejNRE9x4NghMlxIhSMokp70sygGr5F7hgiaLU2ZkgkWOMy2oeu
        2MYgb+3SU+TKJvnwZETSxWOKBvxVKr8fmKlj1ymZwqaqlXOHF0r1aIHXq1ar5yQREhUQ5eTH97DrW
        GaZk9M0Q==;
Received: from [2001:4bb8:18a:723b:fb35:3fe:67e:4563] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ohuA0-001GZn-Qs; Mon, 10 Oct 2022 14:53:41 +0000
Date:   Mon, 10 Oct 2022 16:53:38 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: [GIT PULL] dma-mapping updates for Linux 6.1
Message-ID: <Y0Qx8pLF+vCjItiu@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 521a547ced6477c54b4b0cc206000406c221b4d6:

  Linux 6.0-rc6 (2022-09-18 13:44:14 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.1-2022-10-10

for you to fetch changes up to c9cb01369b926a074004714ab9f9b65f75bf3c60:

  ARM/dma-mapping: remove the dma_coherent member of struct dev_archdata (2022-10-06 14:31:08 +0200)

----------------------------------------------------------------
dma-mapping updates for Linux 6.1

 - fix a regression in the ARM dma-direct conversion (Christoph Hellwig)
 - use memcpy_{from,to}_page (Fabio M. De Francesco)
 - cleanup the swiotlb MAINTAINERS entry (Lukas Bulwahn)
 - make SG table pool allocation less fragile (Masahiro Yamada)
 - don't panic on swiotlb initialization failure (Robin Murphy)

----------------------------------------------------------------
Christoph Hellwig (2):
      ARM/dma-mappіng: don't override ->dma_coherent when set from a bus notifier
      ARM/dma-mapping: remove the dma_coherent member of struct dev_archdata

Fabio M. De Francesco (1):
      swiotlb: replace kmap_atomic() with memcpy_{from,to}_page()

Lukas Bulwahn (1):
      MAINTAINERS: merge SWIOTLB SUBSYSTEM into DMA MAPPING HELPERS

Masahiro Yamada (1):
      lib/sg_pool: change module_init(sg_pool_init) to subsys_initcall

Robin Murphy (1):
      swiotlb: don't panic!

 MAINTAINERS                   | 17 +++++------------
 arch/arm/include/asm/device.h |  1 -
 arch/arm/mm/dma-mapping.c     | 10 ++++++++--
 kernel/dma/swiotlb.c          | 40 +++++++++++++++++++++++-----------------
 lib/sg_pool.c                 | 16 ++--------------
 5 files changed, 38 insertions(+), 46 deletions(-)

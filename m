Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E04A5B44D6
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 08:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbiIJG4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 02:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiIJG4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 02:56:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E39319280
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 23:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=gw5msSXb4FwYmG7+qBKY5dvv180hX0dAH8WvIYXGd4Q=; b=l+jpqr2JqbcKpL2mlhBK8t6wlw
        /Hul2JeaAhQWDzHY85fZh2FNMfMr8BFGaHA+A6hQrJL0S33z9OUmDgbphsb4cDr43AtZzPiUS6M6z
        WRUX2jQ1pRGSxdVdUwsUGBltmgSBQBXXOla0qvCJIHAGmNHglm635AENgrS6bXfnYt9Z56bKSjG7E
        0M6BZ+Le9xXjM8yMv2sDffED4KpssZafJCuJR1OrIOtLkaW8kRpOyZb+U4zt2B9umlShc7Y43koQz
        YAn3BSY8/c0vbjMYA/7SZhN+ZIJn3+2NtoAXb35UNmuKRyurjtgm9bG+E/BgVy91Y7R/ZUnP85lpo
        dARM2QQA==;
Received: from [2001:4bb8:198:38af:e8dc:dbbd:a9d:5c54] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oWuPZ-006qqt-Gk; Sat, 10 Sep 2022 06:56:17 +0000
Date:   Sat, 10 Sep 2022 08:56:10 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: [GIT PULL] dma-mapping fixes for Linux 6.0
Message-ID: <Yxw1CiX1qG9msudX@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 0066f1b0e27556381402db3ff31f85d2a2265858:

  afs: Return -EAGAIN, not -EREMOTEIO, when a file already locked (2022-09-06 21:33:01 -0400)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.0-2022-09-10

for you to fetch changes up to 9fc18f6d56d5b79d527c17a8100a0965d18345cf:

  dma-mapping: mark dma_supported static (2022-09-07 10:38:28 +0200)

----------------------------------------------------------------
dma-mapping fixes for Linux 6.0

 - revert a panic on swiotlb initialization failure (Yu Zhao)
 - fix the lookup for partial syncs in dma-debug (Robin Murphy)
 - fix a shift overflow in swiotlb (Chao Gao)
 - fix a comment typo in swiotlb (Chao Gao)
 - mark a function static now that all abusers are gone
   (Christoph Hellwig)

----------------------------------------------------------------
Chao Gao (2):
      swiotlb: avoid potential left shift overflow
      swiotlb: fix a typo

Christoph Hellwig (1):
      dma-mapping: mark dma_supported static

Robin Murphy (1):
      dma-debug: improve search for partial syncs

Yu Zhao (1):
      Revert "swiotlb: panic if nslabs is too small"

 include/linux/dma-mapping.h |  5 -----
 kernel/dma/debug.c          |  6 ++----
 kernel/dma/mapping.c        |  3 +--
 kernel/dma/swiotlb.c        | 13 ++++++-------
 4 files changed, 9 insertions(+), 18 deletions(-)

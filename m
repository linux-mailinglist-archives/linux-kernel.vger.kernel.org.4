Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA65641C0F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 10:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiLDJcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 04:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiLDJc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 04:32:27 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA9F12D24;
        Sun,  4 Dec 2022 01:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/WO5b3+XRveRvUH+vYohmYPHmCE9UPS08lsr4eFm8KE=; b=wbL9zB6OKLcBZ0DlexYe2IbjQM
        bDCHu/PrzX7C3xGd2hOlpAd+7iWtuKy8UM+zDrHcAAxUZbpFv22JGyvS4ppxY/HgnTtF6zY8ZHUb5
        PXknbF/B7hoJ0+hq1z3dz9B5J8uNg09zVmQe7/HG+tAx66lRy6Mj2YBy1DCpPJNnRPUxBV/qQ/0S3
        AmgVpO06rCr8sR3j1ZYKyRH+diDG4hyJw9VYnOjFNwOvRn+uaCEgule9sRaNuP5NHvjOf9s3SoKch
        kYozVjd8Iglapx8VbbKfAEhzC+R9761isZR00tY0dxedNnwq2ZPhRQWkWuJnu14HXW2xDCHg9xEVU
        0VsoetAQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p1lM0-007BeU-5b; Sun, 04 Dec 2022 09:32:08 +0000
Date:   Sun, 4 Dec 2022 01:32:08 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LinuxKernelMailingList@gondor.apana.org.au,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH 0/10] crypto: Driver conversions for DMA alignment
Message-ID: <Y4xpGNNsfbucyUlt@infradead.org>
References: <Y4nDL50nToBbi4DS@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4nDL50nToBbi4DS@gondor.apana.org.au>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 05:19:43PM +0800, Herbert Xu wrote:
> These are the rest of the driver conversions in order for arm64
> to safely lower the kmalloc alignment below that required for DMA.

Btw, drivers/crypto/ has a lot of weird and most likely uses of
GFP_DMA.  Can someone look into those while we're doing DMA audits
of the cryto drivers?

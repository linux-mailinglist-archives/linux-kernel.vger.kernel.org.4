Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C654661F55
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 08:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236358AbjAIHiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 02:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236325AbjAIHiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 02:38:09 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DE012ABC;
        Sun,  8 Jan 2023 23:38:05 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pEmir-00FVEa-N9; Mon, 09 Jan 2023 15:37:34 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 09 Jan 2023 15:37:33 +0800
Date:   Mon, 9 Jan 2023 15:37:33 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH] crypto: talitos - Remove GFP_DMA and add DMA alignment
 padding
Message-ID: <Y7vEPRYRRpJVcHcQ@gondor.apana.org.au>
References: <Y4nDL50nToBbi4DS@gondor.apana.org.au>
 <Y4xpGNNsfbucyUlt@infradead.org>
 <Y47BgCuZsYLX61A9@gondor.apana.org.au>
 <Y47g7qO8dsRdxCgf@infradead.org>
 <Y47+gxbdKR03EYCj@gondor.apana.org.au>
 <Y61WrVAjjtAMAvSh@gondor.apana.org.au>
 <Y651YoR58cCg3adj@gondor.apana.org.au>
 <Y66T1UCBTqBE6GQ4@gondor.apana.org.au>
 <07259416-84bb-c264-dd8a-5bb3706b8c49@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07259416-84bb-c264-dd8a-5bb3706b8c49@csgroup.eu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 07:18:27AM +0000, Christophe Leroy wrote:
>
> Doesn't GFP_DMA guarantees that the provided memory is addressable for 
> DMA ? Or do we assume that all memory returned by kmalloc can be used 
> for DMA ?

No it does not.  Please refer to the DMI API documentation.

> kmalloc() already returns not DMA aligned memory, why does it becomes a 
> problem now ?

As it stands kmalloc on arm64 returns DMA-aligned memory.  This
will soon no longer be the case.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

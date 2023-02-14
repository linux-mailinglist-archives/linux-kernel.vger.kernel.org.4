Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABD76958EA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 07:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbjBNGNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 01:13:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbjBNGNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 01:13:07 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E61F1CF72;
        Mon, 13 Feb 2023 22:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=N1+Q6ehlZzyNk+5II3GHXDdllKQVwZxvOeW2m7AQVX0=; b=NzZRxjtUrAT7Z7LuVDOPBP8bjk
        lgwVXa2ovuAfrtPW/mPGRVXCMLqStQGG3l+AinjualcyNAoLQ1jcCY0PhFjAue8CCzmgGdXcpPw9l
        svvXjvlUIX7qEbNZfMPqnCNv56cKM797oO9qAotys/TSuZFNDDpUbDztbHrMdl7EZTsY85oXvB197
        +0Ziy3ymW7cQJq1K0K1oq1DT7hePAQ7IzN8zPZJtd0Md1dyys880YcAIh3iANB2nxMuMOmKgGTUS7
        +6eYwr9ny5CyTpOD//imvA4ErCc43kCoAiqG/81BMj+U8XVCXAxlzuqvf0MIlcAybxPhcvar95mGS
        MoQyoDdQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pRoYj-0001Ng-GA; Tue, 14 Feb 2023 06:12:57 +0000
Date:   Mon, 13 Feb 2023 22:12:57 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     JiaJie Ho <jiajie.ho@starfivetech.com>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor.dooley@microchip.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v2 4/4] crypto: starfive - Add hash and HMAC support
Message-ID: <Y+smaRL9f7g9RWEB@infradead.org>
References: <20230130154242.112613-1-jiajie.ho@starfivetech.com>
 <20230130154242.112613-5-jiajie.ho@starfivetech.com>
 <Y+S5fBjZQZli9nBg@gondor.apana.org.au>
 <88a62a7a11814d629e2198583a0349b6@EXMBX168.cuchost.com>
 <Y+TARjfzt2FMG6oJ@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+TARjfzt2FMG6oJ@gondor.apana.org.au>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2023 at 05:43:34PM +0800, Herbert Xu wrote:
> On Thu, Feb 09, 2023 at 09:33:06AM +0000, JiaJie Ho wrote:
> >
> > The DMA can only support 32-bit addressing.
> > So, I am copying everything in case kernel allocated memory region >32-bit for a user app.
> 
> Does your hardware support scatter-and-gather? If so you should
> at least allocate individual pages rather than one contiguous buffer.
> 
> Then you can allocate them on-demand rather than before-hand.
> 
> It would also be nice to not do the copy if the input you were
> given was in low memory (and contiguous if your hardware doesn't
> do SG).

All of that is done by the DMA API, or more specifically swiotlb and
does not need to be duplicated in individual drivers.

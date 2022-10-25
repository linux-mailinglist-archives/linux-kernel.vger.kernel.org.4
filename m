Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6CCA60C32F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 07:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbiJYFVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 01:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiJYFU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 01:20:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B009C112A88;
        Mon, 24 Oct 2022 22:20:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2082E61736;
        Tue, 25 Oct 2022 05:20:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC67C433C1;
        Tue, 25 Oct 2022 05:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666675255;
        bh=5cFmToZnfHJ3wdZXZsGCXvTpJ5G1Crrf87o/qATJxsk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p0fCnGGFpHgVFPayes/UIyVNcy6BtBRFTD3Q9/wyqG2Y5xH1mZr2r2sKRSiBWhuDh
         ztXeBQj+aAYuaZH0FmKdh0ijkr9ui60lO7QqMz+DnvlJM7CiwFy1tao33M4GHL5A0B
         k39c3haPGpF0sTuDVeEtZ39lNQqvX1Fz7mnKxSa2yhST/m2Z4A4UQwdc7vy7WBQPZc
         fuqh9cvdkNsODKS+tDbsj2YYA9N93A/DSh0lORlRzKH9o0PDqx3dE/hBsDgp39Eo8g
         9POJdiZ/00GHwRte+7FXXbAQTPh2qOETSQ24pfz47+tX9HEMjgoWkY1gH2yg/GkqX3
         6pVtRZThPUc2Q==
Date:   Mon, 24 Oct 2022 22:20:53 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Jussi Kivilinna <jussi.kivilinna@iki.fi>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 12/15] crypto: arm64/sm4 - add CE implementation for
 ESSIV mode
Message-ID: <Y1dyNWSdCesQlWm8@sol.localdomain>
References: <20221018071006.5717-1-tianjia.zhang@linux.alibaba.com>
 <20221018071006.5717-13-tianjia.zhang@linux.alibaba.com>
 <Y1DHb66VYPzFlTwh@sol.localdomain>
 <6d2a98f4-c50d-d05b-4a24-08fdd3ee20fa@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d2a98f4-c50d-d05b-4a24-08fdd3ee20fa@linux.alibaba.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 10:47:14AM +0800, Tianjia Zhang wrote:
> Hi Eric,
> 
> On 10/20/22 11:58 AM, Eric Biggers wrote:
> > On Tue, Oct 18, 2022 at 03:10:03PM +0800, Tianjia Zhang wrote:
> > > This patch is a CE-optimized assembly implementation for ESSIV mode.
> > > The assembly part is realized by reusing the CBC mode.
> > > 
> > > Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> > 
> > Is there still a use case for CBC-ESSIV mode these days, now that everyone is
> > using XTS instead?
> > 
> > - Eric
> 
> The mainstream is already using XTS, but CBC-ESSIV is still an optional
> backup algorithm, especially in block crypto and fscrypto, I'm currently
> working on supporting the SM4 algorithm for these subsystems.
> 

The only reason that AES-CBC-ESSIV support was added to fs/crypto/ was because
someone had a low-power embedded device with a hardware crypto accelerator that
only supported AES-CBC.

Nothing like that is relevant here, as this is just a software implementation.

Please just don't include ESSIV.  There's no need to implement random useless
algorithms.  It could always be added later if a use case actually arises.

- Eric

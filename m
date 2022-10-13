Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014EF5FD482
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 08:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiJMGI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 02:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiJMGI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 02:08:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E57612C8A9;
        Wed, 12 Oct 2022 23:08:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6992616FF;
        Thu, 13 Oct 2022 06:08:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC585C433D6;
        Thu, 13 Oct 2022 06:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665641335;
        bh=qHJMJEcih6so6BSzh3Q2gwqEnOlegjhfiSsSBu1WH+4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bCwMgpN2NFm8ny18yJEmxvIZNxPQFDDV277F93hsyKONkNcKoEkxBJG3jD3V5rhx3
         kV5U25IQhZ2gi/i3ILOKgpiuEGkPEAW/59psMoED2p+N6nVN4nnxsClNrYu1hTJhdz
         11+Kl0R1jaLVffsHoIc9U4WCR+A9Bor4KozjzeE5YO4107ZyXlePTXrUqVGncy/a+M
         xMV/t0PjO4NyYQm6q5p0KbyVrcvlxUeNxB99ug9y/9+owthOnQG4jThY9E++fQqgNI
         EdBOYhDv6i8GSWOQ9S+gk5UIjJ5F2OoViNKXfpqhh3cQ0GYfBg3sk6NPVSR4Ycx23p
         gKzeS102hvYNw==
Date:   Wed, 12 Oct 2022 23:08:53 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Robert Elliott <elliott@hpe.com>, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/19] crypto: x86/sha - limit FPU preemption
Message-ID: <Y0erdZ/tJWgm4KKi@sol.localdomain>
References: <20221006223151.22159-1-elliott@hpe.com>
 <20221012215931.3896-1-elliott@hpe.com>
 <20221012215931.3896-5-elliott@hpe.com>
 <Y0eosAIgkvMzYJz8@sol.localdomain>
 <Y0eqe5lbazXzpM/K@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0eqe5lbazXzpM/K@gondor.apana.org.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 02:04:43PM +0800, Herbert Xu wrote:
> On Wed, Oct 12, 2022 at 10:57:04PM -0700, Eric Biggers wrote:
> >
> > 'len' can't be 0 at the beginning of this loop, so the 'if (chunk)' check isn't
> > needed.  And it wouldn't make sense even if 'len' could be 0, since a while loop
> > could just be used in that case.
> 
> I don't see anything preventing len from being zero if this gets
> called directly by a user of the Crypto API through crypto_shash_update.
> But yes a while loop would be a lot cleaner.
> 

When len == 0, the following path is taken instead:

        if (!crypto_simd_usable() ||
            (sctx->count % SHA1_BLOCK_SIZE) + len < SHA1_BLOCK_SIZE)
                return crypto_sha1_update(desc, data, len);

- Eric

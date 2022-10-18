Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B38601F5D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 02:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbiJRASB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 20:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbiJRAPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 20:15:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB75F895E2;
        Mon, 17 Oct 2022 17:12:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 344DBB81C13;
        Tue, 18 Oct 2022 00:12:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94169C433D6;
        Tue, 18 Oct 2022 00:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666051939;
        bh=gnitjREAosEnc2q8OgrCTjC9y263oqZqF5PO1jPmfAk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q7i2DxbdEcxbhfpzWd7/PqUCedMhspOijxzXuQatS+gez7pf5cjxzCH9olhYsFZAQ
         MK2bKDWrhOMTg7eqhAuu8rFjt9KYv93+6ZjGJkYMuLI9nbF72Yv1Luia0qrfJysCsF
         mnxq5Ywwdt2Kbh25Brw2hdqK+i9N1RjnS+XpsTodn0KG6f1pzwaeJzNN4eG7LHT207
         kOGNJDpnF1RQ9ywEXzh5XN5Kb72mJZLCMwfE8RAFNDQoN4MnKMMiHOQf9SFxaImpQ6
         ZIymM2Xvkh/ew0lhZZBsxlGpQeYbbshRgyemsr+ycWZbpbH8XBCFWAOc5dbcOcZXuj
         YRew0JcmpZM9w==
Date:   Mon, 17 Oct 2022 17:12:16 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Nathan Huckleberry <nhuck@google.com>
Cc:     Bruno Goncalves <bgoncalv@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: x86/polyval - Fix crashes when keys are not
 16-byte aligned
Message-ID: <Y03vYKwgdK34Hyfh@sol.localdomain>
References: <20221017222620.715153-1-nhuck@google.com>
 <Y03fBQPM7h7+cfGK@sol.localdomain>
 <CAJkfWY5CXFQfSkM=U6u_DdLjDyLDoubqy2FeSZg5k7GBkOTnsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJkfWY5CXFQfSkM=U6u_DdLjDyLDoubqy2FeSZg5k7GBkOTnsQ@mail.gmail.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 04:38:25PM -0700, Nathan Huckleberry wrote:
> On Mon, Oct 17, 2022 at 4:02 PM Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > On Mon, Oct 17, 2022 at 03:26:20PM -0700, Nathan Huckleberry wrote:
> > > The key_powers array is not guaranteed to be 16-byte aligned, so using
> > > movaps to operate on key_powers is not allowed.
> > >
> > > Switch movaps to movups.
> > >
> > > Fixes: 34f7f6c30112 ("crypto: x86/polyval - Add PCLMULQDQ accelerated implementation of POLYVAL")
> > > Reported-by: Bruno Goncalves <bgoncalv@redhat.com>
> > > Signed-off-by: Nathan Huckleberry <nhuck@google.com>
> > > ---
> > >  arch/x86/crypto/polyval-clmulni_asm.S | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/arch/x86/crypto/polyval-clmulni_asm.S b/arch/x86/crypto/polyval-clmulni_asm.S
> > > index a6ebe4e7dd2b..32b98cb53ddf 100644
> > > --- a/arch/x86/crypto/polyval-clmulni_asm.S
> > > +++ b/arch/x86/crypto/polyval-clmulni_asm.S
> > > @@ -234,7 +234,7 @@
> > >
> > >       movups (MSG), %xmm0
> > >       pxor SUM, %xmm0
> > > -     movaps (KEY_POWERS), %xmm1
> > > +     movups (KEY_POWERS), %xmm1
> > >       schoolbook1_noload
> > >       dec BLOCKS_LEFT
> > >       addq $16, MSG
> >
> > I thought that crypto_tfm::__crt_ctx is guaranteed to be 16-byte aligned,
> > and that the x86 AES code relies on that property.
> >
> > But now I see that actually the x86 AES code manually aligns the context.
> > See aes_ctx() in arch/x86/crypto/aesni-intel_glue.c.
> >
> > Did you consider doing the same for polyval?
> 
> I'll submit a v2 aligning the tfm_ctx. I think that makes more sense
> than working on unaligned keys.
> 
> Is there a need to do the same changes on arm64? The keys are also
> unaligned there.
> 

arm64 defines ARCH_DMA_MINALIGN to 128, so I don't think the same issue applies
there.  Also the instructions used don't assume aligned addresses.

- Eric

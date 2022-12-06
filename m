Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480B5644F4B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 00:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiLFXGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 18:06:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLFXGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 18:06:42 -0500
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE872E8;
        Tue,  6 Dec 2022 15:06:40 -0800 (PST)
Date:   Tue, 06 Dec 2022 23:06:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=n8pjl.ca;
        s=protonmail; t=1670367998; x=1670627198;
        bh=xMloqDP4QENMlZA1ePPi3XtFSzSh2ooBvz2MYzvN9lw=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=O6eaIPKNcsdaaOXYA3d6lyh/+Kzu7SI84OgeVgpWffL/Y7n2vy1hJz9+ZnQY1hFii
         Unh+adwHtVd0u6KmO0GTSpFn4asXutMC7jfnvqJ1tVIUvCOSl0WOzJIOcROuIb/NnE
         T1a1mXyAWar+i/BUJMtgqS9mg+Ydpr0HuJGgvDDInPJuggG+nIUxRX0SF2YNO2k9eG
         LsWhSUGS8Yzea8ftbuvg4ralBn/7gqxNz6m7I8HDEaf8avirAfzU3j4m8awE7f3yW2
         2PDfrQyEkKOS59sY/IVg/BAL7XsJJGejKaPwGT5DUkEZki5734CBM1/sRksdMFL5W4
         LUr5vMoNNAXWg==
To:     "Elliott, Robert (Servers)" <elliott@hpe.com>
From:   Peter Lafreniere <peter@n8pjl.ca>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "ap420073@gmail.com" <ap420073@gmail.com>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "David.Laight@aculab.com" <David.Laight@aculab.com>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 10/24] crypto: x86/poly - limit FPU preemption
Message-ID: <FuRP6eq1TdvRdmbeIUM2jGr9qmB2CptLqZsWq_hVq3Bqur-pL9HX3xBLPC3iC1F6F4FT1Moi9GhPssy8MGEKO7LUKH6sA34TbV0S8K3Gn8Q=@n8pjl.ca>
In-Reply-To: <MW5PR84MB1842C2D1EA00D5EF65784E25AB179@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <20221103042740.6556-1-elliott@hpe.com> <20221116041342.3841-1-elliott@hpe.com> <20221116041342.3841-11-elliott@hpe.com> <Y3TF7/+DejcnN0eV@zx2c4.com> <Y4B/kjS0lgzdUJHG@gondor.apana.org.au> <MW5PR84MB1842C2D1EA00D5EF65784E25AB179@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
Feedback-ID: 53133685:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Subject: Re: [PATCH v4 10/24] crypto: x86/poly - limit FPU preemption
> > Perhaps we should try a different approach. How about just limiting
> > the size to 4K, and then depending on need_resched we break out of
> > the loop? Something like:
> >=20
> > if (!len)
> > return 0;
> >=20
> > kernel_fpu_begin();
> > for (;;) {
> > unsigned int chunk =3D min(len, 4096);
> >=20
> > sha1_base_do_update(desc, data, chunk, sha1_xform);
> >=20
> > len -=3D chunk;
> > data +=3D chunk;
> >=20
> > if (!len)
> > break;
> >=20
> > if (need_resched()) {
> > kernel_fpu_end();
> > cond_resched();
> > kernel_fpu_begin();
> > }
> > }
> > kernel_fpu_end();
>=20
>=20
> I implemented that conditional approach in the sha algorithms.
>=20
> The results of a boot (using sha512 for module signatures, with
> crypto extra tests enabled, comparing to sha512 with a 20 KiB
> fixed limit) are:
>=20
> sha1 cond: 14479 calls; 784256 cycles doing begin/end; longest FPU contex=
t 35828 cycles
> sha256 cond: 26763 calls; 1273570 cycles doing begin/end; longest FPU con=
text 118612 cycles
> sha512 cond: 26957 calls; 1680046 cycles doing begin/end; longest FPU con=
text 169140982 cycles
> sha512 20KiB: 161011 calls; 16232280 cycles doing begin/end; longest FPU =
context 4049644 cycles
>=20
> NOTE: I didn't have a patch in place to isolate the counts for each varia=
tion
> (ssse3 vs. avx vs. avx2) and
> - for sha512: sha512 vs. sha384
> - for sha256: sha256 vs. sha224
> so the numbers include sha256 and sha512 running twice as many tests
> as sha1.
>=20
> This approach looks very good:
> - 16% of the number of begin/end calls
> - 10% of the CPU cycles spent making the calls
> - the FPU context is held for a long time (77 ms) but only while
> it's not needed.
>=20
> That's much more efficient than releasing it every 30 us just in case.

How recently did you make this change? I implemented this conditional=20
approach for ecb_cbc_helpers.h, but saw no changes at all to performance=20
on serpent-avx2 and twofish-avx.

kernel_fpu_{begin,end} (after the first call to begin) don't do anything=20
more than enable/disable preemption and make a few writes to the mxcsr.=20
It's likely that the above approach has the tiniest bit less overhead,=20
and it will preempt on non CONFIG_PREEMPT kernels, but nothing suggests=20
a performance uplift.

This brings us back to this question: should crypto routines be=20
preempted under PREEMPT_VOLUNTARY or not?

> I'll keep testing this to make sure RCU stalls stay away, and apply
> the approach to the other algorithms.

I missed the earlier discussions. Have you seen issues with RCU=20
stalls/latency spikes because of crypto routines? If so, what preemption=20
model were you running?
=20
> In x86, need_resched() has to deal with a PER_CPU variable, so I'm
> not sure it's worth the hassle to figure out how to do that from
> assembly code.

Leave it in c. It'll be more maintainable that way.

Cheers,
Peter Lafreniere <peter@n8pjl.ca>


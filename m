Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508BA644543
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 15:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234594AbiLFODy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 09:03:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbiLFODv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 09:03:51 -0500
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EE52A274
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 06:03:48 -0800 (PST)
Date:   Tue, 06 Dec 2022 14:03:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=n8pjl.ca;
        s=protonmail; t=1670335425; x=1670594625;
        bh=iI12qbM8aQ4mHnBTuYsibQkXVSzIxzzhq3+3w/j4qMk=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=1H7Cdv/ZMoq+ZpuB0+ArGn7ucqhPLWzCLL1VMb55DszsJ+VjInCVu/eB+B5MY3gGm
         CQD8wLteOV71sAEEPaevLcn5iKU6R6WJ454c8Ox0LfLHj7oI91xr3x8yUbL99KtbHp
         JSrf4Qy6fboVs2C0A1qjqBoJrXw+O+H8jXnaaImEoJOyCVKOhSs4m01k5c9eI3Lywy
         r/+WVCes2BaiuI/Ylue9YDvkRN6qyYSvnkK31dsvd5SH25sr//oNHHcSrwiwXQzqsj
         yz0WQwn05KKCr9onduxV1HAGOiw0+H8PZDEqkmaS6QCYa/u92JGYgVmWP5id/YKBjR
         EXEZvDft0B25w==
To:     Herbert Xu <herbert@gondor.apana.org.au>
From:   Peter Lafreniere <peter@n8pjl.ca>
Cc:     "Elliott, Robert (Servers)" <elliott@hpe.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "ap420073@gmail.com" <ap420073@gmail.com>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "David.Laight@aculab.com" <David.Laight@aculab.com>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 10/24] crypto: x86/poly - limit FPU preemption
Message-ID: <5TnEjVPNm7Eyw-GH7C0LeJJvgRSpOLb2NUshnG407s3TGTXL1lq4RpsoAMTpVGKWk7tVxDI5f2G9aH6lDbATR6QqXXkE7q54o7TUzO91ibI=@n8pjl.ca>
In-Reply-To: <Y47El6TRitHm7Xz9@gondor.apana.org.au>
References: <20221103042740.6556-1-elliott@hpe.com> <20221116041342.3841-1-elliott@hpe.com> <20221116041342.3841-11-elliott@hpe.com> <Y3TF7/+DejcnN0eV@zx2c4.com> <Y4B/kjS0lgzdUJHG@gondor.apana.org.au> <MW5PR84MB1842C2D1EA00D5EF65784E25AB179@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM> <Y4nEcV4w3eOEFYze@gondor.apana.org.au> <MW5PR84MB184215302DC8E824812D6B13AB179@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM> <Y47El6TRitHm7Xz9@gondor.apana.org.au>
Feedback-ID: 53133685:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > BTW, just a minor nit but you can delete the cond_resched() call
> > > because kernel_fpu_end()/preempt_enable() will do it anyway.
> >=20
> > That happens under
> > CONFIG_PREEMPTION=3Dy
> > (from include/Linux/preempt.h and arch/x86/include/asm/preempt.h)
> >=20
> > Is calling cond_resched() still helpful if that is not the configuratio=
n?
>=20
>=20
> Perhaps, but then again perhaps if preemption is off, maybe we
> shouldn't even bother with the 4K split. Were the initial
> warnings with or without preemption?
>=20
> Personally I don't really care since I always use preemption.
>=20
> The PREEMPT Kconfigs do provide a bit of nuance with the split
> between PREEMPT_NONE vs. PREEMPT_VOLUNTARY. But perhaps that is
> just overkill for our situation.

I was thinking about this a few days ago, and my 2=C2=A2 is that it's=20
probably best to not preempt the kernel in the middle of a crypto=20
operation under PREEMPT_VOLUNTARY. We're already not preempting during=20
these operations, and there haven't been complaints of excessive latency=20
because of these crypto operations.

If we skip the kernel_fpu_{begin,end} pair when not under=20
CONFIG_PREEMPT, we'll save a significant cycle count that is wasted=20
currently. See Elliot Robert's numbers on conditional begin/end in sha=20
to see the benefits of not saving/restoring unnecessarily: "10% of the=20
CPU cycles spent making the [kernel_fpu_{begin,end}] calls".

> I'll leave it to you to decide :)

One extra thought: commit 827ee47: "crypto: x86 - add some helper macros=20
for ECB and CBC modes" makes a mention of fpu save/restore being done=20
lazily. I don't know the details, so would that change this discussion?

Thanks for listening,

Peter Lafreniere <peter@n8pjl.ca>


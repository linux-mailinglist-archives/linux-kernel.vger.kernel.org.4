Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF01168B8DC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 10:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjBFJnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 04:43:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjBFJnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 04:43:15 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F05914492
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 01:43:12 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 61CA01EC02DD;
        Mon,  6 Feb 2023 10:43:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1675676590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=7L+NbQrTX1GIntNdvb/FylhMDxVwLZcRnH3facGIP3g=;
        b=fptBgdvqD86oG4/dX5DgaD6DcNTYqubjiO/IO8AaBVGu7dJGyI8iA9s7pLvUk4Ac8dgIMr
        w7/WVWzMvdK/n64wvR98v2geHRb3N+vhZl4KKFQ311refiQap6h4TNNDrEkfoMZGjLntor
        YClvYKlcoqndwK0rDh8iPIAQSQf7/Zk=
Date:   Mon, 6 Feb 2023 10:43:05 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Kujau <lists@nerdbynature.de>,
        Juergen Gross <jgross@suse.com>,
        Michael Kelley <mikelley@microsoft.com>,
        linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: External USB disks not recognized with v6.1.8 when using Xen
Message-ID: <Y+DLqV5MfuBJRnb6@zn.tnic>
References: <4fe9541e-4d4c-2b2a-f8c8-2d34a7284930@nerdbynature.de>
 <f22551ea-0694-2838-4a3f-f60d8d93fa64@leemhuis.info>
 <8f132803-f496-f33a-d2ab-b47fd5af0b88@nerdbynature.de>
 <0f441adb-f565-7a37-d9e5-3b14f6f7aea6@suse.com>
 <f02c49da-0377-97b9-9438-9e0ddbfbcc6d@nerdbynature.de>
 <CAHk-=wg1yXaX+Ut4uctf7x1WrZ4WW9hjSCr1VACwZtkZT9frFw@mail.gmail.com>
 <Y9+tDmLAlqg37TS+@zn.tnic>
 <CAHk-=wgC_MEFnnzUGN4q9pmhxV+eFV1Oo=W2j1J69YhJF5EDtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgC_MEFnnzUGN4q9pmhxV+eFV1Oo=W2j1J69YhJF5EDtw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 05, 2023 at 12:21:42PM -0800, Linus Torvalds wrote:
> So this is the one I'd almost leave alone.
> 
> Because this is not a "there are no MTRR's" situation, this is a "I
> haven't enabled CONFIG_MTRR, so I don't _know_ if there are any MTRR's
> or not.
> 
> And returning MTRR_TYPE_UNCACHABLE will then disable things like
> largepages etc, so this change would effectively mean that if
> CONFIG_MTRR is off, it would turn off hugepage support too.

Right, if we wanted to be precise here, we would check whether the
underlying hw supports MTRRs - i.e., check CPUID bit - and if our
support for it is disabled, then we'd return UC because this is how the
MTRR-supporting hw behaves:

"If the MTRRs are disabled in implementations that support the MTRR
mechanism, the default memory type is set to uncacheable (UC)."

That's the AMD APM.

The Intel SDM has a similar wording:

"Following a hardware reset, the P6 and more recent processor families
disable all the fixed and variable MTRRs, which in effect makes all of
physical memory uncacheable."

So something like

	if (cpu_feature_enabled(X86_FEATURE_MTRR))
		return MTRR_TYPE_UNCACHABLE;
	else
		return MTRR_TYPE_INVALID;


> > @@ -721,8 +721,9 @@ int pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot)
> >         u8 mtrr, uniform;
> >
> >         mtrr = mtrr_type_lookup(addr, addr + PUD_SIZE, &uniform);
> > -       if ((mtrr != MTRR_TYPE_INVALID) && (!uniform) &&
> > -           (mtrr != MTRR_TYPE_WRBACK))
> > +       if (mtrr != MTRR_TYPE_UNCACHABLE &&
> > +           mtrr != MTRR_TYPE_WRBACK &&
> > +           !uniform)
> >                 return 0;
> 
> Here you make up for it, but I don't actually understand why these
> checks exist at all.
> 
> I *think* that what the check should do is just check for uniformity.

Looka here:

6b6378355b92 ("x86, mm: support huge KVA mappings on x86")

Ack on the uniformity aspect. The WB is fine too because "has no affect on
the PAT memory types."

And then when MTRRs are disabled, then I guess it doesn't matter for the
large page mappings anyway. I would have said that we don't really care
about MTRRs being disabled but all those new confidential computing
things do disable MTRRs. Xen too.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

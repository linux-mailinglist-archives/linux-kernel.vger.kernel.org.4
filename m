Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D241E6D8833
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 22:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbjDEU0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 16:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbjDEU0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 16:26:42 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2F94ECD
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 13:26:41 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 90B5B1EC063A;
        Wed,  5 Apr 2023 22:26:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1680726399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=o11Xdk8FQ+DXEzZFf1xZ/lehDQ5H5GG8tavpD2KrR9g=;
        b=gg6sV2/IGVbmNAK1mJMB3mAjXcCMxB9IzGspIGJeZNzR2zLxrg0FpqvmnqfVkPwJr/Tde8
        NLl1ag8UtyfPW1Ui0MrBLOzw2sGpQg8rgmRFU4EmeFYE3IFCmWvIbNuIWBXTuFc8uuwgQo
        IsuVuuY6RRCAI/Guf4BMvpjpZYCSVvY=
Date:   Wed, 5 Apr 2023 22:26:33 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v5 03/15] x86/mtrr: replace some constants with defines
Message-ID: <20230405202633.GFZC3ZeVWtmjkODYW7@fat_crate.local>
References: <20230401063652.23522-1-jgross@suse.com>
 <20230401063652.23522-4-jgross@suse.com>
 <20230403160323.GAZCr4y14GvOA4dZID@fat_crate.local>
 <1231926a-5d03-5631-a376-b0d738c7e25c@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1231926a-5d03-5631-a376-b0d738c7e25c@suse.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 09:55:59AM +0200, Juergen Gross wrote:
> On 03.04.23 18:03, Borislav Petkov wrote:
> > On Sat, Apr 01, 2023 at 08:36:40AM +0200, Juergen Gross wrote:
> > > @@ -643,10 +646,12 @@ static bool set_mtrr_var_ranges(unsigned int index, struct mtrr_var_range *vr)
> > >   	unsigned int lo, hi;
> > >   	bool changed = false;
> > > +#define BASE_MASK	(MTRR_BASE_TYPE_MASK | (size_and_mask << PAGE_SHIFT))
> > > +#define MASK_MASK	(MTRR_MASK_VALID | (size_and_mask << PAGE_SHIFT))
> > 
> > No, "MASK_MASK" is too much. :-)
> 
> Any better suggestion for the name? :-)

Looking at this again, what this is actually doing is masking out the
reserved bits. But in an unnecessarily complicated way.

What it should do, instead, is do that explicitly:

	/* Zap the reserved bits and compare only the valid fields: */
	if (((vr->base_lo & ~RESV_LOW) != (lo & ~RESV_LOW)) ||
	    ((vr->base_hi & ~RESV_HI) != (hi & ~RESV_HI)))

where

#define RESV_LOW	GENMASK_ULL(8, 11)
#define RESV_HI		GENMASK(phys_addr - 1, 63)

and then we can get rid of that size_or_mask and size_and_mask
stupidity.

I think that would simplify this variable ranges handling code a lot
more and make it pretty straightforward...

> No. The "48" is the _number_ of physical address bits, so the 64 bit address
> mask will be 0000ffff.ffffffff (48 bits set).

Uff, sorry about that. I got confused by that SIZE_OR_MASK_BITS() where
phys_addr and not phys_addr - 1 works because it the arithmetic works
with starting bit 0.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

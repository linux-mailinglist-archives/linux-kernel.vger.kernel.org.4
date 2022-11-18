Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47E762F095
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 10:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241750AbiKRJJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 04:09:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241623AbiKRJJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 04:09:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F8FF24;
        Fri, 18 Nov 2022 01:09:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 91AB0B822B2;
        Fri, 18 Nov 2022 09:09:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80552C433C1;
        Fri, 18 Nov 2022 09:09:28 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="kG38vcqX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1668762566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g17PMHi9u+4MJQGHkf/DIo9Tq+jShLtD3YJw7FV3s3I=;
        b=kG38vcqXlgsWQlQBbAL/1Y+4UK0C7RJ+oWrBZBnyAhb8C2JfoPs/tdDyrl+jl5vhLTTAyH
        2q7RAqmWrPJRUFBEWZ+gjlZfzzoefmkwIAXDncXUYqmwm3IVlilJ+peNP6e7w6a2nLDTdv
        t8vFxs8odJD1AhwfUtFgb0IX6y1onIU=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f036269c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 18 Nov 2022 09:09:25 +0000 (UTC)
Date:   Fri, 18 Nov 2022 10:09:23 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH] of: fdt: parse early params before adding bootloader
 randomness
Message-ID: <Y3dLw4TksI6hQLHP@zx2c4.com>
References: <20221105014613.113503-1-Jason@zx2c4.com>
 <CAL_JsqKA1_HV5V17mHkKn8X72c_UN2Jg=TYtJkt93YM6SSDMSg@mail.gmail.com>
 <Y2lBj1ZIdFRf9HdR@zx2c4.com>
 <cd6e153b-953f-0374-364e-af649c82d8b4@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cd6e153b-953f-0374-364e-af649c82d8b4@rasmusvillemoes.dk>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 09:33:53AM +0100, Rasmus Villemoes wrote:
> On 07/11/2022 18.34, Jason A. Donenfeld wrote:
> > On Mon, Nov 07, 2022 at 11:28:20AM -0600, Rob Herring wrote:
> >> On Fri, Nov 4, 2022 at 8:46 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >>>
> >>> FDT is examined so early that it's before the first incidental call to
> >>> parse_early_param(). This is similar to EFI, except EFI actually added
> >>> an explicitly call to parse_early_param(). Let's do the same here, so
> >>> that specifying `random.trust_bootloader=0` is not ignored.
> >>>
> >>> Fixes: d97c68d178fb ("random: treat bootloader trust toggle the same way as cpu trust toggle")
> >>> Cc: Rob Herring <robh@kernel.org>
> >>> Cc: Frank Rowand <frowand.list@gmail.com>
> >>> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> >>> ---
> >>>  drivers/of/fdt.c | 3 +++
> >>>  1 file changed, 3 insertions(+)
> >>>
> >>> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> >>> index 7b571a631639..6d959117fd4f 100644
> >>> --- a/drivers/of/fdt.c
> >>> +++ b/drivers/of/fdt.c
> >>> @@ -1195,6 +1195,9 @@ int __init early_init_dt_scan_chosen(char *cmdline)
> >>>
> >>>         rng_seed = of_get_flat_dt_prop(node, "rng-seed", &l);
> >>>         if (rng_seed && l > 0) {
> >>> +               /* Parse random.trust_bootloader if it's in command line. */
> >>> +               parse_early_param();
> >>
> >> I don't think it's good that the timing of calling this is dependent
> >> on "rng-seed" being present or not. So perhaps move it up to after the
> >> cmdline is set.
> >>
> >> Either way, the other issue is the cmdline is not necessarily fixed at
> >> this point with some architectures doing their own
> >> append/prepend/override of the cmdline. We can't seem to get common
> >> implementation there finished. I'm doubtful that corner case would
> >> actually be hit though.
> > 
> > Hm, yea. I'm actually now having second thoughts about this one too for
> > other reasons: FDT isn't the only arch that has this issue. It's also a
> > problem on x86 and m68k. Maybe the random.trust_bootloader toggle should
> > just go away, since already your bootloader can do whatever it wants to
> > the kernel it executes? Not sure; I'll think on it a bit I guess...
> 
> Well, for the FDT case it least one could preserve the ability for the
> bootloader to say "hey, here's a bunch of bytes, but I have reason to
> believe they're not as random as you'd like" by setting a boolean
> "rng-seed-is-crap" [pick a better name] property alongside the rng-seed
> property. Then the kernel logic could be CONFIG_TRUST_BOOT_LOADER &&
> !of_get_bool("rng-seed-is-crap"). Currently, the only thing the
> bootloader could do in that case is to just elide the rng-seed
> completely (or set the not-actually-working cmdline flag).

Yea I don't think we want to introduce that kind of complexity here. No
more knobs :)

Jason

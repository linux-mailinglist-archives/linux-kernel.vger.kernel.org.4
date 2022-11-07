Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B11761FB7C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 18:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbiKGReT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 12:34:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbiKGReQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 12:34:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7FA21816;
        Mon,  7 Nov 2022 09:34:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0BA2611DA;
        Mon,  7 Nov 2022 17:34:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEDD3C433D6;
        Mon,  7 Nov 2022 17:34:13 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="lVLa1BG4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1667842451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B4SMF6oVs5RRpJDRVxFyeTr9TfajDc8wD+p7wUzg6d0=;
        b=lVLa1BG4y7erbzc5C/3bpbaTgEY+pR8MFJfu8uqrcp/NRDzcASGe/cOufRrtuwEurMJo/9
        wxvX1aahpUD1jRmawKwQqQDjzXjC7CR3OwE1gbX5EA4zZpURAXV+gkQ9WlkG9pH385KqH+
        nj3t74P+vn1W/y9IueAxh6yp9xs2cfI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a4e34559 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 7 Nov 2022 17:34:10 +0000 (UTC)
Date:   Mon, 7 Nov 2022 18:34:07 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH] of: fdt: parse early params before adding bootloader
 randomness
Message-ID: <Y2lBj1ZIdFRf9HdR@zx2c4.com>
References: <20221105014613.113503-1-Jason@zx2c4.com>
 <CAL_JsqKA1_HV5V17mHkKn8X72c_UN2Jg=TYtJkt93YM6SSDMSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAL_JsqKA1_HV5V17mHkKn8X72c_UN2Jg=TYtJkt93YM6SSDMSg@mail.gmail.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 11:28:20AM -0600, Rob Herring wrote:
> On Fri, Nov 4, 2022 at 8:46 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > FDT is examined so early that it's before the first incidental call to
> > parse_early_param(). This is similar to EFI, except EFI actually added
> > an explicitly call to parse_early_param(). Let's do the same here, so
> > that specifying `random.trust_bootloader=0` is not ignored.
> >
> > Fixes: d97c68d178fb ("random: treat bootloader trust toggle the same way as cpu trust toggle")
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Frank Rowand <frowand.list@gmail.com>
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > ---
> >  drivers/of/fdt.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > index 7b571a631639..6d959117fd4f 100644
> > --- a/drivers/of/fdt.c
> > +++ b/drivers/of/fdt.c
> > @@ -1195,6 +1195,9 @@ int __init early_init_dt_scan_chosen(char *cmdline)
> >
> >         rng_seed = of_get_flat_dt_prop(node, "rng-seed", &l);
> >         if (rng_seed && l > 0) {
> > +               /* Parse random.trust_bootloader if it's in command line. */
> > +               parse_early_param();
> 
> I don't think it's good that the timing of calling this is dependent
> on "rng-seed" being present or not. So perhaps move it up to after the
> cmdline is set.
> 
> Either way, the other issue is the cmdline is not necessarily fixed at
> this point with some architectures doing their own
> append/prepend/override of the cmdline. We can't seem to get common
> implementation there finished. I'm doubtful that corner case would
> actually be hit though.

Hm, yea. I'm actually now having second thoughts about this one too for
other reasons: FDT isn't the only arch that has this issue. It's also a
problem on x86 and m68k. Maybe the random.trust_bootloader toggle should
just go away, since already your bootloader can do whatever it wants to
the kernel it executes? Not sure; I'll think on it a bit I guess...

Jason

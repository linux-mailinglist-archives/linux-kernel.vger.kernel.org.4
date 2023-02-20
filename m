Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4B669D139
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 17:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbjBTQSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 11:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbjBTQSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 11:18:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B29C1E28B;
        Mon, 20 Feb 2023 08:18:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BDA3FB80D4C;
        Mon, 20 Feb 2023 16:18:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71E6C433D2;
        Mon, 20 Feb 2023 16:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676909887;
        bh=YDdZ/aSVIgXwm24AXeuAc+sDztQxXKgMwVKTkCbhyNc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tubziPJhVTQgDfu8gZrMAfy6SzrfHWHCXqgMfhMJ67dukHh+HyIkODEJw5egy03Jy
         uqV/FFQbYwj4Uzw+7rYjOH/E5BcUbiOKMu8COpfMM2oSplSIa570KpHV276HiwY1UD
         MXTwzN+AUOYaaI3kxF2ffbL5dMRXCNHMD79OUg2cVv6LpT4FKu/1mkpeROLioVjMml
         iBkBhPHTtIPhbxpbu+KOI5aF2gszbSKXKT/1thSVjtsr3FMRpc2xZftc8uqZ8Ddw0H
         Kymxq73jEnd7bQ7x8Xvh9KvNOhDHGKPaO3kFPE+xXdWzr7LpsPNXGZMiqvz1IEXSgw
         60ja7dqyCUjxA==
Date:   Mon, 20 Feb 2023 08:21:37 -0800
From:   Bjorn Andersson <andersson@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, mka@chromium.org
Subject: Re: [PATCH v3 1/2] clk: Add generic sync_state callback for
 disabling unused clocks
Message-ID: <20230220162137.xjeowlc4qd3rtzc2@ripper>
References: <20221227204528.1899863-1-abel.vesa@linaro.org>
 <ebc257025ebd641e624ef506ea09c800.sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebc257025ebd641e624ef506ea09c800.sboyd@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 09:38:22PM -0800, Stephen Boyd wrote:
> Quoting Abel Vesa (2022-12-27 12:45:27)
> > There are unused clocks that need to remain untouched by clk_disable_unused,
> > and most likely could be disabled later on sync_state. So provide a generic
> > sync_state callback for the clock providers that register such clocks.
> > Then, use the same mechanism as clk_disable_unused from that generic
> > callback, but pass the device to make sure only the clocks belonging to
> > the current clock provider get disabled, if unused. Also, during the
> > default clk_disable_unused, if the driver that registered the clock has
> > the generic clk_sync_state_disable_unused callback set for sync_state,
> > skip disabling its clocks.
> 
> How does that avoid disabling clks randomly in the clk tree? I'm
> concerned about disabling an unused clk in the middle of the tree
> because it doesn't have a driver using sync state, while the clk is the
> parent of an unused clk that is backed by sync state.
> 
>    clk A -->  clk B 
> 
> clk A: No sync state
> clk B: sync state
> 
> clk B is left on by the bootloader. __clk_disable_unused(NULL) is called
> from late init. Imagine clk A is the root of the tree.
> 
> 	clk_disable_unused_subtree(clk_core A)
> 	  clk_disable_unused_subtree(clk_core B)
> 	    if (from_sync_state && core->dev != dev)
> 	      return;
> 	  ...
> 	  clk core A->ops->disable()
> 
> clk core B is off now?
> 

I will have to give this some more thought. But this is exactly what we
have today; consider A being any builtin clock driver and B being any
clock driver built as modules, with relationship to A.

clk_disable_unused() will take down A without waiting for B, possibly
locking up parts of the clock hardware of B; or turning off the clocks
to IP blocks that rely on those clocks (e.g. display).

So my thought on this is that I don't think this patch negatively alter
the situation. But as it isn't recursive, this remains a problem that
needs to be fixed.

> Also sync_state seems broken right now. I saw mka mentioned that if you
> have a device node enabled in your DT but never enable a driver for it
> in the kernel we'll never get sync_state called. This is another
> problem, but it concerns me that sync_state would make the unused clk
> disabling happen at some random time or not at all.
> 

I don't think that sync_state is "broken".

There is no way to distinguish a driver not being built in, or a driver
being built as module but not yet loaded. The approach taken by
sync_state currently is optimistically speculative.

One alternative to this is found in the regulator framework, where we
have a 30 second timer triggering the late disable. The result of this
is that every time I end up in the ramdisk console because "root file
system can't be mounted", I have 25 second to figure out what the
problem is before the backlight goes out...

As such I do prefer the optimistic approach...

> Can the problem be approached more directly? If this is about fixing
> continuous splash screen, then I wonder why we can't list out the clks
> that we know are enabled by the bootloader in some new DT binding, e.g.:
> 
> 	clock-controller {
> 		#clock-cells = <1>;
> 		boot-handoff-clocks = <&consumer_device "clock cells for this clk provider">;
> 	};
> 

I was under the impression that we have ruled out this approach.

Presumably this list should not be a manually maintained list of display
clocks, and that means the bootloader would need to go in and  build
this list of all enabled clocks. I don't think this is practical.

> Then mark those as "critical/don't turn off" all the way up the clk tree
> when the clk driver probes by essentially incrementing the
> prepare/enable count but not actually touching the hardware, and when
> the clks are acquired by clk_get() for that device that's using them
> from boot we make the first clk_prepare_enable() do nothing and not
> increment the count at all. We can probably stick some flag into the
> 'struct clk' for this when we create the handle in clk_get() so that the
> prepare and enable functions can special case and skip over.
> 

The benefit of sync_state is that it kicks when the client drivers has
probed. As such, you can have e.g. the display driver clk_get(), then
probe defer on some other resource, and the clock state can remain
untouched.

> The sync_state hook operates on a driver level, which is too large when
> you consider that a single clk driver may register hundreds of clks that
> are not related. We want to target a solution at the clk level so that
> any damage from keeping on all the clks provided by the controller is
> limited to just the drivers that aren't probed and ready to handle their
> clks. If sync_state could be called whenever a clk consumer consumes a
> clk it may work? Technically we already have that by the clk_hw_provider
> function but there isn't enough information being passed there, like the
> getting device.
> 

The current solution already operates on all clocks of all drivers, that
happens to be probed at late_initcall(). This patch removes the
subordinate clause from this, allowing clock drivers and their clients
to be built as modules.

So while it still operates on all clocks of a driver, it moves that
point to a later stage, where that is more reasonable to do.



It would probably (haven't considered all aspects) if sync_state could
prune the tree gradually, disabling the branches that are fully probed.

But it wouldn't affect Matthias problem; e.g. if you forget to build the
venus driver, sync_state won't happen for that branch of the tree.
(Something that is arguably better than leaving all the clocks for that
driver enabled)

Regards,
Bjorn

> > diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> > index 842e72a5348f..cf1adfeaf257 100644
> > --- a/include/linux/clk-provider.h
> > +++ b/include/linux/clk-provider.h
> > @@ -720,6 +720,7 @@ struct clk *clk_register_divider_table(struct device *dev, const char *name,
> >                 void __iomem *reg, u8 shift, u8 width,
> >                 u8 clk_divider_flags, const struct clk_div_table *table,
> >                 spinlock_t *lock);
> > +void clk_sync_state_disable_unused(struct device *dev);
> 
> This is a weird place to put this. Why not in the helper functions
> section?
> 
> >  /**
> >   * clk_register_divider - register a divider clock with the clock framework
> >   * @dev: device registering this clock

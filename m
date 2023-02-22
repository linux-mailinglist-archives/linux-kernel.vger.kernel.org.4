Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC29269F7CE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 16:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbjBVPax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 10:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbjBVPav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 10:30:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7C837717;
        Wed, 22 Feb 2023 07:30:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3FB59B815C8;
        Wed, 22 Feb 2023 15:30:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D24DC433EF;
        Wed, 22 Feb 2023 15:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677079848;
        bh=sVA1o6wuZ1GuHVS6IClOur8oHR2t+TgMPfwchaZ/ukY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HFT/uVzgMAdaFzkRP6JDiqxxeeMAdaXOg08SZpb2Kd9YlbMkzwMySkFidRt1+4aNx
         Z2s7XATzX5My3+jVmMjgjuczcRS+HQPIaK6LaD8Sno5ciT2jOH99IzqkUXuVhBMCMl
         d9aD+jtLVyBOklarS2abWH0t4PkpfZx22wy/+oXSvCtCrr680zkghGjPFb7Iaxf/m7
         O1ztmVAp8LXoc+evmDRcZ9iwTTxvS9/gNVe1VWDha7Spudl1Dv5IYOTJHMXwh0zwZI
         UBj47MJ1y27tg1ZKQQCAkBrufe5moTGG4QJOTqJByenQlxPL09XLCBxmNZdL5NVqIm
         p+M/lApgtcoRA==
Date:   Wed, 22 Feb 2023 07:34:15 -0800
From:   Bjorn Andersson <andersson@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, mka@chromium.org,
        Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH v3 1/2] clk: Add generic sync_state callback for
 disabling unused clocks
Message-ID: <20230222153415.5npe4axg4mupzvw4@ripper>
References: <20221227204528.1899863-1-abel.vesa@linaro.org>
 <ebc257025ebd641e624ef506ea09c800.sboyd@kernel.org>
 <20230220162137.xjeowlc4qd3rtzc2@ripper>
 <6a3204bcd2a192c866c0fc66fed9786f.sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a3204bcd2a192c866c0fc66fed9786f.sboyd@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 11:24:36AM -0800, Stephen Boyd wrote:
> Quoting Bjorn Andersson (2023-02-20 08:21:37)
> > On Fri, Feb 17, 2023 at 09:38:22PM -0800, Stephen Boyd wrote:
> > > Quoting Abel Vesa (2022-12-27 12:45:27)
> > > > There are unused clocks that need to remain untouched by clk_disable_unused,
> > > > and most likely could be disabled later on sync_state. So provide a generic
> > > > sync_state callback for the clock providers that register such clocks.
> > > > Then, use the same mechanism as clk_disable_unused from that generic
> > > > callback, but pass the device to make sure only the clocks belonging to
> > > > the current clock provider get disabled, if unused. Also, during the
> > > > default clk_disable_unused, if the driver that registered the clock has
> > > > the generic clk_sync_state_disable_unused callback set for sync_state,
> > > > skip disabling its clocks.
> > > 
> > > How does that avoid disabling clks randomly in the clk tree? I'm
> > > concerned about disabling an unused clk in the middle of the tree
> > > because it doesn't have a driver using sync state, while the clk is the
> > > parent of an unused clk that is backed by sync state.
> > > 
> > >    clk A -->  clk B 
> > > 
> > > clk A: No sync state
> > > clk B: sync state
> > > 
> > > clk B is left on by the bootloader. __clk_disable_unused(NULL) is called
> > > from late init. Imagine clk A is the root of the tree.
> > > 
> > >       clk_disable_unused_subtree(clk_core A)
> > >         clk_disable_unused_subtree(clk_core B)
> > >           if (from_sync_state && core->dev != dev)
> > >             return;
> > >         ...
> > >         clk core A->ops->disable()
> > > 
> > > clk core B is off now?
> > > 
> > 
> > I will have to give this some more thought. But this is exactly what we
> > have today; consider A being any builtin clock driver and B being any
> > clock driver built as modules, with relationship to A.
> > 
> > clk_disable_unused() will take down A without waiting for B, possibly
> > locking up parts of the clock hardware of B; or turning off the clocks
> > to IP blocks that rely on those clocks (e.g. display).
> 
> Oh, thanks for clarifying! Yes, the disabling of unused clks with
> respect to modules is broken in the same way. This makes that brokenness
> equally apply to builtin drivers, making the situation worse, not better.
> 

It does indeed improve the situation, because it allow us to have clock
drivers and consumers as modules without having their clocks disabled
prematurely (or by chance not be disabled ever).

But it does come at the cost of disabling unused clocks later, or if the
system doesn't probe all enabled devices, possibly never.

[..]
> > 
> > Presumably this list should not be a manually maintained list of display
> > clocks, and that means the bootloader would need to go in and  build
> > this list of all enabled clocks. I don't think this is practical.
> 
> Why does the bootloader need to do that? The devicetree author can list
> out the clks that they want to keep on for the display driver until the
> display driver can acquire them.
> 

I don't think maintaining this list is either necessary or the solution
to our problem. But if we need it, I don't think the list of clock which
happens to be needed for the author to boot his particular build of
Linux is sufficient "hardware description".

We need to solve the ordering issue, because we do want as many clock
drivers built as modules as possible, and anything shutting down
seemingly unused clocks at late_initcall() is causing problems, beyond
display.

> > 
> > > Then mark those as "critical/don't turn off" all the way up the clk tree
> > > when the clk driver probes by essentially incrementing the
> > > prepare/enable count but not actually touching the hardware, and when
> > > the clks are acquired by clk_get() for that device that's using them
> > > from boot we make the first clk_prepare_enable() do nothing and not
> > > increment the count at all. We can probably stick some flag into the
> > > 'struct clk' for this when we create the handle in clk_get() so that the
> > > prepare and enable functions can special case and skip over.
> > > 
> > 
> > The benefit of sync_state is that it kicks when the client drivers has
> > probed. As such, you can have e.g. the display driver clk_get(), then
> > probe defer on some other resource, and the clock state can remain
> > untouched.
> 
> Ok. I think this spitball design would do that still. It's not like we
> would go and disable the clks that are handed to the display driver even
> if it probe defers. The clk would be marked as enabled until the display
> driver enables the clk, and then it wouldn't be disabled during late
> init (or later) because the clk would be enabled either by the core or
> by the display driver. The point where we transfer ownership of the
> enable state is when the consumer calls clk_enable().
> 

You're right, and if a driver where to acquire a clock enable/disable it
and then probe defer, the sync_state mechanism wouldn't help us anyways.

But we need something that kicks in and disables unused clocks whenever
there will be no more consumers. Regardless if the list of resources to
do this with is defined my human, machine or derived from something.

> > 
> > > The sync_state hook operates on a driver level, which is too large when
> > > you consider that a single clk driver may register hundreds of clks that
> > > are not related. We want to target a solution at the clk level so that
> > > any damage from keeping on all the clks provided by the controller is
> > > limited to just the drivers that aren't probed and ready to handle their
> > > clks. If sync_state could be called whenever a clk consumer consumes a
> > > clk it may work? Technically we already have that by the clk_hw_provider
> > > function but there isn't enough information being passed there, like the
> > > getting device.
> > > 
> > 
> > The current solution already operates on all clocks of all drivers, that
> > happens to be probed at late_initcall(). This patch removes the
> > subordinate clause from this, allowing clock drivers and their clients
> > to be built as modules.
> > 
> > So while it still operates on all clocks of a driver, it moves that
> > point to a later stage, where that is more reasonable to do.
> > 
> 
> When we have clk drivers that provide clks to many different device
> drivers, they all have to probe for any unused clks to be disabled.
> 

I would prefer that we go to a mechanism where we disable all unused
clocks per provider, based on sync_state, and then from there try to
optimize that to disable subsets of those clocks a few seconds
earlier. Because upstream is broken by design right now.

I've reverted the applies patches, and sent a new pull request. Let's
try to make some progress on Saravana's proposal.

Regards,
Bjorn

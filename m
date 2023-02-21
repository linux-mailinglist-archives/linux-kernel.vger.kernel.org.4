Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9534169E831
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 20:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjBUTYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 14:24:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjBUTYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 14:24:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FADB222E1;
        Tue, 21 Feb 2023 11:24:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71AE461154;
        Tue, 21 Feb 2023 19:24:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD024C433D2;
        Tue, 21 Feb 2023 19:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677007478;
        bh=SVvDHc0qGNcu3rq+fjx1pMniD9fkjjNcNi6nKilrenI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=WTA34HZt6x2fTzszpFqPniHpP6YFOzR2m/+STcU0HN1k/QfFKC4H0vXWEaqZU3Nkt
         /VXkF+3QaPq6CSG2MmGw35gTwPvQHRSZMSKTryWglAhWtB+ZBtXV6YFr4zUdchXOXN
         wBopI5pyE2hFfB/FZw7TZzK3sfY96MD+2A6XNN4xTSfTGtxf/WOOvT59BHNc7rKILR
         liBLEn4sCnYDS6y+p+QUnnCmcs/PygKUNco6ju4aE6bYHnKZOHKPkm1Mxurff/ywCH
         lI3dCfwEVNibsLNIt3NkfKisCOMOV0fYH9yaWjyKOGfPHablgegL/20xjnFyVNh0aN
         nB/WS/HoE7Osw==
Message-ID: <6a3204bcd2a192c866c0fc66fed9786f.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230220162137.xjeowlc4qd3rtzc2@ripper>
References: <20221227204528.1899863-1-abel.vesa@linaro.org> <ebc257025ebd641e624ef506ea09c800.sboyd@kernel.org> <20230220162137.xjeowlc4qd3rtzc2@ripper>
Subject: Re: [PATCH v3 1/2] clk: Add generic sync_state callback for disabling unused clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, mka@chromium.org,
        Saravana Kannan <saravanak@google.com>
To:     Bjorn Andersson <andersson@kernel.org>
Date:   Tue, 21 Feb 2023 11:24:36 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2023-02-20 08:21:37)
> On Fri, Feb 17, 2023 at 09:38:22PM -0800, Stephen Boyd wrote:
> > Quoting Abel Vesa (2022-12-27 12:45:27)
> > > There are unused clocks that need to remain untouched by clk_disable_=
unused,
> > > and most likely could be disabled later on sync_state. So provide a g=
eneric
> > > sync_state callback for the clock providers that register such clocks.
> > > Then, use the same mechanism as clk_disable_unused from that generic
> > > callback, but pass the device to make sure only the clocks belonging =
to
> > > the current clock provider get disabled, if unused. Also, during the
> > > default clk_disable_unused, if the driver that registered the clock h=
as
> > > the generic clk_sync_state_disable_unused callback set for sync_state,
> > > skip disabling its clocks.
> >=20
> > How does that avoid disabling clks randomly in the clk tree? I'm
> > concerned about disabling an unused clk in the middle of the tree
> > because it doesn't have a driver using sync state, while the clk is the
> > parent of an unused clk that is backed by sync state.
> >=20
> >    clk A -->  clk B=20
> >=20
> > clk A: No sync state
> > clk B: sync state
> >=20
> > clk B is left on by the bootloader. __clk_disable_unused(NULL) is called
> > from late init. Imagine clk A is the root of the tree.
> >=20
> >       clk_disable_unused_subtree(clk_core A)
> >         clk_disable_unused_subtree(clk_core B)
> >           if (from_sync_state && core->dev !=3D dev)
> >             return;
> >         ...
> >         clk core A->ops->disable()
> >=20
> > clk core B is off now?
> >=20
>=20
> I will have to give this some more thought. But this is exactly what we
> have today; consider A being any builtin clock driver and B being any
> clock driver built as modules, with relationship to A.
>=20
> clk_disable_unused() will take down A without waiting for B, possibly
> locking up parts of the clock hardware of B; or turning off the clocks
> to IP blocks that rely on those clocks (e.g. display).

Oh, thanks for clarifying! Yes, the disabling of unused clks with
respect to modules is broken in the same way. This makes that brokenness
equally apply to builtin drivers, making the situation worse, not better.

>=20
> So my thought on this is that I don't think this patch negatively alter
> the situation. But as it isn't recursive, this remains a problem that
> needs to be fixed.
>=20
> > Also sync_state seems broken right now. I saw mka mentioned that if you
> > have a device node enabled in your DT but never enable a driver for it
> > in the kernel we'll never get sync_state called. This is another
> > problem, but it concerns me that sync_state would make the unused clk
> > disabling happen at some random time or not at all.
> >=20
>=20
> I don't think that sync_state is "broken".
>=20
> There is no way to distinguish a driver not being built in, or a driver
> being built as module but not yet loaded. The approach taken by
> sync_state currently is optimistically speculative.
>=20
> One alternative to this is found in the regulator framework, where we
> have a 30 second timer triggering the late disable. The result of this
> is that every time I end up in the ramdisk console because "root file
> system can't be mounted", I have 25 second to figure out what the
> problem is before the backlight goes out...
>=20
> As such I do prefer the optimistic approach...
>=20
> > Can the problem be approached more directly? If this is about fixing
> > continuous splash screen, then I wonder why we can't list out the clks
> > that we know are enabled by the bootloader in some new DT binding, e.g.:
> >=20
> >       clock-controller {
> >               #clock-cells =3D <1>;
> >               boot-handoff-clocks =3D <&consumer_device "clock cells fo=
r this clk provider">;
> >       };
> >=20
>=20
> I was under the impression that we have ruled out this approach.

Where did we rule it out? I suppose we already have this information if
we search the DT for 'clocks' properties and read the clk hardware at
boot to see if it is enabled. Putting these two things together gets us
all the enabled clks at boot that are consumed by device nodes. It
doesn't tell use about anything not consumed in DT, or handle overlays,
but if we have that problem we can probably figure something out later.

>=20
> Presumably this list should not be a manually maintained list of display
> clocks, and that means the bootloader would need to go in and  build
> this list of all enabled clocks. I don't think this is practical.

Why does the bootloader need to do that? The devicetree author can list
out the clks that they want to keep on for the display driver until the
display driver can acquire them.

>=20
> > Then mark those as "critical/don't turn off" all the way up the clk tree
> > when the clk driver probes by essentially incrementing the
> > prepare/enable count but not actually touching the hardware, and when
> > the clks are acquired by clk_get() for that device that's using them
> > from boot we make the first clk_prepare_enable() do nothing and not
> > increment the count at all. We can probably stick some flag into the
> > 'struct clk' for this when we create the handle in clk_get() so that the
> > prepare and enable functions can special case and skip over.
> >=20
>=20
> The benefit of sync_state is that it kicks when the client drivers has
> probed. As such, you can have e.g. the display driver clk_get(), then
> probe defer on some other resource, and the clock state can remain
> untouched.

Ok. I think this spitball design would do that still. It's not like we
would go and disable the clks that are handed to the display driver even
if it probe defers. The clk would be marked as enabled until the display
driver enables the clk, and then it wouldn't be disabled during late
init (or later) because the clk would be enabled either by the core or
by the display driver. The point where we transfer ownership of the
enable state is when the consumer calls clk_enable().

>=20
> > The sync_state hook operates on a driver level, which is too large when
> > you consider that a single clk driver may register hundreds of clks that
> > are not related. We want to target a solution at the clk level so that
> > any damage from keeping on all the clks provided by the controller is
> > limited to just the drivers that aren't probed and ready to handle their
> > clks. If sync_state could be called whenever a clk consumer consumes a
> > clk it may work? Technically we already have that by the clk_hw_provider
> > function but there isn't enough information being passed there, like the
> > getting device.
> >=20
>=20
> The current solution already operates on all clocks of all drivers, that
> happens to be probed at late_initcall(). This patch removes the
> subordinate clause from this, allowing clock drivers and their clients
> to be built as modules.
>=20
> So while it still operates on all clocks of a driver, it moves that
> point to a later stage, where that is more reasonable to do.
>=20

When we have clk drivers that provide clks to many different device
drivers, they all have to probe for any unused clks to be disabled.

>=20
>=20
> It would probably (haven't considered all aspects) if sync_state could
> prune the tree gradually, disabling the branches that are fully probed.
>=20
> But it wouldn't affect Matthias problem; e.g. if you forget to build the
> venus driver, sync_state won't happen for that branch of the tree.
> (Something that is arguably better than leaving all the clocks for that
> driver enabled)
>=20

I didn't follow this part.

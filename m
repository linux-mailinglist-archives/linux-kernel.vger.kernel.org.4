Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6B869E7CF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 19:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjBUSob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 13:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjBUSo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 13:44:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93E220068;
        Tue, 21 Feb 2023 10:44:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64208B81052;
        Tue, 21 Feb 2023 18:44:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2049CC433EF;
        Tue, 21 Feb 2023 18:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677005062;
        bh=XnLl9WgTt/7cEYyeLY/yPY03O4OnlgByjW82FJCgZWs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=lpJOaSmfsw8K8OoaOvh7YV2ow3JnO/jNifbkSEaLFDjwcB+y5S02IiYwLus0ei61K
         6Sc+FoyjEq/gucfPpXX5FxAajP7nuZiic1ZZMKvHjM2VCwshiJT9V2Qb9/iumwt64c
         Zf8txOmhh+qwbcmK7RIuBIREXM/YWW0xobpbBa4ckuvhPeFYTo+q2as90QGRho65+2
         WlbRNlpFm7yonSUOnmO8ZQIC/M2h77Ta20vHZD8UzBZrQ4kC96nFeRlLeVpQexgtBf
         zKPu2jIYQAolt2nl5s5pnRhUM6C66mw2waRbLIWERmYsdv5D8Bjh+sojhGaVzb1ALp
         BAv1eY0ObbkTg==
Message-ID: <0cbf23f481ebb50f955001d6e845a165.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Y/OV3CF0ootyooDJ@linaro.org>
References: <20221227204528.1899863-1-abel.vesa@linaro.org> <ebc257025ebd641e624ef506ea09c800.sboyd@kernel.org> <Y/OV3CF0ootyooDJ@linaro.org>
Subject: Re: [PATCH v3 1/2] clk: Add generic sync_state callback for disabling unused clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, mka@chromium.org,
        Saravana Kannan <saravanak@google.com>
To:     Abel Vesa <abel.vesa@linaro.org>
Date:   Tue, 21 Feb 2023 10:44:19 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2023-02-20 07:46:36)
> On 23-02-17 21:38:22, Stephen Boyd wrote:
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
>=20
> Yes, that is correct. But the same thing is happening currently if the
> clk_ignore_unused in not specified.

The existing code traverses the clk tree in depth-first order, disabling
clks from the leaves up to the root. This breaks that tree walk. It is
not the same thing.

> At least with this new approach, we
> get to leave unused clocks enabled either until sync_state is called or f=
orever.
> All the provider has to do is to implement a sync_state callback (or use
> the generic one provided). So the provider of clk A would obviously need
> a sync state callback registered.

Sure.

>=20
> >=20
> > Also sync_state seems broken right now. I saw mka mentioned that if you
> > have a device node enabled in your DT but never enable a driver for it
> > in the kernel we'll never get sync_state called. This is another
> > problem, but it concerns me that sync_state would make the unused clk
> > disabling happen at some random time or not at all.
>=20
> Well, the fact that the sync state not being called because a driver for
> a consumer device doesn't probe does not really mean it is broken. Just
> because the consumer driver hasn't probed yet, doesn't mean it will
> not probe later on.
>=20
> That aside, rather than going with clk_ignore_unused all the time on
> qcom platforms, at least in a perfect scenario (where sync state is
> reached for all providers) the clocks get disabled.

The clks will get disabled in some random order though even if every clk
provider has sync_state.

>=20
> >=20
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
> > Then mark those as "critical/don't turn off" all the way up the clk tree
> > when the clk driver probes by essentially incrementing the
> > prepare/enable count but not actually touching the hardware, and when
> > the clks are acquired by clk_get() for that device that's using them
> > from boot we make the first clk_prepare_enable() do nothing and not
> > increment the count at all. We can probably stick some flag into the
> > 'struct clk' for this when we create the handle in clk_get() so that the
> > prepare and enable functions can special case and skip over.
>=20
> Well, that means we need to play whack-a-mole by alsways adding such cloc=
ks to
> devicetree.

I don't think the bootloader is constantly changing. Either we want to
hand off the enable state to devices that are using them from boot, or
we don't. I doubt that is changing outside of bootloader development
time.

>=20
> >=20
> > The sync_state hook operates on a driver level, which is too large when
> > you consider that a single clk driver may register hundreds of clks that
> > are not related. We want to target a solution at the clk level so that
> > any damage from keeping on all the clks provided by the controller is
> > limited to just the drivers that aren't probed and ready to handle their
> > clks. If sync_state could be called whenever a clk consumer consumes a
> > clk it may work? Technically we already have that by the clk_hw_provider
> > function but there isn't enough information being passed there, like the
> > getting device.
>=20
> Actually, from the multitude of clocks registered by one provider, the
> ones already explicitely enabled (and obvisously their parents) by thier
> consumer are safe. The only ones we need to worry about are the ones that
> might be enabled by bootloader and need to remain on. With the sync state
> approach, the latter mentioned clocks will either remain on indefinitely
> or will be disabled on sync state. The provider driver is the only level
> that has a registered sync state callback.
>=20

The driver has sync_state callback, yes. I'm saying that it is too wide
of a scope to implement disabling unused clks via the sync_state
callback.

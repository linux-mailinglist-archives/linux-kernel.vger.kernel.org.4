Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB846CF34B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 21:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjC2Tkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 15:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjC2TkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 15:40:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19735B85;
        Wed, 29 Mar 2023 12:40:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D593B82420;
        Wed, 29 Mar 2023 19:40:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2669EC433D2;
        Wed, 29 Mar 2023 19:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680118814;
        bh=BtG4oqNmADwt5o9uZUmgM6fpSmVLSH3rtIqCqd4+adA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=N1GOz6yrQJX00eVR89tJylqHm2CqiTkx2Q9Mq2NM935ANeB2+1qto38TrFwXE+L/v
         2/foqde7tR1RwTTjv7ktC/u50OdzOWecANajdKq2Fxgk3rgSfYxvkJKwBc5bUI7BBa
         rrItLrBxr0/t+dkjtcWBBMooQo+0YqRvHDkyUGiYh0T3p/7sK56VmO4kFY2izMu4Cw
         XYx24VPCClbc2tORMfhEk6wiwfMkmNzZGOF9HJaK6rzOfTbn9IRFtKfO4WZFRfGZ+r
         Ar/wXHb4WflmIkti3QspgbB2fPYTDtB/rfXqa2ZyXCu6+pNsbmtZk62Xm0D9Rf48eV
         1VO9LpyKLKJ9w==
Message-ID: <21bc62c2356392be72e884785055d027.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230117175553.fedlob24udnhgdkn@pengutronix.de>
References: <20220913102141.971148-1-m.felsch@pengutronix.de> <20221005082348.v43xbjrhbdlbaohv@pengutronix.de> <20221005230609.5BA04C433D6@smtp.kernel.org> <20230117175553.fedlob24udnhgdkn@pengutronix.de>
Subject: Re: [RFC PATCH 0/2] Propose critical clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     abel.vesa@linaro.org, abelvesa@kernel.org, festevam@gmail.com,
        kernel@pengutronix.de, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org,
        Peng Fan <peng.fan@nxp.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, Marek Vasut <marex@denx.de>
To:     Marco Felsch <m.felsch@pengutronix.de>
Date:   Wed, 29 Mar 2023 12:40:12 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Marco Felsch (2023-01-17 09:55:53)
> Hi Stephen,
>=20
> sorry for the delay.

Sorry for my delay as well. I dread this topic!

>=20
> On 22-10-05, Stephen Boyd wrote:
> > Quoting Marco Felsch (2022-10-05 01:23:48)
> > > Hi Stephen, Michael,
> > >=20
> > > I know it is a busy time right now, but maybe you have a few minutes =
for
> > > this RFC. I know it is incomplete, but the interessting part is there
> > > and it would fix a real issue we encountered on the imx8mm-evk's.
> > >=20
> >=20
> > There's another approach by Marek[1]. Can you work together on a
> > solution? I think we should step away from trying to make the critical
> > flag work during clk registration, and turn on the clk during provider
> > registration instead. That hopefully makes it simpler. We can keep the
> > clk flag of course, so that the clk can't be turned off, but otherwise
> > we shouldn't need to make registration path check for the property.
>=20
> Can you please explain your idea a bit more in detail so I can follow
> you. The whole idea of this patchset is to enable a clock and never turn
> it off. According the clk-provider.h comment this is the exact use-case
> for the CLK_IS_CRITICAL flag. For static clock provider tree's like
> soc-clock tree's this can be done by the driver by setting the
> CLK_IS_CRITICAL flag within the struct clk_init_data. Now the question
> is how I can add such a handling to "dynamic" clock providers which are
> added by system-designs e.g. an i2c-clock provider. Of course each I2C
> clock provider driver can check the flag but I wanted to make it common
> to all.
>=20

A long time ago we had a large debate about putting critical clock flag
into devicetree. During that time, we wanted an 'always-on' sort of
binding[1] that told the clk framework to turn on the clk and leave it
on forever. In fact, there was a binding and everything[2] but it didn't
get merged. I don't want to drag Maxime into this thread again, but we
need a summary of these old threads to make sure we're not falling into
the traps they describe[3].

I admit I don't want to spend my time re-reading these huge threads, but
I may have to because I don't recall all the details anymore about why
we were so opposed to critical clocks or always on clocks as a DT
binding. I think it was because we were concerned about abuse by DT
authors and getting stuck using old DTBs with newer kernels that have
drivers that want to start gating clks. I'm not sure that is a real
concern anymore though. If you have a driver that starts getting clks
that have been marked as always-on in the DT you would probably remove
them from the always-on list at the same time as adding the new node
that consumes those clocks.

Furthermore, back then I recall it was decided that the CLK_IS_CRITICAL
flag should only be set in software, so that it can be removed later on.
The fear was that we may have to live with old DTBs forever, so having a
property that said we must keep some clk enabled forever may run into
some problem. And the argument was that critical clks was a software
design of the Linux kernel, not something that DT cares about, so
putting a hint for that mechanism into the DT was wrong. I don't see how
this argument holds up when you have an external to the SoC clk (i.e.
not a memory controller or CPU clk) that needs to be always on in some
board designs and turned off in other board designs. The SoC clk driver
isn't going to know what to do with the external clk.

This is why I'm leaning towards avoiding the CLK_IS_CRITICAL flag and
implementing an "always-on" binding. The historical baggage with the
critical flag is too large to overcome. Writing that the clk is
always-on in the binding doesn't imply that it is "critical" as strongly
as having the word critical in the property name. It just means that the
clk is always on.

I kept reading the other thread[4] and I see that there was yet another
idea for a binding/feature that said "keep this clock on until a driver
claims it". I suspect we should implement that sort of logic for all
clks, so that we hand off the enable state from boot properly. This gets
into the sync_state stuff from Abel Vesa, and reworking disable unused
so that it doesn't get called early.

I hope this always-on property isn't being used to workaround the
disable unused logic. Instead, it should be used to indicate that some
clk must always be on and that child clks shouldn't be turning it on and
off when they turn themselves on and off. Show a real need for this, Cc
the folks involved in the 8 years ago discussions, and I think it will
work out.

BTW, this is similar to CLK_SET_RATE_PARENT, which we haven't put into
DT as a property. Eventually we modified the clk.h API to have rate
locking so that the flag could be set on clks but the parent rate would
be "locked" ensuring the frequency doesn't change when the child changes
rates. We may need to add a DT binding for rate/parent locking in the
future though if we want to make sure parents don't change or
frequencies don't change for a particular clk that is generated by some
i2c chip or some external to the SoC clk.

[1] https://lore.kernel.org/all/20151001195653.GL7104@lukather/
[2] https://lore.kernel.org/all/1428432239-4114-5-git-send-email-lee.jones@=
linaro.org/
[3] https://lore.kernel.org/all/20150422093446.GA28007@lukather/
[4] https://lore.kernel.org/all/20150811091146.GB13374@x1/

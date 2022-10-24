Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97D0609AC0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 08:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiJXGvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 02:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiJXGvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 02:51:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E37748CA3;
        Sun, 23 Oct 2022 23:51:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20E4FB80ED4;
        Mon, 24 Oct 2022 06:51:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07951C433D7;
        Mon, 24 Oct 2022 06:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666594269;
        bh=VfgOEi8uV7y5OEJiq7APLWjtfyJvuKRFZf3WePzO+t8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ij+xhdrztODC7PA0QWXx4+cpgBqXxtMDlZ0TXynOPKub/yrmZrAUEMhmcGgKItgj5
         Tor9CS8FeDOSRQET4jdC9Ucxd1wbiGeTKBZSlDKiRums3EavWX7oz0jbZr2X7kqiQS
         /wGQvWp1yuEKejLh4ikvEIziHEvg7UyvN7BMRDLymFqoJ26DJn0/QVqNInFxoFW3qI
         bdQ0zrepkqHwSNgucybQ98CHrTNlGxn3sZJdO8BA9A0fNuy0ikquSnaTl+JZK3dOjs
         EtHZSOzY+rEH04ygE+U68GFy43qCbTHsG1wROYnM3ra3pzilvw6DRA6UnChfTCBwHz
         AX2PJYK5YEnjw==
Date:   Mon, 24 Oct 2022 08:51:02 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Marcin Wojtas <mw@semihalf.com>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, hch@lst.de, jaz@semihalf.com
Subject: Re: [PATCH] ARM: dts: armada-38x: Mark devices as dma-coherent
Message-ID: <20221024085102.15712ce9@thinkpad>
In-Reply-To: <CAPv3WKdcQGqofEgV4w_iiQ7FFa0ZF=du8gK9eAD==10HhwEnUA@mail.gmail.com>
References: <20221022234024.87475-1-mw@semihalf.com>
        <Y1VX4RtzKQZHe/oO@lunn.ch>
        <Y1Vp4BdC50o9roKe@shell.armlinux.org.uk>
        <CAPv3WKdcQGqofEgV4w_iiQ7FFa0ZF=du8gK9eAD==10HhwEnUA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Oct 2022 23:30:34 +0200
Marcin Wojtas <mw@semihalf.com> wrote:

> niedz., 23 pa=C5=BA 2022 o 18:21 Russell King (Oracle)
> <linux@armlinux.org.uk> napisa=C5=82(a):
> >
> > On Sun, Oct 23, 2022 at 05:04:01PM +0200, Andrew Lunn wrote: =20
> > > On Sun, Oct 23, 2022 at 01:40:24AM +0200, Marcin Wojtas wrote: =20
> > > > Armada 38x platforms marks all devices as coherent via
> > > > mvebu_hwcc_notifier(), whereas the standard way to determine
> > > > this is by of_dma_is_coherent(). Reflect the hardware
> > > > capabilities by adding 'dma-coherent' properties to the device tree=
. =20
> > >
> > > Hi Marcin
> > >
> > > Does this need to go to -rc for 6.0? The DMA issues being reported?
> > > If so, please add a Fixed: tag. =20
> >
> > Are we absolutely sure this makes sense?
> >
> > Looking at atch/arm/mach-mvebu/coherency.c, there are dependencies
> > on stuff such as whether the kernel is in SMP mode or not (because
> > the page tables need to be appropriately marked as shared for
> > coherency with IO to work). We only enable the shared bit if we're
> > in SMP mode because (a) its difficult to do at runtime due to TLB
> > conflicts (requires switching the MMU off, rewriting the page tables
> > and switching the MMU back on), and (b) setting the shared bit for
> > CPUs that don't need it _can_ result in the CPUs basically bypassing
> > their caches and thus kill system performance.
> >
> > So, if we have Armada 38x platforms that are operated in uniprocessor
> > mode, this patch can cause havoc on such a setup.
> >
> > I would suggest utmost caution with this approach.
> > =20
>=20
> Sure. In such a case the description of 380 variant (single core)
> should remain untouched.
>=20
> We need to decide what to do with dual-CPU, i.e. Armada 385/388. How abou=
t:
> - Don't change current behavior, i.e. perform a necessary kernel
> configuration in "arm,pl310-cache" driver,
> arch/arm/mach-mvebu/coherency.c + &coherencyfab:node in DT
> - Satisfy of_dma_is_coherent() by adding `dma-coherent;` in
> armada-385.dtsi only (IMO this would describe HW properly)
> ?

It will describe HW properly, but someone running older kernel compiled
with no SMP support will see a performance drop. I wonder how many
people do that.

Marek

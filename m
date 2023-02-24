Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAEA96A2226
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 20:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjBXTKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 14:10:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBXTKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 14:10:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFB71ACD8;
        Fri, 24 Feb 2023 11:10:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14C1C61977;
        Fri, 24 Feb 2023 19:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 695FDC433EF;
        Fri, 24 Feb 2023 19:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677265816;
        bh=Beeg3L8TB4WjiSw949cuBxSUM1UYxNMXNzKYVbF+ync=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=BdBdSOO4A2TbKmfFFY9zoVy1TylXrNLt2+twn4YM4PK1c+IdoifLC1L+pDS4hUUlS
         Pd9HJylSUeuVKVVBihyraJtRI4pS2YmzEaMNzH2UukT2qpv4SXlj6GhlTFu05liCOI
         y5lY2/IZhMpzAt9b0XLM/OH+eKc6GOlZ6uYqfaYaOmjvvKCXtkLOzLL7et6nOJoWpY
         V/9TOOFaI89n/5Z4X7wjX9Tb5j31gSkqI5RAeK2XgEK3KtbxfNnZClc+zCls5kHT9T
         6s8Y28cRO+edS+8fHOeVlCjo+DlIm9zFxx+41WOPsUgHZnNkAv/BSFTnhu2l/jXE7C
         lnB5zrawdeYFQ==
Message-ID: <19ce51bd94685e2bed6cbc20467e5705.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <d2519ebc-8f71-1cf0-9ec8-a65a7f094853@loongson.cn>
References: <20221129034157.15036-1-zhuyinbo@loongson.cn> <31c690a347f858a477bbba9c838984ed.sboyd@kernel.org> <4b5fd886-57ce-01ef-8224-432898b7fb1c@loongson.cn> <8332a1cf44b01f06bdd5db9dc5d7f387.sboyd@kernel.org> <01ee3dc6-a868-fd2b-93aa-11e6bdfcc9df@loongson.cn> <9e8952c9415973dc7276185e3cdf5ae7.sboyd@kernel.org> <d92223a0-6d4c-33ea-1473-3d40bdd0ad9e@loongson.cn> <834da7dc-bb5d-3427-43e5-938e40a2d180@loongson.cn> <6c497d2d70d215a86be178fc08546f4d.sboyd@kernel.org> <d2519ebc-8f71-1cf0-9ec8-a65a7f094853@loongson.cn>
Subject: Re: [PATCH v10 2/4] clk: clk-loongson2: add clock controller driver support
From:   Stephen Boyd <sboyd@kernel.org>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Yang Li <yang.lee@linux.alibaba.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, liupeibao@loongson.cn,
        loongarch@lists.linux.dev, wanghongliang@loongson.cn,
        zhuyinbo <zhuyinbo@loongson.cn>
Date:   Fri, 24 Feb 2023 11:10:14 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting zhuyinbo (2023-02-22 18:16:49)
>=20
> =E5=9C=A8 2023/2/23 =E4=B8=8A=E5=8D=885:00, Stephen Boyd =E5=86=99=E9=81=
=93:
> > Quoting zhuyinbo (2023-02-21 21:10:14)
> >>>>> yes, the use of dts doesn't require the use of CLK_OF_DECLARE and c=
an
> >>>>> use platform_driver_register
> >>>>>
> >>>>> but my drvier not use platform_driver_register to register clk and =
use
> >>>>> CLK_OF_DECLARE to match of_clk_init.
> >>>> of_clk_init() is there to register clks that are needed for early in=
it,
> >>>> i.e. the clockevent/clocksource or the root interrupt controller
> >>>> (irqchip). Otherwise, it isn't necessary to register clks via
> >>>> of_clk_init().
> >>> okay, I got it.
> >> and,=C2=A0 the time driver=C2=A0 get clock by CCF that ask loongson2 c=
lock driver
> >> use CLK_OF_DECLARE
> >>
> >> to match of_clk_init.=C2=A0=C2=A0 because=C2=A0 the timer_probe=C2=A0 =
is very early and the
> >> timer driver was use TIMER_OF_DECLARE
> >>
> >> to match time_probe.
> >>
> > If you have a time driver that gets clks, register those early with
> > CLK_OF_DECLARE_DRIVER() and then have a platform driver for the rest of
> > the clk tree that registers clks later.
>=20
> okay, I got it.=C2=A0 and this series patch I will use platform driver.=20
> later, if the loongson2 time driver use the
>=20
> CLK_OF_DECLARE style I will make a alone time clk driver for it that=20
> use=C2=A0 CLK_OF_DECLARE_DRIVER()
>=20

It can be the same file if you want. But then it can't be a module. Up
to you what you want to do there.

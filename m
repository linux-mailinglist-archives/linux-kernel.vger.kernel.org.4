Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F7469FD52
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 22:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbjBVVBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 16:01:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbjBVVA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 16:00:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6260843919;
        Wed, 22 Feb 2023 13:00:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17419B8188D;
        Wed, 22 Feb 2023 21:00:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3343C433D2;
        Wed, 22 Feb 2023 21:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677099652;
        bh=PhUBOUnu/Py6uAl2pOs4CADrQSyz1xYDNSEEsVhDC/I=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=DpJr7k66EtPYQI9xatYOgOw+EE3B/CCLQiS0GREbShipdAQo2k+yVDNFOrSZ9HSy3
         oPNZFO7RQhLjl5Fr/ea7VW2P3MXfuoM/xqXAw1EJefmt97xtgSo9NhXRqyYA9EbEKj
         mrYW8ZTs2HmsK8V2my1FWFE1Aee9cHdwtV4ZSMgBNy0gKyEF7KYYbYDpdxCuP+FgX2
         dFuz0SfaUznSR2cFsYjXym6+EEeFijP9+N85tXppZ+FcJUNi6fCbM9otmhSdRoCIwG
         VishBR9+2nmfLbgcSc9cz7RidDf8GccP3zOLrzLNL7g1aRaDM5STkB4omyywV+VPSJ
         dpnBje/xd02Tg==
Message-ID: <6c497d2d70d215a86be178fc08546f4d.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <834da7dc-bb5d-3427-43e5-938e40a2d180@loongson.cn>
References: <20221129034157.15036-1-zhuyinbo@loongson.cn> <20221129034157.15036-2-zhuyinbo@loongson.cn> <31c690a347f858a477bbba9c838984ed.sboyd@kernel.org> <4b5fd886-57ce-01ef-8224-432898b7fb1c@loongson.cn> <8332a1cf44b01f06bdd5db9dc5d7f387.sboyd@kernel.org> <01ee3dc6-a868-fd2b-93aa-11e6bdfcc9df@loongson.cn> <9e8952c9415973dc7276185e3cdf5ae7.sboyd@kernel.org> <d92223a0-6d4c-33ea-1473-3d40bdd0ad9e@loongson.cn> <834da7dc-bb5d-3427-43e5-938e40a2d180@loongson.cn>
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
Date:   Wed, 22 Feb 2023 13:00:50 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting zhuyinbo (2023-02-21 21:10:14)
>=20
> >
> >>> yes, the use of dts doesn't require the use of CLK_OF_DECLARE and can
> >>> use platform_driver_register
> >>>
> >>> but my drvier not use platform_driver_register to register clk and use
> >>> CLK_OF_DECLARE to match of_clk_init.
> >> of_clk_init() is there to register clks that are needed for early init,
> >> i.e. the clockevent/clocksource or the root interrupt controller
> >> (irqchip). Otherwise, it isn't necessary to register clks via
> >> of_clk_init().
> > okay, I got it.
>=20
> and,=C2=A0 the time driver=C2=A0 get clock by CCF that ask loongson2 cloc=
k driver=20
> use CLK_OF_DECLARE
>=20
> to match of_clk_init.=C2=A0=C2=A0 because=C2=A0 the timer_probe=C2=A0 is =
very early and the=20
> timer driver was use TIMER_OF_DECLARE
>=20
> to match time_probe.
>=20

If you have a time driver that gets clks, register those early with
CLK_OF_DECLARE_DRIVER() and then have a platform driver for the rest of
the clk tree that registers clks later.

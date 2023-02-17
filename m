Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F60A69B55A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 23:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjBQWPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 17:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBQWPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 17:15:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306465A3B6;
        Fri, 17 Feb 2023 14:15:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFF7562071;
        Fri, 17 Feb 2023 22:15:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E96C4339C;
        Fri, 17 Feb 2023 22:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676672145;
        bh=CAwFwvxZLX8x0bqlIXBGrQ70JsVcL+a1viVjg97kZ+s=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=tqp5Xt/xckaqoCokZm2wkFFj0J4BPwv9TpLdmAqHOTievevAo8KOHXezOT+yolUyK
         Q6z3qdkdgygS9IsafThKWWBqDrVlt8OuXOb7ObGSke2N+s1Tu6ybmfZ6eQ5VOkwUO5
         2wUcvsFtDd2FMd0ZEBxLm2BHZ+sJUgE1rSTOC/pYt4vMdN4XhvvUBE+5CsyLiLCDAY
         Bx0Lk8i7+JtwwjIXbJXg9vd0bF5CyX8g+zH9awUPe5Pj19zLF921jDoFEGHSEtJQCG
         7bwEweqcXCl7pN2k8i23xLu0D9g4vHTPmKfBXhITnKuihKAoyEU4soTQVFw6bE6rgp
         Lr9TmMNMQbIBA==
Message-ID: <8332a1cf44b01f06bdd5db9dc5d7f387.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4b5fd886-57ce-01ef-8224-432898b7fb1c@loongson.cn>
References: <20221129034157.15036-1-zhuyinbo@loongson.cn> <20221129034157.15036-2-zhuyinbo@loongson.cn> <31c690a347f858a477bbba9c838984ed.sboyd@kernel.org> <4b5fd886-57ce-01ef-8224-432898b7fb1c@loongson.cn>
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
        zhuyinbo@loongson.cn
Date:   Fri, 17 Feb 2023 14:15:42 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting zhuyinbo (2023-02-14 23:35:22)
>=20
> =E5=9C=A8 2023/2/11 =E4=B8=8A=E5=8D=887:42, Stephen Boyd =E5=86=99=E9=81=
=93:
> > Quoting Yinbo Zhu (2022-11-28 19:41:55)
> >
> >> +
> >> +       mult =3D (val >> LOONGSON2_USB_FREQSCALE_SHIFT) &
> >> +                       clk_div_mask(LOONGSON2_USB_FREQSCALE_WIDTH);
> >> +
> >> +       rate =3D parent_rate * (mult + 1);
> >> +       do_div(rate, 8);
> > Why is do_div() being used?
> no expecial reason, I only want to get a result that rate divide 8.

Ok, you can use div_u64() here and simplify.

> >
>=20
> you meaning is to use clk_parent_data to rework=20
> loongson2_clk_pll_register=C2=A0 and drop
>=20
> loongson2_obtain_fixed_clk_hw ?

Yes

>=20
> >
> >> +}
> >> +
> >> +static void __init loongson2_clocks_init(struct device_node *np)
> >> +{
> >> +       struct clk_hw **hws;
> >> +       struct clk_hw_onecell_data *clk_hw_data;
> >> +       spinlock_t loongson2_clk_lock;
> >> +
> >> +       loongson2_pll_base =3D of_iomap(np, 0);
> >> +
> >> +       if (!loongson2_pll_base) {
> >> +               pr_err("clk: unable to map loongson2 clk registers\n");
> >> +               goto err;
> > return?
> sorry, I don't get it.=C2=A0 you meaning is that=C2=A0 remove "goto err".=
 Instead,=20
> add a "return".

Yes.

> >
> >> +       }
> >> +
> >> +       clk_hw_data =3D kzalloc(struct_size(clk_hw_data, hws, LOONGSON=
2_CLK_END),
> >> +                                       GFP_KERNEL);
> >> +       if (WARN_ON(!clk_hw_data))
> >> +               goto err;
[...]
> >> +
> >> +err:
> >> +       iounmap(loongson2_pll_base);
> >> +}
> >> +
> >> +CLK_OF_DECLARE(loongson2_clk, "loongson,ls2k-clk", loongson2_clocks_i=
nit);
> > Any reason this can't be a platform driver?
>=20
> For the compatible consideration of other clock controllers of=20
> Loongson-2 series in the future, the way of using dts can be
>=20
> better compatible.
>=20

Sorry that sentence doesn't make sense to me. The use of dts doesn't
require the use of CLK_OF_DECLARE.

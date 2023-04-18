Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA426E5608
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 02:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjDRAuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 20:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDRAuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 20:50:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B332D47;
        Mon, 17 Apr 2023 17:50:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D85A629EB;
        Tue, 18 Apr 2023 00:50:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA7AC433EF;
        Tue, 18 Apr 2023 00:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681779007;
        bh=ob+RguaaZGgk/yhIR3DTpFkJJlEXBdn6L7F4PQIpnG0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=fIbMQAF8HESOjo6yVwJyz+/s2Ptgu8+uHTMV1lO53oB7rzWJjvcWPpcXWD/mZlYWb
         Bq74GH7rjDEF+kMq9pjAilhKi7ja6qP7FTMi7fVVC3DxfnxIaQd4uGBBeMXvAbGmTl
         HblgCH42BShoDrRnEI3kkpMXZkIEx984HodaAWuZKdZz4aRzjss7nfDyeRLf2x/EWa
         FtQaMh7QBlt7wAwxPmMS0XQ0C06/lNslXl8W9YQkSfmlkdU7nG4Q52eoB54SIfJxN3
         V484eIUVLweT7R7DMkP+wyjalwlOXiwCpRNuq20+17XOYTjH8bkziFduGrxWCLoW3y
         a6oUEDx52OioQ==
Message-ID: <0c8891233195166d4a1b3cd858e91445.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAMhs-H9+ZthzCvqssypG8a2xKF4KFnvgz4ZfTKn6wE=ZxV29hQ@mail.gmail.com>
References: <20230321050034.1431379-1-sergio.paracuellos@gmail.com> <20230321050034.1431379-3-sergio.paracuellos@gmail.com> <2d848bc03aacb41a708ba2794eb043ff.sboyd@kernel.org> <CAMhs-H9+ZthzCvqssypG8a2xKF4KFnvgz4ZfTKn6wE=ZxV29hQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] clk: ralink: add clock and reset driver for MTMIPS SoCs
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-mips@vger.kernel.org,
        tsbogend@alpha.franken.de, john@phrozen.org,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
        mturquette@baylibre.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        devicetree@vger.kernel.org, arinc.unal@arinc9.com
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Mon, 17 Apr 2023 17:50:05 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sergio Paracuellos (2023-04-13 22:49:47)
> On Thu, Apr 13, 2023 at 8:55=E2=80=AFPM Stephen Boyd <sboyd@kernel.org> w=
rote:
> >
> > Quoting Sergio Paracuellos (2023-03-20 22:00:27)
> > > diff --git a/drivers/clk/ralink/clk-mtmips.c b/drivers/clk/ralink/clk=
-mtmips.c
> > > new file mode 100644
> > > index 000000000000..6b4b5ae9384d
> > > --- /dev/null
> > > +++ b/drivers/clk/ralink/clk-mtmips.c
> > > @@ -0,0 +1,985 @@
[...]
> >
> > > +               .name =3D _name,                                  \
> > > +               .ops =3D &(const struct clk_ops) {                \
> >
> > Make this into a named variable? Otherwise I suspect the compiler will
> > want to duplicate it.
>=20
> I am not sure if I understand this. What do you mean exactly?

	static const struct clk_ops mtmips_periph_clk_ops =3D {
		.recalc_rate =3D mtmips_pherip_clk_rate,
	};

> > > +static unsigned long rt3352_bus_recalc_rate(struct clk_hw *hw,
> > > +                                           unsigned long parent_rate)
> > > +{
> > > +       return parent_rate / 3;
> > > +}
> > > +
> > > +static unsigned long rt305x_xtal_recalc_rate(struct clk_hw *hw,
> > > +                                            unsigned long parent_rat=
e)
> > > +{
> > > +       return 40000000;
> > > +}
> >
> > Register fixed factor and fixed rate clks in software instead of
> > duplicating the code here.
>=20
> All the macros used in current code rely on the fact of having recalc
> functions so we can maintain the code shorter just using them. Is
> there a real benefit of using a fixed factor and fixed clks here?
> If possible I can avoid the duplicate here just using the same
> recalc_rate function returning the fixed stuff for both 305x and 3352
> SoCs as I am also doing for other functions.

The real benefit is less code, smaller kernel size, less maintenance
over time.

> >
> > > +       }
> > > +}
> > > +
> > > +static unsigned long rt2880_cpu_recalc_rate(struct clk_hw *hw,
> > > +                                           unsigned long xtal_clk)
> > > +{
> > > +       struct mtmips_clk *clk =3D to_mtmips_clk(hw);
> > > +       struct regmap *sysc =3D clk->priv->sysc;
> > > +       u32 t;
> > > +
> > > +       regmap_read(sysc, SYSC_REG_SYSTEM_CONFIG, &t);
> > > +       t =3D (t >> RT2880_CONFIG_CPUCLK_SHIFT) & RT2880_CONFIG_CPUCL=
K_MASK;
> > > +
> > > +       switch (t) {
> > > +       case RT2880_CONFIG_CPUCLK_250:
> > > +               return 250000000;
> > > +       case RT2880_CONFIG_CPUCLK_266:
> > > +               return 266000000;
> > > +       case RT2880_CONFIG_CPUCLK_280:
> > > +               return 280000000;
> > > +       case RT2880_CONFIG_CPUCLK_300:
> > > +               return 300000000;
> > > +       default:
> > > +               BUG();
> > > +       }
> > > +}
> > > +
> > > +static unsigned long rt2880_bus_recalc_rate(struct clk_hw *hw,
> > > +                                           unsigned long parent_rate)
> > > +{
> > > +       return parent_rate / 2;
> > > +}
> >
> > A fixed factor clk?
>=20
> As I have said, macros rely on having recalc_rate functions. Also,
> having in this way makes pretty clear the relation between the bus
> clock and its related parent as it is in the datasheet.

The macros are your own design, right? In which case, maybe you can use
CLK_HW_INIT() and friends macros instead to show the relationship
between clks in C code?

>=20
> >
> > > +
> > > +static u32 mt7620_calc_rate(u32 ref_rate, u32 mul, u32 div)
> > > +{
> > > +       u64 t;
> > > +
> > > +       t =3D ref_rate;
> > > +       t *=3D mul;
> > > +       do_div(t, div);
> >
> > Do we really need to do 64-bit math? At the least use div_u64().
>=20
> This is directly extracted from arch/mips/ralink clock code, so I have
> maintained it as it is since I don't have an mt7620 SoC based board to
> test. However using div_u64 here with t being u64 makes sense.

Does anyone have the board to test? Can we simply delete it instead?

> > > +
> > > +static unsigned long mt7620_bus_recalc_rate(struct clk_hw *hw,
> > > +                                           unsigned long parent_rate)
> > > +{
> > > +       static const u32 ocp_dividers[16] =3D {
> > > +               [CPU_SYS_CLKCFG_OCP_RATIO_2] =3D 2,
> > > +               [CPU_SYS_CLKCFG_OCP_RATIO_3] =3D 3,
> > > +               [CPU_SYS_CLKCFG_OCP_RATIO_4] =3D 4,
> > > +               [CPU_SYS_CLKCFG_OCP_RATIO_5] =3D 5,
> > > +               [CPU_SYS_CLKCFG_OCP_RATIO_10] =3D 10,
> > > +       };
> > > +       struct mtmips_clk *clk =3D to_mtmips_clk(hw);
> > > +       struct regmap *sysc =3D clk->priv->sysc;
> > > +       u32 t;
> > > +       u32 ocp_ratio;
> > > +       u32 div;
> > > +
> > > +       if (IS_ENABLED(CONFIG_USB)) {
> > > +               /*
> > > +               * When the CPU goes into sleep mode, the BUS
> > > +               * clock will be too low for USB to function properly.
> > > +               * Adjust the busses fractional divider to fix this
> > > +               */
> > > +               regmap_read(sysc, SYSC_REG_CPU_SYS_CLKCFG, &t);
> > > +               t &=3D ~(CLKCFG_FDIV_MASK | CLKCFG_FFRAC_MASK);
> > > +               t |=3D CLKCFG_FDIV_USB_VAL | CLKCFG_FFRAC_USB_VAL;
> > > +               regmap_write(sysc, SYSC_REG_CPU_SYS_CLKCFG, t);
> >
> > Why can't we do this unconditionally? And recalc_rate() shouldn't be
> > writing registers. It should be calculating the frequency of the clk
> > based on 'parent_rate' and whatever the hardware is configured for.
>=20
> This code is with IS_ENABLED(CONFIG_USB) guard in the original code so
> I have maintained it as it is. Where should it be moved into instead
> of doing the register writes in this recalc function?

Can you do it unconditionally in driver probe? Or when the clk is turned
off or on can you park it at a safe frequency?

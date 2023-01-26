Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4671667C2C6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 03:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjAZCXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 21:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjAZCXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 21:23:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870FF1A943;
        Wed, 25 Jan 2023 18:23:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EB90616FD;
        Thu, 26 Jan 2023 02:23:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A29EC433D2;
        Thu, 26 Jan 2023 02:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674699798;
        bh=ZSHEoYMnXHm5rkWCg89TQMnpvhrOeO4EoBPI9C32P/Q=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=a0Y08YUGIL0u2+uGVr7wDmGY+mI+09SavJyLiLnrXvZgHXmBEO2WcHtIZcoN659PU
         kCgf5ywphPR99bNZFEurh7Ooye0RrfL2e1dBq3vNNh0pGGPIBR/BZhSWjR6P7hikmf
         jGSBxPG4diXM70dt0DVFNnQjsuQx4zr1ItiyITfhJifqifyW61vY8PwB9xdit8RfGE
         nU7tkNfvGsMaapGiLoRLCYn6Mcek9XMSzpJXeovPMM4PggJY2DnYxOoPNwi/ABerjV
         Z7NH7TA0+wXR84j4lv8ygILN512Q0+BeeXznOEkGWpngCopDTa4vpgu3Sxs8H2GSRq
         4Zv0T6y3HSbRw==
Message-ID: <b204674234451a9ab81e834b90244d82.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <367cf74b038281d235681f6e7fd6f3f7046c962b.1674401764.git.daniel@makrotopia.org>
References: <cover.1674401764.git.daniel@makrotopia.org> <367cf74b038281d235681f6e7fd6f3f7046c962b.1674401764.git.daniel@makrotopia.org>
Subject: Re: [PATCH v4 3/3] clk: mediatek: add MT7981 clock support
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Miles Chen <miles.chen@mediatek.com>,
        Edward-JW Yang <edward-jw.yang@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>,
        Jianhui Zhao <zhaojh329@gmail.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Date:   Wed, 25 Jan 2023 18:23:16 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Daniel Golle (2023-01-22 07:44:00)
> +       GATE_SGMII1(CLK_SGM1_CK1_EN, "sgm1_ck1_en", "usb_ln0", 4),
> +       GATE_SGMII1(CLK_SGM1_CDR_CK1_EN, "sgm1_cdr_ck1_en", "usb_cdr", 5),
> +};
> +
> +static const struct mtk_gate_regs eth_cg_regs =3D {
> +       .set_ofs =3D 0x30,
> +       .clr_ofs =3D 0x30,
> +       .sta_ofs =3D 0x30,
> +};
> +
> +#define GATE_ETH(_id, _name, _parent, _shift) {        \
> +               .id =3D _id,                              \
> +               .name =3D _name,                          \
> +               .parent_name =3D _parent,                 \
> +               .regs =3D &eth_cg_regs,                   \
> +               .shift =3D _shift,                        \
> +               .ops =3D &mtk_clk_gate_ops_no_setclr_inv, \
> +       }
> +
> +static const struct mtk_gate eth_clks[] __initconst =3D {
> +       GATE_ETH(CLK_ETH_FE_EN, "eth_fe_en", "netsys_2x", 6),
> +       GATE_ETH(CLK_ETH_GP2_EN, "eth_gp2_en", "sgm_325m", 7),
> +       GATE_ETH(CLK_ETH_GP1_EN, "eth_gp1_en", "sgm_325m", 8),
> +       GATE_ETH(CLK_ETH_WOCPU0_EN, "eth_wocpu0_en", "netsys_wed_mcu", 15=
),
> +};
> +
> +static const struct mtk_clk_desc eth_desc =3D {
> +       .clks =3D eth_clks,
> +       .num_clks =3D ARRAY_SIZE(eth_clks),
> +};
> +
> +static const struct mtk_clk_desc sgmii0_desc =3D {
> +       .clks =3D sgmii0_clks,
> +       .num_clks =3D ARRAY_SIZE(sgmii0_clks),
> +};
> +
> +static const struct mtk_clk_desc sgmii1_desc =3D {
> +       .clks =3D sgmii1_clks,
> +       .num_clks =3D ARRAY_SIZE(sgmii1_clks),
> +};
> +
> +static const struct of_device_id of_match_clk_mt7981_eth[] =3D {
> +       { .compatible =3D "mediatek,mt7981-ethsys", .data =3D &eth_desc },
> +       { .compatible =3D "mediatek,mt7981-sgmiisys_0", .data =3D &sgmii0=
_desc },
> +       { .compatible =3D "mediatek,mt7981-sgmiisys_1", .data =3D &sgmii1=
_desc },
> +       { /* sentinel */ }
> +};

Actually not applied

WARNING: DT compatible string "mediatek,mt7981-ethsys" appears un-documente=
d -- check ./Documentation/devicetree/bindings/
#291: FILE: drivers/clk/mediatek/clk-mt7981-eth.c:103:
+       { .compatible =3D "mediatek,mt7981-ethsys", .data =3D &eth_desc },

WARNING: DT compatible string "mediatek,mt7981-sgmiisys_0" appears un-docum=
ented -- check ./Documentation/devicetree/bindings/
#292: FILE: drivers/clk/mediatek/clk-mt7981-eth.c:104:
+       { .compatible =3D "mediatek,mt7981-sgmiisys_0", .data =3D &sgmii0_d=
esc },

WARNING: DT compatible string "mediatek,mt7981-sgmiisys_1" appears un-docum=
ented -- check ./Documentation/devicetree/bindings/
#293: FILE: drivers/clk/mediatek/clk-mt7981-eth.c:105:
+       { .compatible =3D "mediatek,mt7981-sgmiisys_1", .data =3D &sgmii1_d=
esc },

WARNING: DT compatible string "mediatek,mt7981-infracfg" appears un-documen=
ted -- check ./Documentation/devicetree/bindings/
#506: FILE: drivers/clk/mediatek/clk-mt7981-infracfg.c:195:
+       { .compatible =3D "mediatek,mt7981-infracfg", .data =3D &infracfg_d=
esc },

Is there a binding update missing?

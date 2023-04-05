Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7BD6D7D53
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 15:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238180AbjDENEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 09:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238176AbjDENEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 09:04:16 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F2A5FCF;
        Wed,  5 Apr 2023 06:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1680699848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YkbuvCGQOWFY1W5hX/uG2RveqynQ+85wv2M8PGFZ7vc=;
        b=3mEi9sd14RtSilWugED3F/f1NHSVZz/2xsgSbVUMYtohN4iyRWPQuN/0cj7BtjXjYQTI9X
        a6aEynlck8IN4/RYN4tKNy+VG1wAYjPHKb2w1UKNamaQkeW8Ds6o9+R3WX/pE03V9N6Ndu
        0nvl10itS1x2Cw7b1X3xuVSiT51gMLU=
Message-ID: <3c1c42baf7d764bf6429b470f534fd9ec46ddedd.camel@crapouillou.net>
Subject: Re: [PATCH v3 56/65] clk: ingenic: cgu: Switch to determine_rate
From:   Paul Cercueil <paul@crapouillou.net>
To:     Maxime Ripard <maxime@cerno.tech>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andreas =?ISO-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        David Lechner <david@lechnology.com>,
        Sekhar Nori <nsekhar@ti.com>, Abel Vesa <abelvesa@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, patches@opensource.cirrus.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-phy@lists.infradead.org,
        linux-rtc@vger.kernel.org, linux-sunxi@lists.linux.dev,
        alsa-devel@alsa-project.org, linux-mips@vger.kernel.org
Date:   Wed, 05 Apr 2023 15:04:05 +0200
In-Reply-To: <20221018-clk-range-checks-fixes-v3-56-9a1358472d52@cerno.tech>
References: <20221018-clk-range-checks-fixes-v3-0-9a1358472d52@cerno.tech>
         <20221018-clk-range-checks-fixes-v3-56-9a1358472d52@cerno.tech>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

Le mardi 04 avril 2023 =C3=A0 12:11 +0200, Maxime Ripard a =C3=A9crit=C2=A0=
:
> The Ingenic CGU clocks implements a mux with a set_parent hook, but
> doesn't provide a determine_rate implementation.
>=20
> This is a bit odd, since set_parent() is there to, as its name
> implies,
> change the parent of a clock. However, the most likely candidate to
> trigger that parent change is a call to clk_set_rate(), with
> determine_rate() figuring out which parent is the best suited for a
> given rate.
>=20
> The other trigger would be a call to clk_set_parent(), but it's far
> less
> used, and it doesn't look like there's any obvious user for that
> clock.
>=20
> So, the set_parent hook is effectively unused, possibly because of an
> oversight. However, it could also be an explicit decision by the
> original author to avoid any reparenting but through an explicit call
> to
> clk_set_parent().

As I said in the v2 (IIRC), clk_set_parent() is used when re-parenting
from the device tree.

>=20
> The driver does implement round_rate() though, which means that we
> can
> change the rate of the clock, but we will never get to change the
> parent.
>=20
> However, It's hard to tell whether it's been done on purpose or not.
>=20
> Since we'll start mandating a determine_rate() implementation, let's
> convert the round_rate() implementation to a determine_rate(), which
> will also make the current behavior explicit. And if it was an
> oversight, the clock behaviour can be adjusted later on.

So just to be sure, this patch won't make clk_set_rate() automatically
switch parents, right?

Allowing automatic re-parenting sounds like a huge can of worms...

Cheers,
-Paul

>=20
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
> =C2=A0drivers/clk/ingenic/cgu.c | 15 ++++++++-------
> =C2=A01 file changed, 8 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/clk/ingenic/cgu.c b/drivers/clk/ingenic/cgu.c
> index 1f7ba30f5a1b..0c9c8344ad11 100644
> --- a/drivers/clk/ingenic/cgu.c
> +++ b/drivers/clk/ingenic/cgu.c
> @@ -491,22 +491,23 @@ ingenic_clk_calc_div(struct clk_hw *hw,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return div;
> =C2=A0}
> =C2=A0
> -static long
> -ingenic_clk_round_rate(struct clk_hw *hw, unsigned long req_rate,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long *paren=
t_rate)
> +static int ingenic_clk_determine_rate(struct clk_hw *hw,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struc=
t clk_rate_request *req)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct ingenic_clk *ingen=
ic_clk =3D to_ingenic_clk(hw);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const struct ingenic_cgu_=
clk_info *clk_info =3D
> to_clk_info(ingenic_clk);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int div =3D 1;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (clk_info->type & CGU_=
CLK_DIV)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0div =3D ingenic_clk_calc_div(hw, clk_info,
> *parent_rate, req_rate);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0div =3D ingenic_clk_calc_div(hw, clk_info, req-
> >best_parent_rate,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 req->rate);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else if (clk_info->type &=
 CGU_CLK_FIXDIV)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0div =3D clk_info->fixdiv.div;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else if (clk_hw_can_set_r=
ate_parent(hw))
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0*parent_rate =3D req_rate;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0req->best_parent_rate =3D req->rate;
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return DIV_ROUND_UP(*parent_ra=
te, div);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0req->rate =3D DIV_ROUND_UP(req=
->best_parent_rate, div);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> =C2=A0}
> =C2=A0
> =C2=A0static inline int ingenic_clk_check_stable(struct ingenic_cgu *cgu,
> @@ -626,7 +627,7 @@ static const struct clk_ops ingenic_clk_ops =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.set_parent =3D ingenic_c=
lk_set_parent,
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.recalc_rate =3D ingenic_=
clk_recalc_rate,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.round_rate =3D ingenic_clk_ro=
und_rate,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.determine_rate =3D ingenic_cl=
k_determine_rate,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.set_rate =3D ingenic_clk=
_set_rate,
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.enable =3D ingenic_clk_e=
nable,
>=20


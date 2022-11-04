Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6C2619A18
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 15:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbiKDOeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 10:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbiKDOe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 10:34:26 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3036548;
        Fri,  4 Nov 2022 07:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1667572309; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yJcwJHHN5pttniHz+NbbkUJe8GLWXEpymY5u4z+2Tls=;
        b=CpbNQdJ/BWVPt6aAZUIABOUDvKsIEPL9U91j803wkEpi9xnD/0w4adiBYeJcN8TJFfSWVl
        x/lvi9fmHRkBC7J3u5FRclEUbJUWbDpV47bpFyqI8WWI72nrAKvHhlIMavR+GX46Lp5ZKT
        4vVIrBF8TIdJDdEsSYvgVdovc3N1IRg=
Date:   Fri, 04 Nov 2022 14:31:20 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 56/65] clk: ingenic: cgu: Switch to determine_rate
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Daniel Vetter <daniel@ffwll.ch>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andreas =?iso-8859-1?q?F=E4rber?= <afaerber@suse.de>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Samuel Holland <samuel@sholland.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Vinod Koul <vkoul@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Takashi Iwai <tiwai@suse.com>,
        David Airlie <airlied@gmail.com>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Lechner <david@lechnology.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-stm32@st-md-mailman.stormreply.com,
        alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-actions@lists.infradead.org, linux-clk@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        patches@opensource.cirrus.com, linux-tegra@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Message-Id: <80VTKR.CE8RVN8M3ZYK3@crapouillou.net>
In-Reply-To: <20221018-clk-range-checks-fixes-v2-56-f6736dec138e@cerno.tech>
References: <20221018-clk-range-checks-fixes-v2-0-f6736dec138e@cerno.tech>
        <20221018-clk-range-checks-fixes-v2-56-f6736dec138e@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

Le ven. 4 nov. 2022 =E0 14:18:13 +0100, Maxime Ripard=20
<maxime@cerno.tech> a =E9crit :
> The Ingenic CGU clocks implements a mux with a set_parent hook, but
> doesn't provide a determine_rate implementation.
>=20
> This is a bit odd, since set_parent() is there to, as its name=20
> implies,
> change the parent of a clock. However, the most likely candidate to
> trigger that parent change is a call to clk_set_rate(), with
> determine_rate() figuring out which parent is the best suited for a
> given rate.
>=20
> The other trigger would be a call to clk_set_parent(), but it's far=20
> less
> used, and it doesn't look like there's any obvious user for that=20
> clock.
>=20
> So, the set_parent hook is effectively unused, possibly because of an
> oversight. However, it could also be an explicit decision by the
> original author to avoid any reparenting but through an explicit call=20
> to
> clk_set_parent().
>=20
> The driver does implement round_rate() though, which means that we can
> change the rate of the clock, but we will never get to change the
> parent.
>=20
> However, It's hard to tell whether it's been done on purpose or not.
>=20
> Since we'll start mandating a determine_rate() implementation, let's
> convert the round_rate() implementation to a determine_rate(), which
> will also make the current behavior explicit. And if it was an
> oversight, the clock behaviour can be adjusted later on.

So it's partly on purpose, partly because I didn't know about=20
.determine_rate.

There's nothing odd about having a lonely .set_parent callback; in my=20
case the clocks are parented from the device tree.

Having the clocks driver trigger a parent change when requesting a rate=20
change sounds very dangerous, IMHO. My MMC controller can be parented=20
to the external 48 MHz oscillator, and if the card requests 50 MHz, it=20
could switch to one of the PLLs. That works as long as the PLLs don't=20
change rate, but if one is configured as driving the CPU clock, it=20
becomes messy.
The thing is, the clocks driver has no way to know whether or not it is=20
"safe" to use a designated parent.

For that reason, in practice, I never actually want to have a clock=20
re-parented - it's almost always a bad idea vs. sticking to the parent=20
clock configured in the DTS.


> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  drivers/clk/ingenic/cgu.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/clk/ingenic/cgu.c b/drivers/clk/ingenic/cgu.c
> index 1f7ba30f5a1b..0c9c8344ad11 100644
> --- a/drivers/clk/ingenic/cgu.c
> +++ b/drivers/clk/ingenic/cgu.c
> @@ -491,22 +491,23 @@ ingenic_clk_calc_div(struct clk_hw *hw,
>  	return div;
>  }
>=20
> -static long
> -ingenic_clk_round_rate(struct clk_hw *hw, unsigned long req_rate,
> -		       unsigned long *parent_rate)
> +static int ingenic_clk_determine_rate(struct clk_hw *hw,
> +				      struct clk_rate_request *req)
>  {
>  	struct ingenic_clk *ingenic_clk =3D to_ingenic_clk(hw);
>  	const struct ingenic_cgu_clk_info *clk_info =3D=20
> to_clk_info(ingenic_clk);
>  	unsigned int div =3D 1;
>=20
>  	if (clk_info->type & CGU_CLK_DIV)
> -		div =3D ingenic_clk_calc_div(hw, clk_info, *parent_rate, req_rate);
> +		div =3D ingenic_clk_calc_div(hw, clk_info, req->best_parent_rate,
> +					   req->rate);

Sorry but I'm not sure that this works.

You replace the "parent_rate" with the "best_parent_rate", and that=20
means you only check the requested rate vs. the parent with the highest=20
frequency, and not vs. the actual parent that will be used.

Cheers,
-Paul

>  	else if (clk_info->type & CGU_CLK_FIXDIV)
>  		div =3D clk_info->fixdiv.div;
>  	else if (clk_hw_can_set_rate_parent(hw))
> -		*parent_rate =3D req_rate;
> +		req->best_parent_rate =3D req->rate;
>=20
> -	return DIV_ROUND_UP(*parent_rate, div);
> +	req->rate =3D DIV_ROUND_UP(req->best_parent_rate, div);
> +	return 0;
>  }
>=20
>  static inline int ingenic_clk_check_stable(struct ingenic_cgu *cgu,
> @@ -626,7 +627,7 @@ static const struct clk_ops ingenic_clk_ops =3D {
>  	.set_parent =3D ingenic_clk_set_parent,
>=20
>  	.recalc_rate =3D ingenic_clk_recalc_rate,
> -	.round_rate =3D ingenic_clk_round_rate,
> +	.determine_rate =3D ingenic_clk_determine_rate,
>  	.set_rate =3D ingenic_clk_set_rate,
>=20
>  	.enable =3D ingenic_clk_enable,
>=20
> --
> b4 0.11.0-dev-99e3a



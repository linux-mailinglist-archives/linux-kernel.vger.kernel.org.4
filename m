Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57C062416B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 12:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiKJL3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 06:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiKJL3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 06:29:21 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1F969DE7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 03:29:19 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id g62so1735575pfb.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 03:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dZWp2kHBH7BxTK24vYMYaWuh8ES61v4HZQKkOxWH97c=;
        b=nm5AzPUP/c5SxnOWRF0E8OOs8vIUdOgDjB6wYkEQYpfYDRuGKSxS+CBIeuds7UEokj
         CAc3O4M3Lzp0CmH9uvJ+chSuCz2e7UtgkMxDMXFmH0EFBdC81NQcL56cIa/e5fTzyvWS
         kSegvkcOyKB6FEauX3mSzkzzDIAUq5r5SATzN3WmVSBqg1jyg/gg0kYs06KdBSG3zxV/
         fvTxGa1dt18Ruz+5BEtQasGBTHQrEp0wpReAHWWGdK+pWMVHzmdtTwn3mkonTWk309ZV
         x5RN6EKVnoWzvPKijsEeJPqRTGi+5rLHTCBxYP1D5lgzLbOuhL8arV0ezTVKJRNayIhr
         L9Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dZWp2kHBH7BxTK24vYMYaWuh8ES61v4HZQKkOxWH97c=;
        b=03M9V3Mtn1cEOLP5iAZpm/rNAiycGbycZRH6+T9nghl4R7Ys1za5f9LlMVfTau3tic
         dCPAaztJDxPn4x1OxClkMELhjaOrbkssV0st/EWeasBeAtEcssDi+VSZgRzfDne7c2sJ
         lYswGZnsvQRfip7STo8FbY6RBfLOnyX5DD0StOIWNIOx7Gcs55YlixluyY63kEkE45IP
         RVCuxlRLA4WhOylM7qQ4OnF+81q6SNaWStRP1GmxGnS7cpDum8zo5pXCmpp7vTkpxCsd
         Kf/6yUqPbNjaktV0nmw+qs/1sGWPnOrgnW7Qxd4r+Ec8dGtdasduSZVuXl37hdz+pWbf
         /ALQ==
X-Gm-Message-State: ACrzQf25MGOCYd5Fcradwn2kZJsskazXWKyVm5NOAekYNGoJ2U+zUrt7
        BSD1+0mT1wSzgA5+4dxpHkCI6H7A6tuxMtfFESMKrA==
X-Google-Smtp-Source: AMsMyM4cuzpOD/TX9hqFyYyupcC8P3vPeFAFlSRm0wZ2MgnRUbZnV+cRg9A/mVHt7wBrkUdmfz48YahbcXukazUMnzc=
X-Received: by 2002:a63:4204:0:b0:442:ee11:4894 with SMTP id
 p4-20020a634204000000b00442ee114894mr2372631pga.595.1668079758533; Thu, 10
 Nov 2022 03:29:18 -0800 (PST)
MIME-Version: 1.0
References: <20221018-clk-range-checks-fixes-v2-0-f6736dec138e@cerno.tech> <20221018-clk-range-checks-fixes-v2-35-f6736dec138e@cerno.tech>
In-Reply-To: <20221018-clk-range-checks-fixes-v2-35-f6736dec138e@cerno.tech>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 10 Nov 2022 12:28:41 +0100
Message-ID: <CAPDyKFoycVedCJMy0=UK+q5SiPQHqje_8bSN-gdkpBa6KhFfkg@mail.gmail.com>
Subject: Re: [PATCH v2 35/65] clk: ux500: sysctrl: Add a determine_rate hook
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Daniel Vetter <daniel@ffwll.ch>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Nov 2022 at 14:32, Maxime Ripard <maxime@cerno.tech> wrote:
>
> The UX500 sysctrl "set_parent" clocks implement a mux with a set_parent
> hook, but doesn't provide a determine_rate implementation.
>
> This is a bit odd, since set_parent() is there to, as its name implies,
> change the parent of a clock. However, the most likely candidate to
> trigger that parent change is a call to clk_set_rate(), with
> determine_rate() figuring out which parent is the best suited for a
> given rate.
>
> The other trigger would be a call to clk_set_parent(), but it's far less
> used, and it doesn't look like there's any obvious user for that clock.

If I recall correctly, that is the use case we did target for these
types of clocks. See sound/soc/ux500/ux500_ab85xx.c, for example.

Maybe there are some additional pieces missing from the old down
stream kernel, I don't have full picture, sorry.

Anyway, if I am not wrong, this was about supporting a low-power audio
use case, which requires us to switch the parent clock (to avoid
wasting energy).

>
> So, the set_parent hook is effectively unused, possibly because of an
> oversight. However, it could also be an explicit decision by the
> original author to avoid any reparenting but through an explicit call to
> clk_set_parent().

Yes, this was the reason.

As a matter of fact, I don't even recall that re-parenting was
possible through clk_set_rate() when this clock driver was introduced.
But, I might be wrong, it's quite a while ago.

>
> The latter case would be equivalent to setting the flag
> CLK_SET_RATE_NO_REPARENT, together with setting our determine_rate hook
> to __clk_mux_determine_rate(). Indeed, if no determine_rate
> implementation is provided, clk_round_rate() (through
> clk_core_round_rate_nolock()) will call itself on the parent if
> CLK_SET_RATE_PARENT is set, and will not change the clock rate
> otherwise. __clk_mux_determine_rate() has the exact same behavior when
> CLK_SET_RATE_NO_REPARENT is set.
>
> And if it was an oversight, then we are at least explicit about our
> behavior now and it can be further refined down the line.
>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Seems reasonable to me!

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/clk/ux500/clk-sysctrl.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/ux500/clk-sysctrl.c b/drivers/clk/ux500/clk-sysctrl.c
> index 702f2f8b43fa..d36336665b6d 100644
> --- a/drivers/clk/ux500/clk-sysctrl.c
> +++ b/drivers/clk/ux500/clk-sysctrl.c
> @@ -110,6 +110,7 @@ static const struct clk_ops clk_sysctrl_gate_fixed_rate_ops = {
>  };
>
>  static const struct clk_ops clk_sysctrl_set_parent_ops = {
> +       .determine_rate = __clk_mux_determine_rate,
>         .set_parent = clk_sysctrl_set_parent,
>         .get_parent = clk_sysctrl_get_parent,
>  };
> @@ -220,6 +221,7 @@ struct clk *clk_reg_sysctrl_set_parent(struct device *dev,
>                                 unsigned long flags)
>  {
>         return clk_reg_sysctrl(dev, name, parent_names, num_parents,
> -                       reg_sel, reg_mask, reg_bits, 0, 0, flags,
> +                       reg_sel, reg_mask, reg_bits, 0, 0,
> +                       flags | CLK_SET_RATE_NO_REPARENT,
>                         &clk_sysctrl_set_parent_ops);
>  }
>
> --
> b4 0.11.0-dev-99e3a

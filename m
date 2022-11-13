Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF565627304
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 23:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235532AbiKMWfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 17:35:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235422AbiKMWfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 17:35:53 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39DEFAE8;
        Sun, 13 Nov 2022 14:35:51 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id z6so5920259qtv.5;
        Sun, 13 Nov 2022 14:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2UWIwxNMt9Li5DI9V3Ue/+A2ETbpfwK4uJjlNth28Ps=;
        b=cxos6M6SEMWjz70hcYfwJn7Qy9x3ScQZdWjcWHcTUuPDd6QIkxHfs4TdC7er0cgTfw
         Zecl1ammtXTh3CRumNopuCdrO/B9HdufOATVFx7LmHWfcuepu8nGRPAXZimVwU33NdJY
         fSpdh/6V9x/8s+acnZlcPXnCq3SzIgJYAOJ+MdHag7DONXMIur05Qu2T29C+PPj+G5FS
         51vaHNJTqtvQKEh0MKIsH8wIeeMtk/77Zn6zHSFYDKwwTYJrTvxOcJz1pI56sykta8ez
         ucf+QXApfLU7u3dxQYz1YwJFVAwCWBLrNvZsrMdMSVYHA3yVHW95iD4uAWPO1ebw8AQZ
         l5aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2UWIwxNMt9Li5DI9V3Ue/+A2ETbpfwK4uJjlNth28Ps=;
        b=SHRhf3ePzGWd2eW9o9v+lLAbpwPN7fWPliNSTLPdEJVI8OUpdhq+2LJvaqTPeCPqKz
         CrppKsATY3mnE6/gta6JICDXpkV9Y33NMBK9Ca7vs7N/+xKUbiS0ieC1HYcC0a//cVCP
         oNa9Z9bWMh8n2aOTOEsRH8t7Zo9WSZuK9PzIVFwg6Zt0J1Rw1EDYmVU2zDRaUmSaWB2x
         D17rHqKQMx96kAHzJAg2FvHsOwVVkxQrD53OInAaDVpPOuUogvseS6VwsvO22Xhqfb2c
         P5zkdlS3Zy2Q9lTSiXP67q6Z3c42pbHEw/iBOQWfdiy5WrlLh+cIy0eiQDW7S1VKSB9g
         CAeg==
X-Gm-Message-State: ANoB5plYYsDjhGWuYBBunRQ6lPH15hkZM5ooD9D9wfAN6nL5cgD4UCZJ
        NlSb4wLRqKefJDbi6lbchjI=
X-Google-Smtp-Source: AA0mqf6n/LTjELlMgOPAUHKCZj998ajlsJmr6FJtHheLBD4DRKv0w+DZx/+jLTxZzLzeUXXjccj7Rg==
X-Received: by 2002:a05:622a:4806:b0:3a4:f140:f707 with SMTP id fb6-20020a05622a480600b003a4f140f707mr10057169qtb.317.1668378951056;
        Sun, 13 Nov 2022 14:35:51 -0800 (PST)
Received: from shaak (modemcable055.92-163-184.mc.videotron.ca. [184.163.92.55])
        by smtp.gmail.com with ESMTPSA id bk8-20020a05620a1a0800b006f9f3c0c63csm5482646qkb.32.2022.11.13.14.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 14:35:50 -0800 (PST)
Date:   Sun, 13 Nov 2022 17:35:46 -0500
From:   Liam Beguin <liambeguin@gmail.com>
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
        Paul Cercueil <paul@crapouillou.net>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
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
Subject: Re: [PATCH v2 13/65] clk: lmk04832: clkout: Add a determine_rate hook
Message-ID: <Y3FxQsT240Wm0G6g@shaak>
References: <20221018-clk-range-checks-fixes-v2-0-f6736dec138e@cerno.tech>
 <20221018-clk-range-checks-fixes-v2-13-f6736dec138e@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018-clk-range-checks-fixes-v2-13-f6736dec138e@cerno.tech>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Fri, Nov 04, 2022 at 02:17:30PM +0100, Maxime Ripard wrote:
> The LKM04832 "CLKOUT" clock implements a mux with a set_parent hook, but
> doesn't provide a determine_rate implementation.
> 
> This is a bit odd, since set_parent() is there to, as its name implies,
> change the parent of a clock. However, the most likely candidate to
> trigger that parent change is a call to clk_set_rate(), with
> determine_rate() figuring out which parent is the best suited for a
> given rate.
> 
> The other trigger would be a call to clk_set_parent(), but it's far less
> used, and it doesn't look like there's any obvious user for that clock.
> 
> So, the set_parent hook is effectively unused, possibly because of an
> oversight. However, it could also be an explicit decision by the
> original author to avoid any reparenting but through an explicit call to
> clk_set_parent().

This is correct, the set_parent hook is effectively unused at the
moment. It was implemented as a way for consumers to select the parent
themselves.

The LMK04832 is used in JESD204 applications where devices need a device
clock as well as a sysref clock. Since this is determined by the
hardware layout, a devicetree option is used to select the inital state
of the clkout mux. This is set at the end of lmk04832_register_clkout().

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
> Since the CLK_SET_RATE_NO_REPARENT flag was already set though, it seems
> unlikely.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Liam Beguin <liambeguin@gmail.com>

Cheers,
Liam

> ---
>  drivers/clk/clk-lmk04832.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/clk-lmk04832.c b/drivers/clk/clk-lmk04832.c
> index f416f8bc2898..f68bb0affdad 100644
> --- a/drivers/clk/clk-lmk04832.c
> +++ b/drivers/clk/clk-lmk04832.c
> @@ -1281,6 +1281,7 @@ static const struct clk_ops lmk04832_clkout_ops = {
>  	.is_enabled = lmk04832_clkout_is_enabled,
>  	.prepare = lmk04832_clkout_prepare,
>  	.unprepare = lmk04832_clkout_unprepare,
> +	.determine_rate = __clk_mux_determine_rate,
>  	.set_parent = lmk04832_clkout_set_parent,
>  	.get_parent = lmk04832_clkout_get_parent,
>  };
> 
> -- 
> b4 0.11.0-dev-99e3a
> 

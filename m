Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9219961EC77
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 08:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbiKGHwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 02:52:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbiKGHwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 02:52:22 -0500
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15DDB7E1;
        Sun,  6 Nov 2022 23:52:21 -0800 (PST)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-13b103a3e5dso11817387fac.2;
        Sun, 06 Nov 2022 23:52:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hLKOOl0yo7YI7pAdrLyTR/NQWG7rhWdAq87I8wp+XOk=;
        b=Hz4IE7Yn/5Nk8NP9z/+kHSK2iouID2NqPAJE07Gf7dUmrO4KnUTFzlxtL17jMaBXyp
         Dv8cHm8yE0X+WAdKn4ta0lHnmPPGfGfpqw07hjoUFsj269CFe3fkBiBGKkM1Km0ZpBVq
         5FV9MdfdXsA+SCYMUJsU5Mn77akA5ZCA2PaN4H2APil9FSkds3jXsuxr+BDJfrBWiaM5
         rq0ytCDRu1afvaduGSERw3Lhw3WnYPZbZBgTOezBolnSeyuJmyNqBeAAxCpTtuGE5uyJ
         2wJB6T+x72yrVPWlXHlocyEcwEuOanDtNzXq3z1T+oSGECc93ju7wyeWDz9t553gHl+0
         0Rpg==
X-Gm-Message-State: ACrzQf2aC3vOwXLhcvRjLxjIQHOKLXRXZrcFyuHa2adtz3AlLoSTj0Go
        nUVwS6lx2ZvAY/XgTjRsvr1BHWPzu0YxKQ==
X-Google-Smtp-Source: AMsMyM79ktbSDFQXhG8HxgxzC9XjiIyabewaT9y3o1EOqeqG95rHakAsNcx7ruKGx21FsDn3b6kSrA==
X-Received: by 2002:a05:6870:c1d1:b0:13a:f691:c9ae with SMTP id i17-20020a056870c1d100b0013af691c9aemr27647508oad.34.1667807540968;
        Sun, 06 Nov 2022 23:52:20 -0800 (PST)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com. [209.85.210.49])
        by smtp.gmail.com with ESMTPSA id x12-20020a05683000cc00b0065c2c46077dsm2627246oto.67.2022.11.06.23.52.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Nov 2022 23:52:20 -0800 (PST)
Received: by mail-ot1-f49.google.com with SMTP id cb2-20020a056830618200b00661b6e5dcd8so6071166otb.8;
        Sun, 06 Nov 2022 23:52:20 -0800 (PST)
X-Received: by 2002:a81:9c49:0:b0:34a:de:97b8 with SMTP id n9-20020a819c49000000b0034a00de97b8mr45959924ywa.384.1667807529144;
 Sun, 06 Nov 2022 23:52:09 -0800 (PST)
MIME-Version: 1.0
References: <20221018-clk-range-checks-fixes-v2-0-f6736dec138e@cerno.tech> <20221018-clk-range-checks-fixes-v2-28-f6736dec138e@cerno.tech>
In-Reply-To: <20221018-clk-range-checks-fixes-v2-28-f6736dec138e@cerno.tech>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 7 Nov 2022 08:51:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXee3Xf8G53anCq-4qfenHhgnMiyC1KhKo8Uv6-UV_jrw@mail.gmail.com>
Message-ID: <CAMuHMdXee3Xf8G53anCq-4qfenHhgnMiyC1KhKo8Uv6-UV_jrw@mail.gmail.com>
Subject: Re: [PATCH v2 28/65] clk: renesas: r9a06g032: Add a determine_rate hook
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
        dri-devel@lists.freedesktop.org,
        Gareth Williams <gareth.williams.jx@renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC Gareth

On Fri, Nov 4, 2022 at 2:18 PM Maxime Ripard <maxime@cerno.tech> wrote:
>
> The Renesas r9a06g032 bitselect clock implements a mux with a set_parent
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
>
> So, the set_parent hook is effectively unused, possibly because of an
> oversight. However, it could also be an explicit decision by the
> original author to avoid any reparenting but through an explicit call to
> clk_set_parent().
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
> ---
>  drivers/clk/renesas/r9a06g032-clocks.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/renesas/r9a06g032-clocks.c b/drivers/clk/renesas/r9a06g032-clocks.c
> index 983faa5707b9..70c37097ca6e 100644
> --- a/drivers/clk/renesas/r9a06g032-clocks.c
> +++ b/drivers/clk/renesas/r9a06g032-clocks.c
> @@ -773,6 +773,7 @@ static int r9a06g032_clk_mux_set_parent(struct clk_hw *hw, u8 index)
>  }
>
>  static const struct clk_ops clk_bitselect_ops = {
> +       .determine_rate = __clk_mux_determine_rate,
>         .get_parent = r9a06g032_clk_mux_get_parent,
>         .set_parent = r9a06g032_clk_mux_set_parent,
>  };
> @@ -797,7 +798,7 @@ r9a06g032_register_bitsel(struct r9a06g032_priv *clocks,
>
>         init.name = desc->name;
>         init.ops = &clk_bitselect_ops;
> -       init.flags = CLK_SET_RATE_PARENT;
> +       init.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT;
>         init.parent_names = names;
>         init.num_parents = 2;
>
>
> --
> b4 0.11.0-dev-99e3a

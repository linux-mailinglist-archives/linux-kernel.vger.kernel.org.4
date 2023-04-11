Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC556DD7F0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 12:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjDKK2T convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 11 Apr 2023 06:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjDKK2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 06:28:16 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C313E49;
        Tue, 11 Apr 2023 03:28:14 -0700 (PDT)
Received: by mail-ot1-f46.google.com with SMTP id i15-20020a9d610f000000b006a11f365d13so2901392otj.0;
        Tue, 11 Apr 2023 03:28:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681208893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9k4ZTujQ4vL3rn+nuolFAvnH5smJoZ+VnOtxKctHstQ=;
        b=y+0bH845JCNTfFSKJ0B1MNOHn231uHjFfzkjSJyaq98rD8+jejuBRzoyTS8HhnoNsO
         8jQ0bd7bTqaZURCPChYQYxcPRSs7oyztbrQDGH3EQAa+rc3jkxU/hdBWk908Q1jRcEBD
         MRxiWJpu5gvekAKHSXCg2vGClTRugX04MBZZy4Kje2/PBxfpSq/pGiuATVcYKzGxG4p1
         3urjx9jdH9H2ImVyeelhhnhTvDRI3YejMMpWCWeMZ4s+LCNLUVhFVzA17grZmnFhAGlG
         jbl9XUx5k4pxksCLilIFkF5uzXvqEjaBwX59XSJJnun9IBrkMSZr6cWBRu5bR8R1NM7Q
         FRmA==
X-Gm-Message-State: AAQBX9fL7mSESR+2nvw+f/aGHSDFxg7E8T6wyWC0Q+6AyiOEoINmtg4c
        9qmfuOeOiXyBbgolJirbePzAEaVVepxtJt9a
X-Google-Smtp-Source: AKy350an1xN/hishtaGm9b8dpgu3i42ccxwem6GQPxV40Cnc+i419snNpiA8gUUu82rkDrPlDBj9fg==
X-Received: by 2002:a9d:7ac4:0:b0:69f:b541:3f6e with SMTP id m4-20020a9d7ac4000000b0069fb5413f6emr6422271otn.19.1681208893360;
        Tue, 11 Apr 2023 03:28:13 -0700 (PDT)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com. [209.85.210.51])
        by smtp.gmail.com with ESMTPSA id d16-20020a9d5e10000000b006a305c68617sm5237126oti.53.2023.04.11.03.28.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 03:28:12 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id cp25-20020a056830661900b00693ce5a2f3eso3621124otb.8;
        Tue, 11 Apr 2023 03:28:12 -0700 (PDT)
X-Received: by 2002:a25:d74c:0:b0:b46:c5aa:86ef with SMTP id
 o73-20020a25d74c000000b00b46c5aa86efmr5126210ybg.12.1681208871324; Tue, 11
 Apr 2023 03:27:51 -0700 (PDT)
MIME-Version: 1.0
References: <20221018-clk-range-checks-fixes-v3-0-9a1358472d52@cerno.tech> <20221018-clk-range-checks-fixes-v3-28-9a1358472d52@cerno.tech>
In-Reply-To: <20221018-clk-range-checks-fixes-v3-28-9a1358472d52@cerno.tech>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 11 Apr 2023 12:27:38 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXUEOP_3zjf8nwDyHvZVG-D0AsBjnr=esKzejMMcEiLSQ@mail.gmail.com>
Message-ID: <CAMuHMdXUEOP_3zjf8nwDyHvZVG-D0AsBjnr=esKzejMMcEiLSQ@mail.gmail.com>
Subject: Re: [PATCH v3 28/65] clk: renesas: r9a06g032: Add a determine_rate hook
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
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
        Paul Cercueil <paul@crapouillou.net>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, patches@opensource.cirrus.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-phy@lists.infradead.org,
        linux-rtc@vger.kernel.org, linux-sunxi@lists.linux.dev,
        alsa-devel@alsa-project.org, linux-mips@vger.kernel.org,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Ralph Siemsen <ralph.siemsen@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC Gareth, Hervé, Miquel, Ralph

On Tue, Apr 4, 2023 at 2:44 PM Maxime Ripard <maxime@cerno.tech> wrote:
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

LGTM, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
But I do not have the hardware.

> --- a/drivers/clk/renesas/r9a06g032-clocks.c
> +++ b/drivers/clk/renesas/r9a06g032-clocks.c
> @@ -1121,6 +1121,7 @@ static int r9a06g032_clk_mux_set_parent(struct clk_hw *hw, u8 index)
>  }
>
>  static const struct clk_ops clk_bitselect_ops = {
> +       .determine_rate = __clk_mux_determine_rate,
>         .get_parent = r9a06g032_clk_mux_get_parent,
>         .set_parent = r9a06g032_clk_mux_set_parent,
>  };
> @@ -1145,7 +1146,7 @@ r9a06g032_register_bitsel(struct r9a06g032_priv *clocks,
>
>         init.name = desc->name;
>         init.ops = &clk_bitselect_ops;
> -       init.flags = CLK_SET_RATE_PARENT;
> +       init.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT;
>         init.parent_names = names;
>         init.num_parents = 2;
>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

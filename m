Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A19621249
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 14:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbiKHNZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 08:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233681AbiKHNZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 08:25:18 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6471834A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 05:25:17 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id ft34so2228895ejc.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 05:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xIunjndO5rqOpIPjGIQJB4TuLtmFYebQ0fOsvPNeO54=;
        b=dY2KECnuVH7NYv0yOK7RrL62QdqUlhl2JmgS7xh7Aop7k+RcPrpLQgabXuGbHHpGQR
         eHydRYWR08BPIi0DGkFfFL5aziMJHQLfVfnBD+eU2h7KlhHzcO6P+1GLNOD4+iPtpIq9
         f+xJ7woffKNTUf34ylHgwFwugM0mjDy+MNR+/tosLv90DX21VaSDgG9tpTl2KCuCdJUO
         uOa6Dv9G/jILV/FYPlkjsMzVEJLK96Ug7G7tfkWymeifahO0bdSmcFGNxzhRtu8RVMPO
         uhbfFCJ4Ya/DrkwEqdNt0sBFZZ7Pau3qynHAmgL94y0H0QvBHa6kKlb7zVfFQiDHP0ks
         6ZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xIunjndO5rqOpIPjGIQJB4TuLtmFYebQ0fOsvPNeO54=;
        b=I+BIVu3/FDPN8Feig8x3QOzP5fQc6PYTOlLlKPY8yyMUgo0iAVccOOnTT1YPDyLg8k
         17a6qgb0oDMXqxOFxqGSrXj4n9x0vOBjcgWbguGKOEIWMmU/jJoYFikozCdouMfK681x
         SdMBda8tCSzqu+ZICk1mokUsReirPl8KN6My0uFVBfEZlt2I7LqrJuc6SPYnWpww3zNJ
         4rkAbbzg3b7F4MqU/16naM8knf6FXlIrT1Ow6c81qd0tiG84ShjifZkdVjSILh7CmBRB
         qmJ0kRYfUbieAFC/dVma0qk03MEMRE0R49VxBYpnPyIhYYBsfy9J+RJeO8fp9ZaQ9MgY
         tTtQ==
X-Gm-Message-State: ANoB5pmmXaGTReOCxB+PPVzdYfKGgom2r4cJb9mvm5Oc14SKq5LfkEYk
        mreZMHqKRdYa2hWqgB5wuayPb5j4UzBkuibLMC59/g==
X-Google-Smtp-Source: AA0mqf68wWCeuB7GkTzw5Vcyy6luDq6tRlJuZOq+6MaYhZcTvhkBj9mitsGYltXA5OQs4b2+osg1ro8i402jh/hf0IY=
X-Received: by 2002:a17:906:6acc:b0:7ae:658c:ee45 with SMTP id
 q12-20020a1709066acc00b007ae658cee45mr11184945ejs.190.1667913915716; Tue, 08
 Nov 2022 05:25:15 -0800 (PST)
MIME-Version: 1.0
References: <20221018-clk-range-checks-fixes-v2-0-f6736dec138e@cerno.tech> <20221018-clk-range-checks-fixes-v2-34-f6736dec138e@cerno.tech>
In-Reply-To: <20221018-clk-range-checks-fixes-v2-34-f6736dec138e@cerno.tech>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 8 Nov 2022 14:25:04 +0100
Message-ID: <CACRpkdYwM6X8bBABCisUGX=P4F=hcFb7QLT3Cu7XUWUvV4TE1Q@mail.gmail.com>
Subject: Re: [PATCH v2 34/65] clk: ux500: prcmu: Add a determine_rate hook
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 4, 2022 at 2:32 PM Maxime Ripard <maxime@cerno.tech> wrote:

> The UX500 PRCMU "clkout" clock implements a mux with a set_parent hook,
> but doesn't provide a determine_rate implementation.
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

It is actually set up from the device tree, typically like this:

/* clkout1 from ACLK divided by 8 */
clocks = <&clkout_clk DB8500_CLKOUT_1 DB8500_CLKOUT_SRC_ACLK 8>;

So the parent (source) and divisor comes in there.

clk->source and clk->divider is already set up when clk_hw_register() is
called.

So set/get_parent() is never used on clkout.

I think I just added the callbacks for completeness, should we delete them
altogether? The patch is probably fine as-is as well so
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

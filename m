Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E0F678A31
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 23:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbjAWWEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 17:04:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjAWWEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 17:04:45 -0500
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A0A4489;
        Mon, 23 Jan 2023 14:04:44 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id p133so11667977oig.8;
        Mon, 23 Jan 2023 14:04:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d2FPhlsZpXvRIxsuYUUigEHlfXrVhve1sVEzIAaA+Cw=;
        b=YVHJaPyQ5lJp9NdfFLQWiw2pwu4nEY/q4L8Ibq9+QmFoEV/yLLq+VXl74L9N8v6+TF
         bh54g56m5KmIrFL8fgYnYrW3tIcROmgveflJVYV0f1Yq90LEU5mUu0ioFR43dVQfQ+Vm
         albsPxmY1AU9+BJLxFV+veYSfACRWzHvNYyOSH4a2JJgKQu66MhjmXbOG6Fy94nxU3hW
         jNMGfdtHjWm5qwqSKH4uA9yJnagloAE0l2qleRFjPxTVt5gc0t3yQL86TwR+ce4Ey1Q4
         RgoS4KLykYiEl2xhKHDn92IlUJJiN3z84cv9/vaEpjaHcooWMDhFPwWpRNlpWqSV8lhj
         XfeQ==
X-Gm-Message-State: AFqh2krk4t5EUbESe+srXuK176Ad9GEA8UTAVRV77tN6AglCL3e4uO54
        De2mjlMIY35Em0XZgKYyfg==
X-Google-Smtp-Source: AMrXdXuGzJhztAkRQDsZ89yb/Lz0gtcYbKO+RHg3d611kAIBMg0f22sl2cvcT8k/mjqlrQMTyAnItw==
X-Received: by 2002:a05:6808:3a5:b0:35e:214f:11c1 with SMTP id n5-20020a05680803a500b0035e214f11c1mr11706700oie.45.1674511483912;
        Mon, 23 Jan 2023 14:04:43 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r184-20020acac1c1000000b0035c21f1a570sm273111oif.6.2023.01.23.14.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 14:04:43 -0800 (PST)
Received: (nullmailer pid 2720043 invoked by uid 1000);
        Mon, 23 Jan 2023 22:04:42 -0000
Date:   Mon, 23 Jan 2023 16:04:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-rockchip@lists.infradead.org, linux-tegra@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Tony Huang <tonyhuang.sunplus@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        Li-hao Kuo <lhjeff911@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        ", Steen Hegelund" <Steen.Hegelund@microchip.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        devicetree@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-actions@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>,
        linux-amlogic@lists.infradead.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Markus Pargmann <mpa@pengutronix.de>,
        linux-kernel@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH 2/2] dt-bindings: mmc: correct pwrseq node names
Message-ID: <167451148159.2720004.9395844039645158729.robh@kernel.org>
References: <20230120085722.171965-1-krzysztof.kozlowski@linaro.org>
 <20230120085722.171965-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120085722.171965-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 20 Jan 2023 09:57:22 +0100, Krzysztof Kozlowski wrote:
> Node names should be generic and should not contain underscores.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/mmc/mmc-pwrseq-emmc.yaml   | 2 +-
>  Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.yaml | 2 +-
>  Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.yaml | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

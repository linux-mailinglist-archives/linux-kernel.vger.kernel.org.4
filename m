Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C587F6F7CDF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 08:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbjEEGST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 02:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjEEGSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 02:18:18 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72D911D81
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 23:18:16 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-643912bca6fso1123717b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 23:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683267496; x=1685859496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2cpNnZUMjxe8omI5N7a3yxPaft5joAL0ch8TrhFB8Z8=;
        b=KggfgirWJGkp7qmBLEOljOsiAwzZXpaW2VuvMX+isJXSmxtXh2V0abiogt8OHDlF0R
         /4A00chD4UN4bShQ25HS8gLCSVWDrX/SnmwSkgNiZPa2rrOs/VxoLuyx3Y4G1ZW+v64B
         F1eUB6ShLnHykX9chUKMoTaTKjRjY214k1WfBxr6cUqyNBMwfhQGBT8AebUkmOQFkoqt
         zPrjlVTFNe3jQTS8WH1cDVVLaO4vuKDrnarMcysZnleayX5K35gQG+Y9v6X73jrNcKtg
         LvUgkScNpfbxymaE8DI5BnkNmEh7ckrp97uLw67+WpWATrnAdUSmciBj3FwMcG6OxTYy
         IgWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683267496; x=1685859496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cpNnZUMjxe8omI5N7a3yxPaft5joAL0ch8TrhFB8Z8=;
        b=SZOxEvSDAW38tLgfubKDuR30y6XdoWif9thnn5xgIdrZL4JTENXgu3CsAORTa5/JNO
         cWmb4HvOQPrYx3GnntfyjdX5HlJ40jndxGEbOivePstvrFg5gN0pH5/W609zi3GvI+kj
         DM60EopsnI1usmDBVIxyY65zZnLPfJgZ5o91gtLzzzX+oC3URb5VXIfzJN+RqNwTHrxw
         So1eSuNZAYjk7jp7VJQOOOwqWdmcIiMudwTYCPoqaxHLX+o0zj0ruUZavbuBq5v1gBjr
         246qoKaJzELzO6pBLruz07G24ykTixAVu1hC5DZY7mOopm5qCtjkjTOOyYzpS/9f+YCQ
         xQJQ==
X-Gm-Message-State: AC+VfDyBzeiFmf2rNaz+LTjDzpImMyjUCQSa4lDmoMH8Uc77NkatWDQY
        bT507DYlzt09N3Qji/pV4QoIOQ==
X-Google-Smtp-Source: ACHHUZ4PLkadb3fwQqdgi8WHpXvUUAVWN2Jptu1Jc5PeyEviOACTLxDsTzBDAOk6BLAw4YsLxzKBOg==
X-Received: by 2002:a05:6a20:7295:b0:ef:205f:8184 with SMTP id o21-20020a056a20729500b000ef205f8184mr651085pzk.13.1683267496411;
        Thu, 04 May 2023 23:18:16 -0700 (PDT)
Received: from localhost ([122.172.85.8])
        by smtp.gmail.com with ESMTPSA id h16-20020aa786d0000000b0063b8f33cb81sm798014pfo.93.2023.05.04.23.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 23:18:15 -0700 (PDT)
Date:   Fri, 5 May 2023 11:48:13 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     soc@kernel.org, Christian Marangi <ansuelsmth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Antoine Tenart <atenart@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Lars Persson <lars.persson@axis.com>,
        Scott Branden <sbranden@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Wei Xu <xuwei5@hisilicon.com>,
        Jean-Marie Verdun <verdun@hpe.com>,
        Nick Hawkins <nick.hawkins@hpe.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Peter Rosin <peda@axentia.se>, Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>,
        Daniel Palmer <daniel@thingy.jp>,
        Romain Perier <romain.perier@gmail.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Marek Vasut <marex@denx.de>, Qin Jian <qinjian@cqplus1.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Paul Barker <paul.barker@sancloud.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Enric Balletbo i Serra <eballetbo@gmail.com>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Michal Simek <michal.simek@xilinx.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@axis.com
Subject: Re: [PATCH 4/4] ARM: dts: Move .dts files to vendor sub-directories
Message-ID: <20230505061813.pu36aup2p5yqcpuh@vireshk-i7>
References: <20230504-arm-dts-mv-v1-0-2c8e51a2b6c4@kernel.org>
 <20230504-arm-dts-mv-v1-4-2c8e51a2b6c4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504-arm-dts-mv-v1-4-2c8e51a2b6c4@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-05-23, 22:29, Rob Herring wrote:
>  arch/arm/boot/dts/st/Makefile                      |   73 +
>  arch/arm/boot/dts/{ => st}/spear1310-evb.dts       |    0
>  arch/arm/boot/dts/{ => st}/spear1310.dtsi          |    0
>  arch/arm/boot/dts/{ => st}/spear1340-evb.dts       |    0
>  arch/arm/boot/dts/{ => st}/spear1340.dtsi          |    0
>  arch/arm/boot/dts/{ => st}/spear13xx.dtsi          |    0
>  arch/arm/boot/dts/{ => st}/spear300-evb.dts        |    0
>  arch/arm/boot/dts/{ => st}/spear300.dtsi           |    0
>  arch/arm/boot/dts/{ => st}/spear310-evb.dts        |    0
>  arch/arm/boot/dts/{ => st}/spear310.dtsi           |    0
>  arch/arm/boot/dts/{ => st}/spear320-evb.dts        |    0
>  arch/arm/boot/dts/{ => st}/spear320-hmi.dts        |    0
>  arch/arm/boot/dts/{ => st}/spear320.dtsi           |    0
>  arch/arm/boot/dts/{ => st}/spear320s.dtsi          |    0
>  arch/arm/boot/dts/{ => st}/spear3xx.dtsi           |    0
>  arch/arm/boot/dts/{ => st}/spear600-evb.dts        |    0
>  arch/arm/boot/dts/{ => st}/spear600.dtsi           |    0

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

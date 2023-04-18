Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5510D6E6E19
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 23:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbjDRVZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 17:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjDRVZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 17:25:31 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002787DB2;
        Tue, 18 Apr 2023 14:25:30 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-38bef71c258so681590b6e.2;
        Tue, 18 Apr 2023 14:25:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681853130; x=1684445130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7yT4GcMjbrel2c9kDi9IQ9tl5o6MfO8exlHC9/eKTb0=;
        b=k/Z5+66qMsDCoDZ/e1TuCh3uIAnBEqUESOBjnGi165xwnXBlZoZk2WzDxKFin4zH1Y
         q1h1av5nprxjIJQsPpFk3FvEiVY+E8ZUmDQtgYkj/9Tl15asrFOcP1iPa4INZLIUf9Mb
         BsZxjLpa6saV6ZQ+N24GwHx5VWCkkV7u2v5pYiTAInKQuEJ8FbKFETT/JLBqUx51rLAv
         tlvoUEJLxI1YcwVW+DvIF/FvnXzT2jLJkM7Z7+ZzyoVdZWZPnsv4pwYS+88xwg0grAl1
         ociNeYNyypFAXUpqtEYQRNnKPY3JK2xZs7VmtS7R/rrpsIsXIACEp5D9Q3Y4Y9GVVXUF
         9vsA==
X-Gm-Message-State: AAQBX9d3tGsyfrH6qR20mffFcPLFe20HPawcnNExIpe6KEp2wLWT11Fm
        7cjFU+tLfr3l4/qnRni+bQ==
X-Google-Smtp-Source: AKy350bJbf7E4XDwA3/8131dQDn0lBGN26VByKnBFlDX2ebpKxcur0FYvrpyn2ImyGuSOquucrCuNQ==
X-Received: by 2002:a05:6808:ab7:b0:38c:17a7:5b80 with SMTP id r23-20020a0568080ab700b0038c17a75b80mr1621062oij.37.1681853130221;
        Tue, 18 Apr 2023 14:25:30 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v124-20020a4a5a82000000b0051ffe0fe11bsm6369196ooa.6.2023.04.18.14.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 14:25:29 -0700 (PDT)
Received: (nullmailer pid 2361549 invoked by uid 1000);
        Tue, 18 Apr 2023 21:25:27 -0000
Date:   Tue, 18 Apr 2023 16:25:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-renesas-soc@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Corentin Labbe <clabbe@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Andy Gross <agross@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Christophe Roullier <christophe.roullier@foss.st.com>,
        linux-amlogic@lists.infradead.org,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Fabio Estevam <festevam@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        Julius Werner <jwerner@chromium.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Jamie Iles <jamie@jamieiles.com>,
        Evan Benn <evanbenn@chromium.org>,
        =?UTF-8?B?77+9ZWNraQ==?= <rafal@milecki.pl>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sander Vanheule <sander@svanheule.net>,
        Fu Wei <fu.wei@linaro.org>, linux-watchdog@vger.kernel.org,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        devicetree@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Justin Chen <justinpopo6@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 2/6] dt-bindings: watchdog: indentation, quotes and
 white-space cleanup
Message-ID: <168185312747.2361485.10895999899602826593.robh@kernel.org>
References: <20230415095112.51257-1-krzysztof.kozlowski@linaro.org>
 <20230415095112.51257-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230415095112.51257-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 15 Apr 2023 11:51:08 +0200, Krzysztof Kozlowski wrote:
> Minor cleanup without functional impact:
> 1. Indent DTS examples to preferred four-spaces (more readable for DTS),
> 2. Drop unneeded quotes,
> 3. Add/drop blank lines to make the code readable.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../watchdog/amlogic,meson-gxbb-wdt.yaml      | 10 +++---
>  .../bindings/watchdog/arm,sbsa-gwdt.yaml      |  1 -
>  .../bindings/watchdog/arm,twd-wdt.yaml        |  6 ++--
>  .../bindings/watchdog/arm-smc-wdt.yaml        |  7 ++--
>  .../bindings/watchdog/atmel,sama5d4-wdt.yaml  | 14 ++++----
>  .../bindings/watchdog/brcm,bcm7038-wdt.yaml   |  6 ++--
>  .../bindings/watchdog/faraday,ftwdt010.yaml   | 16 +++++-----
>  .../watchdog/mediatek,mt7621-wdt.yaml         |  6 ++--
>  .../bindings/watchdog/qcom-wdt.yaml           | 32 +++++++++----------
>  .../bindings/watchdog/renesas,wdt.yaml        | 14 ++++----
>  .../bindings/watchdog/snps,dw-wdt.yaml        | 32 +++++++++----------
>  .../bindings/watchdog/st,stm32-iwdg.yaml      | 10 +++---
>  .../watchdog/xlnx,xps-timebase-wdt.yaml       | 12 +++----
>  13 files changed, 83 insertions(+), 83 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C576E6E1F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 23:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbjDRV0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 17:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjDRVZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 17:25:58 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA62CAD2A;
        Tue, 18 Apr 2023 14:25:56 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6a437526b7cso736408a34.1;
        Tue, 18 Apr 2023 14:25:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681853156; x=1684445156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1y++hWxszbxdwjn4XHYGat0BkERR+aOKZ06U2V4Qsw=;
        b=k90FYBV9gsqgdwoLmJmBHpp66eE1t6rY3To6AMTiSJAm1hj1suStxAPBlfrJw66ogL
         wOvSKbrf0qexGxJYS+FcAo0Uq3gi8gq/5AptIfjHSxlmVUBF1POSTt3Zup9VpvYLEm6M
         M7eDeDmBi+1Xg34SS0ByetxU130FekcGEy1gAKhrl96PBGKyFCmLDCl+MiSxHP8kOzUw
         WQoEOisv4V93jHlHaJBYrUQbdAeu7GNfwwxROhCSbzXDKetscfSQIqGS4M9ySFOkFoQO
         Z30wN4KOyV7DeaYblswvhzkQF6eNeQ6a1hi0fryyrGZLHnoj3anuTtTRTLUAQ2qONooj
         WIlQ==
X-Gm-Message-State: AAQBX9eBtdpzBIS/tXa/jcKlR0z0hgfz4cV5kiJjTCWEDsRZaQXm0SHG
        Y/vT1HD0uHsjSYMc4qVEbA==
X-Google-Smtp-Source: AKy350a/OTdllCATjmGezPT1m6bdviDcFkCirlifvfPn2ydSCEej4nyQRiMWdgkdCNUBPOZoo/lCZA==
X-Received: by 2002:a05:6870:b14d:b0:184:8536:ce54 with SMTP id a13-20020a056870b14d00b001848536ce54mr1896652oal.28.1681853156080;
        Tue, 18 Apr 2023 14:25:56 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e6-20020a056870944600b0017fea9c156esm6023892oal.18.2023.04.18.14.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 14:25:55 -0700 (PDT)
Received: (nullmailer pid 2362107 invoked by uid 1000);
        Tue, 18 Apr 2023 21:25:53 -0000
Date:   Tue, 18 Apr 2023 16:25:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-arm-kernel@lists.infradead.org,
        Anson Huang <Anson.Huang@nxp.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        =?UTF-8?B?77+9ZWNraQ==?= <rafal@milecki.pl>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Justin Chen <justinpopo6@gmail.com>,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>,
        devicetree@vger.kernel.org, Sander Vanheule <sander@svanheule.net>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Evan Benn <evanbenn@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Christophe Roullier <christophe.roullier@foss.st.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-renesas-soc@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Julius Werner <jwerner@chromium.org>,
        Jamie Iles <jamie@jamieiles.com>,
        linux-mediatek@lists.infradead.org,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-watchdog@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>, Fu Wei <fu.wei@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 3/6] dt-bindings: watchdog: arm,sp805: drop unneeded
 minItems
Message-ID: <168185315346.2362046.17065820066385103041.robh@kernel.org>
References: <20230415095112.51257-1-krzysztof.kozlowski@linaro.org>
 <20230415095112.51257-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230415095112.51257-3-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 15 Apr 2023 11:51:09 +0200, Krzysztof Kozlowski wrote:
> There is no need to specify minItems when they are equal to maxItems,
> because it is implied by maxItems.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/watchdog/arm,sp805.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


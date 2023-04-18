Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324D06E6E40
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 23:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbjDRVbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 17:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232608AbjDRVbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 17:31:06 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D9013875;
        Tue, 18 Apr 2023 14:30:41 -0700 (PDT)
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6a5f602a8f7so873481a34.1;
        Tue, 18 Apr 2023 14:30:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681853410; x=1684445410;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6SgIob3ZbJ9A9DbSdga+gd14f2Z3RSbkiShhGJVWvl4=;
        b=VbxBjzLxKhT7J07s/N/t/4tt7fgahs7HTdcuwTKaaueWYOMIAnOXC1VjUYBggrn9PF
         Hxk/yPew42ekJHh5QqxUXueOFY5cGzaIfWN32toPlyWM+QSGBAaUN5WEqLmAJDQZT5lM
         fKXO/JciU3doY/l0wt7kCAPJzuC7i/eiukJU+5Oq0lFbk9/QxbeGYQ3d/95/JihmI/cJ
         vT0qukmrTP5JoCU/1g6Kf0bJnyFO6VPHk6OG72tEzxv0IOpVFiD4/9meQSMOC1wKDOLn
         E1FyihOI7dBHEIXAGJAEw5S8lIiV/vid4ZtVLkahhPXqe7eLx+yBYHIpanTBOWmSVnEa
         SpNQ==
X-Gm-Message-State: AAQBX9dW89ptJbBVt/d48H6xwwOh7WK/bR7Ot9UBzZRXSKFxve9f0QgJ
        BF5Lce5YwwQE+UoMwwOvDA==
X-Google-Smtp-Source: AKy350aReJVaibAghZiN+VSoVRy43DPIB7GVh66FFWas1Pk9GeRCRwxzczKHwH8CDiBT6m+naiEd7w==
X-Received: by 2002:a05:6870:2191:b0:187:89c5:1eef with SMTP id l17-20020a056870219100b0018789c51eefmr1880813oae.34.1681853409910;
        Tue, 18 Apr 2023 14:30:09 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q4-20020a056870e60400b0016e49af5815sm5958219oag.51.2023.04.18.14.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 14:30:08 -0700 (PDT)
Received: (nullmailer pid 2366687 invoked by uid 1000);
        Tue, 18 Apr 2023 21:30:07 -0000
Date:   Tue, 18 Apr 2023 16:30:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Sander Vanheule <sander@svanheule.net>,
        Justin Chen <justinpopo6@gmail.com>,
        Jamie Iles <jamie@jamieiles.com>,
        linux-mediatek@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Julius Werner <jwerner@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-renesas-soc@vger.kernel.org,
        Srinivas Neeli <srinivas.neeli@xilinx.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        NXP Linux Team <linux-imx@nxp.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-msm@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Robert Marko <robert.marko@sartura.hr>,
        =?UTF-8?B?77+9ZWNraQ==?= <rafal@milecki.pl>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-watchdog@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Christophe Roullier <christophe.roullier@foss.st.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        linux-amlogic@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Fu Wei <fu.wei@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        devicetree@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Evan Benn <evanbenn@chromium.org>
Subject: Re: [PATCH 4/6] dt-bindings: watchdog: fsl-imx7ulp-wdt: simplify
 with unevaluatedProperties
Message-ID: <168185340654.2366635.7606572133355407089.robh@kernel.org>
References: <20230415095112.51257-1-krzysztof.kozlowski@linaro.org>
 <20230415095112.51257-4-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230415095112.51257-4-krzysztof.kozlowski@linaro.org>
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


On Sat, 15 Apr 2023 11:51:10 +0200, Krzysztof Kozlowski wrote:
> Allow generic watchdog properties by using unevaluatedProperties: false.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/watchdog/fsl-imx7ulp-wdt.yaml         | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


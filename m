Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6AC678850
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 21:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbjAWUgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 15:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbjAWUgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 15:36:23 -0500
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830D12A161;
        Mon, 23 Jan 2023 12:36:20 -0800 (PST)
Received: by mail-oo1-f43.google.com with SMTP id x15-20020a4ab90f000000b004e64a0a967fso2324740ooo.2;
        Mon, 23 Jan 2023 12:36:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BXZOruu8vF1W3OHoGHeuELt144xNWCjFLx25df7cNag=;
        b=vlAMRsYdluzIRbloUome+/xE62dCb4DIFtiiSHGlMULm3DjnoVU0vrJLQIN/J8vc6U
         0bEI34x/+1EtMBgSR47ikGAsTvR624cm9HglzNl9d8+/iEe3kVuH9o3XX3UbkZ0X8QVU
         b3TuJPi5tyr6kdiHvGnwQDBVpDbh42jSB4ff8B+3LiW78JeZAfNaJePz0RmkYl9hc32y
         GyLk/4D7H27jPsAH8n8/mQPOPW+B000PcxOq7wPjQ8137J1Nm5Z5syD08VTzRHwxQU6s
         HtYCsK+e0JDgaORol7yhyO/IKnfkVVHO1KGQp1nOzy1wDRvIbU9Bkl0jzGtPQcd8VIr8
         csbQ==
X-Gm-Message-State: AFqh2kqiAF9MA5rqeA8fT0/05pa4PBikGI7phhuI1UBOyNnuY7p4UQPG
        BrEuyaWnFIbM4DUO22t9XQ==
X-Google-Smtp-Source: AMrXdXsQsX0gehByiSzM0/8Tzq5eTS+0xo4CAjG2uqTJ/9s2lJxIUAfMzhqyCU0LuoeA5R/gbj4sbg==
X-Received: by 2002:a4a:e842:0:b0:4f9:c06:7cec with SMTP id m2-20020a4ae842000000b004f90c067cecmr11587519oom.0.1674506179527;
        Mon, 23 Jan 2023 12:36:19 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h46-20020a4a9431000000b005006f6771e6sm37107ooi.8.2023.01.23.12.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 12:36:19 -0800 (PST)
Received: (nullmailer pid 2480201 invoked by uid 1000);
        Mon, 23 Jan 2023 20:36:17 -0000
Date:   Mon, 23 Jan 2023 14:36:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Dragos Bogdan <dragos.bogdan@analog.com>,
        Sankar Velliangiri <navin@linumiz.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Eugene Zaikonnikov <ez@norophonic.com>,
        linux-samsung-soc@vger.kernel.org,
        Lucas Stankus <lucas.p.stankus@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        devicetree@vger.kernel.org,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        kernel@pengutronix.de, Miquel Raynal <miquel.raynal@bootlin.com>,
        Stefan Agner <stefan@agner.ch>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Nishant Malpani <nish.malpani25@gmail.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Sean Nyekjaer <sean@geanix.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Lazar <alazar@startmail.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        linux-iio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Phil Reid <preid@electromag.com.au>,
        chrome-platform@lists.linux.dev,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Robert Yang <decatf@gmail.com>,
        linux-renesas-soc@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Philippe Reynes <tremyfr@yahoo.fr>,
        Renato Lui Geh <renatogeh@gmail.com>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Andreas Klinger <ak@it-klinger.de>,
        linux-arm-kernel@lists.infradead.org,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-fbdev@vger.kernel.org,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Kent Gustavsson <kent@minoris.se>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Stefan Popa <stefan.popa@analog.com>,
        Artur Rojek <contact@artur-rojek.eu>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Harald Geyer <harald@ccbib.org>,
        Puranjay Mohan <puranjay12@gmail.com>
Subject: Re: [PATCH 3/5] dt-bindings: iio: correct node names in examples
Message-ID: <167450608749.2477833.17695901473190509950.robh@kernel.org>
References: <20230118184413.395820-1-krzysztof.kozlowski@linaro.org>
 <20230118184413.395820-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118184413.395820-3-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 18 Jan 2023 19:44:11 +0100, Krzysztof Kozlowski wrote:
> Do not use underscores and unneeded suffixes (e.g. i2c0) in node name in
> examples.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/iio/accel/adi,adis16201.yaml      | 2 +-
>  .../devicetree/bindings/iio/accel/adi,adis16240.yaml      | 2 +-
>  .../devicetree/bindings/iio/accel/adi,adxl313.yaml        | 2 +-
>  .../devicetree/bindings/iio/accel/adi,adxl345.yaml        | 4 ++--
>  .../devicetree/bindings/iio/accel/bosch,bma220.yaml       | 2 +-
>  .../devicetree/bindings/iio/accel/nxp,fxls8962af.yaml     | 4 ++--
>  Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml | 2 +-
>  Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml | 2 +-
>  Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml | 2 +-
>  .../devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml       | 2 +-
>  .../devicetree/bindings/iio/adc/st,stmpe-adc.yaml         | 8 +++-----
>  .../devicetree/bindings/iio/frequency/adf4371.yaml        | 2 +-
>  .../devicetree/bindings/iio/gyroscope/nxp,fxas21002c.yaml | 4 ++--
>  .../devicetree/bindings/iio/health/ti,afe4403.yaml        | 2 +-
>  .../devicetree/bindings/iio/health/ti,afe4404.yaml        | 2 +-
>  Documentation/devicetree/bindings/iio/humidity/dht11.yaml | 2 +-
>  .../devicetree/bindings/iio/humidity/ti,hdc2010.yaml      | 2 +-
>  .../devicetree/bindings/iio/imu/adi,adis16460.yaml        | 2 +-
>  .../devicetree/bindings/iio/imu/invensense,icm42600.yaml  | 4 ++--
>  .../devicetree/bindings/iio/imu/nxp,fxos8700.yaml         | 4 ++--
>  .../devicetree/bindings/iio/pressure/asc,dlhl60d.yaml     | 2 +-
>  .../devicetree/bindings/iio/pressure/bmp085.yaml          | 2 +-
>  .../bindings/iio/temperature/maxim,max31865.yaml          | 2 +-
>  23 files changed, 30 insertions(+), 32 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

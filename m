Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8336787F1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 21:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbjAWUfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 15:35:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbjAWUft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 15:35:49 -0500
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC33A8690;
        Mon, 23 Jan 2023 12:35:47 -0800 (PST)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-15f64f2791dso15378251fac.7;
        Mon, 23 Jan 2023 12:35:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bqUWksinymEVfLReKJJtCyYWWLZ6cx8j3ymD6Z3V0yc=;
        b=5buK6GITVl+Nj+yB7C1cfpAl3OJNGmZUheZ6f2K1kPMrkxe6J1Ieh2RIZTM5PFLTT/
         lUxSTkgwfzxz2HcLvt7wEMRtf6fQ0RGb9AIVguN/xZRyUdz+IqSFCMmxk93tEyV6xEi7
         ls7umcYEQaoQePWzh3a31/llYebdGZr+1U0JP1JCCrVU3dvcLZVnsqMGCNEx1oAJcDpK
         alJ6h/pCNYlEmDiJTKypT0/96/IY33y+UK32TDEr9JpyYtkDLw+8vbk5y4cDUC5sjJ2E
         +VfAz6vs2bvkaMpoucYQd/NYr7grlupVjxly7GEyd6jw0PoOFy5xViHnkAeAJPJpOeif
         EEFQ==
X-Gm-Message-State: AFqh2koL7JuUY0yWDrtWIbXVcqv9xP1RjiF60derlYOORqFMCKbf14XI
        c8sVrcL6SJ6jtjhVnCp0rQ==
X-Google-Smtp-Source: AMrXdXsvDCFsbVFw+eJ2cbyJwAUV1dOFiwlLrgu1CNnxj6xXm20ORfJFg1UiQgks29vH4SbJm/yNBA==
X-Received: by 2002:a05:6870:2f02:b0:155:a38f:70d1 with SMTP id qj2-20020a0568702f0200b00155a38f70d1mr12278017oab.18.1674506147053;
        Mon, 23 Jan 2023 12:35:47 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v11-20020a056870310b00b00144e6ffe9e5sm9358140oaa.47.2023.01.23.12.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 12:35:46 -0800 (PST)
Received: (nullmailer pid 2479493 invoked by uid 1000);
        Mon, 23 Jan 2023 20:35:44 -0000
Date:   Mon, 23 Jan 2023 14:35:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Stefan Agner <stefan@agner.ch>,
        Sean Nyekjaer <sean@geanix.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Phil Reid <preid@electromag.com.au>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Philippe Reynes <tremyfr@yahoo.fr>, devicetree@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        ", Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Benson Leung <bleung@chromium.org>,
        Stefan Popa <stefan.popa@analog.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Harald Geyer <harald@ccbib.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-fbdev@vger.kernel.org,
        Eugene Zaikonnikov <ez@norophonic.com>,
        linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        linux-samsung-soc@vger.kernel.org, Robert Yang <decatf@gmail.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Kent Gustavsson <kent@minoris.se>,
        Lucas Stankus <lucas.p.stankus@gmail.com>,
        Artur Rojek <contact@artur-rojek.eu>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Renato Lui Geh <renatogeh@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-iio@vger.kernel.org, kernel@pengutronix.de,
        Dragos Bogdan <dragos.bogdan@analog.com>,
        Guenter Roeck <groeck@chromium.org>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        chrome-platform@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Alexandru Lazar <alazar@startmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nishant Malpani <nish.malpani25@gmail.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Sankar Velliangiri <navin@linumiz.com>,
        linux-kernel@vger.kernel.org,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        linux-renesas-soc@vger.kernel.org,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: Re: [PATCH 4/5] dt-bindings: iio: use lowercase hex in examples
Message-ID: <167450611717.2478620.14360335395859339085.robh@kernel.org>
References: <20230118184413.395820-1-krzysztof.kozlowski@linaro.org>
 <20230118184413.395820-4-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118184413.395820-4-krzysztof.kozlowski@linaro.org>
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


On Wed, 18 Jan 2023 19:44:12 +0100, Krzysztof Kozlowski wrote:
> Use lowercase hex in addresses in examples.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/iio/accel/kionix,kxcjk1013.yaml     | 2 +-
>  .../devicetree/bindings/iio/adc/samsung,exynos-adc.yaml     | 2 +-
>  Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml   | 2 +-
>  .../devicetree/bindings/iio/potentiometer/adi,ad5272.yaml   | 2 +-
>  .../devicetree/bindings/iio/temperature/adi,ltc2983.yaml    | 6 +++---
>  5 files changed, 7 insertions(+), 7 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D967667879E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 21:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbjAWUVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 15:21:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbjAWUVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 15:21:35 -0500
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A6136684;
        Mon, 23 Jan 2023 12:21:33 -0800 (PST)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-15f97c478a8so15267848fac.13;
        Mon, 23 Jan 2023 12:21:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RIXb14l8qXPqTW/PtL9Jyd2nlt/GYyXK1O+1ZgxBBnc=;
        b=McQH21JPnbuAuNXb1Ie2XbfVfbVuhJlmTgwVeJl71mwTt5ttYk9pFtm6MUjVDfve4A
         A44e/pXHe1qZmavmcpcGtiwg3wDN7GkydATN3sN3RuGuE35VlAtbTtNOY3A3YMn2nTIf
         Mers7w0OkVvIioCDXdD8pqbCDZUVx67CEWxgTEaPgOCFFqk5EZIpgeKHvMUwArV9Mnfy
         G+u08tc3YTVEd09t4kkWCPPGyRI9BhHsUsCCo5ewhbDzVZViwkjOe8K+q2nGqeTUn//W
         eLqbuz3APZmBCIevacZmTubgl2a7KzZW0ZOpEpoS/ittFqhkSzIj7MA4EUq5wCT9d7P/
         cjng==
X-Gm-Message-State: AFqh2kpl58fWEHvN6EtqrFgyD6RgUySGDOc55v8nqqYZnV80Yrb5wgqj
        nRHuWRDZsifoXrXfVeHtRw==
X-Google-Smtp-Source: AMrXdXuK8kDdEc2x7uYT25rzCUabXOb/nurq2zZCYeuPju4G3OhwCu+TOZB5uMPQMcHtcgqdDT83XQ==
X-Received: by 2002:a05:6870:3d96:b0:14f:eb44:afde with SMTP id lm22-20020a0568703d9600b0014feb44afdemr13270485oab.26.1674505292384;
        Mon, 23 Jan 2023 12:21:32 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o41-20020a056870912900b0015f9cc16ef7sm7295004oae.46.2023.01.23.12.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 12:21:31 -0800 (PST)
Received: (nullmailer pid 2459648 invoked by uid 1000);
        Mon, 23 Jan 2023 20:21:30 -0000
Date:   Mon, 23 Jan 2023 14:21:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Dragos Bogdan <dragos.bogdan@analog.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        ", Jean-Baptiste Maneyrol" <jmaneyrol@invensense.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Artur Rojek <contact@artur-rojek.eu>,
        Stefan Popa <stefan.popa@analog.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Andreas Klinger <ak@it-klinger.de>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-samsung-soc@vger.kernel.org,
        Nishant Malpani <nish.malpani25@gmail.com>,
        ", Michael Hennerich" <Michael.Hennerich@analog.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        chrome-platform@lists.linux.dev, Kent Gustavsson <kent@minoris.se>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alexandru Lazar <alazar@startmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lucas Stankus <lucas.p.stankus@gmail.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Robert Yang <decatf@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-iio@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Philippe Reynes <tremyfr@yahoo.fr>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        linux-kernel@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
        Sean Nyekjaer <sean@geanix.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        "linux-renesas-soc@vger.kernel.org , Stefan Agner" <stefan@agner.ch>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        linux-fbdev@vger.kernel.org, Renato Lui Geh <renatogeh@gmail.com>,
        Phil Reid <preid@electromag.com.au>,
        Harald Geyer <harald@ccbib.org>,
        Sankar Velliangiri <navin@linumiz.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Eugene Zaikonnikov <ez@norophonic.com>, kernel@pengutronix.de,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Puranjay Mohan <puranjay12@gmail.com>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Subject: Re: [PATCH 2/5] dt-bindings: iio: minor whitespace cleanups
Message-ID: <167450528964.2459590.15791649664134666125.robh@kernel.org>
References: <20230118184413.395820-1-krzysztof.kozlowski@linaro.org>
 <20230118184413.395820-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118184413.395820-2-krzysztof.kozlowski@linaro.org>
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


On Wed, 18 Jan 2023 19:44:10 +0100, Krzysztof Kozlowski wrote:
> Drop redundant blank lines and add such when needed.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/iio/dac/adi,ad5380.yaml        | 1 +
>  .../bindings/iio/proximity/google,cros-ec-mkbp-proximity.yaml    | 1 -
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

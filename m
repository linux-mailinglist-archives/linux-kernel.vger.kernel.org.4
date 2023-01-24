Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6252678DC7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 02:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbjAXByk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 20:54:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjAXByi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 20:54:38 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D1E39BA3;
        Mon, 23 Jan 2023 17:54:31 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id n24-20020a0568301e9800b006865671a9d5so8422067otr.6;
        Mon, 23 Jan 2023 17:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1SIlV76DVxeq/C35+t24zRKgN1DEZm4VgHWvTfe7RPk=;
        b=l7NNGsr1JQuzUnc25Wtd9Awtmf42my7g2nvhiZ0bzAIgkjx6lp88NC5FHN7pPgY82k
         G542R43Ae3PgKGJh1Cs5N3kgZrdwccgTwEquohn8UL+0w2Mm8KZoVhQLSiSAi+Ixjrix
         Rjpo/AGoTe7VNNmIEOM8ujjMoLam1cMsaId4YrJ8TmzGR3PYNCO/lmyQgrKrtEnBIOpi
         e6jWB0NLfojhUcOftYFok+T6clN0RR1YMmvzXpJlItmt6SMUsvBThcYtLLjkmGyD/1UG
         6NUXH77gXICtHggfPzx/oCL65F+AdQkxevZSNAEDgXzCv2ifhndexxbmSk7RtPeqEn8T
         e5xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1SIlV76DVxeq/C35+t24zRKgN1DEZm4VgHWvTfe7RPk=;
        b=bEedwFrNbgY5o0Ol8yMOPqAcRJkhMpNEIll8tsYchpsYEXBbgtXaoQNPucFqaktPWi
         O+fKJuxyV/6qnTxMuAnWjU6EpkDz28apZMfiulD5KKErGjkVZr/o21INQDV+ldv9SvqH
         +bKTvI4aGP1+FCoO365x/mIwfSLG0RE1FUelxi63QZlmPIhO6ogLYcrelx2FscdIdSGy
         femZEfTVOLpOxBp4buuA0t8yZv9SX0QI7i5u2bYjqiRVFEV7JxL0lJUMAr4mrPvPZCvV
         XSBb9yLWFviRHKem2wD5U4RIgCxr5I/abJfSRq8HS6LDgxXAGkyg1jOE+Pmxb3+97jgO
         I7kg==
X-Gm-Message-State: AFqh2kqOzV3j+j+odKnhYPQ7GT8lj8+Nn2/N86iQWyGM7RsKR5/vYMBC
        jUdTb84CYOjkPRU/G6Rg5Zc=
X-Google-Smtp-Source: AMrXdXv0I+2WnACwWrMr9nYYPOZnq5pzy3Uspbg1ghHol1K/v8O+Swkxm8uHb0X/rKx0GxMcZRtRrA==
X-Received: by 2002:a05:6830:18e6:b0:67f:e4ff:2996 with SMTP id d6-20020a05683018e600b0067fe4ff2996mr11221961otf.12.1674525271116;
        Mon, 23 Jan 2023 17:54:31 -0800 (PST)
Received: from localhost ([2804:30c:b10:f300:3241:5b01:98c4:5294])
        by smtp.gmail.com with ESMTPSA id s13-20020a05683004cd00b00686543d0f04sm393165otd.21.2023.01.23.17.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 17:54:30 -0800 (PST)
Date:   Mon, 23 Jan 2023 22:54:23 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lucas Stankus <lucas.p.stankus@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Renato Lui Geh <renatogeh@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Oleksij Rempel <linux@rempel-privat.de>, kernel@pengutronix.de,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Nishant Malpani <nish.malpani25@gmail.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Dragos Bogdan <dragos.bogdan@analog.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Stefan Popa <stefan.popa@analog.com>,
        Robert Yang <decatf@gmail.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Artur Rojek <contact@artur-rojek.eu>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Philippe Reynes <tremyfr@yahoo.fr>,
        Alexandru Lazar <alazar@startmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Stefan Agner <stefan@agner.ch>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Harald Geyer <harald@ccbib.org>,
        Eugene Zaikonnikov <ez@norophonic.com>,
        Phil Reid <preid@electromag.com.au>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Sankar Velliangiri <navin@linumiz.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        chrome-platform@lists.linux.dev
Subject: Re: [PATCH 1/5] dt-bindings: iio: drop unneeded quotes
Message-ID: <Y886T3/2Gu0k7XQN@marsc.168.1.7>
References: <20230118184413.395820-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118184413.395820-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/18, Krzysztof Kozlowski wrote:
> Cleanup by removing unneeded quotes from refs and redundant blank lines.
> No functional impact except adjusting to preferred coding style.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/iio/accel/memsensing,msa311.yaml  | 5 ++---
>  Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml | 2 +-
>  Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml | 2 +-
>  .../devicetree/bindings/iio/adc/atmel,sama5d2-adc.yaml    | 2 +-
>  Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml | 4 ++--
>  .../devicetree/bindings/iio/adc/ingenic,adc.yaml          | 4 ++--
>  .../devicetree/bindings/iio/adc/microchip,mcp3911.yaml    | 4 ++--
>  .../devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml    | 2 +-
>  .../devicetree/bindings/iio/adc/samsung,exynos-adc.yaml   | 2 +-
>  .../devicetree/bindings/iio/adc/st,stm32-adc.yaml         | 8 ++++----
>  .../devicetree/bindings/iio/adc/ti,ads131e08.yaml         | 2 +-
>  Documentation/devicetree/bindings/iio/adc/ti,tsc2046.yaml | 2 +-
>  .../devicetree/bindings/iio/dac/lltc,ltc1660.yaml         | 4 ++--
>  .../devicetree/bindings/iio/dac/lltc,ltc2632.yaml         | 4 ++--
>  .../devicetree/bindings/iio/dac/st,stm32-dac.yaml         | 4 ++--
>  Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml | 2 +-
>  .../devicetree/bindings/iio/temperature/ti,tmp117.yaml    | 6 +++---
>  17 files changed, 29 insertions(+), 30 deletions(-)
> 

For adi,ad7292.yaml
Acked-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

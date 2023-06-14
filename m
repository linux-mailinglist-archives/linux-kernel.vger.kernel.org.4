Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6537B7307F8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 21:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbjFNTSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 15:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjFNTSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 15:18:13 -0400
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4DF2682;
        Wed, 14 Jun 2023 12:18:12 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-777a78739ccso387408039f.3;
        Wed, 14 Jun 2023 12:18:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686770292; x=1689362292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YBpMMsjcbe1wo6wOZhJlr/oSYFVntydqWqDrNGep1l0=;
        b=BqhS7xA7T6RbrmqgQMKjBoqmWZ1RQwQxUcJ1HwbrBIQpo7J1Ech+GIvw3+nrmKux5x
         b2sWZ0FLaTadYyaKIC/J74/XRpuABvGw09cQ5gCzKp1P132FBzjblYON6ZBSa9l4rQNn
         qCHRO3oe3fjXsYxs7yI6Jtwh7ZxkTsjrbCstJybrhFYYHMNOlinL9VN+iRWJ8kq6HLZ1
         /Qa3DAhtPWA0pDV7E0LE5Zy6Sy7LcN3oC1U9rCUJwn+Pot7LiF18d4v/RsJ4cODUznkv
         3g3ZzIHgGA5MuboJ/DhHQRrniU01/bcVmdO9hf5AUcoCwgDc17ccvtzOFr5oA82o8Qu8
         8w1g==
X-Gm-Message-State: AC+VfDzlPpeV70SVe2a8G2hR976hUdWxw3Mx7as+UNOaFLR25cHIPJv0
        Bgw1mSnTZ0GQAExvwttTFQ==
X-Google-Smtp-Source: ACHHUZ5c57N/o0GzC8aXwuQsvNktRZIXbCA+u83AThjFLnR3buYrBFGMs/uzsSp0OtJJ2l8Rq3rG3w==
X-Received: by 2002:a05:6602:299a:b0:776:cfd8:b44a with SMTP id o26-20020a056602299a00b00776cfd8b44amr16111912ior.8.1686770291867;
        Wed, 14 Jun 2023 12:18:11 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id b8-20020a02c988000000b0041f5ff08660sm5160476jap.141.2023.06.14.12.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 12:18:11 -0700 (PDT)
Received: (nullmailer pid 2587113 invoked by uid 1000);
        Wed, 14 Jun 2023 19:18:08 -0000
Date:   Wed, 14 Jun 2023 13:18:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, kernel@pengutronix.de,
        Peng Fan <peng.fan@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Mark Brown <broonie@kernel.org>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Anson Huang <Anson.Huang@nxp.com>, Marek Vasut <marex@denx.de>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-input@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCH v1 6/7] dt-bindings: clock: imx6q: Allow single optional
 clock and add enet_ref_pad
Message-ID: <20230614191808.GA2581397-robh@kernel.org>
References: <20230601101451.357662-1-o.rempel@pengutronix.de>
 <20230601101451.357662-7-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601101451.357662-7-o.rempel@pengutronix.de>
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

On Thu, Jun 01, 2023 at 12:14:50PM +0200, Oleksij Rempel wrote:
> All clocks for this driver are optional, so this change allows the

It's not about what the driver supports, but the h/w. You are saying 
this SoC can operate with only 1 of any of the clock inputs?

> 'clocks' and 'clock-names' properties to accept a single clock.
> Additionally, 'enet_ref_pad' clock is added. This resolves the following
> dtbs_check warning:
>   imx6dl-alti6p.dtb: clock-controller@20c4000: clocks: [[24]] is too short
>   From schema: Documentation/devicetree/bindings/clock/imx6q-clock.yaml
> 
>   imx6dl-alti6p.dtb: clock-controller@20c4000: clock-names:0: 'osc' was
>     expected
>   From schema: Documentation/devicetree/bindings/clock/imx6q-clock.yaml
> 
>   imx6dl-alti6p.dtb: clock-controller@20c4000: clock-names:
>     ['enet_ref_pad'] is too short
>   From schema: Documentation/devicetree/bindings/clock/imx6q-clock.yaml
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  .../devicetree/bindings/clock/imx6q-clock.yaml    | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/imx6q-clock.yaml b/Documentation/devicetree/bindings/clock/imx6q-clock.yaml
> index bae4fcb3aacc..ed65d19c2e0e 100644
> --- a/Documentation/devicetree/bindings/clock/imx6q-clock.yaml
> +++ b/Documentation/devicetree/bindings/clock/imx6q-clock.yaml
> @@ -28,20 +28,23 @@ properties:
>      const: 1
>  
>    clocks:
> +    minItems: 1
>      items:
>        - description: 24m osc
>        - description: 32k osc
>        - description: ckih1 clock input
>        - description: anaclk1 clock input
>        - description: anaclk2 clock input
> +      - description: enet_ref_pad
>  
>    clock-names:
> -    items:
> -      - const: osc
> -      - const: ckil
> -      - const: ckih1
> -      - const: anaclk1
> -      - const: anaclk2
> +    enum:
> +      - osc
> +      - ckil
> +      - ckih1
> +      - anaclk1
> +      - anaclk2
> +      - enet_ref_pad
>  
>    fsl,pmic-stby-poweroff:
>      $ref: /schemas/types.yaml#/definitions/flag
> -- 
> 2.39.2
> 

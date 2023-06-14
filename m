Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F007307C2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 21:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbjFNTEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 15:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234140AbjFNTDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 15:03:54 -0400
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEEE2130;
        Wed, 14 Jun 2023 12:03:40 -0700 (PDT)
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-33b3f2f7989so28720555ab.0;
        Wed, 14 Jun 2023 12:03:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686769420; x=1689361420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jU8Y2sdZDfv7N4GPggg1x+Z5N7QIIfRO7/8zpUyBMd0=;
        b=R9APLsWUtJoyBwF+/0/3+XIN5R1sTRxHm0tMm4e9/R7DjjUut7ujFumjCXdgO2XXuX
         LZa2cRHWH+Pm0rvOcb70TXao9HjRRxCT6yxzr9biII8Qae2hBDEICyp2n+TZ9DzDI3Yz
         JSGSSMUhsIPLFqdVCxp+RkVgF+s1o1KXiLRmFfz1/vg/55gXE3GIETmnXcdSQaQk0Kue
         Ig0/iCi0C1xzYGtwHc/3r7wmnhLWIP/dFXX/fXRHKbFQ/e3pTSnzIVycYfed6FcDs30q
         BwurtrgTWbaTC69kcnCliQKaLklsv88iPB2r0SCrt5qiDFXjMV0O9crC4zIIas829/uM
         5GcQ==
X-Gm-Message-State: AC+VfDwL8uRhbTdEtUI3eLz5WviEkY2u0x3aWdwiKvZ9+L11Sx8Zqwlk
        sv8cQm2AJk/dkrbIYVsvO9nz3/n8Qw==
X-Google-Smtp-Source: ACHHUZ6IWp2IJvLymrUkZkP3sUZu5ZIgw/yQewsjouigJZKA4GqPN7z8wafo9EKvyTFUOwtRoMrY8g==
X-Received: by 2002:a92:7302:0:b0:33d:3b69:2d28 with SMTP id o2-20020a927302000000b0033d3b692d28mr12644439ilc.29.1686769419870;
        Wed, 14 Jun 2023 12:03:39 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id o11-20020a92dacb000000b0033af84e6321sm5551778ilq.64.2023.06.14.12.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 12:03:39 -0700 (PDT)
Received: (nullmailer pid 2565014 invoked by uid 1000);
        Wed, 14 Jun 2023 19:03:36 -0000
Date:   Wed, 14 Jun 2023 13:03:36 -0600
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
Subject: Re: [PATCH v1 3/7] dt-bindings: timer: gpt: Support 3rd clock for
 i.MX6DL
Message-ID: <20230614190336.GA2561906-robh@kernel.org>
References: <20230601101451.357662-1-o.rempel@pengutronix.de>
 <20230601101451.357662-4-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601101451.357662-4-o.rempel@pengutronix.de>
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

On Thu, Jun 01, 2023 at 12:14:47PM +0200, Oleksij Rempel wrote:
> Add support for a 3rd clock, 'osc_per', for i.MX6DL to the 'fsl,imxgpt'
> binding to resolve the following dtbs_check warning:
>   imx6dl-alti6p.dtb: timer@2098000: clocks: [[2, 119], [2, 120], [2, 237]]
>     is too long
>   From schema: Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
>   imx6dl-alti6p.dtb: timer@2098000: clock-names: ['ipg', 'per', 'osc_per']
>     is too long
>   From schema: Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  .../devicetree/bindings/timer/fsl,imxgpt.yaml | 22 ++++++++++++++-----
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml b/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
> index adf617b8f353..21ff51c3f38f 100644
> --- a/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
> +++ b/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
> @@ -46,14 +46,24 @@ properties:
>      maxItems: 1
>  
>    clocks:
> -    items:
> -      - description: SoC GPT ipg clock
> -      - description: SoC GPT per clock
> +    anyOf:

No need for anyOf. Just add the 3rd entry and 'minItems: 2'.

> +      - items:
> +          - description: SoC GPT ipg clock
> +          - description: SoC GPT per clock
> +      - items:
> +          - description: SoC GPT ipg clock
> +          - description: SoC GPT per clock
> +          - description: SoC GPT osc_per clock
>  
>    clock-names:
> -    items:
> -      - const: ipg
> -      - const: per
> +    anyOf:
> +      - items:
> +          - const: ipg
> +          - const: per
> +      - items:
> +          - const: ipg
> +          - const: per
> +          - const: osc_per
>  
>  required:
>    - compatible
> -- 
> 2.39.2
> 

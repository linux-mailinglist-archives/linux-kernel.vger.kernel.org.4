Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECAF37307E1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 21:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235242AbjFNTNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 15:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjFNTNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 15:13:49 -0400
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A571BFD;
        Wed, 14 Jun 2023 12:13:48 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-77b6e2f0c9fso74778839f.1;
        Wed, 14 Jun 2023 12:13:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686770028; x=1689362028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=69i3gF2aa9gLEhqJ8vGcBYKwa3/nKacy0WKaQtHM3c8=;
        b=T4mzzyzPzA1aTjPjm8me0awLWoePMHEQWh83ohM8YpEbhDCwP5N1MFca7KVz1qM9yT
         zGAaqMSpi+ulRSFf6EWd6AjGx47xIBMDCZEPx2y7ssNnTbZ8h7rUgOFFkEmcVKmCQuW4
         WPoBj4wTB7t6Pl8gEjWG8rpDfR75Tu4ZuFdXLR64DE2+LFyETwikKSw6+nXHi/mSA5Nw
         /JBefYPHQJi4WNJuYcC/zTmMxTKrNoa2GZhAXCzw+3XwC8z22s24tNaEaAa9nQv3MAKd
         9zLptYPB84IRcSbAiijBb8MSBEChgBoG9/vAWbvLWIvXF+PziCa3C0ZCtDi1ddjGPDUE
         9WRA==
X-Gm-Message-State: AC+VfDwY62tQSVehScMY+b+lQsJ5wg3NAKItON+d/kRkcIOCe/s8arm2
        urMB+x2rMH5GFHnOujCmd0Y8WinrsQ==
X-Google-Smtp-Source: ACHHUZ6fEDxxe0686b9vWNAnOOTsDBT8D+eDaFY+2OLBohxA0tNlwwAEuLob8bMoz+GfFsSeeXXv5Q==
X-Received: by 2002:a6b:ef0b:0:b0:776:2ee:4c63 with SMTP id k11-20020a6bef0b000000b0077602ee4c63mr12117781ioh.15.1686770028056;
        Wed, 14 Jun 2023 12:13:48 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id t13-20020a5edd0d000000b0076373f90e46sm5561234iop.33.2023.06.14.12.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 12:13:47 -0700 (PDT)
Received: (nullmailer pid 2581244 invoked by uid 1000);
        Wed, 14 Jun 2023 19:13:44 -0000
Date:   Wed, 14 Jun 2023 13:13:44 -0600
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
Subject: Re: [PATCH v1 5/7] dt-bindings: clock: imx6ul: Support optional
 enet*_ref_pad clocks
Message-ID: <20230614191344.GA2579146-robh@kernel.org>
References: <20230601101451.357662-1-o.rempel@pengutronix.de>
 <20230601101451.357662-6-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601101451.357662-6-o.rempel@pengutronix.de>
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

On Thu, Jun 01, 2023 at 12:14:49PM +0200, Oleksij Rempel wrote:
> Extend the 'clocks' and 'clock-names' properties to support optional
> 'enet1_ref_pad' and 'enet2_ref_pad' clocks to resolve the following
> dtbs_check warning:
>   imx6ul-prti6g.dtb: clock-controller@20c4000: clocks: [[17], [18], [19],
>     [20], [21]] is too long
>   From schema: Documentation/devicetree/bindings/clock/imx6ul-clock.yaml
> 
>   imx6ul-prti6g.dtb: clock-controller@20c4000: clock-names: ['ckil',
>     'osc', 'ipp_di0', 'ipp_di1', 'enet1_ref_pad'] is too long
>   From schema: Documentation/devicetree/bindings/clock/imx6ul-clock.yaml
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/clock/imx6ul-clock.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/imx6ul-clock.yaml b/Documentation/devicetree/bindings/clock/imx6ul-clock.yaml
> index be54d4df5afa..d6a36fe575d3 100644
> --- a/Documentation/devicetree/bindings/clock/imx6ul-clock.yaml
> +++ b/Documentation/devicetree/bindings/clock/imx6ul-clock.yaml
> @@ -28,18 +28,24 @@ properties:
>      const: 1
>  
>    clocks:
> +    minItems: 4
>      items:
>        - description: 32k osc
>        - description: 24m osc
>        - description: ipp_di0 clock input
>        - description: ipp_di1 clock input
> +      - description: Optional lenet1_ref_pad or enet2_ref_pad clocks
> +      - description: Optional lenet1_ref_pad or enet2_ref_pad clocks
>  
>    clock-names:
> +    minItems: 4
>      items:
>        - const: ckil
>        - const: osc
>        - const: ipp_di0
>        - const: ipp_di1
> +      - enum: [enet1_ref_pad, enet2_ref_pad]
> +      - enum: [enet1_ref_pad, enet2_ref_pad]

pattern: '^enet[12]_ref_pad$'

Rob

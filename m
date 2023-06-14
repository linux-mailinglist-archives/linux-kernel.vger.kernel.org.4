Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1708E73080C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 21:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjFNTVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 15:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjFNTVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 15:21:35 -0400
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A0426B7;
        Wed, 14 Jun 2023 12:21:16 -0700 (PDT)
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-33cb82122c7so29528265ab.1;
        Wed, 14 Jun 2023 12:21:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686770476; x=1689362476;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sHiFqUH8Ns99cL4Q7Lgq6jxmGIJl/IBWeuGMsrbyXnU=;
        b=bT5p3MIEHc53heYTrW6QWDnCa9Cf7EIJhU2CgyPBAP0G4M0EkSQxVi3bKErCD1g4cm
         wV0oG8rlU+2mXrDq0rnZ8Y5YBiFq6pJkfrgJoSuW2oM1PuW1UyRztjqlg5G2UqcqIJAk
         RHcZBvFOjUaKwiFlwo3aJva9HBsPElWmV//mR+qlnWvnAL3XdlLCi+NDtl99udyccLps
         hJAy88cQOMozWCqqBJEmAcSqFzll4JR5z0Er43VfQYmg8Yo+7avQtGEPmEy3npUqMfSp
         sqqNjD+emKSqhG/1zYLswm0aHR9HHgV0LuM0UOW0PXemC1IWtcx/PwujEJ7VJt7xwspp
         KOXw==
X-Gm-Message-State: AC+VfDyNPR+wwOL5pHMHIY8INXAhgqn7pJu8ep7mskZjynw3YwMdBUqM
        XaTuvkXUA79deL1cOeCldg==
X-Google-Smtp-Source: ACHHUZ4+oCaDJAL2TyNKe9N2ZuahMJpTVt2MjofPkLtQyNt9QOfQlpzr2x39gYaMHbPNmmJx9oNtlQ==
X-Received: by 2002:a05:6e02:5c7:b0:33f:dfd1:fe49 with SMTP id l7-20020a056e0205c700b0033fdfd1fe49mr10449290ils.6.1686770475971;
        Wed, 14 Jun 2023 12:21:15 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id i18-20020a02c612000000b004230e6377f3sm190722jan.177.2023.06.14.12.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 12:21:15 -0700 (PDT)
Received: (nullmailer pid 2591199 invoked by uid 1000);
        Wed, 14 Jun 2023 19:21:12 -0000
Date:   Wed, 14 Jun 2023 13:21:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-mmc@vger.kernel.org, Abel Vesa <abelvesa@kernel.org>,
        devicetree@vger.kernel.org, linux-crypto@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Fabio Estevam <festevam@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-input@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-clk@vger.kernel.org, Anson Huang <Anson.Huang@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Thomas Gleixner <tglx@linutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Peng Fan <peng.fan@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v1 7/7] dt-bindings: input: touchscreen: edt-ft5x06: Add
 'threshold' property
Message-ID: <168677047226.2591141.8223363796946763544.robh@kernel.org>
References: <20230601101451.357662-1-o.rempel@pengutronix.de>
 <20230601101451.357662-8-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601101451.357662-8-o.rempel@pengutronix.de>
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


On Thu, 01 Jun 2023 12:14:51 +0200, Oleksij Rempel wrote:
> Add a new property 'threshold' to the edt-ft5x06 touchscreen binding.
> This property allows setting the "click"-threshold in the range from 0
> to 255. This change addresses the following dtbs_check warning:
>   imx6dl-lanmcu.dtb: touchscreen@38: 'threshold' does not match any of the
>     regexes: 'pinctrl-[0-9]+'
>   From schema:
>     Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  .../devicetree/bindings/input/touchscreen/edt-ft5x06.yaml   | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


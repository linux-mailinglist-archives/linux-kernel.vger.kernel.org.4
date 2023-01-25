Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C6567BC5C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 21:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236370AbjAYUL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 15:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236353AbjAYULv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 15:11:51 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF29D5D111;
        Wed, 25 Jan 2023 12:11:19 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id n24-20020a0568301e9800b006865671a9d5so11794540otr.6;
        Wed, 25 Jan 2023 12:11:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nvGxKBe2tXNnIAXd7DhRCMLLrdEFz1rEy7hosIzra4k=;
        b=fbG68ML9FUjq6Ny/B620Rja1oYl3Rj2gaVTIKZGvaq+LG2COIVjb2jFz/1HI2GbX6w
         CyiS7xfJTqXnnF2389HKa0SJF+YmE6dRdkYKwgfvDkc+6DEBfqtIWwNfl6ilh/tBm4wW
         LM10x1S00fJBjXjDD7i40Pt6vedNOixUUaXk0aVnmX+d4mRxd/YGU/iaDIZfoP7DyJLH
         YaaT8hImV1l4ZZDpPrqOU4U7zKOu/Q4lO1gpMtkF6Zh3PA1wnPjTCGD1ymf/e+16mz2y
         sLkiGFN3ePJxGYXcfXWIe92FXfsoA/dZ0n8JpFFs6tLEWa/od37CVJgUXpGVR9OGW53q
         q1PQ==
X-Gm-Message-State: AFqh2kpaMxRVoyXPVJ4sFzyXxVkwVTzQPokEmSvRc3g+bRnLMSalwahx
        IkvuFkF/r+T+/d5P+rpg1A==
X-Google-Smtp-Source: AMrXdXuxRG4RDF7RI7gCrOg1RarCpE71i170Oc3Cr+xu3/OuWc975n087q9cZ/K9XzPPfyTQp3Iy4Q==
X-Received: by 2002:a9d:7508:0:b0:670:686c:7dc with SMTP id r8-20020a9d7508000000b00670686c07dcmr17455962otk.26.1674677402557;
        Wed, 25 Jan 2023 12:10:02 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b6-20020a9d6b86000000b00684e79759d7sm2505546otq.65.2023.01.25.12.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 12:10:02 -0800 (PST)
Received: (nullmailer pid 2808877 invoked by uid 1000);
        Wed, 25 Jan 2023 20:10:00 -0000
Date:   Wed, 25 Jan 2023 14:10:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Peter Korsgaard <jacmet@sunsite.dk>, Chester Lin <clin@suse.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-riscv@lists.infradead.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-serial@vger.kernel.org, Le Ray <erwan.leray@foss.st.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Tomer Maimon <tmaimon77@gmail.com>, devicetree@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-amlogic@lists.infradead.org,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Pragnesh Patel <pragnesh.patel@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH v2 12/12] dt-bindings: serial: example cleanup
Message-ID: <167467740050.2808709.16126387956370383942.robh@kernel.org>
References: <20230124091602.44027-1-krzysztof.kozlowski@linaro.org>
 <20230124091916.45054-10-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124091916.45054-10-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 24 Jan 2023 10:19:16 +0100, Krzysztof Kozlowski wrote:
> Adjust example DTS indentation to match recommended style of 4-spaces
> and use lower-case hex for address in reg.  No functional change.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/serial/8250_omap.yaml | 18 ++++++-------
>  .../bindings/serial/amlogic,meson-uart.yaml   | 10 +++----
>  .../devicetree/bindings/serial/cdns,uart.yaml | 10 +++----
>  .../bindings/serial/renesas,em-uart.yaml      | 10 +++----
>  .../bindings/serial/renesas,hscif.yaml        | 26 +++++++++----------
>  .../bindings/serial/renesas,sci.yaml          | 24 ++++++++---------
>  .../bindings/serial/renesas,scif.yaml         | 24 ++++++++---------
>  .../bindings/serial/renesas,scifa.yaml        | 22 ++++++++--------
>  .../bindings/serial/renesas,scifb.yaml        | 12 ++++-----
>  .../devicetree/bindings/serial/serial.yaml    | 18 ++++++-------
>  .../bindings/serial/sifive-serial.yaml        |  6 ++---
>  .../bindings/serial/xlnx,opb-uartlite.yaml    |  4 +--
>  12 files changed, 92 insertions(+), 92 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

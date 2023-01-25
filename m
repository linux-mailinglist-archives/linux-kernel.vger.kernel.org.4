Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1C467BC16
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 21:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236175AbjAYUGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 15:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236012AbjAYUGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 15:06:49 -0500
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27243EC50;
        Wed, 25 Jan 2023 12:06:42 -0800 (PST)
Received: by mail-oi1-f180.google.com with SMTP id s124so17293031oif.1;
        Wed, 25 Jan 2023 12:06:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cjdeMOLunBcaH9abbjTPumVPAzpI0woKuv5TqA6wWlg=;
        b=6upkJX424fNniMQEujc+Hto49Q2U6KjBLPg9Z7dYXnYh6Uyi2Np5CmXamO2AgZRPEk
         OTr140htRYeOFexYSloaAQCanwNhkMofkdsCamJ8CGGh6DdmrtjiZs/Epxxj8gtM/AAf
         49ejJ6ydKw5Hz1S6roPj8nH4mvI1FFec/BuwfFpux43qnRUZ/03SwwW4yLc9/r7yWStK
         Wcy2SeozUQXol6pLUFyjFsAUgvzHb15OlP9oMcly2Vq39M5rYt8fiBVDA2hVLsWZzazA
         ZPbCpHpg9eX9K+nAJp+0sCjGweXO+Ejuiy3q7G/M44D1wLjjoVeHBGco1xsCaZj0UlA4
         3nKQ==
X-Gm-Message-State: AFqh2kqVmlec5dJEDeticxArcHgryoW4gJw/fV+rJ4+VxkDWKpsCJ/6f
        HSt7dpQD2hlFiw5yrGf1Lw==
X-Google-Smtp-Source: AMrXdXs39pVibYTbO8sCzlzh4gXhBnoYQHFDiAukdaJUOpcBjaCiIgpNW6SRZHdq1Euvc18hPYacFw==
X-Received: by 2002:aca:e106:0:b0:363:8e7e:60b with SMTP id y6-20020acae106000000b003638e7e060bmr15163351oig.31.1674677201827;
        Wed, 25 Jan 2023 12:06:41 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l74-20020a9d1b50000000b0068668e2e08bsm2534670otl.58.2023.01.25.12.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 12:06:41 -0800 (PST)
Received: (nullmailer pid 2770378 invoked by uid 1000);
        Wed, 25 Jan 2023 20:06:40 -0000
Date:   Wed, 25 Jan 2023 14:06:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Fabio Estevam <festevam@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, Chester Lin <clin@suse.com>,
        Le Ray <erwan.leray@foss.st.com>,
        Pragnesh Patel <pragnesh.patel@sifive.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH v2 03/12] dt-bindings: serial: pl011: allow ARM Primecell
 properties
Message-ID: <167467719955.2770340.7541724589555631279.robh@kernel.org>
References: <20230124091602.44027-1-krzysztof.kozlowski@linaro.org>
 <20230124091916.45054-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124091916.45054-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 24 Jan 2023 10:19:07 +0100, Krzysztof Kozlowski wrote:
> Reference ARM Primecell bindings to allow typical Primecell device node properties:
> 
>   broadcom/bcm2711-rpi-400.dtb: serial@7e201000: Unevaluated properties are not allowed ('arm,primecell-periphid' was unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/serial/pl011.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

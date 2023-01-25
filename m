Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47DD67BC34
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 21:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236276AbjAYUJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 15:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235842AbjAYUJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 15:09:18 -0500
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1815D112;
        Wed, 25 Jan 2023 12:08:52 -0800 (PST)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-15ff0a1f735so14527538fac.5;
        Wed, 25 Jan 2023 12:08:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2nDL5JMpYL8zMscLCkNwpf+56C4bxX8siHriNAzVjbw=;
        b=U4PaVHvwBMqiQmQG7we+RUQACALIlHWOSzft4EqKcW6SMPm/4/ZzSU8SubA0DS3LPX
         qOhFnfGKkbbUJ6PY8U+WDpTW7vRt+l26A7HS2YpFj1l8oKLH4B06KbKKy/ThjbxKn5F6
         UNNwmofig/Dv51/6UX5zDb/ox9rQF5IUqjUg7aPz6ICMBNLn80DGInC3nB44NBK8ipla
         fcoXKm94XKCL+cnRZerYgTsQeGUcbyVMPXdfAMKB34m6SF5PfZhLN/D49Jk+Olm+K+ZG
         MhX/kJE6Du30F5Qtl8fdMY/ouu40O7e+cuPipTgrDSM5QkMK+gM65Eis7/w0SM0mINPn
         sayg==
X-Gm-Message-State: AFqh2kpMAcqgCq1z6eld1Jnko2wJFJoetgzBi9/hQVSYpoP4kl6GxR6l
        48o6X18WEpiddwQpQGTZJA==
X-Google-Smtp-Source: AMrXdXuA8tO45Yj4ss66nTmpQUbLo6kLx/P66wPdUh9X5rLrKkVx5S80pJZ5ehwR5YNBU80lx/AzZQ==
X-Received: by 2002:a05:6870:9d0a:b0:15f:32b:6e33 with SMTP id pp10-20020a0568709d0a00b0015f032b6e33mr16413614oab.39.1674677330355;
        Wed, 25 Jan 2023 12:08:50 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p13-20020a056870568d00b0015f83e16a10sm2278638oao.44.2023.01.25.12.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 12:08:50 -0800 (PST)
Received: (nullmailer pid 2793767 invoked by uid 1000);
        Wed, 25 Jan 2023 20:08:48 -0000
Date:   Wed, 25 Jan 2023 14:08:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Chester Lin <clin@suse.com>, Fugang Duan <fugang.duan@nxp.com>,
        Pragnesh Patel <pragnesh.patel@sifive.com>,
        Le Ray <erwan.leray@foss.st.com>, linux-kernel@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        devicetree@vger.kernel.org, Tomer Maimon <tmaimon77@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Lubomir Rintel <lkundrak@v3.sk>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Fabio Estevam <festevam@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-serial@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 09/12] dt-bindings: serial: fsl-lpuart: allow other
 serial properties
Message-ID: <167467732818.2793535.3311476419413024796.robh@kernel.org>
References: <20230124091602.44027-1-krzysztof.kozlowski@linaro.org>
 <20230124091916.45054-7-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124091916.45054-7-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 24 Jan 2023 10:19:13 +0100, Krzysztof Kozlowski wrote:
> Reference common serial properties bindings to allow typical serial
> properties:
> 
>   imx8qxp-ai_ml.dtb: serial@5a060000: Unevaluated properties are not allowed ('uart-has-rtscts' were unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/serial/fsl-lpuart.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

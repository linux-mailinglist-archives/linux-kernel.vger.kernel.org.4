Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A788567BC3D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 21:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236292AbjAYUJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 15:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236294AbjAYUJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 15:09:32 -0500
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C755CFF5;
        Wed, 25 Jan 2023 12:09:02 -0800 (PST)
Received: by mail-ot1-f43.google.com with SMTP id 39-20020a9d032a000000b006884aad0b15so1825895otv.12;
        Wed, 25 Jan 2023 12:09:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6t3+eN2lHtIu49LblIFaPzhFGYt/AfmaSuGsn+YEdS0=;
        b=Mlwrg261vQPuhB3fLF2e0lcBhhSJsxDtr7Bl+2CTFBjAUHr6bAr+lhthNVL+qoletm
         6ETYsOiBfVheTvwNmdcZU8AN2ztTKQEqx7q0pAsERWotaSfzt3crF44sg+y4BQvUvtMx
         5s2xwsXUcozuGsxP86ivDLx2Q40OgjcrlpV6yd57Kiaqh/BQNGUS+7L8wk8g6L4DYQXM
         2P4hg/m8x9CDeQr7P57oxCd/8Jlq1WQQJkVTs2isffVXf20WSirxwMZZ6OdJ1SEdtp3C
         cNW6ZHBbCYmohM6fvbqinXQ0iz9sroheDJXE31lbgwR2e2Kua/bxRU+oxZhZMhO7dqRc
         bA/A==
X-Gm-Message-State: AFqh2krVTWbaxLvC19L4qlSxLdYqLcGK9qOVnSPNdg1qDSTMb2XCNrhv
        iuGdeL03iD9uy8yINntrkA==
X-Google-Smtp-Source: AMrXdXvmG+MMXgZe3y8Iabdwj1T7QPV9D3ixNYqPrRVv52b4IuvZX87jEuE4ezPKTjyH7bgohvzYWA==
X-Received: by 2002:a9d:6b03:0:b0:670:7a2b:f52f with SMTP id g3-20020a9d6b03000000b006707a2bf52fmr15887767otp.8.1674677341751;
        Wed, 25 Jan 2023 12:09:01 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f18-20020a9d5f12000000b00670641eb272sm2571030oti.20.2023.01.25.12.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 12:09:01 -0800 (PST)
Received: (nullmailer pid 2795996 invoked by uid 1000);
        Wed, 25 Jan 2023 20:09:00 -0000
Date:   Wed, 25 Jan 2023 14:09:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Peter Korsgaard <jacmet@sunsite.dk>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Le Ray <erwan.leray@foss.st.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chester Lin <clin@suse.com>, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Pragnesh Patel <pragnesh.patel@sifive.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        Fugang Duan <fugang.duan@nxp.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Subject: Re: [PATCH v2 10/12] dt-bindings: serial: st,stm32-uart: drop common
 properties
Message-ID: <167467733943.2795781.3621050331030383112.robh@kernel.org>
References: <20230124091602.44027-1-krzysztof.kozlowski@linaro.org>
 <20230124091916.45054-8-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124091916.45054-8-krzysztof.kozlowski@linaro.org>
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


On Tue, 24 Jan 2023 10:19:14 +0100, Krzysztof Kozlowski wrote:
> The binding references serial and rs485 schemas, so there is no need to
> list their properties.  Simplify a bit by removing unneeded entries.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/serial/st,stm32-uart.yaml          | 7 -------
>  1 file changed, 7 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

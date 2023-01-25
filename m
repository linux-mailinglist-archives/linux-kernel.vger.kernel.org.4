Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7145867BC12
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 21:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236114AbjAYUGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 15:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235528AbjAYUG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 15:06:29 -0500
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44FB5A376;
        Wed, 25 Jan 2023 12:06:25 -0800 (PST)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-15eec491b40so22706860fac.12;
        Wed, 25 Jan 2023 12:06:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XmbysuHPjfK+X9Z9VAj7ZA13Rw20BD2qll2fpcLoSIU=;
        b=XK+McU71tWKnipyyujzE2GrQ92kq6arUNbCeihFz3GKUFc1p5TRUIHkjahPCb+9HoF
         ySP8qTDSge3y+zUafGtKj6xVtVljcPurHoNim70usGR4O1NZy+HvYOd4Y2+ooAQ8rA7T
         I5qMvPU8NWCZ/L4FZh0VX842u5c50w1KR8VF98rw1Kv/OLREQbWDt6i5G+Hs2jQ6xyFn
         hPyI9wH6GBSMQzQU4IlcwWbuPie9dFIzNNRc1G2VapAMY/AgZalnygfruSa6z4mNmZYu
         vUcVrebj6576kr9VnpNctMACyHX6pXSLHv89qmUivPazGhu6VuIMqSS4SbkjynK2bZ6z
         zcqQ==
X-Gm-Message-State: AFqh2kqXj/NUl3EEiWVKcL4g5XOPqi4Zm5L9gVSZkjD8UXUbZlbVOBKN
        wyPFQeAOlH+8FABsJ6+qYw==
X-Google-Smtp-Source: AK7set+GaEu8klX8ZrT+kPUSQ/UdfQGCuvFO5aVmA0fCZzJ/i5NkLzmYTh9rERQZJyp7IvXTuaR09A==
X-Received: by 2002:a05:6870:d356:b0:160:3369:1624 with SMTP id h22-20020a056870d35600b0016033691624mr5072686oag.13.1674677184988;
        Wed, 25 Jan 2023 12:06:24 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id lu24-20020a056871431800b0013297705e5dsm2285614oab.28.2023.01.25.12.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 12:06:24 -0800 (PST)
Received: (nullmailer pid 2770011 invoked by uid 1000);
        Wed, 25 Jan 2023 20:06:23 -0000
Date:   Wed, 25 Jan 2023 14:06:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Le Ray <erwan.leray@foss.st.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Chester Lin <clin@suse.com>, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        - <devicetree@vger.kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Pragnesh Patel <pragnesh.patel@sifive.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-riscv@lists.infradead.org,
        Peter Korsgaard <jacmet@sunsite.dk>,
        linux-amlogic@lists.infradead.org,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        linux-stm32@st-md-mailman.stormreply.com,
        Fugang Duan <fugang.duan@nxp.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Fabio Estevam <festevam@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Subject: Re: [PATCH v2 02/12] dt-bindings: serial: 8250: correct Nuvoton
 NPCM850 compatible
Message-ID: <167467718287.2769960.1087362383778612276.robh@kernel.org>
References: <20230124091602.44027-1-krzysztof.kozlowski@linaro.org>
 <20230124091602.44027-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124091602.44027-3-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 24 Jan 2023 10:15:52 +0100, Krzysztof Kozlowski wrote:
> Nuvoton NPCM850 UART is compatible with NPCM750, so add proper fallback
> to match existing DTS and Linux driver.
> 
> Fixes: c8177f90b7c6 ("dt-bindings: serial: 8250: Add npcm845 compatible string")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/serial/8250.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

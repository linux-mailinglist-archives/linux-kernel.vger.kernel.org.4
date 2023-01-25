Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C5967BC47
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 21:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236387AbjAYUKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 15:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236388AbjAYUJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 15:09:57 -0500
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDB55D900;
        Wed, 25 Jan 2023 12:09:35 -0800 (PST)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1631b928691so6413265fac.11;
        Wed, 25 Jan 2023 12:09:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7GwbvorGn0RsrCr1lYO8AQMjltKd8a/pRgkR5/1pKCQ=;
        b=vINhH318gGrH6cV6e8EkyIbLnLXH79tm9/DBf2nlgtSXDlcuHc/FQyw/w2cBcDsXXj
         DP24o7dBe20niNu1xnPPfIbveUq2A9T0kvYsmiyNqOLrpyCybD+DQWUXF0PGbqcqPKM+
         l7uUm3lkQ5jjThQCxMH5/WdnGu1OVL6vgcBgcZiWmazscNp9FIUiSXmIDawWxXQxtfTH
         Hv917z8oinxdqn5VJqIESkGVxghNR4xa6tMF+bn83R7G0yPQBeGntIOkIzUEdx+PRkUC
         9Wzb8d8LFAV4VmeGSIyY58uTnmzPsWbsaNlIlSsQ8imYXvfGW5eiiOoe1Vl89JH8gecN
         Bl1Q==
X-Gm-Message-State: AO0yUKXmuGrX5wN/dHqwNBMcIibHutSTDheuSTOrQT136BdfdZ78UgPw
        ihLvr5Be9vWCuQLqMe4LIg==
X-Google-Smtp-Source: AK7set8vWoADu2dFh2Wi0jTLqZLUS3c9WQz5pfsofwNc+7WfeFAiHYC6lXfkVBUekSKcwpURaqmjaA==
X-Received: by 2002:a05:6870:1711:b0:163:3d31:58be with SMTP id h17-20020a056870171100b001633d3158bemr1344921oae.45.1674677365046;
        Wed, 25 Jan 2023 12:09:25 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j24-20020a056870051800b0013b9ee734dcsm2271007oao.35.2023.01.25.12.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 12:09:24 -0800 (PST)
Received: (nullmailer pid 2800439 invoked by uid 1000);
        Wed, 25 Jan 2023 20:09:23 -0000
Date:   Wed, 25 Jan 2023 14:09:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Pragnesh Patel <pragnesh.patel@sifive.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Fabio Estevam <festevam@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Chester Lin <clin@suse.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Le Ray <erwan.leray@foss.st.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Jerome Brunet <jbrunet@baylibre.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v2 11/12] dt-bindings: serial: drop unneeded quotes
Message-ID: <167467736271.2800253.2821370670394691234.robh@kernel.org>
References: <20230124091602.44027-1-krzysztof.kozlowski@linaro.org>
 <20230124091916.45054-9-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124091916.45054-9-krzysztof.kozlowski@linaro.org>
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


On Tue, 24 Jan 2023 10:19:15 +0100, Krzysztof Kozlowski wrote:
> Cleanup by removing unneeded quotes from refs.  No functional impact
> except adjusting to preferred coding style.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/serial/8250.yaml            | 4 ++--
>  .../devicetree/bindings/serial/fsl,s32-linflexuart.yaml       | 2 +-
>  Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml    | 4 ++--
>  Documentation/devicetree/bindings/serial/fsl-lpuart.yaml      | 2 +-
>  Documentation/devicetree/bindings/serial/fsl-mxs-auart.yaml   | 2 +-
>  5 files changed, 7 insertions(+), 7 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

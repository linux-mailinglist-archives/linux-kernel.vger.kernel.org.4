Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA3E67BC1A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 21:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236222AbjAYUHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 15:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236155AbjAYUHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 15:07:03 -0500
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6A4457F2;
        Wed, 25 Jan 2023 12:07:00 -0800 (PST)
Received: by mail-oi1-f182.google.com with SMTP id v17so17276181oie.5;
        Wed, 25 Jan 2023 12:07:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HjxpPCXLfIbQ+6VlgSG0tsTyVkfQNnId/4DSkULnpV4=;
        b=CfT8Nyfr30Lmyael8Xf0rEY+c/BMd/cdoVWRIOFYsqJwSIYHLeXog8qq1zZX9KLuNF
         E7UjwtpGNaSw/9BaK3l/nufizqx3nTq0kgPNeGa5BGq9zqqyzFkfLA4nH2/+y7U3rIQ0
         +k+W7oIQG+cTQRn0HYD5hFmmkuh3YplJBzYNtQoCnlGG2i16sqC0ksS4C/W/15G9LHDk
         x0BpogRiVOXgH2NYWyIDxJB7ZTZHy3G/mSkruFRbIQ2DcgFD57cAOp1CNptq12477qyN
         LOK9VZl5RJBvP4ZjPrLuqKSj6hxKmbdCRvNIXnBitS60tgKJts4ZmefPuEnwNbCXOZwk
         0YbQ==
X-Gm-Message-State: AFqh2kq396xwo/9vzM+AbPsW+FxNRR4dy9mEVo0psCvPpZUHreq5VkvF
        QioGlI5Kr3Vq93CuF0S5DA==
X-Google-Smtp-Source: AMrXdXvZSXdLIAvantzWPKLx8w8nHQA+dbuiWBV7hE/X1AIpaFtwf5qnOANWheWQAHC+czb3K7K1XQ==
X-Received: by 2002:a54:4708:0:b0:364:eb0f:6de1 with SMTP id k8-20020a544708000000b00364eb0f6de1mr15696584oik.23.1674677219277;
        Wed, 25 Jan 2023 12:06:59 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id eu25-20020a056808289900b00369ec58932csm2620202oib.45.2023.01.25.12.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 12:06:58 -0800 (PST)
Received: (nullmailer pid 2771034 invoked by uid 1000);
        Wed, 25 Jan 2023 20:06:57 -0000
Date:   Wed, 25 Jan 2023 14:06:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Fugang Duan <fugang.duan@nxp.com>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Chester Lin <clin@suse.com>, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Le Ray <erwan.leray@foss.st.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Kevin Hilman <khilman@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Michal Simek <michal.simek@amd.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-serial@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org,
        Pragnesh Patel <pragnesh.patel@sifive.com>
Subject: Re: [PATCH v2 04/12] dt-bindings: serial: correct ref to serial.yaml
Message-ID: <167467721713.2770933.9672853616239186241.robh@kernel.org>
References: <20230124091602.44027-1-krzysztof.kozlowski@linaro.org>
 <20230124091916.45054-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124091916.45054-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 24 Jan 2023 10:19:08 +0100, Krzysztof Kozlowski wrote:
> The serial bindings should reference the local (in kernel) serial.yaml,
> not the /schemas/serial.yaml.  The latter comes from dtschema package
> and is a small subset of serial bindings.
> 
> Usage of the local serial.yaml allows typical properties and children:
> 
>   xilinx/avnet-ultra96-rev1.dtb: serial@ff000000: Unevaluated properties are not allowed ('bluetooth' were unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Michal Simek <michal.simek@amd.com>
> ---
>  Documentation/devicetree/bindings/serial/cdns,uart.yaml         | 2 +-
>  Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D1F67BC1E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 21:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236155AbjAYUHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 15:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235943AbjAYUHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 15:07:30 -0500
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D5E38B75;
        Wed, 25 Jan 2023 12:07:29 -0800 (PST)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-15ff0a1f735so14523040fac.5;
        Wed, 25 Jan 2023 12:07:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XkAXkDhEfbbO8vL4jcgXHdApyqSqXlGnBUofEqsLMzQ=;
        b=TNtb4MYGKah3NTCSEMeCPBZET9Ud8XUGsYgQu5Z6tWLDWjUDE/Bv6YXofKNzrqAZbV
         MneLiiZgtGrDiU3vu+b/JMDTum5ex91FtRVR8UqSGkBx1TafgzlvhQoV3ca4UuDSkjG8
         SDIP8EJ1/Y5iexJ20h9awE/76RrpXK69FhTuoUKuQGXiuUpox2nzXpmLoxBPVponlY6q
         RBiUE3xFQMuxv7I7RyvQ3eUkJfokExaz2Ey6N+hgLm5FQzJQV+McoovxSZGxMO5jJ/xi
         DI7lGNWZ20PpPyjfeGjqL83Nh/a42sPQS0t/tvxGkkZVKwFf+b3O2xh0vjE8OST19/VI
         Knqw==
X-Gm-Message-State: AFqh2krSY3xIIppONHGq2vbXYQ2Ki0ohZmBRZQRu4UWOK9fBA8BiqwR8
        EdYJjmRcIxswitRHH/dEvw==
X-Google-Smtp-Source: AMrXdXteyM0OPwTs5gB6Am2eJ/aHWrEwxvp1bRY11quUm5b1g3LulC49my3RB8kmiOVdtzemE+Uh7g==
X-Received: by 2002:a05:6870:bace:b0:154:bfcd:e86e with SMTP id js14-20020a056870bace00b00154bfcde86emr16295491oab.2.1674677248733;
        Wed, 25 Jan 2023 12:07:28 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id fw9-20020a056870080900b00143ae7d4ccesm1886575oab.45.2023.01.25.12.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 12:07:28 -0800 (PST)
Received: (nullmailer pid 2778134 invoked by uid 1000);
        Wed, 25 Jan 2023 20:07:27 -0000
Date:   Wed, 25 Jan 2023 14:07:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Michal Simek <michal.simek@xilinx.com>, devicetree@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        Pragnesh Patel <pragnesh.patel@sifive.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Chester Lin <clin@suse.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Le Ray <erwan.leray@foss.st.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        linux-kernel@vger.kernel.org, Michal Simek <michal.simek@amd.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Lubomir Rintel <lkundrak@v3.sk>,
        linux-riscv@lists.infradead.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-amlogic@lists.infradead.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 05/12] dt-bindings: serial: cdsn,uart: add
 power-domains
Message-ID: <167467724645.2777996.13882955684476906730.robh@kernel.org>
References: <20230124091602.44027-1-krzysztof.kozlowski@linaro.org>
 <20230124091916.45054-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124091916.45054-3-krzysztof.kozlowski@linaro.org>
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


On Tue, 24 Jan 2023 10:19:09 +0100, Krzysztof Kozlowski wrote:
> Few Xilinx DTS have power domains in serial node:
> 
>   zynqmp-zc1232-revA.dtb: serial@ff000000: Unevaluated properties are not allowed ('power-domains' was unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Michal Simek <michal.simek@amd.com>
> ---
>  .../devicetree/bindings/serial/cdns,uart.yaml   | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

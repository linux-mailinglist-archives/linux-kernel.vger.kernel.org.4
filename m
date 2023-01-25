Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF04B67BC27
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 21:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236202AbjAYUIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 15:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236211AbjAYUIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 15:08:18 -0500
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405B84F358;
        Wed, 25 Jan 2023 12:08:17 -0800 (PST)
Received: by mail-ot1-f41.google.com with SMTP id a1-20020a056830008100b006864df3b1f8so11792778oto.3;
        Wed, 25 Jan 2023 12:08:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t39EsIvvp67IzNGd+XHwSqU0K2A/vSnr7kxAVJ448Ms=;
        b=ZHQiRtCJGC9Cc6oMU7YfDVnqJcILAFp9oGYwb1u7rZsAWQC6dRhxeaZZkF0nTVmUC4
         d8nZoqXwRojdNzQw4S5MmxgYB/DFpoTW6AxmbADYG2E3ae1XaMWmbB8HiXmT6ZMdKzWd
         VK5TQDvDTVbscZn+h2i+G1kas9IDdSs9ETebMyHseG0lkKpEwmWfaapRgZd+DttYMPOb
         OXzXdrBxK1btBsXzGTSoYAZG7dVuWAzTjeZFK172gOAEs7AXZiHariJZiY9TPMMgP1XB
         C7iLssjH5dEsf8SJban2k6QFwzi50Be5LoHhQ1/mHGTDjtV92Ll/HOtJEL6inkMEDXPa
         nLtw==
X-Gm-Message-State: AFqh2kqb4kt4Rl2lcrqRlqs1TJKxKD+3H5XYMg/X8hMDJm38yKXvyCQj
        2i3zqLKszsai3uEpaBXAPw==
X-Google-Smtp-Source: AMrXdXsmfTrkC6CB13iDEfae46rieh8cjr3v84kXPdnw8bCR8TEBh66uXMANGvdhEgd8e1uTEm4Jfw==
X-Received: by 2002:a05:6830:1383:b0:684:dbfd:f239 with SMTP id d3-20020a056830138300b00684dbfdf239mr22688884otq.9.1674677296424;
        Wed, 25 Jan 2023 12:08:16 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s15-20020a056830124f00b006864749f39csm2572694otp.36.2023.01.25.12.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 12:08:16 -0800 (PST)
Received: (nullmailer pid 2787324 invoked by uid 1000);
        Wed, 25 Jan 2023 20:08:14 -0000
Date:   Wed, 25 Jan 2023 14:08:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Le Ray <erwan.leray@foss.st.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-amlogic@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-riscv@lists.infradead.org,
        Tomer Maimon <tmaimon77@gmail.com>,
        linux-serial@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>,
        Chester Lin <clin@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pragnesh Patel <pragnesh.patel@sifive.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH v2 07/12] dt-bindings: serial: fsl-imx-uart: drop common
 properties
Message-ID: <167467729413.2787137.2431263317209271713.robh@kernel.org>
References: <20230124091602.44027-1-krzysztof.kozlowski@linaro.org>
 <20230124091916.45054-5-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124091916.45054-5-krzysztof.kozlowski@linaro.org>
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


On Tue, 24 Jan 2023 10:19:11 +0100, Krzysztof Kozlowski wrote:
> The binding references serial and rs485 schemas, so there is no need to
> list their properties.  Simplify a bit by removing unneeded entries.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml | 7 -------
>  1 file changed, 7 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB0C67BC23
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 21:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236195AbjAYUIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 15:08:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235895AbjAYUII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 15:08:08 -0500
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87838303E2;
        Wed, 25 Jan 2023 12:08:05 -0800 (PST)
Received: by mail-oi1-f169.google.com with SMTP id o66so17281866oia.6;
        Wed, 25 Jan 2023 12:08:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1p3FdYLlGUAChSL+8xP1SW3yYfJGghI7cagrX3Bi/I=;
        b=TkInBkFI3B6MuchErSlslCdWs7j6SNKh4cAtaWh9UUHKxqOi/DT2pMHuoI6y2CaoZ+
         hWoh0QbvKn1Mg9gK+Lao13u1WCOw95EN1IPNuwZBqatK1ZhClqET6hkym9imI2p/Lga0
         8ZPd9OsQh+O9W/xjFch1haiJUNca7V0FrgADvIDANn2RON515EVCAbKFmUziklnqrizm
         PaWuVNshEt7JIErdPxR0BzRZILnEeb5m2/a2PsYKMguYHIutlbIp67PNeBomTqx/lb1x
         D3J9GIy3Vyxvk0Br/o0vQlvjh1Z40dt9B1LseYbV0t1LewAkWnALUOY9p1GYpMxiw9sI
         e8DA==
X-Gm-Message-State: AFqh2kqY8DePnq2hnZOr0sr7Bem7CuHGvBEe4OsJo/mKie8O7CDvVuwK
        ovTDlk5wxFLM0ZMKi8Hxvw==
X-Google-Smtp-Source: AMrXdXseqabcyHulKdSW9gY6uTAUwCSIlEbwqpw1soFhskncwZCdeRj5URGKhSfWNKhae8zY1f8dDg==
X-Received: by 2002:a05:6808:189d:b0:364:d523:e138 with SMTP id bi29-20020a056808189d00b00364d523e138mr18874315oib.32.1674677284798;
        Wed, 25 Jan 2023 12:08:04 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b18-20020a056830105200b0068646a8223bsm2528460otp.57.2023.01.25.12.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 12:08:04 -0800 (PST)
Received: (nullmailer pid 2785052 invoked by uid 1000);
        Wed, 25 Jan 2023 20:08:03 -0000
Date:   Wed, 25 Jan 2023 14:08:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Michal Simek <michal.simek@xilinx.com>,
        devicetree@vger.kernel.org, Fugang Duan <fugang.duan@nxp.com>,
        linux-riscv@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Fabio Estevam <festevam@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Pragnesh Patel <pragnesh.patel@sifive.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        NXP Linux Team <linux-imx@nxp.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-serial@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-amlogic@lists.infradead.org, Chester Lin <clin@suse.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Le Ray <erwan.leray@foss.st.com>
Subject: Re: [PATCH v2 06/12] dt-bindings: serial: 8250_omap: drop rs485
 properties
Message-ID: <167467728253.2784879.8231136375928061202.robh@kernel.org>
References: <20230124091602.44027-1-krzysztof.kozlowski@linaro.org>
 <20230124091916.45054-4-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124091916.45054-4-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 24 Jan 2023 10:19:10 +0100, Krzysztof Kozlowski wrote:
> The binding references rs485 schema, so there is no need to list its
> properties.  Simplify a bit by removing unneeded entries.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/serial/8250_omap.yaml | 5 -----
>  1 file changed, 5 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

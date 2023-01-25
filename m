Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C1867BC2C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 21:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236260AbjAYUId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 15:08:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236258AbjAYUI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 15:08:27 -0500
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28C05CFF8;
        Wed, 25 Jan 2023 12:08:25 -0800 (PST)
Received: by mail-ot1-f44.google.com with SMTP id cm26-20020a056830651a00b00684e5c0108dso11784894otb.9;
        Wed, 25 Jan 2023 12:08:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cWgaUXrrfuDciYk4fQKTg/r1Izy/Hz1zVjtkeDOPneI=;
        b=jFBf+IRpw99o1IXA/W2YfWXO3243+5cITUTZrAPSqE0X9d9fT9RRGKxjQ6UlqB6PA2
         BxGOrFuz2E6PgX9t5zscfXXKSg/DIQmOGOx09eux5hMIR6/g1AoPHSC05FPXPkvYpFXm
         wOx3tTvXEhPQKtANcscFZruPKoGh0qwRpt6zKuB/VAB55Zv+aFwa85TQeGfm0ya3Q4QT
         bxcJppw/W/LG/NKdM9toJVocAOE0H6zhuGtbCrRZDvBFpc7k1B3gBgzfK83kNXojBmmU
         oth76HKvAkiFAwn+HJZhMW8fXPGKeA8LQsljcH029iIAVKD78JZqgCJ3qaAbEh6IrAgS
         37IA==
X-Gm-Message-State: AFqh2krDIn9N4pu6IpfNSW4GgKmrok2hyzLzN7osIao/zmVbdrdl2eNh
        NPUc9fJpNnCdc3lStc0B4A==
X-Google-Smtp-Source: AMrXdXus3Z4ceRGOdNX1UqMgR5Jf06MXM2+F28K1Q1mS/DZ7M+aspNZLq1GQou47O7HCV+kd1rd9xA==
X-Received: by 2002:a05:6830:1d6e:b0:66c:6c78:27f4 with SMTP id l14-20020a0568301d6e00b0066c6c7827f4mr17518733oti.3.1674677304813;
        Wed, 25 Jan 2023 12:08:24 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j25-20020a056830015900b0068657984c22sm2553323otp.32.2023.01.25.12.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 12:08:24 -0800 (PST)
Received: (nullmailer pid 2788919 invoked by uid 1000);
        Wed, 25 Jan 2023 20:08:23 -0000
Date:   Wed, 25 Jan 2023 14:08:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lubomir Rintel <lkundrak@v3.sk>,
        linux-stm32@st-md-mailman.stormreply.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-riscv@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        Le Ray <erwan.leray@foss.st.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Chester Lin <clin@suse.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-arm-kernel@lists.infradead.org,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-serial@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Pragnesh Patel <pragnesh.patel@sifive.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH v2 08/12] dt-bindings: serial: fsl-lpuart: drop rs485
 properties
Message-ID: <167467730194.2788619.6626868986212724244.robh@kernel.org>
References: <20230124091602.44027-1-krzysztof.kozlowski@linaro.org>
 <20230124091916.45054-6-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124091916.45054-6-krzysztof.kozlowski@linaro.org>
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


On Tue, 24 Jan 2023 10:19:12 +0100, Krzysztof Kozlowski wrote:
> The binding references rs485 schema, so there is no need to list its
> properties.  Simplify a bit by removing unneeded entries.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/serial/fsl-lpuart.yaml | 3 ---
>  1 file changed, 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

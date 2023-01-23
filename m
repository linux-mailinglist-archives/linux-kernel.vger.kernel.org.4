Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4D8677F09
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbjAWPNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:13:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbjAWPNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:13:36 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFF826862
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:13:24 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id e19-20020a05600c439300b003db1cac0c1fso9350096wmn.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XbA6lJheuFk/8xFTT1ePhHPMDBY/JK/4xrBmt+OOi4U=;
        b=zKwo3e+7uOyJGADkS3SvY4tG/YcyQsjz83Hw5I13CEburg4Q5MNhT/O9mXFaHC1VHm
         NHpBnUzfLRasM5hHsboJ8qg0tjtusxjgkgU3z7WRakchQU+RDTPBJnRDSdlQige5MWjK
         n04J6T7rlTs3x9+hGTcOrAiMVD24XhCyrC8pae432g0HFZcOudET18IAy6qyEVL5YFKe
         tiWwsiNjm+uFGz47RWjXDJJuk1CSEYl4taTXz6UiG6pRB6Loe9dj7kV0N8md6ZyI+0ft
         Plr0jHIhb9I72XwyXwCtNsowVRCU61bWwloIL2WLm69gsGTF/KCt+exSO/oKQmjopXf0
         1F2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XbA6lJheuFk/8xFTT1ePhHPMDBY/JK/4xrBmt+OOi4U=;
        b=qbscaAy1zsWaBRH4uYgE9+3PHTgUBoLZAg9L6G/RLzkOIBCs7RqhKRuMWGtJ9hFPDz
         4JUNC1W7/AYBbzDE8kfLUpJuzTMXj9xhQa5xJuNV22Iy3BPNG1OOPY2GzNzDt9VNsXYt
         F0iVN6yJiBZWmFsBxspWqwzV/Hl5WJBRpeUwmzh0pByntDBIgVEWrkwnJOU2IqQHkSAl
         f5t2XbWaY1hTTAe8BE6Ndx7NB5MDkbUxUETXXlf9sWPIhLAEaSNCiRKOMDSvxrdyob5Z
         F5iv8JbD96IdZiOSInxUVqR84ItfVRsb6+qoqCJkzEEl0MSWQ3LBcwIEOsGMZHxfuuBa
         ULBw==
X-Gm-Message-State: AFqh2kpGXG4u5ENxCpIytCz/DwXsExwRQ5oMGdtvtV7V40CwRreX9+jq
        XIarRMfEIK/6cx23NoylO8rhFg==
X-Google-Smtp-Source: AMrXdXszs6a9DYNOLInJHWRaCXLtQ/W1X0idHVCXTCQ9XdHt03vNRQ/V7BA7UrJDU9EYj7btHPSV3A==
X-Received: by 2002:a05:600c:181a:b0:3d2:2043:9cbf with SMTP id n26-20020a05600c181a00b003d220439cbfmr24384116wmp.10.1674486802800;
        Mon, 23 Jan 2023 07:13:22 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n1-20020a5d67c1000000b002bc7f64efa3sm34737922wrw.29.2023.01.23.07.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 07:13:22 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        - <devicetree@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Chester Lin <clin@suse.com>, Fugang Duan <fugang.duan@nxp.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pragnesh Patel <pragnesh.patel@sifive.com>,
        Le Ray <erwan.leray@foss.st.com>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        Tomer Maimon <tmaimon77@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 06/13] dt-bindings: serial: 8250_omap: drop rs485 properties
Date:   Mon, 23 Jan 2023 16:12:55 +0100
Message-Id: <20230123151302.368277-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230123151302.368277-1-krzysztof.kozlowski@linaro.org>
References: <20230123151302.368277-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The binding references rs485 schema, so there is no need to list its
properties.  Simplify a bit by removing unneeded entries.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/serial/8250_omap.yaml | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/8250_omap.yaml b/Documentation/devicetree/bindings/serial/8250_omap.yaml
index 53dc1212ad2e..7db8e5477b03 100644
--- a/Documentation/devicetree/bindings/serial/8250_omap.yaml
+++ b/Documentation/devicetree/bindings/serial/8250_omap.yaml
@@ -70,11 +70,6 @@ properties:
   dsr-gpios: true
   rng-gpios: true
   dcd-gpios: true
-  rs485-rts-delay: true
-  rs485-rts-active-low: true
-  rs485-rx-during-tx: true
-  rs485-rts-active-high: true
-  linux,rs485-enabled-at-boot-time: true
   rts-gpio: true
   power-domains: true
   clock-frequency: true
-- 
2.34.1


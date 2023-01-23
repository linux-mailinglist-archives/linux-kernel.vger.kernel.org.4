Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3D9677F0F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbjAWPN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbjAWPNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:13:38 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B035F2916E
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:13:26 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id m15so9271261wms.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=42Hfl1J4qT8SATIfnUTpADzmL78jDne+EhYGf6Qds8c=;
        b=yTpXkuZVxBf/Okosou2SRl8i1EYnqKjpR9qYNEiJoBGzFJVhTP1BUZcYXSwoDYMMm/
         gGEOvGj+EPw8SDiTsobtFtGxqW5JxRGzgDd8uP9l7D5gjnnmBMvuXxYa5MsvGhtFwGkh
         1tXRuYZCb+3E/KkAf+XmmfvAi5/C3Iw+uW9kmkIK8pzTnKGZIEEg6DuXqnQ1gfRJlvV4
         utPYIa2FsLiGCut+4a08Y8O9Wbw9fGRby/G9y/xEyeEUWM3TfuAwiFOOzfMPfpH7cDwZ
         YthMHBcw7/iaTz1OlbMNI73XKu2je6+LGiC+3p58LLw1SPixX4Bg6TAKC52aP69iurRt
         +TeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=42Hfl1J4qT8SATIfnUTpADzmL78jDne+EhYGf6Qds8c=;
        b=4K9GATIZrE2oBfGdZWaR+yK1F/ac96lam7HqwxQYFbLFHddnIM9ql0UbGRqrN1f4ck
         Zx4hBoN+UPcI+wJkQuwixB2j0KRPiixMi5+0PvtZrKvm8pzf/dNdwk/JffIsvOMz0aq7
         i1hf+niuIDEuCNkZthLXRrh6r04Ge3LVDoqywiPT2pb+nKfd9AKKV2LeJuT8cyDOMhfM
         IIjSlJADywtasUoD/vsma5C2vF7JxZpLbprH3FrT4E2BwvHeoTxi0cEE5Q63fEjubVCk
         FMqZB2b6KcTqlSqrX46ce3MHX0BUjUb6Sg6JnKQ+i4Jbm3otu+aIh8breQCmSrhtS2g9
         Cmvw==
X-Gm-Message-State: AFqh2kqTb+CHumtJ0ukBVr/rR/tZSBzkVRQue5nx6to0WlUuu8YOggwZ
        vYTq95blsLnqFCUIqOcBSlhdmA==
X-Google-Smtp-Source: AMrXdXu6vYRYY5wV4XGcnXHQFFjaoLMw0vFZzVv4DjurTQnJ18UGrtA3F3Fe/V27r3/7GSCupm0HyA==
X-Received: by 2002:a05:600c:3b82:b0:3d2:392b:3165 with SMTP id n2-20020a05600c3b8200b003d2392b3165mr24592200wms.12.1674486805187;
        Mon, 23 Jan 2023 07:13:25 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n1-20020a5d67c1000000b002bc7f64efa3sm34737922wrw.29.2023.01.23.07.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 07:13:24 -0800 (PST)
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
Subject: [PATCH 07/13] dt-bindings: serial: fsl-imx-uart: drop common properties
Date:   Mon, 23 Jan 2023 16:12:56 +0100
Message-Id: <20230123151302.368277-7-krzysztof.kozlowski@linaro.org>
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

The binding references serial and rs485 schemas, so there is no need to
list their properties.  Simplify a bit by removing unneeded entries.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml b/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml
index 9d949296a142..b431a0d1cd6b 100644
--- a/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml
@@ -83,13 +83,6 @@ properties:
       are sensible for most use cases. If you need low latency processing on
       slow connections this needs to be configured appropriately.
 
-  uart-has-rtscts: true
-
-  rs485-rts-delay: true
-  rs485-rts-active-low: true
-  rs485-rx-during-tx: true
-  linux,rs485-enabled-at-boot-time: true
-
 required:
   - compatible
   - reg
-- 
2.34.1


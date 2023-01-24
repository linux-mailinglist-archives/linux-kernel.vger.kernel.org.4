Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0C96793F1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 10:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbjAXJUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 04:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233443AbjAXJUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 04:20:02 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90963E087
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 01:19:55 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id f19-20020a1c6a13000000b003db0ef4dedcso12334499wmc.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 01:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=42Hfl1J4qT8SATIfnUTpADzmL78jDne+EhYGf6Qds8c=;
        b=BfLinym/cklYezWvUdj/D3yAkf3NS77r92L10AME1y3JOtClKrEyZemZUji43xEfmE
         1CTGJHL8LxpGTSF3AkvFqeVNgE+wNerxDjURu1GcsX8rSNVpDps+fEwxFUsL1xhzvIiB
         +JmwNDp9o2c47v+qoJpdwZjZjMOt18r0Fc2C4iVYdDxnRsFioUSNzd9hAO5fdSylxvpr
         UUpTk957V2QsLmu9PRjgqzFHSbSzImHl6JKpF9omsRIvzHfPuFAVkaXEXwuO1hzWJOBA
         0yl9HepBj47QjGkby3EUe8AYOG4bhg7R8UD5AgoB/ADnPyyfeGIxtjSl3t1dXmFoRS3j
         T0zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=42Hfl1J4qT8SATIfnUTpADzmL78jDne+EhYGf6Qds8c=;
        b=e2qCLn6WovyzFdBltAq3koemAwA4N8/CK0IPJ4kJ6QyOeC6SJwxCoCriXqxqN/HbtC
         YuIzkBlfQpoVmFZ0ygEke3+/gG2L+mMqNYnTqz8Kyf2L0Bp51WAGF7II3X330as//oMy
         dCTX5i9DwhjhKbRX9QBr2x+OlYTDMlXwzOjRduF5qKd52dVaSTbhz8Foj9EI5A86b5Ff
         PHUdlVwSo9Rj7CHlVDsAhDrBq2263uViUsrMXoBtJRRZRykrU1+zkHFck21BWIq4FipH
         NyBSkUdoXAJTopuFVtQ7pa84AWQ+Qn42IUVjWxtwo/+5CjO5DZmsUVlJIPig4NwHlkp+
         OfiA==
X-Gm-Message-State: AFqh2kpoBBZrO9qWSAMVYYgvqd5fXN5JymHxVK3UPRs1reFBQO49NihM
        gNx542fL0sDnged6vA2akmcClg==
X-Google-Smtp-Source: AMrXdXs6ofs80YXfseUtI8imesuJyhITR5jNUBCkTkhOsWQiGBk4hZUL16Iu0n0uoxEvTPx24lzRdw==
X-Received: by 2002:a05:600c:540a:b0:3db:a3a:45ac with SMTP id he10-20020a05600c540a00b003db0a3a45acmr26791047wmb.32.1674551994306;
        Tue, 24 Jan 2023 01:19:54 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id i22-20020a05600c355600b003a84375d0d1sm13672242wmq.44.2023.01.24.01.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 01:19:53 -0800 (PST)
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
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Chester Lin <clin@suse.com>, Fugang Duan <fugang.duan@nxp.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pragnesh Patel <pragnesh.patel@sifive.com>,
        Le Ray <erwan.leray@foss.st.com>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        Tomer Maimon <tmaimon77@gmail.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 07/12] dt-bindings: serial: fsl-imx-uart: drop common properties
Date:   Tue, 24 Jan 2023 10:19:11 +0100
Message-Id: <20230124091916.45054-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230124091602.44027-1-krzysztof.kozlowski@linaro.org>
References: <20230124091602.44027-1-krzysztof.kozlowski@linaro.org>
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


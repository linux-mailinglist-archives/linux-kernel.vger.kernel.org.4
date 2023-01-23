Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C468B677F1A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbjAWPOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbjAWPN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:13:57 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E4F274B6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:13:31 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id d2so11107933wrp.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lf7sCIV+g7d4Io27nUeL8AFqRST4Uv3gC9DO+XLsu5c=;
        b=cqVYvO11OXKCMxWS2m2N8CuvmAo04795P3glA3/QShNfksesNCwdIiapFJIUxHx8cg
         3rS+IwE+nzmtwwJKmwEYmQW5HLkl7MmB54iys0Xhur69ZQg04gXhIFNjki1cNxhgM/hm
         KVdVtMqmIHX9lNjdkHzp2HS8EYbgPuXUYi8+63DnFvCutve84+4ZjO1HvGNqiyFO7QiQ
         0rkXFCKJMjZnLe10OEAwNQV/7I7wA0Qmxni0Mo/QqIeyhtr1qYNrtVfm7dhsM722pJ1P
         sPnDVVZr0HkwjgZyaHNJBlv/Mmd2HgHSPEa6D8zIE0r8kuGKh0CVafLNIOC929NHP8Cs
         Evnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lf7sCIV+g7d4Io27nUeL8AFqRST4Uv3gC9DO+XLsu5c=;
        b=0tQC0SvR8aKU3lgVWP808SHkclBkppAWWysmjKA/NLjmZLO0YkhoHcHmB92I93SJH+
         8cd1/yAxd08WWi8Y7dkSdBFsmWLjusMfRUTgyMlhk3xCzcljadD5rx9VSJm8e25VLvfH
         2Mn7KY9kKOCjQ9DAhD2+vunmGujKzByDQDqBF88+2VRpsmjloF8uTdlUKnr9AhUHmljn
         Qz5raJdqmzSl9rgqv4852fO19Sv/hzDyms9uJTn3WhTmKbZi4xRE9NWJx53so5ZGj8CJ
         YR7Wx5KcS02/c8f6j4Yjp6EW8caUXkmppKLSPTNeXWCAfSgAjq+kp9f4+iPu1ys+ROIA
         FjaQ==
X-Gm-Message-State: AFqh2kqdHBBP1oPnW9sPJdlB9YKDany/csuomwdsfPy2jAyZ9iWU0ka4
        LqLTWj4UI40W1MJBbyEIg5NTYQ==
X-Google-Smtp-Source: AMrXdXvPieFXZTI3YD37rAAxnRgL7EXzr2+7M2297WZ2GeWKED5O3/ADcQWZP+sLDJlxaXVyZ1+vHQ==
X-Received: by 2002:adf:edd1:0:b0:2bc:7d12:e736 with SMTP id v17-20020adfedd1000000b002bc7d12e736mr21123596wro.1.1674486810209;
        Mon, 23 Jan 2023 07:13:30 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n1-20020a5d67c1000000b002bc7f64efa3sm34737922wrw.29.2023.01.23.07.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 07:13:29 -0800 (PST)
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
Subject: [PATCH 09/13] dt-bindings: serial: fsl-lpuart: allow other serial properties
Date:   Mon, 23 Jan 2023 16:12:58 +0100
Message-Id: <20230123151302.368277-9-krzysztof.kozlowski@linaro.org>
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

Reference common serial properties bindings to allow typical serial
properties:

  imx8qxp-ai_ml.dtb: serial@5a060000: Unevaluated properties are not allowed ('uart-has-rtscts' were unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/serial/fsl-lpuart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
index b1e81a6451a6..26c3593fa98b 100644
--- a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
+++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
@@ -11,6 +11,7 @@ maintainers:
 
 allOf:
   - $ref: "rs485.yaml"
+  - $ref: serial.yaml#
 
 properties:
   compatible:
-- 
2.34.1


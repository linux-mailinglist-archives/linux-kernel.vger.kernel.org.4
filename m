Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4663C677F02
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbjAWPNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:13:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbjAWPNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:13:21 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD51627991
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:13:19 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id e3so11097022wru.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b5LLyL4NM9RFy872x3bTzHa5dSLMasbi37/mYNx6DCA=;
        b=YNHH8XRTX/01S31iQXYst52wcTTzbNbPtyQX8SbuGG5qAnPY1IAqJCxowByc5NAiIj
         EVn8g39hWWoxqwFSvp+seTBUawYQXnNdYFG80ce8+U59d80Q9psruK3xc4Ch80Q9YQ2K
         7nLXo8JaD+hoq87mrhJnw9b9r2JkD5hpoExRj3QchU725f9quBfOmlP3QFCp1yrmlIh+
         yN0fT+2BIch3oSwCfldxTIrUFhydcgT/dWrzIQtWy5fZU5RDfkbqSugyevH04iBrUfo4
         KkH+FZ5UVdtouXOh29sg6LYwdfy4Y6E8tyFQT+bxnvnvq0tiMvWZprOXXi1+E/vda0cB
         kxKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b5LLyL4NM9RFy872x3bTzHa5dSLMasbi37/mYNx6DCA=;
        b=vW6IodSwqnq9mxXOZTvMqdSUOdKRfF1ftKCb8fDM4dRlUXQ7xSvZyIDWTEwXav9+V+
         umf7+pb2m1LqlHswrR1TtqOJypYKa1Gnvr5eTBRDW+gy2MhtDDobBH484EVwFs1MrYy+
         oMHpEDcTQt9YGth+wxIXDkNl90FhgBb/Gpa9MC21z6rxxSspB3g83BKe28QzXXltA46n
         odlqZiGMb5WJqmG9MjmJiF8SwZKCJFi1voSD+hZZ86pj/NoQ3pyKCnbyKhEDXhzNaRIP
         gHIp1mJZrbYTpvQEp5yoGfP9bKjUUAyD24zelVhB6OAsnAIs98qG9ng0CcmD5cH39Eri
         5KdQ==
X-Gm-Message-State: AFqh2koynnoSQ5Ozx7odyqmU0AGB2q42PRQjfVm+aUfPJsYnyId2zgzc
        c0wUsBEapp4VnHZJZuRo0Jjazg==
X-Google-Smtp-Source: AMrXdXsQsitf8BzeJXaPtKrY+OeCwfG0Ax0tXdx3cyfdOVAR+FOLMjW3bN2wF/BNgF4woch/VT2ctg==
X-Received: by 2002:adf:ce90:0:b0:2bb:edc7:504 with SMTP id r16-20020adfce90000000b002bbedc70504mr23324176wrn.26.1674486798260;
        Mon, 23 Jan 2023 07:13:18 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n1-20020a5d67c1000000b002bc7f64efa3sm34737922wrw.29.2023.01.23.07.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 07:13:17 -0800 (PST)
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
Subject: [PATCH 04/13] dt-bindings: serial: correct ref to serial.yaml
Date:   Mon, 23 Jan 2023 16:12:53 +0100
Message-Id: <20230123151302.368277-4-krzysztof.kozlowski@linaro.org>
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

The serial bindings should reference the local (in kernel) serial.yaml,
not the /schemas/serial.yaml.  The latter comes from dtschema package
and is a small subset of serial bindings.

Usage of the local serial.yaml allows typical properties and children:

  xilinx/avnet-ultra96-rev1.dtb: serial@ff000000: Unevaluated properties are not allowed ('bluetooth' were unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/serial/cdns,uart.yaml         | 2 +-
 Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/cdns,uart.yaml b/Documentation/devicetree/bindings/serial/cdns,uart.yaml
index 876b8cf1cafb..0c118d5336cc 100644
--- a/Documentation/devicetree/bindings/serial/cdns,uart.yaml
+++ b/Documentation/devicetree/bindings/serial/cdns,uart.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Michal Simek <michal.simek@xilinx.com>
 
 allOf:
-  - $ref: /schemas/serial.yaml#
+  - $ref: serial.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml b/Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml
index 2f4390e8d4e8..6f65e9a81c29 100644
--- a/Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml
+++ b/Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml
@@ -63,7 +63,7 @@ required:
   - xlnx,use-parity
 
 allOf:
-  - $ref: /schemas/serial.yaml#
+  - $ref: serial.yaml#
   - if:
       properties:
         xlnx,use-parity:
-- 
2.34.1


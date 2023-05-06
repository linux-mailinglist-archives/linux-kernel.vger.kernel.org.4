Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC496F94E7
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 01:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjEFX1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 19:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjEFX1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 19:27:16 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE7C3C10;
        Sat,  6 May 2023 16:27:11 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-2fe3fb8e25fso2052635f8f.0;
        Sat, 06 May 2023 16:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683415630; x=1686007630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJf8u6DteZrPC3Nb9ejhbBWXKTmUXoGnAUErkLrt6HA=;
        b=fuB+QTQ888ZTij4/cuhjc2J36+2SHGZZUPvY9AxiWAJDNXKs1H+DLGajpyGdD45QO6
         R8tDNXgvqRvCqlwECg3WLCIMddMAGAtInNgsJYsaQu9QVlic/DWlGLXVU85DzbuYtWfp
         rWPTie92IwIiRDidgicKyEXv6nnTsr7csHy9C08DS/YE/NPe+YxVJSIga/lfeXPsFbMx
         DRkwJw+Enwjifo1zwQnMEEFt2tqRg/W4BevLYoL+ngWj74kdMdrguArsrJlCX/GcJFlJ
         Y2Q87YT1v7T3aZuEqNi/s+JYtVli3YGdn2qvpeTxmkKnjMYed277mCOpRuJhO2dvqBYQ
         yvUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683415630; x=1686007630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rJf8u6DteZrPC3Nb9ejhbBWXKTmUXoGnAUErkLrt6HA=;
        b=fOFUbYjcM3sOZWYIEykuxL2fSqh58BMOAcexLISZ7+Co/rFw4tlfQv+GLN9ixplrAb
         9PLpcnGnXIcaNwwPvBWNGk/EdLUwZWzUwa1sG7qd+cz3692DePgQ/jEq+lq7rsb/rNGn
         cRGBiIKGWdmrSx+H38k2K/UEHus6pvZD8Mmjpz9o9dAdug91YmPHinL8ANWP4zC+hB1D
         eRE5DICIiJFG0Af4oemzJyYPmDHpnrNw5yc4vjrr8eE27yIEGPvvLzc+KPGZ7oiROWAJ
         TszuOmxKmPyAzJRBhahvnMGPTweGpC9W1jOsxkJXvUyQTfiZH4pBq2WMWSEhgfocCISi
         KLPg==
X-Gm-Message-State: AC+VfDxRWUZIMhpoJiPf/yy9iqV1WYYQaAMwmjJsQFQc3YwrmQ9yaazm
        bASITtjMKqnUc50ZnPOYuO8=
X-Google-Smtp-Source: ACHHUZ4lfjThY8M9Rr67+NJ4VEoF7t2da+0IiXeb6D0lzEyek42K6sPWLDsq1r7ivWHquzui3y9+wA==
X-Received: by 2002:a5d:5749:0:b0:303:97db:ae93 with SMTP id q9-20020a5d5749000000b0030397dbae93mr3984246wrw.44.1683415630207;
        Sat, 06 May 2023 16:27:10 -0700 (PDT)
Received: from localhost.localdomain ([176.221.215.212])
        by smtp.gmail.com with ESMTPSA id p4-20020a1c7404000000b003f1739a0116sm12098655wmc.33.2023.05.06.16.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 16:27:09 -0700 (PDT)
From:   Maksim Kiselev <bigunclemax@gmail.com>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Icenowy Zheng <icenowy@aosc.io>,
        Maksim Kiselev <bigunclemax@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Maxime Ripard <mripard@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v3 1/5] dt-bindings: spi: sun6i: add DT bindings for Allwinner R329/D1/R528/T113s SPI
Date:   Sun,  7 May 2023 02:26:04 +0300
Message-Id: <20230506232616.1792109-2-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230506232616.1792109-1-bigunclemax@gmail.com>
References: <20230506232616.1792109-1-bigunclemax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Listed above Allwinner SoCs has two SPI controllers. First is the regular
SPI controller and the second one has additional functionality for
MIPI-DBI Type C.

Add compatible strings for these controllers

Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
---
 .../devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml   | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
index de36c6a34a0f..807dde457e3b 100644
--- a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
@@ -21,6 +21,7 @@ properties:
     oneOf:
       - const: allwinner,sun6i-a31-spi
       - const: allwinner,sun8i-h3-spi
+      - const: allwinner,sun50i-r329-spi
       - items:
           - enum:
               - allwinner,sun8i-r40-spi
@@ -28,6 +29,12 @@ properties:
               - allwinner,sun50i-h616-spi
               - allwinner,suniv-f1c100s-spi
           - const: allwinner,sun8i-h3-spi
+      - items:
+          - enum:
+              - allwinner,sun20i-d1-spi
+              - allwinner,sun20i-d1-spi-dbi
+              - allwinner,sun50i-r329-spi-dbi
+          - const: allwinner,sun50i-r329-spi
 
   reg:
     maxItems: 1
-- 
2.39.2


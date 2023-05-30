Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B3B7164DE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbjE3OtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjE3OtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:49:03 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157C5121
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 07:49:01 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2af2d092d7aso48590751fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 07:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685458139; x=1688050139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hlemkSAZzL/U9gKFtrjPiWNMuzaH3xd08e53mEnq57M=;
        b=q76h1ZEyA3kflY8T+tAg6eEkOHLYK0YZTFqFbCCKF2K9iyLput/pxGqmVSlGXhqv7P
         WnAHGN3sBVvANR/w6I/EN92qOLxT7kfA+TYRrbMeQfQ5Ix17P62ma2yKm6N1X7n7zy6a
         9nl5jWppRRrsIKlusdV7Z4xtzwxXfCbcQGTgabenNUfaXkr6pbTiAq/s44M2sqhPwN5Y
         aF2N5hQt6Q2QJHKpFbTR/tFqhDOls0J+/KD33Q68HF2m1O8GZk0L7u6CimkvrwEvNDi8
         9vyiJE+L61MBUJCGSp7RCegRZ1TxnfE/0ySvZZCeQAKuFtx+4L45fUMJd/FEseCp9LT+
         MzUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685458139; x=1688050139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hlemkSAZzL/U9gKFtrjPiWNMuzaH3xd08e53mEnq57M=;
        b=WLrY163tfpdfdGfRtfGn0RzwkntULt/LjbBdJgRWClECO4v19kS1zSOmzrZTTxvRDs
         RmvLAelIz+Is2hPccPtk3g+PS8FzB1yRleSuyVtOqM99YbDjRFNoubRk8SvxAcsRJzsm
         f0jdP+bjgCmxPOTf9z2yFauFc7w+pbFqUhKY+Vtk84O9/YmTzidCedV7tENqJg6rVT6Y
         Y25BXZJ4u0y2MUF18QWAr7i2KsCpYN6jbI/RLIYR23djF51Pp65iIBcYZJaUbej44Zy0
         DJl4EiRZYq7b3mpPkhisoVk1vt9xIAwBQJWR3QyrD4i4f8WHRL6h7s+rrWC3syyv3N2C
         uuiA==
X-Gm-Message-State: AC+VfDwF/Z4lSnziGKryz8tPAjZw9Rry+5kRWEABxP4C7fEGyTc7LzTy
        EYyf+EiHcBh7TTTVixLmZakD+Q==
X-Google-Smtp-Source: ACHHUZ75iw6ri2Ado2xzCbkAC1E3tQDvSOkgKFSnxjKffw7eTsxcgM6foIzrYPzzNhulhzOltIlCVg==
X-Received: by 2002:a2e:6a17:0:b0:2ac:b63e:94a6 with SMTP id f23-20020a2e6a17000000b002acb63e94a6mr966165ljc.21.1685458139198;
        Tue, 30 May 2023 07:48:59 -0700 (PDT)
Received: from krzk-bin.. ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id q21-20020aa7cc15000000b00514b2717ec6sm631283edt.28.2023.05.30.07.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 07:48:58 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Dipen Patel <dipenp@nvidia.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dilip Kota <eswara.kota@linux.intel.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-rtc@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-spi@vger.kernel.org, timestamp@lists.linux.dev,
        linux-watchdog@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH 1/7] dt-bindings: phy: intel,combo-phy: restrict node name suffixes
Date:   Tue, 30 May 2023 16:48:45 +0200
Message-Id: <20230530144851.92059-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530144851.92059-1-krzysztof.kozlowski@linaro.org>
References: <20230530144851.92059-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the pattern matching node names a bit stricter to improve DTS
consistency.  The pattern is restricted to:
1. Only one unit address or one -N suffix,
2. -N suffixes to decimal numbers.

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Tony Lindgren <tony@atomide.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>
---
 Documentation/devicetree/bindings/phy/intel,combo-phy.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/intel,combo-phy.yaml b/Documentation/devicetree/bindings/phy/intel,combo-phy.yaml
index 5d54b0a0e873..7dd6a4d94b48 100644
--- a/Documentation/devicetree/bindings/phy/intel,combo-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/intel,combo-phy.yaml
@@ -15,7 +15,7 @@ description: |
 
 properties:
   $nodename:
-    pattern: "combophy(@.*|-[0-9a-f])*$"
+    pattern: "combophy(@.*|-([0-9]|[1-9][0-9]+))?$"
 
   compatible:
     items:
-- 
2.34.1


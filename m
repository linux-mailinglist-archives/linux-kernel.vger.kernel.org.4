Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B9C639A85
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 13:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiK0MdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 07:33:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiK0MdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 07:33:07 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667C2CE0B
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 04:33:06 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id u27so2470788lfc.9
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 04:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CoiNQxKW0RSoOcQ50Corefzwrk1M9kQCbioyKko52Q8=;
        b=a/vG3/7Px25YtNF7c8CL08EI18btkroRbcaaWave/chVmyqGvvzI5jHawQhEfwQm8E
         ZQgjtoP4Dh6CyELbILvsjx+1Ta/6Dddydd/5BBQhCRtQZGUOiEKmesrzLGMpqz1x+mpd
         Kh+MeGvzvwuzZcN3Ik2PlLEv9va9ae/PCaP1VHZTkn3XKOINfsxUd0RJck0JpmTqG39B
         HGXcJSrUQ5itbNIIgKkBr7+Dw2T6D/I4ElJJ6JXjg3nYlQb8PSZydijFHNLlZ2Pg5i2l
         vuQNrDkMJs6Zn6Hqc9F8ZRMOKQe6+u2rBGF21UWsrJ/RoVJpsz0BzrXAicumYz8M/f24
         aLAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CoiNQxKW0RSoOcQ50Corefzwrk1M9kQCbioyKko52Q8=;
        b=KSLFf6eZek816hVEhoAzBr2N65NAiIZaNZ8ttcw6yTgOCBkdfVR2ms5Me4uT22g99j
         TyTc8DolkXp3f29MslYBafATHsGCvKh58g70TxTY9rUpMWd0MrMJjnj/p3vApyuZu8ff
         KnIhPq/gbTzqn0pHFxSrtN+cCuiSUKLo/SIkxrO+meiwpZnSRu1cPUmu6yYfiw+0eDFh
         NyKoI8Yv8b3cSf3I8MhLga2uULUPPD5YRUhTKP3d3DMBihQYH99tcKIM06vekFDiHf+g
         isFrS6yflSYHf8KNCGgzTwnT1uY2PZ+aeBg0F5f1xBpcvRSRtyzqbPhI1o6l7xWpJZQK
         zH/Q==
X-Gm-Message-State: ANoB5pmPg8DpcLfg9pyYXzqegU10jdmkDG6PFFGoCptdevbcMPXSFp2b
        uufyzbbR8Vt0pMSE7RlYTuQmGw==
X-Google-Smtp-Source: AA0mqf4NOHx8oHEaVSb5QxELEepIu3rq66l/GXeQxSRRqp+ZpDVGOJF9cg7jBcwjk+1kmNXYw4hnqA==
X-Received: by 2002:a19:7107:0:b0:4a8:e955:77e7 with SMTP id m7-20020a197107000000b004a8e95577e7mr9415620lfc.573.1669552384823;
        Sun, 27 Nov 2022 04:33:04 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id bf36-20020a05651225a400b0049fff3f645esm1270435lfb.70.2022.11.27.04.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 04:33:04 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Sriranjani P <sriranjani.p@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH v2 3/4] dt-bindings: soc: samsung: exynos-sysreg: add dedicated SYSREG compatibles to Exynos5433
Date:   Sun, 27 Nov 2022 13:32:58 +0100
Message-Id: <20221127123259.20339-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221127123259.20339-1-krzysztof.kozlowski@linaro.org>
References: <20221127123259.20339-1-krzysztof.kozlowski@linaro.org>
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

Exynos5433 has several different SYSREGs, so use dedicated compatibles
for them and deprecate usage of generic Exynos5433 compatible alone (as
it is too generic).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Reviewed-by: Sriranjani P <sriranjani.p@samsung.com>

---

Changes since v1:
1. Add Rb tags.

Cc: Sriranjani P <sriranjani.p@samsung.com>
Cc: Chanho Park <chanho61.park@samsung.com>
Cc: Sam Protsenko <semen.protsenko@linaro.org>
---
 .../bindings/soc/samsung/samsung,exynos-sysreg.yaml | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
index 68064a5e339c..42357466005e 100644
--- a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
+++ b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
@@ -17,10 +17,21 @@ properties:
               - samsung,exynos3-sysreg
               - samsung,exynos4-sysreg
               - samsung,exynos5-sysreg
-              - samsung,exynos5433-sysreg
               - samsung,exynos850-sysreg
               - samsung,exynosautov9-sysreg
           - const: syscon
+      - items:
+          - enum:
+              - samsung,exynos5433-cam0-sysreg
+              - samsung,exynos5433-cam1-sysreg
+              - samsung,exynos5433-disp-sysreg
+              - samsung,exynos5433-fsys-sysreg
+          - const: samsung,exynos5433-sysreg
+          - const: syscon
+      - items:
+          - const: samsung,exynos5433-sysreg
+          - const: syscon
+        deprecated: true
 
   reg:
     maxItems: 1
-- 
2.34.1


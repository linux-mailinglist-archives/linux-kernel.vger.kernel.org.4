Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7684566202A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 09:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbjAIIkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 03:40:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233666AbjAIIj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 03:39:57 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E408B13F1A
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 00:39:55 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id s9so7353323wru.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 00:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xQ3K/io4iY2GwjynBlbKdP/dQNns/heqzgxTc+VLTbk=;
        b=uoybz+I0rrdzryvAFoZXzdYjqss4CEShTQt9kaZMolZJ3XeINCEyRSF62QWRd/h98X
         /VtYvv+HxunluEMQHCxODay1/luLVAZXtoaNNMphItwULOeLDSLcYbhGxeTEAdQAFoNI
         3x6qByYrV7IJroPxWL9f4rs9wl6kn0QnUPOm8OylgUGXq+r6b+hYvbXVgQI9BB5m6983
         OQ7U7RmB6bIwywvnzFlZfK6fqKT4kAQojqtwRUKbJlka82Zc1tAWeUVAyk8Ka6k26iWO
         W7vpbs5RwCb5064N0vUgGA0ngC5FReDqquwyXOt9/6NphtEN3W4mtg1Eiu/n+OAke6uB
         5eKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xQ3K/io4iY2GwjynBlbKdP/dQNns/heqzgxTc+VLTbk=;
        b=6MOTfKbxv+uXpIrrDhKEXpjY/2UljNa9irRrwYnli9BdDu/2TxMugxM/sYJFP2mYR6
         g3gIFD8zUUTk2CPJTMmrC/YVVURFft221IsuUvtLqE4cDDJ+IJ+NUnWmTmh1rglQE1sQ
         76zmNaNxSJ6iEpmD4BDhJCfXMXRJEH5HRciBeQwZ8jADXFrWH//4UGv5GOOdGRceuZpE
         LDmXu0s3/Tk1Swe6eTApmuGTJzZC0rwOAs22038b/sHSVReu/yK13PgBzuphr8klH0CG
         jZqGgMVgo1VUzUnUkvSxNOAiD9AdvEUVbA6FAp1nSWDsl/5qvb1ZZP2kYRNRSFPeFPEC
         YOOA==
X-Gm-Message-State: AFqh2kofgLeY6wPibtGg0hTOuKsiR30RFaIFL75H2nEUra6kJm+t0Cpd
        GMZwk8sFCaqsjkgV7gZP3Zd9KQ==
X-Google-Smtp-Source: AMrXdXtmW+X3Ei5S+EFkiH61YWcu+ID/9ZhO6toJ7+59ffejgvukY81lSbLVhJyf6Aij7xkA9Qsa0Q==
X-Received: by 2002:adf:eb4f:0:b0:242:659c:dc7 with SMTP id u15-20020adfeb4f000000b00242659c0dc7mr38364812wrn.61.1673253594453;
        Mon, 09 Jan 2023 00:39:54 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id b1-20020adf9b01000000b0028e55b44a99sm7853335wrc.17.2023.01.09.00.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 00:39:54 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Sriranjani P <sriranjani.p@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH] dt-bindings: soc: samsung: exynos-sysreg: correct indentation for deprecated
Date:   Mon,  9 Jan 2023 09:39:48 +0100
Message-Id: <20230109083948.77462-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

"deprecated" keyword was indentend wrong - entire list of compatibles
starting with generic Exynos SoC compatible is deprecated.

Reported-by: Rob Herring <robh@kernel.org>
Fixes: 0a2af7bdeeb4 ("dt-bindings: soc: samsung: exynos-sysreg: add dedicated SYSREG compatibles to Exynos850")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
index 60958dac0345..163e912e9cad 100644
--- a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
+++ b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
@@ -36,7 +36,7 @@ properties:
               - samsung,exynos850-sysreg
               - samsung,exynosautov9-sysreg
           - const: syscon
-            deprecated: true
+        deprecated: true
       - items:
           - enum:
               - samsung,exynos850-cmgp-sysreg
-- 
2.34.1


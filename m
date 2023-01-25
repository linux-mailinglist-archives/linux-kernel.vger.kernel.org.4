Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F040367B8EB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 18:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235971AbjAYR7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 12:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjAYR7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 12:59:51 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6822DE62
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 09:59:50 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id t18so5070873wro.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 09:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sTOOyplbHxnZ+EFGvkRK9RseAv80+oP0c90JV+EsvHc=;
        b=b3xrzTS5gcAyZdQpRwmO6xq87K/+gmwj3GtougbVYdVQRQCOEZHNlrsx6LRYrb2KnG
         AVIP1dZjGgS8PfB9/OiiHLgXsTAYL+xYW4OSiWSmwiYjizCelQw9X/ga3CFj5xse05gS
         lmmZ/fj88VeBXnC0Yr9ZZbmCzwNMdFn6+yAc669OjP/0o3F8l8/1W4vqUv6jPElbvzAt
         KbOEoXZbQRCAqWvdM/FsVZZhUZ7t+7Xm6g0JlpWUCAjOsq9TEF/C3X/NT5cl2n55zn6z
         ga8meNb/niwL0bojsOlp8FgZjgdx8/11jRwcP0pFjW2I4yR/OSwrAW4RClEXCQXYMGTo
         eMnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sTOOyplbHxnZ+EFGvkRK9RseAv80+oP0c90JV+EsvHc=;
        b=xJaodhr88FK9Wk6OGofWRtkV3+72sXU6GBSumh+rgck8R/GLk6iXbx72lJhGhaseZB
         Fc1ezxs3Fi0EAsz7hBxWd/tJbbn+W1lNjO1bd3ybr1McUgd0/vdK9u47W8gJY5l1m+8z
         EDliHykNouKU3qHEw5RA8wUj6cKPDLhMZYUhpLTyN6SDtH5UuG3ChxS2HubrnF5DUUyE
         AIpPODbRWHGhx4Pnxb9ffRtfQr/yGwQRviSDf9jTO79hDO7KKJuTgWQFQQN/zSQSDfl/
         REbYE+71AlFHPD9G4Y5XQws4c+QnkqW8H+xHB3poMYrVQllvXPEh0LsBJLkYxPcvGP/Y
         Zw6g==
X-Gm-Message-State: AO0yUKUbZrdD9DsDy2OLGlwie2wd0MYGWTgjcdqBFgown08JO56czbon
        SAhmkEY52po68guKHXXG/Dsm0Q==
X-Google-Smtp-Source: AK7set8wYctbejAZWGPmx51Hf1KyVA1kzcMV4t6Iwl3vyOvPDFih0BorVAjojrAKqLqCV6ssK3VAiA==
X-Received: by 2002:adf:fa09:0:b0:2bf:ac2c:4489 with SMTP id m9-20020adffa09000000b002bfac2c4489mr6572646wrr.54.1674669588976;
        Wed, 25 Jan 2023 09:59:48 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id w14-20020a5d608e000000b002bc84c55758sm6048927wrt.63.2023.01.25.09.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 09:59:48 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: usb: samsung,exynos-dwc3: allow unit address in DTS
Date:   Wed, 25 Jan 2023 18:59:43 +0100
Message-Id: <20230125175943.675823-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Samsung Exynos SoC USB 3.0 DWC3 Controller is a simple wrapper of
actual DWC3 Controller device node.  It handles necessary Samsung
Exynos-specific resources (regulators, clocks), but does not have its
own MMIO address space.

However neither simple-bus bindings nor dtc W=1 accept device nodes in
soc@ node which do not have unit address.  Therefore allow using
the address space of child device (actual DWC3 Controller) as the
wrapper's address.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

DTS fixes are here:
https://lore.kernel.org/linux-samsung-soc/20230125175751.675090-1-krzysztof.kozlowski@linaro.org/T/#t
---
 .../devicetree/bindings/usb/samsung,exynos-dwc3.yaml        | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml b/Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml
index 6b9a3bcb3926..a94b1926dda0 100644
--- a/Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml
@@ -29,6 +29,9 @@ properties:
 
   ranges: true
 
+  reg:
+    maxItems: 1
+
   '#size-cells':
     const: 1
 
@@ -108,8 +111,9 @@ examples:
     #include <dt-bindings/clock/exynos5420.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
 
-    usb {
+    usb-wrapper@12000000 {
         compatible = "samsung,exynos5250-dwusb3";
+        reg = <0x12000000 0x10000>;
         #address-cells = <1>;
         #size-cells = <1>;
         ranges;
-- 
2.34.1


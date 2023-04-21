Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5754C6EB4CE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 00:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbjDUWcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 18:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233856AbjDUWbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 18:31:53 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B97130FC
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 15:31:50 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-94a34d3812cso374795266b.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 15:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682116308; x=1684708308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GM3ex0o7phRkVYpEz3RNOVhx0nnRDZ3E5rWibO8rzvY=;
        b=MVdya2iwMP+Tb9vrJO6Qaq5Kadu1S6rbgf3tM+sKi814OIZke9h3FIkL1sbBUndcw8
         Bg4IJjwu49Sq8xCKa72Gu69/aPYrdVZG+MEQKrpzZgDYmjO/txJqbPNFf0xcjweU/f49
         55z39WWexzh4lSHCq+3szFg4Ab0jTRUYub/D4HiFBlM+qGJ1yHABowLEbh/pNDb8z4f7
         SvVkIbiMAG2RKS2lColNqR9gqUCUS5xDcapSU9oDEJimICE+xLAQq0qfSqnH9kzjXshP
         8bvZwZdKqpa8w6ON2HUQNQRLJ5a4ASD/bLhWYjQ/KpUawBbGPZrKYnr+RSQcNtTHAc1L
         WEgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682116308; x=1684708308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GM3ex0o7phRkVYpEz3RNOVhx0nnRDZ3E5rWibO8rzvY=;
        b=E1Moo+uF25OqsNaAM7JneDpiRa1Yf6wz2/kdzmDR1CtA38vIuihSdsRNaj3lodh/wH
         q6XaIjdJvIl+yKy69wQ5Wq1FD1Sw5xUT3nlm0sCDeczPiy8E5r4Q/WExdlxvIgYHIK93
         Z98YodXJ9uYtXY9Hv1FC7XC4xs29pUSYD/rJp+1gX68mjs7IqINmopbFiYQ6YwA3sSLW
         Xj3Y+UCDRIE93Juin3unjFWq6AopzBm4ebbHAf+TVOt/jTQ1pepjBRi+c0qLpWrlNlkH
         OfJVxDEOf6xqUuXvNCWI5+Df2527DJ0yG8E3/uSBh33aUghpx5W5nRf0AvwJuPwM2PKd
         Ro8w==
X-Gm-Message-State: AAQBX9cBweq1RbxKlQG49ppmajSwM/C+dsFP0mwEgXy0WPYIcoEPH2WZ
        0KYa6ry92wXEjAOEEDaznE5UKQ==
X-Google-Smtp-Source: AKy350bUxqLy+nykcJVMKDQWK8ENRYMKDjIoQtQ7q7xl9+crY9FN76esYAOt9D+Gsdg4ZwOyTsaQGA==
X-Received: by 2002:a17:907:98f6:b0:94a:8b35:f15d with SMTP id ke22-20020a17090798f600b0094a8b35f15dmr4281217ejc.45.1682116308667;
        Fri, 21 Apr 2023 15:31:48 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:687d:8c5:41cb:9883])
        by smtp.gmail.com with ESMTPSA id l7-20020a1709060e0700b0094ee21fe943sm2557098eji.116.2023.04.21.15.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 15:31:48 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: socionext: add missing cache properties
Date:   Sat, 22 Apr 2023 00:31:47 +0200
Message-Id: <20230421223147.115156-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As all level 2 and level 3 caches are unified, add required
cache-unified and cache-level properties to fix warnings like:

  uniphier-ld11-ref.dtb: l2-cache: 'cache-level' is a required property
  uniphier-ld11-ref.dtb: l2-cache: 'cache-unified' is a required property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Please take the patch via sub-arch SoC tree.
---
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi | 2 ++
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 4 ++++
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
index 7bb36b071475..4680571c264d 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
@@ -52,6 +52,8 @@ cpu1: cpu@1 {
 
 		l2: l2-cache {
 			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index 4e2171630272..335093da6573 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -86,10 +86,14 @@ cpu3: cpu@101 {
 
 		a72_l2: l2-cache0 {
 			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
 		};
 
 		a53_l2: l2-cache1 {
 			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
index 38ccfb46ea42..d6e3cc6fdb25 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
@@ -83,6 +83,8 @@ cpu3: cpu@3 {
 
 		l2: l2-cache {
 			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
-- 
2.34.1


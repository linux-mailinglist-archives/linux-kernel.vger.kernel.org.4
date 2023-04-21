Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E026EB4E5
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 00:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbjDUWdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 18:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233979AbjDUWcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 18:32:42 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419EC4491
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 15:32:16 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-94ef0a8546fso324794966b.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 15:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682116328; x=1684708328;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hr3UaX7LY90jhy2fAf/k8i9BKyCM6T9mwnocDBAE7gU=;
        b=odFevG8v8d+W5aEKiQzZr5FtZRgadu5OiNaUD7LpF0XD84P7iVFr9edjaU7mxmRw45
         wSpAWwfEQMstHOCH0Dnrqo92IWi952IykEIVnW7CV4okdzA+HPnJHekPtA7TsBP+rQsA
         bX0t+CNhpQxKU3YWkXFqMd3Cy0ZW2btY6xL8/HFMLUma3OjZhFj0UPv1g+zLgsDsJSMn
         zOwWO4NYtar8/OZySxXTtBjG/5psMWJKJqXjTBLmh8NuWxZGGOHc3P+DbBLqlsZDx2Wc
         WcRTSKerGEcc91ROJN1cjE38SCd28JUPNudsi0enL9A9QoOCIvJ1kssdzK/oG1M1+Itj
         oyMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682116328; x=1684708328;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hr3UaX7LY90jhy2fAf/k8i9BKyCM6T9mwnocDBAE7gU=;
        b=VyXzIxVV+iUbvI/SUw7S7EN08ILpmoUIzJJ1h3nGq++Y7ZG+tVGRgmkVKzbRb7aQM+
         dgh+6pgcXG6dIT3evjSB0XVn7bLrjVmkTBRlai1AsYHgE8bCKoIhgaP1JtO0Wq4Roe0C
         QQbw8UnGEWLTItwmrK29YqMc932iMgg02715Au+4auFBKjPFgPT9rzMkulaJ4X7OuGz6
         aoRTgB30B9qZWjAQwKyWBjKtrVEPyir1Y1Y0uVeys3I52RfQofMhodnZ/qVMWG96FRbk
         3idFMwD9f8tj9a93a20RXchSGvq7ZqQKee2eZeLcAuzTHN+ZgdPqBnzvPYAkHXKXC8NB
         m3pg==
X-Gm-Message-State: AAQBX9eWIjmXMjPnjOIlIYCGpCwpUN9X4ZaQccL34uZoU+jYwWbwh9MG
        VPwb+04uf9ghHc3V5H5+vAWt4A==
X-Google-Smtp-Source: AKy350aX46RqFmqg6T10xi9P2gyEodIo/v28usuxp2r+ODFURoEn5Wr0KLkdzSeONoVShFjGFGotBQ==
X-Received: by 2002:a17:907:168d:b0:953:4775:baa7 with SMTP id hc13-20020a170907168d00b009534775baa7mr4328662ejc.52.1682116328101;
        Fri, 21 Apr 2023 15:32:08 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:687d:8c5:41cb:9883])
        by smtp.gmail.com with ESMTPSA id mc2-20020a170906eb4200b0094ca077c985sm2539058ejb.213.2023.04.21.15.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 15:32:07 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: freescale: add missing cache properties
Date:   Sat, 22 Apr 2023 00:32:06 +0200
Message-Id: <20230421223206.115528-1-krzysztof.kozlowski@linaro.org>
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
cache-unified properties to fix warnings like:

  fsl-ls2080a-simu.dtb: l2-cache3: 'cache-unified' is a required property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Please take the patch via sub-arch SoC tree.
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 1 +
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 1 +
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 1 +
 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi | 4 ++++
 arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi | 4 ++++
 5 files changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 678bb0358751..9cbb31191cf9 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -47,6 +47,7 @@ cpu1: cpu@1 {
 		l2: l2-cache {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index b9fd24cdc919..f8acbefc805b 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -85,6 +85,7 @@ cpu3: cpu@3 {
 		l2: l2-cache {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index a01e3cfec77f..50f68ca5a9af 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -80,6 +80,7 @@ cpu3: cpu@3 {
 		l2: l2-cache {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
index 1e5d76c4d83d..1aa38ed09aa4 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
@@ -96,21 +96,25 @@ cpu7: cpu@301 {
 	cluster0_l2: l2-cache0 {
 		compatible = "cache";
 		cache-level = <2>;
+		cache-unified;
 	};
 
 	cluster1_l2: l2-cache1 {
 		compatible = "cache";
 		cache-level = <2>;
+		cache-unified;
 	};
 
 	cluster2_l2: l2-cache2 {
 		compatible = "cache";
 		cache-level = <2>;
+		cache-unified;
 	};
 
 	cluster3_l2: l2-cache3 {
 		compatible = "cache";
 		cache-level = <2>;
+		cache-unified;
 	};
 
 	CPU_PW20: cpu-pw20 {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
index c12c86915ec8..8581ea55d254 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
@@ -96,21 +96,25 @@ cpu7: cpu@301 {
 	cluster0_l2: l2-cache0 {
 		compatible = "cache";
 		cache-level = <2>;
+		cache-unified;
 	};
 
 	cluster1_l2: l2-cache1 {
 		compatible = "cache";
 		cache-level = <2>;
+		cache-unified;
 	};
 
 	cluster2_l2: l2-cache2 {
 		compatible = "cache";
 		cache-level = <2>;
+		cache-unified;
 	};
 
 	cluster3_l2: l2-cache3 {
 		compatible = "cache";
 		cache-level = <2>;
+		cache-unified;
 	};
 
 	CPU_PW20: cpu-pw20 {
-- 
2.34.1


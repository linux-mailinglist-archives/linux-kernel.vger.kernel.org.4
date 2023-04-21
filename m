Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A936EB4EE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 00:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234062AbjDUWdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 18:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233853AbjDUWc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 18:32:56 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760DD44AE
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 15:32:23 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-94eff00bcdaso373130366b.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 15:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682116336; x=1684708336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wXy9a0k4qOMAVmB2/btPHugUWWK8+3AF8yRhIQLtz+Y=;
        b=DM6PmEj4eUkKcPpVDXkfsDteoHuobt27uIXJLIpn+BYC22GAEQJOF4FCpVXv3FGI2/
         oREsHOBNEeUhEaIfTm9KRW6BZ8jm8y2obWKWRnsxS6CB4xFECO0M2grKOCpkX3fwVihh
         LmtIj+toKD6qDroDMD4m/Jl2NdmEfY1It4vUMWaSCScRWxtjeAnZGUIWseFs/1QCZMfg
         +PqYzVuNh9HPM/x7SWZEIwMckN8jqFssN+rwCCg86KiWAmQtI35O4OwdIoV3RaTaaFAk
         AV0rvG7wwX9pdwGnRR5Q+KhSjKlhEKa7hbAPkCLebr3ErPLckHaUS5EqlguoB61kXdcA
         jPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682116336; x=1684708336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wXy9a0k4qOMAVmB2/btPHugUWWK8+3AF8yRhIQLtz+Y=;
        b=eD5LQFdMMN8S+RBC15QBZV6xF0o4yx2y2TuVotu3fKL0m3FQB/PD7KLRVpqV1vMwue
         x9XC3zJ0b86A9AaVNOHLdbHs8mhKHtQBshqtJxskXhJWU662MNzXNYPhgKAnNkJh3Cao
         wIf5V4WAolZwKrnQJLMXZ+W/QK3kbT6oZMGuA36Xi+F6E1fRthJIXk+Z7Gxmk0kVHMpO
         ujXjdv5Csa5KGzkCVEAOPj/nFBUHwkr9iVzlCaKkz2C5EPjH1vFzCpF/mtIjaeiRbTez
         7UldG7rInkTaY14uYyRWO069uHMr5aMqMhyBlLcqI4nqzzC8EggAi1eUt7M6c3CE7u7D
         zZGw==
X-Gm-Message-State: AAQBX9eeVYj1KtprQzsgCbiF42efBZE7fPXVaxyOt2rhzCxEOAG4i0Vl
        FVfKomUUCoZlWD54kPe8iom12Q==
X-Google-Smtp-Source: AKy350YoFlkWWENwH15S0t5/MZMb58+9Lmn7vyViDHVSRvvEYizgRWMin3TPvkImSP6Kt0QD3GTydQ==
X-Received: by 2002:a17:906:5647:b0:94f:36a0:da45 with SMTP id v7-20020a170906564700b0094f36a0da45mr3626056ejr.29.1682116336643;
        Fri, 21 Apr 2023 15:32:16 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:687d:8c5:41cb:9883])
        by smtp.gmail.com with ESMTPSA id j19-20020a17090686d300b0094f109a5b3asm2586821ejy.135.2023.04.21.15.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 15:32:16 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: hisilicon: add missing cache properties
Date:   Sat, 22 Apr 2023 00:32:14 +0200
Message-Id: <20230421223215.115666-1-krzysztof.kozlowski@linaro.org>
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

  hi3660-hikey960.dtb: l2-cache0: 'cache-unified' is a required property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Please take the patch via sub-arch SoC tree.
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi |  2 ++
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi |  2 ++
 arch/arm64/boot/dts/hisilicon/hip05.dtsi  |  4 ++++
 arch/arm64/boot/dts/hisilicon/hip06.dtsi  |  4 ++++
 arch/arm64/boot/dts/hisilicon/hip07.dtsi  | 16 ++++++++++++++++
 5 files changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index a57f35eb5ef6..7e137a884ae5 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -204,11 +204,13 @@ CLUSTER_SLEEP_1: cluster-sleep-1 {
 		A53_L2: l2-cache0 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 
 		A73_L2: l2-cache1 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index f6d3202b0d1a..872e9c73c422 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -187,11 +187,13 @@ cpu7: cpu@103 {
 		CLUSTER0_L2: l2-cache0 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 
 		CLUSTER1_L2: l2-cache1 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/hisilicon/hip05.dtsi b/arch/arm64/boot/dts/hisilicon/hip05.dtsi
index 5b2b1bfd0d2a..65ddc0698f82 100644
--- a/arch/arm64/boot/dts/hisilicon/hip05.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip05.dtsi
@@ -212,21 +212,25 @@ cpu15: cpu@20303 {
 		cluster0_l2: l2-cache0 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 
 		cluster1_l2: l2-cache1 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 
 		cluster2_l2: l2-cache2 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 
 		cluster3_l2: l2-cache3 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/hisilicon/hip06.dtsi b/arch/arm64/boot/dts/hisilicon/hip06.dtsi
index 291c2ee38288..c588848bfdeb 100644
--- a/arch/arm64/boot/dts/hisilicon/hip06.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip06.dtsi
@@ -212,21 +212,25 @@ cpu15: cpu@10303 {
 		cluster0_l2: l2-cache0 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 
 		cluster1_l2: l2-cache1 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 
 		cluster2_l2: l2-cache2 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 
 		cluster3_l2: l2-cache3 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/hisilicon/hip07.dtsi b/arch/arm64/boot/dts/hisilicon/hip07.dtsi
index 8a9436ca2531..595abe339c5d 100644
--- a/arch/arm64/boot/dts/hisilicon/hip07.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip07.dtsi
@@ -843,81 +843,97 @@ cpu63: cpu@70303 {
 		cluster0_l2: l2-cache0 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 
 		cluster1_l2: l2-cache1 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 
 		cluster2_l2: l2-cache2 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 
 		cluster3_l2: l2-cache3 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 
 		cluster4_l2: l2-cache4 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 
 		cluster5_l2: l2-cache5 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 
 		cluster6_l2: l2-cache6 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 
 		cluster7_l2: l2-cache7 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 
 		cluster8_l2: l2-cache8 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 
 		cluster9_l2: l2-cache9 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 
 		cluster10_l2: l2-cache10 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 
 		cluster11_l2: l2-cache11 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 
 		cluster12_l2: l2-cache12 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 
 		cluster13_l2: l2-cache13 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 
 		cluster14_l2: l2-cache14 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 
 		cluster15_l2: l2-cache15 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5146EB4E9
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 00:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233523AbjDUWd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 18:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233943AbjDUWcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 18:32:45 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FFC3A9A
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 15:32:17 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-506b20efd4cso3685082a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 15:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682116330; x=1684708330;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iL+wRgzfrN+6O9biXfGczBTfab+gqJL537YfXAsfmMg=;
        b=H/ldu9X/G+U/2S0H7gVLuJqeTayKbR8ZNKdYDH9zD05B6yO585zGepd35VFhKSYcod
         yTTLAeAMLec9m480sRB6oYxHiDybdkcpl0gKEbbF2uBUI6qOHSvDxMLuogcZD7GMowL1
         pV+wKe5HsgzCOvqiRBMi8cX+tG27WR4lzecfGMH0LMy5iXonbsynhBj+ERXTuDCSeT6u
         VV57FGZ45uSppLx5Lll3ChVIxNfkzV9yQJjCTca+zA4CK9OQ+Y5GmLNYCtCDH8VQ1CEj
         nVSNpvUVifV35+xf8qGRemRTVMvfugHHJuq6o9N09DVpx57KQuRM2O9olSC4+j0pxcbo
         TLmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682116330; x=1684708330;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iL+wRgzfrN+6O9biXfGczBTfab+gqJL537YfXAsfmMg=;
        b=e15x8BQRqkI/yDu3EC2stJYUtBXoOUHzu8Cyj+NwD+afANRf0XXHfL47LWox2L7/gz
         cxDWaoQjgjQOTeTfDyh7H7pWgOpOsYxXPrEszv1hccxwQMXt5+fmOcdxl/bUMBz5DkS4
         GthsFiz/eUH5r8tPrny3QhVBGFgCWHQ7YDju6zCMOE7d1LMrojPY/A1vby0RMPtg/CBo
         afdN9cdEBV5Xkb8bLElOLdyMrB0LaJUrSJY/ZlQlhkP5H6eX3KUVE2E+k/nKnuzYg3PT
         sVrkPjk0Vu3Bcu4SjX4RQzLenY3uCJN1txR+WGdtTFzsWRV1gT9CUA5efTu2+tAIMp/Z
         udsg==
X-Gm-Message-State: AAQBX9cduNn/BLCMPPR+oZK+vBcwVJvxli54TP4JhjlRFJDZ1bKrwJ2Q
        SeYf25GmblOtFyP8tNPRGtRAfQ==
X-Google-Smtp-Source: AKy350Z+xAPWZacK2xPOHFBG+M4fP1nokdklOiOXAoTu6PwWqLRMzS2nEzAE7va1QBONEoOoahCSpg==
X-Received: by 2002:aa7:db42:0:b0:506:b228:7aff with SMTP id n2-20020aa7db42000000b00506b2287affmr6045788edt.23.1682116330331;
        Fri, 21 Apr 2023 15:32:10 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:687d:8c5:41cb:9883])
        by smtp.gmail.com with ESMTPSA id j19-20020aa7c0d3000000b005065141d1f4sm2234044edp.20.2023.04.21.15.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 15:32:09 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        William Zhang <william.zhang@broadcom.com>,
        Anand Gore <anand.gore@broadcom.com>,
        Kursad Oney <kursad.oney@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: broadcom: add missing cache properties
Date:   Sat, 22 Apr 2023 00:32:08 +0200
Message-Id: <20230421223208.115555-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

As all level 2 and level 3 caches are unified, add required
cache-unified properties to fix warnings like:

  bcm94908.dtb: l2-cache0: 'cache-unified' is a required property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Please take the patch via sub-arch SoC tree.
---
 arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi    | 1 +
 arch/arm64/boot/dts/broadcom/bcmbca/bcm4912.dtsi    | 1 +
 arch/arm64/boot/dts/broadcom/bcmbca/bcm63146.dtsi   | 1 +
 arch/arm64/boot/dts/broadcom/bcmbca/bcm63158.dtsi   | 1 +
 arch/arm64/boot/dts/broadcom/bcmbca/bcm6813.dtsi    | 1 +
 arch/arm64/boot/dts/broadcom/bcmbca/bcm6856.dtsi    | 1 +
 arch/arm64/boot/dts/broadcom/bcmbca/bcm6858.dtsi    | 1 +
 arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi    | 1 +
 arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi | 4 ++++
 9 files changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi
index 457805efb385..f549bda8c48c 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi
@@ -64,6 +64,7 @@ cpu3: cpu@3 {
 		l2: l2-cache0 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4912.dtsi b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4912.dtsi
index 46aa8c0b7971..d658c81f7285 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4912.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4912.dtsi
@@ -52,6 +52,7 @@ B53_3: cpu@3 {
 		L2_0: l2-cache0 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm63146.dtsi b/arch/arm64/boot/dts/broadcom/bcmbca/bcm63146.dtsi
index 7020f2e995e2..4f474d47022e 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm63146.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm63146.dtsi
@@ -36,6 +36,7 @@ B53_1: cpu@1 {
 		L2_0: l2-cache0 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm63158.dtsi b/arch/arm64/boot/dts/broadcom/bcmbca/bcm63158.dtsi
index 6a0242cbea57..909f254dc47d 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm63158.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm63158.dtsi
@@ -52,6 +52,7 @@ B53_3: cpu@3 {
 		L2_0: l2-cache0 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm6813.dtsi b/arch/arm64/boot/dts/broadcom/bcmbca/bcm6813.dtsi
index 1a12905266ef..685ae32951c9 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm6813.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm6813.dtsi
@@ -52,6 +52,7 @@ B53_3: cpu@3 {
 		L2_0: l2-cache0 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm6856.dtsi b/arch/arm64/boot/dts/broadcom/bcmbca/bcm6856.dtsi
index f41ebc30666f..820553ce541b 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm6856.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm6856.dtsi
@@ -36,6 +36,7 @@ B53_1: cpu@1 {
 		L2_0: l2-cache0 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm6858.dtsi b/arch/arm64/boot/dts/broadcom/bcmbca/bcm6858.dtsi
index fa2688f41f06..0eb93c298297 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm6858.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm6858.dtsi
@@ -51,6 +51,7 @@ B53_3: cpu@3 {
 		L2_0: l2-cache0 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi b/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
index e1b80e569cdf..9dcd25ec2c04 100644
--- a/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
@@ -80,6 +80,7 @@ A57_3: cpu@3 {
 		CLUSTER0_L2: l2-cache@0 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
index 388424b3e1d3..7aece79bf882 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
@@ -109,21 +109,25 @@ cpu@301 {
 		CLUSTER0_L2: l2-cache@0 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 
 		CLUSTER1_L2: l2-cache@100 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 
 		CLUSTER2_L2: l2-cache@200 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 
 		CLUSTER3_L2: l2-cache@300 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
-- 
2.34.1


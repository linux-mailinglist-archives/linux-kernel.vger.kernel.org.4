Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F74074871C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 16:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbjGEO7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 10:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbjGEO7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 10:59:41 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0393B1998
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 07:59:30 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51d80d81d6eso8207440a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 07:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688569169; x=1691161169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RAZvI3OMDqsKJV2X1gUf5clnFycSJYrrukv5F7tiAds=;
        b=Qld28BWUYGUNXhnclL5xm/Gdrt21mBjLDbNE/mDnUU0IUdkCHKSQqTHzbCrESCDC4I
         xHRgGVxd8Anfe4FqO1/iAyz1+oKCvQZKHFVNM2q/glzOcRHv2ZupUhOPIjSBmRdRmat8
         VIPrfasF1rw+xXz0MsuIM6mXoHVjx8QNgC5jpanagLJpJ9wuBl+4EcgG7gbzN1NjGIJI
         RTstH31U4euTjDO/pfKzXw9Kezf9aWgB8IxxkbnHnQpdeliujdRJKLPvWxs6V5wedex/
         2E0ex1m2yx5WZ65U9EAkd0VIMolImtwsc9Y5QleCWGDRO1RXsCiywadHkcDcNgCsz7Qp
         4B5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688569169; x=1691161169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RAZvI3OMDqsKJV2X1gUf5clnFycSJYrrukv5F7tiAds=;
        b=PKtBb0hA29kRoclrkCL677QQYIEMY5u06VMKv0bWCv7ZcK+fn5Qyf2VL3eHJmgL6ps
         cim7MLhZ/5chI+320grp0fIhuJArbMuGQq8QRAQQqwj4rExxmF354uRnBP9Xw6/DC8Z8
         vWTMnITZdTiw+0Ey1iiHCHmQkmJIG6HP3qrEBNDdKn8dF57oHjV9pXsbRAesNST95mok
         dOtygp96GpcZDnXa/htJAfHQXO/Q3HLru++pp6RTeiECK6cMi6lsnxmP4oXdmjmp9+iQ
         s/02iiwxLwzU3KufcLbuuqvxuRrZXWlsgamGiDo1HX92csezjcaKxXbKlsynH3+tmkXH
         quzA==
X-Gm-Message-State: ABy/qLZlXm1e1n3Oco28xOp6tmeNtcorzjx0hJODbjA5pQdp4/sLEVjZ
        kf1SNnmu0Vg7ldYR/kT7ZJaMhQ==
X-Google-Smtp-Source: ACHHUZ5/h0zlxSxslthMi5UIAMV0sL8nzzKHUMKhofK96Kcu4rpdiEgCV1nDiyU9CjmuxHezgSPyaQ==
X-Received: by 2002:a17:906:d14a:b0:98e:35d1:9946 with SMTP id br10-20020a170906d14a00b0098e35d19946mr13761831ejb.64.1688569169429;
        Wed, 05 Jul 2023 07:59:29 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id p7-20020a170906838700b0099364d9f0e9sm4614613ejx.102.2023.07.05.07.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 07:59:28 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: hisilicon: add missing space before {
Date:   Wed,  5 Jul 2023 16:59:25 +0200
Message-Id: <20230705145925.293447-1-krzysztof.kozlowski@linaro.org>
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

Add missing whitespace between node name/label and opening {.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 2 +-
 arch/arm64/boot/dts/hisilicon/hip06.dtsi  | 8 ++++----
 arch/arm64/boot/dts/hisilicon/hip07.dtsi  | 8 ++++----
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index f29a3e471288..be808bb2544e 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -861,7 +861,7 @@ tsensor: tsensor@0,f7030700 {
 			#thermal-sensor-cells = <1>;
 		};
 
-		i2s0: i2s@f7118000{
+		i2s0: i2s@f7118000 {
 			compatible = "hisilicon,hi6210-i2s";
 			reg = <0x0 0xf7118000 0x0 0x8000>; /* i2s unit */
 			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>; /* 155 "DigACodec_intr"-32 */
diff --git a/arch/arm64/boot/dts/hisilicon/hip06.dtsi b/arch/arm64/boot/dts/hisilicon/hip06.dtsi
index c588848bfdeb..f46c33d10750 100644
--- a/arch/arm64/boot/dts/hisilicon/hip06.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip06.dtsi
@@ -570,7 +570,7 @@ port@5 {
 			};
 		};
 
-		eth0: ethernet-4{
+		eth0: ethernet-4 {
 			compatible = "hisilicon,hns-nic-v2";
 			ae-handle = <&dsaf0>;
 			port-idx-in-ae = <4>;
@@ -579,7 +579,7 @@ eth0: ethernet-4{
 			dma-coherent;
 		};
 
-		eth1: ethernet-5{
+		eth1: ethernet-5 {
 			compatible = "hisilicon,hns-nic-v2";
 			ae-handle = <&dsaf0>;
 			port-idx-in-ae = <5>;
@@ -588,7 +588,7 @@ eth1: ethernet-5{
 			dma-coherent;
 		};
 
-		eth2: ethernet-0{
+		eth2: ethernet-0 {
 			compatible = "hisilicon,hns-nic-v2";
 			ae-handle = <&dsaf0>;
 			port-idx-in-ae = <0>;
@@ -597,7 +597,7 @@ eth2: ethernet-0{
 			dma-coherent;
 		};
 
-		eth3: ethernet-1{
+		eth3: ethernet-1 {
 			compatible = "hisilicon,hns-nic-v2";
 			ae-handle = <&dsaf0>;
 			port-idx-in-ae = <1>;
diff --git a/arch/arm64/boot/dts/hisilicon/hip07.dtsi b/arch/arm64/boot/dts/hisilicon/hip07.dtsi
index 595abe339c5d..81d907ef43ed 100644
--- a/arch/arm64/boot/dts/hisilicon/hip07.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip07.dtsi
@@ -1483,7 +1483,7 @@ port@5 {
 			};
 		};
 
-		eth0: ethernet@4{
+		eth0: ethernet@4 {
 			compatible = "hisilicon,hns-nic-v2";
 			ae-handle = <&dsaf0>;
 			port-idx-in-ae = <4>;
@@ -1492,7 +1492,7 @@ eth0: ethernet@4{
 			dma-coherent;
 		};
 
-		eth1: ethernet@5{
+		eth1: ethernet@5 {
 			compatible = "hisilicon,hns-nic-v2";
 			ae-handle = <&dsaf0>;
 			port-idx-in-ae = <5>;
@@ -1501,7 +1501,7 @@ eth1: ethernet@5{
 			dma-coherent;
 		};
 
-		eth2: ethernet@0{
+		eth2: ethernet@0 {
 			compatible = "hisilicon,hns-nic-v2";
 			ae-handle = <&dsaf0>;
 			port-idx-in-ae = <0>;
@@ -1510,7 +1510,7 @@ eth2: ethernet@0{
 			dma-coherent;
 		};
 
-		eth3: ethernet@1{
+		eth3: ethernet@1 {
 			compatible = "hisilicon,hns-nic-v2";
 			ae-handle = <&dsaf0>;
 			port-idx-in-ae = <1>;
-- 
2.34.1


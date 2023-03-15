Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229E46BB842
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 16:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbjCOPnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 11:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbjCOPnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 11:43:46 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D75664D3;
        Wed, 15 Mar 2023 08:43:22 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 0BA7B40AC9;
        Wed, 15 Mar 2023 20:43:19 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1678894999; bh=bHma5jkgRzcDX6jZxn7KcOr5IxK0IUPT6jvQbfkxZKs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yBn4xK9IC4H97jwGWZrl2EaeztgwsGf0MzvdXtcK77AvXSHCxZ+7edYzGL7gdkG68
         LucwaFoZDh5qKq/KbT5LmwmaHbkWQP8n7WOTIEYgqrKygvMVE0Zjcv+F4tNB/wi/z3
         jx0LfDRJanrD99fbpatmQS0uVMbQHChRZv4pybmxbYYv/2jCF2ND5VgsMpQmqGqdrQ
         QVUyDJgbwKYjFnfPW2t1447OaImnx9o0WOWitpGe49302ZKqW0lImHhUIMbhE5XZyd
         u/01DYJzU5tRO1+8IWDKN1RrfbpuscZ2mTCaAp3Pz3vZyQ6lacMupRQeUtZbpYeOnf
         X7XyixaAWGCnw==
From:   Nikita Travkin <nikita@trvn.ru>
To:     agross@kernel.org, andersson@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH v3 1/4] arm64: dts: qcom: sc7180: Don't enable lpass clocks by default
Date:   Wed, 15 Mar 2023 20:43:08 +0500
Message-Id: <20230315154311.37299-2-nikita@trvn.ru>
In-Reply-To: <20230315154311.37299-1-nikita@trvn.ru>
References: <20230315154311.37299-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lpass clocks are usually blocked from HLOS by the firmware and
instead are managed by the ADSP. Mark them as reserved and explicitly
enable in the CrOS boards that have special, cooperative firmware.

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 8 ++++++++
 arch/arm64/boot/dts/qcom/sc7180.dtsi         | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index 423630c4d02c..26def6e12723 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -785,6 +785,14 @@ alc5682: codec@1a {
 	};
 };
 
+&lpasscc {
+	status = "okay";
+};
+
+&lpass_hm {
+	status = "okay";
+};
+
 &lpass_cpu {
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 53f0076f20f6..f0de177981f9 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -3623,6 +3623,8 @@ lpasscc: clock-controller@62d00000 {
 			power-domains = <&lpass_hm LPASS_CORE_HM_GDSCR>;
 			#clock-cells = <1>;
 			#power-domain-cells = <1>;
+
+			status = "reserved"; /* Controlled by ADSP */
 		};
 
 		lpass_cpu: lpass@62d87000 {
@@ -3671,6 +3673,8 @@ lpass_hm: clock-controller@63000000 {
 
 			#clock-cells = <1>;
 			#power-domain-cells = <1>;
+
+			status = "reserved"; /* Controlled by ADSP */
 		};
 	};
 
-- 
2.39.2


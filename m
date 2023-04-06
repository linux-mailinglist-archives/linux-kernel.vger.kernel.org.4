Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A356D9BC6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 17:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239628AbjDFPHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 11:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239601AbjDFPHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 11:07:20 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D89AD37;
        Thu,  6 Apr 2023 08:06:58 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 97DC241848;
        Thu,  6 Apr 2023 20:06:54 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1680793615; bh=N6oObUDYJcJKRmHqEIXrt+Eeic0D8f7CSqwLjgqLK6o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VrFxFnsOH4oBDgxKjU2ZXbba4nRtm85aNwrA2CzHFX8qVVxvjdZuRZv7miiLZ0BHq
         YvcvkXqwi+L7QHIwsbXOepyo3kRWJXo8twZ1oIW8J0dlxC9fRmOaSMh5AZbE/GsT4v
         CSGOyIBoWZ2HqypfSShzEKEs11jwjANySLUxX2KXr3WcUdeq/1iuiwo8OnDjBsQmPf
         Rl2s6WP+NgDl9CZSA1AgM5EawKibqbMejeK2SR7EVYUzYmTHzLs2U4vyc8q4oD9MVT
         brSAoZiDxp50NL0CnBTw2I3fJOuEvBhYn7mgM99bd8di5vYap6CUaIAthfymg4wK+J
         fQso5oRdohirg==
From:   Nikita Travkin <nikita@trvn.ru>
To:     agross@kernel.org, andersson@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        konrad.dybcio@linaro.org, quic_srivasam@quicinc.com,
        judyhsiao@chromium.org, mka@chromium.org, dianders@chromium.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH v4 1/4] arm64: dts: qcom: sc7180: Don't enable lpass clocks by default
Date:   Thu,  6 Apr 2023 20:06:30 +0500
Message-Id: <20230406150633.83351-2-nikita@trvn.ru>
In-Reply-To: <20230406150633.83351-1-nikita@trvn.ru>
References: <20230406150633.83351-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index 3c799b564b64..6f40301faa1c 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -3621,6 +3621,8 @@ lpasscc: clock-controller@62d00000 {
 			power-domains = <&lpass_hm LPASS_CORE_HM_GDSCR>;
 			#clock-cells = <1>;
 			#power-domain-cells = <1>;
+
+			status = "reserved"; /* Controlled by ADSP */
 		};
 
 		lpass_cpu: lpass@62d87000 {
@@ -3669,6 +3671,8 @@ lpass_hm: clock-controller@63000000 {
 
 			#clock-cells = <1>;
 			#power-domain-cells = <1>;
+
+			status = "reserved"; /* Controlled by ADSP */
 		};
 	};
 
-- 
2.39.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F030C6DB98C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 10:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjDHIOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 04:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjDHIOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 04:14:20 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E373549F4;
        Sat,  8 Apr 2023 01:14:18 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 6840441850;
        Sat,  8 Apr 2023 13:14:15 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1680941655; bh=C6lgJgkZpQ+Vok1PSRW8xpEjtlkFr/cDQ9phQ33f1NU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BqYXlA8Xgai76pJbJ8wsHr7RpEoSprbMxZQZj/p7WUgxaF3aWmn2G3AkNedabCxDD
         s0FEEZIci8QgjRcnVHYo9rOigvOGP5R8o6+P/PV8rmhBJzAoHIwIWKDIRUcpApPQy/
         WAzhpN0rCnKWcc86k+5w//+vNbCvRqvstGa19liBa771ikFAedIVkobxjtN1k9WI0i
         DKICYvolSG01fWunTaLMflIJeCQPz4A79+qaOft6xfr21tFPNhm/pM6uWrT73rLCba
         NHYkGQZT6k4ZVBtXKWefwpl1sp2Q5BdPddlnGiUfdMSV0Vm2+UwzYkahpGvbj6N5Xj
         V0Yrn4PAvV/XQ==
From:   Nikita Travkin <nikita@trvn.ru>
To:     agross@kernel.org, andersson@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        konrad.dybcio@linaro.org, quic_srivasam@quicinc.com,
        judyhsiao@chromium.org, mka@chromium.org, dianders@chromium.org,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH v6 1/4] arm64: dts: qcom: sc7180: Don't enable lpass clocks by default
Date:   Sat,  8 Apr 2023 13:13:13 +0500
Message-Id: <20230408081316.234293-2-nikita@trvn.ru>
In-Reply-To: <20230408081316.234293-1-nikita@trvn.ru>
References: <20230408081316.234293-1-nikita@trvn.ru>
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

The IDP board gets lpass clocks disabled as it doesn't make use of sound
anyway and might use Qualcomm firmware that blocks those clocks. [1]

[1] https://lore.kernel.org/all/ZBJhmDd3zK%2FAiwBD@google.com/

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
v5: minor style changes (Konrad)
v6: Extend the commit message (Doug)
---
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 8 ++++++++
 arch/arm64/boot/dts/qcom/sc7180.dtsi         | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index 423630c4d02c..7e57899ef2c6 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -785,6 +785,10 @@ alc5682: codec@1a {
 	};
 };
 
+&lpasscc {
+	status = "okay";
+};
+
 &lpass_cpu {
 	status = "okay";
 
@@ -810,6 +814,10 @@ dai-link@5 {
 	};
 };
 
+&lpass_hm {
+	status = "okay";
+};
+
 &mdp {
 	status = "okay";
 };
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


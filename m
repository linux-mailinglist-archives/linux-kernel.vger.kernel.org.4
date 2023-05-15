Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE43702A11
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 12:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241083AbjEOKIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 06:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240667AbjEOKIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 06:08:09 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56ACD199;
        Mon, 15 May 2023 03:07:50 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 5E2364185F;
        Mon, 15 May 2023 14:37:51 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1684143471; bh=oNqE/0HvBFxcIEMYbtudwPxtjKI2KGW2T9KslsLh1fM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PpPJYtmKVF6Pcs3/gVFzny3SDv7d+1qIlOUfbM+Ozqa3fE4KAgnx3P4VtrFGBpBab
         LZyGE1VU4y9pj3+wwlMNf38zl53mALl8H4URw7zF+bqfCkXakOM1QXMFbrmThOjO2z
         GNVnIi+F/NRYSsPBugM/9xvrFsImWFqK6gkvo/vuByLflFvJFrdKCSrDyaNx2oyXBq
         PsAQQ0rxVnLhUCUTZGTTtKUzd0B6fpMR91TKqYW/ntbNOEeudSth7OoQ+UHdDsLBrh
         gd3lXJVAff0wkqlA5lgPlb0uFfywh+E/WuPOmVD5iOiZNflfpmIQ04KDFI6N6N5yM5
         dTY5XYVkOke1w==
From:   Nikita Travkin <nikita@trvn.ru>
To:     agross@kernel.org, andersson@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, konrad.dybcio@linaro.org,
        quic_srivasam@quicinc.com, judyhsiao@chromium.org,
        mka@chromium.org, dianders@chromium.org,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH v6 RESEND 1/4] arm64: dts: qcom: sc7180: Don't enable lpass clocks by default
Date:   Mon, 15 May 2023 14:37:41 +0500
Message-Id: <20230515093744.289045-2-nikita@trvn.ru>
In-Reply-To: <20230515093744.289045-1-nikita@trvn.ru>
References: <20230515093744.289045-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index ca6920de7ea8..6cf09152fdfd 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -788,6 +788,10 @@ alc5682: codec@1a {
 	};
 };
 
+&lpasscc {
+	status = "okay";
+};
+
 &lpass_cpu {
 	status = "okay";
 
@@ -813,6 +817,10 @@ dai-link@5 {
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
index ea1ffade1aa1..39130596dc7d 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -3627,6 +3627,8 @@ lpasscc: clock-controller@62d00000 {
 			power-domains = <&lpass_hm LPASS_CORE_HM_GDSCR>;
 			#clock-cells = <1>;
 			#power-domain-cells = <1>;
+
+			status = "reserved"; /* Controlled by ADSP */
 		};
 
 		lpass_cpu: lpass@62d87000 {
@@ -3675,6 +3677,8 @@ lpass_hm: clock-controller@63000000 {
 
 			#clock-cells = <1>;
 			#power-domain-cells = <1>;
+
+			status = "reserved"; /* Controlled by ADSP */
 		};
 	};
 
-- 
2.40.0


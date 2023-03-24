Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF49D6C7BE2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 10:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjCXJst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 05:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCXJsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 05:48:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E1D35A7;
        Fri, 24 Mar 2023 02:48:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84808B81DEB;
        Fri, 24 Mar 2023 09:48:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D1E5C433D2;
        Fri, 24 Mar 2023 09:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679651324;
        bh=mkHVp7d64S5bJINGS2EiLvsmAoZ0Dtzmx168JV4/2V8=;
        h=From:To:Cc:Subject:Date:From;
        b=WvMRplOfo5on0g6CSuAiAee4vS68axpPZ+p8m2TOvgY8uZal+vU1S8FKpl6X3RBOP
         mtgbD5tk+4KnO7kdTVvHRGi3LQrSWnrTr9fqzrVxV/fkQVu1lOWDKS7VRTLfpDzywx
         2B3lNVH7TNfZJ8F8pZfM7TVeRdeOCHjxolTPzB7njh5YASw8u7H6+SJ30NEAS4THl1
         txqHxeAuizJ+1dMoWMaTjZM0a42fAhd4o3zBHkl5A23eeWTpL+uQhOzL7ZHHkuiDoF
         WYJGYyfYzE76nnEO0TJSiiqOzNYb33EW9jl+lIbr7wSBfF8+eQYUBjm3T1lQ7nKza7
         vqt8EbdKHBKQw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pfe2N-0005KV-Ev; Fri, 24 Mar 2023 10:48:43 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] arm64: dts: qcom: sc8280xp-x13s: enable alternate touchpad
Date:   Fri, 24 Mar 2023 10:47:44 +0100
Message-Id: <20230324094744.20448-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable both touchpad nodes in the devictree and let the HID driver
determine which one is actually populated (by attempting to read from
each i2c address).

Ideally this would not be needed and the boot firmware should instead
enable only the node for the populated touchpad, but this is unlikely to
ever be realised for the X13s.

Note that the pin configuration must currently be moved to the parent
i2c-bus node even though only one of these nodes will ever be
successfully probed on a specific device (e.g. to allow them to be
probed in parallel).

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index 6addc91d7c74..d7de7cb22d75 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -641,7 +641,7 @@ &i2c21 {
 	clock-frequency = <400000>;
 
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c21_default>;
+	pinctrl-0 = <&i2c21_default>, <&tpad_default>;
 
 	status = "okay";
 
@@ -654,12 +654,7 @@ touchpad@15 {
 		vdd-supply = <&vreg_misc_3p3>;
 		vddl-supply = <&vreg_s10b>;
 
-		pinctrl-names = "default";
-		pinctrl-0 = <&tpad_default>;
-
 		wakeup-source;
-
-		status = "disabled";
 	};
 
 	touchpad@2c {
@@ -671,9 +666,6 @@ touchpad@2c {
 		vdd-supply = <&vreg_misc_3p3>;
 		vddl-supply = <&vreg_s10b>;
 
-		pinctrl-names = "default";
-		pinctrl-0 = <&tpad_default>;
-
 		wakeup-source;
 	};
 
-- 
2.39.2


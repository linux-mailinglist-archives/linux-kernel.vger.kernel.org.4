Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2A4698123
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 17:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjBOQpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 11:45:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjBOQpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 11:45:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0195B1F488;
        Wed, 15 Feb 2023 08:45:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92DD161CDE;
        Wed, 15 Feb 2023 16:45:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB88FC4339B;
        Wed, 15 Feb 2023 16:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676479552;
        bh=4hSk3iQocpfOE/qEG5dsksQoLFfjipAko9fOMasZXic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=udKiLjkWTK002xyuosj56bqlyJCbbe+/cYbLVe/mbuEfoz1EHQtWVJwsgKrJcdtEg
         WEqHtZEaA/vRCNXsGemp0QeSL+gpPBSY1vUpxSWEEgJ5O4tjTYRzm+DY+cyeTZD8hI
         vdxQhpEW1KV0T7Ik0LuOQhLYZ8IslzXhVOnbIz8cKiRKh6YjtBzzymC69yPWfRgG0m
         l0FuR9cbm6RrQgvMQgVTUjmsbMFiYap+QVuSWIPt6Boaa6Vn3dSslkQgVBn4xwzPAg
         f1iUK/sG21guXbgzE+xE/EDDAo32/MUWbJ6iMITXiAjPxVl3xW/lqvvmaL8hxaFWrG
         3pPTGJRZtN/0g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pSKvg-0000Mx-UO; Wed, 15 Feb 2023 17:46:48 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 2/2] arm64: dts: sc8280xp-x13s: fix external display 'data-lanes'
Date:   Wed, 15 Feb 2023 17:45:24 +0100
Message-Id: <20230215164524.1335-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230215164524.1335-1-johan+linaro@kernel.org>
References: <20230215164524.1335-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'data-lanes' property belongs in the controller node but was
erroneously moved to the endpoint nodes in the last revision of the
external display series:

	[drm] Invalid property "data-lanes", default max DP lanes = 4

Fixes: 8fcff430faee ("arm64: dts: qcom: sc8280xp-x13s: Enable external display")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index 918be6728baa..d52d49a82ada 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -491,20 +491,22 @@ &mdss0 {
 };
 
 &mdss0_dp0 {
+	data-lanes = <0 1>;
+
 	status = "okay";
 };
 
 &mdss0_dp0_out {
-	data-lanes = <0 1>;
 	remote-endpoint = <&pmic_glink_con0_ss>;
 };
 
 &mdss0_dp1 {
+	data-lanes = <0 1>;
+
 	status = "okay";
 };
 
 &mdss0_dp1_out {
-	data-lanes = <0 1>;
 	remote-endpoint = <&pmic_glink_con1_ss>;
 };
 
-- 
2.39.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94FD7698126
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 17:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjBOQp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 11:45:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjBOQpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 11:45:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4D01F488;
        Wed, 15 Feb 2023 08:45:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3DDB6B8225F;
        Wed, 15 Feb 2023 16:45:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B69C433D2;
        Wed, 15 Feb 2023 16:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676479552;
        bh=gXCoCYIWuQ6zQPZdkRw/SFmCLHKeUNes3OHwjCNAvMk=;
        h=From:To:Cc:Subject:Date:From;
        b=psgd15gCQzR+zIFPKZDbUDVORdJVqWAiGjsprnfd2q0y+Es3zKUuLREBAIDP7DK/m
         oRuLXnYCxG4OCl9xEagjyaAvX45wWBke2h0+294ILt6c29k2FIvRTecbVMNhaD8N96
         qX4fWiiRVAh7dVM2DcuQB0WHhM9zPb95PWTvgmCxhDFBfnvPxwHI8YeDthPp8JgJP5
         QrcfrxBntN9fT5kgokVm3/0n7c8ZgDJb89Op5DjNLaz9De1vvdEjmxmpJVGzIYAWgR
         ZNd2FMae3bS0E/rfrdyGxUlHO5EYTOoIIqVJ6Rrj9tAMzfCIKXe4FWfXC0wTsuTphV
         bnU6Ki3TnIMHg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pSKvg-0000Mv-4n; Wed, 15 Feb 2023 17:46:48 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 1/2] arm64: dts: sc8280xp-crd: fix external display 'data-lanes'
Date:   Wed, 15 Feb 2023 17:45:23 +0100
Message-Id: <20230215164524.1335-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.2
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

Fixes: bc9a747ae91f ("arm64: dts: qcom: sc8280xp-crd: Introduce pmic_glink")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
index 0c3bdd3cdb9e..db6eb19d0da7 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
@@ -379,20 +379,22 @@ &mdss0 {
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


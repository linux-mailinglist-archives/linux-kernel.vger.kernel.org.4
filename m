Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F665B9D5C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 16:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbiIOOg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 10:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiIOOfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 10:35:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EBB67CA3;
        Thu, 15 Sep 2022 07:34:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C9FB6247E;
        Thu, 15 Sep 2022 14:34:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B76E5C433D7;
        Thu, 15 Sep 2022 14:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663252498;
        bh=d073PaUnYzoOzHdAykMoHn66BIAIqRnlEi7221UuM3c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YNwCph1cC7IGp+PmXLFn5uK3KjNG3hP4D+W6plak+XNHIw14sXwTFzlSuqtaFUqki
         N2MdaLv+mPyelyc3l8uU5LtRdJTWfXqPOY8BUypwAndkfUbDXHWMW0ms8bl9fbKl0J
         zf37IGC5AtY/UdsFkhEDpBgv/6nEOv7GQOK5cJoro5ciNWrP58lYASsprDukA+LSfp
         xriOmQnbWqrd1Q7AnsmcZtFAzK7QZVcXRq66kUFnnmvVFQC1EXBItVTVXrr+iM+BfP
         E1FoftpZnsp0VqP7Nr7Ifzoe65pEpnTAyVfMx1uoUO1I9XEacX4SSTVpVWwPwiNKHj
         /lw6ayApcTFeQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oYpxG-0005AY-G3; Thu, 15 Sep 2022 16:35:02 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 2/2] arm64: dts: qcom: sm8540: fix UFS PHY serdes size
Date:   Thu, 15 Sep 2022 16:34:31 +0200
Message-Id: <20220915143431.19842-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220915143431.19842-1-johan+linaro@kernel.org>
References: <20220915143431.19842-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The size of the UFS PHY serdes register region is 0x1c4 and the
corresponding 'reg' property should specifically not include the
adjacent regions that are defined in the child node (e.g. tx and rx).

Fixes: 07fa917a335e ("arm64: dts: qcom: sm8450: add ufs nodes")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index d0ebf61a0074..8dde41ed6491 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -3147,7 +3147,7 @@ ufs_mem_hc: ufshc@1d84000 {
 
 		ufs_mem_phy: phy@1d87000 {
 			compatible = "qcom,sm8450-qmp-ufs-phy";
-			reg = <0 0x01d87000 0 0xe10>;
+			reg = <0 0x01d87000 0 0x1c4>;
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges;
-- 
2.35.1


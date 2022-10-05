Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47305F567B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 16:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiJEOd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 10:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiJEOdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 10:33:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4119F726BC;
        Wed,  5 Oct 2022 07:33:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E864AB81E36;
        Wed,  5 Oct 2022 14:33:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EEB5C433C1;
        Wed,  5 Oct 2022 14:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664980400;
        bh=Ms4we0de2im5hYlIBZEqPqwRtSfzNv60b2QJJkEK3bI=;
        h=From:To:Cc:Subject:Date:From;
        b=r6sP0+P8LJu5mZ/GoIsUEdtzcy0aSByrRQWc5Y+c6HV/6cQD89mKUYOsFqwCJDCVD
         Dq560kDcU+3KWjMkbff+PEoHTPblwbp4FIoGdqNdYg6X4Q9dv7Bm478DHyOrEyf03V
         jF56igfPX9zudJCp+BbEaRiYaMkUorUwRqGmFBrZRhTMEwUGARj77gxR5ohiWWR5KL
         dhhKKeWi/O9mEazwEKCxqPTH8smN7h7rnEuTf/p8nbPoVytRS2RDESPnquCVgwaDTD
         7ES5edI/yXd5vqbTQSaUFRcG0vLY69Uo4O93Huxl3ULIxEXcbtEmfl8Yj74uqY78/E
         lqt9fWOGguO8Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1og5Sa-00006y-SF; Wed, 05 Oct 2022 16:33:20 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Brian Masney <bmasney@redhat.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] arm64: dts: qcom: sc8280xp: fix ufs_card_phy ref clock
Date:   Wed,  5 Oct 2022 16:33:05 +0200
Message-Id: <20221005143305.388-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
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

The GCC_UFS_REF_CLKREF_CLK must be enabled or the second UFS controller
fails to enumerate on sa8295p-adp.

Note that the vendor kernel enables both GCC_UFS_REF_CLKREF_CLK and
GCC_UFS_1_CARD_CLKREF_CLK and it is possible that the former should be
modelled as a parent of the latter. The clock driver also has a
GCC_UFS_CARD_CLKREF_CLK clock which the firmware appears to enable on
the ADP.

The usual lack of documentation for Qualcomm SoCs makes this a highly
annoying guessing game, but as the second controller works on the ADP
without either card reference clock enabled, only enable
GCC_UFS_REF_CLKREF_CLK for now.

Fixes: 152d1faf1e2f ("arm64: dts: qcom: add SC8280XP platform")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---

The related issue for the first controller is being fixed here:

	https://lore.kernel.org/lkml/20220830180120.2082734-1-bmasney@redhat.com/T/#u

Johan


 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index cf7ef37c11ec..917f1feac6ac 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -960,7 +960,7 @@ ufs_card_phy: phy@1da7000 {
 			ranges;
 			clock-names = "ref",
 				      "ref_aux";
-			clocks = <&gcc GCC_UFS_1_CARD_CLKREF_CLK>,
+			clocks = <&gcc GCC_UFS_REF_CLKREF_CLK>,
 				 <&gcc GCC_UFS_CARD_PHY_AUX_CLK>;
 
 			resets = <&ufs_card_hc 0>;
-- 
2.35.1


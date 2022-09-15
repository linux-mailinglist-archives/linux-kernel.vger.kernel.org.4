Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4555B9CB8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 16:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiIOOQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 10:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiIOOQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 10:16:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA865A2C3;
        Thu, 15 Sep 2022 07:16:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AB4A4B81F25;
        Thu, 15 Sep 2022 14:16:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 648C1C433C1;
        Thu, 15 Sep 2022 14:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663251369;
        bh=LNf9aGj3Ub8wBgCFrcr80QXNiDmenIH+fVO6E1pM0qs=;
        h=From:To:Cc:Subject:Date:From;
        b=VQ3Qd44YQCOXOIwi4mp1Aec5XBf8rOGDOKVoLNHMjdTrdO2BXVmT5qdh9bKWibtUo
         BzwmJUKfX8m/Fokw5FAfgAqa1Gc+ElO82PgsqbiK1fGcMPI1h3IxzrULlvspGB4XKH
         qbbz5soB4PpRqBvIiRRDN3J5OfzS6DMJ0tBxJw8cboUrkJewehlU4v4B5n9F0G43zc
         K6otM75fSR9Bk4Ftc8H9UjpjUP7Tqon6rHIl0U0WEKdiExzwday45S12buIrca4u+W
         n49SBnQaTQZB+TPrM5lrjDKIs/fJRjvonz6cPI9i+t8PxKZtnMfQo2Ajft9MCu/HyW
         SqmIskrSV5QeQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oYpf2-0004nc-Kv; Thu, 15 Sep 2022 16:16:12 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] arm64: dts: qcom: sc8280xp: fix UFS PHY serdes size
Date:   Thu, 15 Sep 2022 16:16:01 +0200
Message-Id: <20220915141601.18435-1-johan+linaro@kernel.org>
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

The size of the UFS PHY serdes register region is 0x1c8 and the
corresponding 'reg' property should specifically not include the
adjacent regions that are defined in the child node (e.g. tx and rx).

Fixes: 152d1faf1e2f ("arm64: dts: qcom: add SC8280XP platform")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 4b85c9276435..638317f78ab2 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -1432,7 +1432,7 @@ ufs_mem_hc: ufs@1d84000 {
 
 		ufs_mem_phy: phy@1d87000 {
 			compatible = "qcom,sc8280xp-qmp-ufs-phy";
-			reg = <0 0x01d87000 0 0xe10>;
+			reg = <0 0x01d87000 0 0x1c8>;
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges;
@@ -1500,7 +1500,7 @@ ufs_card_hc: ufs@1da4000 {
 
 		ufs_card_phy: phy@1da7000 {
 			compatible = "qcom,sc8280xp-qmp-ufs-phy";
-			reg = <0 0x01da7000 0 0xe10>;
+			reg = <0 0x01da7000 0 0x1c8>;
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges;
-- 
2.35.1


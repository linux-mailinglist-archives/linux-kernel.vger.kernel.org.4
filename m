Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC06A6006EF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 08:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbiJQGvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 02:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiJQGuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 02:50:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3D84D4DB;
        Sun, 16 Oct 2022 23:50:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 408C8B80EBD;
        Mon, 17 Oct 2022 06:50:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC3EC4FEB6;
        Mon, 17 Oct 2022 06:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665989441;
        bh=h9t3f2jv70g3Xg8Fuz/cy6pNfgf+gjH5E7JH0Z7sUPI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=euto/nuJP40pIQNp7AbjSENl7GIMh212CJCFmG8aGOmWQ8EvGiKRVl2R8Xm4i5f9+
         UPF6gTNikWVC+yJ1PGab9ioyAQzYN08l6uqmtpFjiwFbDpW3Fm9NbggRwwwIdWv7Pc
         0pL2TQRlCw0i6t5/Y75aFbM5USQGf9OZQYoTzbPMEzZkpp2sY1zlqKNfK9yOnV17rK
         0IMUT3yRM/Q+2HlwiSP0+kYXhZpXLms/fSzZh0cdqkrLKoahOypbSJhD5V3iNAiqU2
         2zpNUsTBiUVSfztm50SFE3kEZJxm7Nv5NjQrxqh6aTCuSJeLGrR36samuJWNIH3DSJ
         TY3aG8O96UH9g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1okJxG-00057s-Uu; Mon, 17 Oct 2022 08:50:30 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v3 09/11] phy: qcom-qmp-usb: clean up power-down handling
Date:   Mon, 17 Oct 2022 08:50:11 +0200
Message-Id: <20221017065013.19647-10-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221017065013.19647-1-johan+linaro@kernel.org>
References: <20221017065013.19647-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Always define the POWER_DOWN_CONTROL register instead of falling back to
the v2 (and v3) offset during power on and power off.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
index 965e486ab87d..b0b13fb6cb59 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
@@ -126,6 +126,7 @@ static const unsigned int usb3phy_regs_layout[QPHY_LAYOUT_SIZE] = {
 	[QPHY_PCS_AUTONOMOUS_MODE_CTRL]	= 0x0d4,
 	[QPHY_PCS_LFPS_RXTERM_IRQ_CLEAR]  = 0x0d8,
 	[QPHY_PCS_LFPS_RXTERM_IRQ_STATUS] = 0x178,
+	[QPHY_PCS_POWER_DOWN_CONTROL]	= 0x04,
 };
 
 static const unsigned int qmp_v3_usb3phy_regs_layout[QPHY_LAYOUT_SIZE] = {
@@ -135,6 +136,7 @@ static const unsigned int qmp_v3_usb3phy_regs_layout[QPHY_LAYOUT_SIZE] = {
 	[QPHY_PCS_AUTONOMOUS_MODE_CTRL]	= 0x0d8,
 	[QPHY_PCS_LFPS_RXTERM_IRQ_CLEAR]  = 0x0dc,
 	[QPHY_PCS_LFPS_RXTERM_IRQ_STATUS] = 0x170,
+	[QPHY_PCS_POWER_DOWN_CONTROL]	= 0x04,
 };
 
 static const unsigned int qmp_v4_usb3phy_regs_layout[QPHY_LAYOUT_SIZE] = {
@@ -2164,13 +2166,8 @@ static int qmp_usb_init(struct phy *phy)
 		qphy_clrbits(dp_com, QPHY_V3_DP_COM_SW_RESET, SW_RESET);
 	}
 
-	if (cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL])
-		qphy_setbits(pcs,
-			     cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL],
-			     cfg->pwrdn_ctrl);
-	else
-		qphy_setbits(pcs, QPHY_V2_PCS_POWER_DOWN_CONTROL,
-			     cfg->pwrdn_ctrl);
+	qphy_setbits(pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL],
+			cfg->pwrdn_ctrl);
 
 	return 0;
 
@@ -2277,13 +2274,8 @@ static int qmp_usb_power_off(struct phy *phy)
 	qphy_clrbits(qphy->pcs, cfg->regs[QPHY_START_CTRL], cfg->start_ctrl);
 
 	/* Put PHY into POWER DOWN state: active low */
-	if (cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL]) {
-		qphy_clrbits(qphy->pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL],
-			     cfg->pwrdn_ctrl);
-	} else {
-		qphy_clrbits(qphy->pcs, QPHY_V2_PCS_POWER_DOWN_CONTROL,
-				cfg->pwrdn_ctrl);
-	}
+	qphy_clrbits(qphy->pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL],
+			cfg->pwrdn_ctrl);
 
 	return 0;
 }
-- 
2.37.3


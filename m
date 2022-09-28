Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C0E5EE06E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 17:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbiI1P3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 11:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234334AbiI1P2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:28:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06031367BB;
        Wed, 28 Sep 2022 08:28:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BB5061F09;
        Wed, 28 Sep 2022 15:28:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC9CC43470;
        Wed, 28 Sep 2022 15:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664378916;
        bh=UTlC61z7rj8etdEZLgSbUnXER0qpRtxBcRao+1tRt3w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RT8d9c/Iva5E6cPgbHG8sKc7/neaWORUWab1UpvWBASKQfvCXgAVCxQwe+3TN8wfQ
         mz4J1/kfBIwQgsXwjc63b1kbtUb7VSAjA2GJt5XBpqgHqhTVFX/51rhJAZvd+gTitY
         MDNKUv/SI34sk0VYm1uFzeeff3qKiTSlsRe2q/n6GCJWm3K8SS2NLWxnJojvp4xhBE
         0edyYL8iAch9M4RCFO55tZZyEWIgzXmClbgZKGYiwGPNTXoXuEpmUPXzl915S+j2YX
         mLOp+FG+2iEQkDcTi7H5ghTa18OI0vEAdVGWcoVH+r1qLczSKufuBQkB/uVRzaMCTM
         MzOeZhg2n8JCQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1odYzK-0007zo-O8; Wed, 28 Sep 2022 17:28:42 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 06/13] phy: qcom-qmp-pcie: drop bogus register update
Date:   Wed, 28 Sep 2022 17:28:15 +0200
Message-Id: <20220928152822.30687-7-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220928152822.30687-1-johan+linaro@kernel.org>
References: <20220928152822.30687-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 0d58280cf1e6 ("phy: Update PHY power control sequence") the
PHY is powered on before configuring the registers and only the MSM8996
PCIe PHY, which includes the POWER_DOWN_CONTROL register in its PCS
initialisation table, may possibly require a second update afterwards.

To make things worse, the POWER_DOWN_CONTROL register lies at a
different offset on more recent SoCs so that the second update, which
still used a hard-coded offset, would write to an unrelated register
(e.g. a revision-id register on SC8280XP).

As the MSM8996 PCIe PHY is now handled by a separate driver, simply drop
the bogus register update.

Fixes: e4d8b05ad5f9 ("phy: qcom-qmp: Use proper PWRDOWN offset for sm8150 USB") added support
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 4146545fdf5f..eea66c24cf7e 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -1953,12 +1953,6 @@ static int qmp_pcie_power_on(struct phy *phy)
 	qmp_pcie_configure(pcs_misc, cfg->regs, cfg->pcs_misc_tbl, cfg->pcs_misc_tbl_num);
 	qmp_pcie_configure(pcs_misc, cfg->regs, cfg->pcs_misc_tbl_sec, cfg->pcs_misc_tbl_num_sec);
 
-	/*
-	 * Pull out PHY from POWER DOWN state.
-	 * This is active low enable signal to power-down PHY.
-	 */
-	qphy_setbits(pcs, QPHY_V2_PCS_POWER_DOWN_CONTROL, cfg->pwrdn_ctrl);
-
 	if (cfg->has_pwrdn_delay)
 		usleep_range(cfg->pwrdn_delay_min, cfg->pwrdn_delay_max);
 
-- 
2.35.1


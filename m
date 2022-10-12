Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8042B5FC245
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 10:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiJLIuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 04:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiJLIuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 04:50:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E9375FF7;
        Wed, 12 Oct 2022 01:50:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5857161484;
        Wed, 12 Oct 2022 08:50:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4CB4C433C1;
        Wed, 12 Oct 2022 08:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665564638;
        bh=4zcfD+SOdj1jTusmyy93nYGG11E/Cu6TVyZ3c6eqJo8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d+8dmTx06uiAAWt8FRYuylxgalDmWUacosmDx4KyZPm1T0J7JmtI7k9qyuH+/Ks3u
         btTjisHdbz0WQUgZA8zluTXZf96oiAjVDYN4vPQtAuHInQM5RgYv6jnTJ05MxoKPVE
         ZJ9LununZa87rmReVlnNINpTqRnyCyns4mPtgOvIocMnng35XNpERofpUxtu0zrVCU
         /iqNW0Q1UMTE5asXHGXUTwEi4dKheNkQS1ijIVWCmH5Ic90K1XULbVrTvy64Yn5VPh
         At+KiwQSP/jWSaUyYzyD9Pd9t71vuo8Sz9geSIbl7Y2NR6FXmdPLaqrmB0HSH0YVsj
         VdUsmgotRwK6w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oiXRe-0006Hd-DJ; Wed, 12 Oct 2022 10:50:30 +0200
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
Subject: [PATCH 04/20] phy: qcom-qmp-pcie: clean up status polling
Date:   Wed, 12 Oct 2022 10:49:46 +0200
Message-Id: <20221012085002.24099-4-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221012085002.24099-1-johan+linaro@kernel.org>
References: <20221012084846.24003-1-johan+linaro@kernel.org>
 <20221012085002.24099-1-johan+linaro@kernel.org>
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

Clean up the status polling by dropping the ready bit mask which is no
longer needed since the QMP driver split.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 9b866ed19ddc..4af6b9e50d16 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -1966,7 +1966,7 @@ static int qmp_pcie_power_on(struct phy *phy)
 	const struct qmp_phy_cfg_tables *mode_tables;
 	void __iomem *pcs = qphy->pcs;
 	void __iomem *status;
-	unsigned int mask, val, ready;
+	unsigned int mask, val;
 	int ret;
 
 	qphy_setbits(pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL],
@@ -2004,9 +2004,7 @@ static int qmp_pcie_power_on(struct phy *phy)
 
 	status = pcs + cfg->regs[QPHY_PCS_STATUS];
 	mask = cfg->phy_status;
-	ready = 0;
-
-	ret = readl_poll_timeout(status, val, (val & mask) == ready, 10,
+	ret = readl_poll_timeout(status, val, !(val & mask), 10,
 				 PHY_INIT_COMPLETE_TIMEOUT);
 	if (ret) {
 		dev_err(qmp->dev, "phy initialization timed-out\n");
-- 
2.35.1


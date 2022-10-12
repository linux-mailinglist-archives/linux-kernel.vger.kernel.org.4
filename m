Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36C45FC25D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 10:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiJLIvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 04:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiJLIum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 04:50:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C947F08D;
        Wed, 12 Oct 2022 01:50:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5026C61494;
        Wed, 12 Oct 2022 08:50:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5E81C4FEE2;
        Wed, 12 Oct 2022 08:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665564639;
        bh=G8AJGMxl9/KJWXhq+yWOTNR/z95QK5IJBTDIbrH6Oy8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=chsbgIEvK92Vm3QZmlw0lfBeXVjxDUVqVo/a+ljetslZzSEpkQnXTYNc0M3A75HaP
         OV2alpHoQlNcHe6GrAiX0E3cZpRWXcdtkt2UO/cNOiUYluR2eRE6UkDtzCRu+X6AM6
         570Y2utcKFSGqwJNyCzftIT7RzwYX1svh/zvtenz8eBkEya5ocCIiVW/2XJZdqNAZ/
         btWV26ztkZOvcI0x4HZQDXuCgVxo/141369K/XAKookjXNcpSKE/mPQqnYkvUDKM3l
         33ba2WBlVwLfIAjQl66oqpZ3KXNxcTa4WWpBXBXmLwUO7FyE8QvFIz8CWqprwCVXqd
         CYe56YwlasjdA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oiXRe-0006HZ-6o; Wed, 12 Oct 2022 10:50:30 +0200
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
Subject: [PATCH 02/20] phy: qcom-qmp-pcie: fix ipq8074-gen3 initialisation
Date:   Wed, 12 Oct 2022 10:49:44 +0200
Message-Id: <20221012085002.24099-2-johan+linaro@kernel.org>
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

The phy_status mask was never set for IPQ8074 (gen3) which meant that
the driver would not wait for the PHY to be initialised during power-on
and would never detect PHY initialisation timeouts.

Fixes: 334fad185415 ("phy: qcom-qmp-pcie: add IPQ8074 PCIe Gen3 QMP PHY support")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index a7677b61f96e..f1e94b879d31 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -1519,6 +1519,7 @@ static const struct qmp_phy_cfg ipq8074_pciephy_gen3_cfg = {
 
 	.start_ctrl		= SERDES_START | PCS_START,
 	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
+	.phy_status		= PHYSTATUS,
 
 	.pipe_clock_rate	= 250000000,
 };
-- 
2.35.1


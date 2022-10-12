Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4888C5FC26B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 10:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiJLIwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 04:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiJLIup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 04:50:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199C375FF7;
        Wed, 12 Oct 2022 01:50:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 72C69B819FA;
        Wed, 12 Oct 2022 08:50:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFE39C4FF19;
        Wed, 12 Oct 2022 08:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665564639;
        bh=Vm0IV9Ie9L+1jEdO8boOCGtP7r5+JBi9mG/Dn1+E7Sw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rHOq9XNTchJ0UN2mHMRcK0md4i/e+nacmQO2MInHqQ74nNOk1TlpXLT90Ir3y0ePI
         J3wiQHjm3e9mbWCBIfcqiZrqrItMpjiTM3VKf4Q+GtWlwuwhpZWQD56PL5EsVGGTXS
         YE4kDM6F1yCrj2mnT9j4RT8qlhOa8yRQQIu+rY/WJGrqdUuno1bA5JhABAW4n1Ysoa
         Ma1zowH0jNmbGwb8lgec+3IlCYZSN0qIhM7tmVpWComSEYGI16kOrFF7djNn37oJjr
         ESwtZ3WMtpmiJoxMIlSr4CZqezAkA3ndPnub1cx1dUNawRk29df23PtteBkM0x6m8I
         zlm3vmgCg2U0g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oiXRf-0006IG-Go; Wed, 12 Oct 2022 10:50:31 +0200
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
Subject: [PATCH 17/20] phy: qcom-qmp-pcie: add config sanity checks
Date:   Wed, 12 Oct 2022 10:49:59 +0200
Message-Id: <20221012085002.24099-17-johan+linaro@kernel.org>
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

The driver expects every configuration to set the pwrdn_ctrl and
phy_status masks. Add some probe WARN_ON_ONCE() to probe to catch any
new driver support that fails to provide them.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 5534a4ad0243..7c81667dd968 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -2347,6 +2347,9 @@ static int qmp_pcie_probe(struct platform_device *pdev)
 	if (!cfg)
 		return -EINVAL;
 
+	WARN_ON_ONCE(!cfg->pwrdn_ctrl);
+	WARN_ON_ONCE(!cfg->phy_status);
+
 	serdes = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(serdes))
 		return PTR_ERR(serdes);
-- 
2.35.1


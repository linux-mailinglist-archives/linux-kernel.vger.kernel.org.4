Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38465604465
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbiJSMCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbiJSMCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:02:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3080E18499D;
        Wed, 19 Oct 2022 04:38:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB1E160B8E;
        Wed, 19 Oct 2022 11:36:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF12BC4347C;
        Wed, 19 Oct 2022 11:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666179379;
        bh=zIA+ml8wbUJ1pYtOiAw0rtWwlGesij42jZ74b5odlbA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OnfROS9pgtB+v2R+pRpamwuc5ZfGYmp8hTczSrF6h09gpiAZ/PA1Z0Xbqp0QBh46S
         EGCz/oppZ1IkL0Xwa6D6udZxbKcCKWaDetAWHO3swrwh/yqZZe0v1Wk1yKHuZ1TUOB
         eqj0e2n60OIZXQnPaQSgbklGG4T1ZCIjZPWgA/DBT8a2O+9ngHv08rAQNhhR5rp+ZY
         hgPKMoZJ/tU+VU5Db0V2rs+aWwm6lt4hp7FAToofhsG1qEOhyPOPWBqbNIk4veu8zo
         0ESO1sgYXpUofJridNFGr0ujQNQ8iOlEEPpgZriNDaikppkA4kKK4xt5xoQYh9mGmN
         67dypo7QXf4cQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1ol7Mm-0005pl-9a; Wed, 19 Oct 2022 13:36:08 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 12/15] phy: qcom-qmp-pcie: fix initialisation reset
Date:   Wed, 19 Oct 2022 13:35:49 +0200
Message-Id: <20221019113552.22353-13-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221019113552.22353-1-johan+linaro@kernel.org>
References: <20221019113552.22353-1-johan+linaro@kernel.org>
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

Add the missing delay after asserting reset. This is specifically needed
for the reset to have any effect on SC8280XP.

The vendor driver uses a 1 ms delay, but that seems a bit excessive.
Instead use a 200 us delay which appears to be more than enough and also
matches the UFS reset delay added by commit 870b1279c7a0 ("scsi:
ufs-qcom: Add reset control support for host controller").

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 2f4bdef73395..9c8e009033f1 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -1866,6 +1866,8 @@ static int qmp_pcie_init(struct phy *phy)
 		goto err_disable_regulators;
 	}
 
+	usleep_range(200, 300);
+
 	ret = reset_control_bulk_deassert(cfg->num_resets, qmp->resets);
 	if (ret) {
 		dev_err(qmp->dev, "reset deassert failed\n");
-- 
2.37.3


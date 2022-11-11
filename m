Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E980625720
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 10:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbiKKJnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 04:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233686AbiKKJnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 04:43:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A1F78782;
        Fri, 11 Nov 2022 01:43:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 084D361F2D;
        Fri, 11 Nov 2022 09:43:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF7EC43142;
        Fri, 11 Nov 2022 09:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668159796;
        bh=TzRtDoyAfzMufPd65BGkX4pJ/DMl35ij09Pc1cMge34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AkV9KHrhRaLPwJse3DLZBzlWclo57AXP2hdYhe7qInV7pfqF1KTZLt8OMfbx06k+r
         o9GGULfLHoOYWvqVHiK/U//cKrOV5fQEIgyp82qL6bkblNQBoFr0UWNXpefv0i3vQo
         UhF2MbjxzLtaebXZnrwmJWD3RRmzZcMEEUBXYlvKnpVPB0Uj+BRPBT7YvqxZpQFyVM
         bE1LRoirVW/mSJ5d2+oiuKEcDZ8mucVDY5C9hRZ7fZiKu8BJGI6gdKRcyibQcdW9EW
         TMLCzMJbtt+Hqv4Jl0/GqRZLjftDUwTEsdFe0ry78I9NZwRHxcmFN/4y45/JZd7qHM
         3mbwPHT3w88QQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1otQYi-00030f-Kx; Fri, 11 Nov 2022 10:42:48 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 3/3] phy: qcom-qmp-pcie: drop redundant clock allocation
Date:   Fri, 11 Nov 2022 10:42:39 +0100
Message-Id: <20221111094239.11547-4-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221111094239.11547-1-johan+linaro@kernel.org>
References: <20221111094239.11547-1-johan+linaro@kernel.org>
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

Since the QMP driver split, there is no reason to allocate the
fixed-rate pipe clock structure separately from the driver data.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 328708a09c37..68cafc9561ae 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -1546,6 +1546,8 @@ struct qmp_pcie {
 
 	struct phy *phy;
 	int mode;
+
+	struct clk_fixed_rate pipe_clk_fixed;
 };
 
 static inline void qphy_setbits(void __iomem *base, u32 offset, u32 val)
@@ -2410,7 +2412,7 @@ static void phy_clk_release_provider(void *res)
  */
 static int phy_pipe_clk_register(struct qmp_pcie *qmp, struct device_node *np)
 {
-	struct clk_fixed_rate *fixed;
+	struct clk_fixed_rate *fixed = &qmp->pipe_clk_fixed;
 	struct clk_init_data init = { };
 	int ret;
 
@@ -2420,10 +2422,6 @@ static int phy_pipe_clk_register(struct qmp_pcie *qmp, struct device_node *np)
 		return ret;
 	}
 
-	fixed = devm_kzalloc(qmp->dev, sizeof(*fixed), GFP_KERNEL);
-	if (!fixed)
-		return -ENOMEM;
-
 	init.ops = &clk_fixed_rate_ops;
 
 	/*
-- 
2.37.4


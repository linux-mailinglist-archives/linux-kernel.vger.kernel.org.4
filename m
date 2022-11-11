Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F4C62571F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 10:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbiKKJnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 04:43:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233685AbiKKJnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 04:43:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AFE78787;
        Fri, 11 Nov 2022 01:43:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04A8C61F2C;
        Fri, 11 Nov 2022 09:43:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF55C4347C;
        Fri, 11 Nov 2022 09:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668159796;
        bh=NPLRtc4/Xi9APO2NAgfGkGH+wyMbp8HKKo8ZM8BktiM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SmTC1BBmrJxXcYYRf0fP3bXS4z3EM0EYWeLP9UXr0ulim3nf06NrmRvF0HfJ766kw
         Krzq1iH5aamZYtsRKqYQys8BlObh/bzCX2qSY3SFPTXmlaiYqtcWG87lhR24fM8sP0
         5gNN2VHtaOnvBJQpxwSYonvdk/s6oGfLO+0EbBxTJWLXmR910uSHEki/mEYO9Xw5oV
         eH3jhao8g3WxHqBVVdYmZjD2SXW3hml5ViNpgpCQUUYuRIfUx8KULpVyiRy41cGTth
         oMA5bB0MpqmKi9xbz5TTUdIyISQR34+nr8/uPuPFVDFjEmC65DzU+7Hc6sajR09qgC
         VjiwEg8w5zU8g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1otQYi-00030d-I4; Fri, 11 Nov 2022 10:42:48 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 2/3] phy: qcom-qmp-usb: drop redundant clock allocation
Date:   Fri, 11 Nov 2022 10:42:38 +0100
Message-Id: <20221111094239.11547-3-johan+linaro@kernel.org>
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
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
index 8b111b7087b9..27f2398ebf08 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
@@ -1485,6 +1485,8 @@ struct qmp_usb {
 	enum phy_mode mode;
 
 	struct phy *phy;
+
+	struct clk_fixed_rate pipe_clk_fixed;
 };
 
 static inline void qphy_setbits(void __iomem *base, u32 offset, u32 val)
@@ -2357,7 +2359,7 @@ static void phy_clk_release_provider(void *res)
  */
 static int phy_pipe_clk_register(struct qmp_usb *qmp, struct device_node *np)
 {
-	struct clk_fixed_rate *fixed;
+	struct clk_fixed_rate *fixed = &qmp->pipe_clk_fixed;
 	struct clk_init_data init = { };
 	int ret;
 
@@ -2367,10 +2369,6 @@ static int phy_pipe_clk_register(struct qmp_usb *qmp, struct device_node *np)
 		return ret;
 	}
 
-	fixed = devm_kzalloc(qmp->dev, sizeof(*fixed), GFP_KERNEL);
-	if (!fixed)
-		return -ENOMEM;
-
 	init.ops = &clk_fixed_rate_ops;
 
 	/* controllers using QMP phys use 125MHz pipe clock interface */
-- 
2.37.4


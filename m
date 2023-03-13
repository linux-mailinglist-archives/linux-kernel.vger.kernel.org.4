Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23026B71AC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 09:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjCMIx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 04:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjCMIxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 04:53:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F01C2BEDB;
        Mon, 13 Mar 2023 01:50:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC9116116D;
        Mon, 13 Mar 2023 08:50:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F056C4339B;
        Mon, 13 Mar 2023 08:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678697456;
        bh=aGmBJTLihmn6NlY3ZdQbfuZ8mhBDbOUV15yYyJq3Nq4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P3MiTsciJBrc4TsZhq68bs7oHbpEJ07tEltt2TZojiU+CULxKjs4hz9em8jFMQxRA
         bs+sRiiSz+1vtjs5mzQKvhjInbkj13HjJ0OH3JijgidZpmD1ewQjhORIkU/wufdhFz
         u2tuLa8IPfPufQMLhngCqVTuueEj9wL37U9jhwUNimDnlskgnRr5XwbiCNwjKBD0QK
         kH7ftGLDC7ajdOwzdBPn9GaLmNjXTsIz+45ubrg2rTt01UOG0sMdNnfTpFOdZ3NlBg
         mgL7ioJURhOutkqE788NZ0oL9oo0P/bKZmMFKcVvLbiuQSJB0CVbemxDfeX5nKJuHG
         lk51fCW5YSemg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pbduO-0006Hw-OJ; Mon, 13 Mar 2023 09:51:56 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 2/2] interconnect: qcom: rpm: drop bogus pm domain attach
Date:   Mon, 13 Mar 2023 09:49:53 +0100
Message-Id: <20230313084953.24088-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313084953.24088-1-johan+linaro@kernel.org>
References: <20230313084953.24088-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any power domain would already have been attached by the platform bus
code so drop the bogus power domain attach which always succeeds from
probe.

This effectively reverts commit 7de109c0abe9 ("interconnect: icc-rpm:
Add support for bus power domain").

Fixes: 7de109c0abe9 ("interconnect: icc-rpm: Add support for bus power domain")
Cc: Yassine Oudjana <y.oudjana@protonmail.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 6 ------
 drivers/interconnect/qcom/icc-rpm.h | 1 -
 drivers/interconnect/qcom/msm8996.c | 1 -
 3 files changed, 8 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 3b055cd893ea..c303ce22a7cd 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -496,12 +496,6 @@ int qnoc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	if (desc->has_bus_pd) {
-		ret = dev_pm_domain_attach(dev, true);
-		if (ret)
-			goto err_disable_clks;
-	}
-
 	provider = &qp->provider;
 	provider->dev = dev;
 	provider->set = qcom_icc_set;
diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index a49af844ab13..02257b0d3d5c 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -91,7 +91,6 @@ struct qcom_icc_desc {
 	size_t num_nodes;
 	const char * const *clocks;
 	size_t num_clocks;
-	bool has_bus_pd;
 	enum qcom_icc_type type;
 	const struct regmap_config *regmap_cfg;
 	unsigned int qos_offset;
diff --git a/drivers/interconnect/qcom/msm8996.c b/drivers/interconnect/qcom/msm8996.c
index 25a1a32bc611..14efd2761b7a 100644
--- a/drivers/interconnect/qcom/msm8996.c
+++ b/drivers/interconnect/qcom/msm8996.c
@@ -1823,7 +1823,6 @@ static const struct qcom_icc_desc msm8996_a0noc = {
 	.num_nodes = ARRAY_SIZE(a0noc_nodes),
 	.clocks = bus_a0noc_clocks,
 	.num_clocks = ARRAY_SIZE(bus_a0noc_clocks),
-	.has_bus_pd = true,
 	.regmap_cfg = &msm8996_a0noc_regmap_config
 };
 
-- 
2.39.2


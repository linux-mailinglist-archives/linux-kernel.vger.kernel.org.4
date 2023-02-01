Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2075A6863CB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 11:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjBAKQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 05:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbjBAKQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 05:16:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1154F3EFD5;
        Wed,  1 Feb 2023 02:16:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6474261760;
        Wed,  1 Feb 2023 10:16:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347EEC43141;
        Wed,  1 Feb 2023 10:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675246593;
        bh=wRymLHXCWqnkYqQGyutZODF79K4cpesmi8Cm/ANh5+g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TkCAzV47/PLKloW530+0THEICphvDfNQEdS+t9TEv3KlDrgGF7yZUb2YKrABsIjX6
         FXYcW1joCD8cysr//4Ub5XaSPmTn8gE9dOiq5IWTMJPwJgWEqTfnoaZonrVoNvYQ/V
         c7uueRVHuwcD3M/AmCO1DrRt6CL3LC6D8/56ytCqT0Pbs1CrqnvYtDtrkOiIXPk9/O
         qf/OHqlzb2Po8dH910Z2Nd63i5cqBqS1OHmd+7s97GtYT6CZq0MBPV0Ok16ad5la/V
         oP5BCmUdIKvdprgTtv3PU038A+Lw+N39GzGOVwRK76MqY6ZfstFOt4OUft/2YpFwd7
         URPzlAOnE+4Ag==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pNAAg-00044N-Dz; Wed, 01 Feb 2023 11:16:54 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 16/23] interconnect: exynos: drop redundant link destroy
Date:   Wed,  1 Feb 2023 11:15:52 +0100
Message-Id: <20230201101559.15529-17-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230201101559.15529-1-johan+linaro@kernel.org>
References: <20230201101559.15529-1-johan+linaro@kernel.org>
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

There is no longer any need to explicitly destroy node links as this is
now done when the node is destroyed as part of icc_nodes_remove().

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/interconnect/samsung/exynos.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/interconnect/samsung/exynos.c b/drivers/interconnect/samsung/exynos.c
index 72e42603823b..ebf09bbf725b 100644
--- a/drivers/interconnect/samsung/exynos.c
+++ b/drivers/interconnect/samsung/exynos.c
@@ -96,14 +96,8 @@ static struct icc_node *exynos_generic_icc_xlate(struct of_phandle_args *spec,
 static int exynos_generic_icc_remove(struct platform_device *pdev)
 {
 	struct exynos_icc_priv *priv = platform_get_drvdata(pdev);
-	struct icc_node *parent_node, *node = priv->node;
 
 	icc_provider_deregister(&priv->provider);
-
-	parent_node = exynos_icc_get_parent(priv->dev->parent->of_node);
-	if (parent_node && !IS_ERR(parent_node))
-		icc_link_destroy(node, parent_node);
-
 	icc_nodes_remove(&priv->provider);
 
 	return 0;
-- 
2.39.1


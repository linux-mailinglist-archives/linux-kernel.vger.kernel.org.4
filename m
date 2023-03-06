Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659FB6AB7D8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 08:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjCFH6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 02:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjCFH5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 02:57:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7211F5CD;
        Sun,  5 Mar 2023 23:57:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DDE4560C48;
        Mon,  6 Mar 2023 07:57:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E79BFC43143;
        Mon,  6 Mar 2023 07:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678089457;
        bh=7x5hKjU6NkCK2RH7/GPqPhr++Nr1GDv6lKb2dVUnLKM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gEoOiMqnPzohh3nJVCPrdDc1MYmWA4bxnGQhSD9eKcw9xF0Sw1hZb1rvIpm4qSDC4
         M5xdeEi8K860PtK58c1eksf3G8lC0CRo8TCRU93hNwk9MtW/gNB12iJAdO+UBCLJtt
         S1BaaFt5HMzmC1MyMO94ZgVmywnkEWpJEL8n460n8sOZbDJcRDL24clvv1StCBHptb
         WWfOVC4FIAS361iRSndzx1yrQd7d11GUE2STLFheD6Yl6F9auY0MU3PRF5cqObUF2X
         tRGbMnLABKI9uTeqNYlS2wMCd2BIIT4bXFQPnWh2mWw8ratxWvOS5TA721Yg2W+7yP
         HtL/KUwVi+z6w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pZ5jd-0000ic-5o; Mon, 06 Mar 2023 08:58:17 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     "Shawn Guo" <shawnguo@kernel.org>,
        "Sascha Hauer" <s.hauer@pengutronix.de>,
        "Pengutronix Kernel Team" <kernel@pengutronix.de>,
        "Fabio Estevam" <festevam@gmail.com>,
        "NXP Linux Team" <linux-imx@nxp.com>,
        "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "Sylwester Nawrocki" <s.nawrocki@samsung.com>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Alim Akhtar" <alim.akhtar@samsung.com>,
        "Thierry Reding" <thierry.reding@gmail.com>,
        "Jonathan Hunter" <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 16/23] interconnect: exynos: drop redundant link destroy
Date:   Mon,  6 Mar 2023 08:56:44 +0100
Message-Id: <20230306075651.2449-17-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230306075651.2449-1-johan+linaro@kernel.org>
References: <20230306075651.2449-1-johan+linaro@kernel.org>
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

There is no longer any need to explicitly destroy node links as this is
now done when the node is destroyed as part of icc_nodes_remove().

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
2.39.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1AB686408
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 11:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbjBAKRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 05:17:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjBAKQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 05:16:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C284F36F;
        Wed,  1 Feb 2023 02:16:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2ABE061753;
        Wed,  1 Feb 2023 10:16:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F27C4FE03;
        Wed,  1 Feb 2023 10:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675246593;
        bh=0m8gstcsjAXKkZ3q2p9aNR2mJM0JHgPPjx74c1l8cI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eCMI8uXF/3vctbgf7q2GxhrLQtBbH/VJSdgU6kRcOZYJk6w1zND0LltlmGXMpu5r2
         GVjX2U9TEyhcbCTGv68EyJBQZLoJR45HCd00Xx2/Rreo9DP3652aLKLEAJZTa5P1ZR
         PoqUB4+BvpCTM4je2Wbfzs2YWRPZ0CTOFbY3JYn9GqaasgZapVhY4GjzfQbPYB+pnw
         YcA1Rjr5+JXstyjwU6E09Wkb0GBmD0CKPQ1ulM/5kYTqt3imJh5qIGjEpdAOVpexP7
         j5m7NZn0teGWSBDX0agvbbR0Jh2HgCqEreB7PMeUYuro7SIGrR2Dxf9oj9SOSGZQPS
         5dHo+4LzWQpMw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pNAAh-00044i-1D; Wed, 01 Feb 2023 11:16:55 +0100
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
Subject: [PATCH 23/23] interconnect: drop unused icc_link_destroy() interface
Date:   Wed,  1 Feb 2023 11:15:59 +0100
Message-Id: <20230201101559.15529-24-johan+linaro@kernel.org>
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

Now that the link array is deallocated when destroying nodes and the
explicit link removal has been dropped from the exynos driver there are
no further users of and no need for the icc_link_destroy() interface.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/interconnect/core.c           | 46 ---------------------------
 include/linux/interconnect-provider.h |  6 ----
 2 files changed, 52 deletions(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 8cca5e9a9d5f..d40b35bdc6ef 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -859,52 +859,6 @@ int icc_link_create(struct icc_node *node, const int dst_id)
 }
 EXPORT_SYMBOL_GPL(icc_link_create);
 
-/**
- * icc_link_destroy() - destroy a link between two nodes
- * @src: pointer to source node
- * @dst: pointer to destination node
- *
- * Return: 0 on success, or an error code otherwise
- */
-int icc_link_destroy(struct icc_node *src, struct icc_node *dst)
-{
-	struct icc_node **new;
-	size_t slot;
-	int ret = 0;
-
-	if (IS_ERR_OR_NULL(src))
-		return -EINVAL;
-
-	if (IS_ERR_OR_NULL(dst))
-		return -EINVAL;
-
-	mutex_lock(&icc_lock);
-
-	for (slot = 0; slot < src->num_links; slot++)
-		if (src->links[slot] == dst)
-			break;
-
-	if (WARN_ON(slot == src->num_links)) {
-		ret = -ENXIO;
-		goto out;
-	}
-
-	src->links[slot] = src->links[--src->num_links];
-
-	new = krealloc(src->links, src->num_links * sizeof(*src->links),
-		       GFP_KERNEL);
-	if (new)
-		src->links = new;
-	else
-		ret = -ENOMEM;
-
-out:
-	mutex_unlock(&icc_lock);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(icc_link_destroy);
-
 /**
  * icc_node_add() - add interconnect node to interconnect provider
  * @node: pointer to the interconnect node
diff --git a/include/linux/interconnect-provider.h b/include/linux/interconnect-provider.h
index b9af9016a95e..e6d8aca6886d 100644
--- a/include/linux/interconnect-provider.h
+++ b/include/linux/interconnect-provider.h
@@ -118,7 +118,6 @@ int icc_std_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
 struct icc_node *icc_node_create(int id);
 void icc_node_destroy(int id);
 int icc_link_create(struct icc_node *node, const int dst_id);
-int icc_link_destroy(struct icc_node *src, struct icc_node *dst);
 void icc_node_add(struct icc_node *node, struct icc_provider *provider);
 void icc_node_del(struct icc_node *node);
 int icc_nodes_remove(struct icc_provider *provider);
@@ -150,11 +149,6 @@ static inline int icc_link_create(struct icc_node *node, const int dst_id)
 	return -ENOTSUPP;
 }
 
-static inline int icc_link_destroy(struct icc_node *src, struct icc_node *dst)
-{
-	return -ENOTSUPP;
-}
-
 static inline void icc_node_add(struct icc_node *node, struct icc_provider *provider)
 {
 }
-- 
2.39.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE0D6AB7D3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 08:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjCFH63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 02:58:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjCFH5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 02:57:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A52B1F903;
        Sun,  5 Mar 2023 23:57:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7764460C6F;
        Mon,  6 Mar 2023 07:57:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78246C4FF06;
        Mon,  6 Mar 2023 07:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678089457;
        bh=a3kuHjgYNyulLZAsEDFoN+UatIjlAmI+HwT51CVFQPY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nCrGJEX21WXgcEsGAk4UFHACAs4RlkJw1HpncMmUmsbc89kHB6gA8p6ve9V+R0SXS
         nbdYLPsPtWWVHGRD4xMXnWkddnVD+GefeSJhWh0kjvLhV7igS0oaOZTJUsADKQnizE
         JBLjdwMO/QSJHMvlMa9qFuOP6amlCqLPtcCsaj7o7e50+kVjErPAkW7UMgfWfiiiJ9
         Hbb0EiHc/vLTvOkb5U2bp95rGC7vOYP2gB51Ps+M9zjbWXeVXeJzsCYoH+Y5Gubmes
         8AC4buwsCi7bUG7Xw0Hj5pkhdo4JXVwLB6SRUmNmsmvnIucW3oQSvJafugKh+FmNTP
         xvmzLcbitTCLg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pZ5jd-0000iy-PL; Mon, 06 Mar 2023 08:58:17 +0100
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
Subject: [PATCH v2 23/23] interconnect: drop unused icc_link_destroy() interface
Date:   Mon,  6 Mar 2023 08:56:51 +0100
Message-Id: <20230306075651.2449-24-johan+linaro@kernel.org>
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

Now that the link array is deallocated when destroying nodes and the
explicit link removal has been dropped from the exynos driver there are
no further users of and no need for the icc_link_destroy() interface.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/interconnect/core.c           | 46 ---------------------------
 include/linux/interconnect-provider.h |  6 ----
 2 files changed, 52 deletions(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index fd12f109c05e..6315d4256ac1 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -862,52 +862,6 @@ int icc_link_create(struct icc_node *node, const int dst_id)
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
2.39.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654106AB7C0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 08:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjCFH6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 02:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjCFH5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 02:57:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEBE1A97F;
        Sun,  5 Mar 2023 23:57:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0618E60C4D;
        Mon,  6 Mar 2023 07:57:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA6DC4167C;
        Mon,  6 Mar 2023 07:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678089457;
        bh=RCTg24MLEmr2jGeawpxyl1buhok9BfoO0aD1ft1g/Ws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tNRQRCrt0yf0Fb/9C8V2AvnTVPmAuKgFHhPO8PKjFbot1TpJ6j+PIaAt+ZzhSi5tp
         PYnbG832OoZrzHqCmCZKRIBkZqT7+ZGFvSFhOV6m+puaKi38jk4M+otlyGq9pxNLdw
         G+VMwTA/pzp7cnUz9I0TgCXzDfCvO2jUJ/4nvHAYa2X/GxOMF/qjKNzESZM1gw/tvh
         glgLg9lwqBe7z9yxjzg4Lw496JU+kRh87MIIEhvMQ0scGWP99giGJcEdvxLRMjVXtt
         bWQ0c/2wamREbUdTIGPnGz9u7TUvv4G4quraopVpIxnadDyVyP+GFcPWJZoDG+3g0K
         dV6+V5pIBsIpA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pZ5jd-0000iv-M6; Mon, 06 Mar 2023 08:58:17 +0100
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
Subject: [PATCH v2 22/23] interconnect: drop unused icc_get() interface
Date:   Mon,  6 Mar 2023 08:56:50 +0100
Message-Id: <20230306075651.2449-23-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230306075651.2449-1-johan+linaro@kernel.org>
References: <20230306075651.2449-1-johan+linaro@kernel.org>
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

The icc_get() interface can be used to lookup an interconnect path based
on global node ids. There has never been any users of this interface and
all lookups are currently done from the devicetree.

Remove the unused icc_get() interface.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/interconnect/core.c  | 52 ++----------------------------------
 include/linux/interconnect.h |  8 ------
 2 files changed, 2 insertions(+), 58 deletions(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index ebefd263ac4b..fd12f109c05e 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -588,7 +588,7 @@ EXPORT_SYMBOL_GPL(icc_set_tag);
 
 /**
  * icc_get_name() - Get name of the icc path
- * @path: reference to the path returned by icc_get()
+ * @path: interconnect path
  *
  * This function is used by an interconnect consumer to get the name of the icc
  * path.
@@ -606,7 +606,7 @@ EXPORT_SYMBOL_GPL(icc_get_name);
 
 /**
  * icc_set_bw() - set bandwidth constraints on an interconnect path
- * @path: reference to the path returned by icc_get()
+ * @path: interconnect path
  * @avg_bw: average bandwidth in kilobytes per second
  * @peak_bw: peak bandwidth in kilobytes per second
  *
@@ -705,54 +705,6 @@ int icc_disable(struct icc_path *path)
 }
 EXPORT_SYMBOL_GPL(icc_disable);
 
-/**
- * icc_get() - return a handle for path between two endpoints
- * @dev: the device requesting the path
- * @src_id: source device port id
- * @dst_id: destination device port id
- *
- * This function will search for a path between two endpoints and return an
- * icc_path handle on success. Use icc_put() to release
- * constraints when they are not needed anymore.
- * If the interconnect API is disabled, NULL is returned and the consumer
- * drivers will still build. Drivers are free to handle this specifically,
- * but they don't have to.
- *
- * Return: icc_path pointer on success, ERR_PTR() on error or NULL if the
- * interconnect API is disabled.
- */
-struct icc_path *icc_get(struct device *dev, const int src_id, const int dst_id)
-{
-	struct icc_node *src, *dst;
-	struct icc_path *path = ERR_PTR(-EPROBE_DEFER);
-
-	mutex_lock(&icc_lock);
-
-	src = node_find(src_id);
-	if (!src)
-		goto out;
-
-	dst = node_find(dst_id);
-	if (!dst)
-		goto out;
-
-	path = path_find(dev, src, dst);
-	if (IS_ERR(path)) {
-		dev_err(dev, "%s: invalid path=%ld\n", __func__, PTR_ERR(path));
-		goto out;
-	}
-
-	path->name = kasprintf(GFP_KERNEL, "%s-%s", src->name, dst->name);
-	if (!path->name) {
-		kfree(path);
-		path = ERR_PTR(-ENOMEM);
-	}
-out:
-	mutex_unlock(&icc_lock);
-	return path;
-}
-EXPORT_SYMBOL_GPL(icc_get);
-
 /**
  * icc_put() - release the reference to the icc_path
  * @path: interconnect path
diff --git a/include/linux/interconnect.h b/include/linux/interconnect.h
index 2b0e784ba771..97ac253df62c 100644
--- a/include/linux/interconnect.h
+++ b/include/linux/interconnect.h
@@ -40,8 +40,6 @@ struct icc_bulk_data {
 
 #if IS_ENABLED(CONFIG_INTERCONNECT)
 
-struct icc_path *icc_get(struct device *dev, const int src_id,
-			 const int dst_id);
 struct icc_path *of_icc_get(struct device *dev, const char *name);
 struct icc_path *devm_of_icc_get(struct device *dev, const char *name);
 int devm_of_icc_bulk_get(struct device *dev, int num_paths, struct icc_bulk_data *paths);
@@ -61,12 +59,6 @@ void icc_bulk_disable(int num_paths, const struct icc_bulk_data *paths);
 
 #else
 
-static inline struct icc_path *icc_get(struct device *dev, const int src_id,
-				       const int dst_id)
-{
-	return NULL;
-}
-
 static inline struct icc_path *of_icc_get(struct device *dev,
 					  const char *name)
 {
-- 
2.39.2


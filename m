Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9691D70D99A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 11:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236277AbjEWJxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 05:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236411AbjEWJx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 05:53:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BA71B4;
        Tue, 23 May 2023 02:53:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E292C61C35;
        Tue, 23 May 2023 09:53:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B3B7C433EF;
        Tue, 23 May 2023 09:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684835598;
        bh=ITjVrCt2ytXcSsWvzm9MEzJEwLJBTz4OoB4cdobCwkw=;
        h=From:To:Cc:Subject:Date:From;
        b=ItRFkTvu7MXDEaipiS+Z1VWDK6eyyA8SeDsdyRRPfxAo7Le9zLA8x+h8WiEhlTyMJ
         YX58kTIPE1sG2oJWLU97LnaxxsE/euQHtS0jhLXjrsTjFppWRqAj41yLtaCGIH87lr
         2oDu6YsI6IAs1ewOJhd5XNSJwKouDNnNpZpCTdLKfcr8RWwMFuy3RkOrdz3V49FE8A
         ndXGPRJGnbewoL9GioCBOTVGPGhfhGOasfxjAlDqLi/QDfh4JDCNkqX9C66FCtb9J1
         xPmB96rJVRSfWCgdgS8l6aYYQU8zy3/G/iIGmHTN7aTH0zLJc1t6g4al9MnwI7nqRB
         3LkvfdKxYU3Mw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1q1Ohl-0006Yo-8z; Tue, 23 May 2023 11:53:21 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     "Bjorn Andersson" <andersson@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH RESEND v2] interconnect: drop unused icc_get() interface
Date:   Tue, 23 May 2023 11:52:48 +0200
Message-Id: <20230523095248.25211-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Hi Georgi,

I just noticed that this patch never made it into 6.4 along with the
rest of the series:

	https://lore.kernel.org/lkml/20230306075651.2449-23-johan+linaro@kernel.org/

This interface is still unused in mainline and should be removed so
resending the patch again.

Johan


 drivers/interconnect/core.c  | 52 ++----------------------------------
 include/linux/interconnect.h |  8 ------
 2 files changed, 2 insertions(+), 58 deletions(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index ec46bcb16d5e..5fac448c28fd 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -587,7 +587,7 @@ EXPORT_SYMBOL_GPL(icc_set_tag);
 
 /**
  * icc_get_name() - Get name of the icc path
- * @path: reference to the path returned by icc_get()
+ * @path: interconnect path
  *
  * This function is used by an interconnect consumer to get the name of the icc
  * path.
@@ -605,7 +605,7 @@ EXPORT_SYMBOL_GPL(icc_get_name);
 
 /**
  * icc_set_bw() - set bandwidth constraints on an interconnect path
- * @path: reference to the path returned by icc_get()
+ * @path: interconnect path
  * @avg_bw: average bandwidth in kilobytes per second
  * @peak_bw: peak bandwidth in kilobytes per second
  *
@@ -704,54 +704,6 @@ int icc_disable(struct icc_path *path)
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
2.39.3


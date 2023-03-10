Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5F86B54AE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 23:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbjCJWmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 17:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbjCJWmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 17:42:06 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76ECA14ACC8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 14:41:42 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1palQg-0002dD-Cl; Fri, 10 Mar 2023 23:41:38 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1palQf-003GqV-C4; Fri, 10 Mar 2023 23:41:37 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1palQe-003uEe-HA; Fri, 10 Mar 2023 23:41:36 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] bus: fsl-mc: fsl-mc-allocator: Improve error reporting
Date:   Fri, 10 Mar 2023 23:41:26 +0100
Message-Id: <20230310224128.2638078-5-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230310224128.2638078-1-u.kleine-koenig@pengutronix.de>
References: <20230310224128.2638078-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2224; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=m2h84BsJapWQ+IP/SZ8E8V7ar6wuL3BLup87a7Nixzk=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkC7IM8pg2g6H3wvwxPUVPKdlZoGauxCIeCp/j2 I+Raw+nlGaJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAuyDAAKCRDB/BR4rcrs CZMuB/0eCfFruQMz0wK1d6qgSDIzcVBfL8c2MHcqYpHOhs7bWc+lEJKrSgHjislIyLjat3xR9U9 KQh+LY9ORGrQvlSYGaqFyjXqey6nvAgySQZE+f+S5WQ+5S565+iFn/N/uI4n2el+HXjUmCKo2JN upmv0FpP0qeguyBr0hdzTbzWmMRqvjy6HCLsQcEdVRytGzxKsARdV18dNl2iAtUnGc62gMAJTdi 2etKfkhATvuK3LQrjOb4blRVjhopNkTIiPAaD2sQSeihTc/d0Ntmd+oR8QXZdRdS8q/IgTL7iqN nQGF+UDm9vle4ilielCJ/htVNRkTud1SV0xGmgg08P/HHPCO
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of silently returning an error in the remove callback (which yields
a generic and little informing error message), annotate each error path of
fsl_mc_resource_pool_remove_device() with an error message and return zero
in the remove callback to suppress the error message.

Note that changing the return value has no other effect than suppressing
the error message by the fsl_mc bus driver.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/bus/fsl-mc/fsl-mc-allocator.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-allocator.c b/drivers/bus/fsl-mc/fsl-mc-allocator.c
index e60faf8edaa1..36f70e5e418b 100644
--- a/drivers/bus/fsl-mc/fsl-mc-allocator.c
+++ b/drivers/bus/fsl-mc/fsl-mc-allocator.c
@@ -104,22 +104,30 @@ static int __must_check fsl_mc_resource_pool_remove_device(struct fsl_mc_device
 	int error = -EINVAL;
 
 	resource = mc_dev->resource;
-	if (!resource || resource->data != mc_dev)
+	if (!resource || resource->data != mc_dev) {
+		dev_err(&mc_bus_dev->dev, "resource mismatch\n");
 		goto out;
+	}
 
 	mc_bus_dev = to_fsl_mc_device(mc_dev->dev.parent);
 	mc_bus = to_fsl_mc_bus(mc_bus_dev);
 	res_pool = resource->parent_pool;
-	if (res_pool != &mc_bus->resource_pools[resource->type])
+	if (res_pool != &mc_bus->resource_pools[resource->type]) {
+		dev_err(&mc_bus_dev->dev, "pool mismatch\n");
 		goto out;
+	}
 
 	mutex_lock(&res_pool->mutex);
 
-	if (res_pool->max_count <= 0)
+	if (res_pool->max_count <= 0) {
+		dev_err(&mc_bus_dev->dev, "max_count underflow\n");
 		goto out_unlock;
+	}
 	if (res_pool->free_count <= 0 ||
-	    res_pool->free_count > res_pool->max_count)
+	    res_pool->free_count > res_pool->max_count) {
+		dev_err(&mc_bus_dev->dev, "free_count mismatch\n");
 		goto out_unlock;
+	}
 
 	/*
 	 * If the device is currently allocated, its resource is not
@@ -613,7 +621,7 @@ static int fsl_mc_allocator_remove(struct fsl_mc_device *mc_dev)
 	if (mc_dev->resource) {
 		error = fsl_mc_resource_pool_remove_device(mc_dev);
 		if (error < 0)
-			return error;
+			return 0;
 	}
 
 	dev_dbg(&mc_dev->dev,
-- 
2.39.1


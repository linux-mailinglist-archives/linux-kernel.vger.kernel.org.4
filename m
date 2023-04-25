Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34DF6EE40F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 16:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbjDYOh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 10:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234337AbjDYOgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 10:36:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 37BA213C05
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 07:36:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EACACC14;
        Tue, 25 Apr 2023 07:37:31 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 652BD3F587;
        Tue, 25 Apr 2023 07:36:46 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     coresight@lists.linaro.org, quic_jinlmao@quicinc.com,
        mike.leach@linaro.org, suzuki.poulose@arm.com
Cc:     James Clark <james.clark@arm.com>, Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 08/13] coresight: Simplify connection fixup mechanism
Date:   Tue, 25 Apr 2023 15:35:35 +0100
Message-Id: <20230425143542.2305069-9-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230425143542.2305069-1-james.clark@arm.com>
References: <20230425143542.2305069-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is some duplication between coresight_fixup_device_conns() and
coresight_fixup_orphan_conns(). They both do the same thing except for
the fact that coresight_fixup_orphan_conns() can't handle iterating over
itself.

By making it able to handle fixing up it's own connections the other
function can be removed.

Reviewed-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: James Clark <james.clark@arm.com>
---
 drivers/hwtracing/coresight/coresight-core.c | 84 ++++++++------------
 1 file changed, 32 insertions(+), 52 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 0b738960973b..8d377a59e0be 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -1316,42 +1316,46 @@ static int coresight_orphan_match(struct device *dev, void *data)
 {
 	int i, ret = 0;
 	bool still_orphan = false;
-	struct coresight_device *csdev, *i_csdev;
+	struct coresight_device *dst_csdev = data;
+	struct coresight_device *src_csdev = to_coresight_device(dev);
 	struct coresight_connection *conn;
-
-	csdev = data;
-	i_csdev = to_coresight_device(dev);
-
-	/* No need to check oneself */
-	if (csdev == i_csdev)
-		return 0;
+	bool fixup_self = (src_csdev == dst_csdev);
 
 	/* Move on to another component if no connection is orphan */
-	if (!i_csdev->orphan)
+	if (!src_csdev->orphan)
 		return 0;
 	/*
-	 * Circle throuch all the connection of that component.  If we find
-	 * an orphan connection whose name matches @csdev, link it.
+	 * Circle through all the connections of that component.  If we find
+	 * an orphan connection whose name matches @dst_csdev, link it.
 	 */
-	for (i = 0; i < i_csdev->pdata->nr_outconns; i++) {
-		conn = i_csdev->pdata->out_conns[i];
-
-		/* We have found at least one orphan connection */
-		if (conn->dest_dev == NULL) {
-			/* Does it match this newly added device? */
-			if (conn->dest_fwnode == csdev->dev.fwnode) {
-				ret = coresight_make_links(i_csdev,
-							   conn, csdev);
-				if (ret)
-					return ret;
-			} else {
-				/* This component still has an orphan */
-				still_orphan = true;
-			}
+	for (i = 0; i < src_csdev->pdata->nr_outconns; i++) {
+		conn = src_csdev->pdata->out_conns[i];
+
+		/* Skip the port if it's already connected. */
+		if (conn->dest_dev)
+			continue;
+
+		/*
+		 * If we are at the "new" device, which triggered this search,
+		 * we must find the remote device from the fwnode in the
+		 * connection.
+		 */
+		if (fixup_self)
+			dst_csdev = coresight_find_csdev_by_fwnode(
+				conn->dest_fwnode);
+
+		/* Does it match this newly added device? */
+		if (dst_csdev && conn->dest_fwnode == dst_csdev->dev.fwnode) {
+			ret = coresight_make_links(src_csdev, conn, dst_csdev);
+			if (ret)
+				return ret;
+		} else {
+			/* This component still has an orphan */
+			still_orphan = true;
 		}
 	}
 
-	i_csdev->orphan = still_orphan;
+	src_csdev->orphan = still_orphan;
 
 	/*
 	 * Returning '0' in case we didn't encounter any error,
@@ -1366,28 +1370,6 @@ static int coresight_fixup_orphan_conns(struct coresight_device *csdev)
 			 csdev, coresight_orphan_match);
 }
 
-
-static int coresight_fixup_device_conns(struct coresight_device *csdev)
-{
-	int i, ret = 0;
-
-	for (i = 0; i < csdev->pdata->nr_outconns; i++) {
-		struct coresight_connection *conn = csdev->pdata->out_conns[i];
-
-		conn->dest_dev =
-			coresight_find_csdev_by_fwnode(conn->dest_fwnode);
-		if (conn->dest_dev && conn->dest_dev->has_conns_grp) {
-			ret = coresight_make_links(csdev, conn, conn->dest_dev);
-			if (ret)
-				break;
-		} else {
-			csdev->orphan = true;
-		}
-	}
-
-	return ret;
-}
-
 static int coresight_remove_match(struct device *dev, void *data)
 {
 	int i;
@@ -1595,7 +1577,7 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 	csdev->subtype = desc->subtype;
 	csdev->ops = desc->ops;
 	csdev->access = desc->access;
-	csdev->orphan = false;
+	csdev->orphan = true;
 
 	csdev->dev.type = &coresight_dev_type[desc->type];
 	csdev->dev.groups = desc->groups;
@@ -1645,8 +1627,6 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 	registered = true;
 
 	ret = coresight_create_conns_sysfs_group(csdev);
-	if (!ret)
-		ret = coresight_fixup_device_conns(csdev);
 	if (!ret)
 		ret = coresight_fixup_orphan_conns(csdev);
 
-- 
2.34.1


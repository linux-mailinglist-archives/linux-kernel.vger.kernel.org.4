Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3109A6CD8DD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 13:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjC2LzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 07:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjC2Lyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 07:54:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2ACA74487
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 04:54:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 412711576;
        Wed, 29 Mar 2023 04:55:08 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 344F83F6C4;
        Wed, 29 Mar 2023 04:54:22 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     coresight@lists.linaro.org, quic_jinlmao@quicinc.com,
        mike.leach@linaro.org, suzuki.poulose@arm.com
Cc:     James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v3 08/13] coresight: Simplify connection fixup mechanism
Date:   Wed, 29 Mar 2023 12:53:21 +0100
Message-Id: <20230329115329.2747724-9-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230329115329.2747724-1-james.clark@arm.com>
References: <20230329115329.2747724-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

Signed-off-by: James Clark <james.clark@arm.com>
---
 drivers/hwtracing/coresight/coresight-core.c | 72 +++++++-------------
 1 file changed, 26 insertions(+), 46 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 389f6203c8f0..2f4aa15ef8f9 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -1316,38 +1316,42 @@ static int coresight_orphan_match(struct device *dev, void *data)
 {
 	int i, ret = 0;
 	bool still_orphan = false;
-	struct coresight_device *csdev, *i_csdev;
+	struct coresight_device *csdev = data;
+	struct coresight_device *i_csdev = to_coresight_device(dev);
 	struct coresight_connection *conn;
 
-	csdev = data;
-	i_csdev = to_coresight_device(dev);
-
-	/* No need to check oneself */
-	if (csdev == i_csdev)
-		return 0;
-
 	/* Move on to another component if no connection is orphan */
 	if (!i_csdev->orphan)
 		return 0;
 	/*
-	 * Circle throuch all the connection of that component.  If we find
+	 * Circle through all the connections of that component.  If we find
 	 * an orphan connection whose name matches @csdev, link it.
 	 */
 	for (i = 0; i < i_csdev->pdata->nr_outconns; i++) {
 		conn = i_csdev->pdata->out_conns[i];
 
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
+		/* Skip the port if it's already connected. */
+		if (conn->dest_dev)
+			continue;
+
+		/*
+		 * When connecting the newly registered device, we need to find
+		 * the remote instead of using the *data shortcut that avoids
+		 * the need for this search.
+		 */
+		if (csdev == i_csdev)
+			csdev = coresight_find_csdev_by_fwnode(
+				conn->dest_fwnode);
+
+		/* Does it match this newly added device? */
+		if (csdev && conn->dest_fwnode == csdev->dev.fwnode) {
+			ret = coresight_make_links(i_csdev, conn, csdev);
+			if (ret)
+				return ret;
+
+		} else {
+			/* This component still has an orphan */
+			still_orphan = true;
 		}
 	}
 
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
@@ -1594,7 +1576,7 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 	csdev->subtype = desc->subtype;
 	csdev->ops = desc->ops;
 	csdev->access = desc->access;
-	csdev->orphan = false;
+	csdev->orphan = true;
 
 	csdev->dev.type = &coresight_dev_type[desc->type];
 	csdev->dev.groups = desc->groups;
@@ -1644,8 +1626,6 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 	registered = true;
 
 	ret = coresight_create_conns_sysfs_group(csdev);
-	if (!ret)
-		ret = coresight_fixup_device_conns(csdev);
 	if (!ret)
 		ret = coresight_fixup_orphan_conns(csdev);
 
-- 
2.34.1


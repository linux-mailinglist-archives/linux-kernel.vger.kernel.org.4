Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0911E6CD8DB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 13:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjC2Lyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 07:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjC2Lye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 07:54:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BABDC4C09
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 04:54:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 76E411570;
        Wed, 29 Mar 2023 04:54:59 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5E0A73F6C4;
        Wed, 29 Mar 2023 04:54:13 -0700 (PDT)
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
Subject: [PATCH v3 06/13] coresight: Fix loss of connection info when a module is unloaded
Date:   Wed, 29 Mar 2023 12:53:19 +0100
Message-Id: <20230329115329.2747724-7-james.clark@arm.com>
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

child_fwnode should be a read only property based on the DT. If it's
cleared on the parent device when a child is unloaded, then when the
child is loaded again the connection won't be remade.

child_dev should be cleared instead which signifies that the connection
should be remade when the child_fwnode registers a new coresight_device.

Similarly the reference count shouldn't be decremented as long as the
parent device exists. The correct place to drop the reference is in
coresight_release_platform_data() which is already done.

Signed-off-by: James Clark <james.clark@arm.com>
---
 drivers/hwtracing/coresight/coresight-core.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index bfe1b93aca4e..12cbb68e8e1c 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -1414,13 +1414,8 @@ static int coresight_remove_match(struct device *dev, void *data)
 		if (csdev->dev.fwnode == conn->dest_fwnode) {
 			iterator->orphan = true;
 			coresight_remove_links(iterator, conn);
-			/*
-			 * Drop the reference to the handle for the remote
-			 * device acquired in parsing the connections from
-			 * platform data.
-			 */
-			fwnode_handle_put(conn->dest_fwnode);
-			conn->dest_fwnode = NULL;
+
+			conn->dest_dev = NULL;
 			/* No need to continue */
 			break;
 		}
@@ -1553,7 +1548,6 @@ void coresight_release_platform_data(struct coresight_device *csdev,
 		 * is going away
 		 */
 		fwnode_handle_put(conns[i].dest_fwnode);
-		pdata->out_conns[i].dest_fwnode = NULL;
 	}
 	if (csdev)
 		coresight_remove_conns_sysfs_group(csdev);
-- 
2.34.1


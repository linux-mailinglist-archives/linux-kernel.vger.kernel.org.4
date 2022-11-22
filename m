Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1722B633BFC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 13:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbiKVMCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 07:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbiKVMC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 07:02:29 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B497B4E;
        Tue, 22 Nov 2022 04:02:26 -0800 (PST)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NGjXy2DrCzmW3s;
        Tue, 22 Nov 2022 20:01:54 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 20:02:24 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 22 Nov
 2022 20:02:24 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <andriy.shevchenko@linux.intel.com>, <djrscally@gmail.com>,
        <heikki.krogerus@linux.intel.com>, <sakari.ailus@linux.intel.com>,
        <gregkh@linuxfoundation.org>, <rafael@kernel.org>
Subject: [PATCH v2] device property: fix of node refcount leak in fwnode_graph_get_next_endpoint()
Date:   Tue, 22 Nov 2022 20:00:39 +0800
Message-ID: <20221122120039.760773-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'parent' returned by fwnode_graph_get_port_parent()
with refcount incremented when 'prev' is not null, it
needs be put when finish using it.

Because the parent is const, introduce a new variable to
store the returned fwnode, then put it before returning
from fwnode_graph_get_next_endpoint().

Fixes: b5b41ab6b0c1 ("device property: Check fwnode->secondary in fwnode_graph_get_next_endpoint()")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
v1 -> v2:
  Introduce a new variable to store the returned fwnode.
---
 drivers/base/property.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 2a5a37fcd998..7a32582aaca8 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -989,26 +989,32 @@ struct fwnode_handle *
 fwnode_graph_get_next_endpoint(const struct fwnode_handle *fwnode,
 			       struct fwnode_handle *prev)
 {
+	struct fwnode_handle *ep, *port_parent = NULL;
 	const struct fwnode_handle *parent;
-	struct fwnode_handle *ep;
 
 	/*
 	 * If this function is in a loop and the previous iteration returned
 	 * an endpoint from fwnode->secondary, then we need to use the secondary
 	 * as parent rather than @fwnode.
 	 */
-	if (prev)
-		parent = fwnode_graph_get_port_parent(prev);
-	else
+	if (prev) {
+		port_parent = fwnode_graph_get_port_parent(prev);
+		parent = port_parent;
+	} else {
 		parent = fwnode;
+	}
 	if (IS_ERR_OR_NULL(parent))
 		return NULL;
 
 	ep = fwnode_call_ptr_op(parent, graph_get_next_endpoint, prev);
-	if (ep)
+	if (ep) {
+		fwnode_handle_put(port_parent);
 		return ep;
+	}
 
-	return fwnode_graph_get_next_endpoint(parent->secondary, NULL);
+	ep = fwnode_graph_get_next_endpoint(parent->secondary, NULL);
+	fwnode_handle_put(port_parent);
+	return ep;
 }
 EXPORT_SYMBOL_GPL(fwnode_graph_get_next_endpoint);
 
-- 
2.25.1


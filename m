Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E02F6319CF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 07:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiKUGmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 01:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiKUGmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 01:42:44 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A0A10BA;
        Sun, 20 Nov 2022 22:42:33 -0800 (PST)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NFyVP0QgDzRpPK;
        Mon, 21 Nov 2022 14:42:05 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 14:42:31 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 21 Nov
 2022 14:42:31 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <andriy.shevchenko@linux.intel.com>, <djrscally@gmail.com>,
        <heikki.krogerus@linux.intel.com>, <sakari.ailus@linux.intel.com>,
        <gregkh@linuxfoundation.org>, <rafael@kernel.org>
Subject: [PATCH] device property: fix of node refcount leak in fwnode_graph_get_next_endpoint()
Date:   Mon, 21 Nov 2022 14:40:49 +0800
Message-ID: <20221121064049.1173345-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'parent' returned by fwnode_graph_get_port_parent() with refcount
incremented when prev is not null, it needs be put when finish using
it.

Fixes: b5b41ab6b0c1 ("device property: Check fwnode->secondary in fwnode_graph_get_next_endpoint()")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/base/property.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 2a5a37fcd998..022d4ff366be 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1005,10 +1005,16 @@ fwnode_graph_get_next_endpoint(const struct fwnode_handle *fwnode,
 		return NULL;
 
 	ep = fwnode_call_ptr_op(parent, graph_get_next_endpoint, prev);
-	if (ep)
+	if (ep) {
+		if (prev)
+			fwnode_handle_put((struct fwnode_handle *)parent);
 		return ep;
+	}
 
-	return fwnode_graph_get_next_endpoint(parent->secondary, NULL);
+	ep = fwnode_graph_get_next_endpoint(parent->secondary, NULL);
+	if (prev)
+		fwnode_handle_put((struct fwnode_handle *)parent);
+	return ep;
 }
 EXPORT_SYMBOL_GPL(fwnode_graph_get_next_endpoint);
 
-- 
2.25.1


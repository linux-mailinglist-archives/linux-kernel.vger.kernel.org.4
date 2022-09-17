Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58DF5BB7CB
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 12:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbiIQKct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 06:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiIQKc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 06:32:27 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21C031367;
        Sat, 17 Sep 2022 03:32:24 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MV6Zm3sbVzMmxh;
        Sat, 17 Sep 2022 18:27:44 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500004.china.huawei.com
 (7.192.104.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 17 Sep
 2022 18:32:22 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <martin.petersen@oracle.com>, <jejb@linux.ibm.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hare@suse.com>, <hch@lst.de>, <bvanassche@acm.org>,
        <john.garry@huawei.com>, <jinpu.wang@cloud.ionos.com>,
        Jason Yan <yanaijie@huawei.com>
Subject: [PATCH 2/7] scsi: libsas: use dev_and_phy_addr_same() instead of open coded
Date:   Sat, 17 Sep 2022 18:43:06 +0800
Message-ID: <20220917104311.1878250-3-yanaijie@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220917104311.1878250-1-yanaijie@huawei.com>
References: <20220917104311.1878250-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500004.china.huawei.com (7.192.104.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sas address comparation of domain device and expander phy is open
coded. Now we can replace it with dev_and_phy_addr_same().

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/scsi/libsas/sas_expander.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index fa2209080cc2..dbf9ffa8367c 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -738,9 +738,7 @@ static void sas_ex_get_linkrate(struct domain_device *parent,
 		    phy->phy_state == PHY_NOT_PRESENT)
 			continue;
 
-		if (SAS_ADDR(phy->attached_sas_addr) ==
-		    SAS_ADDR(child->sas_addr)) {
-
+		if (dev_and_phy_addr_same(child, phy)) {
 			child->min_linkrate = min(parent->min_linkrate,
 						  phy->linkrate);
 			child->max_linkrate = max(parent->max_linkrate,
@@ -1012,8 +1010,7 @@ static int sas_ex_discover_dev(struct domain_device *dev, int phy_id)
 		sas_add_parent_port(dev, phy_id);
 		return 0;
 	}
-	if (dev->parent && (SAS_ADDR(ex_phy->attached_sas_addr) ==
-			    SAS_ADDR(dev->parent->sas_addr))) {
+	if (dev->parent && dev_and_phy_addr_same(dev->parent, ex_phy)) {
 		sas_add_parent_port(dev, phy_id);
 		if (ex_phy->routing_attr == TABLE_ROUTING)
 			sas_configure_phy(dev, phy_id, dev->port->sas_addr, 1);
@@ -1312,7 +1309,7 @@ static int sas_check_parent_topology(struct domain_device *child)
 		    parent_phy->phy_state == PHY_NOT_PRESENT)
 			continue;
 
-		if (SAS_ADDR(parent_phy->attached_sas_addr) != SAS_ADDR(child->sas_addr))
+		if (dev_and_phy_addr_same(child, parent_phy))
 			continue;
 
 		child_phy = &child_ex->ex_phy[parent_phy->attached_phy_id];
@@ -1522,8 +1519,7 @@ static int sas_configure_parent(struct domain_device *parent,
 		struct ex_phy *phy = &ex_parent->ex_phy[i];
 
 		if ((phy->routing_attr == TABLE_ROUTING) &&
-		    (SAS_ADDR(phy->attached_sas_addr) ==
-		     SAS_ADDR(child->sas_addr))) {
+		    dev_and_phy_addr_same(child, phy)) {
 			res = sas_configure_phy(parent, i, sas_addr, include);
 			if (res)
 				return res;
@@ -1858,8 +1854,7 @@ static void sas_unregister_devs_sas_addr(struct domain_device *parent,
 	if (last) {
 		list_for_each_entry_safe(child, n,
 			&ex_dev->children, siblings) {
-			if (SAS_ADDR(child->sas_addr) ==
-			    SAS_ADDR(phy->attached_sas_addr)) {
+			if (dev_and_phy_addr_same(child, phy)) {
 				set_bit(SAS_DEV_GONE, &child->state);
 				if (dev_is_expander(child->dev_type))
 					sas_unregister_ex_tree(parent->port, child);
@@ -1941,8 +1936,7 @@ static int sas_discover_new(struct domain_device *dev, int phy_id)
 	if (res)
 		return res;
 	list_for_each_entry(child, &dev->ex_dev.children, siblings) {
-		if (SAS_ADDR(child->sas_addr) ==
-		    SAS_ADDR(ex_phy->attached_sas_addr)) {
+		if (dev_and_phy_addr_same(child, ex_phy)) {
 			if (dev_is_expander(child->dev_type))
 				res = sas_discover_bfs_by_root(child);
 			break;
-- 
2.31.1


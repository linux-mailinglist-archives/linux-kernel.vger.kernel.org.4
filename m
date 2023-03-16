Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4648C6BC712
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 08:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjCPHaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 03:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjCPHaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 03:30:06 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F296341B6F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 00:30:02 -0700 (PDT)
X-UUID: 40cf4c80c3ca11ed91027fb02e0f1d65-20230316
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=yk/jNbxXPIJjagKiNGJc8Kt765xoLiABwlA5tGTLv20=;
        b=dOMx0xSwDf6QGFDpogC7ZL0m1CDIekO1v7jYbEpMUq1u3ivmhr2+Tw5qeTWwnSlOuYeX//87ChFsl/3fS9kFwuM2VOoO1I08mufW4Sq1RtO67JoF09Qj+GYDdRfKmvInFuaGP4DqTyv7mPYG8IQ6X2B/BmbFzwo+Y+oHVi6jTIQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.21,REQID:a98ef712-6e7f-4451-a4d2-7b318175bcb2,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.21,REQID:a98ef712-6e7f-4451-a4d2-7b318175bcb2,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:83295aa,CLOUDID:2c4a6db3-beed-4dfc-bd9c-e1b22fa6ccc4,B
        ulkID:2303161514554FYIEAP5,BulkQuantity:0,Recheck:0,SF:29|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 40cf4c80c3ca11ed91027fb02e0f1d65-20230316
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 566233247; Thu, 16 Mar 2023 15:14:55 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Thu, 16 Mar 2023 15:14:54 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Thu, 16 Mar 2023 15:14:53 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: [PATCH v9 1/2] phy: core: add debugfs files
Date:   Thu, 16 Mar 2023 15:14:51 +0800
Message-ID: <20230316071452.9161-1-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a debugfs root for phy class, and create a debugfs directory under
the root when create phy, then phy drivers can add debugfs files.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v9: create a 'phy' debugfs root, add a debugfs entry in struct phy suggested by Vinod;

No v8 sent out;

v2~v7: no changes
---
 drivers/phy/phy-core.c  | 14 ++++++++++++++
 include/linux/phy/phy.h |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 9951efc03eaa..05715352881e 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -11,6 +11,7 @@
 #include <linux/export.h>
 #include <linux/module.h>
 #include <linux/err.h>
+#include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/of.h>
@@ -20,6 +21,7 @@
 #include <linux/regulator/consumer.h>
 
 static struct class *phy_class;
+static struct dentry *phy_debugfs_root;
 static DEFINE_MUTEX(phy_provider_mutex);
 static LIST_HEAD(phy_provider_list);
 static LIST_HEAD(phys);
@@ -996,6 +998,8 @@ struct phy *phy_create(struct device *dev, struct device_node *node,
 		pm_runtime_no_callbacks(&phy->dev);
 	}
 
+	phy->debugfs = debugfs_create_dir(dev_name(&phy->dev), phy_debugfs_root);
+
 	return phy;
 
 put_dev:
@@ -1226,6 +1230,7 @@ static void phy_release(struct device *dev)
 
 	phy = to_phy(dev);
 	dev_vdbg(dev, "releasing '%s'\n", dev_name(dev));
+	debugfs_remove_recursive(phy->debugfs);
 	regulator_put(phy->pwr);
 	ida_simple_remove(&phy_ida, phy->id);
 	kfree(phy);
@@ -1242,6 +1247,15 @@ static int __init phy_core_init(void)
 
 	phy_class->dev_release = phy_release;
 
+	phy_debugfs_root = debugfs_create_dir("phy", NULL);
+
 	return 0;
 }
 device_initcall(phy_core_init);
+
+static void __exit phy_core_exit(void)
+{
+	debugfs_remove_recursive(phy_debugfs_root);
+	class_destroy(phy_class);
+}
+module_exit(phy_core_exit);
diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index 3a570bc59fc7..f6d607ef0e80 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -148,6 +148,7 @@ struct phy_attrs {
  * @power_count: used to protect when the PHY is used by multiple consumers
  * @attrs: used to specify PHY specific attributes
  * @pwr: power regulator associated with the phy
+ * @debugfs: debugfs directory
  */
 struct phy {
 	struct device		dev;
@@ -158,6 +159,7 @@ struct phy {
 	int			power_count;
 	struct phy_attrs	attrs;
 	struct regulator	*pwr;
+	struct dentry		*debugfs;
 };
 
 /**
-- 
2.18.0


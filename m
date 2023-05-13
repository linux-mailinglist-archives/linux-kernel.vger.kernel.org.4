Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5BA701595
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 11:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237569AbjEMJWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 05:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbjEMJW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 05:22:29 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249E3448A
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 02:22:24 -0700 (PDT)
X-UUID: a9e0c230f16f11ed9cb5633481061a41-20230513
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=5Kkxf3BPerLuhz2Tiv7w0gG5pbHJwAtXbjBqeS8LbOE=;
        b=iRxb/Qkb2jdO0DTfQiPrY0Y6ScFY4yazVQ12kneqSybw/ADJq43Vt4ZfwoTLsY27rAyBrXQcnBbxySLF2Ob7t2mOsMUJ3B2sMFWowvSqO7LOSP23YvMa+YvgAoLFQ51Uz4WQZG0A2x0f3ejclb1EI3Maj5BSM9NFkMVEoXqVBfo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.24,REQID:9d5e97db-597b-4fdc-b15c-a8ab692da25b,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:100
X-CID-INFO: VERSION:1.1.24,REQID:9d5e97db-597b-4fdc-b15c-a8ab692da25b,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:100
X-CID-META: VersionHash:178d4d4,CLOUDID:7410b7c0-e32c-4c97-918d-fbb3fc224d4e,B
        ulkID:230513172222B47BHOAL,BulkQuantity:0,Recheck:0,SF:17|19|48|29|28,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: a9e0c230f16f11ed9cb5633481061a41-20230513
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 794918871; Sat, 13 May 2023 17:22:21 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 13 May 2023 17:22:19 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 13 May 2023 17:22:19 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND v9 1/2] phy: core: add debugfs files
Date:   Sat, 13 May 2023 17:22:17 +0800
Message-ID: <20230513092218.21139-1-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
index 6464dcb56d56..96a0b1e111f3 100644
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


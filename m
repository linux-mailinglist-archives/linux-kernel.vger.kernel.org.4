Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF955EF008
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 10:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235408AbiI2IJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 04:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234953AbiI2IJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:09:45 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79D01277C
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 01:09:40 -0700 (PDT)
X-UUID: 4f1e2dbfe9214f9ca69568ed2ae6302d-20220929
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=6/aL/tySIJ4vn6EYApzN8xabXPa2bykp5V8nuDfj/xU=;
        b=VDn23JKkM9TjDfMmZsPFY296cNsJVuUqDt+DPbJ9MCh7/NeENa5qRuQrnxI1J09EzrsUiapJv6XQflaC7rYQt+E8dQuyGl4wvJilMa2kHQejYlx8nCIh1G5aPIJdszN7DkbJfTwnuzw/zQ3JWwx2zDfSDxlaU1Gkiv/XHy7mujg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:a66ca3a7-0d5b-4a1a-a251-436337d1ed1a,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.11,REQID:a66ca3a7-0d5b-4a1a-a251-436337d1ed1a,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:39a5ff1,CLOUDID:c2916c07-1cee-4c38-b21b-a45f9682fdc0,B
        ulkID:220929160936NQABT6K8,BulkQuantity:0,Recheck:0,SF:28|17|19|48|823|824
        ,TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,
        COL:0
X-UUID: 4f1e2dbfe9214f9ca69568ed2ae6302d-20220929
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 599145088; Thu, 29 Sep 2022 16:09:35 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 29 Sep 2022 16:09:34 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Thu, 29 Sep 2022 16:09:33 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Tianping Fang <tianping.fang@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 1/2] phy: core: add debugfs root
Date:   Thu, 29 Sep 2022 16:09:25 +0800
Message-ID: <20220929080926.1272-1-chunfeng.yun@mediatek.com>
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

Add a debugfs root for phy class, then phy drivers can add debugfs files
under this folder.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2: no changes
---
 drivers/phy/phy-core.c  | 6 ++++++
 include/linux/phy/phy.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index d93ddf1262c5..2f9f69190519 100644
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
@@ -1204,6 +1205,9 @@ void devm_of_phy_provider_unregister(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_of_phy_provider_unregister);
 
+struct dentry *phy_debug_root;
+EXPORT_SYMBOL_GPL(phy_debug_root);
+
 /**
  * phy_release() - release the phy
  * @dev: the dev member within phy
@@ -1233,6 +1237,8 @@ static int __init phy_core_init(void)
 
 	phy_class->dev_release = phy_release;
 
+	phy_debug_root = debugfs_create_dir("phy", NULL);
+
 	return 0;
 }
 device_initcall(phy_core_init);
diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index b1413757fcc3..c398749d49b9 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -205,6 +205,8 @@ struct phy_lookup {
 #define devm_of_phy_provider_register_full(dev, children, xlate) \
 	__devm_of_phy_provider_register(dev, children, THIS_MODULE, xlate)
 
+extern struct dentry *phy_debug_root;
+
 static inline void phy_set_drvdata(struct phy *phy, void *data)
 {
 	dev_set_drvdata(&phy->dev, data);
-- 
2.18.0


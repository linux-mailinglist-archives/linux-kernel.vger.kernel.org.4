Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A99269DB5E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 08:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbjBUHmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 02:42:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbjBUHmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 02:42:02 -0500
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACEC2725
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 23:42:00 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VcBNpl2_1676965304;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VcBNpl2_1676965304)
          by smtp.aliyun-inc.com;
          Tue, 21 Feb 2023 15:41:57 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     vkoul@kernel.org
Cc:     kishon@kernel.org, heiko@sntech.de, p.zabel@pengutronix.de,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] phy: rockchip-pcie: Remove the unused function phy_wr_cfg()
Date:   Tue, 21 Feb 2023 15:41:42 +0800
Message-Id: <20230221074142.5935-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function phy_wr_cfg is defined in the phy-rockchip-pcie.c file, but
not called elsewhere, so remove this unused function.

drivers/phy/rockchip/phy-rockchip-pcie.c:122:19: warning: unused function 'phy_rd_cfg'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4130
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/phy/rockchip/phy-rockchip-pcie.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-pcie.c b/drivers/phy/rockchip/phy-rockchip-pcie.c
index 75216091d901..8234b83fdd88 100644
--- a/drivers/phy/rockchip/phy-rockchip-pcie.c
+++ b/drivers/phy/rockchip/phy-rockchip-pcie.c
@@ -119,21 +119,6 @@ static inline void phy_wr_cfg(struct rockchip_pcie_phy *rk_phy,
 				   PHY_CFG_WR_SHIFT));
 }
 
-static inline u32 phy_rd_cfg(struct rockchip_pcie_phy *rk_phy,
-			     u32 addr)
-{
-	u32 val;
-
-	regmap_write(rk_phy->reg_base, rk_phy->phy_data->pcie_conf,
-		     HIWORD_UPDATE(addr,
-				   PHY_CFG_RD_MASK,
-				   PHY_CFG_ADDR_SHIFT));
-	regmap_read(rk_phy->reg_base,
-		    rk_phy->phy_data->pcie_status,
-		    &val);
-	return val;
-}
-
 static int rockchip_pcie_phy_power_off(struct phy *phy)
 {
 	struct phy_pcie_instance *inst = phy_get_drvdata(phy);
-- 
2.20.1.7.g153144c


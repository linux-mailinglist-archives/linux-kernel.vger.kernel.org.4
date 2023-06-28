Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E4874089F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 04:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbjF1Cpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 22:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbjF1Cpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 22:45:30 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 6CA942D4E;
        Tue, 27 Jun 2023 19:45:22 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id E5116604D9369;
        Wed, 28 Jun 2023 10:45:18 +0800 (CST)
X-MD-Sfrom: yunchuan@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   wuych <yunchuan@nfschina.com>
To:     iyappan@os.amperecomputing.com, keyur@os.amperecomputing.com,
        quan@os.amperecomputing.com, andrew@lunn.ch, hkallweit1@gmail.com,
        linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, wuych <yunchuan@nfschina.com>
Subject: [PATCH net-next 08/10] net: mdio: Remove unnecessary (void*) conversions
Date:   Wed, 28 Jun 2023 10:45:17 +0800
Message-Id: <20230628024517.1440644-1-yunchuan@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pointer variables of void * type do not require type cast.

Signed-off-by: wuych <yunchuan@nfschina.com>
---
 drivers/net/mdio/mdio-xgene.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/mdio/mdio-xgene.c b/drivers/net/mdio/mdio-xgene.c
index 7aafc221b5cf..aa79464c9d6d 100644
--- a/drivers/net/mdio/mdio-xgene.c
+++ b/drivers/net/mdio/mdio-xgene.c
@@ -79,7 +79,7 @@ EXPORT_SYMBOL(xgene_mdio_wr_mac);
 
 int xgene_mdio_rgmii_read(struct mii_bus *bus, int phy_id, int reg)
 {
-	struct xgene_mdio_pdata *pdata = (struct xgene_mdio_pdata *)bus->priv;
+	struct xgene_mdio_pdata *pdata = bus->priv;
 	u32 data, done;
 	u8 wait = 10;
 
@@ -105,7 +105,7 @@ EXPORT_SYMBOL(xgene_mdio_rgmii_read);
 
 int xgene_mdio_rgmii_write(struct mii_bus *bus, int phy_id, int reg, u16 data)
 {
-	struct xgene_mdio_pdata *pdata = (struct xgene_mdio_pdata *)bus->priv;
+	struct xgene_mdio_pdata *pdata = bus->priv;
 	u32 val, done;
 	u8 wait = 10;
 
@@ -211,7 +211,7 @@ static void xgene_enet_wr_mdio_csr(void __iomem *base_addr,
 static int xgene_xfi_mdio_write(struct mii_bus *bus, int phy_id,
 				int reg, u16 data)
 {
-	void __iomem *addr = (void __iomem *)bus->priv;
+	void __iomem *addr = bus->priv;
 	int timeout = 100;
 	u32 status, val;
 
@@ -234,7 +234,7 @@ static int xgene_xfi_mdio_write(struct mii_bus *bus, int phy_id,
 
 static int xgene_xfi_mdio_read(struct mii_bus *bus, int phy_id, int reg)
 {
-	void __iomem *addr = (void __iomem *)bus->priv;
+	void __iomem *addr = bus->priv;
 	u32 data, status, val;
 	int timeout = 100;
 
-- 
2.30.2


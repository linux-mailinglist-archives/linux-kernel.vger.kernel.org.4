Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A833E74CD4B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 08:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbjGJGlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 02:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjGJGlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 02:41:05 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 88985185;
        Sun,  9 Jul 2023 23:41:01 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 4D6C8602A8713;
        Mon, 10 Jul 2023 14:40:57 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
To:     yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, wuych <yunchuan@nfschina.com>
Subject: [PATCH net-next v2 05/10] net: hns: Remove unnecessary (void*) conversions
Date:   Mon, 10 Jul 2023 14:40:53 +0800
Message-Id: <20230710064053.173486-1-suhui@nfschina.com>
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

From: wuych <yunchuan@nfschina.com>

Pointer variables of void * type do not require type cast.

Signed-off-by: wuych <yunchuan@nfschina.com>
---
 drivers/net/ethernet/hisilicon/hns_mdio.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns_mdio.c b/drivers/net/ethernet/hisilicon/hns_mdio.c
index 9232caaf0bdc..409a89d80220 100644
--- a/drivers/net/ethernet/hisilicon/hns_mdio.c
+++ b/drivers/net/ethernet/hisilicon/hns_mdio.c
@@ -217,7 +217,7 @@ static void hns_mdio_cmd_write(struct hns_mdio_device *mdio_dev,
 static int hns_mdio_write_c22(struct mii_bus *bus,
 			      int phy_id, int regnum, u16 data)
 {
-	struct hns_mdio_device *mdio_dev = (struct hns_mdio_device *)bus->priv;
+	struct hns_mdio_device *mdio_dev = bus->priv;
 	u16 reg = (u16)(regnum & 0xffff);
 	u16 cmd_reg_cfg;
 	int ret;
@@ -259,7 +259,7 @@ static int hns_mdio_write_c22(struct mii_bus *bus,
 static int hns_mdio_write_c45(struct mii_bus *bus, int phy_id, int devad,
 			      int regnum, u16 data)
 {
-	struct hns_mdio_device *mdio_dev = (struct hns_mdio_device *)bus->priv;
+	struct hns_mdio_device *mdio_dev = bus->priv;
 	u16 reg = (u16)(regnum & 0xffff);
 	u16 cmd_reg_cfg;
 	int ret;
@@ -312,7 +312,7 @@ static int hns_mdio_write_c45(struct mii_bus *bus, int phy_id, int devad,
  */
 static int hns_mdio_read_c22(struct mii_bus *bus, int phy_id, int regnum)
 {
-	struct hns_mdio_device *mdio_dev = (struct hns_mdio_device *)bus->priv;
+	struct hns_mdio_device *mdio_dev = bus->priv;
 	u16 reg = (u16)(regnum & 0xffff);
 	u16 reg_val;
 	int ret;
@@ -363,7 +363,7 @@ static int hns_mdio_read_c22(struct mii_bus *bus, int phy_id, int regnum)
 static int hns_mdio_read_c45(struct mii_bus *bus, int phy_id, int devad,
 			     int regnum)
 {
-	struct hns_mdio_device *mdio_dev = (struct hns_mdio_device *)bus->priv;
+	struct hns_mdio_device *mdio_dev = bus->priv;
 	u16 reg = (u16)(regnum & 0xffff);
 	u16 reg_val;
 	int ret;
@@ -424,7 +424,7 @@ static int hns_mdio_read_c45(struct mii_bus *bus, int phy_id, int devad,
  */
 static int hns_mdio_reset(struct mii_bus *bus)
 {
-	struct hns_mdio_device *mdio_dev = (struct hns_mdio_device *)bus->priv;
+	struct hns_mdio_device *mdio_dev = bus->priv;
 	const struct hns_mdio_sc_reg *sc_reg;
 	int ret;
 
-- 
2.30.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A686AF7C6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 22:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjCGVia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 16:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjCGVi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 16:38:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FB085A6B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 13:38:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 52810B81A3A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 21:38:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5B56C433EF;
        Tue,  7 Mar 2023 21:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678225101;
        bh=OuCk13GKx8zSj9WTb+0ihTNhjFcp1ekBTWkWWYT/Y4s=;
        h=From:To:Cc:Subject:Date:From;
        b=PLYFNPMB/jr1V2JMqYMeh96V0kjYqpYrt8Rhz1j8YqbHUjpKhoVOuYzb+b8TlUiv0
         QlWndw+NEhJve8bmekXYdXzsVH7FHRNdwbUTmDyDZnLNHMpKipNAHuLpTtYISAPJAA
         QQBBLlv/B++mIBg10cxl8JHAWyhpneHOskqAKMG9JuCA1UIO8cgju9gwwiIn5LmFY+
         4g/DHdags4Os4328y5ZI3TCoIUJOP75hgWXcciPb151pLSVxjAn93hl+Jp/IHrWBkD
         f0b4697iV9fgJQo7KP4ADaVV7i+e+l0AAjmTaDT6Mwk2bdsj6gmqPCm9htt0GXvJBt
         +WLiO64T+1BPQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>, Greg@vger.kernel.org,
        Kroah-Hartman@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH] misc: alcor_pci: Use PCI core to manage ASPM instead of open-coding
Date:   Tue,  7 Mar 2023 15:38:16 -0600
Message-Id: <20230307213816.886308-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

"priv->ext_config_dev_aspm" was never set to a non-zero value.  Therefore,
alcor_pci_aspm_ctrl(priv, 1) did nothing, and alcor_pci_aspm_ctrl(priv, 0)
always disabled ASPM in the device and the upstream bridge.

The driver disabled ASPM in alcor_pci_probe() and alcor_resume(), so it's
possible the device doesn't work well when ASPM is enabled.

Remove all the ASPM-related code and replace the alcor_pci_aspm_ctrl(0)
calls with pci_disable_link_state(pdev, PCIE_LINK_STATE_L0S |
PCIE_LINK_STATE_L1), which asks the PCI core to disable ASPM.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/misc/cardreader/alcor_pci.c | 144 +---------------------------
 include/linux/alcor_pci.h           |   7 --
 2 files changed, 4 insertions(+), 147 deletions(-)

diff --git a/drivers/misc/cardreader/alcor_pci.c b/drivers/misc/cardreader/alcor_pci.c
index 9080f9f150a2..5b637171c46c 100644
--- a/drivers/misc/cardreader/alcor_pci.c
+++ b/drivers/misc/cardreader/alcor_pci.c
@@ -95,137 +95,6 @@ u32 alcor_read32be(struct alcor_pci_priv *priv, unsigned int addr)
 }
 EXPORT_SYMBOL_GPL(alcor_read32be);
 
-static int alcor_pci_find_cap_offset(struct alcor_pci_priv *priv,
-				     struct pci_dev *pci)
-{
-	int where;
-	u8 val8;
-	u32 val32;
-
-	where = ALCOR_CAP_START_OFFSET;
-	pci_read_config_byte(pci, where, &val8);
-	if (!val8)
-		return 0;
-
-	where = (int)val8;
-	while (1) {
-		pci_read_config_dword(pci, where, &val32);
-		if (val32 == 0xffffffff) {
-			dev_dbg(priv->dev, "find_cap_offset invalid value %x.\n",
-				val32);
-			return 0;
-		}
-
-		if ((val32 & 0xff) == 0x10) {
-			dev_dbg(priv->dev, "pcie cap offset: %x\n", where);
-			return where;
-		}
-
-		if ((val32 & 0xff00) == 0x00) {
-			dev_dbg(priv->dev, "pci_find_cap_offset invalid value %x.\n",
-				val32);
-			break;
-		}
-		where = (int)((val32 >> 8) & 0xff);
-	}
-
-	return 0;
-}
-
-static void alcor_pci_init_check_aspm(struct alcor_pci_priv *priv)
-{
-	struct pci_dev *pci;
-	int where;
-	u32 val32;
-
-	priv->pdev_cap_off    = alcor_pci_find_cap_offset(priv, priv->pdev);
-	/*
-	 * A device might be attached to root complex directly and
-	 * priv->parent_pdev will be NULL. In this case we don't check its
-	 * capability and disable ASPM completely.
-	 */
-	if (priv->parent_pdev)
-		priv->parent_cap_off = alcor_pci_find_cap_offset(priv,
-							 priv->parent_pdev);
-
-	if ((priv->pdev_cap_off == 0) || (priv->parent_cap_off == 0)) {
-		dev_dbg(priv->dev, "pci_cap_off: %x, parent_cap_off: %x\n",
-			priv->pdev_cap_off, priv->parent_cap_off);
-		return;
-	}
-
-	/* link capability */
-	pci   = priv->pdev;
-	where = priv->pdev_cap_off + ALCOR_PCIE_LINK_CAP_OFFSET;
-	pci_read_config_dword(pci, where, &val32);
-	priv->pdev_aspm_cap = (u8)(val32 >> 10) & 0x03;
-
-	pci   = priv->parent_pdev;
-	where = priv->parent_cap_off + ALCOR_PCIE_LINK_CAP_OFFSET;
-	pci_read_config_dword(pci, where, &val32);
-	priv->parent_aspm_cap = (u8)(val32 >> 10) & 0x03;
-
-	if (priv->pdev_aspm_cap != priv->parent_aspm_cap) {
-		u8 aspm_cap;
-
-		dev_dbg(priv->dev, "pdev_aspm_cap: %x, parent_aspm_cap: %x\n",
-			priv->pdev_aspm_cap, priv->parent_aspm_cap);
-		aspm_cap = priv->pdev_aspm_cap & priv->parent_aspm_cap;
-		priv->pdev_aspm_cap    = aspm_cap;
-		priv->parent_aspm_cap = aspm_cap;
-	}
-
-	dev_dbg(priv->dev, "ext_config_dev_aspm: %x, pdev_aspm_cap: %x\n",
-		priv->ext_config_dev_aspm, priv->pdev_aspm_cap);
-	priv->ext_config_dev_aspm &= priv->pdev_aspm_cap;
-}
-
-static void alcor_pci_aspm_ctrl(struct alcor_pci_priv *priv, u8 aspm_enable)
-{
-	struct pci_dev *pci;
-	u8 aspm_ctrl, i;
-	int where;
-	u32 val32;
-
-	if ((!priv->pdev_cap_off) || (!priv->parent_cap_off)) {
-		dev_dbg(priv->dev, "pci_cap_off: %x, parent_cap_off: %x\n",
-			priv->pdev_cap_off, priv->parent_cap_off);
-		return;
-	}
-
-	if (!priv->pdev_aspm_cap)
-		return;
-
-	aspm_ctrl = 0;
-	if (aspm_enable) {
-		aspm_ctrl = priv->ext_config_dev_aspm;
-
-		if (!aspm_ctrl) {
-			dev_dbg(priv->dev, "aspm_ctrl == 0\n");
-			return;
-		}
-	}
-
-	for (i = 0; i < 2; i++) {
-
-		if (i) {
-			pci   = priv->parent_pdev;
-			where = priv->parent_cap_off
-				+ ALCOR_PCIE_LINK_CTRL_OFFSET;
-		} else {
-			pci   = priv->pdev;
-			where = priv->pdev_cap_off
-				+ ALCOR_PCIE_LINK_CTRL_OFFSET;
-		}
-
-		pci_read_config_dword(pci, where, &val32);
-		val32 &= (~0x03);
-		val32 |= (aspm_ctrl & priv->pdev_aspm_cap);
-		pci_write_config_byte(pci, where, (u8)val32);
-	}
-
-}
-
 static inline void alcor_mask_sd_irqs(struct alcor_pci_priv *priv)
 {
 	alcor_write32(priv, 0, AU6601_REG_INT_ENABLE);
@@ -308,7 +177,6 @@ static int alcor_pci_probe(struct pci_dev *pdev,
 
 	pci_set_master(pdev);
 	pci_set_drvdata(pdev, priv);
-	alcor_pci_init_check_aspm(priv);
 
 	for (i = 0; i < ARRAY_SIZE(alcor_pci_cells); i++) {
 		alcor_pci_cells[i].platform_data = priv;
@@ -319,7 +187,7 @@ static int alcor_pci_probe(struct pci_dev *pdev,
 	if (ret < 0)
 		goto error_clear_drvdata;
 
-	alcor_pci_aspm_ctrl(priv, 0);
+	pci_disable_link_state(pdev, PCIE_LINK_STATE_L0S | PCIE_LINK_STATE_L1);
 
 	return 0;
 
@@ -339,8 +207,6 @@ static void alcor_pci_remove(struct pci_dev *pdev)
 
 	priv = pci_get_drvdata(pdev);
 
-	alcor_pci_aspm_ctrl(priv, 1);
-
 	mfd_remove_devices(&pdev->dev);
 
 	ida_free(&alcor_pci_idr, priv->id);
@@ -353,18 +219,16 @@ static void alcor_pci_remove(struct pci_dev *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int alcor_suspend(struct device *dev)
 {
-	struct alcor_pci_priv *priv = dev_get_drvdata(dev);
-
-	alcor_pci_aspm_ctrl(priv, 1);
 	return 0;
 }
 
 static int alcor_resume(struct device *dev)
 {
-
 	struct alcor_pci_priv *priv = dev_get_drvdata(dev);
 
-	alcor_pci_aspm_ctrl(priv, 0);
+	pci_disable_link_state(priv->pdev,
+			       PCIE_LINK_STATE_L0S | PCIE_LINK_STATE_L1);
+
 	return 0;
 }
 #endif /* CONFIG_PM_SLEEP */
diff --git a/include/linux/alcor_pci.h b/include/linux/alcor_pci.h
index 8274ed525e9f..c4a0b23846d8 100644
--- a/include/linux/alcor_pci.h
+++ b/include/linux/alcor_pci.h
@@ -268,13 +268,6 @@ struct alcor_pci_priv {
 	unsigned long id; /* idr id */
 
 	struct alcor_dev_cfg	*cfg;
-
-	/* PCI ASPM related vars */
-	int pdev_cap_off;
-	u8  pdev_aspm_cap;
-	int parent_cap_off;
-	u8  parent_aspm_cap;
-	u8 ext_config_dev_aspm;
 };
 
 void alcor_write8(struct alcor_pci_priv *priv, u8 val, unsigned int addr);
-- 
2.25.1


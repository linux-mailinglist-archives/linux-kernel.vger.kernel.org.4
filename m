Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C516966CE13
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 18:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235081AbjAPRxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 12:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234911AbjAPRwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 12:52:46 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3453B667
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 09:35:08 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id bf43so43673890lfb.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 09:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/pYK289ULrgsf/Jk8COetz13qlDoBjNKsMyxX7loUDw=;
        b=pKr/SoBpM/X64xXxDigtMbtty8+VxmqTToE5Vgfyx5AgTZCZq/O/SbGt0/wX7GVCqH
         8Y352t1YrUJsUC0U0+XZJAKlfgZ9tIzBMz22FPxzGHFBmoZDXFHDjmZSgfLN4TyNUx2r
         cXHZT/0j+ulQkHENMfQFdztFPN+A4US4owf0UHcYCJsGcJySYx9metSlSm7XqrrBHdt+
         u6ICsAAbnmehCYG+qrRRkflgH1+EvK52yMd3UliLXV6qsGYsOV1GmJdkPHsl4Llphhs3
         rerp1uohcvhhRwacpNEAMJnFT3aYJqyvlm9IqrgjtIu7vyd0gmBoPRo9jXPJtFr/hesM
         yPdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/pYK289ULrgsf/Jk8COetz13qlDoBjNKsMyxX7loUDw=;
        b=c6O47BpvTi3/uisCTuxzbpPSHjFczQC3MMEPB2FABvy6VnfKimh/s0SJ2n0UqDcu49
         p0NyAZ49NUngfR/7iuDWc7o364l1/JvJpS+5iyVZl0wOrdhHtn0FqxIAdWjMZ59ugk4f
         rBfOSk3ge/rqzRdbAGA3nGEum2EwIHDzYyr6vhWDTL0mVYLPXar+9Xqk4czQ2NLP0pPY
         mor20Vn/jO+DzBBRRtViSmCIN0WIlXlJdPjSfbaUnZg9PYKUcuumWIY1i9QR7jV7zrz5
         Mgzgu/ftG31GsxBgwB+VP03sBL6Rjvs/RZVF3bP8UulrSuEK4fwqXVA3CMWtKHf92Iq2
         uFWw==
X-Gm-Message-State: AFqh2kpmHEgUAcoJkSx1/3Bph9vvoFo0Ackiad+TqZq3rxtPmhF8NFlP
        Xwfl3XoBTEu6Qx2m1yzfD0Hr4Gv3+k3cdLtP
X-Google-Smtp-Source: AMrXdXsKJwqskOP/by0HTMPg+FUXa81A0yDzLkE3gsr+Ks87ZDrAVUjBgQY8fXG4kCztFu/RTIIr8w==
X-Received: by 2002:a19:f514:0:b0:4b5:61e8:8934 with SMTP id j20-20020a19f514000000b004b561e88934mr23683566lfb.64.1673890507730;
        Mon, 16 Jan 2023 09:35:07 -0800 (PST)
Received: from gilgamesh.lab.semihalf.net ([83.142.187.85])
        by smtp.gmail.com with ESMTPSA id k20-20020a2e8894000000b0028b7f51414fsm707333lji.80.2023.01.16.09.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 09:35:07 -0800 (PST)
From:   Marcin Wojtas <mw@semihalf.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     rafael@kernel.org, andriy.shevchenko@linux.intel.com,
        sean.wang@mediatek.com, Landen.Chao@mediatek.com,
        linus.walleij@linaro.org, andrew@lunn.ch, vivien.didelot@gmail.com,
        f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linux@armlinux.org.uk, hkallweit1@gmail.com, mw@semihalf.com,
        jaz@semihalf.com, tn@semihalf.com, Samer.El-Haj-Mahmoud@arm.com
Subject: [net-next: PATCH v4 8/8] net: dsa: mv88e6xxx: switch to device_/fwnode_ APIs
Date:   Mon, 16 Jan 2023 18:34:20 +0100
Message-Id: <20230116173420.1278704-9-mw@semihalf.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20230116173420.1278704-1-mw@semihalf.com>
References: <20230116173420.1278704-1-mw@semihalf.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to support both DT and ACPI in future, modify the
mv88e6xx driver  code to use device_/fwnode_ equivalent routines.
No functional change is introduced by this patch.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 41 +++++++++-----------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 6731597bded0..1f1dd3dd4012 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -3932,10 +3932,11 @@ static int mv88e6xxx_mdio_write_c45(struct mii_bus *bus, int phy, int devad,
 }
 
 static int mv88e6xxx_mdio_register(struct mv88e6xxx_chip *chip,
-				   struct device_node *np,
+				   struct fwnode_handle *fwnode,
 				   bool external)
 {
 	static int index;
+	struct device_node *np = to_of_node(fwnode);
 	struct mv88e6xxx_mdio_bus *mdio_bus;
 	struct mii_bus *bus;
 	int err;
@@ -4016,18 +4017,18 @@ static void mv88e6xxx_mdios_unregister(struct mv88e6xxx_chip *chip)
 }
 
 static int mv88e6xxx_mdios_register(struct mv88e6xxx_chip *chip,
-				    struct device_node *np)
+				    struct fwnode_handle *fwnode)
 {
-	struct device_node *child;
+	struct fwnode_handle *child;
 	int err;
 
 	/* Always register one mdio bus for the internal/default mdio
 	 * bus. This maybe represented in the device tree, but is
 	 * optional.
 	 */
-	child = of_get_child_by_name(np, "mdio");
+	child = fwnode_get_named_child_node(fwnode, "mdio");
 	err = mv88e6xxx_mdio_register(chip, child, false);
-	of_node_put(child);
+	fwnode_handle_put(child);
 	if (err)
 		return err;
 
@@ -4035,13 +4036,13 @@ static int mv88e6xxx_mdios_register(struct mv88e6xxx_chip *chip,
 	 * which say they are compatible with the external mdio
 	 * bus.
 	 */
-	for_each_available_child_of_node(np, child) {
-		if (of_device_is_compatible(
-			    child, "marvell,mv88e6xxx-mdio-external")) {
+	fwnode_for_each_available_child_node(fwnode, child) {
+		if (fwnode_property_match_string(child, "compatible",
+						 "marvell,mv88e6xxx-mdio-external") == 0) {
 			err = mv88e6xxx_mdio_register(chip, child, true);
 			if (err) {
 				mv88e6xxx_mdios_unregister(chip);
-				of_node_put(child);
+				fwnode_handle_put(child);
 				return err;
 			}
 		}
@@ -7096,18 +7097,14 @@ static int mv88e6xxx_probe(struct mdio_device *mdiodev)
 	struct dsa_mv88e6xxx_pdata *pdata = mdiodev->dev.platform_data;
 	const struct mv88e6xxx_info *compat_info = NULL;
 	struct device *dev = &mdiodev->dev;
-	struct device_node *np = dev->of_node;
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
 	struct mv88e6xxx_chip *chip;
 	int port;
 	int err;
 
-	if (!np && !pdata)
-		return -EINVAL;
-
-	if (np)
-		compat_info = of_device_get_match_data(dev);
+	compat_info = device_get_match_data(dev);
 
-	if (pdata) {
+	if (!compat_info && pdata) {
 		compat_info = pdata_device_get_match_data(dev);
 
 		if (!pdata->netdev)
@@ -7164,9 +7161,9 @@ static int mv88e6xxx_probe(struct mdio_device *mdiodev)
 	mv88e6xxx_phy_init(chip);
 
 	if (chip->info->ops->get_eeprom) {
-		if (np)
-			of_property_read_u32(np, "eeprom-length",
-					     &chip->eeprom_len);
+		if (fwnode)
+			device_property_read_u32(dev, "eeprom-length",
+						 &chip->eeprom_len);
 		else
 			chip->eeprom_len = pdata->eeprom_len;
 	}
@@ -7177,8 +7174,8 @@ static int mv88e6xxx_probe(struct mdio_device *mdiodev)
 	if (err)
 		goto out;
 
-	if (np) {
-		chip->irq = of_irq_get(np, 0);
+	if (fwnode) {
+		chip->irq = fwnode_irq_get(fwnode, 0);
 		if (chip->irq == -EPROBE_DEFER) {
 			err = chip->irq;
 			goto out;
@@ -7216,7 +7213,7 @@ static int mv88e6xxx_probe(struct mdio_device *mdiodev)
 	if (err)
 		goto out_g1_atu_prob_irq;
 
-	err = mv88e6xxx_mdios_register(chip, np);
+	err = mv88e6xxx_mdios_register(chip, fwnode);
 	if (err)
 		goto out_g1_vtu_prob_irq;
 
-- 
2.29.0


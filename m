Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773D9746A31
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 08:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjGDG7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 02:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjGDG7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 02:59:43 -0400
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BDC107
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 23:59:40 -0700 (PDT)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2023070406593938db8939be6d3a440a
        for <linux-kernel@vger.kernel.org>;
        Tue, 04 Jul 2023 08:59:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=michael.haener@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=naZsB+e+2/m4FNfzsyhDy9BbreIhpBNPwhPGxh/+8wk=;
 b=jfsgk4LxQW0tINDC2AhBc5k9yT1DmeALX45eXp5z8sMZvL85Z+BvmZL/dvFy2y84HAvaLC
 8ycK+RpWdDV4bChnGlHDeDjQD3rjY3VvVsx44d+MWxOqh7g1tDbpKf4vX0tQpjxfNNyOkGUt
 /cN8YPz7+dGan7v+Oae0Qy7eGsY6w=;
From:   "M. Haener" <michael.haener@siemens.com>
To:     netdev@vger.kernel.org
Cc:     Michael Haener <michael.haener@siemens.com>,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexander Sverdlin <alexander.sverdlin@siemens.com>
Subject: [PATCH v2 2/3] net: dsa: mv88e632x: Refactor serdes write
Date:   Tue,  4 Jul 2023 08:59:05 +0200
Message-ID: <20230704065916.132486-3-michael.haener@siemens.com>
In-Reply-To: <20230704065916.132486-1-michael.haener@siemens.com>
References: <20230704065916.132486-1-michael.haener@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-664519:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Haener <michael.haener@siemens.com>

To avoid code duplication, the serdes write functions
have been combined.

Signed-off-by: Michael Haener <michael.haener@siemens.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c   |  4 ++++
 drivers/net/dsa/mv88e6xxx/chip.h   |  2 ++
 drivers/net/dsa/mv88e6xxx/serdes.c |  6 +++---
 drivers/net/dsa/mv88e6xxx/serdes.h | 11 +++++++++++
 4 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index d2a320c6bed7..11b98546b938 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -4375,6 +4375,7 @@ static const struct mv88e6xxx_ops mv88e6172_ops = {
 	.stu_getnext = mv88e6352_g1_stu_getnext,
 	.stu_loadpurge = mv88e6352_g1_stu_loadpurge,
 	.serdes_read = mv88e6352_serdes_read,
+	.serdes_write = mv88e6352_serdes_write,
 	.serdes_get_regs_len = mv88e6352_serdes_get_regs_len,
 	.serdes_get_regs = mv88e6352_serdes_get_regs,
 	.gpio_ops = &mv88e6352_gpio_ops,
@@ -4476,6 +4477,7 @@ static const struct mv88e6xxx_ops mv88e6176_ops = {
 	.stu_getnext = mv88e6352_g1_stu_getnext,
 	.stu_loadpurge = mv88e6352_g1_stu_loadpurge,
 	.serdes_read = mv88e6352_serdes_read,
+	.serdes_write = mv88e6352_serdes_write,
 	.serdes_irq_mapping = mv88e6352_serdes_irq_mapping,
 	.serdes_get_regs_len = mv88e6352_serdes_get_regs_len,
 	.serdes_get_regs = mv88e6352_serdes_get_regs,
@@ -4747,6 +4749,7 @@ static const struct mv88e6xxx_ops mv88e6240_ops = {
 	.stu_getnext = mv88e6352_g1_stu_getnext,
 	.stu_loadpurge = mv88e6352_g1_stu_loadpurge,
 	.serdes_read = mv88e6352_serdes_read,
+	.serdes_write = mv88e6352_serdes_write,
 	.serdes_irq_mapping = mv88e6352_serdes_irq_mapping,
 	.serdes_get_regs_len = mv88e6352_serdes_get_regs_len,
 	.serdes_get_regs = mv88e6352_serdes_get_regs,
@@ -5160,6 +5163,7 @@ static const struct mv88e6xxx_ops mv88e6352_ops = {
 	.stu_getnext = mv88e6352_g1_stu_getnext,
 	.stu_loadpurge = mv88e6352_g1_stu_loadpurge,
 	.serdes_read = mv88e6352_serdes_read,
+	.serdes_write = mv88e6352_serdes_write,
 	.serdes_irq_mapping = mv88e6352_serdes_irq_mapping,
 	.gpio_ops = &mv88e6352_gpio_ops,
 	.avb_ops = &mv88e6352_avb_ops,
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index bbf1e7f6f343..7e9b6eb11216 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -595,6 +595,8 @@ struct mv88e6xxx_ops {
 
 	int (*serdes_read)(struct mv88e6xxx_chip *chip, int lane, int device,
 			   int reg, u16 *val);
+	int (*serdes_write)(struct mv88e6xxx_chip *chip, int lane, int reg,
+			    u16 val);
 
 	/* SERDES interrupt handling */
 	unsigned int (*serdes_irq_mapping)(struct mv88e6xxx_chip *chip,
diff --git a/drivers/net/dsa/mv88e6xxx/serdes.c b/drivers/net/dsa/mv88e6xxx/serdes.c
index 5696b94c9155..b988d47ecbdd 100644
--- a/drivers/net/dsa/mv88e6xxx/serdes.c
+++ b/drivers/net/dsa/mv88e6xxx/serdes.c
@@ -25,8 +25,8 @@ int mv88e6352_serdes_read(struct mv88e6xxx_chip *chip, int lane,
 				       reg, val);
 }
 
-static int mv88e6352_serdes_write(struct mv88e6xxx_chip *chip, int reg,
-				  u16 val)
+int mv88e6352_serdes_write(struct mv88e6xxx_chip *chip, int lane, int reg,
+			   u16 val)
 {
 	return mv88e6xxx_phy_page_write(chip, MV88E6352_ADDR_SERDES,
 					MV88E6352_SERDES_PAGE_FIBER,
@@ -549,5 +549,5 @@ int mv88e6352_serdes_set_tx_amplitude(struct mv88e6xxx_chip *chip, int port,
 	ctrl &= ~MV88E6352_SERDES_OUT_AMP_MASK;
 	ctrl |= reg;
 
-	return mv88e6352_serdes_write(chip, MV88E6352_SERDES_SPEC_CTRL2, ctrl);
+	return mv88e6xxx_serdes_write(chip, lane, MV88E6352_SERDES_SPEC_CTRL2, ctrl);
 }
diff --git a/drivers/net/dsa/mv88e6xxx/serdes.h b/drivers/net/dsa/mv88e6xxx/serdes.h
index 9b3a5ece33e7..d3e83c674ef7 100644
--- a/drivers/net/dsa/mv88e6xxx/serdes.h
+++ b/drivers/net/dsa/mv88e6xxx/serdes.h
@@ -124,6 +124,8 @@ int mv88e6352_serdes_read(struct mv88e6xxx_chip *chip, int lane, int device,
 			  int reg, u16 *val);
 int mv88e6390_serdes_read(struct mv88e6xxx_chip *chip, int lane, int device,
 			  int reg, u16 *val);
+int mv88e6352_serdes_write(struct mv88e6xxx_chip *chip, int lane, int reg,
+			   u16 val);
 unsigned int mv88e6352_serdes_irq_mapping(struct mv88e6xxx_chip *chip,
 					  int port);
 unsigned int mv88e6390_serdes_irq_mapping(struct mv88e6xxx_chip *chip,
@@ -166,6 +168,15 @@ static inline int mv88e6xxx_serdes_read(struct mv88e6xxx_chip *chip, int lane,
 	return chip->info->ops->serdes_read(chip, lane, device, reg, val);
 }
 
+static inline int mv88e6xxx_serdes_write(struct mv88e6xxx_chip *chip, int lane,
+					 int reg, u16 val)
+{
+	if (!chip->info->ops->serdes_write)
+		return -EOPNOTSUPP;
+
+	return chip->info->ops->serdes_write(chip, lane, reg, val);
+}
+
 static inline unsigned int
 mv88e6xxx_serdes_irq_mapping(struct mv88e6xxx_chip *chip, int port)
 {
-- 
2.41.0


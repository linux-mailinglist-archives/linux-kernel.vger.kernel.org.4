Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D1F738FD1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 21:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbjFUTOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 15:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjFUTOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 15:14:23 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3B31BC1;
        Wed, 21 Jun 2023 12:14:08 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-98746d7f35dso801265766b.2;
        Wed, 21 Jun 2023 12:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687374846; x=1689966846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3BO6oKbpsV0/lssStRLXyv7Q1yOEIxNYSxSTIzG1XLo=;
        b=eWir9PUKr+uzCLk1+RDJqm76JmJf/Q7MsJp6dNL5Et2GgeJMvv9oKLwncQ2qACTWqQ
         lHDndzNUqiN1ju3b2WvRG6aCcRjdd/1gnFwfKicjUMv2Kx3novwH4bng4g9WM84Ro7Qx
         9RnQ1j1snLq3Lhc8X36qI1pIzMcqSEChVQ8cuWeW3VboA3EmpC/LY2k1yDZzNC4+mG7y
         GwSzEwjmw0UNj6PGhBfkXixAo6WRubE/e+0AeNVGlMMCaS3G6DubrbmerBr/zasmdEHq
         do3ETzH2Xus52eFHuOCTxfISJwk/b69jdnFcXgeqGwbbgtXvq2ut63lYMMvGlC8xjpgw
         UrkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687374846; x=1689966846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3BO6oKbpsV0/lssStRLXyv7Q1yOEIxNYSxSTIzG1XLo=;
        b=YmlNpoFcwpMOSp5KfHYrsaqWx8CwqqRl60m0e6Rvf4dvn1wQukO6AoKueyJj1flIiC
         W67cZdwmQsYUpD2drIiJjcm+sVbsAosgqKmHa4XqpymgvwNpGNNZKWxpZZWB2kdzUArf
         Jb5keEnQuepnPrrYSUXvkLW4UHE3jDQc0nsLKn81LL5gNPv7DfdVSZa5iNDFpVJnYubc
         GepTLe61zvtPmgNAzrf+GTh9wmkhrHKsZzOp7FU4MEi+WfS1EW1rIzPlY3WuTQ+J0mjt
         eQn/j3QRcvAll7MbmuYAs7b8sWNNCMyiqxtFg1laws1Y+L5TKjqnGNQKVmWKp7sNCRX7
         neOA==
X-Gm-Message-State: AC+VfDyTw5tRsbYd3gyPsjLpxWHm/b3KukGSgEJsmsEwrJsUEUJt4JWL
        Eavx8/MiGCAWJGGHvXDSXQ5oiKSqJiFQWQ==
X-Google-Smtp-Source: ACHHUZ54hzw/8TQsKMd5mqeg42FNRWuXsbYVHe7C2P8GZsjzuLP91a9Kmw1KpkmMCllZcwxx+thUdA==
X-Received: by 2002:a17:907:869f:b0:98c:ed39:3629 with SMTP id qa31-20020a170907869f00b0098ced393629mr1059339ejc.23.1687374846265;
        Wed, 21 Jun 2023 12:14:06 -0700 (PDT)
Received: from WBEC325.dom.local ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id gu1-20020a170906f28100b009829a5ae8b3sm3539562ejb.64.2023.06.21.12.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 12:14:05 -0700 (PDT)
From:   Pawel Dembicki <paweldembicki@gmail.com>
To:     netdev@vger.kernel.org
Cc:     linus.walleij@linaro.org, Pawel Dembicki <paweldembicki@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/6] net: dsa: vsc73xx: Add dsa tagging based on 8021q
Date:   Wed, 21 Jun 2023 21:12:59 +0200
Message-Id: <20230621191302.1405623-3-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230621191302.1405623-1-paweldembicki@gmail.com>
References: <20230621191302.1405623-1-paweldembicki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is simple implementation of 8021q tagging in vsc73xx driver.
At this moment devices with DSA_TAG_PROTO_NONE are useless. VSC73XX
family doesn't provide any tag support for external ethernet ports.

The only way is vlan-based tagging. It require constant hardware vlan
filtering. VSC73XX family support provider bridging but QinQ only without
fully implemented 802.1AD. It allow only doubled 0x8100 TPID.

In simple port mode QinQ is enabled to preserve forwarding vlan tagged
frames.

Tag driver introduce most simple funcionality required for proper taging
support.

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
 drivers/net/dsa/Kconfig                |   2 +-
 drivers/net/dsa/vitesse-vsc73xx-core.c | 531 +++++++++++++++++++++----
 include/net/dsa.h                      |   2 +
 net/dsa/Kconfig                        |   6 +
 net/dsa/Makefile                       |   1 +
 net/dsa/tag_vsc73xx_8021q.c            |  87 ++++
 6 files changed, 543 insertions(+), 86 deletions(-)
 create mode 100644 net/dsa/tag_vsc73xx_8021q.c

diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
index 3ed5391bb18d..4cf0166fef7b 100644
--- a/drivers/net/dsa/Kconfig
+++ b/drivers/net/dsa/Kconfig
@@ -125,7 +125,7 @@ config NET_DSA_SMSC_LAN9303_MDIO
 
 config NET_DSA_VITESSE_VSC73XX
 	tristate
-	select NET_DSA_TAG_NONE
+	select NET_DSA_TAG_VSC73XX
 	select FIXED_PHY
 	select VITESSE_PHY
 	select GPIOLIB
diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index ce22bd5fa8df..653914fb5796 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -25,6 +25,7 @@
 #include <linux/etherdevice.h>
 #include <linux/gpio/consumer.h>
 #include <linux/gpio/driver.h>
+#include <linux/dsa/8021q.h>
 #include <linux/random.h>
 #include <net/dsa.h>
 
@@ -63,6 +64,8 @@
 #define VSC73XX_CAT_DROP	0x6e
 #define VSC73XX_CAT_PR_MISC_L2	0x6f
 #define VSC73XX_CAT_PR_USR_PRIO	0x75
+#define VSC73XX_CAT_VLAN_MISC	0x79
+#define VSC73XX_CAT_PORT_VLAN	0x7a
 #define VSC73XX_Q_MISC_CONF	0xdf
 
 /* MAC_CFG register bits */
@@ -123,6 +126,17 @@
 #define VSC73XX_ADVPORTM_IO_LOOPBACK	BIT(1)
 #define VSC73XX_ADVPORTM_HOST_LOOPBACK	BIT(0)
 
+/*  TXUPDCFG transmit modify setup bits */
+#define VSC73XX_TXUPDCFG_DSCP_REWR_MODE	GENMASK(20, 19)
+#define VSC73XX_TXUPDCFG_DSCP_REWR_ENA	BIT(18)
+#define VSC73XX_TXUPDCFG_TX_INT_TO_USRPRIO_ENA	BIT(17)
+#define VSC73XX_TXUPDCFG_TX_UNTAGGED_VID	GENMASK(15, 4)
+#define VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_ENA	BIT(3)
+#define VSC73XX_TXUPDCFG_TX_UPDATE_CRC_CPU_ENA	BIT(1)
+#define VSC73XX_TXUPDCFG_TX_INSERT_TAG	BIT(0)
+
+#define VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_SHIFT 4
+
 /* CAT_DROP categorizer frame dropping register bits */
 #define VSC73XX_CAT_DROP_DROP_MC_SMAC_ENA	BIT(6)
 #define VSC73XX_CAT_DROP_FWD_CTRL_ENA		BIT(4)
@@ -136,6 +150,15 @@
 #define VSC73XX_Q_MISC_CONF_EARLY_TX_512	(1 << 1)
 #define VSC73XX_Q_MISC_CONF_MAC_PAUSE_MODE	BIT(0)
 
+/* CAT_VLAN_MISC categorizer VLAN miscellaneous bits*/
+#define VSC73XX_CAT_VLAN_MISC_VLAN_TCI_IGNORE_ENA BIT(8)
+#define VSC73XX_CAT_VLAN_MISC_VLAN_KEEP_TAG_ENA BIT(7)
+
+/* CAT_PORT_VLAN categorizer port VLAN*/
+#define VSC73XX_CAT_PORT_VLAN_VLAN_CFI BIT(15)
+#define VSC73XX_CAT_PORT_VLAN_VLAN_USR_PRIO GENMASK(14, 12)
+#define VSC73XX_CAT_PORT_VLAN_VLAN_VID GENMASK(11, 0)
+
 /* Frame analyzer block 2 registers */
 #define VSC73XX_STORMLIMIT	0x02
 #define VSC73XX_ADVLEARN	0x03
@@ -190,7 +213,8 @@
 #define VSC73XX_VLANACCESS_VLAN_MIRROR		BIT(29)
 #define VSC73XX_VLANACCESS_VLAN_SRC_CHECK	BIT(28)
 #define VSC73XX_VLANACCESS_VLAN_PORT_MASK	GENMASK(9, 2)
-#define VSC73XX_VLANACCESS_VLAN_TBL_CMD_MASK	GENMASK(2, 0)
+#define VSC73XX_VLANACCESS_VLAN_PORT_MASK_SHIFT	2
+#define VSC73XX_VLANACCESS_VLAN_TBL_CMD_MASK	GENMASK(1, 0)
 #define VSC73XX_VLANACCESS_VLAN_TBL_CMD_IDLE	0
 #define VSC73XX_VLANACCESS_VLAN_TBL_CMD_READ_ENTRY	1
 #define VSC73XX_VLANACCESS_VLAN_TBL_CMD_WRITE_ENTRY	2
@@ -345,6 +369,13 @@ static const struct vsc73xx_counter vsc73xx_tx_counters[] = {
 	{ 29, "TxQoSClass3" }, /* non-standard counter */
 };
 
+enum vsc73xx_port_vlan_conf {
+	VSC73XX_VLAN_UNAWARE,
+	VSC73XX_VLAN_AWARE,
+	VSC73XX_DOUBLE_VLAN_AWARE,
+	VSC73XX_DOUBLE_VLAN_CPU_AWARE,
+};
+
 int vsc73xx_is_addr_valid(u8 block, u8 subblock)
 {
 	switch (block) {
@@ -559,90 +590,7 @@ static enum dsa_tag_protocol vsc73xx_get_tag_protocol(struct dsa_switch *ds,
 	 * cannot access the tag. (See "Internal frame header" section
 	 * 3.9.1 in the manual.)
 	 */
-	return DSA_TAG_PROTO_NONE;
-}
-
-static int vsc73xx_setup(struct dsa_switch *ds)
-{
-	struct vsc73xx *vsc = ds->priv;
-	int i;
-
-	dev_info(vsc->dev, "set up the switch\n");
-
-	/* Issue RESET */
-	vsc73xx_write(vsc, VSC73XX_BLOCK_SYSTEM, 0, VSC73XX_GLORESET,
-		      VSC73XX_GLORESET_MASTER_RESET);
-	usleep_range(125, 200);
-
-	/* Initialize memory, initialize RAM bank 0..15 except 6 and 7
-	 * This sequence appears in the
-	 * VSC7385 SparX-G5 datasheet section 6.6.1
-	 * VSC7395 SparX-G5e datasheet section 6.6.1
-	 * "initialization sequence".
-	 * No explanation is given to the 0x1010400 magic number.
-	 */
-	for (i = 0; i <= 15; i++) {
-		if (i != 6 && i != 7) {
-			vsc73xx_write(vsc, VSC73XX_BLOCK_MEMINIT,
-				      2,
-				      0, 0x1010400 + i);
-			mdelay(1);
-		}
-	}
-	mdelay(30);
-
-	/* Clear MAC table */
-	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0,
-		      VSC73XX_MACACCESS,
-		      VSC73XX_MACACCESS_CMD_CLEAR_TABLE);
-
-	/* Clear VLAN table */
-	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0,
-		      VSC73XX_VLANACCESS,
-		      VSC73XX_VLANACCESS_VLAN_TBL_CMD_CLEAR_TABLE);
-
-	msleep(40);
-
-	/* Use 20KiB buffers on all ports on VSC7395
-	 * The VSC7385 has 16KiB buffers and that is the
-	 * default if we don't set this up explicitly.
-	 * Port "31" is "all ports".
-	 */
-	if (IS_739X(vsc))
-		vsc73xx_write(vsc, VSC73XX_BLOCK_MAC, 0x1f,
-			      VSC73XX_Q_MISC_CONF,
-			      VSC73XX_Q_MISC_CONF_EXTENT_MEM);
-
-	/* Put all ports into reset until enabled */
-	for (i = 0; i < 7; i++) {
-		if (i == 5)
-			continue;
-		vsc73xx_write(vsc, VSC73XX_BLOCK_MAC, 4,
-			      VSC73XX_MAC_CFG, VSC73XX_MAC_CFG_RESET);
-	}
-
-	/* MII delay, set both GTX and RX delay to 2 ns */
-	vsc73xx_write(vsc, VSC73XX_BLOCK_SYSTEM, 0, VSC73XX_GMIIDELAY,
-		      VSC73XX_GMIIDELAY_GMII0_GTXDELAY_2_0_NS |
-		      VSC73XX_GMIIDELAY_GMII0_RXDELAY_2_0_NS);
-	/* IP multicast flood mask (table 144) */
-	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_IFLODMSK,
-		      0xff);
-
-	mdelay(50);
-
-	/*configure forward map to CPU <-> port only*/
-	for (i = 0; i < vsc->ds->num_ports; i++)
-		vsc->forward_map[i] = VSC73XX_SRCMASKS_PORTS_MASK & BIT(CPU_PORT);
-	vsc->forward_map[CPU_PORT] = VSC73XX_SRCMASKS_PORTS_MASK & ~BIT(CPU_PORT);
-
-	/* Release reset from the internal PHYs */
-	vsc73xx_write(vsc, VSC73XX_BLOCK_SYSTEM, 0, VSC73XX_GLORESET,
-		      VSC73XX_GLORESET_PHY_RESET);
-
-	udelay(4);
-
-	return 0;
+	return DSA_TAG_PROTO_VSC73XX_8021Q;
 }
 
 static void vsc73xx_init_port(struct vsc73xx *vsc, int port)
@@ -1092,6 +1040,417 @@ static void vsc73xx_port_stp_state_set(struct dsa_switch *ds, int port,
 				    VSC73XX_SRCMASKS_PORTS_MASK, 0);
 }
 
+static int
+vsc73xx_port_wait_for_vlan_table_cmd(struct vsc73xx *vsc, int attempts)
+{
+	u32 val;
+	int i;
+
+	for (i = 0; i <= attempts; i++) {
+		vsc73xx_read(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_VLANACCESS,
+			     &val);
+		if ((val & VSC73XX_VLANACCESS_VLAN_TBL_CMD_MASK) ==
+		    VSC73XX_VLANACCESS_VLAN_TBL_CMD_IDLE)
+			return 0;
+	}
+	return -EBUSY;
+}
+
+static int
+vsc73xx_port_read_vlan_table_entry(struct dsa_switch *ds, u16 vid, u8 *portmap)
+{
+	struct vsc73xx *vsc = ds->priv;
+	u32 val;
+	int ret;
+
+	if (vid > 4095)
+		return -EPERM;
+	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_VLANTIDX, vid);
+	ret = vsc73xx_port_wait_for_vlan_table_cmd(vsc, VSC73XX_TABLE_ATTEMPTS);
+	if (ret)
+		return ret;
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_VLANACCESS,
+			    VSC73XX_VLANACCESS_VLAN_TBL_CMD_MASK,
+			    VSC73XX_VLANACCESS_VLAN_TBL_CMD_READ_ENTRY);
+	ret = vsc73xx_port_wait_for_vlan_table_cmd(vsc, VSC73XX_TABLE_ATTEMPTS);
+	if (ret)
+		return ret;
+	vsc73xx_read(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_VLANACCESS, &val);
+	*portmap = (val & VSC73XX_VLANACCESS_VLAN_PORT_MASK) >>
+		   VSC73XX_VLANACCESS_VLAN_PORT_MASK_SHIFT;
+	return 0;
+}
+
+static int
+vsc73xx_port_write_vlan_table_entry(struct dsa_switch *ds, u16 vid, u8 portmap)
+{
+	struct vsc73xx *vsc = ds->priv;
+	int ret;
+
+	if (vid > 4095)
+		return -EPERM;
+	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_VLANTIDX, vid);
+	ret = vsc73xx_port_wait_for_vlan_table_cmd(vsc, VSC73XX_TABLE_ATTEMPTS);
+	if (ret)
+		return ret;
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_VLANACCESS,
+			    VSC73XX_VLANACCESS_VLAN_TBL_CMD_MASK |
+			    VSC73XX_VLANACCESS_VLAN_SRC_CHECK |
+			    VSC73XX_VLANACCESS_VLAN_PORT_MASK,
+			    VSC73XX_VLANACCESS_VLAN_TBL_CMD_WRITE_ENTRY |
+			    VSC73XX_VLANACCESS_VLAN_SRC_CHECK |
+			    (portmap <<
+			     VSC73XX_VLANACCESS_VLAN_PORT_MASK_SHIFT));
+	ret = vsc73xx_port_wait_for_vlan_table_cmd(vsc, VSC73XX_TABLE_ATTEMPTS);
+	if (ret)
+		return ret;
+	return 0;
+}
+
+static int
+vsc73xx_port_update_vlan_table(struct dsa_switch *ds, int port, u16 vid,
+			       bool set)
+{
+	u8 portmap;
+	int ret;
+
+	if (vid > 4095)
+		return -EPERM;
+
+	ret = vsc73xx_port_read_vlan_table_entry(ds, vid, &portmap);
+	if (ret)
+		return ret;
+
+	if (set)
+		portmap |= BIT(port) | BIT(CPU_PORT);
+	else
+		portmap &= ~BIT(port);
+
+	if (portmap == BIT(CPU_PORT))
+		portmap = 0;
+
+	ret = vsc73xx_port_write_vlan_table_entry(ds, vid, portmap);
+
+	return ret;
+}
+
+static void
+vsc73xx_port_set_vlan_conf(struct dsa_switch *ds, int port,
+			   enum vsc73xx_port_vlan_conf port_vlan_conf)
+{
+	struct vsc73xx *vsc = ds->priv;
+
+	if (port_vlan_conf == VSC73XX_VLAN_UNAWARE) {
+		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
+				    VSC73XX_MAC_CFG,
+				    VSC73XX_MAC_CFG_VLAN_AWR, 0);
+		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
+				    VSC73XX_MAC_CFG,
+				    VSC73XX_MAC_CFG_VLAN_DBLAWR, 0);
+		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
+				    VSC73XX_CAT_VLAN_MISC,
+				    VSC73XX_CAT_VLAN_MISC_VLAN_TCI_IGNORE_ENA,
+				    VSC73XX_CAT_VLAN_MISC_VLAN_TCI_IGNORE_ENA);
+		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
+				    VSC73XX_CAT_VLAN_MISC,
+				    VSC73XX_CAT_VLAN_MISC_VLAN_KEEP_TAG_ENA,
+				    VSC73XX_CAT_VLAN_MISC_VLAN_KEEP_TAG_ENA);
+		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
+				    VSC73XX_CAT_DROP,
+				    VSC73XX_CAT_DROP_TAGGED_ENA, 0);
+	} else {
+		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
+				    VSC73XX_MAC_CFG,
+				    VSC73XX_MAC_CFG_VLAN_AWR,
+				    VSC73XX_MAC_CFG_VLAN_AWR);
+		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
+				    VSC73XX_CAT_DROP,
+				    VSC73XX_CAT_DROP_TAGGED_ENA, 0);
+		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
+				    VSC73XX_CAT_DROP,
+				    VSC73XX_CAT_DROP_UNTAGGED_ENA,
+				    VSC73XX_CAT_DROP_UNTAGGED_ENA);
+
+		if (port_vlan_conf == VSC73XX_DOUBLE_VLAN_CPU_AWARE)
+			vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
+					    VSC73XX_MAC_CFG,
+					    VSC73XX_MAC_CFG_VLAN_DBLAWR,
+					    VSC73XX_MAC_CFG_VLAN_DBLAWR);
+		else
+			vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
+					    VSC73XX_MAC_CFG,
+					    VSC73XX_MAC_CFG_VLAN_DBLAWR, 0);
+
+		if (port_vlan_conf == VSC73XX_DOUBLE_VLAN_AWARE) {
+			vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
+					    VSC73XX_CAT_VLAN_MISC,
+					    VSC73XX_CAT_VLAN_MISC_VLAN_TCI_IGNORE_ENA,
+					    VSC73XX_CAT_VLAN_MISC_VLAN_TCI_IGNORE_ENA);
+			vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
+					    VSC73XX_CAT_VLAN_MISC,
+					    VSC73XX_CAT_VLAN_MISC_VLAN_KEEP_TAG_ENA,
+					    VSC73XX_CAT_VLAN_MISC_VLAN_KEEP_TAG_ENA);
+			vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
+					    VSC73XX_TXUPDCFG,
+					    VSC73XX_TXUPDCFG_TX_INSERT_TAG, 0);
+		} else {
+			vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
+					    VSC73XX_CAT_VLAN_MISC,
+					    VSC73XX_CAT_VLAN_MISC_VLAN_TCI_IGNORE_ENA,
+					    0);
+			vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
+					    VSC73XX_CAT_VLAN_MISC,
+					    VSC73XX_CAT_VLAN_MISC_VLAN_KEEP_TAG_ENA,
+					    0);
+			vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
+					    VSC73XX_TXUPDCFG,
+					    VSC73XX_TXUPDCFG_TX_INSERT_TAG,
+					    VSC73XX_TXUPDCFG_TX_INSERT_TAG);
+		}
+
+		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
+				    VSC73XX_TXUPDCFG,
+				    VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_ENA, 0);
+		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
+				    VSC73XX_TXUPDCFG,
+				    VSC73XX_TXUPDCFG_TX_UNTAGGED_VID, 0);
+		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
+				    VSC73XX_CAT_PORT_VLAN,
+				    VSC73XX_CAT_PORT_VLAN_VLAN_VID, 0);
+	}
+}
+
+static int vsc73xx_port_set_double_vlan_aware(struct dsa_switch *ds, int port)
+{
+	int i, ret;
+
+	if (port == CPU_PORT)
+		vsc73xx_port_set_vlan_conf(ds, port,
+					   VSC73XX_DOUBLE_VLAN_CPU_AWARE);
+	else
+		vsc73xx_port_set_vlan_conf(ds, port,
+					   VSC73XX_DOUBLE_VLAN_AWARE);
+
+	for (i = 0; i <= 4095; i++) {
+		ret = vsc73xx_port_update_vlan_table(ds, port, i, 0);
+		if (ret)
+			return ret;
+	}
+	return ret;
+}
+
+static int vsc73xx_vlan_set_untagged(struct dsa_switch *ds, int port, u16 vid,
+				     bool port_vlan)
+{
+	struct vsc73xx *vsc = ds->priv;
+	u16 vlan_no;
+	u32 val;
+
+	vsc73xx_read(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_TXUPDCFG, &val);
+
+	if (port_vlan && (val & VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_ENA)) {
+		vsc73xx_read(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_TXUPDCFG,
+			     &val);
+		vlan_no = (val & VSC73XX_TXUPDCFG_TX_UNTAGGED_VID) >>
+				VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_SHIFT;
+		if (!vid_is_dsa_8021q(vlan_no) && !vid_is_dsa_8021q(vid) &&
+		    vlan_no != vid) {
+			dev_warn(vsc->dev,
+				 "Port %d can have only one untagged vid! Now is: %d.\n",
+				 port, vlan_no);
+				return -EPERM;
+		}
+	}
+
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_CAT_DROP,
+			    VSC73XX_CAT_DROP_UNTAGGED_ENA, 0);
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_TXUPDCFG,
+			    VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_ENA,
+			    VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_ENA);
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_TXUPDCFG,
+			    VSC73XX_TXUPDCFG_TX_UNTAGGED_VID,
+			    (vid << VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_SHIFT) &
+			     VSC73XX_TXUPDCFG_TX_UNTAGGED_VID);
+	return 0;
+}
+
+static int vsc73xx_vlan_set_pvid(struct dsa_switch *ds, int port, u16 vid,
+				 bool port_vlan)
+{
+	struct vsc73xx *vsc = ds->priv;
+	struct dsa_port *dsa_port =  dsa_to_port(ds, port);
+	u16 vlan_no;
+	u32 val;
+
+	if (!dsa_port)
+		return -EINVAL;
+
+	vsc73xx_read(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_CAT_PORT_VLAN, &val);
+	vlan_no = val & VSC73XX_CAT_PORT_VLAN_VLAN_VID;
+
+	if (port_vlan && vlan_no && !vid_is_dsa_8021q(vlan_no) &&
+	    !vid_is_dsa_8021q(vid) && vlan_no != vid) {
+		dev_warn(vsc->dev,
+			 "Port %d can have only one pvid! Now is: %d.\n",
+			 port, vlan_no);
+		return -EPERM;
+	}
+
+	if (dsa_port_is_vlan_filtering(dsa_port))
+		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
+				    VSC73XX_CAT_VLAN_MISC,
+				    VSC73XX_CAT_VLAN_MISC_VLAN_TCI_IGNORE_ENA,
+				    0);
+	else
+		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
+				    VSC73XX_CAT_VLAN_MISC,
+				    VSC73XX_CAT_VLAN_MISC_VLAN_TCI_IGNORE_ENA,
+				    VSC73XX_CAT_VLAN_MISC_VLAN_TCI_IGNORE_ENA);
+
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_CAT_VLAN_MISC,
+			    VSC73XX_CAT_VLAN_MISC_VLAN_KEEP_TAG_ENA,
+			    VSC73XX_CAT_VLAN_MISC_VLAN_KEEP_TAG_ENA);
+
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_CAT_PORT_VLAN,
+			    VSC73XX_CAT_PORT_VLAN_VLAN_VID,
+			    vid & VSC73XX_CAT_PORT_VLAN_VLAN_VID);
+	return 0;
+}
+
+static int vsc73xx_tag_8021q_vlan_add(struct dsa_switch *ds, int port, u16 vid,
+				      u16 flags)
+{
+	bool untagged = flags & BRIDGE_VLAN_INFO_UNTAGGED;
+	bool pvid = flags & BRIDGE_VLAN_INFO_PVID;
+	int ret;
+
+	if (untagged) {
+		ret = vsc73xx_vlan_set_untagged(ds, port, vid, false);
+		if (ret)
+			return ret;
+	}
+	if (pvid) {
+		ret = vsc73xx_vlan_set_pvid(ds, port, vid, false);
+		if (ret)
+			return ret;
+	}
+	ret = vsc73xx_port_update_vlan_table(ds, port, vid, 1);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int vsc73xx_tag_8021q_vlan_del(struct dsa_switch *ds, int port, u16 vid)
+{
+	return vsc73xx_port_update_vlan_table(ds, port, vid, 0);
+}
+
+static int vsc73xx_setup(struct dsa_switch *ds)
+{
+	struct vsc73xx *vsc = ds->priv;
+	int i, ret;
+
+	dev_info(vsc->dev, "set up the switch\n");
+
+	ds->vlan_filtering_is_global = false;
+	ds->configure_vlan_while_not_filtering = false;
+
+	/* Issue RESET */
+	vsc73xx_write(vsc, VSC73XX_BLOCK_SYSTEM, 0, VSC73XX_GLORESET,
+		      VSC73XX_GLORESET_MASTER_RESET);
+	usleep_range(125, 200);
+
+	/* Initialize memory, initialize RAM bank 0..15 except 6 and 7
+	 * This sequence appears in the
+	 * VSC7385 SparX-G5 datasheet section 6.6.1
+	 * VSC7395 SparX-G5e datasheet section 6.6.1
+	 * "initialization sequence".
+	 * No explanation is given to the 0x1010400 magic number.
+	 */
+	for (i = 0; i <= 15; i++) {
+		if (i != 6 && i != 7) {
+			vsc73xx_write(vsc, VSC73XX_BLOCK_MEMINIT,
+				      2,
+				      0, 0x1010400 + i);
+			mdelay(1);
+		}
+	}
+	mdelay(30);
+
+	/* Clear MAC table */
+	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+		      VSC73XX_MACACCESS,
+		      VSC73XX_MACACCESS_CMD_CLEAR_TABLE);
+
+	/* Clear VLAN table */
+	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+		      VSC73XX_VLANACCESS,
+		      VSC73XX_VLANACCESS_VLAN_TBL_CMD_CLEAR_TABLE);
+
+	msleep(40);
+
+	/* Use 20KiB buffers on all ports on VSC7395
+	 * The VSC7385 has 16KiB buffers and that is the
+	 * default if we don't set this up explicitly.
+	 * Port "31" is "all ports".
+	 */
+	if (IS_739X(vsc))
+		vsc73xx_write(vsc, VSC73XX_BLOCK_MAC, 0x1f,
+			      VSC73XX_Q_MISC_CONF,
+			      VSC73XX_Q_MISC_CONF_EXTENT_MEM);
+
+	/* Put all ports into reset until enabled */
+	for (i = 0; i < 7; i++) {
+		if (i == 5)
+			continue;
+		vsc73xx_write(vsc, VSC73XX_BLOCK_MAC, 4,
+			      VSC73XX_MAC_CFG, VSC73XX_MAC_CFG_RESET);
+	}
+
+	/* MII delay, set both GTX and RX delay to 2 ns */
+	vsc73xx_write(vsc, VSC73XX_BLOCK_SYSTEM, 0, VSC73XX_GMIIDELAY,
+		      VSC73XX_GMIIDELAY_GMII0_GTXDELAY_2_0_NS |
+		      VSC73XX_GMIIDELAY_GMII0_RXDELAY_2_0_NS);
+	/* Ingess VLAN reception mask (table 145) */
+	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_VLANMASK,
+		      0x5f);
+	/* IP multicast flood mask (table 144) */
+	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_IFLODMSK,
+		      0xff);
+
+	mdelay(50);
+
+	for (i = 0; i < vsc->ds->num_ports; i++) {
+		if (i == 5)
+			continue;
+		ret = vsc73xx_port_set_double_vlan_aware(ds, i);
+		if (ret)
+			return ret;
+	}
+
+	rtnl_lock();
+	ret = dsa_tag_8021q_register(ds, htons(ETH_P_8021Q));
+	rtnl_unlock();
+	if (ret)
+		return ret;
+
+	/*configure forward map to CPU <-> port only*/
+	for (i = 0; i < vsc->ds->num_ports; i++)
+		vsc->forward_map[i] = VSC73XX_SRCMASKS_PORTS_MASK &
+				      BIT(CPU_PORT);
+	vsc->forward_map[CPU_PORT] = VSC73XX_SRCMASKS_PORTS_MASK &
+				     ~BIT(CPU_PORT);
+
+	/* Release reset from the internal PHYs */
+	vsc73xx_write(vsc, VSC73XX_BLOCK_SYSTEM, 0, VSC73XX_GLORESET,
+		      VSC73XX_GLORESET_PHY_RESET);
+
+	udelay(4);
+
+	return 0;
+}
+
 static const struct dsa_switch_ops vsc73xx_ds_ops = {
 	.get_tag_protocol = vsc73xx_get_tag_protocol,
 	.setup = vsc73xx_setup,
@@ -1109,6 +1468,8 @@ static const struct dsa_switch_ops vsc73xx_ds_ops = {
 	.port_change_mtu = vsc73xx_change_mtu,
 	.port_max_mtu = vsc73xx_get_max_mtu,
 	.port_stp_state_set = vsc73xx_port_stp_state_set,
+	.tag_8021q_vlan_add = vsc73xx_tag_8021q_vlan_add,
+	.tag_8021q_vlan_del = vsc73xx_tag_8021q_vlan_del,
 };
 
 static int vsc73xx_gpio_get(struct gpio_chip *chip, unsigned int offset)
diff --git a/include/net/dsa.h b/include/net/dsa.h
index 75022cf771cf..2440df7ea6c9 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -56,6 +56,7 @@ struct phylink_link_state;
 #define DSA_TAG_PROTO_RTL8_4T_VALUE		25
 #define DSA_TAG_PROTO_RZN1_A5PSW_VALUE		26
 #define DSA_TAG_PROTO_LAN937X_VALUE		27
+#define DSA_TAG_PROTO_VSC73XX_8021Q_VALUE	28
 
 enum dsa_tag_protocol {
 	DSA_TAG_PROTO_NONE		= DSA_TAG_PROTO_NONE_VALUE,
@@ -86,6 +87,7 @@ enum dsa_tag_protocol {
 	DSA_TAG_PROTO_RTL8_4T		= DSA_TAG_PROTO_RTL8_4T_VALUE,
 	DSA_TAG_PROTO_RZN1_A5PSW	= DSA_TAG_PROTO_RZN1_A5PSW_VALUE,
 	DSA_TAG_PROTO_LAN937X		= DSA_TAG_PROTO_LAN937X_VALUE,
+	DSA_TAG_PROTO_VSC73XX_8021Q	= DSA_TAG_PROTO_VSC73XX_8021Q_VALUE,
 };
 
 struct dsa_switch;
diff --git a/net/dsa/Kconfig b/net/dsa/Kconfig
index 8e698bea99a3..e59360071c67 100644
--- a/net/dsa/Kconfig
+++ b/net/dsa/Kconfig
@@ -166,6 +166,12 @@ config NET_DSA_TAG_TRAILER
 	  Say Y or M if you want to enable support for tagging frames at
 	  with a trailed. e.g. Marvell 88E6060.
 
+config NET_DSA_TAG_VSC73XX_8021Q
+	tristate "Tag driver for Microchip/Vitesse VSC73xx family of switches, using VLAN"
+	help
+	  Say Y or M if you want to enable support for tagging frames with a
+	  custom VLAN-based header.
+
 config NET_DSA_TAG_XRS700X
 	tristate "Tag driver for XRS700x switches"
 	help
diff --git a/net/dsa/Makefile b/net/dsa/Makefile
index 12e305824a96..bab8a933c514 100644
--- a/net/dsa/Makefile
+++ b/net/dsa/Makefile
@@ -37,6 +37,7 @@ obj-$(CONFIG_NET_DSA_TAG_RTL8_4) += tag_rtl8_4.o
 obj-$(CONFIG_NET_DSA_TAG_RZN1_A5PSW) += tag_rzn1_a5psw.o
 obj-$(CONFIG_NET_DSA_TAG_SJA1105) += tag_sja1105.o
 obj-$(CONFIG_NET_DSA_TAG_TRAILER) += tag_trailer.o
+obj-$(CONFIG_NET_DSA_TAG_VSC73XX_8021Q) += tag_vsc73xx_8021q.o
 obj-$(CONFIG_NET_DSA_TAG_XRS700X) += tag_xrs700x.o
 
 # for tracing framework to find trace.h
diff --git a/net/dsa/tag_vsc73xx_8021q.c b/net/dsa/tag_vsc73xx_8021q.c
new file mode 100644
index 000000000000..3d83dfecde31
--- /dev/null
+++ b/net/dsa/tag_vsc73xx_8021q.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/* Copyright (C) 2022 Pawel Dembicki <paweldembicki@gmail.com>
+ * Based on tag_sja1105.c:
+ * Copyright (c) 2019, Vladimir Oltean <olteanv@gmail.com>
+ */
+#include <linux/dsa/8021q.h>
+
+#include "tag.h"
+#include "tag_8021q.h"
+
+#define VSC73XX_8021Q_NAME "vsc73xx-8021q"
+
+static struct sk_buff *vsc73xx_xmit(struct sk_buff *skb,
+				    struct net_device *netdev)
+{
+	struct dsa_port *dp = dsa_slave_to_port(netdev);
+	u16 queue_mapping = skb_get_queue_mapping(skb);
+	u8 pcp = netdev_txq_to_tc(netdev, queue_mapping);
+	u16 tx_vid = dsa_tag_8021q_standalone_vid(dp);
+	struct net_device *br = dsa_port_bridge_dev_get(dp);
+
+	if (skb->offload_fwd_mark) {
+		unsigned int bridge_num = dsa_port_bridge_num_get(dp);
+
+		if (br_vlan_enabled(br))
+			return skb;
+		else
+			tx_vid = dsa_tag_8021q_bridge_vid(bridge_num);
+	}
+
+	return dsa_8021q_xmit(skb, netdev, ETH_P_8021Q,
+			      ((pcp << VLAN_PRIO_SHIFT) | tx_vid));
+}
+
+static void vsc73xx_vlan_rcv(struct sk_buff *skb, int *source_port,
+			     int *switch_id, int *vbid, u16 *vid)
+{
+	if (vid_is_dsa_8021q(skb_vlan_tag_get(skb) & VLAN_VID_MASK))
+		return dsa_8021q_rcv(skb, source_port, switch_id, vbid);
+
+	/* Try our best with imprecise RX */
+	*vid = skb_vlan_tag_get(skb) & VLAN_VID_MASK;
+}
+
+static struct sk_buff *vsc73xx_rcv(struct sk_buff *skb,
+				   struct net_device *netdev)
+{
+	int src_port = -1, switch_id = -1, vbid = -1;
+	u16 vid;
+
+	if (skb_vlan_tag_present(skb))
+		/* Normal traffic path. */
+		vsc73xx_vlan_rcv(skb, &src_port, &switch_id, &vbid, &vid);
+
+	if (vbid >= 1)
+		skb->dev = dsa_tag_8021q_find_port_by_vbid(netdev, vbid);
+	else if (src_port == -1 || switch_id == -1)
+		skb->dev = dsa_find_designated_bridge_port_by_vid(netdev, vid);
+	else
+		skb->dev = dsa_master_find_slave(netdev, switch_id, src_port);
+	if (!skb->dev) {
+		netdev_warn(netdev, "Couldn't decode source port\n");
+		return NULL;
+	}
+
+	dsa_default_offload_fwd_mark(skb);
+
+	if (dsa_port_is_vlan_filtering(dsa_slave_to_port(skb->dev)) &&
+	    eth_hdr(skb)->h_proto == htons(ETH_P_8021Q))
+		__vlan_hwaccel_clear_tag(skb);
+
+	return skb;
+}
+
+static const struct dsa_device_ops vsc73xx_8021q_netdev_ops = {
+	.name			= VSC73XX_8021Q_NAME,
+	.proto			= DSA_TAG_PROTO_VSC73XX_8021Q,
+	.xmit			= vsc73xx_xmit,
+	.rcv			= vsc73xx_rcv,
+	.needed_headroom	= VLAN_HLEN,
+	.promisc_on_master	= true,
+};
+
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_VSC73XX_8021Q, VSC73XX_8021Q_NAME);
+
+module_dsa_tag_driver(vsc73xx_8021q_netdev_ops);
-- 
2.34.1


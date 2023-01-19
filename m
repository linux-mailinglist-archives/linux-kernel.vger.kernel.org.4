Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C79F673F51
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 17:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjASQvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 11:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjASQvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 11:51:19 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600E7829B2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 08:51:14 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30J1KBdf020876;
        Thu, 19 Jan 2023 10:51:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=SftSV7gvE+qMf6Vai8FZHIFOJ0BkZ4KenaMUMu6OZGU=;
 b=od1uJdNxKbfqBeIw8DpVyiOWn/dLGvG/w5pVBF+4SHCCaIcBBG8a+9ByWJy/Z/a5d+Pd
 IFcE6CXiIz68b8xkNjx4QOmOLEMjVNneMsCSodhu0BhmLtlxAeOPBYdQwyTzf8yNBNNT
 eA4el5nUeCKrq3XHn2u2Im8Bec3o484ZN8kwa1/1CKRijyJhAgmwuEOlpyQ2upnvXAn3
 Rk1Aj/iTHbXFvScmtBqiR66f0PY9m+uE7zOV4lVLqX/CBDOpyVTicq6/wCVvOmYuuvnJ
 hJqMLrZIEYjrBE8wDDhBg3FGf6R9Zu06/HmKyRi5kNEZkgFqo97JQ2aPU2LLHOu6DAuV IQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3n3tp6ga7w-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 10:51:07 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Thu, 19 Jan
 2023 10:51:04 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.7 via Frontend Transport; Thu, 19 Jan 2023 10:51:04 -0600
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6BD3D11CB;
        Thu, 19 Jan 2023 16:51:04 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <vkoul@kernel.org>
CC:     <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 2/2] soundwire: bus: Allow SoundWire peripherals to register IRQ handlers
Date:   Thu, 19 Jan 2023 16:51:04 +0000
Message-ID: <20230119165104.3433290-2-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230119165104.3433290-1-ckeepax@opensource.cirrus.com>
References: <20230119165104.3433290-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: dv3xlRQxIx3faMjWQx2X1KI5vfyzj45L
X-Proofpoint-GUID: dv3xlRQxIx3faMjWQx2X1KI5vfyzj45L
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Tanure <tanureal@opensource.cirrus.com>

Allow SoundWire peripherals to register a normal IRQ handler to receive
SoundWire alerts. This allows sharing the IRQ code between I2C/SPI which
typically use a normal IRQ handler, and SoundWire which historically
used a callback.

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/soundwire/bus.c       | 39 +++++++++++++++++++++++++++++++++++
 include/linux/soundwire/sdw.h |  9 ++++++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index daee2cca94a4d..49087e0ca3c3c 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -3,6 +3,7 @@
 
 #include <linux/acpi.h>
 #include <linux/delay.h>
+#include <linux/irq.h>
 #include <linux/mod_devicetable.h>
 #include <linux/pm_runtime.h>
 #include <linux/soundwire/sdw_registers.h>
@@ -25,6 +26,23 @@ static int sdw_get_id(struct sdw_bus *bus)
 	return 0;
 }
 
+static int sdw_irq_map(struct irq_domain *h, unsigned int virq,
+		       irq_hw_number_t hw)
+{
+	struct sdw_bus *bus = h->host_data;
+
+	irq_set_chip_data(virq, bus);
+	irq_set_chip(virq, &bus->irq_chip);
+	irq_set_nested_thread(virq, 1);
+	irq_set_noprobe(virq);
+
+	return 0;
+}
+
+static const struct irq_domain_ops sdw_domain_ops = {
+	.map	= sdw_irq_map,
+};
+
 /**
  * sdw_bus_master_add() - add a bus Master instance
  * @bus: bus instance
@@ -142,6 +160,13 @@ int sdw_bus_master_add(struct sdw_bus *bus, struct device *parent,
 	bus->params.curr_bank = SDW_BANK0;
 	bus->params.next_bank = SDW_BANK1;
 
+	bus->irq_chip.name = dev_name(bus->dev);
+	bus->domain = irq_domain_add_linear(NULL, SDW_MAX_DEVICES, &sdw_domain_ops, bus);
+	if (!bus->domain) {
+		dev_err(bus->dev, "Failed to add IRQ domain\n");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL(sdw_bus_master_add);
@@ -158,6 +183,8 @@ static int sdw_delete_slave(struct device *dev, void *data)
 	mutex_lock(&bus->bus_lock);
 
 	if (slave->dev_num) { /* clear dev_num if assigned */
+		irq_dispose_mapping(irq_find_mapping(bus->domain, slave->dev_num));
+
 		clear_bit(slave->dev_num, bus->assigned);
 		if (bus->dev_num_ida_min)
 			ida_free(&sdw_peripheral_ida, slave->dev_num);
@@ -178,6 +205,9 @@ static int sdw_delete_slave(struct device *dev, void *data)
 void sdw_bus_master_delete(struct sdw_bus *bus)
 {
 	device_for_each_child(bus->dev, NULL, sdw_delete_slave);
+
+	irq_domain_remove(bus->domain);
+
 	sdw_master_device_del(bus);
 
 	sdw_bus_debugfs_exit(bus);
@@ -717,6 +747,12 @@ static int sdw_assign_device_num(struct sdw_slave *slave)
 			slave->dev_num = dev_num;
 			slave->dev_num_sticky = dev_num;
 			new_device = true;
+
+			slave->irq = irq_create_mapping(bus->domain, dev_num);
+			if (!slave->irq) {
+				dev_err(bus->dev, "Failed to map IRQ\n");
+				return -EINVAL;
+			}
 		} else {
 			slave->dev_num = slave->dev_num_sticky;
 		}
@@ -1682,6 +1718,9 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 				struct device *dev = &slave->dev;
 				struct sdw_driver *drv = drv_to_sdw_driver(dev->driver);
 
+				if (slave->prop.irq && slave->irq)
+					handle_nested_irq(slave->irq);
+
 				if (drv->ops && drv->ops->interrupt_callback) {
 					slave_intr.sdca_cascade = sdca_cascade;
 					slave_intr.control_port = clear;
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 3cd2a761911ff..7627c459ab20f 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -5,6 +5,8 @@
 #define __SOUNDWIRE_H
 
 #include <linux/bug.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
 #include <linux/mod_devicetable.h>
 #include <linux/bitfield.h>
 
@@ -369,6 +371,7 @@ struct sdw_dpn_prop {
  * @clock_reg_supported: the Peripheral implements the clock base and scale
  * registers introduced with the SoundWire 1.2 specification. SDCA devices
  * do not need to set this boolean property as the registers are required.
+ * @irq: call actual IRQ handler on slave, as well as callback
  */
 struct sdw_slave_prop {
 	u32 mipi_revision;
@@ -393,6 +396,7 @@ struct sdw_slave_prop {
 	u8 scp_int1_mask;
 	u32 quirks;
 	bool clock_reg_supported;
+	bool irq;
 };
 
 #define SDW_SLAVE_QUIRKS_INVALID_INITIAL_PARITY	BIT(0)
@@ -638,6 +642,7 @@ struct sdw_slave_ops {
  * struct sdw_slave - SoundWire Slave
  * @id: MIPI device ID
  * @dev: Linux device
+ * @irq: IRQ number
  * @status: Status reported by the Slave
  * @bus: Bus handle
  * @prop: Slave properties
@@ -667,6 +672,7 @@ struct sdw_slave_ops {
 struct sdw_slave {
 	struct sdw_slave_id id;
 	struct device dev;
+	int irq;
 	enum sdw_slave_status status;
 	struct sdw_bus *bus;
 	struct sdw_slave_prop prop;
@@ -884,6 +890,7 @@ struct sdw_master_ops {
  * is used to compute and program bus bandwidth, clock, frame shape,
  * transport and port parameters
  * @debugfs: Bus debugfs
+ * @domain: IRQ domain
  * @defer_msg: Defer message
  * @clk_stop_timeout: Clock stop timeout computed
  * @bank_switch_timeout: Bank switch timeout computed
@@ -917,6 +924,8 @@ struct sdw_bus {
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs;
 #endif
+	struct irq_chip irq_chip;
+	struct irq_domain *domain;
 	struct sdw_defer defer_msg;
 	unsigned int clk_stop_timeout;
 	u32 bank_switch_timeout;
-- 
2.30.2


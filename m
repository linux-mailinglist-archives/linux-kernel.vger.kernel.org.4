Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A4D72CFF5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 21:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbjFLT6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 15:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236849AbjFLT5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 15:57:21 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA5D10CC;
        Mon, 12 Jun 2023 12:57:19 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CJktms021897;
        Mon, 12 Jun 2023 19:57:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=PAAauk/MBIDBkulUZ9s2999ynLRXJIwzeNJ2iTp8zN8=;
 b=M5SKSjgwy4Qab/k2toPoEOV/fGATxC9f0WsQA68EmFowImwOIHUPRHCBCRuMyoUQF8S6
 qEPcAVdVXKKIC+hDGsl7uKZ/+mJypkPXJzpdPEHr1IM2MKVQtBApR8NyoqLqD8pwE3Uo
 +O7NIask8FeHbwaTFQR5e5TD9Iu4eBlJvJYJ9Z2FrQ/lQRhsAR+cQ8hqpbKWjVSylRr5
 9mRaJDoVcx3F+5nqohpJX49aa9R7Z61Ty6WIeOGUUqvgvQQdDrvCujmj+8jrx01QVZaW
 YZI5WjP1amIwtingXHJKC9vhW6MMOdQmahsGBZnqA2ruddLaa2aZy2iTdHNOzLa8/tBt bA== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r69tqg6bh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 19:57:04 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35CJ5DeP027239;
        Mon, 12 Jun 2023 19:57:03 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([9.208.130.102])
        by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3r4gt5krr8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 19:57:03 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35CJv2t157737696
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 19:57:02 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6CD8F58043;
        Mon, 12 Jun 2023 19:57:02 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1EA4C58055;
        Mon, 12 Jun 2023 19:57:02 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.148.226])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 12 Jun 2023 19:57:02 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, jk@ozlabs.org, joel@jms.id.au,
        alistair@popple.id.au, andrew@aj.id.au, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 13/14] fsi: Add IBM I2C Responder virtual FSI master
Date:   Mon, 12 Jun 2023 14:56:56 -0500
Message-Id: <20230612195657.245125-14-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230612195657.245125-1-eajames@linux.ibm.com>
References: <20230612195657.245125-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3jec_YyfU2LCS1Sze_pswArchOLxJQ55
X-Proofpoint-ORIG-GUID: 3jec_YyfU2LCS1Sze_pswArchOLxJQ55
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_14,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 clxscore=1015 mlxscore=0 spamscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306120169
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The I2C Responder (I2CR) is an I2C device that translates I2C commands
to CFAM or SCOM operations, effectively implementing an FSI master and
bus.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/Kconfig                    |   9 +
 drivers/fsi/Makefile                   |   1 +
 drivers/fsi/fsi-master-i2cr.c          | 316 +++++++++++++++++++++++++
 drivers/fsi/fsi-master-i2cr.h          |  33 +++
 include/trace/events/fsi_master_i2cr.h | 107 +++++++++
 5 files changed, 466 insertions(+)
 create mode 100644 drivers/fsi/fsi-master-i2cr.c
 create mode 100644 drivers/fsi/fsi-master-i2cr.h
 create mode 100644 include/trace/events/fsi_master_i2cr.h

diff --git a/drivers/fsi/Kconfig b/drivers/fsi/Kconfig
index e6668a869913..999be82720c5 100644
--- a/drivers/fsi/Kconfig
+++ b/drivers/fsi/Kconfig
@@ -62,6 +62,15 @@ config FSI_MASTER_ASPEED
 
 	 Enable it for your BMC kernel in an OpenPower or IBM Power system.
 
+config FSI_MASTER_I2CR
+	tristate "IBM I2C Responder virtual FSI master"
+	depends on I2C
+	help
+	  This option enables a virtual FSI master in order to access a CFAM
+	  behind an IBM I2C Responder (I2CR) chip. The I2CR is an I2C device
+	  that translates I2C commands to CFAM or SCOM operations, effectively
+	  implementing an FSI master and bus.
+
 config FSI_SCOM
 	tristate "SCOM FSI client device driver"
 	help
diff --git a/drivers/fsi/Makefile b/drivers/fsi/Makefile
index da218a1ad8e1..34dbaa1c452e 100644
--- a/drivers/fsi/Makefile
+++ b/drivers/fsi/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_FSI) += fsi-core.o
 obj-$(CONFIG_FSI_MASTER_HUB) += fsi-master-hub.o
 obj-$(CONFIG_FSI_MASTER_ASPEED) += fsi-master-aspeed.o
 obj-$(CONFIG_FSI_MASTER_GPIO) += fsi-master-gpio.o
+obj-$(CONFIG_FSI_MASTER_I2CR) += fsi-master-i2cr.o
 obj-$(CONFIG_FSI_MASTER_AST_CF) += fsi-master-ast-cf.o
 obj-$(CONFIG_FSI_SCOM) += fsi-scom.o
 obj-$(CONFIG_FSI_SBEFIFO) += fsi-sbefifo.o
diff --git a/drivers/fsi/fsi-master-i2cr.c b/drivers/fsi/fsi-master-i2cr.c
new file mode 100644
index 000000000000..61659c27a973
--- /dev/null
+++ b/drivers/fsi/fsi-master-i2cr.c
@@ -0,0 +1,316 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) IBM Corporation 2023 */
+
+#include <linux/device.h>
+#include <linux/fsi.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
+
+#include "fsi-master-i2cr.h"
+
+#define CREATE_TRACE_POINTS
+#include <trace/events/fsi_master_i2cr.h>
+
+#define I2CR_ADDRESS_CFAM(a)	((a) >> 2)
+#define I2CR_INITIAL_PARITY	true
+
+#define I2CR_STATUS_CMD		0x60002
+#define  I2CR_STATUS_ERR	 BIT_ULL(61)
+#define I2CR_ERROR_CMD		0x60004
+#define I2CR_LOG_CMD		0x60008
+
+static const u8 i2cr_cfam[] = {
+	0xc0, 0x02, 0x0d, 0xa6,
+	0x80, 0x01, 0x10, 0x02,
+	0x80, 0x01, 0x10, 0x02,
+	0x80, 0x01, 0x10, 0x02,
+	0x80, 0x01, 0x80, 0x52,
+	0x80, 0x01, 0x10, 0x02,
+	0x80, 0x01, 0x10, 0x02,
+	0x80, 0x01, 0x10, 0x02,
+	0x80, 0x01, 0x10, 0x02,
+	0x80, 0x01, 0x22, 0x2d,
+	0x00, 0x00, 0x00, 0x00,
+	0xde, 0xad, 0xc0, 0xde
+};
+
+static bool i2cr_check_parity32(u32 v, bool parity)
+{
+	u32 i;
+
+	for (i = 0; i < 32; ++i) {
+		if (v & (1u << i))
+			parity = !parity;
+	}
+
+	return parity;
+}
+
+static bool i2cr_check_parity64(u64 v)
+{
+	u32 i;
+	bool parity = I2CR_INITIAL_PARITY;
+
+	for (i = 0; i < 64; ++i) {
+		if (v & (1llu << i))
+			parity = !parity;
+	}
+
+	return parity;
+}
+
+static u32 i2cr_get_command(u32 address, bool parity)
+{
+	address <<= 1;
+
+	if (i2cr_check_parity32(address, parity))
+		address |= 1;
+
+	return address;
+}
+
+static int i2cr_transfer(struct i2c_client *client, u32 command, u64 *data)
+{
+	struct i2c_msg msgs[2];
+	int ret;
+
+	msgs[0].addr = client->addr;
+	msgs[0].flags = 0;
+	msgs[0].len = sizeof(command);
+	msgs[0].buf = (__u8 *)&command;
+	msgs[1].addr = client->addr;
+	msgs[1].flags = I2C_M_RD;
+	msgs[1].len = sizeof(*data);
+	msgs[1].buf = (__u8 *)data;
+
+	ret = i2c_transfer(client->adapter, msgs, 2);
+	if (ret == 2)
+		return 0;
+
+	trace_i2cr_i2c_error(client, command, ret);
+
+	if (ret < 0)
+		return ret;
+
+	return -EIO;
+}
+
+static int i2cr_check_status(struct i2c_client *client)
+{
+	u64 status;
+	int ret;
+
+	ret = i2cr_transfer(client, I2CR_STATUS_CMD, &status);
+	if (ret)
+		return ret;
+
+	if (status & I2CR_STATUS_ERR) {
+		u32 buf[3] = { 0, 0, 0 };
+		u64 error;
+		u64 log;
+
+		i2cr_transfer(client, I2CR_ERROR_CMD, &error);
+		i2cr_transfer(client, I2CR_LOG_CMD, &log);
+
+		trace_i2cr_status_error(client, status, error, log);
+
+		buf[0] = I2CR_STATUS_CMD;
+		i2c_master_send(client, (const char *)buf, sizeof(buf));
+
+		buf[0] = I2CR_ERROR_CMD;
+		i2c_master_send(client, (const char *)buf, sizeof(buf));
+
+		buf[0] = I2CR_LOG_CMD;
+		i2c_master_send(client, (const char *)buf, sizeof(buf));
+
+		dev_err(&client->dev, "status:%016llx error:%016llx log:%016llx\n", status, error,
+			log);
+		return -EREMOTEIO;
+	}
+
+	trace_i2cr_status(client, status);
+	return 0;
+}
+
+int fsi_master_i2cr_read(struct fsi_master_i2cr *i2cr, u32 addr, u64 *data)
+{
+	u32 command = i2cr_get_command(addr, I2CR_INITIAL_PARITY);
+	int ret;
+
+	mutex_lock(&i2cr->lock);
+
+	ret = i2cr_transfer(i2cr->client, command, data);
+	if (ret)
+		goto unlock;
+
+	ret = i2cr_check_status(i2cr->client);
+	if (ret)
+		goto unlock;
+
+	trace_i2cr_read(i2cr->client, command, data);
+
+unlock:
+	mutex_unlock(&i2cr->lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(fsi_master_i2cr_read);
+
+int fsi_master_i2cr_write(struct fsi_master_i2cr *i2cr, u32 addr, u64 data)
+{
+	u32 buf[3] = { 0 };
+	int ret;
+
+	buf[0] = i2cr_get_command(addr, i2cr_check_parity64(data));
+	memcpy(&buf[1], &data, sizeof(data));
+
+	mutex_lock(&i2cr->lock);
+
+	ret = i2c_master_send(i2cr->client, (const char *)buf, sizeof(buf));
+	if (ret == sizeof(buf)) {
+		ret = i2cr_check_status(i2cr->client);
+		if (!ret)
+			trace_i2cr_write(i2cr->client, buf[0], data);
+	} else {
+		trace_i2cr_i2c_error(i2cr->client, buf[0], ret);
+
+		if (ret >= 0)
+			ret = -EIO;
+	}
+
+	mutex_unlock(&i2cr->lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(fsi_master_i2cr_write);
+
+static int i2cr_read(struct fsi_master *master, int link, uint8_t id, uint32_t addr, void *val,
+		     size_t size)
+{
+	struct fsi_master_i2cr *i2cr = container_of(master, struct fsi_master_i2cr, master);
+	u64 data;
+	size_t i;
+	int ret;
+
+	if (link || id || (addr & 0xffff0000) || !(size == 1 || size == 2 || size == 4))
+		return -EINVAL;
+
+	/*
+	 * The I2CR doesn't have CFAM or FSI slave address space - only the
+	 * engines. In order for this to work with the FSI core, we need to
+	 * emulate at minimum the CFAM config table so that the appropriate
+	 * engines are discovered.
+	 */
+	if (addr < 0xc00) {
+		if (addr > sizeof(i2cr_cfam) - 4)
+			addr = (addr & 0x3) + (sizeof(i2cr_cfam) - 4);
+
+		memcpy(val, &i2cr_cfam[addr], size);
+		return 0;
+	}
+
+	ret = fsi_master_i2cr_read(i2cr, I2CR_ADDRESS_CFAM(addr), &data);
+	if (ret)
+		return ret;
+
+	/*
+	 * FSI core expects up to 4 bytes BE back, while I2CR replied with LE
+	 * bytes on the wire.
+	 */
+	for (i = 0; i < size; ++i)
+		((u8 *)val)[i] = ((u8 *)&data)[7 - i];
+
+	return 0;
+}
+
+static int i2cr_write(struct fsi_master *master, int link, uint8_t id, uint32_t addr,
+		      const void *val, size_t size)
+{
+	struct fsi_master_i2cr *i2cr = container_of(master, struct fsi_master_i2cr, master);
+	u64 data = 0;
+	size_t i;
+
+	if (link || id || (addr & 0xffff0000) || !(size == 1 || size == 2 || size == 4))
+		return -EINVAL;
+
+	/* I2CR writes to CFAM or FSI slave address are a successful no-op. */
+	if (addr < 0xc00)
+		return 0;
+
+	/*
+	 * FSI core passes up to 4 bytes BE, while the I2CR expects LE bytes on
+	 * the wire.
+	 */
+	for (i = 0; i < size; ++i)
+		((u8 *)&data)[7 - i] = ((u8 *)val)[i];
+
+	return fsi_master_i2cr_write(i2cr, I2CR_ADDRESS_CFAM(addr), data);
+}
+
+static void i2cr_release(struct device *dev)
+{
+	struct fsi_master_i2cr *i2cr = to_fsi_master_i2cr(to_fsi_master(dev));
+
+	of_node_put(dev->of_node);
+
+	kfree(i2cr);
+}
+
+static int i2cr_probe(struct i2c_client *client)
+{
+	struct fsi_master_i2cr *i2cr;
+	int ret;
+
+	i2cr = kzalloc(sizeof(*i2cr), GFP_KERNEL);
+	if (!i2cr)
+		return -ENOMEM;
+
+	/* Only one I2CR on any given I2C bus (fixed I2C device address) */
+	i2cr->master.idx = client->adapter->nr;
+	dev_set_name(&i2cr->master.dev, "i2cr%d", i2cr->master.idx);
+	i2cr->master.dev.parent = &client->dev;
+	i2cr->master.dev.of_node = of_node_get(dev_of_node(&client->dev));
+	i2cr->master.dev.release = i2cr_release;
+
+	i2cr->master.n_links = 1;
+	i2cr->master.read = i2cr_read;
+	i2cr->master.write = i2cr_write;
+
+	mutex_init(&i2cr->lock);
+	i2cr->client = client;
+
+	ret = fsi_master_register(&i2cr->master);
+	if (ret)
+		return ret;
+
+	i2c_set_clientdata(client, i2cr);
+	return 0;
+}
+
+static void i2cr_remove(struct i2c_client *client)
+{
+	struct fsi_master_i2cr *i2cr = i2c_get_clientdata(client);
+
+	fsi_master_unregister(&i2cr->master);
+}
+
+static const struct of_device_id i2cr_ids[] = {
+	{ .compatible = "ibm,i2cr-fsi-master" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, i2cr_ids);
+
+static struct i2c_driver i2cr_driver = {
+	.probe_new = i2cr_probe,
+	.remove = i2cr_remove,
+	.driver = {
+		.name = "fsi-master-i2cr",
+		.of_match_table = i2cr_ids,
+	},
+};
+
+module_i2c_driver(i2cr_driver)
+
+MODULE_AUTHOR("Eddie James <eajames@linux.ibm.com>");
+MODULE_DESCRIPTION("IBM I2C Responder virtual FSI master driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/fsi/fsi-master-i2cr.h b/drivers/fsi/fsi-master-i2cr.h
new file mode 100644
index 000000000000..96636bf28cac
--- /dev/null
+++ b/drivers/fsi/fsi-master-i2cr.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) IBM Corporation 2023 */
+
+#ifndef DRIVERS_FSI_MASTER_I2CR_H
+#define DRIVERS_FSI_MASTER_I2CR_H
+
+#include <linux/i2c.h>
+#include <linux/mutex.h>
+
+#include "fsi-master.h"
+
+struct i2c_client;
+
+struct fsi_master_i2cr {
+	struct fsi_master master;
+	struct mutex lock;	/* protect HW access */
+	struct i2c_client *client;
+};
+
+#define to_fsi_master_i2cr(m)	container_of(m, struct fsi_master_i2cr, master)
+
+int fsi_master_i2cr_read(struct fsi_master_i2cr *i2cr, u32 addr, u64 *data);
+int fsi_master_i2cr_write(struct fsi_master_i2cr *i2cr, u32 addr, u64 data);
+
+static inline bool is_fsi_master_i2cr(struct fsi_master *master)
+{
+	if (master->dev.parent && master->dev.parent->type == &i2c_client_type)
+		return true;
+
+	return false;
+}
+
+#endif /* DRIVERS_FSI_MASTER_I2CR_H */
diff --git a/include/trace/events/fsi_master_i2cr.h b/include/trace/events/fsi_master_i2cr.h
new file mode 100644
index 000000000000..c33eba130049
--- /dev/null
+++ b/include/trace/events/fsi_master_i2cr.h
@@ -0,0 +1,107 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM fsi_master_i2cr
+
+#if !defined(_TRACE_FSI_MASTER_I2CR_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_FSI_MASTER_I2CR_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(i2cr_i2c_error,
+	TP_PROTO(const struct i2c_client *client, uint32_t command, int rc),
+	TP_ARGS(client, command, rc),
+	TP_STRUCT__entry(
+		__field(int, bus)
+		__field(int, rc)
+		__array(unsigned char, command, sizeof(uint32_t))
+		__field(unsigned short, addr)
+	),
+	TP_fast_assign(
+		__entry->bus = client->adapter->nr;
+		__entry->rc = rc;
+		memcpy(__entry->command, &command, sizeof(uint32_t));
+		__entry->addr = client->addr;
+	),
+	TP_printk("%d-%02x command:{ %*ph } rc:%d", __entry->bus, __entry->addr,
+		  (int)sizeof(uint32_t), __entry->command, __entry->rc)
+);
+
+TRACE_EVENT(i2cr_read,
+	TP_PROTO(const struct i2c_client *client, uint32_t command, uint64_t *data),
+	TP_ARGS(client, command, data),
+	TP_STRUCT__entry(
+		__field(int, bus)
+		__array(unsigned char, data, sizeof(uint64_t))
+		__array(unsigned char, command, sizeof(uint32_t))
+		__field(unsigned short, addr)
+	),
+	TP_fast_assign(
+		__entry->bus = client->adapter->nr;
+		memcpy(__entry->data, data, sizeof(uint64_t));
+		memcpy(__entry->command, &command, sizeof(uint32_t));
+		__entry->addr = client->addr;
+	),
+	TP_printk("%d-%02x command:{ %*ph } { %*ph }", __entry->bus, __entry->addr,
+		  (int)sizeof(uint32_t), __entry->command, (int)sizeof(uint64_t), __entry->data)
+);
+
+TRACE_EVENT(i2cr_status,
+	TP_PROTO(const struct i2c_client *client, uint64_t status),
+	TP_ARGS(client, status),
+	TP_STRUCT__entry(
+		__field(uint64_t, status)
+		__field(int, bus)
+		__field(unsigned short, addr)
+	),
+	TP_fast_assign(
+		__entry->status = status;
+		__entry->bus = client->adapter->nr;
+		__entry->addr = client->addr;
+	),
+	TP_printk("%d-%02x %016llx", __entry->bus, __entry->addr, __entry->status)
+);
+
+TRACE_EVENT(i2cr_status_error,
+	TP_PROTO(const struct i2c_client *client, uint64_t status, uint64_t error, uint64_t log),
+	TP_ARGS(client, status, error, log),
+	TP_STRUCT__entry(
+		__field(uint64_t, error)
+		__field(uint64_t, log)
+		__field(uint64_t, status)
+		__field(int, bus)
+		__field(unsigned short, addr)
+	),
+	TP_fast_assign(
+		__entry->error = error;
+		__entry->log = log;
+		__entry->status = status;
+		__entry->bus = client->adapter->nr;
+		__entry->addr = client->addr;
+	),
+	TP_printk("%d-%02x status:%016llx error:%016llx log:%016llx", __entry->bus, __entry->addr,
+		  __entry->status, __entry->error, __entry->log)
+);
+
+TRACE_EVENT(i2cr_write,
+	TP_PROTO(const struct i2c_client *client, uint32_t command, uint64_t data),
+	TP_ARGS(client, command, data),
+	TP_STRUCT__entry(
+		__field(int, bus)
+		__array(unsigned char, data, sizeof(uint64_t))
+		__array(unsigned char, command, sizeof(uint32_t))
+		__field(unsigned short, addr)
+	),
+	TP_fast_assign(
+		__entry->bus = client->adapter->nr;
+		memcpy(__entry->data, &data, sizeof(uint64_t));
+		memcpy(__entry->command, &command, sizeof(uint32_t));
+		__entry->addr = client->addr;
+	),
+	TP_printk("%d-%02x command:{ %*ph } { %*ph }", __entry->bus, __entry->addr,
+		  (int)sizeof(uint32_t), __entry->command, (int)sizeof(uint64_t), __entry->data)
+);
+
+#endif
+
+#include <trace/define_trace.h>
-- 
2.31.1


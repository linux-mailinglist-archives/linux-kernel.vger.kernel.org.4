Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B8469E977
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 22:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjBUV1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 16:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjBUV0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 16:26:52 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30440311E3;
        Tue, 21 Feb 2023 13:26:49 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31LLHOhM022447;
        Tue, 21 Feb 2023 21:26:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=iewubdbzkMpFrlnBQmvRr1ZguaKXzO3tk5NYbvu+Gak=;
 b=WdYUcd1hcdnHjcwd3OqcwPNFOjA1h8eRqnzJkNEXCXCZjrLlFm1nVsIslzVHKTmzMOtW
 +4dl4/AXD3buFQpIZOBMlL/o8+K9fzHOKJ6UG78oFfGUJMqd/5u/T34N3AmGHrgnkwjL
 17t6dLB2zhU9ipi2PrMTattfZt34uGL4kH6MjirBo1chAqwK/D+FdQnEuM1MrfMid3nb
 mtguhuKPQMA4RkwuzAsPq7Rk4kj8kJ1fxvAezJ9uZag1/gb4rg785pZ4sd79JjI82UnE
 DvNWw0Ik/VgUuJTDYSabrxMEYbqbb/fbZjeUBQjQVrDAaGM2a968tB2BfOZR9iE71mM2 WA== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nw4ma9sph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 21:26:32 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31LHmTvR015944;
        Tue, 21 Feb 2023 21:26:32 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([9.208.129.117])
        by ppma05wdc.us.ibm.com (PPS) with ESMTPS id 3ntpa6vuye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 21:26:32 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31LLQV6I262848
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Feb 2023 21:26:31 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 139A558059;
        Tue, 21 Feb 2023 21:26:31 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45FAC58058;
        Tue, 21 Feb 2023 21:26:29 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.65.223.120])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 21 Feb 2023 21:26:29 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhiramat@kernel.org, alistair@popple.id.au, joel@jms.id.au,
        jk@ozlabs.org, andrew@aj.id.au, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, eajames@linux.ibm.com
Subject: [PATCH v5 3/6] fsi: Add IBM I2C Responder virtual FSI master
Date:   Tue, 21 Feb 2023 15:26:19 -0600
Message-Id: <20230221212622.3897097-4-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230221212622.3897097-1-eajames@linux.ibm.com>
References: <20230221212622.3897097-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vP79WBBjLuxHXwliBQGRDaZAIIZh9eZ0
X-Proofpoint-GUID: vP79WBBjLuxHXwliBQGRDaZAIIZh9eZ0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-21_12,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302210182
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
Changes since v4:
 - Split the read/write functions into the FSI master register access functions
   and generic functions that can do the SCOMs
 - Rework the trace events to handle variable data size and fix the trace
   structure alignment/padding
 - Add a check on the status register during probe to avoid registering the
   FSI master if the device isn't there

 drivers/fsi/Kconfig                    |   9 +
 drivers/fsi/Makefile                   |   1 +
 drivers/fsi/fsi-master-i2cr.c          | 228 +++++++++++++++++++++++++
 drivers/fsi/fsi-master-i2cr.h          |  24 +++
 drivers/fsi/fsi-master.h               |   1 +
 include/trace/events/fsi_master_i2cr.h | 109 ++++++++++++
 6 files changed, 372 insertions(+)
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
index 000000000000..d4ea41cde1ae
--- /dev/null
+++ b/drivers/fsi/fsi-master-i2cr.c
@@ -0,0 +1,228 @@
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
+#define I2CR_STATUS		0x30001
+#define  I2CR_STATUS_ERR	 BIT_ULL(61)
+#define I2CR_ERROR		0x30002
+
+static bool i2cr_check_parity(u32 v, bool parity)
+{
+	u32 i;
+
+	for (i = 0; i < 32; ++i) {
+		if (v & (1 << i))
+			parity = !parity;
+	}
+
+	return parity;
+}
+
+static __be32 i2cr_get_command(u32 address, bool parity)
+{
+	address <<= 1;
+
+	if (i2cr_check_parity(address, parity))
+		address |= 1;
+
+	return cpu_to_be32(address);
+}
+
+static int i2cr_transfer(struct i2c_client *client, u32 address, __be64 *data)
+{
+	struct i2c_msg msgs[2];
+	__be32 command;
+	int ret;
+
+	command = i2cr_get_command(address, true);
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
+	__be64 status_be = 0;
+	u64 status;
+	int ret;
+
+	ret = i2cr_transfer(client, I2CR_STATUS, &status_be);
+	if (ret)
+		return ret;
+
+	status = be64_to_cpu(status_be);
+	if (status & I2CR_STATUS_ERR) {
+		__be64 error_be = 0;
+		u64 error;
+
+		i2cr_transfer(client, I2CR_ERROR, &error_be);
+		error = be64_to_cpu(error_be);
+		trace_i2cr_status_error(client, status, error);
+
+		dev_err(&client->dev, "status:%016llx error:%016llx\n", status, error);
+		return -EREMOTEIO;
+	}
+
+	trace_i2cr_status(client, status);
+	return 0;
+}
+
+int fsi_master_i2cr_read(struct fsi_master_i2cr *i2cr, u32 addr, void *data, size_t size)
+{
+	__be64 buf;
+	int ret;
+
+	mutex_lock(&i2cr->lock);
+
+	ret = i2cr_transfer(i2cr->client, addr, &buf);
+	if (ret)
+		goto unlock;
+
+	ret = i2cr_check_status(i2cr->client);
+	if (ret)
+		goto unlock;
+
+	memcpy(data, &buf, size);
+	trace_i2cr_read(i2cr->client, addr, data, size);
+
+unlock:
+	mutex_unlock(&i2cr->lock);
+	return ret;
+}
+
+int fsi_master_i2cr_write(struct fsi_master_i2cr *i2cr, u32 addr, const void *data, size_t size)
+{
+	u32 buf[3] = { 0 };
+	__be32 command;
+	int ret;
+
+	memcpy(&buf[1], data, size);
+	command = i2cr_get_command(addr, i2cr_check_parity(buf[1], true));
+	memcpy(&buf[0], &command, sizeof(u32));
+
+	mutex_lock(&i2cr->lock);
+
+	ret = i2c_master_send(i2cr->client, (const char *)buf, sizeof(buf));
+	if (ret == sizeof(buf)) {
+		ret = i2cr_check_status(i2cr->client);
+		if (!ret)
+			trace_i2cr_write(i2cr->client, addr, data, size);
+	} else {
+		trace_i2cr_i2c_error(i2cr->client, command, ret);
+
+		if (ret >= 0)
+			ret = -EIO;
+	}
+
+	mutex_unlock(&i2cr->lock);
+	return ret;
+}
+
+static int i2cr_read(struct fsi_master *master, int link, uint8_t id, uint32_t addr, void *val,
+		     size_t size)
+{
+	struct fsi_master_i2cr *i2cr = container_of(master, struct fsi_master_i2cr, master);
+
+	if (link || id || (addr & 0xffff0000) || !(size == 1 || size == 2 || size == 4))
+		return -EINVAL;
+
+	return fsi_master_i2cr_read(i2cr, I2CR_ADDRESS_CFAM(addr), val, size);
+}
+
+static int i2cr_write(struct fsi_master *master, int link, uint8_t id, uint32_t addr,
+		      const void *val, size_t size)
+{
+	struct fsi_master_i2cr *i2cr = container_of(master, struct fsi_master_i2cr, master);
+
+	if (link || id || (addr & 0xffff0000) || !(size == 1 || size == 2 || size == 4))
+		return -EINVAL;
+
+	return fsi_master_i2cr_write(i2cr, I2CR_ADDRESS_CFAM(addr), val, size);
+}
+
+static int i2cr_probe(struct i2c_client *client)
+{
+	struct fsi_master_i2cr *i2cr;
+	int ret;
+
+	if (i2cr_check_status(client))
+		return -ENODEV;
+
+	i2cr = devm_kzalloc(&client->dev, sizeof(*i2cr), GFP_KERNEL);
+	if (!i2cr)
+		return -ENOMEM;
+
+	i2cr->master.dev.parent = &client->dev;
+	i2cr->master.dev.of_node = of_node_get(dev_of_node(&client->dev));
+
+	i2cr->master.n_links = 1;
+	i2cr->master.flags = FSI_MASTER_FLAG_I2CR;
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
index 000000000000..0e164b3c6d3c
--- /dev/null
+++ b/drivers/fsi/fsi-master-i2cr.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) IBM Corporation 2023 */
+
+#ifndef DRIVERS_FSI_MASTER_I2CR_H
+#define DRIVERS_FSI_MASTER_I2CR_H
+
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
+int fsi_master_i2cr_read(struct fsi_master_i2cr *i2cr, u32 addr, void *data, size_t size);
+int fsi_master_i2cr_write(struct fsi_master_i2cr *i2cr, u32 addr, const void *data, size_t size);
+
+#endif /* DRIVERS_FSI_MASTER_I2CR_H */
diff --git a/drivers/fsi/fsi-master.h b/drivers/fsi/fsi-master.h
index 967622c1cabf..a1fa315849d2 100644
--- a/drivers/fsi/fsi-master.h
+++ b/drivers/fsi/fsi-master.h
@@ -111,6 +111,7 @@
 
 /* fsi-master definition and flags */
 #define FSI_MASTER_FLAG_SWCLOCK		0x1
+#define FSI_MASTER_FLAG_I2CR		0x2
 
 /*
  * Structures and function prototypes
diff --git a/include/trace/events/fsi_master_i2cr.h b/include/trace/events/fsi_master_i2cr.h
new file mode 100644
index 000000000000..bbd7875ee5a6
--- /dev/null
+++ b/include/trace/events/fsi_master_i2cr.h
@@ -0,0 +1,109 @@
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
+	TP_PROTO(const struct i2c_client *client, __be32 command, int rc),
+	TP_ARGS(client, command, rc),
+	TP_STRUCT__entry(
+		__field(int, bus)
+		__field(int, rc)
+		__array(unsigned char, command, sizeof(__be32))
+		__field(unsigned short, addr)
+	),
+	TP_fast_assign(
+		__entry->bus = client->adapter->nr;
+		__entry->addr = client->addr;
+		memcpy(__entry->command, &command, sizeof(__be32));
+		__entry->rc = rc;
+	),
+	TP_printk("%d-%02x command:{ %*ph } rc:%d", __entry->bus, __entry->addr,
+		  (int)sizeof(__be32), __entry->command, __entry->rc)
+);
+
+TRACE_EVENT(i2cr_read,
+	TP_PROTO(const struct i2c_client *client, uint32_t address, const void *data, size_t size),
+	TP_ARGS(client, address, data, size),
+	TP_STRUCT__entry(
+		__field(size_t, size)
+		__field(int, bus)
+		__field(uint32_t, address)
+		__array(unsigned char, data, 8)
+		__field(unsigned short, addr)
+	),
+	TP_fast_assign(
+		__entry->bus = client->adapter->nr;
+		__entry->addr = client->addr;
+		__entry->address = address;
+		__entry->size = size > 8 ? 8 : size;
+		memcpy(__entry->data, data, __entry->size);
+	),
+	TP_printk("%d-%02x address:%08x size:%zu { %*ph }", __entry->bus, __entry->addr,
+		  __entry->address, __entry->size, (int)__entry->size, __entry->data)
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
+		__entry->bus = client->adapter->nr;
+		__entry->addr = client->addr;
+		__entry->status = status;
+	),
+	TP_printk("%d-%02x %016llx", __entry->bus, __entry->addr, __entry->status)
+);
+
+TRACE_EVENT(i2cr_status_error,
+	TP_PROTO(const struct i2c_client *client, uint64_t status, uint64_t error),
+	TP_ARGS(client, status, error),
+	TP_STRUCT__entry(
+		__field(uint64_t, error)
+		__field(uint64_t, status)
+		__field(int, bus)
+		__field(unsigned short, addr)
+	),
+	TP_fast_assign(
+		__entry->bus = client->adapter->nr;
+		__entry->addr = client->addr;
+		__entry->error = error;
+		__entry->status = status;
+	),
+	TP_printk("%d-%02x status:%016llx error:%016llx", __entry->bus, __entry->addr,
+		  __entry->status, __entry->error)
+);
+
+TRACE_EVENT(i2cr_write,
+	TP_PROTO(const struct i2c_client *client, uint32_t address, const void *data, size_t size),
+	TP_ARGS(client, address, data, size),
+	TP_STRUCT__entry(
+		__field(size_t,	size)
+		__field(int, bus)
+		__field(uint32_t, address)
+		__array(unsigned char, data, 8)
+		__field(unsigned short, addr)
+	),
+	TP_fast_assign(
+		__entry->bus = client->adapter->nr;
+		__entry->addr = client->addr;
+		__entry->address = address;
+		__entry->size = size > 8 ? 8 : size;
+		memcpy(__entry->data, data, __entry->size);
+	),
+	TP_printk("%d-%02x address:%08x size:%zu { %*ph }", __entry->bus, __entry->addr,
+		  __entry->address, __entry->size, (int)__entry->size, __entry->data)
+);
+
+#endif
+
+#include <trace/define_trace.h>
-- 
2.31.1


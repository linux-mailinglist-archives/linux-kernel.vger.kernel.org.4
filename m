Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F29267D7BF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 22:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbjAZVb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 16:31:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232362AbjAZVbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 16:31:48 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336B34DBCE;
        Thu, 26 Jan 2023 13:31:47 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30QKFrBU022970;
        Thu, 26 Jan 2023 21:31:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=QwlJo+ZY/eY+rklSkxDhRuRP/i9uG3s2ks085YAnBfQ=;
 b=HL6eoWIukoNkjW0Ube0JvmYlhN8UWEag/a+A80HTbQJIhco7UauihkjbZbRPjzxQYMgd
 x1yW0wLnjLijjVeLuHARPUUOnYoIrmUTB5/s0lpeQz0BWrQRCS0fTn+iIPnMQqw3U402
 PVsar/K+7NnbZuY28cGeCb21oDO5st50lwq+bGO7x6gzlnr9xXoruI+cKGmbRolc5tKz
 v2wNTvjEvw7cWGD2KPXaf6KDDAUibgpd/Em229z++tvuJOzmRVQIgfsSIrOUJ5wI7TQb
 xdOp9R5u97Ahm9l3WuZSq1hWwr0O1/2OVvEtVf3feRwx7fqGDTgtMicYeNsUpGyDE7+o cA== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nc0dd9g3e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 21:31:31 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30QJHBlt012680;
        Thu, 26 Jan 2023 21:31:29 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([9.208.129.113])
        by ppma02wdc.us.ibm.com (PPS) with ESMTPS id 3n87p7yd9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 21:31:29 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30QLVSbp56492356
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jan 2023 21:31:28 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 26E5C5805D;
        Thu, 26 Jan 2023 21:31:28 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B56C758055;
        Thu, 26 Jan 2023 21:31:26 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.160.3.213])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 26 Jan 2023 21:31:26 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-trace-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        rostedt@goodmis.org, eajames@linux.ibm.com, alistair@popple.id.au,
        joel@jms.id.au, jk@ozlabs.org, andrew@aj.id.au, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH v3 2/2] fsi: Add IBM I2C Responder virtual FSI master
Date:   Thu, 26 Jan 2023 15:31:23 -0600
Message-Id: <20230126213123.884125-3-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230126213123.884125-1-eajames@linux.ibm.com>
References: <20230126213123.884125-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VlYD7SdkSJ4e6VaN0j3e0oM5JpsS6Zew
X-Proofpoint-GUID: VlYD7SdkSJ4e6VaN0j3e0oM5JpsS6Zew
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-26_09,2023-01-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301260202
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
 drivers/fsi/fsi-master-i2cr.c          | 225 +++++++++++++++++++++++++
 include/trace/events/fsi_master_i2cr.h |  96 +++++++++++
 4 files changed, 331 insertions(+)
 create mode 100644 drivers/fsi/fsi-master-i2cr.c
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
index 000000000000..0eadc9b26063
--- /dev/null
+++ b/drivers/fsi/fsi-master-i2cr.c
@@ -0,0 +1,225 @@
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
+#include "fsi-master.h"
+
+#define CREATE_TRACE_POINTS
+#include <trace/events/fsi_master_i2cr.h>
+
+#define I2CR_ADDRESS_CFAM(a)	((a) >> 2)
+#define I2CR_STATUS		0x30001
+#define  I2CR_STATUS_ERR	 BIT_ULL(61)
+#define I2CR_ERROR		0x30002
+
+struct fsi_master_i2cr {
+	struct fsi_master master;
+	struct mutex lock;	/* protect HW access */
+	struct i2c_client *client;
+};
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
+	__be32 command;
+
+	address <<= 1;
+
+	if (i2cr_check_parity(address, parity))
+		address |= 1;
+
+	command = cpu_to_be32(address);
+	trace_i2cr_command((__force uint32_t)command);
+
+	return command;
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
+	trace_i2cr_i2c_error(ret);
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
+		trace_i2cr_status_error(status, error);
+		dev_err(&client->dev, "status:%016llx error:%016llx\n", status, error);
+		return -EREMOTEIO;
+	}
+
+	trace_i2cr_status(status);
+	return 0;
+}
+
+static int i2cr_read(struct fsi_master *master, int link, uint8_t id, uint32_t addr, void *val,
+		     size_t size)
+{
+	struct fsi_master_i2cr *i2cr = container_of(master, struct fsi_master_i2cr, master);
+	__be64 data = 0;
+	int ret;
+
+	if (link || id || (addr & 0xffff0000) || !(size == 1 || size == 2 || size == 4))
+		return -EINVAL;
+
+	mutex_lock(&i2cr->lock);
+
+	ret = i2cr_transfer(i2cr->client, I2CR_ADDRESS_CFAM(addr), &data);
+	if (ret)
+		goto unlock;
+
+	ret = i2cr_check_status(i2cr->client);
+	if (ret)
+		goto unlock;
+
+	trace_i2cr_read(addr, size, (__force uint32_t)data);
+	memcpy(val, &data, size);
+
+unlock:
+	mutex_unlock(&i2cr->lock);
+	return ret;
+}
+
+static int i2cr_write(struct fsi_master *master, int link, uint8_t id, uint32_t addr,
+		      const void *val, size_t size)
+{
+	struct fsi_master_i2cr *i2cr = container_of(master, struct fsi_master_i2cr, master);
+	struct {
+		__be32 command;
+		u32 val;
+		u32 rsvd;
+	} __packed data = { 0, 0, 0 };
+	int ret;
+
+	if (link || id || (addr & 0xffff0000) || !(size == 1 || size == 2 || size == 4))
+		return -EINVAL;
+
+	memcpy(&data.val, val, size);
+	data.command = i2cr_get_command(I2CR_ADDRESS_CFAM(addr),
+					i2cr_check_parity(data.val, true));
+
+	mutex_lock(&i2cr->lock);
+
+	ret = i2c_master_send(i2cr->client, (const char *)&data, sizeof(data));
+	if (ret == sizeof(data)) {
+		ret = i2cr_check_status(i2cr->client);
+		if (!ret)
+			trace_i2cr_write(addr, size, data.val);
+	} else {
+		trace_i2cr_i2c_error(ret);
+
+		if (ret >= 0)
+			ret = -EIO;
+	}
+
+	mutex_unlock(&i2cr->lock);
+	return ret;
+}
+
+static int i2cr_probe(struct i2c_client *client)
+{
+	struct fsi_master_i2cr *i2cr;
+	int ret;
+
+	i2cr = devm_kzalloc(&client->dev, sizeof(*i2cr), GFP_KERNEL);
+	if (!i2cr)
+		return -ENOMEM;
+
+	i2cr->master.dev.parent = &client->dev;
+	i2cr->master.dev.of_node = of_node_get(dev_of_node(&client->dev));
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
+static const struct of_device_id i2cr_i2c_ids[] = {
+	{ .compatible = "ibm,i2cr-fsi-master", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, i2cr_i2c_ids);
+
+static struct i2c_driver i2cr_driver = {
+	.probe_new = i2cr_probe,
+	.remove = i2cr_remove,
+	.driver = {
+		.name = "fsi-master-i2cr",
+		.of_match_table = i2cr_i2c_ids,
+	},
+};
+
+module_i2c_driver(i2cr_driver)
+
+MODULE_AUTHOR("Eddie James <eajames@linux.ibm.com>");
+MODULE_DESCRIPTION("IBM I2C Responder virtual FSI master driver");
+MODULE_LICENSE("GPL");
diff --git a/include/trace/events/fsi_master_i2cr.h b/include/trace/events/fsi_master_i2cr.h
new file mode 100644
index 000000000000..7b53c6a35bc7
--- /dev/null
+++ b/include/trace/events/fsi_master_i2cr.h
@@ -0,0 +1,96 @@
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
+TRACE_EVENT(i2cr_command,
+	TP_PROTO(uint32_t command),
+	TP_ARGS(command),
+	TP_STRUCT__entry(
+		__field(uint32_t,	command)
+	),
+	TP_fast_assign(
+		__entry->command = command;
+	),
+	TP_printk("command:%08x", __entry->command)
+);
+
+TRACE_EVENT(i2cr_i2c_error,
+	TP_PROTO(int rc),
+	TP_ARGS(rc),
+	TP_STRUCT__entry(
+		__field(int,	rc)
+	),
+	TP_fast_assign(
+		__entry->rc = rc;
+	),
+	TP_printk("rc:%d", __entry->rc)
+);
+
+TRACE_EVENT(i2cr_read,
+	TP_PROTO(uint32_t addr, size_t size, uint64_t result),
+	TP_ARGS(addr, size, result),
+	TP_STRUCT__entry(
+		__field(uint32_t,	addr)
+		__field(size_t,		size)
+		__field(uint64_t,	result)
+	),
+	TP_fast_assign(
+		__entry->addr = addr;
+		__entry->size = size;
+		__entry->result = result;
+	),
+	TP_printk("addr:%08x size:%zu result:%016llx", __entry->addr, __entry->size,
+		  __entry->result)
+);
+
+TRACE_EVENT(i2cr_status,
+	TP_PROTO(uint64_t status),
+	TP_ARGS(status),
+	TP_STRUCT__entry(
+		__field(uint32_t,	status)
+	),
+	TP_fast_assign(
+		__entry->status = status >> 32;
+	),
+	TP_printk("status:%08x", __entry->status)
+);
+
+TRACE_EVENT(i2cr_status_error,
+	TP_PROTO(uint64_t status, uint64_t error),
+	TP_ARGS(status, error),
+	TP_STRUCT__entry(
+		__field(uint64_t,	error)
+		__field(uint32_t,	status)
+	),
+	TP_fast_assign(
+		__entry->error = error;
+		__entry->status = status >> 32;
+	),
+	TP_printk("status:%08x error:%016llx", __entry->status, __entry->error)
+);
+
+TRACE_EVENT(i2cr_write,
+	TP_PROTO(uint32_t addr, uint32_t val, size_t size),
+	TP_ARGS(addr, val, size),
+	TP_STRUCT__entry(
+		__field(uint32_t,	addr)
+		__field(uint32_t,	val)
+		__field(size_t,		size)
+	),
+	TP_fast_assign(
+		__entry->addr = addr;
+		__entry->val = val;
+		__entry->size = size;
+	),
+	TP_printk("addr:%08x val:%08x size:%zu", __entry->addr, __entry->val, __entry->size)
+);
+
+#endif
+
+#include <trace/define_trace.h>
-- 
2.31.1


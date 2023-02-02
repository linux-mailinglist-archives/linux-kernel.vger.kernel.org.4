Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704DD688774
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 20:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbjBBTUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 14:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbjBBTTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 14:19:50 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFF66C101;
        Thu,  2 Feb 2023 11:19:49 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 312JC1a1005250;
        Thu, 2 Feb 2023 19:19:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=R1SFIAqWXYUkd7S+gF9unOZUwX3M1z2F2+c2cz22Qns=;
 b=bweoRdh/xsEcStRaj5Wk6UQF4eZgIeTL74qjqRbyaBB0hBFtHdwil2H5PVWaLOgPHh3J
 WpIc68+q/ejQlObqcqURGRaBDZ1n2ad46uzI/AL8OA6ZPz+xDismzxOwXofJINb2DG8e
 RS8FZaVkxEt3YhKziUImMakfC8+qkHmqvu8616/cDB/MMz+hv+YaXSNgle/I1O/sGWUo
 8rYCeyvq+vJ9o3GPn0iQoxaG97vQAAda4giGHrlAN3cD62naUuN5dCqEM87omivWVKFT
 H7HYfl3Z0L2SgMPIxh1fQzqW7eiXC6G1SDhwknx6fP1jGA8wYufBIucKtFF3iiAaRiLo uw== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ngk4785pk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 19:19:34 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 312J1gVE026758;
        Thu, 2 Feb 2023 19:19:33 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([9.208.129.114])
        by ppma01wdc.us.ibm.com (PPS) with ESMTPS id 3ncvtnd1sf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 19:19:33 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 312JJVkE46596464
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Feb 2023 19:19:32 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C78FC5805A;
        Thu,  2 Feb 2023 19:19:31 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5FE4558056;
        Thu,  2 Feb 2023 19:19:30 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.65.214.66])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  2 Feb 2023 19:19:30 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-trace-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        rostedt@goodmis.org, eajames@linux.ibm.com, alistair@popple.id.au,
        joel@jms.id.au, jk@ozlabs.org, andrew@aj.id.au, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH v4 2/2] fsi: Add IBM I2C Responder virtual FSI master
Date:   Thu,  2 Feb 2023 13:19:26 -0600
Message-Id: <20230202191926.133340-3-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230202191926.133340-1-eajames@linux.ibm.com>
References: <20230202191926.133340-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jhsYItl3UC2RFBtoHbZYJ9nccQrfdFRb
X-Proofpoint-ORIG-GUID: jhsYItl3UC2RFBtoHbZYJ9nccQrfdFRb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_13,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 suspectscore=0
 phishscore=0 impostorscore=0 spamscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302020171
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
Changes since v3:
 - Rework the endian-ness in i2cr_write
 - Rework the tracing to include the i2c bus and device address

 drivers/fsi/Kconfig                    |   9 +
 drivers/fsi/Makefile                   |   1 +
 drivers/fsi/fsi-master-i2cr.c          | 218 +++++++++++++++++++++++++
 include/trace/events/fsi_master_i2cr.h | 109 +++++++++++++
 4 files changed, 337 insertions(+)
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
index 000000000000..7ed93c9f4352
--- /dev/null
+++ b/drivers/fsi/fsi-master-i2cr.c
@@ -0,0 +1,218 @@
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
+	trace_i2cr_read(i2cr->client, addr, size, data);
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
+	u32 data[3] = { 0 };
+	__be32 command;
+	int ret;
+
+	if (link || id || (addr & 0xffff0000) || !(size == 1 || size == 2 || size == 4))
+		return -EINVAL;
+
+	memcpy(&data[1], val, size);
+	command = i2cr_get_command(I2CR_ADDRESS_CFAM(addr), i2cr_check_parity(data[1], true));
+	memcpy(&data[0], &command, sizeof(u32));
+
+	mutex_lock(&i2cr->lock);
+
+	ret = i2c_master_send(i2cr->client, (const char *)data, sizeof(data));
+	if (ret == sizeof(data)) {
+		ret = i2cr_check_status(i2cr->client);
+		if (!ret)
+			trace_i2cr_write(i2cr->client, addr, size, data[1]);
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
index 000000000000..2ccc8b447999
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
+		__field(unsigned short, addr)
+		__array(unsigned char, command, sizeof(__be32))
+		__field(int, rc)
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
+	TP_PROTO(const struct i2c_client *client, uint32_t address, size_t size, __be64 result),
+	TP_ARGS(client, address, size, result),
+	TP_STRUCT__entry(
+		__field(int, bus)
+		__field(unsigned short, addr)
+		__field(uint32_t, address)
+		__field(size_t, size)
+		__array(unsigned char, result, sizeof(__be64))
+	),
+	TP_fast_assign(
+		__entry->bus = client->adapter->nr;
+		__entry->addr = client->addr;
+		__entry->address = address;
+		__entry->size = size;
+		memcpy(__entry->result, &result, sizeof(__be64));
+	),
+	TP_printk("%d-%02x address:%08x size:%zu { %*ph }", __entry->bus, __entry->addr,
+		  __entry->address, __entry->size, (int)__entry->size, __entry->result)
+);
+
+TRACE_EVENT(i2cr_status,
+	TP_PROTO(const struct i2c_client *client, uint64_t status),
+	TP_ARGS(client, status),
+	TP_STRUCT__entry(
+		__field(int, bus)
+		__field(unsigned short, addr)
+		__field(uint64_t, status)
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
+		__field(int, bus)
+		__field(unsigned short, addr)
+		__field(uint64_t, error)
+		__field(uint64_t, status)
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
+	TP_PROTO(const struct i2c_client *client, uint32_t address, size_t size, uint32_t data),
+	TP_ARGS(client, address, size, data),
+	TP_STRUCT__entry(
+		__field(int, bus)
+		__field(unsigned short, addr)
+		__field(uint32_t, address)
+		__field(size_t,	size)
+		__array(unsigned char, data, sizeof(uint32_t))
+	),
+	TP_fast_assign(
+		__entry->bus = client->adapter->nr;
+		__entry->addr = client->addr;
+		__entry->address = address;
+		__entry->size = size;
+		memcpy(__entry->data, &data, sizeof(uint32_t));
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


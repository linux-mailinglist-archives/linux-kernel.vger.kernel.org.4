Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218E75EE63F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 21:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234705AbiI1T6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 15:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234453AbiI1T5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 15:57:49 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D20953D3D;
        Wed, 28 Sep 2022 12:57:47 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28SJqLiP018787;
        Wed, 28 Sep 2022 19:57:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=8ODXVfRXyvhzhZL3SSFC58yLogbf8HDcBx1jlbfpVSs=;
 b=TtPRTZSy5qR6mMhRkky6O+hyruZlaDpxpL9JCSq94Hh5eSjyRR6h19jpygpgQdkynGes
 0tTnnrDP1sNb4dHbAtRNAMxHeGiikSPp895kMi8XqKpNfjGAEfUVz0+FC8xmcxGaac2x
 60iijU8AGEaNj3grOpgqeykCa/zdvbvoSvp5eVU0Qj7cn5rysRdt8PSQ2k3MVK5dFrxP
 7ZBGsT71oZF0C2NPG6qLMGdv8TrIrBxCIsxBu+sT7Ct6TZ3xsKOSk5H6MHRBf68RKP9e
 zMHKiCrPHtXx48t8K4QVvG7iP92otxX1dqfZZ7GSEA0WcjeYKMaNACvMyTdNtmmALF9v EA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jvfp3tk24-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 19:57:34 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28SJvXfE026010
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 19:57:33 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 28 Sep 2022 12:57:32 -0700
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
CC:     Elliot Berman <quic_eberman@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Srivatsa Vaddagiri" <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Will Deacon" <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Arnd Bergmann" <arnd@arndb.de>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 14/14] tty: gunyah: Add tty console driver for RM Console Services
Date:   Wed, 28 Sep 2022 12:56:33 -0700
Message-ID: <20220928195633.2348848-15-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220928195633.2348848-1-quic_eberman@quicinc.com>
References: <20220928195633.2348848-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: eG439zpOQdxTaWMegKMz6AeBzxzceC6X
X-Proofpoint-GUID: eG439zpOQdxTaWMegKMz6AeBzxzceC6X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-28_09,2022-09-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 mlxscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209280119
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gunyah provides a console for each VM using the VM console resource
manager APIs. This driver allows console data from other
VMs to be accessed via a TTY device and exports a console device to dump
Linux's own logs to our console.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 MAINTAINERS              |   1 +
 drivers/tty/Kconfig      |   8 +
 drivers/tty/Makefile     |   1 +
 drivers/tty/gunyah_tty.c | 409 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 419 insertions(+)
 create mode 100644 drivers/tty/gunyah_tty.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a0cba618e5f6..e8d4a6d9491a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8890,6 +8890,7 @@ F:	Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml
 F:	Documentation/virt/gunyah/
 F:	arch/arm64/gunyah/
 F:	drivers/mailbox/gunyah-msgq.c
+F:	drivers/tty/gunyah_tty.c
 F:	drivers/virt/gunyah/
 F:	include/asm-generic/gunyah.h
 F:	include/linux/gunyah*.h
diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index cc30ff93e2e4..ff86e977f9ac 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -380,6 +380,14 @@ config RPMSG_TTY
 	  To compile this driver as a module, choose M here: the module will be
 	  called rpmsg_tty.
 
+config GUNYAH_CONSOLE
+	tristate "Gunyah Consoles"
+	depends on GUNYAH
+	help
+	  This enables support for console output using Gunyah's Resource Manager RPC.
+	  This is normally used when a secondary VM which does not have exclusive access
+	  to a real or virtualized serial device and virtio-console is unavailable.
+
 endif # TTY
 
 source "drivers/tty/serdev/Kconfig"
diff --git a/drivers/tty/Makefile b/drivers/tty/Makefile
index 07aca5184a55..d183fbfd835b 100644
--- a/drivers/tty/Makefile
+++ b/drivers/tty/Makefile
@@ -27,5 +27,6 @@ obj-$(CONFIG_GOLDFISH_TTY)	+= goldfish.o
 obj-$(CONFIG_MIPS_EJTAG_FDC_TTY) += mips_ejtag_fdc.o
 obj-$(CONFIG_VCC)		+= vcc.o
 obj-$(CONFIG_RPMSG_TTY)		+= rpmsg_tty.o
+obj-$(CONFIG_GUNYAH_CONSOLE)	+= gunyah_tty.o
 
 obj-y += ipwireless/
diff --git a/drivers/tty/gunyah_tty.c b/drivers/tty/gunyah_tty.c
new file mode 100644
index 000000000000..80a20da11ad0
--- /dev/null
+++ b/drivers/tty/gunyah_tty.c
@@ -0,0 +1,409 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#define pr_fmt(fmt) "gh_rsc_mgr_console: " fmt
+
+#include <linux/gunyah_rsc_mgr.h>
+#include <linux/auxiliary_bus.h>
+#include <linux/workqueue.h>
+#include <linux/spinlock.h>
+#include <linux/tty_flip.h>
+#include <linux/console.h>
+#include <linux/module.h>
+#include <linux/kfifo.h>
+#include <linux/kref.h>
+#include <linux/slab.h>
+#include <linux/tty.h>
+
+/*
+ * The Linux TTY code does not support dynamic addition of tty derived devices so we need to know
+ * how many tty devices we might need when space is allocated for the tty device. Since VMs might be
+ * added/removed dynamically, we need to make sure we have enough allocated.
+ */
+#define RSC_MGR_TTY_ADAPTERS		16
+
+/* # of payload bytes that can fit in a 1-fragment CONSOLE_WRITE message */
+#define RM_CONS_WRITE_MSG_SIZE	((1 * (GH_MSGQ_MAX_MSG_SIZE - 8)) - 4)
+
+struct rm_cons_port {
+	struct tty_port port;
+	u16 vmid;
+	bool open;
+	unsigned int index;
+
+	DECLARE_KFIFO(put_fifo, char, 1024);
+	spinlock_t fifo_lock;
+	struct work_struct put_work;
+
+	struct rm_cons_data *cons_data;
+};
+
+struct rm_cons_data {
+	struct tty_driver *tty_driver;
+	struct device *dev;
+
+	spinlock_t ports_lock;
+	struct rm_cons_port *ports[RSC_MGR_TTY_ADAPTERS];
+
+	struct notifier_block rsc_mgr_notif;
+	struct console console;
+};
+
+static void put_work_fn(struct work_struct *ws)
+{
+	char buf[RM_CONS_WRITE_MSG_SIZE];
+	int count, ret;
+	struct rm_cons_port *port = container_of(ws, struct rm_cons_port, put_work);
+
+	while (!kfifo_is_empty(&port->put_fifo)) {
+		count = kfifo_out_spinlocked(&port->put_fifo, buf, sizeof(buf), &port->fifo_lock);
+		if (count <= 0)
+			continue;
+
+		ret = gh_rm_console_write(port->vmid, buf, count);
+		if (ret) {
+			pr_warn_once("failed to send characters: %d\n", ret);
+			break;
+		}
+	}
+}
+
+static int rsc_mgr_console_notif(struct notifier_block *nb, unsigned long cmd, void *data)
+{
+	int count, i;
+	struct rm_cons_port *rm_port = NULL;
+	struct tty_port *tty_port = NULL;
+	struct rm_cons_data *cons_data = container_of(nb, struct rm_cons_data, rsc_mgr_notif);
+	const struct gh_rm_notification *notif = data;
+	struct gh_rm_notif_vm_console_chars const * const msg = notif->buff;
+
+	if (cmd != GH_RM_NOTIF_VM_CONSOLE_CHARS ||
+		notif->size < sizeof(*msg))
+		return NOTIFY_DONE;
+
+	spin_lock(&cons_data->ports_lock);
+	for (i = 0; i < RSC_MGR_TTY_ADAPTERS; i++) {
+		if (!cons_data->ports[i])
+			continue;
+		if (cons_data->ports[i]->vmid == msg->vmid) {
+			rm_port = cons_data->ports[i];
+			break;
+		}
+	}
+	if (rm_port)
+		tty_port = tty_port_get(&rm_port->port);
+	spin_unlock(&cons_data->ports_lock);
+
+	if (!rm_port)
+		pr_warn("Received unexpected console characters for VMID %u\n", msg->vmid);
+	if (!tty_port)
+		return NOTIFY_DONE;
+
+	count = tty_buffer_request_room(tty_port, msg->num_bytes);
+	tty_insert_flip_string(tty_port, msg->bytes, count);
+	tty_flip_buffer_push(tty_port);
+
+	tty_port_put(tty_port);
+	return NOTIFY_OK;
+}
+
+static ssize_t vmid_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct rm_cons_port *rm_port = dev_get_drvdata(dev);
+
+	if (rm_port->vmid == GH_VMID_SELF)
+		return sysfs_emit(buf, "self\n");
+
+	return sysfs_emit(buf, "%u\n", rm_port->vmid);
+}
+
+static DEVICE_ATTR_RO(vmid);
+
+static struct attribute *rsc_mgr_tty_dev_attrs[] = {
+	&dev_attr_vmid.attr,
+	NULL
+};
+
+static const struct attribute_group rsc_mgr_tty_dev_attr_group = {
+	.attrs = rsc_mgr_tty_dev_attrs,
+};
+
+static const struct attribute_group *rsc_mgr_tty_dev_attr_groups[] = {
+	&rsc_mgr_tty_dev_attr_group,
+	NULL
+};
+
+static int rsc_mgr_tty_open(struct tty_struct *tty, struct file *filp)
+{
+	int ret;
+	struct rm_cons_port *rm_port = dev_get_drvdata(tty->dev);
+
+	if (!rm_port->open) {
+		ret = gh_rm_console_open(rm_port->vmid);
+		if (ret) {
+			pr_err("Failed to open RM console for vmid %x: %d\n", rm_port->vmid, ret);
+			return ret;
+		}
+		rm_port->open = true;
+	}
+
+	return tty_port_open(&rm_port->port, tty, filp);
+}
+
+static void rsc_mgr_tty_close(struct tty_struct *tty, struct file *filp)
+{
+	int ret;
+	struct rm_cons_port *rm_port = dev_get_drvdata(tty->dev);
+
+	if (rm_port->open) {
+		if (rm_port->vmid != GH_VMID_SELF) {
+			ret = gh_rm_console_close(rm_port->vmid);
+			if (ret)
+				pr_warn("Failed to close RM console for vmid %d: %d\n",
+					rm_port->vmid, ret);
+		}
+		rm_port->open = false;
+
+		tty_port_close(&rm_port->port, tty, filp);
+	}
+
+}
+
+static int rsc_mgr_tty_write(struct tty_struct *tty, const unsigned char *buf, int count)
+{
+	struct rm_cons_port *rm_port = dev_get_drvdata(tty->dev);
+	int ret;
+
+	ret = kfifo_in_spinlocked(&rm_port->put_fifo, buf, count, &rm_port->fifo_lock);
+	if (ret > 0)
+		schedule_work(&rm_port->put_work);
+
+	return ret;
+}
+
+static unsigned int rsc_mgr_mgr_tty_write_room(struct tty_struct *tty)
+{
+	struct rm_cons_port *rm_port = dev_get_drvdata(tty->dev);
+
+	return kfifo_avail(&rm_port->put_fifo);
+}
+
+static void rsc_mgr_console_write(struct console *co, const char *buf, unsigned count)
+{
+	struct rm_cons_port *rm_port = co->data;
+	int ret;
+
+	ret = kfifo_in_spinlocked(&rm_port->put_fifo, buf, count, &rm_port->fifo_lock);
+	if (ret > 0)
+		schedule_work(&rm_port->put_work);
+}
+
+static struct tty_driver *rsc_mgr_console_device(struct console *co, int *index)
+{
+	struct rm_cons_port *rm_port = co->data;
+
+	*index = rm_port->index;
+	return rm_port->port.tty->driver;
+}
+
+static int rsc_mgr_console_setup(struct console *co, char *unused)
+{
+	int ret;
+	struct rm_cons_port *rm_port = co->data;
+
+	if (!rm_port->open) {
+		ret = gh_rm_console_open(rm_port->vmid);
+		if (ret) {
+			pr_err("Failed to open RM console for vmid %x: %d\n", rm_port->vmid, ret);
+			return ret;
+		}
+		rm_port->open = true;
+	}
+
+	return 0;
+}
+
+static int rsc_mgr_console_exit(struct console *co)
+{
+	int ret;
+	struct rm_cons_port *rm_port = co->data;
+
+	if (rm_port->open) {
+		ret = gh_rm_console_close(rm_port->vmid);
+		if (ret) {
+			pr_err("Failed to close RM console for vmid %x: %d\n", rm_port->vmid, ret);
+			return ret;
+		}
+		rm_port->open = false;
+	}
+
+	return 0;
+}
+
+static const struct tty_operations rsc_mgr_tty_ops = {
+	.open = rsc_mgr_tty_open,
+	.close = rsc_mgr_tty_close,
+	.write = rsc_mgr_tty_write,
+	.write_room = rsc_mgr_mgr_tty_write_room,
+};
+
+static void rsc_mgr_port_destruct(struct tty_port *port)
+{
+	struct rm_cons_port *rm_port = container_of(port, struct rm_cons_port, port);
+	struct rm_cons_data *cons_data = rm_port->cons_data;
+
+	spin_lock(&cons_data->ports_lock);
+	WARN_ON(cons_data->ports[rm_port->index] != rm_port);
+	cons_data->ports[rm_port->index] = NULL;
+	spin_unlock(&cons_data->ports_lock);
+	kfree(rm_port);
+}
+
+static const struct tty_port_operations rsc_mgr_port_ops = {
+	.destruct = rsc_mgr_port_destruct,
+};
+
+static struct rm_cons_port *rsc_mgr_port_create(struct rm_cons_data *cons_data, u16 vmid)
+{
+	struct rm_cons_port *rm_port;
+	struct device *ttydev;
+	unsigned int index;
+	int ret;
+
+	rm_port = kzalloc(sizeof(*rm_port), GFP_KERNEL);
+	rm_port->vmid = vmid;
+	INIT_KFIFO(rm_port->put_fifo);
+	spin_lock_init(&rm_port->fifo_lock);
+	INIT_WORK(&rm_port->put_work, put_work_fn);
+	tty_port_init(&rm_port->port);
+	rm_port->port.ops = &rsc_mgr_port_ops;
+
+	spin_lock(&cons_data->ports_lock);
+	for (index = 0; index < RSC_MGR_TTY_ADAPTERS; index++) {
+		if (!cons_data->ports[index]) {
+			cons_data->ports[index] = rm_port;
+			rm_port->index = index;
+			break;
+		}
+	}
+	spin_unlock(&cons_data->ports_lock);
+	if (index >= RSC_MGR_TTY_ADAPTERS) {
+		ret = -ENOSPC;
+		goto err_put_port;
+	}
+
+	ttydev = tty_port_register_device_attr(&rm_port->port, cons_data->tty_driver, index,
+					      cons_data->dev, rm_port, rsc_mgr_tty_dev_attr_groups);
+	if (IS_ERR(ttydev)) {
+		ret = PTR_ERR(ttydev);
+		goto err_put_port;
+	}
+
+	return rm_port;
+err_put_port:
+	tty_port_put(&rm_port->port);
+	return ERR_PTR(ret);
+}
+
+static int rsc_mgr_console_probe(struct auxiliary_device *auxdev,
+	const struct auxiliary_device_id *aux_dev_id)
+{
+	struct rm_cons_data *cons_data;
+	struct rm_cons_port *rm_port;
+	int ret;
+	u16 vmid;
+
+	cons_data = devm_kzalloc(&auxdev->dev, sizeof(*cons_data), GFP_KERNEL);
+	if (!cons_data)
+		return -ENOMEM;
+	dev_set_drvdata(&auxdev->dev, cons_data);
+	cons_data->dev = &auxdev->dev;
+
+	cons_data->tty_driver = tty_alloc_driver(RSC_MGR_TTY_ADAPTERS,
+						 TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV);
+	if (IS_ERR(cons_data->tty_driver))
+		return PTR_ERR(cons_data->tty_driver);
+
+	cons_data->tty_driver->driver_name = "gh";
+	cons_data->tty_driver->name = "ttyGH";
+	cons_data->tty_driver->type = TTY_DRIVER_TYPE_SYSTEM;
+	cons_data->tty_driver->init_termios = tty_std_termios;
+	tty_set_operations(cons_data->tty_driver, &rsc_mgr_tty_ops);
+
+	ret = tty_register_driver(cons_data->tty_driver);
+	if (ret) {
+		dev_err(&auxdev->dev, "Could not register tty driver: %d\n", ret);
+		goto err_put_tty;
+	}
+
+	spin_lock_init(&cons_data->ports_lock);
+
+	cons_data->rsc_mgr_notif.notifier_call = rsc_mgr_console_notif;
+	ret = gh_rm_register_notifier(&cons_data->rsc_mgr_notif);
+	if (ret) {
+		dev_err(&auxdev->dev, "Could not register for resource manager notifications: %d\n",
+			ret);
+		goto err_put_tty;
+	}
+
+	rm_port = rsc_mgr_port_create(cons_data, GH_VMID_SELF);
+	if (IS_ERR(rm_port)) {
+		ret = PTR_ERR(rm_port);
+		dev_err(&auxdev->dev, "Could not create own console: %d\n", ret);
+		goto err_unreg_notif;
+	}
+
+	strncpy(cons_data->console.name, "ttyGH", sizeof(cons_data->console.name));
+	cons_data->console.write = rsc_mgr_console_write;
+	cons_data->console.device = rsc_mgr_console_device;
+	cons_data->console.setup = rsc_mgr_console_setup;
+	cons_data->console.exit = rsc_mgr_console_exit;
+	cons_data->console.index = rm_port->index;
+	cons_data->console.data = rm_port;
+	register_console(&cons_data->console);
+
+	ret = gh_rm_get_vmid(&vmid);
+	if (!ret) {
+		rm_port = rsc_mgr_port_create(cons_data, vmid);
+		if (IS_ERR(rm_port))
+			dev_warn(&auxdev->dev, "Could not create loop-back console: %ld\n",
+				PTR_ERR(rm_port));
+	} else {
+		dev_warn(&auxdev->dev, "Failed to get this VM's VMID: %d. Not creating loop-back console\n",
+			 ret);
+	}
+
+	return 0;
+err_unreg_notif:
+	gh_rm_unregister_notifier(&cons_data->rsc_mgr_notif);
+err_put_tty:
+	tty_driver_kref_put(cons_data->tty_driver);
+	return ret;
+}
+
+static void rsc_mgr_console_remove(struct auxiliary_device *auxdev)
+{
+	struct rm_cons_data *cons_data = dev_get_drvdata(&auxdev->dev);
+
+	unregister_console(&cons_data->console);
+	gh_rm_unregister_notifier(&cons_data->rsc_mgr_notif);
+	tty_driver_kref_put(cons_data->tty_driver);
+}
+
+static struct auxiliary_device_id rsc_mgr_console_ids[] = {
+	{ .name = "gunyah_rsc_mgr.console" },
+	{}
+};
+MODULE_DEVICE_TABLE(auxiliary, rsc_mgr_console_ids);
+
+static struct auxiliary_driver rsc_mgr_console_drv = {
+	.probe = rsc_mgr_console_probe,
+	.remove = rsc_mgr_console_remove,
+	.id_table = rsc_mgr_console_ids,
+};
+module_auxiliary_driver(rsc_mgr_console_drv);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Gunyah Console");
-- 
2.25.1


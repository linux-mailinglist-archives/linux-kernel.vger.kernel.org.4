Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37FDA5FA922
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 02:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbiJKALD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 20:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbiJKAKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 20:10:02 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5788F193DF;
        Mon, 10 Oct 2022 17:09:46 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29AMp3ZQ020824;
        Tue, 11 Oct 2022 00:09:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=XFAz8+Jl6XNJGFSbiHb9TYEp8cP07MIlPe92gO674AY=;
 b=mYYR63Mu4Pkw9kPS5z4z8+CV3vrOB51Jz8qVJjA48DXbilezCNijtHC/ueI13oPm6o+o
 ZKnii5tRv0z5Gv/N/2LYcl4IrhLtfICiy+iEe5gZyjyBj8+zyLTCPtDj37RAc1myngZy
 cRf8cgQPgCyk5vqMAsCXwp/TBnt08ueihcRmsuPo9PeNxpclbs93zZl77dMTJ7tRj039
 3KZu7buNjSncWs1hdEwm9Gg4ureqY3kutXMkFGiUJvD3Vy5GOET6ZoREP0xuOwTNUUoF
 bZHBDElGFdLAD4LtcpVEC4rV+3SicXjvNaKVaFh5ZtC5KPQOhUAPj+9JmJx3wOWxo17F lg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k4rxa0hmj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Oct 2022 00:09:32 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29B09V46012990
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Oct 2022 00:09:31 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 10 Oct 2022 17:09:30 -0700
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
CC:     Elliot Berman <quic_eberman@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Srivatsa Vaddagiri" <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
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
Subject: [PATCH v5 13/13] tty: gunyah: Add tty console driver for RM Console Services
Date:   Mon, 10 Oct 2022 17:08:40 -0700
Message-ID: <20221011000840.289033-14-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221011000840.289033-1-quic_eberman@quicinc.com>
References: <20221011000840.289033-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5aFaaY3klHeFhllOpVENG9ztcqJCdnva
X-Proofpoint-GUID: 5aFaaY3klHeFhllOpVENG9ztcqJCdnva
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-10_12,2022-10-10_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 mlxscore=0 clxscore=1015 adultscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2210100143
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
 MAINTAINERS                  |   1 +
 drivers/tty/Kconfig          |   8 +
 drivers/tty/Makefile         |   1 +
 drivers/tty/gunyah_console.c | 439 +++++++++++++++++++++++++++++++++++
 4 files changed, 449 insertions(+)
 create mode 100644 drivers/tty/gunyah_console.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8a3d79b56698..e85140fa0dfe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8889,6 +8889,7 @@ F:	Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml
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
index 07aca5184a55..134b7321c630 100644
--- a/drivers/tty/Makefile
+++ b/drivers/tty/Makefile
@@ -27,5 +27,6 @@ obj-$(CONFIG_GOLDFISH_TTY)	+= goldfish.o
 obj-$(CONFIG_MIPS_EJTAG_FDC_TTY) += mips_ejtag_fdc.o
 obj-$(CONFIG_VCC)		+= vcc.o
 obj-$(CONFIG_RPMSG_TTY)		+= rpmsg_tty.o
+obj-$(CONFIG_GUNYAH_CONSOLE)	+= gunyah_console.o
 
 obj-y += ipwireless/
diff --git a/drivers/tty/gunyah_console.c b/drivers/tty/gunyah_console.c
new file mode 100644
index 000000000000..71d9f22c2a43
--- /dev/null
+++ b/drivers/tty/gunyah_console.c
@@ -0,0 +1,439 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/console.h>
+#include <linux/kfifo.h>
+#include <linux/kref.h>
+#include <linux/gunyah_rsc_mgr.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/tty.h>
+#include <linux/tty_flip.h>
+#include <linux/workqueue.h>
+
+/*
+ * The Linux TTY code requires us to know ahead of time how many ports we might
+ * need. Each port here corresponds to a VM. 16 seems like a reasonable number
+ * of ports for systems that are running Gunyah and using the console interface.
+ */
+#define RM_CONS_TTY_ADAPATERS		(16)
+
+struct rm_cons_port {
+	struct tty_port port;
+	u16 vmid;
+	unsigned int index;
+};
+
+struct rm_cons_drv_data {
+	struct tty_driver *tty_driver;
+	struct device *dev;
+
+	spinlock_t ports_lock;
+	struct rm_cons_port *ports[RM_CONS_TTY_ADAPATERS];
+
+	struct notifier_block rm_cons_notif;
+	struct console console;
+
+	/* below are for printk console.
+	 * gh_rm_console_* calls will sleep and console_write can be called from
+	 * atomic ctx. Two xmit buffers are used. The active buffer is tracked with
+	 * co_xmit_idx. Writes go into the co_xmit_buf[co_xmit_idx] buffer.
+	 * A work is scheduled to flush the bytes. The work will swap the active buffer
+	 * and write out the other buffer.
+	 */
+	char *co_xmit_buf[2];
+	int co_xmit_idx;
+	unsigned int co_xmit_count;
+	spinlock_t co_xmit_lock;
+	struct work_struct co_flush_work;
+};
+
+static int rm_cons_notif_handler(struct notifier_block *nb, unsigned long cmd, void *data)
+{
+	int count, i;
+	struct rm_cons_port *rm_port = NULL;
+	struct tty_port *tty_port = NULL;
+	struct rm_cons_drv_data *cons_data =
+		container_of(nb, struct rm_cons_drv_data, rm_cons_notif);
+	const struct gh_rm_notification *notif = data;
+	struct gh_rm_notif_vm_console_chars const * const msg = notif->buff;
+
+	if (cmd != GH_RM_NOTIF_VM_CONSOLE_CHARS ||
+		notif->size < sizeof(*msg))
+		return NOTIFY_DONE;
+
+	spin_lock(&cons_data->ports_lock);
+	for (i = 0; i < RM_CONS_TTY_ADAPATERS; i++) {
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
+		dev_warn(cons_data->dev, "Received unexpected console characters for VMID %u\n",
+			msg->vmid);
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
+static int rm_cons_tty_open(struct tty_struct *tty, struct file *filp)
+{
+	struct rm_cons_port *rm_port = dev_get_drvdata(tty->dev);
+
+	return tty_port_open(&rm_port->port, tty, filp);
+}
+
+static void rm_cons_tty_close(struct tty_struct *tty, struct file *filp)
+{
+	struct rm_cons_port *rm_port = dev_get_drvdata(tty->dev);
+
+	tty_port_close(&rm_port->port, tty, filp);
+}
+
+static int rm_cons_tty_write(struct tty_struct *tty, const unsigned char *buf, int count)
+{
+	struct rm_cons_port *rm_port = dev_get_drvdata(tty->dev);
+	int ret;
+
+	if (!count)
+		return 0;
+
+	ret = gh_rm_console_write(rm_port->vmid, buf, count);
+	if (ret)
+		return -EAGAIN;
+	return count;
+}
+
+static void rm_cons_tty_flush_chars(struct tty_struct *tty)
+{
+	struct rm_cons_port *rm_port = dev_get_drvdata(tty->dev);
+
+	gh_rm_console_flush(rm_port->vmid);
+}
+
+static unsigned int rm_cons_mgr_tty_write_room(struct tty_struct *tty)
+{
+	return GH_RM_CONSOLE_WRITE_CHARS;
+}
+
+static const struct tty_operations rm_cons_tty_ops = {
+	.open = rm_cons_tty_open,
+	.close = rm_cons_tty_close,
+	.write = rm_cons_tty_write,
+	.flush_chars = rm_cons_tty_flush_chars,
+	.write_room = rm_cons_mgr_tty_write_room,
+};
+
+static int rm_cons_port_activate(struct tty_port *port, struct tty_struct *tty)
+{
+	struct rm_cons_port *rm_port = container_of(port, struct rm_cons_port, port);
+
+	return gh_rm_console_open(rm_port->vmid);
+}
+
+static void rm_cons_port_shutdown(struct tty_port *port)
+{
+	struct rm_cons_port *rm_port = container_of(port, struct rm_cons_port, port);
+	int ret;
+
+	ret = gh_rm_console_close(rm_port->vmid);
+	if (ret)
+		dev_err(port->tty->dev, "Failed to close ttyGH%d: %d\n", rm_port->index, ret);
+}
+
+static void rm_cons_port_destruct(struct tty_port *port)
+{
+	struct rm_cons_port *rm_port = container_of(port, struct rm_cons_port, port);
+	struct rm_cons_drv_data *cons_data = dev_get_drvdata(port->tty->dev);
+
+	spin_lock(&cons_data->ports_lock);
+	cons_data->ports[rm_port->index] = NULL;
+	spin_unlock(&cons_data->ports_lock);
+	kfree(rm_port);
+}
+
+static const struct tty_port_operations rm_cons_port_ops = {
+	.activate = rm_cons_port_activate,
+	.shutdown = rm_cons_port_shutdown,
+	.destruct = rm_cons_port_destruct,
+};
+
+static void rm_cons_console_flush_work(struct work_struct *ws)
+{
+	struct rm_cons_drv_data *cons_data =
+		container_of(ws, struct rm_cons_drv_data, co_flush_work);
+	struct console *co = &cons_data->console;
+	struct rm_cons_port *rm_port = co->data;
+	unsigned long flags;
+	size_t size;
+	int ret, old_buf = cons_data->co_xmit_idx;
+
+	spin_lock_irqsave(&cons_data->co_xmit_lock, flags);
+	cons_data->co_xmit_idx = 1 - old_buf;
+	size = cons_data->co_xmit_count;
+	cons_data->co_xmit_count = 0;
+	spin_unlock_irqrestore(&cons_data->co_xmit_lock, flags);
+
+	do {
+		ret = gh_rm_console_write(rm_port->vmid, cons_data->co_xmit_buf[old_buf], size);
+	} while (ret && ret != -ENOMEM);
+
+	gh_rm_console_flush(rm_port->vmid);
+}
+
+static void rm_cons_console_write(struct console *co, const char *buf, unsigned count)
+{
+	struct rm_cons_drv_data *cons_data = container_of(co, struct rm_cons_drv_data, console);
+	unsigned long flags;
+
+	spin_lock_irqsave(&cons_data->co_xmit_lock, flags);
+	count = min(count, (unsigned)(PAGE_SIZE - cons_data->co_xmit_count));
+	memcpy(&cons_data->co_xmit_buf[cons_data->co_xmit_idx][cons_data->co_xmit_count], buf,
+		count);
+	cons_data->co_xmit_count += count;
+	spin_unlock_irqrestore(&cons_data->co_xmit_lock, flags);
+
+	schedule_work(&cons_data->co_flush_work);
+}
+
+static struct tty_driver *rm_cons_console_device(struct console *co, int *index)
+{
+	struct rm_cons_drv_data *cons_data = container_of(co, struct rm_cons_drv_data, console);
+	struct rm_cons_port *rm_port = co->data;
+
+	*index = rm_port->index;
+	return cons_data->tty_driver;
+}
+
+static int rm_cons_console_setup(struct console *co, char *unused)
+{
+	struct rm_cons_drv_data *cons_data = container_of(co, struct rm_cons_drv_data, console);
+	struct rm_cons_port *rm_port = co->data;
+	int ret;
+
+	if (!tty_port_get(&rm_port->port))
+		return -ENODEV;
+
+	cons_data->co_xmit_buf[0] = (unsigned char *)get_zeroed_page(GFP_KERNEL);
+	if (!cons_data->co_xmit_buf[0])
+		goto err;
+	cons_data->co_xmit_buf[1] = (unsigned char *)get_zeroed_page(GFP_KERNEL);
+	if (!cons_data->co_xmit_buf[1])
+		goto err;
+
+	mutex_lock(&rm_port->port.mutex);
+	if (!tty_port_initialized(&rm_port->port)) {
+		ret = gh_rm_console_open(rm_port->vmid);
+		if (ret) {
+			dev_err(rm_port->port.tty->dev, "Failed to open %s%d: %d\n",
+				co->name, rm_port->index, ret);
+			goto err;
+		}
+		tty_port_set_initialized(&rm_port->port, true);
+	}
+	rm_port->port.console = true;
+	mutex_unlock(&rm_port->port.mutex);
+
+	return 0;
+err:
+	if (cons_data->co_xmit_buf[1])
+		free_page((unsigned long)cons_data->co_xmit_buf[1]);
+	if (cons_data->co_xmit_buf[0])
+		free_page((unsigned long)cons_data->co_xmit_buf[0]);
+	mutex_unlock(&rm_port->port.mutex);
+	tty_port_put(&rm_port->port);
+	return ret;
+}
+
+static int rm_cons_console_exit(struct console *co)
+{
+	struct rm_cons_port *rm_port = co->data;
+	int ret;
+
+	mutex_lock(&rm_port->port.mutex);
+	rm_port->port.console = false;
+
+	if (!tty_port_active(&rm_port->port)) {
+		ret = gh_rm_console_close(rm_port->vmid);
+		if (ret)
+			dev_err(rm_port->port.tty->dev, "Failed to close %s%d: %d\n",
+				co->name, rm_port->index, ret);
+		tty_port_set_initialized(&rm_port->port, false);
+	}
+
+	mutex_unlock(&rm_port->port.mutex);
+	tty_port_put(&rm_port->port);
+
+	return 0;
+}
+
+static struct rm_cons_port *rm_cons_port_create(struct rm_cons_drv_data *cons_data, u16 vmid)
+{
+	struct rm_cons_port *rm_port;
+	struct device *ttydev;
+	unsigned int index;
+	int ret;
+
+	rm_port = kzalloc(sizeof(*rm_port), GFP_KERNEL);
+	if (!rm_port)
+		return ERR_PTR(-ENOMEM);
+	rm_port->vmid = vmid;
+	tty_port_init(&rm_port->port);
+	rm_port->port.ops = &rm_cons_port_ops;
+
+	spin_lock(&cons_data->ports_lock);
+	for (index = 0; index < RM_CONS_TTY_ADAPATERS; index++) {
+		if (!cons_data->ports[index]) {
+			cons_data->ports[index] = rm_port;
+			rm_port->index = index;
+			break;
+		}
+	}
+	spin_unlock(&cons_data->ports_lock);
+	if (index >= RM_CONS_TTY_ADAPATERS) {
+		ret = -ENOSPC;
+		goto err_put_port;
+	}
+
+	ttydev = tty_port_register_device_attr(&rm_port->port, cons_data->tty_driver, index,
+					      cons_data->dev, rm_port, NULL);
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
+static int rm_cons_console_probe(struct device *dev)
+{
+	struct rm_cons_drv_data *cons_data;
+	struct rm_cons_port *rm_port;
+	int ret;
+	u16 vmid;
+
+	cons_data = devm_kzalloc(dev, sizeof(*cons_data), GFP_KERNEL);
+	if (!cons_data)
+		return -ENOMEM;
+	dev_set_drvdata(dev, cons_data);
+	cons_data->dev = dev;
+
+	cons_data->tty_driver = tty_alloc_driver(RM_CONS_TTY_ADAPATERS,
+						 TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV |
+						 TTY_DRIVER_RESET_TERMIOS);
+	if (IS_ERR(cons_data->tty_driver))
+		return PTR_ERR(cons_data->tty_driver);
+
+	cons_data->tty_driver->driver_name = KBUILD_MODNAME;
+	cons_data->tty_driver->name = "ttyGH";
+	cons_data->tty_driver->type = TTY_DRIVER_TYPE_SYSTEM;
+	cons_data->tty_driver->subtype = SYSTEM_TYPE_TTY;
+	cons_data->tty_driver->init_termios = tty_std_termios;
+	tty_set_operations(cons_data->tty_driver, &rm_cons_tty_ops);
+
+	ret = tty_register_driver(cons_data->tty_driver);
+	if (ret) {
+		dev_err(dev, "Could not register tty driver: %d\n", ret);
+		goto err_put_tty;
+	}
+
+	spin_lock_init(&cons_data->ports_lock);
+
+	cons_data->rm_cons_notif.notifier_call = rm_cons_notif_handler;
+	ret = gh_rm_register_notifier(&cons_data->rm_cons_notif);
+	if (ret) {
+		dev_err(dev, "Could not register for resource manager notifications: %d\n", ret);
+		goto err_put_tty;
+	}
+
+	spin_lock_init(&cons_data->co_xmit_lock);
+	INIT_WORK(&cons_data->co_flush_work, rm_cons_console_flush_work);
+
+	rm_port = rm_cons_port_create(cons_data, GH_VMID_SELF);
+	if (IS_ERR(rm_port)) {
+		ret = PTR_ERR(rm_port);
+		dev_err(dev, "Could not create own console: %d\n", ret);
+		goto err_unreg_notif;
+	}
+
+	rm_port->port.console = 1;
+	strncpy(cons_data->console.name, "ttyGH", sizeof(cons_data->console.name));
+	cons_data->console.write = rm_cons_console_write;
+	cons_data->console.device = rm_cons_console_device;
+	cons_data->console.setup = rm_cons_console_setup;
+	cons_data->console.exit = rm_cons_console_exit;
+	cons_data->console.index = rm_port->index;
+	cons_data->console.data = rm_port;
+	register_console(&cons_data->console);
+
+	ret = gh_rm_get_vmid(&vmid);
+	if (!ret) {
+		rm_port = rm_cons_port_create(cons_data, vmid);
+		if (IS_ERR(rm_port))
+			dev_warn(dev, "Could not create loopback console: %ld\n", PTR_ERR(rm_port));
+	} else {
+		dev_warn(dev, "Failed to get this VM's VMID: %d. Not creating loop-back console\n",
+			 ret);
+	}
+
+	return 0;
+err_unreg_notif:
+	gh_rm_unregister_notifier(&cons_data->rm_cons_notif);
+err_put_tty:
+	tty_driver_kref_put(cons_data->tty_driver);
+	return ret;
+}
+
+static int rm_cons_console_remove(struct device *dev)
+{
+	struct rm_cons_drv_data *cons_data = dev_get_drvdata(dev);
+
+	unregister_console(&cons_data->console);
+	if (cons_data->co_xmit_buf[1])
+		free_page((unsigned long)cons_data->co_xmit_buf[1]);
+	if (cons_data->co_xmit_buf[0])
+		free_page((unsigned long)cons_data->co_xmit_buf[0]);
+	gh_rm_unregister_notifier(&cons_data->rm_cons_notif);
+	tty_unregister_driver(cons_data->tty_driver);
+	tty_driver_kref_put(cons_data->tty_driver);
+
+	return 0;
+}
+
+static struct gunyah_rm_cons_device_id rm_cons_console_ids[] = {
+	{ .name = GH_RM_DEVICE_CONSOLE },
+	{}
+};
+MODULE_DEVICE_TABLE(gunyah_rsc_mgr, rm_cons_console_ids);
+
+static struct gh_rm_driver rm_cons_console_drv = {
+	.drv = {
+		.name = KBUILD_MODNAME,
+		.probe = rm_cons_console_probe,
+		.remove = rm_cons_console_remove,
+	},
+	.id_table = rm_cons_console_ids,
+};
+module_gh_rm_driver(rm_cons_console_drv);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Gunyah Console");
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6786AA71D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 02:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjCDBJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 20:09:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjCDBJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 20:09:29 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B7ABB9C;
        Fri,  3 Mar 2023 17:08:02 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3240J06l028516;
        Sat, 4 Mar 2023 01:07:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=vpOwzZQLrpmHaihmYhdcY2zbPs5StQEqOQFTEOCreb8=;
 b=R5DuSNfZHSZwnUGbomtO0mkgWDuzJsQnYZX1REN5qfI7uKLAFyeff6ZmFxiprfmakHwy
 u7YTUqKs+qdluMTXDrs0p5ifaus9Y7lxUJzRbS8o+fsfbLG3pliXGm4QGRVG0DFLZhJ8
 6nhNqizl/9eM+PHRTm42iUXZy8L1I25ss5DbTllaRsziYRdp71IQMECMLssutgZIu/AM
 qiYAcakUWQ3DLF9hER3a+TM03blzsf3RLWVbqwV8EcqT62gAKC/Q59gKS288msxjHATP
 8SSIemUIBOYRs7QwYpqV8vAPAKROUKd7XmuavXTMU1ftBxAhvEnSlXF/jI3bg8mvAJEt ig== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p36mybgjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 04 Mar 2023 01:07:21 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32417LVl026133
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 4 Mar 2023 01:07:21 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 3 Mar 2023 17:07:20 -0800
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>
CC:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v11 24/26] virt: gunyah: Add irqfd interface
Date:   Fri, 3 Mar 2023 17:06:30 -0800
Message-ID: <20230304010632.2127470-25-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230304010632.2127470-1-quic_eberman@quicinc.com>
References: <20230304010632.2127470-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: unE253sIrpOs0k8Rbcml-qsvAYKgF2b7
X-Proofpoint-ORIG-GUID: unE253sIrpOs0k8Rbcml-qsvAYKgF2b7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_07,2023-03-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 clxscore=1015 mlxscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303040005
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable support for creating irqfds which can raise an interrupt on a
Gunyah virtual machine. irqfds are exposed to userspace as a Gunyah VM
function with the name "irqfd". If the VM devicetree is not configured
to create a doorbell with the corresponding label, userspace will still
be able to assert the eventfd but no interrupt will be raised on the
guest.

Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 Documentation/virt/gunyah/vm-manager.rst |   2 +-
 drivers/virt/gunyah/Kconfig              |   9 ++
 drivers/virt/gunyah/Makefile             |   1 +
 drivers/virt/gunyah/gunyah_irqfd.c       | 164 +++++++++++++++++++++++
 include/linux/gunyah.h                   |   5 +
 include/uapi/linux/gunyah.h              |  30 +++++
 6 files changed, 210 insertions(+), 1 deletion(-)
 create mode 100644 drivers/virt/gunyah/gunyah_irqfd.c

diff --git a/Documentation/virt/gunyah/vm-manager.rst b/Documentation/virt/gunyah/vm-manager.rst
index 83d326b0d11f..a1dd70f0cbf6 100644
--- a/Documentation/virt/gunyah/vm-manager.rst
+++ b/Documentation/virt/gunyah/vm-manager.rst
@@ -124,7 +124,7 @@ the VM starts.
 The possible types are documented below:
 
 .. kernel-doc:: include/uapi/linux/gunyah.h
-   :identifiers: GH_FN_VCPU gh_fn_vcpu_arg
+   :identifiers: GH_FN_VCPU gh_fn_vcpu_arg GH_FN_IRQFD gh_fn_irqfd_arg
 
 Gunyah VCPU API Descriptions
 ----------------------------
diff --git a/drivers/virt/gunyah/Kconfig b/drivers/virt/gunyah/Kconfig
index 4c1c6110b50e..2cde24d429d1 100644
--- a/drivers/virt/gunyah/Kconfig
+++ b/drivers/virt/gunyah/Kconfig
@@ -26,3 +26,12 @@ config GUNYAH_VCPU
 	  VMMs can also handle stage 2 faults of the vCPUs.
 
 	  Say Y/M here if unsure and you want to support Gunyah VMMs.
+
+config GUNYAH_IRQFD
+	tristate "Gunyah irqfd interface"
+	depends on GUNYAH
+	help
+	  Enable kernel support for creating irqfds which can raise an interrupt
+	  on Gunyah virtual machine.
+
+	  Say Y/M here if unsure and you want to support Gunyah VMMs.
diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
index 2d1b604a7b03..6cf756bfa3c2 100644
--- a/drivers/virt/gunyah/Makefile
+++ b/drivers/virt/gunyah/Makefile
@@ -7,3 +7,4 @@ gunyah_rsc_mgr-y += rsc_mgr.o rsc_mgr_rpc.o vm_mgr.o vm_mgr_mm.o
 obj-$(CONFIG_GUNYAH) += gunyah_rsc_mgr.o
 
 obj-$(CONFIG_GUNYAH_VCPU) += gunyah_vcpu.o
+obj-$(CONFIG_GUNYAH_IRQFD) += gunyah_irqfd.o
diff --git a/drivers/virt/gunyah/gunyah_irqfd.c b/drivers/virt/gunyah/gunyah_irqfd.c
new file mode 100644
index 000000000000..38e5fe266b00
--- /dev/null
+++ b/drivers/virt/gunyah/gunyah_irqfd.c
@@ -0,0 +1,164 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/eventfd.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/gunyah.h>
+#include <linux/gunyah_vm_mgr.h>
+#include <linux/module.h>
+#include <linux/poll.h>
+#include <linux/printk.h>
+
+#include <uapi/linux/gunyah.h>
+
+struct gh_irqfd {
+	struct gh_resource *ghrsc;
+	struct gh_vm_resource_ticket ticket;
+	struct gh_vm_function_instance *f;
+
+	bool level;
+
+	struct eventfd_ctx *ctx;
+	wait_queue_entry_t wait;
+	poll_table pt;
+};
+
+static int irqfd_wakeup(wait_queue_entry_t *wait, unsigned int mode, int sync, void *key)
+{
+	struct gh_irqfd *irqfd = container_of(wait, struct gh_irqfd, wait);
+	__poll_t flags = key_to_poll(key);
+	u64 enable_mask = GH_BELL_NONBLOCK;
+	u64 old_flags;
+	int ret = 0;
+
+	if (flags & EPOLLIN) {
+		if (irqfd->ghrsc) {
+			ret = gh_hypercall_bell_send(irqfd->ghrsc->capid, enable_mask, &old_flags);
+			if (ret)
+				pr_err_ratelimited("Failed to inject interrupt %d: %d\n",
+						irqfd->ticket.label, ret);
+		} else
+			pr_err_ratelimited("Premature injection of interrupt\n");
+	}
+
+	return 0;
+}
+
+static void irqfd_ptable_queue_proc(struct file *file, wait_queue_head_t *wqh, poll_table *pt)
+{
+	struct gh_irqfd *irq_ctx = container_of(pt, struct gh_irqfd, pt);
+
+	add_wait_queue(wqh, &irq_ctx->wait);
+}
+
+static int gh_irqfd_populate(struct gh_vm_resource_ticket *ticket, struct gh_resource *ghrsc)
+{
+	struct gh_irqfd *irqfd = container_of(ticket, struct gh_irqfd, ticket);
+	u64 enable_mask = GH_BELL_NONBLOCK;
+	u64 ack_mask = ~0;
+	int ret = 0;
+
+	if (irqfd->ghrsc) {
+		pr_warn("irqfd%d already got a Gunyah resource. Check if multiple resources with same label were configured.\n",
+			irqfd->ticket.label);
+		return -1;
+	}
+
+	irqfd->ghrsc = ghrsc;
+	if (irqfd->level) {
+		ret = gh_hypercall_bell_set_mask(irqfd->ghrsc->capid, enable_mask, ack_mask);
+		if (ret)
+			pr_warn("irq %d couldn't be set as level triggered. Might cause IRQ storm if asserted\n",
+				irqfd->ticket.label);
+	}
+
+	return 0;
+}
+
+static void gh_irqfd_unpopulate(struct gh_vm_resource_ticket *ticket, struct gh_resource *ghrsc)
+{
+	struct gh_irqfd *irqfd = container_of(ticket, struct gh_irqfd, ticket);
+	u64 cnt;
+
+	eventfd_ctx_remove_wait_queue(irqfd->ctx, &irqfd->wait, &cnt);
+}
+
+static long gh_irqfd_bind(struct gh_vm_function_instance *f)
+{
+	struct gh_fn_irqfd_arg *args = f->argp;
+	struct gh_irqfd *irqfd;
+	__poll_t events;
+	struct fd fd;
+	long r;
+
+	if (f->arg_size != sizeof(*args))
+		return -EINVAL;
+
+	/* All other flag bits are reserved for future use */
+	if (args->flags & ~GH_IRQFD_LEVEL)
+		return -EINVAL;
+
+	irqfd = kzalloc(sizeof(*irqfd), GFP_KERNEL);
+	if (!irqfd)
+		return -ENOMEM;
+
+	irqfd->f = f;
+	f->data = irqfd;
+
+	fd = fdget(args->fd);
+	if (!fd.file) {
+		kfree(irqfd);
+		return -EBADF;
+	}
+
+	irqfd->ctx = eventfd_ctx_fileget(fd.file);
+	if (IS_ERR(irqfd->ctx)) {
+		r = PTR_ERR(irqfd->ctx);
+		goto err_fdput;
+	}
+
+	if (args->flags & GH_IRQFD_LEVEL)
+		irqfd->level = true;
+
+	init_waitqueue_func_entry(&irqfd->wait, irqfd_wakeup);
+	init_poll_funcptr(&irqfd->pt, irqfd_ptable_queue_proc);
+
+	irqfd->ticket.resource_type = GH_RESOURCE_TYPE_BELL_TX;
+	irqfd->ticket.label = args->label;
+	irqfd->ticket.owner = THIS_MODULE;
+	irqfd->ticket.populate = gh_irqfd_populate;
+	irqfd->ticket.unpopulate = gh_irqfd_unpopulate;
+
+	r = gh_vm_add_resource_ticket(f->ghvm, &irqfd->ticket);
+	if (r)
+		goto err_ctx;
+
+	events = vfs_poll(fd.file, &irqfd->pt);
+	if (events & EPOLLIN)
+		pr_warn("Premature injection of interrupt\n");
+	fdput(fd);
+
+	return 0;
+err_ctx:
+	eventfd_ctx_put(irqfd->ctx);
+err_fdput:
+	fdput(fd);
+	kfree(irqfd);
+	return r;
+}
+
+static void gh_irqfd_unbind(struct gh_vm_function_instance *f)
+{
+	struct gh_irqfd *irqfd = f->data;
+
+	gh_vm_remove_resource_ticket(irqfd->f->ghvm, &irqfd->ticket);
+	eventfd_ctx_put(irqfd->ctx);
+	kfree(irqfd);
+}
+
+DECLARE_GH_VM_FUNCTION_INIT(irqfd, GH_FN_IRQFD, gh_irqfd_bind, gh_irqfd_unbind);
+MODULE_DESCRIPTION("Gunyah irqfds");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/gunyah.h b/include/linux/gunyah.h
index 63395dacc1a8..0344b6988cfa 100644
--- a/include/linux/gunyah.h
+++ b/include/linux/gunyah.h
@@ -33,6 +33,11 @@ struct gh_resource {
 	u32 rm_label;
 };
 
+/**
+ * Gunyah Doorbells
+ */
+#define GH_BELL_NONBLOCK		BIT(32)
+
 /**
  * Gunyah Message Queues
  */
diff --git a/include/uapi/linux/gunyah.h b/include/uapi/linux/gunyah.h
index e52265fa5715..5617dadc1c7b 100644
--- a/include/uapi/linux/gunyah.h
+++ b/include/uapi/linux/gunyah.h
@@ -76,6 +76,19 @@ struct gh_vm_dtb_config {
  */
 #define GH_FN_VCPU 		1
 
+/**
+ * GH_FN_IRQFD - register eventfd to assert a Gunyah doorbell
+ *
+ * gh_fn_desc is filled with gh_fn_irqfd_arg
+ *
+ * Allows setting an eventfd to directly trigger a guest interrupt.
+ * irqfd.fd specifies the file descriptor to use as the eventfd.
+ * irqfd.label corresponds to the doorbell label used in the guest VM's devicetree.
+ *
+ * Return: 0
+ */
+#define GH_FN_IRQFD 		2
+
 #define GH_FN_MAX_ARG_SIZE		256
 
 /**
@@ -88,6 +101,23 @@ struct gh_fn_vcpu_arg {
 
 #define GH_IRQFD_LEVEL			(1UL << 0)
 
+/**
+ * struct gh_fn_irqfd_arg - Arguments to create an irqfd function
+ * @fd: an eventfd which when written to will raise a doorbell
+ * @label: Label of the doorbell created on the guest VM
+ * @flags: GH_IRQFD_LEVEL configures the corresponding doorbell to behave
+ *         like a level triggered interrupt.
+ * @padding: padding bytes
+ */
+struct gh_fn_irqfd_arg {
+	__u32 fd;
+	__u32 label;
+	__u32 flags;
+	__u32 padding;
+};
+
+#define GH_IOEVENTFD_DATAMATCH		(1UL << 0)
+
 /**
  * struct gh_fn_desc - Arguments to create a VM function
  * @type: Type of the function. See GH_FN_* macro for supported types
-- 
2.39.2


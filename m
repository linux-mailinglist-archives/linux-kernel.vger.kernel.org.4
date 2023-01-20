Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B33676177
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 00:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjATXXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 18:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjATXXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 18:23:47 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B9673EE2;
        Fri, 20 Jan 2023 15:23:45 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KMddvj029658;
        Fri, 20 Jan 2023 22:48:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=fb0yRpVmhMXXS6AyR3FeSmfPN/D1GiSlLNNO1AqAe2I=;
 b=A3vzg1Up4h19vdn/REubMpgX9Z+o27tXJJOLLJpIYjP67QXoYx+ii3nlmT90cJ7YVnn/
 BOHav4N5vQIbO+c1rpkM/OFSHA0a9lRtLjBFGNsZv6ctphci0QYoSq/8lKCZSAu+UT4S
 lVXn63q3ALX6Fl2Z0+FYQ9aplOL3IfOuBkJ7o/c41x163cV/XmR0Jzg3FpSQ2tCi2ldG
 DMn4Yw0/I29Ts9eQXeXn68uwJQYcAYyRHHAYHZNxDGQ3AFSt2dECnDS346LUKns7o6ZQ
 icamG3fnb8ix9Oloea/qa70R+oSoahkoppN7Aler9mOVxwwI6EyZZkSzWU5TQNuu5nOw oA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n7xm40k9n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 22:48:11 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30KMmA7K029482
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 22:48:11 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 20 Jan 2023 14:48:10 -0800
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Alex Elder <elder@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>
CC:     Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v9 26/27] virt: gunyah: Add irqfd interface
Date:   Fri, 20 Jan 2023 14:46:25 -0800
Message-ID: <20230120224627.4053418-27-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230120224627.4053418-1-quic_eberman@quicinc.com>
References: <20230120224627.4053418-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: M1eYgToxgYnRDIieRSUBBmswDMFw9s8A
X-Proofpoint-GUID: M1eYgToxgYnRDIieRSUBBmswDMFw9s8A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_11,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 impostorscore=0 mlxscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301200218
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
 Documentation/virt/gunyah/vm-manager.rst |  22 +++
 drivers/virt/gunyah/Kconfig              |   9 ++
 drivers/virt/gunyah/Makefile             |   1 +
 drivers/virt/gunyah/gunyah_irqfd.c       | 166 +++++++++++++++++++++++
 include/linux/gunyah.h                   |   5 +
 include/uapi/linux/gunyah.h              |  11 +-
 6 files changed, 213 insertions(+), 1 deletion(-)
 create mode 100644 drivers/virt/gunyah/gunyah_irqfd.c

diff --git a/Documentation/virt/gunyah/vm-manager.rst b/Documentation/virt/gunyah/vm-manager.rst
index d11267d59802..b6cf8db826b8 100644
--- a/Documentation/virt/gunyah/vm-manager.rst
+++ b/Documentation/virt/gunyah/vm-manager.rst
@@ -142,3 +142,25 @@ The vcpu type will register with the VM Manager to expect to control
 vCPU number `vcpu_id`. It returns a file descriptor allowing interaction with
 the vCPU. See the Gunyah vCPU API description sections for interacting with
 the Gunyah vCPU file descriptors.
+
+Type: "irqfd"
+^^^^^^^^^^^^^
+
+::
+
+  struct gh_fn_irqfd_arg {
+	__u32 fd;
+	__u32 label;
+  #define GH_IRQFD_LEVEL			(1UL << 0)
+  #define GH_IRQFD_DEASSIGN		(1UL << 1)
+	__u32 flags;
+  };
+
+Allows setting an eventfd to directly trigger a guest interrupt.
+irqfd.fd specifies the file descriptor to use as the eventfd.
+irqfd.label corresponds to the doorbell label used in the guest VM's devicetree.
+The irqfd is removed using the GH_IRQFD_DEASSIGN flag and specifying at least
+the irqfd.label.
+
+GH_IRQFD_LEVEL configures the corresponding doorbell to behave like a level
+triggered interrupt.
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
index 000000000000..a3be9ca2377a
--- /dev/null
+++ b/drivers/virt/gunyah/gunyah_irqfd.c
@@ -0,0 +1,166 @@
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
+#include <linux/kref.h>
+#include <linux/module.h>
+#include <linux/poll.h>
+#include <linux/printk.h>
+
+#include <uapi/linux/gunyah.h>
+
+struct gunyah_irqfd {
+	struct gunyah_resource *ghrsc;
+	struct gunyah_vm_resource_ticket ticket;
+	struct gunyah_vm_function *f;
+
+	struct kref kref;
+	bool level;
+
+	struct eventfd_ctx *ctx;
+	wait_queue_entry_t wait;
+	poll_table pt;
+	struct fd fd;
+};
+
+static void gh_irqfd_cleanup(struct kref *kref)
+{
+	struct gunyah_irqfd *irqfd = container_of(kref, struct gunyah_irqfd, kref);
+
+	kfree(irqfd);
+}
+
+static int irqfd_wakeup(wait_queue_entry_t *wait, unsigned int mode, int sync, void *key)
+{
+	struct gunyah_irqfd *irqfd = container_of(wait, struct gunyah_irqfd, wait);
+	__poll_t flags = key_to_poll(key);
+	u64 enable_mask = GH_DBL_NONBLOCK;
+	u64 old_flags;
+	int ret = 0;
+
+	if (flags & EPOLLIN) {
+		if (irqfd->ghrsc) {
+			ret = gh_hypercall_dbl_send(irqfd->ghrsc->capid, enable_mask, &old_flags);
+			if (ret)
+				pr_err("Failed to assert irq %d\n", irqfd->f->fn.irqfd.label);
+		}
+	}
+
+	return 0;
+}
+
+static void irqfd_ptable_queue_proc(struct file *file, wait_queue_head_t *wqh, poll_table *pt)
+{
+	struct gunyah_irqfd *irq_ctx = container_of(pt, struct gunyah_irqfd, pt);
+
+	add_wait_queue(wqh, &irq_ctx->wait);
+}
+
+static int gunyah_irqfd_populate(struct gunyah_vm_resource_ticket *ticket,
+				struct gunyah_resource *ghrsc)
+{
+	struct gunyah_irqfd *irqfd = container_of(ticket, struct gunyah_irqfd, ticket);
+	u64 enable_mask = GH_DBL_NONBLOCK;
+	u64 ack_mask = ~0;
+	int ret = 0;
+
+	irqfd->ghrsc = ghrsc;
+	if (irqfd->level) {
+		ret = gh_hypercall_dbl_set_mask(irqfd->ghrsc->capid, enable_mask, ack_mask);
+		if (ret)
+			pr_warn("irq %d couldn't be set as level triggered. Might cause IRQ storm if asserted\n",
+				irqfd->f->fn.irqfd.label);
+	}
+	kref_get(&irqfd->kref);
+
+	return 0;
+}
+
+static void gunyah_irqfd_unpopulate(struct gunyah_vm_resource_ticket *ticket,
+					struct gunyah_resource *ghrsc)
+{
+	struct gunyah_irqfd *irqfd = container_of(ticket, struct gunyah_irqfd, ticket);
+	u64 cnt;
+
+	eventfd_ctx_remove_wait_queue(irqfd->ctx, &irqfd->wait, &cnt);
+	eventfd_ctx_put(irqfd->ctx);
+	fdput(irqfd->fd);
+	irqfd->ctx = NULL;
+	irqfd->fd.file = NULL;
+	irqfd->ghrsc = NULL;
+	kref_put(&irqfd->kref, gh_irqfd_cleanup);
+}
+
+static long gunyah_irqfd_bind(struct gunyah_vm_function *f)
+{
+	__poll_t events;
+	struct gunyah_irqfd *irqfd;
+	long r;
+
+	irqfd = kzalloc(sizeof(*irqfd), GFP_KERNEL);
+	if (!irqfd)
+		return -ENOMEM;
+
+	irqfd->f = f;
+	f->data = irqfd;
+
+	irqfd->fd = fdget(f->fn.irqfd.fd);
+	if (!irqfd->fd.file) {
+		r = -EBADF;
+		goto err_free;
+	}
+
+	irqfd->ctx = eventfd_ctx_fileget(irqfd->fd.file);
+	if (IS_ERR(irqfd->ctx)) {
+		r = PTR_ERR(irqfd->ctx);
+		goto err_fdput;
+	}
+
+	if (f->fn.irqfd.flags & GH_IRQFD_LEVEL)
+		irqfd->level = true;
+
+	init_waitqueue_func_entry(&irqfd->wait, irqfd_wakeup);
+	init_poll_funcptr(&irqfd->pt, irqfd_ptable_queue_proc);
+	kref_init(&irqfd->kref);
+
+	irqfd->ticket.resource_type = GUNYAH_RESOURCE_TYPE_BELL_TX;
+	irqfd->ticket.label = f->fn.irqfd.label;
+	irqfd->ticket.owner = THIS_MODULE;
+	irqfd->ticket.populate = gunyah_irqfd_populate;
+	irqfd->ticket.unpopulate = gunyah_irqfd_unpopulate;
+
+	r = ghvm_add_resource_ticket(f->ghvm, &irqfd->ticket);
+	if (r)
+		goto err_ctx;
+
+	events = vfs_poll(irqfd->fd.file, &irqfd->pt);
+	if (events & EPOLLIN)
+		pr_warn("Premature injection of interrupt\n");
+
+	return 0;
+err_ctx:
+	eventfd_ctx_put(irqfd->ctx);
+err_fdput:
+	fdput(irqfd->fd);
+err_free:
+	kfree(irqfd);
+	return r;
+}
+
+static void gunyah_irqfd_release(struct gunyah_vm_function *f)
+{
+	struct gunyah_irqfd *irqfd = f->data;
+
+	/* unpopulate will trigger clean up of the eventfd */
+	ghvm_remove_resource_ticket(irqfd->f->ghvm, &irqfd->ticket);
+}
+
+DECLARE_GUNYAH_VM_FUNCTION_INIT(irqfd, gunyah_irqfd_bind, gunyah_irqfd_release);
+MODULE_DESCRIPTION("Gunyah irqfds");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/gunyah.h b/include/linux/gunyah.h
index ac4879940c10..6b363707a901 100644
--- a/include/linux/gunyah.h
+++ b/include/linux/gunyah.h
@@ -33,6 +33,11 @@ struct gunyah_resource {
 	u32 rm_label;
 };
 
+/**
+ * Gunyah Doorbells
+ */
+#define GH_DBL_NONBLOCK		BIT(32)
+
 /**
  * Gunyah Message Queues
  */
diff --git a/include/uapi/linux/gunyah.h b/include/uapi/linux/gunyah.h
index b4afb11f538a..a947f0317ca9 100644
--- a/include/uapi/linux/gunyah.h
+++ b/include/uapi/linux/gunyah.h
@@ -57,10 +57,19 @@ struct gh_fn_vcpu_arg {
 	__u32 vcpu_id;
 };
 
+struct gh_fn_irqfd_arg {
+	__u32 fd;
+	__u32 label;
+#define GH_IRQFD_LEVEL			(1UL << 0)
+#define GH_IRQFD_DEASSIGN		(1UL << 1)
+	__u32 flags;
+};
+
 struct gh_vm_function {
 	char name[GUNYAH_FUNCTION_NAME_SIZE];
 	union {
-		struct gh_device_vcpu_arg vcpu;
+		struct gh_fn_vcpu_arg vcpu;
+		struct gh_fn_irqfd_arg irqfd;
 		char data[GUNYAH_FUNCTION_MAX_ARG_SIZE];
 	};
 };
-- 
2.39.0


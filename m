Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2AF65169C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 00:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbiLSXGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 18:06:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbiLSXDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 18:03:44 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F98167FE;
        Mon, 19 Dec 2022 15:01:12 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJIKvmY015286;
        Mon, 19 Dec 2022 23:00:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=D3j+GJokMFdBeRJ2Xes3rbW9E8kTJM1GvmXc4zDqJAc=;
 b=HBu83y0/uAMJArdMUGnpvY1AKDw7TcrYAYpgEkGdprxeopmwSue7o6EatGo1A9yWk4TF
 p9s5LTyHKEGx6Jie0XwEdXQph1Tw6xe4hJ8xwQ2XVHXQyZjuzWLiX0fZCdrv1UrCem5c
 WiKFO4nL2v3UIxgmx0H2Wm1P8kXz0Ni83Hz2rP6i4jqseYy+eODM1gAzMtlfxVC0hu+0
 6+u+Ozkjp/F/82sJEnxn5+aUjE9yMUa7vFZplLKsPob9xCWH/UNmOjAdVFpDbivtIL9j
 GKc/SHWiO9QKxn+X8xQhkWypLMkt4frBbIiUzomwDhlw+1QIXWpdXTsebF9N5/BOGmqI mw== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mh72gd4e1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 23:00:56 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BJN0ucQ006910
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 23:00:56 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 19 Dec 2022 15:00:55 -0800
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>
CC:     Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>
Subject: [PATCH v8 27/28] virt: gunyah: Add irqfd interface
Date:   Mon, 19 Dec 2022 14:58:48 -0800
Message-ID: <20221219225850.2397345-28-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221219225850.2397345-1-quic_eberman@quicinc.com>
References: <20221219225850.2397345-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5or1HWkH4LQxbY2CovGsT7oOrv1RQ2EZ
X-Proofpoint-ORIG-GUID: 5or1HWkH4LQxbY2CovGsT7oOrv1RQ2EZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_01,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 suspectscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212190202
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
 Documentation/virt/gunyah/vm-manager.rst |  22 +++
 drivers/virt/gunyah/Kconfig              |  10 ++
 drivers/virt/gunyah/Makefile             |   1 +
 drivers/virt/gunyah/gunyah_irqfd.c       | 180 +++++++++++++++++++++++
 include/linux/gunyah.h                   |   5 +
 include/uapi/linux/gunyah.h              |  11 +-
 6 files changed, 228 insertions(+), 1 deletion(-)
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
index f9551cd5dfe4..42842e755a04 100644
--- a/drivers/virt/gunyah/Kconfig
+++ b/drivers/virt/gunyah/Kconfig
@@ -49,5 +49,15 @@ config GUNYAH_VCPU
 	  can schedule the guest VM's vCPUs instead of using Gunyah's scheduler.
 	  VMMs can also handle stage 2 faults of the vCPUs.
 
+	  Say Y/M here if unsure and you want to support Gunyah VMMs.
+
+config GUNYAH_IRQFD
+	tristate "Gunyah irqfd interface"
+	depends on GUNYAH_RESOURCE_MANAGER
+	depends on GUNYAH_VM_MANAGER
+	help
+	  Enable kernel support for creating irqfds which can raise an interrupt
+	  on Gunyah virtual machine.
+
 	  Say Y/M here if unsure and you want to support Gunyah VMMs.
 endif
diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
index debdd7e4d9a1..065eeb060597 100644
--- a/drivers/virt/gunyah/Makefile
+++ b/drivers/virt/gunyah/Makefile
@@ -6,3 +6,4 @@ gunyah_rsc_mgr-$(CONFIG_GUNYAH_VM_MANAGER) += vm_mgr.o vm_mgr_mm.o
 obj-$(CONFIG_GUNYAH_RESOURCE_MANAGER) += gunyah_rsc_mgr.o
 
 obj-$(CONFIG_GUNYAH_VCPU) += gunyah_vcpu.o
+obj-$(CONFIG_GUNYAH_IRQFD) += gunyah_irqfd.o
diff --git a/drivers/virt/gunyah/gunyah_irqfd.c b/drivers/virt/gunyah/gunyah_irqfd.c
new file mode 100644
index 000000000000..34ec389323e2
--- /dev/null
+++ b/drivers/virt/gunyah/gunyah_irqfd.c
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
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
+	struct work_struct shutdown_work;
+};
+
+static void gh_irqfd_cleanup(struct kref *kref)
+{
+	struct gunyah_irqfd *irqfd = container_of(kref, struct gunyah_irqfd, kref);
+
+	kfree(irqfd);
+}
+
+
+static void irqfd_shutdown(struct work_struct *work)
+{
+	struct gunyah_irqfd *irqfd = container_of(work, struct gunyah_irqfd, shutdown_work);
+	u64 isr;
+
+	if (irqfd->ctx) {
+		eventfd_ctx_remove_wait_queue(irqfd->ctx, &irqfd->wait, &isr);
+		eventfd_ctx_put(irqfd->ctx);
+		fdput(irqfd->fd);
+		irqfd->ctx = NULL;
+		irqfd->fd.file = NULL;
+	}
+
+	kref_put(&irqfd->kref, gh_irqfd_cleanup);
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
+
+	queue_work(system_wq, &irqfd->shutdown_work);
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
+	init_waitqueue_func_entry(&irqfd->wait, irqfd_wakeup);
+	INIT_WORK(&irqfd->shutdown_work, irqfd_shutdown);
+	init_poll_funcptr(&irqfd->pt, irqfd_ptable_queue_proc);
+	kref_init(&irqfd->kref);
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
index 2c2b498a792d..db5910adc658 100644
--- a/include/linux/gunyah.h
+++ b/include/linux/gunyah.h
@@ -32,6 +32,11 @@ struct gunyah_resource {
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
index ccc0e6d0f985..5eab212c7bf5 100644
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
2.25.1


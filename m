Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485DB72E997
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 19:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240066AbjFMRYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 13:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239504AbjFMRXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 13:23:53 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39241BDA;
        Tue, 13 Jun 2023 10:22:31 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35DAbd9A026411;
        Tue, 13 Jun 2023 17:21:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=s5OQJ/+8FCLVRLVc1UHZIAyzi8TdsvhJlqfMVuM3Wpk=;
 b=C68U0eaB0dRgDKHu0St7PoT9O7Re259zuOt4b53U1GwUSSKhYca1FcBg7qP3zTvqeScO
 UTvM5G6vikIA0IJPsJSj9bhSP28oVCqpz5GdL49csb/jzCQNbPqy18c4/g8DluLGaEdE
 qaF+2vdAeIhp/o3EAF94Fl/pdMghK4sl7IJBxENOzyOMqBnPDSyLNbSK4xajQN1Ko6wm
 GULfueZZDTAn5JtqGJmQmg69l0Arga09dVH8rkh7B9qd+Ke9oUBG7GqWuuIrDB9nScBy
 CoOMsDIAO8rxwRdq1hMR0j7JY3cxJAiVPPhPSlfzeSHrV5l4KGWsnFRtLv65cKpq6Tsu Sg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r6amhj9f0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 17:21:56 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35DHLtEm004637
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 17:21:55 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 13 Jun 2023 10:21:54 -0700
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
        Conor Dooley <conor+dt@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v14 23/25] virt: gunyah: Add irqfd interface
Date:   Tue, 13 Jun 2023 10:20:51 -0700
Message-ID: <20230613172054.3959700-24-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230613172054.3959700-1-quic_eberman@quicinc.com>
References: <20230613172054.3959700-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: u0EwBxlvwgHoey5yhEq-9g440XC4qny3
X-Proofpoint-GUID: u0EwBxlvwgHoey5yhEq-9g440XC4qny3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_20,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306130153
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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

Acked-by: Alex Elder <elder@linaro.org>
Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 Documentation/virt/gunyah/vm-manager.rst |   2 +-
 drivers/virt/gunyah/Kconfig              |   9 ++
 drivers/virt/gunyah/Makefile             |   1 +
 drivers/virt/gunyah/gunyah_irqfd.c       | 180 +++++++++++++++++++++++
 include/uapi/linux/gunyah.h              |  35 +++++
 5 files changed, 226 insertions(+), 1 deletion(-)
 create mode 100644 drivers/virt/gunyah/gunyah_irqfd.c

diff --git a/Documentation/virt/gunyah/vm-manager.rst b/Documentation/virt/gunyah/vm-manager.rst
index b0c3bde105ae9..57a254827be26 100644
--- a/Documentation/virt/gunyah/vm-manager.rst
+++ b/Documentation/virt/gunyah/vm-manager.rst
@@ -116,7 +116,7 @@ the VM *before* the VM starts.
 The argument types are documented below:
 
 .. kernel-doc:: include/uapi/linux/gunyah.h
-   :identifiers: gh_fn_vcpu_arg
+   :identifiers: gh_fn_vcpu_arg gh_fn_irqfd_arg gh_irqfd_flags
 
 Gunyah VCPU API Descriptions
 ----------------------------
diff --git a/drivers/virt/gunyah/Kconfig b/drivers/virt/gunyah/Kconfig
index 0a58395f7d2c5..bc2c46d9df946 100644
--- a/drivers/virt/gunyah/Kconfig
+++ b/drivers/virt/gunyah/Kconfig
@@ -39,3 +39,12 @@ config GUNYAH_VCPU
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
index cc16b6c19db92..ad212a1cf9671 100644
--- a/drivers/virt/gunyah/Makefile
+++ b/drivers/virt/gunyah/Makefile
@@ -7,3 +7,4 @@ gunyah-y += rsc_mgr.o rsc_mgr_rpc.o vm_mgr.o vm_mgr_mm.o
 obj-$(CONFIG_GUNYAH) += gunyah.o
 
 obj-$(CONFIG_GUNYAH_VCPU) += gunyah_vcpu.o
+obj-$(CONFIG_GUNYAH_IRQFD) += gunyah_irqfd.o
diff --git a/drivers/virt/gunyah/gunyah_irqfd.c b/drivers/virt/gunyah/gunyah_irqfd.c
new file mode 100644
index 0000000000000..3e954ebd20297
--- /dev/null
+++ b/drivers/virt/gunyah/gunyah_irqfd.c
@@ -0,0 +1,180 @@
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
+	int ret = 0;
+
+	if (flags & EPOLLIN) {
+		if (irqfd->ghrsc) {
+			ret = gh_hypercall_bell_send(irqfd->ghrsc->capid, 1, NULL);
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
+static bool gh_irqfd_populate(struct gh_vm_resource_ticket *ticket, struct gh_resource *ghrsc)
+{
+	struct gh_irqfd *irqfd = container_of(ticket, struct gh_irqfd, ticket);
+	int ret;
+
+	if (irqfd->ghrsc) {
+		pr_warn("irqfd%d already got a Gunyah resource. Check if multiple resources with same label were configured.\n",
+			irqfd->ticket.label);
+		return false;
+	}
+
+	irqfd->ghrsc = ghrsc;
+	if (irqfd->level) {
+		/* Configure the bell to trigger when bit 0 is asserted (see
+		 * irq_wakeup) and for bell to automatically clear bit 0 once
+		 * received by the VM (ack_mask).  need to make sure bit 0 is cleared right away,
+		 * otherwise the line will never be deasserted. Emulating edge
+		 * trigger interrupt does not need to set either mask
+		 * because irq is listed only once per gh_hypercall_bell_send
+		 */
+		ret = gh_hypercall_bell_set_mask(irqfd->ghrsc->capid, 1, 1);
+		if (ret)
+			pr_warn("irq %d couldn't be set as level triggered. Might cause IRQ storm if asserted\n",
+				irqfd->ticket.label);
+	}
+
+	return true;
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
+	if (args->flags & ~GH_IRQFD_FLAGS_LEVEL)
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
+	if (args->flags & GH_IRQFD_FLAGS_LEVEL)
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
+static bool gh_irqfd_compare(const struct gh_vm_function_instance *f,
+				const void *arg, size_t size)
+{
+	const struct gh_fn_irqfd_arg *instance = f->argp,
+					 *other = arg;
+
+	if (sizeof(*other) != size)
+		return false;
+
+	return instance->label == other->label;
+}
+
+DECLARE_GH_VM_FUNCTION_INIT(irqfd, GH_FN_IRQFD, 2, gh_irqfd_bind, gh_irqfd_unbind,
+				gh_irqfd_compare);
+MODULE_DESCRIPTION("Gunyah irqfd VM Function");
+MODULE_LICENSE("GPL");
diff --git a/include/uapi/linux/gunyah.h b/include/uapi/linux/gunyah.h
index 434ffa8ffc783..0c480c622686a 100644
--- a/include/uapi/linux/gunyah.h
+++ b/include/uapi/linux/gunyah.h
@@ -77,9 +77,12 @@ struct gh_vm_dtb_config {
  * @GH_FN_VCPU: create a vCPU instance to control a vCPU
  *              &struct gh_fn_desc.arg is a pointer to &struct gh_fn_vcpu_arg
  *              Return: file descriptor to manipulate the vcpu.
+ * @GH_FN_IRQFD: register eventfd to assert a Gunyah doorbell
+ *               &struct gh_fn_desc.arg is a pointer to &struct gh_fn_irqfd_arg
  */
 enum gh_fn_type {
 	GH_FN_VCPU = 1,
+	GH_FN_IRQFD,
 };
 
 #define GH_FN_MAX_ARG_SIZE		256
@@ -99,6 +102,38 @@ struct gh_fn_vcpu_arg {
 	__u32 id;
 };
 
+/**
+ * enum gh_irqfd_flags - flags for use in gh_fn_irqfd_arg
+ * @GH_IRQFD_FLAGS_LEVEL: make the interrupt operate like a level triggered
+ *                        interrupt on guest side. Triggering IRQFD before
+ *                        guest handles the interrupt causes interrupt to
+ *                        stay asserted.
+ */
+enum gh_irqfd_flags {
+	GH_IRQFD_FLAGS_LEVEL		= 1UL << 0,
+};
+
+/**
+ * struct gh_fn_irqfd_arg - Arguments to create an irqfd function.
+ *
+ * Create this function with &GH_VM_ADD_FUNCTION using type &GH_FN_IRQFD.
+ *
+ * Allows setting an eventfd to directly trigger a guest interrupt.
+ * irqfd.fd specifies the file descriptor to use as the eventfd.
+ * irqfd.label corresponds to the doorbell label used in the guest VM's devicetree.
+ *
+ * @fd: an eventfd which when written to will raise a doorbell
+ * @label: Label of the doorbell created on the guest VM
+ * @flags: see &enum gh_irqfd_flags
+ * @padding: padding bytes
+ */
+struct gh_fn_irqfd_arg {
+	__u32 fd;
+	__u32 label;
+	__u32 flags;
+	__u32 padding;
+};
+
 /**
  * struct gh_fn_desc - Arguments to create a VM function
  * @type: Type of the function. See &enum gh_fn_type.
-- 
2.40.0


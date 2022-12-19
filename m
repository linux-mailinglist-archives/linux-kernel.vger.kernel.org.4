Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA1065169B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 00:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbiLSXF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 18:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbiLSXDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 18:03:44 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB07167FB;
        Mon, 19 Dec 2022 15:01:11 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJLlxcd022071;
        Mon, 19 Dec 2022 23:00:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=RDg5s2ifmOVHGfiF3BxuYSFTrQKyMCJHmzShVpSaW7M=;
 b=VfID/oyDy+7XRVliNy13OXsnD2YMdwtDCjLyWau+KbxHulKjLdHhgstS0XW+42UezTx8
 XRDqWRuPTBoPKePeefoVmwnp5cLvEnpMv5XaXk0iIqT/TIUir3kiT9Tu0H0oPUsINTNF
 HIFdm0Pw9nr79DqQpEKlwjKwkCfVc/+SHwekFVms5Se1qBLlj6j09vaSsyXPc+SloV7I
 TmKAoDqOD6wS1uxs8ngkmHCqQGii5B/RxtgZ3tH9W9m7OZsObPnX+F1ejlTycHN73u1j
 OeIbdVaBtl5CwIRbuX8SZuVUYoyyJ7iVT0unQqiWSwQvWxVonjhdw1TcgZyJIzz/dDBz 7w== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mh6xtd4c9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 23:00:53 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BJN0r6t007454
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 23:00:53 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 19 Dec 2022 15:00:52 -0800
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>
Subject: [PATCH v8 25/28] virt: gunyah: Add proxy-scheduled vCPUs
Date:   Mon, 19 Dec 2022 14:58:46 -0800
Message-ID: <20221219225850.2397345-26-quic_eberman@quicinc.com>
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
X-Proofpoint-GUID: W3YTIiboiHysvAHTQ8XHL7kuc8MkfStP
X-Proofpoint-ORIG-GUID: W3YTIiboiHysvAHTQ8XHL7kuc8MkfStP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_01,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 adultscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2212190202
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gunyah allows host virtual machines to schedule guest virtual machines
and handle their MMIO accesses. vCPUs are presented to the host as a
Gunyah resource and represented to userspace as a Gunyah VM function.

Creating the vcpu VM function will create a file descriptor that:
 - can run an ioctl: GH_VCPU_RUN to schedule the guest vCPU until the
   next interrupt occurs on the host or when the guest vCPU can no
   longer be run.
 - can be mmap'd to share a gh_vcpu_run structure which can look up the
   reason why GH_VCPU_RUN returned and provide return values for MMIO
   access.

Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 Documentation/virt/gunyah/vm-manager.rst |  30 +-
 arch/arm64/gunyah/gunyah_hypercall.c     |  28 ++
 drivers/virt/gunyah/Kconfig              |  12 +
 drivers/virt/gunyah/Makefile             |   2 +
 drivers/virt/gunyah/gunyah_vcpu.c        | 350 +++++++++++++++++++++++
 drivers/virt/gunyah/vm_mgr.c             |  25 ++
 drivers/virt/gunyah/vm_mgr.h             |   1 +
 include/linux/gunyah.h                   |   7 +
 include/uapi/linux/gunyah.h              |  30 ++
 9 files changed, 483 insertions(+), 2 deletions(-)
 create mode 100644 drivers/virt/gunyah/gunyah_vcpu.c

diff --git a/Documentation/virt/gunyah/vm-manager.rst b/Documentation/virt/gunyah/vm-manager.rst
index d929f8f20b3b..d11267d59802 100644
--- a/Documentation/virt/gunyah/vm-manager.rst
+++ b/Documentation/virt/gunyah/vm-manager.rst
@@ -5,8 +5,7 @@ Virtual Machine Manager
 =======================
 
 The Gunyah Virtual Machine Manager is a Linux driver to support launching
-virtual machines using Gunyah. It presently supports launching non-proxy
-scheduled Linux-like virtual machines.
+virtual machines using Gunyah.
 
 Except for some basic information about the location of initial binaries,
 most of the configuration about a Gunyah virtual machine is described in the
@@ -116,3 +115,30 @@ GH_VM_START
 ~~~~~~~~~~~
 
 This ioctl starts the VM.
+
+GH_VM_ADD_FUNCTION
+~~~~~~~~~~~~~~~~~~
+
+This ioctl registers a Gunyah VM function with the VM manager. The VM function
+is described with a `type` string and some arguments for that type. Typically,
+the function is added before the VM starts, but the function doesn't "operate"
+until the VM starts with GH_VM_START: e.g. vCPU ioclts will all return an error
+until the VM starts because the vCPUs don't exist until the VM is started. This
+allows the VMM to set up all the kernel functionality needed for the VM *before*
+the VM starts.
+
+The possible types are documented below:
+
+Type: "vcpu"
+^^^^^^^^^^^^
+
+::
+
+  struct gh_fn_vcpu_arg {
+	__u32 vcpu_id;
+  };
+
+The vcpu type will register with the VM Manager to expect to control
+vCPU number `vcpu_id`. It returns a file descriptor allowing interaction with
+the vCPU. See the Gunyah vCPU API description sections for interacting with
+the Gunyah vCPU file descriptors.
diff --git a/arch/arm64/gunyah/gunyah_hypercall.c b/arch/arm64/gunyah/gunyah_hypercall.c
index d28600909be4..dc42a4e6bd7c 100644
--- a/arch/arm64/gunyah/gunyah_hypercall.c
+++ b/arch/arm64/gunyah/gunyah_hypercall.c
@@ -28,6 +28,7 @@
 #define GH_HYPERCALL_HYP_IDENTIFY		GH_HYPERCALL(0x0000)
 #define GH_HYPERCALL_MSGQ_SEND			GH_HYPERCALL(0x001B)
 #define GH_HYPERCALL_MSGQ_RECV			GH_HYPERCALL(0x001C)
+#define GH_HYPERCALL_VCPU_RUN			GH_HYPERCALL(0x0065)
 
 /**
  * gh_hypercall_get_uid() - Returns a UID when running under a Gunyah hypervisor
@@ -98,5 +99,32 @@ int gh_hypercall_msgq_recv(u64 capid, uintptr_t buff, size_t size, size_t *recv_
 }
 EXPORT_SYMBOL_GPL(gh_hypercall_msgq_recv);
 
+int gh_hypercall_vcpu_run(u64 capid, u64 *resume_data, struct gh_hypercall_vcpu_run_resp *resp)
+{
+	struct arm_smccc_1_2_regs args = {
+		.a0 = GH_HYPERCALL_VCPU_RUN,
+		.a1 = capid,
+		.a2 = resume_data[0],
+		.a3 = resume_data[1],
+		.a4 = resume_data[2],
+		/* C language says this will be implictly zero. Gunyah requires 0, so be explicit */
+		.a5 = 0,
+	};
+	struct arm_smccc_1_2_regs res;
+
+	arm_smccc_1_2_hvc(&args, &res);
+
+	if (res.a0)
+		return res.a0;
+
+	resp->state = res.a1;
+	resp->state_data[0] = res.a2;
+	resp->state_data[1] = res.a3;
+	resp->state_data[2] = res.a4;
+
+	return res.a0;
+}
+EXPORT_SYMBOL_GPL(gh_hypercall_vcpu_run);
+
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Gunyah Hypervisor Hypercalls");
diff --git a/drivers/virt/gunyah/Kconfig b/drivers/virt/gunyah/Kconfig
index e92318ec8026..f9551cd5dfe4 100644
--- a/drivers/virt/gunyah/Kconfig
+++ b/drivers/virt/gunyah/Kconfig
@@ -38,4 +38,16 @@ config GUNYAH_VM_MANAGER
 	  required to launch other virtual machines.
 
 	  Say Y here if unsure and you want to support Gunyah VMMs.
+
+config GUNYAH_VCPU
+	tristate "Runnable Gunyah vCPUs"
+	depends on GUNYAH_RESOURCE_MANAGER
+	depends on GUNYAH_VM_MANAGER
+	help
+	  Enable kernel support for host-scheduled vCPUs running under Gunyah.
+	  When selecting this option, userspace virtual machine managers (VMM)
+	  can schedule the guest VM's vCPUs instead of using Gunyah's scheduler.
+	  VMMs can also handle stage 2 faults of the vCPUs.
+
+	  Say Y/M here if unsure and you want to support Gunyah VMMs.
 endif
diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
index e321c009898f..debdd7e4d9a1 100644
--- a/drivers/virt/gunyah/Makefile
+++ b/drivers/virt/gunyah/Makefile
@@ -4,3 +4,5 @@ obj-$(CONFIG_GUNYAH_PLATFORM_HOOKS) += gunyah_platform_hooks.o
 gunyah_rsc_mgr-y += rsc_mgr.o rsc_mgr_rpc.o
 gunyah_rsc_mgr-$(CONFIG_GUNYAH_VM_MANAGER) += vm_mgr.o vm_mgr_mm.o
 obj-$(CONFIG_GUNYAH_RESOURCE_MANAGER) += gunyah_rsc_mgr.o
+
+obj-$(CONFIG_GUNYAH_VCPU) += gunyah_vcpu.o
diff --git a/drivers/virt/gunyah/gunyah_vcpu.c b/drivers/virt/gunyah/gunyah_vcpu.c
new file mode 100644
index 000000000000..618a6e103de7
--- /dev/null
+++ b/drivers/virt/gunyah/gunyah_vcpu.c
@@ -0,0 +1,350 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/anon_inodes.h>
+#include <linux/file.h>
+#include <linux/gunyah.h>
+#include <linux/gunyah_vm_mgr.h>
+#include <linux/interrupt.h>
+#include <linux/kref.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/wait.h>
+
+#include "vm_mgr.h"
+
+#include <uapi/linux/gunyah.h>
+
+#define MAX_VCPU_NAME		20 /* gh-vcpu:u32_max+NUL */
+
+struct gunyah_vcpu {
+	struct gunyah_resource *rsc;
+	struct gunyah_vm_resource_ticket ticket;
+	struct gunyah_vm_function *f;
+	struct gunyah_vm *ghvm;
+
+	bool handle_mmio;
+	struct gh_vcpu_run *vcpu_run;
+
+	struct kref kref;
+	struct completion ready;
+	struct mutex run_lock;
+};
+
+/* VCPU is ready to run */
+#define GH_VCPU_STATE_READY		0
+/* VCPU is sleeping until an interrupt arrives */
+#define GH_VCPU_STATE_EXPECTS_WAKEUP	1
+/* VCPU is powered off */
+#define GH_VCPU_STATE_POWERED_OFF	2
+/* VCPU is blocked in EL2 for unspecified reason */
+#define GH_VCPU_STATE_BLOCKED		3
+/* VCPU has returned for MMIO READ */
+#define GH_VCPU_ADDRSPACE_VMMIO_READ	4
+/* VCPU has returned for MMIO WRITE */
+#define GH_VCPU_ADDRSPACE_VMMIO_WRITE	5
+
+static void vcpu_release(struct kref *kref)
+{
+	struct gunyah_vcpu *vcpu = container_of(kref, struct gunyah_vcpu, kref);
+
+	kfree(vcpu);
+}
+
+/**
+ * When hypervisor wants us to schedule vCPU again, it gives us an interrupt
+ */
+static irqreturn_t gh_vcpu_irq_handler(int irq, void *data)
+{
+	struct gunyah_vcpu *vcpu = data;
+
+	complete(&vcpu->ready);
+	return IRQ_HANDLED;
+}
+
+static void gh_handle_mmio_return(struct gunyah_vcpu *vcpu, u64 *state)
+{
+	if (!vcpu->vcpu_run->mmio.is_write)
+		memcpy(&state[0], vcpu->vcpu_run->mmio.data, vcpu->vcpu_run->mmio.len);
+
+	vcpu->handle_mmio = false;
+	vcpu->vcpu_run->exit_reason = GH_VM_EXIT_UNKNOWN;
+}
+
+static bool gh_handle_mmio(struct gunyah_vcpu *vcpu,
+				struct gh_hypercall_vcpu_run_resp *vcpu_run_resp)
+{
+	int ret = 0;
+
+	if (vcpu_run_resp->state == GH_VCPU_ADDRSPACE_VMMIO_READ) {
+		vcpu->vcpu_run->mmio.is_write = 0;
+		vcpu->vcpu_run->exit_reason = GH_VM_EXIT_MMIO;
+	} else { /* GH_VCPU_ADDRSPACE_VMMIO_WRITE case */
+		ret = gh_vm_mgr_mmio_write(vcpu->f->ghvm, vcpu_run_resp->state_data[0],
+			vcpu_run_resp->state_data[1], vcpu_run_resp->state_data[2]);
+		if (!ret)
+			return true;
+
+		vcpu->vcpu_run->mmio.is_write = 1;
+		memcpy(vcpu->vcpu_run->mmio.data, &vcpu_run_resp->state_data[2],
+			vcpu_run_resp->state_data[1]);
+	}
+
+	vcpu->vcpu_run->mmio.phys_addr = vcpu_run_resp->state_data[0];
+	vcpu->vcpu_run->mmio.len = vcpu_run_resp->state_data[1];
+	vcpu->vcpu_run->exit_reason = GH_VM_EXIT_MMIO;
+
+	return false;
+}
+
+/**
+ * gh_vcpu_run() - Request Gunyah to begin scheduling this vCPU.
+ * @vcpu: The client descriptor that was obtained via gunyah_vcpu_alloc()
+ */
+static int gh_vcpu_run(struct gunyah_vcpu *vcpu)
+{
+	struct gh_hypercall_vcpu_run_resp vcpu_run_resp;
+	u64 state_data[3] = { 0 };
+	int ret = 0;
+
+	ret = gh_vm_ensure_started(vcpu->ghvm);
+	if (ret)
+		return ret;
+
+	if (mutex_lock_interruptible(&vcpu->run_lock))
+		return -ERESTARTSYS;
+
+	if (!vcpu->rsc || !vcpu->f) {
+		ret = -ENODEV;
+		goto out;
+	}
+	/* Last exit reason was EXIT_MMIO. Userspace has filled in the data, now we need to tell
+	 * Gunyah about the response.
+	 */
+	if (vcpu->handle_mmio)
+		gh_handle_mmio_return(vcpu, state_data);
+
+	while (!ret && !signal_pending(current) && !vcpu->vcpu_run->immediate_exit) {
+		ret = gh_hypercall_vcpu_run(vcpu->rsc->capid, state_data, &vcpu_run_resp);
+		if (ret == GH_ERROR_OK) {
+			switch (vcpu_run_resp.state) {
+			case GH_VCPU_STATE_READY:
+				if (need_resched())
+					schedule();
+				break;
+			case GH_VCPU_STATE_EXPECTS_WAKEUP:
+			case GH_VCPU_STATE_POWERED_OFF:
+				ret = wait_for_completion_interruptible(&vcpu->ready);
+				/* reinitialize completion before next VCPU_RUN. If we reinitialize
+				 * after the VCPU_RUN, interrupt may have already come before
+				 * we can re-initialize and then waiting for an interrupt that
+				 * was already handled.
+				 */
+				reinit_completion(&vcpu->ready);
+				break;
+			case GH_VCPU_STATE_BLOCKED:
+				schedule();
+				break;
+			case GH_VCPU_ADDRSPACE_VMMIO_READ:
+			case GH_VCPU_ADDRSPACE_VMMIO_WRITE:
+				if (!gh_handle_mmio(vcpu, &vcpu_run_resp)) {
+					vcpu->handle_mmio = true;
+					goto out;
+				}
+				break;
+			default:
+				pr_warn_ratelimited("Unknown vCPU state: %llx\n",
+							vcpu_run_resp.state);
+				schedule();
+				break;
+			}
+		} else if (ret == GH_ERROR_RETRY) {
+			schedule();
+			ret = 0;
+		} else
+			ret = gh_remap_error(ret);
+	}
+
+out:
+	mutex_unlock(&vcpu->run_lock);
+
+	if (signal_pending(current))
+		return -ERESTARTSYS;
+
+	return ret;
+}
+
+static long gh_vcpu_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	struct gunyah_vcpu *vcpu = filp->private_data;
+	long ret = -EINVAL;
+
+	switch (cmd) {
+	case GH_VCPU_RUN:
+		ret = gh_vcpu_run(vcpu);
+		break;
+	case GH_VCPU_MMAP_SIZE:
+		ret = PAGE_SIZE;
+		break;
+	default:
+		break;
+	}
+	return ret;
+}
+
+static int gh_vcpu_release(struct inode *inode, struct file *filp)
+{
+	struct gunyah_vcpu *vcpu = filp->private_data;
+
+	kref_put(&vcpu->kref, vcpu_release);
+	return 0;
+}
+
+static vm_fault_t gh_vcpu_fault(struct vm_fault *vmf)
+{
+	struct gunyah_vcpu *vcpu = vmf->vma->vm_file->private_data;
+	struct page *page = NULL;
+
+	if (vmf->pgoff == 0)
+		page = virt_to_page(vcpu->vcpu_run);
+
+	get_page(page);
+	vmf->page = page;
+	return 0;
+}
+
+static const struct vm_operations_struct gh_vcpu_ops = {
+	.fault = gh_vcpu_fault,
+};
+
+static int gh_vcpu_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	vma->vm_ops = &gh_vcpu_ops;
+	return 0;
+}
+
+static const struct file_operations gh_vcpu_fops = {
+	.unlocked_ioctl = gh_vcpu_ioctl,
+	.release = gh_vcpu_release,
+	.llseek = noop_llseek,
+	.mmap = gh_vcpu_mmap,
+};
+
+static int gunyah_vcpu_populate(struct gunyah_vm_resource_ticket *ticket,
+				struct gunyah_resource *ghrsc)
+{
+	struct gunyah_vcpu *vcpu = container_of(ticket, struct gunyah_vcpu, ticket);
+	int ret;
+
+	mutex_lock(&vcpu->run_lock);
+	vcpu->rsc = ghrsc;
+
+	init_completion(&vcpu->ready);
+	mutex_unlock(&vcpu->run_lock);
+
+	ret = request_irq(vcpu->rsc->irq, gh_vcpu_irq_handler, IRQF_TRIGGER_RISING, "gh_vcpu",
+			vcpu);
+	if (WARN(ret, "Failed to request vcpu irq %d: %d", vcpu->rsc->irq, ret))
+		return ret;
+
+	return ret;
+}
+
+static void gunyah_vcpu_unpopulate(struct gunyah_vm_resource_ticket *ticket,
+				   struct gunyah_resource *ghrsc)
+{
+	struct gunyah_vcpu *vcpu = container_of(ticket, struct gunyah_vcpu, ticket);
+
+	mutex_lock(&vcpu->run_lock);
+	free_irq(vcpu->rsc->irq, vcpu);
+	vcpu->rsc = NULL;
+	mutex_unlock(&vcpu->run_lock);
+}
+
+static long gunyah_vcpu_bind(struct gunyah_vm_function *f)
+{
+	struct gunyah_vcpu *vcpu;
+	char name[MAX_VCPU_NAME];
+	struct file *file;
+	struct page *page;
+	int fd;
+	long r;
+
+	vcpu = kzalloc(sizeof(*vcpu), GFP_KERNEL);
+	if (!vcpu)
+		return -ENOMEM;
+
+	vcpu->f = f;
+	f->data = vcpu;
+	mutex_init(&vcpu->run_lock);
+	kref_init(&vcpu->kref);
+
+	page = alloc_page(GFP_KERNEL | __GFP_ZERO);
+	if (!page) {
+		r = -ENOMEM;
+		goto err_destroy_vcpu;
+	}
+	vcpu->vcpu_run = page_address(page);
+
+	vcpu->ticket.resource_type = GUNYAH_RESOURCE_TYPE_VCPU;
+	vcpu->ticket.label = f->fn.vcpu.vcpu_id;
+	vcpu->ticket.owner = THIS_MODULE;
+	vcpu->ticket.populate = gunyah_vcpu_populate;
+	vcpu->ticket.unpopulate = gunyah_vcpu_unpopulate;
+
+	r = ghvm_add_resource_ticket(f->ghvm, &vcpu->ticket);
+	if (r)
+		goto err_destroy_page;
+
+	fd = get_unused_fd_flags(O_CLOEXEC);
+	if (fd < 0) {
+		r = fd;
+		goto err_remove_vcpu;
+	}
+
+	if (!get_gunyah_vm(f->ghvm)) {
+		r = -ENODEV;
+		goto err_put_fd;
+	}
+	vcpu->ghvm = f->ghvm;
+
+	kref_get(&vcpu->kref);
+	snprintf(name, sizeof(name), "gh-vcpu:%d", vcpu->ticket.label);
+	file = anon_inode_getfile(name, &gh_vcpu_fops, vcpu, O_RDWR);
+	if (IS_ERR(file)) {
+		r = PTR_ERR(file);
+		goto err_put_ghvm;
+	}
+
+	fd_install(fd, file);
+
+	return fd;
+err_put_ghvm:
+	put_gunyah_vm(vcpu->ghvm);
+err_put_fd:
+	put_unused_fd(fd);
+err_remove_vcpu:
+	ghvm_remove_resource_ticket(f->ghvm, &vcpu->ticket);
+err_destroy_page:
+	free_page((unsigned long)vcpu->vcpu_run);
+err_destroy_vcpu:
+	kfree(vcpu);
+	return r;
+}
+
+static void gunyah_vcpu_release(struct gunyah_vm_function *f)
+{
+	struct gunyah_vcpu *vcpu = f->data;
+
+	ghvm_remove_resource_ticket(vcpu->f->ghvm, &vcpu->ticket);
+	vcpu->f = NULL;
+
+	kref_put(&vcpu->kref, vcpu_release);
+}
+
+DECLARE_GUNYAH_VM_FUNCTION_INIT(vcpu, gunyah_vcpu_bind, gunyah_vcpu_release);
+MODULE_DESCRIPTION("Gunyah vCPU Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
index dcca255bc11f..415d2b164457 100644
--- a/drivers/virt/gunyah/vm_mgr.c
+++ b/drivers/virt/gunyah/vm_mgr.c
@@ -390,6 +390,31 @@ static int gh_vm_start(struct gunyah_vm *ghvm)
 	return ret;
 }
 
+int gh_vm_ensure_started(struct gunyah_vm *ghvm)
+{
+	int ret;
+
+retry:
+	ret = down_read_interruptible(&ghvm->status_lock);
+	if (ret)
+		return ret;
+
+	if (unlikely(ghvm->vm_status == GH_RM_VM_STATUS_NO_STATE)) {
+		up_read(&ghvm->status_lock);
+		ret = gh_vm_start(ghvm);
+		if (ret)
+			return ret;
+		goto retry;
+	}
+
+	if (unlikely(ghvm->vm_status != GH_RM_VM_STATUS_READY))
+		ret = -ENODEV;
+
+	up_read(&ghvm->status_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(gh_vm_ensure_started);
+
 static void gh_vm_stop(struct gunyah_vm *ghvm)
 {
 	int ret;
diff --git a/drivers/virt/gunyah/vm_mgr.h b/drivers/virt/gunyah/vm_mgr.h
index 46ba2e530be2..cd45fa3dc2c2 100644
--- a/drivers/virt/gunyah/vm_mgr.h
+++ b/drivers/virt/gunyah/vm_mgr.h
@@ -70,6 +70,7 @@ struct gunyah_vm_memory_mapping *gh_vm_mem_mapping_find(struct gunyah_vm *ghvm,
 struct gunyah_vm_memory_mapping *gh_vm_mem_mapping_find_mapping(struct gunyah_vm *ghvm,
 								u64 gpa, u32 size);
 
+int gh_vm_ensure_started(struct gunyah_vm *ghvm);
 int gh_vm_mgr_mmio_write(struct gunyah_vm *ghvm, u64 addr, u32 len, u64 data);
 
 #endif
diff --git a/include/linux/gunyah.h b/include/linux/gunyah.h
index af69a3479025..42160b4de834 100644
--- a/include/linux/gunyah.h
+++ b/include/linux/gunyah.h
@@ -168,4 +168,11 @@ void gh_hypercall_hyp_identify(struct gh_hypercall_hyp_identify_resp *hyp_identi
 int gh_hypercall_msgq_send(u64 capid, size_t size, uintptr_t buff, int tx_flags, bool *ready);
 int gh_hypercall_msgq_recv(u64 capid, uintptr_t buff, size_t size, size_t *recv_size, bool *ready);
 
+struct gh_hypercall_vcpu_run_resp {
+	u64 state;
+	u64 state_data[3];
+};
+
+int gh_hypercall_vcpu_run(u64 capid, u64 *resume_data, struct gh_hypercall_vcpu_run_resp *resp);
+
 #endif
diff --git a/include/uapi/linux/gunyah.h b/include/uapi/linux/gunyah.h
index 40db32aeb012..ccc0e6d0f985 100644
--- a/include/uapi/linux/gunyah.h
+++ b/include/uapi/linux/gunyah.h
@@ -53,13 +53,43 @@ struct gh_vm_dtb_config {
 #define GUNYAH_FUNCTION_NAME_SIZE		32
 #define GUNYAH_FUNCTION_MAX_ARG_SIZE		1024
 
+struct gh_fn_vcpu_arg {
+	__u32 vcpu_id;
+};
+
 struct gh_vm_function {
 	char name[GUNYAH_FUNCTION_NAME_SIZE];
 	union {
+		struct gh_device_vcpu_arg vcpu;
 		char data[GUNYAH_FUNCTION_MAX_ARG_SIZE];
 	};
 };
 
 #define GH_VM_ADD_FUNCTION	_IOW(GH_IOCTL_TYPE, 0x4, struct gh_vm_function)
 
+/* for GH_VCPU_RUN, returned by mmap(vcpu_fd, offset=0) */
+struct gh_vcpu_run {
+	/* in */
+	__u8 immediate_exit;
+	__u8 padding1[7];
+
+	/* out */
+#define GH_VM_EXIT_UNKNOWN            0
+#define GH_VM_EXIT_MMIO               1
+	__u32 exit_reason;
+
+	union {
+		/* GH_VM_EXIT_MMIO */
+		struct {
+			__u64 phys_addr;
+			__u8  data[8];
+			__u32 len;
+			__u8  is_write;
+		} mmio;
+	};
+};
+
+#define GH_VCPU_RUN		_IO(GH_IOCTL_TYPE, 0x5)
+#define GH_VCPU_MMAP_SIZE	_IO(GH_IOCTL_TYPE, 0x6)
+
 #endif
-- 
2.25.1


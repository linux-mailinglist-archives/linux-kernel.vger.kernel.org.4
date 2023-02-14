Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AACC696FAE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 22:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbjBNV2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 16:28:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbjBNV1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 16:27:53 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B3F303DE;
        Tue, 14 Feb 2023 13:27:27 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31ELHW1Q029938;
        Tue, 14 Feb 2023 21:26:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=RhU80bYVgcAGmGEHUFUVYEVnSRadawR0ygwxcPknuGc=;
 b=NZGHXWRygK1Y1yvdGFwAEGphW683kowrh63VW2RRrJT3xxct9ckbGwx05j3m8yrwib9n
 fFnRMyGRp3avAPwJ1FHlSb+jQxbzPfgTyOGQXhzst0eT/1kopBGm7hsl/icse61ioiM7
 zI8WsouLSbz+VtUAUFvLE+PlNPwv0KBM42vyZsCKD9UA2HVXajo2+iK6GP1S25cXf4R7
 ZQZAqpDMgpKYRF2grDWcPFWyvAQf7tmNAeaozkofuhaPaLldmoneSYk7mFsRY1sQZjWM
 331vdf97Yp/TH6dgaUw7u5GQzZ7qlsUZyYJN8LiM9g6JICZukpFg5S0p0VzP6CmbXlfx /Q== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nqtv0beb8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 21:26:11 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31ELQABC006109
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 21:26:10 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 14 Feb 2023 13:26:09 -0800
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
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
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v10 22/26] virt: gunyah: Add proxy-scheduled vCPUs
Date:   Tue, 14 Feb 2023 13:26:00 -0800
Message-ID: <20230214212602.3326566-1-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230214211229.3239350-1-quic_eberman@quicinc.com>
References: <20230214211229.3239350-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RsouC3EGMCGHBONuwppM3KR6kWe3uxQe
X-Proofpoint-ORIG-GUID: RsouC3EGMCGHBONuwppM3KR6kWe3uxQe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_15,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302140184
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/virt/gunyah/Kconfig              |  11 +
 drivers/virt/gunyah/Makefile             |   2 +
 drivers/virt/gunyah/gunyah_vcpu.c        | 463 +++++++++++++++++++++++
 drivers/virt/gunyah/vm_mgr.c             |   4 +
 drivers/virt/gunyah/vm_mgr.h             |   1 +
 include/linux/gunyah.h                   |   8 +
 include/uapi/linux/gunyah.h              |  61 +++
 9 files changed, 606 insertions(+), 2 deletions(-)
 create mode 100644 drivers/virt/gunyah/gunyah_vcpu.c

diff --git a/Documentation/virt/gunyah/vm-manager.rst b/Documentation/virt/gunyah/vm-manager.rst
index 5272a6e9145c..662b8d6fec2a 100644
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
@@ -122,3 +121,30 @@ GH_VM_START
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
index 2ca9ab098ff6..260d416dd006 100644
--- a/arch/arm64/gunyah/gunyah_hypercall.c
+++ b/arch/arm64/gunyah/gunyah_hypercall.c
@@ -40,6 +40,7 @@ EXPORT_SYMBOL_GPL(arch_is_gunyah_guest);
 #define GH_HYPERCALL_HYP_IDENTIFY		GH_HYPERCALL(0x8000)
 #define GH_HYPERCALL_MSGQ_SEND			GH_HYPERCALL(0x801B)
 #define GH_HYPERCALL_MSGQ_RECV			GH_HYPERCALL(0x801C)
+#define GH_HYPERCALL_VCPU_RUN			GH_HYPERCALL(0x8065)
 
 /**
  * gh_hypercall_hyp_identify() - Returns build information and feature flags
@@ -89,5 +90,32 @@ enum gh_error gh_hypercall_msgq_recv(u64 capid, uintptr_t buff, size_t size, siz
 }
 EXPORT_SYMBOL_GPL(gh_hypercall_msgq_recv);
 
+enum gh_error gh_hypercall_vcpu_run(u64 capid, u64 *resume_data,
+					struct gh_hypercall_vcpu_run_resp *resp)
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
+	if (res.a0 == GH_ERROR_OK) {
+		resp->state = res.a1;
+		resp->state_data[0] = res.a2;
+		resp->state_data[1] = res.a3;
+		resp->state_data[2] = res.a4;
+	}
+
+	return res.a0;
+}
+EXPORT_SYMBOL_GPL(gh_hypercall_vcpu_run);
+
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Gunyah Hypervisor Hypercalls");
diff --git a/drivers/virt/gunyah/Kconfig b/drivers/virt/gunyah/Kconfig
index de815189dab6..4c1c6110b50e 100644
--- a/drivers/virt/gunyah/Kconfig
+++ b/drivers/virt/gunyah/Kconfig
@@ -15,3 +15,14 @@ config GUNYAH
 
 config GUNYAH_PLATFORM_HOOKS
 	tristate
+
+config GUNYAH_VCPU
+	tristate "Runnable Gunyah vCPUs"
+	depends on GUNYAH
+	help
+	  Enable kernel support for host-scheduled vCPUs running under Gunyah.
+	  When selecting this option, userspace virtual machine managers (VMM)
+	  can schedule the guest VM's vCPUs instead of using Gunyah's scheduler.
+	  VMMs can also handle stage 2 faults of the vCPUs.
+
+	  Say Y/M here if unsure and you want to support Gunyah VMMs.
diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
index 6b8f84dbfe0d..2d1b604a7b03 100644
--- a/drivers/virt/gunyah/Makefile
+++ b/drivers/virt/gunyah/Makefile
@@ -5,3 +5,5 @@ obj-$(CONFIG_GUNYAH_PLATFORM_HOOKS) += gunyah_platform_hooks.o
 
 gunyah_rsc_mgr-y += rsc_mgr.o rsc_mgr_rpc.o vm_mgr.o vm_mgr_mm.o
 obj-$(CONFIG_GUNYAH) += gunyah_rsc_mgr.o
+
+obj-$(CONFIG_GUNYAH_VCPU) += gunyah_vcpu.o
diff --git a/drivers/virt/gunyah/gunyah_vcpu.c b/drivers/virt/gunyah/gunyah_vcpu.c
new file mode 100644
index 000000000000..fb1f55cb5020
--- /dev/null
+++ b/drivers/virt/gunyah/gunyah_vcpu.c
@@ -0,0 +1,463 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
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
+	struct gh_vm_function_instance *f;
+	struct gunyah_resource *rsc;
+	struct mutex run_lock;
+	/* Track why vcpu_run left last time around. */
+	enum {
+		GH_VCPU_UNKNOWN = 0,
+		GH_VCPU_READY,
+		GH_VCPU_MMIO_READ,
+		GH_VCPU_SYSTEM_DOWN,
+	} state;
+	u8 mmio_read_len;
+	struct gh_vcpu_run *vcpu_run;
+	struct completion ready;
+	struct gh_vm *ghvm;
+
+	struct notifier_block nb;
+	struct gh_vm_resource_ticket ticket;
+	struct kref kref;
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
+	free_page((unsigned long)vcpu->vcpu_run);
+	kfree(vcpu);
+}
+
+/*
+ * When hypervisor allows us to schedule vCPU again, it gives us an interrupt
+ */
+static irqreturn_t gh_vcpu_irq_handler(int irq, void *data)
+{
+	struct gunyah_vcpu *vcpu = data;
+
+	complete(&vcpu->ready);
+	return IRQ_HANDLED;
+}
+
+static bool gh_handle_mmio(struct gunyah_vcpu *vcpu,
+				struct gh_hypercall_vcpu_run_resp *vcpu_run_resp)
+{
+	int ret = 0;
+	u64 addr = vcpu_run_resp->state_data[0],
+	    len  = vcpu_run_resp->state_data[1],
+	    data = vcpu_run_resp->state_data[2];
+
+	if (vcpu_run_resp->state == GH_VCPU_ADDRSPACE_VMMIO_READ) {
+		vcpu->vcpu_run->mmio.is_write = 0;
+		/* Record that we need to give vCPU user's supplied value next gh_vcpu_run() */
+		vcpu->state = GH_VCPU_MMIO_READ;
+		vcpu->mmio_read_len = len;
+	} else { /* GH_VCPU_ADDRSPACE_VMMIO_WRITE */
+		/* Try internal handlers first */
+		ret = gh_vm_mmio_write(vcpu->f->ghvm, addr, len, data);
+		if (!ret)
+			return true;
+
+		/* Give userspace the info */
+		vcpu->vcpu_run->mmio.is_write = 1;
+		memcpy(vcpu->vcpu_run->mmio.data, &data, len);
+	}
+
+	vcpu->vcpu_run->mmio.phys_addr = addr;
+	vcpu->vcpu_run->mmio.len = len;
+	vcpu->vcpu_run->exit_reason = GH_VCPU_EXIT_MMIO;
+
+	return false;
+}
+
+static int gh_vcpu_rm_notification(struct notifier_block *nb, unsigned long action, void *data)
+{
+	struct gunyah_vcpu *vcpu = container_of(nb, struct gunyah_vcpu, nb);
+	struct gh_rm_vm_exited_payload *exit_payload = data;
+
+	if (action == GH_RM_NOTIFICATION_VM_EXITED &&
+		le16_to_cpu(exit_payload->vmid) == vcpu->ghvm->vmid)
+		complete(&vcpu->ready);
+
+	return NOTIFY_OK;
+}
+
+static inline enum gh_vm_status remap_vm_status(enum gh_rm_vm_status rm_status)
+{
+	switch (rm_status) {
+	case GH_RM_VM_STATUS_INIT_FAILED:
+		return GH_VM_STATUS_LOAD_FAILED;
+	case GH_RM_VM_STATUS_EXITED:
+		return GH_VM_STATUS_EXITED;
+	default:
+		return GH_VM_STATUS_CRASHED;
+	}
+}
+
+/**
+ * gh_vcpu_check_system() - Check whether VM as a whole is running
+ * @vcpu: Pointer to gunyah_vcpu
+ *
+ * Returns true if the VM is alive.
+ * Returns false if the vCPU is the VM is not alive (can only be that VM is shutting down).
+ */
+static bool gh_vcpu_check_system(struct gunyah_vcpu *vcpu)
+	__must_hold(&vcpu->run_lock)
+{
+	bool ret = true;
+
+	down_read(&vcpu->ghvm->status_lock);
+	if (likely(vcpu->ghvm->vm_status == GH_RM_VM_STATUS_RUNNING))
+		goto out;
+
+	vcpu->vcpu_run->status.status = remap_vm_status(vcpu->ghvm->vm_status);
+	vcpu->vcpu_run->status.exit_info = vcpu->ghvm->exit_info;
+	vcpu->vcpu_run->exit_reason = GH_VCPU_EXIT_STATUS;
+	vcpu->state = GH_VCPU_SYSTEM_DOWN;
+	ret = false;
+out:
+	up_read(&vcpu->ghvm->status_lock);
+	return ret;
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
+	enum gh_error gh_error;
+	int ret = 0;
+
+	if (!vcpu->f)
+		return -ENODEV;
+
+	if (mutex_lock_interruptible(&vcpu->run_lock))
+		return -ERESTARTSYS;
+
+	if (!vcpu->rsc) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	switch (vcpu->state) {
+	case GH_VCPU_UNKNOWN:
+		if (vcpu->ghvm->vm_status != GH_RM_VM_STATUS_RUNNING) {
+			/* Check if VM is up. If VM is starting, will block until VM is fully up
+			 * since that thread does down_write.
+			 */
+			if (!gh_vcpu_check_system(vcpu))
+				goto out;
+		}
+		vcpu->state = GH_VCPU_READY;
+		break;
+	case GH_VCPU_MMIO_READ:
+		memcpy(&state_data[0], vcpu->vcpu_run->mmio.data, vcpu->mmio_read_len);
+		vcpu->state = GH_VCPU_READY;
+		break;
+	case GH_VCPU_SYSTEM_DOWN:
+		goto out;
+	default:
+		break;
+	}
+
+	while (!ret && !signal_pending(current)) {
+		if (vcpu->vcpu_run->immediate_exit) {
+			ret = -EINTR;
+			goto out;
+		}
+
+		gh_error = gh_hypercall_vcpu_run(vcpu->rsc->capid, state_data, &vcpu_run_resp);
+		if (gh_error == GH_ERROR_OK) {
+			ret = 0;
+			switch (vcpu_run_resp.state) {
+			case GH_VCPU_STATE_READY:
+				if (need_resched())
+					schedule();
+				break;
+			case GH_VCPU_STATE_POWERED_OFF:
+				/* vcpu might be off because the VM is shut down.
+				 * If so, it won't ever run again: exit back to user
+				 */
+				if (!gh_vcpu_check_system(vcpu))
+					goto out;
+				/* Otherwise, another vcpu will turn it on (e.g. by PSCI)
+				 * and hyp sends an interrupt to wake Linux up.
+				 */
+				fallthrough;
+			case GH_VCPU_STATE_EXPECTS_WAKEUP:
+				ret = wait_for_completion_interruptible(&vcpu->ready);
+				/* reinitialize completion before next hypercall. If we reinitialize
+				 * after the hypercall, interrupt may have already come before
+				 * re-initializing the completion and then end up waiting for
+				 * event that already happened.
+				 */
+				reinit_completion(&vcpu->ready);
+				/* Check system status again. Completion might've
+				 * come from gh_vcpu_rm_notification
+				 */
+				if (!ret && !gh_vcpu_check_system(vcpu))
+					goto out;
+				break;
+			case GH_VCPU_STATE_BLOCKED:
+				schedule();
+				break;
+			case GH_VCPU_ADDRSPACE_VMMIO_READ:
+			case GH_VCPU_ADDRSPACE_VMMIO_WRITE:
+				if (!gh_handle_mmio(vcpu, &vcpu_run_resp))
+					goto out;
+				break;
+			default:
+				pr_warn_ratelimited("Unknown vCPU state: %llx\n",
+							vcpu_run_resp.state);
+				schedule();
+				break;
+			}
+		} else if (gh_error == GH_ERROR_RETRY) {
+			schedule();
+			ret = 0;
+		} else
+			ret = gh_remap_error(gh_error);
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
+	gh_vm_put(vcpu->ghvm);
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
+static int gunyah_vcpu_populate(struct gh_vm_resource_ticket *ticket, struct gunyah_resource *ghrsc)
+{
+	struct gunyah_vcpu *vcpu = container_of(ticket, struct gunyah_vcpu, ticket);
+	int ret;
+
+	mutex_lock(&vcpu->run_lock);
+	if (vcpu->rsc) {
+		ret = -1;
+		goto out;
+	}
+
+	vcpu->rsc = ghrsc;
+	init_completion(&vcpu->ready);
+
+	ret = request_irq(vcpu->rsc->irq, gh_vcpu_irq_handler, IRQF_TRIGGER_RISING, "gh_vcpu",
+			vcpu);
+	if (ret)
+		pr_warn("Failed to request vcpu irq %d: %d", vcpu->rsc->irq, ret);
+
+out:
+	mutex_unlock(&vcpu->run_lock);
+	return ret;
+}
+
+static void gunyah_vcpu_unpopulate(struct gh_vm_resource_ticket *ticket,
+				   struct gunyah_resource *ghrsc)
+{
+	struct gunyah_vcpu *vcpu = container_of(ticket, struct gunyah_vcpu, ticket);
+
+	vcpu->vcpu_run->immediate_exit = true;
+	complete_all(&vcpu->ready);
+	mutex_lock(&vcpu->run_lock);
+	free_irq(vcpu->rsc->irq, vcpu);
+	vcpu->rsc = NULL;
+	mutex_unlock(&vcpu->run_lock);
+}
+
+static long gunyah_vcpu_bind(struct gh_vm_function_instance *f)
+{
+	struct gunyah_vcpu *vcpu;
+	char name[MAX_VCPU_NAME];
+	struct file *file;
+	struct page *page;
+	int fd;
+	long r;
+
+	if (!gh_api_has_feature(GH_API_FEATURE_VCPU))
+		return -EOPNOTSUPP;
+
+	if (f->arg_size)
+		return -EINVAL;
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
+	vcpu->ticket.label = f->arg;
+	vcpu->ticket.owner = THIS_MODULE;
+	vcpu->ticket.populate = gunyah_vcpu_populate;
+	vcpu->ticket.unpopulate = gunyah_vcpu_unpopulate;
+
+	r = gh_vm_add_resource_ticket(f->ghvm, &vcpu->ticket);
+	if (r)
+		goto err_destroy_page;
+
+	fd = get_unused_fd_flags(O_CLOEXEC);
+	if (fd < 0) {
+		r = fd;
+		goto err_remove_vcpu;
+	}
+
+	if (!gh_vm_get(f->ghvm)) {
+		r = -ENODEV;
+		goto err_put_fd;
+	}
+	vcpu->ghvm = f->ghvm;
+
+	vcpu->nb.notifier_call = gh_vcpu_rm_notification;
+	/* Ensure we run after the vm_mgr handles the notification and does
+	 * any necessary state changes. We wake up to check the new state.
+	 */
+	vcpu->nb.priority = -1;
+	r = gh_rm_notifier_register(f->rm, &vcpu->nb);
+	if (r)
+		goto err_put_gh_vm;
+
+	kref_get(&vcpu->kref);
+	snprintf(name, sizeof(name), "gh-vcpu:%d", vcpu->ticket.label);
+	file = anon_inode_getfile(name, &gh_vcpu_fops, vcpu, O_RDWR);
+	if (IS_ERR(file)) {
+		r = PTR_ERR(file);
+		goto err_notifier;
+	}
+
+	fd_install(fd, file);
+
+	return fd;
+err_notifier:
+	gh_rm_notifier_unregister(f->rm, &vcpu->nb);
+err_put_gh_vm:
+	gh_vm_put(vcpu->ghvm);
+err_put_fd:
+	put_unused_fd(fd);
+err_remove_vcpu:
+	gh_vm_remove_resource_ticket(f->ghvm, &vcpu->ticket);
+err_destroy_page:
+	free_page((unsigned long)vcpu->vcpu_run);
+err_destroy_vcpu:
+	kfree(vcpu);
+	return r;
+}
+
+static void gunyah_vcpu_unbind(struct gh_vm_function_instance *f)
+{
+	struct gunyah_vcpu *vcpu = f->data;
+
+	gh_rm_notifier_unregister(f->rm, &vcpu->nb);
+	gh_vm_remove_resource_ticket(vcpu->f->ghvm, &vcpu->ticket);
+	vcpu->f = NULL;
+
+	kref_put(&vcpu->kref, vcpu_release);
+}
+
+DECLARE_GUNYAH_VM_FUNCTION_INIT(vcpu, GH_FN_VCPU, gunyah_vcpu_bind, gunyah_vcpu_unbind);
+MODULE_DESCRIPTION("Gunyah vCPU Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
index 24829db17a0d..7ec9f4c7a982 100644
--- a/drivers/virt/gunyah/vm_mgr.c
+++ b/drivers/virt/gunyah/vm_mgr.c
@@ -378,6 +378,10 @@ static int gh_vm_rm_notification_exited(struct gh_vm *ghvm, void *data)
 
 	down_write(&ghvm->status_lock);
 	ghvm->vm_status = GH_RM_VM_STATUS_EXITED;
+	ghvm->exit_info.type = le16_to_cpu(payload->exit_type);
+	ghvm->exit_info.reason_size = le32_to_cpu(payload->exit_reason_size);
+	memcpy(&ghvm->exit_info.reason, payload->exit_reason,
+		min(GH_VM_MAX_EXIT_REASON_SIZE, ghvm->exit_info.reason_size));
 	up_write(&ghvm->status_lock);
 
 	return NOTIFY_DONE;
diff --git a/drivers/virt/gunyah/vm_mgr.h b/drivers/virt/gunyah/vm_mgr.h
index 70802cd7cbe1..5e200d9f6f06 100644
--- a/drivers/virt/gunyah/vm_mgr.h
+++ b/drivers/virt/gunyah/vm_mgr.h
@@ -45,6 +45,7 @@ struct gh_vm {
 	enum gh_rm_vm_status vm_status;
 	wait_queue_head_t vm_status_wait;
 	struct rw_semaphore status_lock;
+	struct gh_vm_exit_info exit_info;
 
 	struct work_struct free_work;
 	struct kref kref;
diff --git a/include/linux/gunyah.h b/include/linux/gunyah.h
index a06d5fa68a65..c819df72d303 100644
--- a/include/linux/gunyah.h
+++ b/include/linux/gunyah.h
@@ -179,4 +179,12 @@ enum gh_error gh_hypercall_msgq_send(u64 capid, size_t size, uintptr_t buff, int
 enum gh_error gh_hypercall_msgq_recv(u64 capid, uintptr_t buff, size_t size, size_t *recv_size,
 					bool *ready);
 
+struct gh_hypercall_vcpu_run_resp {
+	u64 state;
+	u64 state_data[3];
+};
+
+enum gh_error gh_hypercall_vcpu_run(u64 capid, u64 *resume_data,
+					struct gh_hypercall_vcpu_run_resp *resp);
+
 #endif
diff --git a/include/uapi/linux/gunyah.h b/include/uapi/linux/gunyah.h
index 8df455a2a293..1173ff0329c2 100644
--- a/include/uapi/linux/gunyah.h
+++ b/include/uapi/linux/gunyah.h
@@ -66,6 +66,12 @@ struct gh_vm_dtb_config {
 
 #define GH_VM_START		_IO(GH_IOCTL_TYPE, 0x3)
 
+/**
+ * GH_FN_VCPU - create a vCPU instance to control a vCPU
+ * gh_fn_desc usage: arg_size must be 0, arg must be the vcpu's ID
+ */
+#define GH_FN_VCPU 		1
+
 #define GH_FN_MAX_ARG_SIZE		256
 
 /**
@@ -83,4 +89,59 @@ struct gh_fn_desc {
 #define GH_VM_ADD_FUNCTION	_IOW(GH_IOCTL_TYPE, 0x4, struct gh_fn_desc)
 #define GH_VM_REMOVE_FUNCTION	_IOW(GH_IOCTL_TYPE, 0x7, struct gh_fn_desc)
 
+enum gh_vm_status {
+	GH_VM_STATUS_LOAD_FAILED	= 1,
+#define GH_VM_STATUS_LOAD_FAILED	GH_VM_STATUS_LOAD_FAILED
+	GH_VM_STATUS_EXITED		= 2,
+#define GH_VM_STATUS_EXITED		GH_VM_STATUS_EXITED
+	GH_VM_STATUS_CRASHED		= 3,
+#define GH_VM_STATUS_CRASHED		GH_VM_STATUS_CRASHED
+};
+
+/**
+ * Gunyah presently will send max 4 bytes of exit_reason.
+ * If that changes, this macro can be safely increased without breaking
+ * userspace so long as struct gh_vcpu_run < PAGE_SIZE.
+ */
+#define GH_VM_MAX_EXIT_REASON_SIZE	8u
+
+struct gh_vm_exit_info {
+	__u16 type;
+	__u16 reserved;
+	__u32 reason_size;
+	__u8 reason[GH_VM_MAX_EXIT_REASON_SIZE];
+};
+
+/* for GH_VCPU_RUN, returned by mmap(vcpu_fd, offset=0) */
+struct gh_vcpu_run {
+	/* in */
+	__u8 immediate_exit;
+	__u8 padding1[7];
+
+	/* out */
+#define GH_VCPU_EXIT_UNKNOWN            0
+#define GH_VCPU_EXIT_MMIO               1
+#define GH_VCPU_EXIT_STATUS             2
+	__u32 exit_reason;
+
+	union {
+		/* GH_VCPU_EXIT_MMIO */
+		struct {
+			__u64 phys_addr;
+			__u8  data[8];
+			__u32 len;
+			__u8  is_write;
+		} mmio;
+
+		/* GH_VCPU_EXIT_STATUS */
+		struct {
+			enum gh_vm_status status;
+			struct gh_vm_exit_info exit_info;
+		} status;
+	};
+};
+
+#define GH_VCPU_RUN		_IO(GH_IOCTL_TYPE, 0x5)
+#define GH_VCPU_MMAP_SIZE	_IO(GH_IOCTL_TYPE, 0x6)
+
 #endif
-- 
2.39.1


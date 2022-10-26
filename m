Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F3360E814
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 21:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbiJZTBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 15:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234556AbiJZTAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 15:00:52 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E703A13F89;
        Wed, 26 Oct 2022 11:59:53 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29QIps1N001934;
        Wed, 26 Oct 2022 18:59:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=6YwSUwMcVDMg5THw4DKg7KN4EZmOMtJ4XVI/qBW5/FY=;
 b=LAh2jUe+PRFY59CVW3XDLx3gD9OcT+wZESlNjZ7x4Vh8C1Yd+jeYH7aWOoNjHd9lzNpr
 fDBYD8unLNaR1hAHEuNw8H166r86xiRuIIb5dYpsPEyOcpxZzA2qMkDlv/pmgLkO/E+9
 Xtscyee9XgBxFo3NFxS5Oj0D9zOhkx64PQfZ652MKWj8bkCik/Te123MNZ1O/TWgbff6
 z7c0H/ih3opFInv7q0god8Zh5MO+YuPEfeb306a5Xvj3RwdbO7AzclUw+YDp/SOuUeTi
 OPl7vzk7q8e/dSiuQ4qQj7yi4uhrR9SoN8eLgQBz2g7BaTke00SRcxHLYSYVM+uvbu+V oQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kfahu80r5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Oct 2022 18:59:38 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29QIxbOn010691
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Oct 2022 18:59:37 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 26 Oct 2022 11:59:36 -0700
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
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
        "Arnd Bergmann" <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Kalle Valo <kvalo@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 16/21] gunyah: vm_mgr: Add ioctls to support basic non-proxy VM boot
Date:   Wed, 26 Oct 2022 11:58:41 -0700
Message-ID: <20221026185846.3983888-17-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221026185846.3983888-1-quic_eberman@quicinc.com>
References: <20221026185846.3983888-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: stP8UsQ1cDlSfEITL95jvwkivOkcSyQV
X-Proofpoint-ORIG-GUID: stP8UsQ1cDlSfEITL95jvwkivOkcSyQV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_07,2022-10-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2210260105
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add remaining ioctls to support non-proxy VM boot:

 - Gunyah Resource Manager uses the VM's devicetree to configure the
   virtual machine. The location of the devicetree in the guest's
   virtual memory can be declared via the SET_DTB_CONFIG ioctl.
 - Trigger start of the virtual machine with VM_START ioctl.

Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 arch/arm64/include/uapi/asm/gunyah.h | 17 ++++++
 drivers/virt/gunyah/vm_mgr.c         | 91 ++++++++++++++++++++++++++++
 drivers/virt/gunyah/vm_mgr.h         |  9 +++
 drivers/virt/gunyah/vm_mgr_mm.c      | 29 +++++++--
 include/uapi/linux/gunyah.h          |  8 +++
 5 files changed, 149 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm64/include/uapi/asm/gunyah.h

diff --git a/arch/arm64/include/uapi/asm/gunyah.h b/arch/arm64/include/uapi/asm/gunyah.h
new file mode 100644
index 000000000000..54986f075ef5
--- /dev/null
+++ b/arch/arm64/include/uapi/asm/gunyah.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
+/*
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _UAPI_ASM_GUNYAH
+#define _UAPI_ASM_GUNYAH
+
+#define GH_REG_GENERAL	0x10000
+#define GH_REG_X_MASK	0x1f
+#define GH_REG_SPECIAL	0x20000
+
+#define GH_REG_X(n)	(GH_REG_GENERAL | (n & GH_REG_X_MASK))
+#define GH_REG_PC	(GH_REG_SPECIAL)
+#define GH_REG_SP_EL1	(GH_REG_SPECIAL + 1)
+
+#endif
diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
index a993e81a20e2..3dae2fd9e412 100644
--- a/drivers/virt/gunyah/vm_mgr.c
+++ b/drivers/virt/gunyah/vm_mgr.c
@@ -9,6 +9,7 @@
 #include <linux/file.h>
 #include <linux/gunyah_rsc_mgr.h>
 #include <linux/miscdevice.h>
+#include <linux/mm.h>
 #include <linux/module.h>
 
 #include <uapi/linux/gunyah.h>
@@ -32,10 +33,79 @@ static __must_check struct gunyah_vm *gunyah_vm_alloc(void)
 
 	mutex_init(&ghvm->mm_lock);
 	INIT_LIST_HEAD(&ghvm->memory_mappings);
+	init_rwsem(&ghvm->status_lock);
 
 	return ghvm;
 }
 
+static int gh_vm_start(struct gunyah_vm *ghvm)
+{
+	struct gunyah_vm_memory_mapping *mapping;
+	u64 dtb_offset;
+	u32 mem_handle;
+	int ret;
+
+	down_write(&ghvm->status_lock);
+	if (ghvm->vm_status != GH_RM_VM_STATUS_NO_STATE) {
+		up_write(&ghvm->status_lock);
+		return 0;
+	}
+
+	mapping = gh_vm_mem_mapping_find_mapping(ghvm,
+			ghvm->dtb_config.gpa, ghvm->dtb_config.size);
+	if (!mapping) {
+		pr_warn("Failed to find the memory_handle for DTB\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
+	mem_handle = mapping->parcel.mem_handle;
+	dtb_offset = ghvm->dtb_config.gpa - mapping->guest_phys_addr;
+
+	ret = gh_rm_vm_configure(ghvm->vmid, ghvm->auth, mem_handle,
+				0, 0, dtb_offset, ghvm->dtb_config.size);
+	if (ret) {
+		pr_warn("Failed to configure VM: %d\n", ret);
+		goto err;
+	}
+
+	ret = gh_rm_vm_init(ghvm->vmid);
+	if (ret) {
+		pr_warn("Failed to initialize VM: %d\n", ret);
+		goto err;
+	}
+
+	ret = gh_rm_vm_start(ghvm->vmid);
+	if (ret) {
+		pr_warn("Failed to start VM: %d\n", ret);
+		goto err;
+	}
+
+	ghvm->vm_status = GH_RM_VM_STATUS_READY;
+
+	up_write(&ghvm->status_lock);
+	return ret;
+err:
+	ghvm->vm_status = GH_RM_VM_STATUS_INIT_FAILED;
+	up_write(&ghvm->status_lock);
+	return ret;
+}
+
+static void gh_vm_stop(struct gunyah_vm *ghvm)
+{
+	int ret;
+
+	down_write(&ghvm->status_lock);
+	if (ghvm->vm_status == GH_RM_VM_STATUS_READY) {
+		ret = gh_rm_vm_stop(ghvm->vmid);
+		if (ret)
+			pr_warn("Failed to stop VM: %d\n", ret);
+	}
+
+	ghvm->vm_status = GH_RM_VM_STATUS_EXITED;
+	up_write(&ghvm->status_lock);
+}
+
 static long gh_vm_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct gunyah_vm *ghvm = filp->private_data;
@@ -79,6 +149,25 @@ static long gh_vm_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		}
 		break;
 	}
+	case GH_VM_SET_DTB_CONFIG: {
+		struct gh_vm_dtb_config dtb_config;
+
+		r = -EFAULT;
+		if (copy_from_user(&dtb_config, argp, sizeof(dtb_config)))
+			break;
+
+		dtb_config.size = PAGE_ALIGN(dtb_config.size);
+		ghvm->dtb_config = dtb_config;
+
+		r = 0;
+		break;
+	}
+	case GH_VM_START: {
+		r = gh_vm_start(ghvm);
+		if (r)
+			r = -EINVAL;
+		break;
+	}
 	default:
 		r = -ENOTTY;
 		break;
@@ -92,6 +181,8 @@ static int gh_vm_release(struct inode *inode, struct file *filp)
 	struct gunyah_vm *ghvm = filp->private_data;
 	struct gunyah_vm_memory_mapping *mapping, *tmp;
 
+	gh_vm_stop(ghvm);
+
 	list_for_each_entry_safe(mapping, tmp, &ghvm->memory_mappings, list) {
 		gh_vm_mem_mapping_reclaim(ghvm, mapping);
 	}
diff --git a/drivers/virt/gunyah/vm_mgr.h b/drivers/virt/gunyah/vm_mgr.h
index ab1f0cb0758a..38ce3a2d9329 100644
--- a/drivers/virt/gunyah/vm_mgr.h
+++ b/drivers/virt/gunyah/vm_mgr.h
@@ -9,6 +9,7 @@
 #include <linux/gunyah_rsc_mgr.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
+#include <linux/rwsem.h>
 
 #include <uapi/linux/gunyah.h>
 
@@ -31,6 +32,12 @@ struct gunyah_vm_memory_mapping {
 struct gunyah_vm {
 	u16 vmid;
 
+	enum gh_rm_vm_auth_mechanism auth;
+	struct gh_vm_dtb_config dtb_config;
+
+	enum gh_rm_vm_status vm_status;
+	struct rw_semaphore status_lock;
+
 	struct mutex mm_lock;
 	struct list_head memory_mappings;
 };
@@ -39,5 +46,7 @@ struct gunyah_vm_memory_mapping *gh_vm_mem_mapping_alloc(struct gunyah_vm *ghvm,
 							struct gh_userspace_memory_region *region);
 void gh_vm_mem_mapping_reclaim(struct gunyah_vm *ghvm, struct gunyah_vm_memory_mapping *mapping);
 struct gunyah_vm_memory_mapping *gh_vm_mem_mapping_find(struct gunyah_vm *ghvm, u32 label);
+struct gunyah_vm_memory_mapping *gh_vm_mem_mapping_find_mapping(struct gunyah_vm *ghvm,
+								u64 gpa, u32 size);
 
 #endif
diff --git a/drivers/virt/gunyah/vm_mgr_mm.c b/drivers/virt/gunyah/vm_mgr_mm.c
index a5a57a38ee09..a7ca9a2e1627 100644
--- a/drivers/virt/gunyah/vm_mgr_mm.c
+++ b/drivers/virt/gunyah/vm_mgr_mm.c
@@ -34,11 +34,6 @@ void gh_vm_mem_mapping_reclaim(struct gunyah_vm *ghvm, struct gunyah_vm_memory_m
 	int i, ret = 0;
 
 	if (mapping->parcel.mem_handle != GH_MEM_HANDLE_INVAL) {
-		down_read(&ghvm->status_lock);
-		if (mapping->parcel.mem_handle == ghvm->primary_mem_handle &&
-			ghvm->vm_status == GH_RM_VM_STATUS_NO_STATE)
-			ghvm->primary_mem_handle = 0;
-		up_read(&ghvm->status_lock);
 		ret = gh_rm_mem_reclaim(&mapping->parcel);
 		if (ret)
 			pr_warn("Failed to reclaim memory parcel for label %d: %d\n",
@@ -58,6 +53,30 @@ void gh_vm_mem_mapping_reclaim(struct gunyah_vm *ghvm, struct gunyah_vm_memory_m
 	mutex_unlock(&ghvm->mm_lock);
 }
 
+struct gunyah_vm_memory_mapping *gh_vm_mem_mapping_find_mapping(struct gunyah_vm *ghvm,
+								u64 gpa, u32 size)
+{
+	struct gunyah_vm_memory_mapping *mapping = NULL;
+	int ret;
+
+	ret = mutex_lock_interruptible(&ghvm->mm_lock);
+	if (ret)
+		return ERR_PTR(ret);
+
+	list_for_each_entry(mapping, &ghvm->memory_mappings, list) {
+		if (gpa >= mapping->guest_phys_addr &&
+			(gpa + size <= mapping->guest_phys_addr +
+			(mapping->npages << PAGE_SHIFT))) {
+			goto unlock;
+		}
+	}
+
+	mapping = NULL;
+unlock:
+	mutex_unlock(&ghvm->mm_lock);
+	return mapping;
+}
+
 struct gunyah_vm_memory_mapping *gh_vm_mem_mapping_find(struct gunyah_vm *ghvm, u32 label)
 {
 	struct gunyah_vm_memory_mapping *mapping;
diff --git a/include/uapi/linux/gunyah.h b/include/uapi/linux/gunyah.h
index 93f4b99fcaf6..575cb1cbd215 100644
--- a/include/uapi/linux/gunyah.h
+++ b/include/uapi/linux/gunyah.h
@@ -42,4 +42,12 @@ struct gh_userspace_memory_region {
 #define GH_VM_SET_USER_MEM_REGION	_IOW(GH_IOCTL_TYPE, 0x41, \
 						struct gh_userspace_memory_region)
 
+struct gh_vm_dtb_config {
+	__u64 gpa;
+	__u64 size;
+};
+#define GH_VM_SET_DTB_CONFIG	_IOW(GH_IOCTL_TYPE, 0x42, struct gh_vm_dtb_config)
+
+#define GH_VM_START		_IO(GH_IOCTL_TYPE, 0x45)
+
 #endif
-- 
2.25.1


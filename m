Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2610D65166A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 00:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbiLSXEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 18:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233036AbiLSXCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 18:02:37 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA41E15FDF;
        Mon, 19 Dec 2022 15:00:59 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJM0DJp028616;
        Mon, 19 Dec 2022 23:00:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=S2ANioppZ6/C/QnLy9PdhKAcZQR2bbFolOCyfnsCock=;
 b=cNKamNrueDE94rH+e8Bxk4FY4sS5CRxDwbrWT7mzLL+QfeW60P+5akTyUDRDa19Otx5F
 +QZC8n2o1rf0ICaxUUkaPCH9lJ4rmHcS4wp157r1O88I+IaQAL3gEdeeKsviKSxShFwJ
 6p94ztRHKaDkaonay9TLjzHwAr4bCIXO1pSgc06YdA0uwv+Ys9CGvUatzoHtJrZnaEsT
 xIVOEDQL2SCgb0/J0Bmsyx1d7SO6dzI3vLk/nFptIujelj3PD8kE+D0NBLbW8mnCs+i0
 B5pCzu3tP1krIPLfdjsquD1iUmU+fNqAytP3K1j6cbbETK4cguLZUAnNEkyAiOoABmfK 9g== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mjyk505xh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 23:00:37 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BJN0b2V007824
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 23:00:37 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 19 Dec 2022 15:00:36 -0800
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>
CC:     Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Bagas Sanjaya" <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        "Sudeep Holla" <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>
Subject: [PATCH v8 15/28] gunyah: vm_mgr: Add ioctls to support basic non-proxy VM boot
Date:   Mon, 19 Dec 2022 14:58:36 -0800
Message-ID: <20221219225850.2397345-16-quic_eberman@quicinc.com>
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
X-Proofpoint-GUID: oxRFipY145lKFcDx-jwzXz3WOinh7nNE
X-Proofpoint-ORIG-GUID: oxRFipY145lKFcDx-jwzXz3WOinh7nNE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_01,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212190202
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/virt/gunyah/vm_mgr.c    | 92 ++++++++++++++++++++++++++++++++-
 drivers/virt/gunyah/vm_mgr.h    |  9 ++++
 drivers/virt/gunyah/vm_mgr_mm.c | 24 +++++++++
 include/uapi/linux/gunyah.h     |  8 +++
 4 files changed, 132 insertions(+), 1 deletion(-)

diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
index a7220ad41669..a96cb7f73754 100644
--- a/drivers/virt/gunyah/vm_mgr.c
+++ b/drivers/virt/gunyah/vm_mgr.c
@@ -8,7 +8,7 @@
 #include <linux/anon_inodes.h>
 #include <linux/file.h>
 #include <linux/gunyah_rsc_mgr.h>
-#include <linux/miscdevice.h>
+#include <linux/mm.h>
 #include <linux/module.h>
 
 #include <uapi/linux/gunyah.h>
@@ -35,10 +35,79 @@ static __must_check struct gunyah_vm *gunyah_vm_alloc(struct gh_rm_rpc *rm)
 
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
+	ret = gh_rm_vm_configure(ghvm->rm, ghvm->vmid, ghvm->auth, mem_handle,
+				0, 0, dtb_offset, ghvm->dtb_config.size);
+	if (ret) {
+		pr_warn("Failed to configure VM: %d\n", ret);
+		goto err;
+	}
+
+	ret = gh_rm_vm_init(ghvm->rm, ghvm->vmid);
+	if (ret) {
+		pr_warn("Failed to initialize VM: %d\n", ret);
+		goto err;
+	}
+
+	ret = gh_rm_vm_start(ghvm->rm, ghvm->vmid);
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
+		ret = gh_rm_vm_stop(ghvm->rm, ghvm->vmid);
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
@@ -82,6 +151,25 @@ static long gh_vm_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
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
@@ -95,6 +183,8 @@ static int gh_vm_release(struct inode *inode, struct file *filp)
 	struct gunyah_vm *ghvm = filp->private_data;
 	struct gunyah_vm_memory_mapping *mapping, *tmp;
 
+	gh_vm_stop(ghvm);
+
 	list_for_each_entry_safe(mapping, tmp, &ghvm->memory_mappings, list) {
 		gh_vm_mem_mapping_reclaim(ghvm, mapping);
 	}
diff --git a/drivers/virt/gunyah/vm_mgr.h b/drivers/virt/gunyah/vm_mgr.h
index 955856c1310b..8dcba9f14b5c 100644
--- a/drivers/virt/gunyah/vm_mgr.h
+++ b/drivers/virt/gunyah/vm_mgr.h
@@ -10,6 +10,7 @@
 #include <linux/list.h>
 #include <linux/miscdevice.h>
 #include <linux/mutex.h>
+#include <linux/rwsem.h>
 
 #include <uapi/linux/gunyah.h>
 
@@ -40,6 +41,12 @@ struct gunyah_vm {
 	u16 vmid;
 	struct gh_rm_rpc *rm;
 
+	enum gh_rm_vm_auth_mechanism auth;
+	struct gh_vm_dtb_config dtb_config;
+
+	enum gh_rm_vm_status vm_status;
+	struct rw_semaphore status_lock;
+
 	struct mutex mm_lock;
 	struct list_head memory_mappings;
 };
@@ -48,5 +55,7 @@ struct gunyah_vm_memory_mapping *gh_vm_mem_mapping_alloc(struct gunyah_vm *ghvm,
 							struct gh_userspace_memory_region *region);
 void gh_vm_mem_mapping_reclaim(struct gunyah_vm *ghvm, struct gunyah_vm_memory_mapping *mapping);
 struct gunyah_vm_memory_mapping *gh_vm_mem_mapping_find(struct gunyah_vm *ghvm, u32 label);
+struct gunyah_vm_memory_mapping *gh_vm_mem_mapping_find_mapping(struct gunyah_vm *ghvm,
+								u64 gpa, u32 size);
 
 #endif
diff --git a/drivers/virt/gunyah/vm_mgr_mm.c b/drivers/virt/gunyah/vm_mgr_mm.c
index 800d35da14ba..82d8e567b1a8 100644
--- a/drivers/virt/gunyah/vm_mgr_mm.c
+++ b/drivers/virt/gunyah/vm_mgr_mm.c
@@ -53,6 +53,30 @@ void gh_vm_mem_mapping_reclaim(struct gunyah_vm *ghvm, struct gunyah_vm_memory_m
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
index 574f33b198d0..36359ad2175e 100644
--- a/include/uapi/linux/gunyah.h
+++ b/include/uapi/linux/gunyah.h
@@ -42,4 +42,12 @@ struct gh_userspace_memory_region {
 #define GH_VM_SET_USER_MEM_REGION	_IOW(GH_IOCTL_TYPE, 0x1, \
 						struct gh_userspace_memory_region)
 
+struct gh_vm_dtb_config {
+	__u64 gpa;
+	__u64 size;
+};
+#define GH_VM_SET_DTB_CONFIG	_IOW(GH_IOCTL_TYPE, 0x2, struct gh_vm_dtb_config)
+
+#define GH_VM_START		_IO(GH_IOCTL_TYPE, 0x3)
+
 #endif
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5CD6ED88F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 01:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbjDXXRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 19:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbjDXXRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 19:17:19 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F56A253;
        Mon, 24 Apr 2023 16:16:57 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33OMF1Xr008934;
        Mon, 24 Apr 2023 23:16:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=OiaoQlWJMxZipymNqSdud0B4nLvAFeMnWnqOtCF6KHA=;
 b=nqgGWpaE2vev2J/EteGq3Wdew1sZck1pkKOEqAJUQAQdUJLE178iFbOfUatJ+tctWhG/
 xC+jEwyNBEy2H7GG2YCL0OjcVM48eMHWf4u0WzsfbnmVYiWq3mSqScZKH+B5rD2NHQwY
 gc8nFquWN0zDcAjEXxG1+Edfim1uind1XJwQxmOjR5lzb2ROmplxEBwk8A5pnP/tGr5W
 mdGfZqOPQgSClcoDvuibkFK1zyCiL0nelYbd4sSIOpC/Yb7rvpNiBZXeIa4IAOzblyfN
 5dRYRKU4+tTJBiHR0UX7strNOe1/p3/fTchoIBEVwyqeE3Rs7Yrhuwk3tOCYNJaL9N4K kg== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q5kbut3r9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Apr 2023 23:16:44 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33ONGh9T029971
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Apr 2023 23:16:43 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 24 Apr 2023 16:16:43 -0700
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
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
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v12 11/25] gunyah: vm_mgr: Add/remove user memory regions
Date:   Mon, 24 Apr 2023 16:15:44 -0700
Message-ID: <20230424231558.70911-12-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230424231558.70911-1-quic_eberman@quicinc.com>
References: <20230424231558.70911-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: SY7EEDmUaP_Ux0stgJbtiWGwqQAfp9nU
X-Proofpoint-GUID: SY7EEDmUaP_Ux0stgJbtiWGwqQAfp9nU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-24_11,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304240211
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When launching a virtual machine, Gunyah userspace allocates memory for
the guest and informs Gunyah about these memory regions through
SET_USER_MEMORY_REGION ioctl.

Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/virt/gunyah/Makefile    |   2 +-
 drivers/virt/gunyah/vm_mgr.c    |  59 +++++++-
 drivers/virt/gunyah/vm_mgr.h    |  26 ++++
 drivers/virt/gunyah/vm_mgr_mm.c | 236 ++++++++++++++++++++++++++++++++
 include/uapi/linux/gunyah.h     |  37 +++++
 5 files changed, 356 insertions(+), 4 deletions(-)
 create mode 100644 drivers/virt/gunyah/vm_mgr_mm.c

diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
index e47e25895299..bacf78b8fa33 100644
--- a/drivers/virt/gunyah/Makefile
+++ b/drivers/virt/gunyah/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
-gunyah-y += rsc_mgr.o rsc_mgr_rpc.o vm_mgr.o
+gunyah-y += rsc_mgr.o rsc_mgr_rpc.o vm_mgr.o vm_mgr_mm.o
 obj-$(CONFIG_GUNYAH) += gunyah.o
diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
index a43401cb34f7..297427952b8c 100644
--- a/drivers/virt/gunyah/vm_mgr.c
+++ b/drivers/virt/gunyah/vm_mgr.c
@@ -15,6 +15,8 @@
 
 #include "vm_mgr.h"
 
+static void gh_vm_free(struct work_struct *work);
+
 static __must_check struct gh_vm *gh_vm_alloc(struct gh_rm *rm)
 {
 	struct gh_vm *ghvm;
@@ -26,20 +28,72 @@ static __must_check struct gh_vm *gh_vm_alloc(struct gh_rm *rm)
 	ghvm->parent = gh_rm_get(rm);
 	ghvm->rm = rm;
 
+	mmgrab(current->mm);
+	ghvm->mm = current->mm;
+	mutex_init(&ghvm->mm_lock);
+	INIT_LIST_HEAD(&ghvm->memory_mappings);
+	INIT_WORK(&ghvm->free_work, gh_vm_free);
+
 	return ghvm;
 }
 
-static int gh_vm_release(struct inode *inode, struct file *filp)
+static long gh_vm_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct gh_vm *ghvm = filp->private_data;
+	void __user *argp = (void __user *)arg;
+	long r;
+
+	switch (cmd) {
+	case GH_VM_SET_USER_MEM_REGION: {
+		struct gh_userspace_memory_region region;
+
+		/* only allow owner task to add memory */
+		if (ghvm->mm != current->mm)
+			return -EPERM;
+
+		if (copy_from_user(&region, argp, sizeof(region)))
+			return -EFAULT;
+
+		/* All other flag bits are reserved for future use */
+		if (region.flags & ~(GH_MEM_ALLOW_READ | GH_MEM_ALLOW_WRITE | GH_MEM_ALLOW_EXEC))
+			return -EINVAL;
+
+		r = gh_vm_mem_alloc(ghvm, &region);
+		break;
+	}
+	default:
+		r = -ENOTTY;
+		break;
+	}
 
+	return r;
+}
+
+static void gh_vm_free(struct work_struct *work)
+{
+	struct gh_vm *ghvm = container_of(work, struct gh_vm, free_work);
+
+	gh_vm_mem_reclaim(ghvm);
 	gh_rm_put(ghvm->rm);
+	mmdrop(ghvm->mm);
 	kfree(ghvm);
+}
+
+static int gh_vm_release(struct inode *inode, struct file *filp)
+{
+	struct gh_vm *ghvm = filp->private_data;
+
+	/* VM will be reset and make RM calls which can interruptible sleep.
+	 * Defer to a work so this thread can receive signal.
+	 */
+	schedule_work(&ghvm->free_work);
 	return 0;
 }
 
 static const struct file_operations gh_vm_fops = {
 	.owner = THIS_MODULE,
+	.unlocked_ioctl = gh_vm_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 	.release = gh_vm_release,
 	.llseek = noop_llseek,
 };
@@ -77,8 +131,7 @@ static long gh_dev_ioctl_create_vm(struct gh_rm *rm, unsigned long arg)
 err_put_fd:
 	put_unused_fd(fd);
 err_destroy_vm:
-	gh_rm_put(ghvm->rm);
-	kfree(ghvm);
+	gh_vm_free(&ghvm->free_work);
 	return err;
 }
 
diff --git a/drivers/virt/gunyah/vm_mgr.h b/drivers/virt/gunyah/vm_mgr.h
index 1e94b58d7d34..434ef9f662a7 100644
--- a/drivers/virt/gunyah/vm_mgr.h
+++ b/drivers/virt/gunyah/vm_mgr.h
@@ -7,14 +7,40 @@
 #define _GH_VM_MGR_H
 
 #include <linux/gunyah_rsc_mgr.h>
+#include <linux/list.h>
+#include <linux/miscdevice.h>
+#include <linux/mutex.h>
 
 #include <uapi/linux/gunyah.h>
 
 long gh_dev_vm_mgr_ioctl(struct gh_rm *rm, unsigned int cmd, unsigned long arg);
 
+enum gh_vm_mem_share_type {
+	VM_MEM_SHARE,
+	VM_MEM_LEND,
+};
+
+struct gh_vm_mem {
+	struct list_head list;
+	enum gh_vm_mem_share_type share_type;
+	struct gh_rm_mem_parcel parcel;
+
+	__u64 guest_phys_addr;
+	struct page **pages;
+	unsigned long npages;
+};
+
 struct gh_vm {
 	struct gh_rm *rm;
 	struct device *parent;
+
+	struct work_struct free_work;
+	struct mm_struct *mm; /* userspace tied to this vm */
+	struct mutex mm_lock;
+	struct list_head memory_mappings;
 };
 
+int gh_vm_mem_alloc(struct gh_vm *ghvm, struct gh_userspace_memory_region *region);
+void gh_vm_mem_reclaim(struct gh_vm *ghvm);
+
 #endif
diff --git a/drivers/virt/gunyah/vm_mgr_mm.c b/drivers/virt/gunyah/vm_mgr_mm.c
new file mode 100644
index 000000000000..91109bbf36b3
--- /dev/null
+++ b/drivers/virt/gunyah/vm_mgr_mm.c
@@ -0,0 +1,236 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#define pr_fmt(fmt) "gh_vm_mgr: " fmt
+
+#include <linux/gunyah_rsc_mgr.h>
+#include <linux/mm.h>
+
+#include <uapi/linux/gunyah.h>
+
+#include "vm_mgr.h"
+
+static bool pages_are_mergeable(struct page *a, struct page *b)
+{
+	if (page_to_pfn(a) + 1 != page_to_pfn(b))
+		return false;
+	if (!zone_device_pages_have_same_pgmap(a, b))
+		return false;
+	return true;
+}
+
+static bool gh_vm_mem_overlap(struct gh_vm_mem *a, u64 addr, u64 size)
+{
+	u64 a_end = a->guest_phys_addr + (a->npages << PAGE_SHIFT);
+	u64 end = addr + size;
+
+	return a->guest_phys_addr < end && addr < a_end;
+}
+
+static struct gh_vm_mem *__gh_vm_mem_find_by_label(struct gh_vm *ghvm, u32 label)
+	__must_hold(&ghvm->mm_lock)
+{
+	struct gh_vm_mem *mapping;
+
+	list_for_each_entry(mapping, &ghvm->memory_mappings, list)
+		if (mapping->parcel.label == label)
+			return mapping;
+
+	return NULL;
+}
+
+static void gh_vm_mem_reclaim_mapping(struct gh_vm *ghvm, struct gh_vm_mem *mapping)
+	__must_hold(&ghvm->mm_lock)
+{
+	int ret = 0;
+
+	if (mapping->parcel.mem_handle != GH_MEM_HANDLE_INVAL) {
+		ret = gh_rm_mem_reclaim(ghvm->rm, &mapping->parcel);
+		if (ret)
+			pr_warn("Failed to reclaim memory parcel for label %d: %d\n",
+				mapping->parcel.label, ret);
+	}
+
+	if (!ret) {
+		unpin_user_pages(mapping->pages, mapping->npages);
+		account_locked_vm(ghvm->mm, mapping->npages, false);
+	}
+
+	kfree(mapping->pages);
+	kfree(mapping->parcel.acl_entries);
+	kfree(mapping->parcel.mem_entries);
+
+	list_del(&mapping->list);
+}
+
+void gh_vm_mem_reclaim(struct gh_vm *ghvm)
+{
+	struct gh_vm_mem *mapping, *tmp;
+
+	mutex_lock(&ghvm->mm_lock);
+
+	list_for_each_entry_safe(mapping, tmp, &ghvm->memory_mappings, list) {
+		gh_vm_mem_reclaim_mapping(ghvm, mapping);
+		kfree(mapping);
+	}
+
+	mutex_unlock(&ghvm->mm_lock);
+}
+
+int gh_vm_mem_alloc(struct gh_vm *ghvm, struct gh_userspace_memory_region *region)
+{
+	struct gh_vm_mem *mapping, *tmp_mapping;
+	struct page *curr_page, *prev_page;
+	struct gh_rm_mem_parcel *parcel;
+	int i, j, pinned, ret = 0;
+	unsigned int gup_flags;
+	size_t entry_size;
+	u16 vmid;
+
+	if (!region->memory_size || !PAGE_ALIGNED(region->memory_size) ||
+		!PAGE_ALIGNED(region->userspace_addr) ||
+		!PAGE_ALIGNED(region->guest_phys_addr))
+		return -EINVAL;
+
+	if (overflows_type(region->guest_phys_addr + region->memory_size, u64))
+		return -EOVERFLOW;
+
+	ret = mutex_lock_interruptible(&ghvm->mm_lock);
+	if (ret)
+		return ret;
+
+	mapping = __gh_vm_mem_find_by_label(ghvm, region->label);
+	if (mapping) {
+		ret = -EEXIST;
+		goto unlock;
+	}
+
+	list_for_each_entry(tmp_mapping, &ghvm->memory_mappings, list) {
+		if (gh_vm_mem_overlap(tmp_mapping, region->guest_phys_addr,
+					region->memory_size)) {
+			ret = -EEXIST;
+			goto unlock;
+		}
+	}
+
+	mapping = kzalloc(sizeof(*mapping), GFP_KERNEL_ACCOUNT);
+	if (!mapping) {
+		ret = -ENOMEM;
+		goto unlock;
+	}
+
+	mapping->guest_phys_addr = region->guest_phys_addr;
+	mapping->npages = region->memory_size >> PAGE_SHIFT;
+	parcel = &mapping->parcel;
+	parcel->label = region->label;
+	parcel->mem_handle = GH_MEM_HANDLE_INVAL; /* to be filled later by mem_share/mem_lend */
+	parcel->mem_type = GH_RM_MEM_TYPE_NORMAL;
+
+	ret = account_locked_vm(ghvm->mm, mapping->npages, true);
+	if (ret)
+		goto free_mapping;
+
+	mapping->pages = kcalloc(mapping->npages, sizeof(*mapping->pages), GFP_KERNEL_ACCOUNT);
+	if (!mapping->pages) {
+		ret = -ENOMEM;
+		mapping->npages = 0; /* update npages for reclaim */
+		goto unlock_pages;
+	}
+
+	gup_flags = FOLL_LONGTERM;
+	if (region->flags & GH_MEM_ALLOW_WRITE)
+		gup_flags |= FOLL_WRITE;
+
+	pinned = pin_user_pages_fast(region->userspace_addr, mapping->npages,
+					gup_flags, mapping->pages);
+	if (pinned < 0) {
+		ret = pinned;
+		goto free_pages;
+	} else if (pinned != mapping->npages) {
+		ret = -EFAULT;
+		mapping->npages = pinned; /* update npages for reclaim */
+		goto unpin_pages;
+	}
+
+	parcel->n_acl_entries = 2;
+	mapping->share_type = VM_MEM_SHARE;
+	parcel->acl_entries = kcalloc(parcel->n_acl_entries, sizeof(*parcel->acl_entries),
+					GFP_KERNEL);
+	if (!parcel->acl_entries) {
+		ret = -ENOMEM;
+		goto unpin_pages;
+	}
+
+	/* acl_entries[0].vmid will be this VM's vmid. We'll fill it when the
+	 * VM is starting and we know the VM's vmid.
+	 */
+	if (region->flags & GH_MEM_ALLOW_READ)
+		parcel->acl_entries[0].perms |= GH_RM_ACL_R;
+	if (region->flags & GH_MEM_ALLOW_WRITE)
+		parcel->acl_entries[0].perms |= GH_RM_ACL_W;
+	if (region->flags & GH_MEM_ALLOW_EXEC)
+		parcel->acl_entries[0].perms |= GH_RM_ACL_X;
+
+	ret = gh_rm_get_vmid(ghvm->rm, &vmid);
+	if (ret)
+		goto free_acl;
+
+	parcel->acl_entries[1].vmid = cpu_to_le16(vmid);
+	/* Host assumed to have all these permissions. Gunyah will not
+	 * grant new permissions if host actually had less than RWX
+	 */
+	parcel->acl_entries[1].perms = GH_RM_ACL_R | GH_RM_ACL_W | GH_RM_ACL_X;
+
+	parcel->n_mem_entries = 1;
+	for (i = 1; i < mapping->npages; i++) {
+		if (!pages_are_mergeable(mapping->pages[i - 1], mapping->pages[i]))
+			parcel->n_mem_entries++;
+	}
+
+	parcel->mem_entries = kcalloc(parcel->n_mem_entries,
+					sizeof(parcel->mem_entries[0]),
+					GFP_KERNEL_ACCOUNT);
+	if (!parcel->mem_entries) {
+		ret = -ENOMEM;
+		goto free_acl;
+	}
+
+	/* reduce number of entries by combining contiguous pages into single memory entry */
+	prev_page = mapping->pages[0];
+	parcel->mem_entries[0].phys_addr = cpu_to_le64(page_to_phys(prev_page));
+	entry_size = PAGE_SIZE;
+	for (i = 1, j = 0; i < mapping->npages; i++) {
+		curr_page = mapping->pages[i];
+		if (pages_are_mergeable(prev_page, curr_page)) {
+			entry_size += PAGE_SIZE;
+		} else {
+			parcel->mem_entries[j].size = cpu_to_le64(entry_size);
+			j++;
+			parcel->mem_entries[j].phys_addr =
+				cpu_to_le64(page_to_phys(curr_page));
+			entry_size = PAGE_SIZE;
+		}
+
+		prev_page = curr_page;
+	}
+	parcel->mem_entries[j].size = cpu_to_le64(entry_size);
+
+	list_add(&mapping->list, &ghvm->memory_mappings);
+	mutex_unlock(&ghvm->mm_lock);
+	return 0;
+free_acl:
+	kfree(parcel->acl_entries);
+unpin_pages:
+	unpin_user_pages(mapping->pages, pinned);
+free_pages:
+	kfree(mapping->pages);
+unlock_pages:
+	account_locked_vm(ghvm->mm, mapping->npages, false);
+free_mapping:
+	kfree(mapping);
+unlock:
+	mutex_unlock(&ghvm->mm_lock);
+	return ret;
+}
diff --git a/include/uapi/linux/gunyah.h b/include/uapi/linux/gunyah.h
index 86b9cb60118d..91d6dd26fcc8 100644
--- a/include/uapi/linux/gunyah.h
+++ b/include/uapi/linux/gunyah.h
@@ -20,4 +20,41 @@
  */
 #define GH_CREATE_VM			_IO(GH_IOCTL_TYPE, 0x0) /* Returns a Gunyah VM fd */
 
+/*
+ * ioctls for VM fds
+ */
+
+/**
+ * enum gh_mem_flags - Possible flags on &struct gh_userspace_memory_region
+ * @GH_MEM_ALLOW_READ: Allow guest to read the memory
+ * @GH_MEM_ALLOW_WRITE: Allow guest to write to the memory
+ * @GH_MEM_ALLOW_EXEC: Allow guest to execute instructions in the memory
+ */
+enum gh_mem_flags {
+	GH_MEM_ALLOW_READ	= 1UL << 0,
+	GH_MEM_ALLOW_WRITE	= 1UL << 1,
+	GH_MEM_ALLOW_EXEC	= 1UL << 2,
+};
+
+/**
+ * struct gh_userspace_memory_region - Userspace memory descripion for GH_VM_SET_USER_MEM_REGION
+ * @label: Identifer to the region which is unique to the VM.
+ * @flags: Flags for memory parcel behavior. See &enum gh_mem_flags.
+ * @guest_phys_addr: Location of the memory region in guest's memory space (page-aligned)
+ * @memory_size: Size of the region (page-aligned)
+ * @userspace_addr: Location of the memory region in caller (userspace)'s memory
+ *
+ * See Documentation/virt/gunyah/vm-manager.rst for further details.
+ */
+struct gh_userspace_memory_region {
+	__u32 label;
+	__u32 flags;
+	__u64 guest_phys_addr;
+	__u64 memory_size;
+	__u64 userspace_addr;
+};
+
+#define GH_VM_SET_USER_MEM_REGION	_IOW(GH_IOCTL_TYPE, 0x1, \
+						struct gh_userspace_memory_region)
+
 #endif
-- 
2.40.0


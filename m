Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0D865162C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 00:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbiLSXCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 18:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbiLSXBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 18:01:05 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68B415A3B;
        Mon, 19 Dec 2022 15:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1671490835; x=1703026835;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jpU+o+x1FMQZ4pcvTcO2IQ2V2sURu0rFXdBI85aXJoQ=;
  b=sgqhBMHIit9YXzjv39rQPIzx85hYBV9qH19E7d1w6GPX54DOAApavnhC
   epvRlFuMnWqU4ipq58Bt2ho/TChQrfCNI/DKHMnpxVd4+n3ZofWchq6Kx
   8KmKGhcqxsqg0S4GQZH/qEf1Iwky7VTTy1xp6/qacBDo5Mjj0k1Q8kuTz
   Y=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 19 Dec 2022 15:00:35 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 15:00:35 -0800
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 19 Dec 2022 15:00:34 -0800
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
Subject: [PATCH v8 14/28] gunyah: vm_mgr: Add/remove user memory regions
Date:   Mon, 19 Dec 2022 14:58:35 -0800
Message-ID: <20221219225850.2397345-15-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221219225850.2397345-1-quic_eberman@quicinc.com>
References: <20221219225850.2397345-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/virt/gunyah/vm_mgr.c    |  45 +++++++
 drivers/virt/gunyah/vm_mgr.h    |  27 ++++
 drivers/virt/gunyah/vm_mgr_mm.c | 221 ++++++++++++++++++++++++++++++++
 include/uapi/linux/gunyah.h     |  22 ++++
 5 files changed, 316 insertions(+), 1 deletion(-)
 create mode 100644 drivers/virt/gunyah/vm_mgr_mm.c

diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
index e817ae6deddc..9d6f900ab7b0 100644
--- a/drivers/virt/gunyah/Makefile
+++ b/drivers/virt/gunyah/Makefile
@@ -1,5 +1,5 @@
 obj-$(CONFIG_GUNYAH) += gunyah.o
 
 gunyah_rsc_mgr-y += rsc_mgr.o rsc_mgr_rpc.o
-gunyah_rsc_mgr-$(CONFIG_GUNYAH_VM_MANAGER) += vm_mgr.o
+gunyah_rsc_mgr-$(CONFIG_GUNYAH_VM_MANAGER) += vm_mgr.o vm_mgr_mm.o
 obj-$(CONFIG_GUNYAH_RESOURCE_MANAGER) += gunyah_rsc_mgr.o
diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
index 9c796e5edcf1..a7220ad41669 100644
--- a/drivers/virt/gunyah/vm_mgr.c
+++ b/drivers/virt/gunyah/vm_mgr.c
@@ -33,14 +33,55 @@ static __must_check struct gunyah_vm *gunyah_vm_alloc(struct gh_rm_rpc *rm)
 	ghvm->vmid = vmid;
 	ghvm->rm = rm;
 
+	mutex_init(&ghvm->mm_lock);
+	INIT_LIST_HEAD(&ghvm->memory_mappings);
+
 	return ghvm;
 }
 
 static long gh_vm_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
+	struct gunyah_vm *ghvm = filp->private_data;
+	void __user *argp = (void __user *)arg;
 	long r;
 
 	switch (cmd) {
+	case GH_VM_SET_USER_MEM_REGION: {
+		struct gunyah_vm_memory_mapping *mapping;
+		struct gh_userspace_memory_region region;
+
+		r = -EFAULT;
+		if (copy_from_user(&region, argp, sizeof(region)))
+			break;
+
+		r = -EINVAL;
+		/* All other flag bits are reserved for future use */
+		if (region.flags & ~(GH_MEM_ALLOW_READ | GH_MEM_ALLOW_WRITE | GH_MEM_ALLOW_EXEC |
+			GH_MEM_LENT))
+			break;
+
+
+		if (region.memory_size) {
+			r = 0;
+			mapping = gh_vm_mem_mapping_alloc(ghvm, &region);
+			if (IS_ERR(mapping)) {
+				r = PTR_ERR(mapping);
+				break;
+			}
+		} else {
+			mapping = gh_vm_mem_mapping_find(ghvm, region.label);
+			if (IS_ERR(mapping)) {
+				r = PTR_ERR(mapping);
+				break;
+			}
+			r = 0;
+			if (!mapping)
+				break;
+			gh_vm_mem_mapping_reclaim(ghvm, mapping);
+			kfree(mapping);
+		}
+		break;
+	}
 	default:
 		r = -ENOTTY;
 		break;
@@ -52,7 +93,11 @@ static long gh_vm_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 static int gh_vm_release(struct inode *inode, struct file *filp)
 {
 	struct gunyah_vm *ghvm = filp->private_data;
+	struct gunyah_vm_memory_mapping *mapping, *tmp;
 
+	list_for_each_entry_safe(mapping, tmp, &ghvm->memory_mappings, list) {
+		gh_vm_mem_mapping_reclaim(ghvm, mapping);
+	}
 	put_gh_rm(ghvm->rm);
 	kfree(ghvm);
 	return 0;
diff --git a/drivers/virt/gunyah/vm_mgr.h b/drivers/virt/gunyah/vm_mgr.h
index 84e3d1a8571d..955856c1310b 100644
--- a/drivers/virt/gunyah/vm_mgr.h
+++ b/drivers/virt/gunyah/vm_mgr.h
@@ -7,6 +7,9 @@
 #define _GH_PRIV_VM_MGR_H
 
 #include <linux/gunyah_rsc_mgr.h>
+#include <linux/list.h>
+#include <linux/miscdevice.h>
+#include <linux/mutex.h>
 
 #include <uapi/linux/gunyah.h>
 
@@ -17,9 +20,33 @@ static inline long gh_dev_vm_mgr_ioctl(struct gh_rm_rpc *rm, unsigned int cmd, u
 	{ return -ENOIOCTLCMD; }
 #endif
 
+enum gunyah_vm_mem_share_type {
+	VM_MEM_SHARE,
+	VM_MEM_LEND,
+};
+
+struct gunyah_vm_memory_mapping {
+	struct list_head list;
+	enum gunyah_vm_mem_share_type share_type;
+	struct gh_rm_mem_parcel parcel;
+
+	__u64 guest_phys_addr;
+	__u32 mem_size;
+	struct page **pages;
+	unsigned long npages;
+};
+
 struct gunyah_vm {
 	u16 vmid;
 	struct gh_rm_rpc *rm;
+
+	struct mutex mm_lock;
+	struct list_head memory_mappings;
 };
 
+struct gunyah_vm_memory_mapping *gh_vm_mem_mapping_alloc(struct gunyah_vm *ghvm,
+							struct gh_userspace_memory_region *region);
+void gh_vm_mem_mapping_reclaim(struct gunyah_vm *ghvm, struct gunyah_vm_memory_mapping *mapping);
+struct gunyah_vm_memory_mapping *gh_vm_mem_mapping_find(struct gunyah_vm *ghvm, u32 label);
+
 #endif
diff --git a/drivers/virt/gunyah/vm_mgr_mm.c b/drivers/virt/gunyah/vm_mgr_mm.c
new file mode 100644
index 000000000000..800d35da14ba
--- /dev/null
+++ b/drivers/virt/gunyah/vm_mgr_mm.c
@@ -0,0 +1,221 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
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
+static inline bool page_contiguous(phys_addr_t p, phys_addr_t t)
+{
+	return t - p == PAGE_SIZE;
+}
+
+static struct gunyah_vm_memory_mapping *__gh_vm_mem_mapping_find(struct gunyah_vm *ghvm, u32 label)
+{
+	struct gunyah_vm_memory_mapping *mapping;
+
+
+	list_for_each_entry(mapping, &ghvm->memory_mappings, list)
+		if (mapping->parcel.label == label)
+			return mapping;
+
+	return NULL;
+}
+
+void gh_vm_mem_mapping_reclaim(struct gunyah_vm *ghvm, struct gunyah_vm_memory_mapping *mapping)
+{
+	int i, ret = 0;
+
+	if (mapping->parcel.mem_handle != GH_MEM_HANDLE_INVAL) {
+		ret = gh_rm_mem_reclaim(ghvm->rm, &mapping->parcel);
+		if (ret)
+			pr_warn("Failed to reclaim memory parcel for label %d: %d\n",
+				mapping->parcel.label, ret);
+	}
+
+	if (!ret)
+		for (i = 0; i < mapping->npages; i++)
+			unpin_user_page(mapping->pages[i]);
+
+	kfree(mapping->pages);
+	kfree(mapping->parcel.acl_entries);
+	kfree(mapping->parcel.mem_entries);
+
+	mutex_lock(&ghvm->mm_lock);
+	list_del(&mapping->list);
+	mutex_unlock(&ghvm->mm_lock);
+}
+
+struct gunyah_vm_memory_mapping *gh_vm_mem_mapping_find(struct gunyah_vm *ghvm, u32 label)
+{
+	struct gunyah_vm_memory_mapping *mapping;
+	int ret;
+
+	ret = mutex_lock_interruptible(&ghvm->mm_lock);
+	if (ret)
+		return ERR_PTR(ret);
+	mapping = __gh_vm_mem_mapping_find(ghvm, label);
+	mutex_unlock(&ghvm->mm_lock);
+	return mapping;
+}
+
+struct gunyah_vm_memory_mapping *gh_vm_mem_mapping_alloc(struct gunyah_vm *ghvm,
+							struct gh_userspace_memory_region *region)
+{
+	phys_addr_t curr_page, prev_page;
+	struct gunyah_vm_memory_mapping *mapping, *tmp_mapping;
+	struct gh_rm_mem_entry *mem_entries;
+	int i, j, pinned, ret = 0;
+	struct gh_rm_mem_parcel *parcel;
+
+	if (!region->memory_size || !PAGE_ALIGNED(region->memory_size) ||
+		!PAGE_ALIGNED(region->userspace_addr))
+		return ERR_PTR(-EINVAL);
+
+	ret = mutex_lock_interruptible(&ghvm->mm_lock);
+	if (ret)
+		return ERR_PTR(ret);
+	mapping = __gh_vm_mem_mapping_find(ghvm, region->label);
+	if (mapping) {
+		ret = -EEXIST;
+		goto unlock;
+	}
+
+	mapping = kzalloc(sizeof(*mapping), GFP_KERNEL);
+	if (!mapping) {
+		ret = -ENOMEM;
+		goto unlock;
+	}
+
+	mapping->parcel.label = region->label;
+	mapping->guest_phys_addr = region->guest_phys_addr;
+	mapping->npages = region->memory_size >> PAGE_SHIFT;
+	parcel = &mapping->parcel;
+	parcel->mem_handle = GH_MEM_HANDLE_INVAL; /* to be filled later by mem_share/mem_lend */
+	parcel->mem_type = GH_RM_MEM_TYPE_NORMAL;
+
+	/* Check for overlap */
+	list_for_each_entry(tmp_mapping, &ghvm->memory_mappings, list) {
+		if (!((mapping->guest_phys_addr + (mapping->npages << PAGE_SHIFT) <=
+			tmp_mapping->guest_phys_addr) ||
+			(mapping->guest_phys_addr >=
+			tmp_mapping->guest_phys_addr + (tmp_mapping->npages << PAGE_SHIFT)))) {
+			ret = -EEXIST;
+			goto unlock;
+		}
+	}
+
+	list_add(&mapping->list, &ghvm->memory_mappings);
+unlock:
+	mutex_unlock(&ghvm->mm_lock);
+	if (ret)
+		goto free_mapping;
+
+	mapping->pages = kcalloc(mapping->npages, sizeof(*mapping->pages), GFP_KERNEL);
+	if (!mapping->pages) {
+		ret = -ENOMEM;
+		goto reclaim;
+	}
+
+	pinned = pin_user_pages_fast(region->userspace_addr, mapping->npages,
+					FOLL_WRITE | FOLL_LONGTERM, mapping->pages);
+	if (pinned < 0) {
+		ret = pinned;
+		goto reclaim;
+	} else if (pinned != mapping->npages) {
+		ret = -EFAULT;
+		mapping->npages = pinned; /* update npages for reclaim */
+		goto reclaim;
+	}
+
+	if (region->flags & GH_MEM_LENT) {
+		parcel->n_acl_entries = 1;
+		mapping->share_type = VM_MEM_LEND;
+	} else {
+		parcel->n_acl_entries = 2;
+		mapping->share_type = VM_MEM_SHARE;
+	}
+	parcel->acl_entries = kcalloc(parcel->n_acl_entries,
+						sizeof(*parcel->acl_entries),
+						GFP_KERNEL);
+	if (!parcel->acl_entries) {
+		ret = -ENOMEM;
+		goto reclaim;
+	}
+
+	parcel->acl_entries[0].vmid = ghvm->vmid;
+	if (region->flags & GH_MEM_ALLOW_READ)
+		parcel->acl_entries[0].perms |= GH_RM_ACL_R;
+	if (region->flags & GH_MEM_ALLOW_WRITE)
+		parcel->acl_entries[0].perms |= GH_RM_ACL_W;
+	if (region->flags & GH_MEM_ALLOW_EXEC)
+		parcel->acl_entries[0].perms |= GH_RM_ACL_X;
+
+	if (mapping->share_type == VM_MEM_SHARE) {
+		ret = gh_rm_get_vmid(ghvm->rm, &parcel->acl_entries[1].vmid);
+		if (ret)
+			goto reclaim;
+		/* Host assumed to have all these permissions. Gunyah will not
+		 * grant new permissions if host actually had less than RWX
+		 */
+		parcel->acl_entries[1].perms |= GH_RM_ACL_R | GH_RM_ACL_W | GH_RM_ACL_X;
+	}
+
+	mem_entries = kcalloc(mapping->npages, sizeof(*mem_entries), GFP_KERNEL);
+	if (!mem_entries) {
+		ret = -ENOMEM;
+		goto reclaim;
+	}
+
+	// reduce number of entries by combining contiguous pages into single memory entry
+	prev_page = mem_entries[0].ipa_base = page_to_phys(mapping->pages[0]);
+	mem_entries[0].size = PAGE_SIZE;
+	for (i = 1, j = 0; i < mapping->npages; i++) {
+		curr_page = page_to_phys(mapping->pages[i]);
+		if (page_contiguous(prev_page, curr_page)) {
+			mem_entries[j].size += PAGE_SIZE;
+		} else {
+			j++;
+			mem_entries[j].ipa_base = curr_page;
+			mem_entries[j].size = PAGE_SIZE;
+		}
+
+		prev_page = curr_page;
+	}
+
+	parcel->n_mem_entries = j + 1;
+	parcel->mem_entries = kmemdup(mem_entries, sizeof(*mem_entries) * parcel->n_mem_entries,
+					GFP_KERNEL);
+	kfree(mem_entries);
+	if (!parcel->mem_entries) {
+		ret = -ENOMEM;
+		goto reclaim;
+	}
+
+	switch (mapping->share_type) {
+	case VM_MEM_LEND:
+		ret = gh_rm_mem_lend(ghvm->rm, parcel);
+		break;
+	case VM_MEM_SHARE:
+		ret = gh_rm_mem_share(ghvm->rm, parcel);
+		break;
+	}
+	if (ret > 0)
+		ret = -EINVAL;
+	if (ret)
+		goto reclaim;
+
+	return mapping;
+reclaim:
+	gh_vm_mem_mapping_reclaim(ghvm, mapping);
+free_mapping:
+	kfree(mapping);
+	return ERR_PTR(ret);
+}
diff --git a/include/uapi/linux/gunyah.h b/include/uapi/linux/gunyah.h
index 88a40d6e0b96..574f33b198d0 100644
--- a/include/uapi/linux/gunyah.h
+++ b/include/uapi/linux/gunyah.h
@@ -20,4 +20,26 @@
  */
 #define GH_CREATE_VM			_IO(GH_IOCTL_TYPE, 0x0) /* Returns a Gunyah VM fd */
 
+/*
+ * ioctls for VM fds
+ */
+struct gh_userspace_memory_region {
+	__u32 label;
+#define GH_MEM_ALLOW_READ	(1UL << 0)
+#define GH_MEM_ALLOW_WRITE	(1UL << 1)
+#define GH_MEM_ALLOW_EXEC	(1UL << 2)
+/*
+ * The guest will be lent the memory instead of shared.
+ * In other words, the guest has exclusive access to the memory region and the host loses access.
+ */
+#define GH_MEM_LENT		(1UL << 3)
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
2.25.1


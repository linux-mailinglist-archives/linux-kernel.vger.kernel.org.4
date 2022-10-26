Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB8C60E7DF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 21:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234258AbiJZTAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 15:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234466AbiJZS7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 14:59:39 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A5DF7C;
        Wed, 26 Oct 2022 11:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1666810778; x=1698346778;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kFW6Hisp1bv7OF9wQs5NTqNDUUPxKFXlQIrUqYPWTkA=;
  b=bO+gZ2bV6NlXY5NkW7r8C6L+fDLoR6rTZf+IRF4a0pP87lRbRB+gB83g
   64+P8wJ1SSnQof1QljLEdKII4Cb522ZRUAd2gOv1TUCEisVbSsz1/OnnY
   SJBakbW+SGEXkELPFLQGpZraFiG53Av7CDrjHYHV5+6B7aKHs0B8E5PQH
   I=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 26 Oct 2022 11:59:37 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 11:59:37 -0700
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 26 Oct 2022 11:59:35 -0700
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
Subject: [PATCH v6 15/21] gunyah: vm_mgr: Add/remove user memory regions
Date:   Wed, 26 Oct 2022 11:58:40 -0700
Message-ID: <20221026185846.3983888-16-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221026185846.3983888-1-quic_eberman@quicinc.com>
References: <20221026185846.3983888-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/virt/gunyah/vm_mgr.h    |  26 ++++
 drivers/virt/gunyah/vm_mgr_mm.c | 226 ++++++++++++++++++++++++++++++++
 include/uapi/linux/gunyah.h     |  22 ++++
 5 files changed, 320 insertions(+), 1 deletion(-)
 create mode 100644 drivers/virt/gunyah/vm_mgr_mm.c

diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
index a69b1e2273af..af1817dfeaf4 100644
--- a/drivers/virt/gunyah/Makefile
+++ b/drivers/virt/gunyah/Makefile
@@ -3,5 +3,5 @@ obj-$(CONFIG_GUNYAH) += gunyah.o
 gunyah_rsc_mgr-y += rsc_mgr.o rsc_mgr_rpc.o rsc_mgr_bus.o
 obj-$(CONFIG_GUNYAH_RESORUCE_MANAGER) += gunyah_rsc_mgr.o
 
-gunyah_vm_mgr-y += vm_mgr.o
+gunyah_vm_mgr-y += vm_mgr.o vm_mgr_mm.o
 obj-$(CONFIG_GUNYAH_VM_MANAGER) += gunyah_vm_mgr.o
diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
index c48853dba11d..a993e81a20e2 100644
--- a/drivers/virt/gunyah/vm_mgr.c
+++ b/drivers/virt/gunyah/vm_mgr.c
@@ -30,14 +30,55 @@ static __must_check struct gunyah_vm *gunyah_vm_alloc(void)
 
 	ghvm->vmid = ret;
 
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
@@ -49,7 +90,11 @@ static long gh_vm_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 static int gh_vm_release(struct inode *inode, struct file *filp)
 {
 	struct gunyah_vm *ghvm = filp->private_data;
+	struct gunyah_vm_memory_mapping *mapping, *tmp;
 
+	list_for_each_entry_safe(mapping, tmp, &ghvm->memory_mappings, list) {
+		gh_vm_mem_mapping_reclaim(ghvm, mapping);
+	}
 	kfree(ghvm);
 	return 0;
 }
diff --git a/drivers/virt/gunyah/vm_mgr.h b/drivers/virt/gunyah/vm_mgr.h
index d306ff5eac82..ab1f0cb0758a 100644
--- a/drivers/virt/gunyah/vm_mgr.h
+++ b/drivers/virt/gunyah/vm_mgr.h
@@ -7,11 +7,37 @@
 #define _GH_PRIV_VM_MGR_H
 
 #include <linux/gunyah_rsc_mgr.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
 
 #include <uapi/linux/gunyah.h>
 
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
index 000000000000..a5a57a38ee09
--- /dev/null
+++ b/drivers/virt/gunyah/vm_mgr_mm.c
@@ -0,0 +1,226 @@
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
+		down_read(&ghvm->status_lock);
+		if (mapping->parcel.mem_handle == ghvm->primary_mem_handle &&
+			ghvm->vm_status == GH_RM_VM_STATUS_NO_STATE)
+			ghvm->primary_mem_handle = 0;
+		up_read(&ghvm->status_lock);
+		ret = gh_rm_mem_reclaim(&mapping->parcel);
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
+		mapping = ERR_PTR(-EEXIST);
+		goto unlock;
+	}
+
+	mapping = kzalloc(sizeof(*mapping), GFP_KERNEL);
+	if (!mapping) {
+		mapping = ERR_PTR(-ENOMEM);
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
+		ret = gh_rm_get_vmid(&parcel->acl_entries[1].vmid);
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
+		ret = gh_rm_mem_lend(parcel);
+		break;
+	case VM_MEM_SHARE:
+		ret = gh_rm_mem_share(parcel);
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
index 37ea6bd4c2fd..93f4b99fcaf6 100644
--- a/include/uapi/linux/gunyah.h
+++ b/include/uapi/linux/gunyah.h
@@ -20,4 +20,26 @@
  */
 #define GH_CREATE_VM			_IO(GH_IOCTL_TYPE, 0x40) /* Returns a Gunyah VM fd */
 
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
+#define GH_VM_SET_USER_MEM_REGION	_IOW(GH_IOCTL_TYPE, 0x41, \
+						struct gh_userspace_memory_region)
+
 #endif
-- 
2.25.1


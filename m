Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A24168B809
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 10:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjBFJFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 04:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjBFJFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 04:05:45 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B791E1D90E;
        Mon,  6 Feb 2023 01:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675674343; x=1707210343;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wydMArbBGwds/iL9VybrjpXeXX1Y+bp+qyuDowUUuQ8=;
  b=VaAYHtGquHQjFf+BA3d6UciqHWh9uVr0F3kAYEp53qjijKONq07bWIpX
   j6StISrOkAA4YSkg6gwNVMHHdjTbpsMeOrSg2quoshHLQ2B67wW2cB8ZS
   6QcS9sL16jDrXxIag9sO9N+2z9KAklEvfEtT6/VWtbEfee1xYtxDwxpar
   FJLlKqoCXmgzsRMARq+I4+Pcb+XGOAjw4Z3kzXnRVpF6MXcoSx8KIpL6x
   yLPnCKV6euLnsyBbukT4e5Wf2589ul8J3+ATovOkcKqSiTaFYh5Zw/7CJ
   MIPcVo5td/G274QNuKkrkCqrqyMOvbg29hjVOdH2wYzBMWVL6enJx7Dnt
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="309495776"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="309495776"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 01:05:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="911862775"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="911862775"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga006.fm.intel.com with ESMTP; 06 Feb 2023 01:05:36 -0800
From:   Yi Liu <yi.l.liu@intel.com>
To:     alex.williamson@redhat.com, jgg@nvidia.com, kevin.tian@intel.com
Cc:     cohuck@redhat.com, eric.auger@redhat.com, nicolinc@nvidia.com,
        kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.l.liu@intel.com,
        yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH v2 01/14] vfio: Allocate per device file structure
Date:   Mon,  6 Feb 2023 01:05:19 -0800
Message-Id: <20230206090532.95598-2-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230206090532.95598-1-yi.l.liu@intel.com>
References: <20230206090532.95598-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is preparation for adding vfio device cdev support. vfio device
cdev requires:
1) a per device file memory to store the kvm pointer set by KVM. It will
   be propagated to vfio_device:kvm after the device cdev file is bound
   to an iommufd
2) a mechanism to block device access through device cdev fd before it
   is bound to an iommufd

To address above requirements, this adds a per device file structure
named vfio_device_file. For now, it's only a wrapper of struct vfio_device
pointer. Other fields will be added to this per file structure in future
commits.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 drivers/vfio/group.c     | 13 +++++++++++--
 drivers/vfio/vfio.h      |  6 ++++++
 drivers/vfio/vfio_main.c | 31 ++++++++++++++++++++++++++-----
 3 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
index 0e9036e2b9c4..cf51e1a0fd96 100644
--- a/drivers/vfio/group.c
+++ b/drivers/vfio/group.c
@@ -215,19 +215,26 @@ void vfio_device_group_close(struct vfio_device *device)
 
 static struct file *vfio_device_open_file(struct vfio_device *device)
 {
+	struct vfio_device_file *df;
 	struct file *filep;
 	int ret;
 
+	df = vfio_allocate_device_file(device);
+	if (IS_ERR(df)) {
+		ret = PTR_ERR(df);
+		goto err_out;
+	}
+
 	ret = vfio_device_group_open(device);
 	if (ret)
-		goto err_out;
+		goto err_free;
 
 	/*
 	 * We can't use anon_inode_getfd() because we need to modify
 	 * the f_mode flags directly to allow more than just ioctls
 	 */
 	filep = anon_inode_getfile("[vfio-device]", &vfio_device_fops,
-				   device, O_RDWR);
+				   df, O_RDWR);
 	if (IS_ERR(filep)) {
 		ret = PTR_ERR(filep);
 		goto err_close_device;
@@ -251,6 +258,8 @@ static struct file *vfio_device_open_file(struct vfio_device *device)
 
 err_close_device:
 	vfio_device_group_close(device);
+err_free:
+	kfree(df);
 err_out:
 	return ERR_PTR(ret);
 }
diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
index 4f39ab549a80..c05a6d3b7a73 100644
--- a/drivers/vfio/vfio.h
+++ b/drivers/vfio/vfio.h
@@ -16,11 +16,17 @@ struct iommu_group;
 struct vfio_device;
 struct vfio_container;
 
+struct vfio_device_file {
+	struct vfio_device *device;
+};
+
 void vfio_device_put_registration(struct vfio_device *device);
 bool vfio_device_try_get_registration(struct vfio_device *device);
 int vfio_device_open(struct vfio_device *device, struct iommufd_ctx *iommufd);
 void vfio_device_close(struct vfio_device *device,
 		       struct iommufd_ctx *iommufd);
+struct vfio_device_file *
+vfio_allocate_device_file(struct vfio_device *device);
 
 extern const struct file_operations vfio_device_fops;
 
diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 3a597e799918..d99fa0cec18e 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -396,6 +396,20 @@ static bool vfio_assert_device_open(struct vfio_device *device)
 	return !WARN_ON_ONCE(!READ_ONCE(device->open_count));
 }
 
+struct vfio_device_file *
+vfio_allocate_device_file(struct vfio_device *device)
+{
+	struct vfio_device_file *df;
+
+	df = kzalloc(sizeof(*df), GFP_KERNEL_ACCOUNT);
+	if (!df)
+		return ERR_PTR(-ENOMEM);
+
+	df->device = device;
+
+	return df;
+}
+
 static int vfio_device_first_open(struct vfio_device *device,
 				  struct iommufd_ctx *iommufd)
 {
@@ -509,12 +523,15 @@ static inline void vfio_device_pm_runtime_put(struct vfio_device *device)
  */
 static int vfio_device_fops_release(struct inode *inode, struct file *filep)
 {
-	struct vfio_device *device = filep->private_data;
+	struct vfio_device_file *df = filep->private_data;
+	struct vfio_device *device = df->device;
 
 	vfio_device_group_close(device);
 
 	vfio_device_put_registration(device);
 
+	kfree(df);
+
 	return 0;
 }
 
@@ -1079,7 +1096,8 @@ static int vfio_ioctl_device_feature(struct vfio_device *device,
 static long vfio_device_fops_unl_ioctl(struct file *filep,
 				       unsigned int cmd, unsigned long arg)
 {
-	struct vfio_device *device = filep->private_data;
+	struct vfio_device_file *df = filep->private_data;
+	struct vfio_device *device = df->device;
 	int ret;
 
 	ret = vfio_device_pm_runtime_get(device);
@@ -1106,7 +1124,8 @@ static long vfio_device_fops_unl_ioctl(struct file *filep,
 static ssize_t vfio_device_fops_read(struct file *filep, char __user *buf,
 				     size_t count, loff_t *ppos)
 {
-	struct vfio_device *device = filep->private_data;
+	struct vfio_device_file *df = filep->private_data;
+	struct vfio_device *device = df->device;
 
 	if (unlikely(!device->ops->read))
 		return -EINVAL;
@@ -1118,7 +1137,8 @@ static ssize_t vfio_device_fops_write(struct file *filep,
 				      const char __user *buf,
 				      size_t count, loff_t *ppos)
 {
-	struct vfio_device *device = filep->private_data;
+	struct vfio_device_file *df = filep->private_data;
+	struct vfio_device *device = df->device;
 
 	if (unlikely(!device->ops->write))
 		return -EINVAL;
@@ -1128,7 +1148,8 @@ static ssize_t vfio_device_fops_write(struct file *filep,
 
 static int vfio_device_fops_mmap(struct file *filep, struct vm_area_struct *vma)
 {
-	struct vfio_device *device = filep->private_data;
+	struct vfio_device_file *df = filep->private_data;
+	struct vfio_device *device = df->device;
 
 	if (unlikely(!device->ops->mmap))
 		return -EINVAL;
-- 
2.34.1


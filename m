Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F3B5BF471
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 05:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbiIUD0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 23:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbiIUD0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 23:26:36 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F857EFC2;
        Tue, 20 Sep 2022 20:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663730792; x=1695266792;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ee7Ty4y0/Pa9CKvua9Cedw/KYX8TbN8bfoA3COqZ8o0=;
  b=mwCBWBhF1kudjuBr83hTdpBd+O0+BV3McB+l7zsn3sfMzuRfjktDM6j+
   xknumeXTSsuU0QepU88n1jRy+FRMQbDQEdky7IjDfiY0PXjITH9BMF3YD
   EsVSw4Z0l6EUEglV+Qn7PRadJjaDls77AlswcUZKmUlLr1SJKkWIwvih7
   MiO6NQdj6xFttVfJYUw1M2VoxWMCC1VjTPrfRKqj9pWNFC2ZDJ1dUpsoV
   R1jv+jm6JrgMHF1ySwfTJpXDqS1yF+q37fwnoDUXrwqZqEE4v8vaJPUGA
   s5CjjDykfkL3zPefQ5Hi8sLEC7QROPDRAuoeT8e60vQk/Dl8QofQtDxdo
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="279612445"
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="279612445"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 20:26:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="761574114"
Received: from sqa-gate.sh.intel.com (HELO michael.clx.dev.tsp.org) ([10.239.48.212])
  by fmsmga001.fm.intel.com with ESMTP; 20 Sep 2022 20:26:23 -0700
From:   Kevin Tian <kevin.tian@intel.com>
To:     Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Longfang Liu <liulongfang@huawei.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Yishai Hadas <yishaih@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Abhishek Sahu <abhsahu@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v4 01/15] vfio: Add helpers for unifying vfio_device life cycle
Date:   Wed, 21 Sep 2022 18:43:47 +0800
Message-Id: <20220921104401.38898-2-kevin.tian@intel.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20220921104401.38898-1-kevin.tian@intel.com>
References: <20220921104401.38898-1-kevin.tian@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The idea is to let vfio core manage the vfio_device life cycle instead
of duplicating the logic cross drivers. This is also a preparatory
step for adding struct device into vfio_device.

New pair of helpers together with a kref in vfio_device:

 - vfio_alloc_device()
 - vfio_put_device()

Drivers can register @init/@release callbacks to manage any private
state wrapping the vfio_device.

However vfio-ccw doesn't fit this model due to a life cycle mess
that its private structure mixes both parent and mdev info hence must
be allocated/freed outside of the life cycle of vfio device.

Per prior discussions this won't be fixed in short term by IBM folks.

Instead of waiting for those modifications introduce another helper
vfio_init_device() so ccw can call it to initialize a pre-allocated
vfio_device.

Further implication of the ccw trick is that vfio_device cannot be
freed uniformly in vfio core. Instead, require *EVERY* driver to
implement @release and free vfio_device inside. Then ccw can choose
to delay the free at its own discretion.

Another trick down the road is that kvzalloc() is used to accommodate
the need of gvt which uses vzalloc() while all others use kzalloc().
So drivers should call a helper vfio_free_device() to free the
vfio_device instead of assuming that kfree() or vfree() is appliable.

Later once the ccw mess is fixed we can remove those tricks and
fully handle structure alloc/free in vfio core.

Existing vfio_{un}init_group_dev() will be deprecated after all
existing usages are converted to the new model.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Co-developed-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Tony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 drivers/vfio/vfio_main.c | 92 ++++++++++++++++++++++++++++++++++++++++
 include/linux/vfio.h     | 25 ++++++++++-
 2 files changed, 116 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 27d9186f35d5..b9c6a97d647a 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -498,6 +498,98 @@ void vfio_uninit_group_dev(struct vfio_device *device)
 }
 EXPORT_SYMBOL_GPL(vfio_uninit_group_dev);
 
+/* Release helper called by vfio_put_device() */
+void vfio_device_release(struct kref *kref)
+{
+	struct vfio_device *device =
+			container_of(kref, struct vfio_device, kref);
+
+	vfio_uninit_group_dev(device);
+
+	/*
+	 * kvfree() cannot be done here due to a life cycle mess in
+	 * vfio-ccw. Before the ccw part is fixed all drivers are
+	 * required to support @release and call vfio_free_device()
+	 * from there.
+	 */
+	device->ops->release(device);
+}
+EXPORT_SYMBOL_GPL(vfio_device_release);
+
+/*
+ * Allocate and initialize vfio_device so it can be registered to vfio
+ * core.
+ *
+ * Drivers should use the wrapper vfio_alloc_device() for allocation.
+ * @size is the size of the structure to be allocated, including any
+ * private data used by the driver.
+ *
+ * Driver may provide an @init callback to cover device private data.
+ *
+ * Use vfio_put_device() to release the structure after success return.
+ */
+struct vfio_device *_vfio_alloc_device(size_t size, struct device *dev,
+				       const struct vfio_device_ops *ops)
+{
+	struct vfio_device *device;
+	int ret;
+
+	if (WARN_ON(size < sizeof(struct vfio_device)))
+		return ERR_PTR(-EINVAL);
+
+	device = kvzalloc(size, GFP_KERNEL);
+	if (!device)
+		return ERR_PTR(-ENOMEM);
+
+	ret = vfio_init_device(device, dev, ops);
+	if (ret)
+		goto out_free;
+	return device;
+
+out_free:
+	kvfree(device);
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(_vfio_alloc_device);
+
+/*
+ * Initialize a vfio_device so it can be registered to vfio core.
+ *
+ * Only vfio-ccw driver should call this interface.
+ */
+int vfio_init_device(struct vfio_device *device, struct device *dev,
+		     const struct vfio_device_ops *ops)
+{
+	int ret;
+
+	vfio_init_group_dev(device, dev, ops);
+
+	if (ops->init) {
+		ret = ops->init(device);
+		if (ret)
+			goto out_uninit;
+	}
+
+	kref_init(&device->kref);
+	return 0;
+
+out_uninit:
+	vfio_uninit_group_dev(device);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(vfio_init_device);
+
+/*
+ * The helper called by driver @release callback to free the device
+ * structure. Drivers which don't have private data to clean can
+ * simply use this helper as its @release.
+ */
+void vfio_free_device(struct vfio_device *device)
+{
+	kvfree(device);
+}
+EXPORT_SYMBOL_GPL(vfio_free_device);
+
 static struct vfio_group *vfio_noiommu_group_alloc(struct device *dev,
 		enum vfio_group_type type)
 {
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 0e2826559091..f67cac700e6f 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -47,7 +47,8 @@ struct vfio_device {
 	struct kvm *kvm;
 
 	/* Members below here are private, not for driver use */
-	refcount_t refcount;
+	struct kref kref;	/* object life cycle */
+	refcount_t refcount;	/* user count on registered device*/
 	unsigned int open_count;
 	struct completion comp;
 	struct list_head group_next;
@@ -57,6 +58,8 @@ struct vfio_device {
 /**
  * struct vfio_device_ops - VFIO bus driver device callbacks
  *
+ * @init: initialize private fields in device structure
+ * @release: Reclaim private fields in device structure
  * @open_device: Called when the first file descriptor is opened for this device
  * @close_device: Opposite of open_device
  * @read: Perform read(2) on device file descriptor
@@ -74,6 +77,8 @@ struct vfio_device {
  */
 struct vfio_device_ops {
 	char	*name;
+	int	(*init)(struct vfio_device *vdev);
+	void	(*release)(struct vfio_device *vdev);
 	int	(*open_device)(struct vfio_device *vdev);
 	void	(*close_device)(struct vfio_device *vdev);
 	ssize_t	(*read)(struct vfio_device *vdev, char __user *buf,
@@ -161,6 +166,24 @@ static inline int vfio_check_feature(u32 flags, size_t argsz, u32 supported_ops,
 	return 1;
 }
 
+struct vfio_device *_vfio_alloc_device(size_t size, struct device *dev,
+				       const struct vfio_device_ops *ops);
+#define vfio_alloc_device(dev_struct, member, dev, ops)				\
+	container_of(_vfio_alloc_device(sizeof(struct dev_struct) +		\
+					BUILD_BUG_ON_ZERO(offsetof(		\
+						struct dev_struct, member)),	\
+					dev, ops),				\
+		     struct dev_struct, member)
+
+int vfio_init_device(struct vfio_device *device, struct device *dev,
+		     const struct vfio_device_ops *ops);
+void vfio_free_device(struct vfio_device *device);
+void vfio_device_release(struct kref *kref);
+static inline void vfio_put_device(struct vfio_device *device)
+{
+	kref_put(&device->kref, vfio_device_release);
+}
+
 void vfio_init_group_dev(struct vfio_device *device, struct device *dev,
 			 const struct vfio_device_ops *ops);
 void vfio_uninit_group_dev(struct vfio_device *device);
-- 
2.21.3


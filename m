Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DAD5BFF38
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 15:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbiIUNvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 09:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiIUNvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 09:51:06 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B5280F70;
        Wed, 21 Sep 2022 06:51:04 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28LAd57Z018752;
        Wed, 21 Sep 2022 15:50:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=CnbWov3M4l8IJodrXNEy5I4PEC7rjWo9LWoZ+tlCEh8=;
 b=XABHNMMA/FFlWRnCxZ+4+zvSciTZjT5vWS9EPY2YMZ+VeEPMWHmgN4FgHyBFaPR0gA32
 b4t4EpD7z+uDYYI+z/mtVIqubKswWHw6J/N4AfyZ6t9fAxroJVVe4yelwnnsoKccUzgO
 zwWwMkGOo5Vd7qbErqw6OqX+IwIQcBp3zmee/BDCm/q181qT9mkUqf7vxc5vfFUsFCiO
 Kp+Oo2z94IlKhhIlFFqhChGhRYrcdGkPEtjbH2AJoc6eTBFrJUmC+Gjbp5suKz2tdjuW
 4XSrsZmZDmg7zJtmtJrR/3mnIEHE2m0Z2wfBpPSMCtmHPxM/tKuaEnKzSsUlrv34Cxu7 hw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3jr11x11ua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Sep 2022 15:50:51 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1EA6910002A;
        Wed, 21 Sep 2022 15:50:50 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 176CA2278AF;
        Wed, 21 Sep 2022 15:50:50 +0200 (CEST)
Received: from localhost (10.75.127.47) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.31; Wed, 21 Sep
 2022 15:50:49 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Rob Herring <robh@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Stefano Stabellini <stefanos@xilinx.com>,
        Bruce Ashfield <bruce.ashfield@xilinx.com>,
        <arnaud.pouliquen@foss.st.com>
Subject: [PATCH v9 3/4] remoteproc: Move rproc_vdev management to remoteproc_virtio.c
Date:   Wed, 21 Sep 2022 15:50:43 +0200
Message-ID: <20220921135044.917140-4-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.24.3
In-Reply-To: <20220921135044.917140-1-arnaud.pouliquen@foss.st.com>
References: <20220921135044.917140-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-21_07,2022-09-20_02,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move functions related to the management of the rproc_vdev
structure in the remoteproc_virtio.c.
The aim is to decorrelate as possible the virtio management from
the core part.

Due to the strong correlation between the vrings and the resource table
the rproc_alloc/parse/free_vring functions are kept in the remoteproc core.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/remoteproc/remoteproc_core.c     | 157 +----------------------
 drivers/remoteproc/remoteproc_internal.h |  10 +-
 drivers/remoteproc/remoteproc_virtio.c   | 154 +++++++++++++++++++++-
 3 files changed, 161 insertions(+), 160 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index ddf2c716d7d8..2e88f933a4eb 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -23,9 +23,7 @@
 #include <linux/panic_notifier.h>
 #include <linux/slab.h>
 #include <linux/mutex.h>
-#include <linux/dma-map-ops.h>
 #include <linux/dma-mapping.h>
-#include <linux/dma-direct.h> /* XXX: pokes into bus_dma_range */
 #include <linux/firmware.h>
 #include <linux/string.h>
 #include <linux/debugfs.h>
@@ -384,7 +382,7 @@ int rproc_alloc_vring(struct rproc_vdev *rvdev, int i)
 	return 0;
 }
 
-static int
+int
 rproc_parse_vring(struct rproc_vdev *rvdev, struct fw_rsc_vdev *rsc, int i)
 {
 	struct rproc *rproc = rvdev->rproc;
@@ -435,166 +433,17 @@ void rproc_free_vring(struct rproc_vring *rvring)
 	}
 }
 
-static int rproc_vdev_do_start(struct rproc_subdev *subdev)
-{
-	struct rproc_vdev *rvdev = container_of(subdev, struct rproc_vdev, subdev);
-
-	return rproc_add_virtio_dev(rvdev, rvdev->id);
-}
-
-static void rproc_vdev_do_stop(struct rproc_subdev *subdev, bool crashed)
-{
-	struct rproc_vdev *rvdev = container_of(subdev, struct rproc_vdev, subdev);
-	int ret;
-
-	ret = device_for_each_child(&rvdev->dev, NULL, rproc_remove_virtio_dev);
-	if (ret)
-		dev_warn(&rvdev->dev, "can't remove vdev child device: %d\n", ret);
-}
-
-/**
- * rproc_rvdev_release() - release the existence of a rvdev
- *
- * @dev: the subdevice's dev
- */
-static void rproc_rvdev_release(struct device *dev)
-{
-	struct rproc_vdev *rvdev = container_of(dev, struct rproc_vdev, dev);
-
-	of_reserved_mem_device_release(dev);
-	dma_release_coherent_memory(dev);
-
-	kfree(rvdev);
-}
-
-static int copy_dma_range_map(struct device *to, struct device *from)
-{
-	const struct bus_dma_region *map = from->dma_range_map, *new_map, *r;
-	int num_ranges = 0;
-
-	if (!map)
-		return 0;
-
-	for (r = map; r->size; r++)
-		num_ranges++;
-
-	new_map = kmemdup(map, array_size(num_ranges + 1, sizeof(*map)),
-			  GFP_KERNEL);
-	if (!new_map)
-		return -ENOMEM;
-	to->dma_range_map = new_map;
-	return 0;
-}
-
-static void rproc_add_rvdev(struct rproc *rproc, struct rproc_vdev *rvdev)
+void rproc_add_rvdev(struct rproc *rproc, struct rproc_vdev *rvdev)
 {
 	if (rvdev && rproc)
 		list_add_tail(&rvdev->node, &rproc->rvdevs);
 }
 
-static void rproc_remove_rvdev(struct rproc_vdev *rvdev)
+void rproc_remove_rvdev(struct rproc_vdev *rvdev)
 {
 	if (rvdev)
 		list_del(&rvdev->node);
 }
-
-static struct rproc_vdev *
-rproc_rvdev_add_device(struct rproc *rproc, struct rproc_vdev_data *rvdev_data)
-{
-	struct rproc_vdev *rvdev;
-	struct fw_rsc_vdev *rsc = rvdev_data->rsc;
-	char name[16];
-	int i, ret;
-
-	rvdev = kzalloc(sizeof(*rvdev), GFP_KERNEL);
-	if (!rvdev)
-		return ERR_PTR(-ENOMEM);
-
-	kref_init(&rvdev->refcount);
-
-	rvdev->id = rvdev_data->id;
-	rvdev->rproc = rproc;
-	rvdev->index = rvdev_data->index;
-
-	/* Initialise vdev subdevice */
-	snprintf(name, sizeof(name), "vdev%dbuffer", rvdev->index);
-	rvdev->dev.parent = &rproc->dev;
-	rvdev->dev.release = rproc_rvdev_release;
-	dev_set_name(&rvdev->dev, "%s#%s", dev_name(rvdev->dev.parent), name);
-	dev_set_drvdata(&rvdev->dev, rvdev);
-
-	ret = device_register(&rvdev->dev);
-	if (ret) {
-		put_device(&rvdev->dev);
-		return ERR_PTR(ret);
-	}
-
-	ret = copy_dma_range_map(&rvdev->dev, rproc->dev.parent);
-	if (ret)
-		goto free_rvdev;
-
-	/* Make device dma capable by inheriting from parent's capabilities */
-	set_dma_ops(&rvdev->dev, get_dma_ops(rproc->dev.parent));
-
-	ret = dma_coerce_mask_and_coherent(&rvdev->dev,
-					   dma_get_mask(rproc->dev.parent));
-	if (ret) {
-		dev_warn(&rvdev->dev,
-			 "Failed to set DMA mask %llx. Trying to continue... (%pe)\n",
-			 dma_get_mask(rproc->dev.parent), ERR_PTR(ret));
-	}
-
-	/* parse the vrings */
-	for (i = 0; i < rsc->num_of_vrings; i++) {
-		ret = rproc_parse_vring(rvdev, rsc, i);
-		if (ret)
-			goto free_rvdev;
-	}
-
-	/* remember the resource offset*/
-	rvdev->rsc_offset = rvdev_data->rsc_offset;
-
-	/* allocate the vring resources */
-	for (i = 0; i < rsc->num_of_vrings; i++) {
-		ret = rproc_alloc_vring(rvdev, i);
-		if (ret)
-			goto unwind_vring_allocations;
-	}
-
-	rproc_add_rvdev(rproc, rvdev);
-
-	rvdev->subdev.start = rproc_vdev_do_start;
-	rvdev->subdev.stop = rproc_vdev_do_stop;
-
-	rproc_add_subdev(rproc, &rvdev->subdev);
-
-	return rvdev;
-
-unwind_vring_allocations:
-	for (i--; i >= 0; i--)
-		rproc_free_vring(&rvdev->vring[i]);
-free_rvdev:
-	device_unregister(&rvdev->dev);
-	return ERR_PTR(ret);
-}
-
-void rproc_vdev_release(struct kref *ref)
-{
-	struct rproc_vdev *rvdev = container_of(ref, struct rproc_vdev, refcount);
-	struct rproc_vring *rvring;
-	struct rproc *rproc = rvdev->rproc;
-	int id;
-
-	for (id = 0; id < ARRAY_SIZE(rvdev->vring); id++) {
-		rvring = &rvdev->vring[id];
-		rproc_free_vring(rvring);
-	}
-
-	rproc_remove_subdev(rproc, &rvdev->subdev);
-	rproc_remove_rvdev(rvdev);
-	device_unregister(&rvdev->dev);
-}
-
 /**
  * rproc_handle_vdev() - handle a vdev fw resource
  * @rproc: the remote processor
diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
index 07c503de0f95..711b0e1f2118 100644
--- a/drivers/remoteproc/remoteproc_internal.h
+++ b/drivers/remoteproc/remoteproc_internal.h
@@ -41,14 +41,13 @@ struct rproc_vdev_data {
 
 /* from remoteproc_core.c */
 void rproc_release(struct kref *kref);
-irqreturn_t rproc_vq_interrupt(struct rproc *rproc, int vq_id);
-void rproc_vdev_release(struct kref *ref);
 int rproc_of_parse_firmware(struct device *dev, int index,
 			    const char **fw_name);
 
 /* from remoteproc_virtio.c */
-int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id);
-int rproc_remove_virtio_dev(struct device *dev, void *data);
+struct rproc_vdev *rproc_rvdev_add_device(struct rproc *rproc, struct rproc_vdev_data *rvdev_data);
+irqreturn_t rproc_vq_interrupt(struct rproc *rproc, int vq_id);
+void rproc_vdev_release(struct kref *ref);
 
 /* from remoteproc_debugfs.c */
 void rproc_remove_trace_file(struct dentry *tfile);
@@ -98,6 +97,7 @@ static inline void  rproc_char_device_remove(struct rproc *rproc)
 
 void rproc_free_vring(struct rproc_vring *rvring);
 int rproc_alloc_vring(struct rproc_vdev *rvdev, int i);
+int rproc_parse_vring(struct rproc_vdev *rvdev, struct fw_rsc_vdev *rsc, int i);
 
 phys_addr_t rproc_va_to_pa(void *cpu_addr);
 int rproc_trigger_recovery(struct rproc *rproc);
@@ -110,6 +110,8 @@ struct resource_table *rproc_elf_find_loaded_rsc_table(struct rproc *rproc,
 						       const struct firmware *fw);
 struct rproc_mem_entry *
 rproc_find_carveout_by_name(struct rproc *rproc, const char *name, ...);
+void rproc_add_rvdev(struct rproc *rproc, struct rproc_vdev *rvdev);
+void rproc_remove_rvdev(struct rproc_vdev *rvdev);
 
 static inline int rproc_prepare_device(struct rproc *rproc)
 {
diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
index 0f7706e23eb9..0aaa70d91aa8 100644
--- a/drivers/remoteproc/remoteproc_virtio.c
+++ b/drivers/remoteproc/remoteproc_virtio.c
@@ -9,7 +9,9 @@
  * Brian Swetland <swetland@google.com>
  */
 
+#include <linux/dma-direct.h>
 #include <linux/dma-map-ops.h>
+#include <linux/dma-mapping.h>
 #include <linux/export.h>
 #include <linux/of_reserved_mem.h>
 #include <linux/remoteproc.h>
@@ -23,6 +25,25 @@
 
 #include "remoteproc_internal.h"
 
+static int copy_dma_range_map(struct device *to, struct device *from)
+{
+	const struct bus_dma_region *map = from->dma_range_map, *new_map, *r;
+	int num_ranges = 0;
+
+	if (!map)
+		return 0;
+
+	for (r = map; r->size; r++)
+		num_ranges++;
+
+	new_map = kmemdup(map, array_size(num_ranges + 1, sizeof(*map)),
+			  GFP_KERNEL);
+	if (!new_map)
+		return -ENOMEM;
+	to->dma_range_map = new_map;
+	return 0;
+}
+
 static struct rproc_vdev *vdev_to_rvdev(struct virtio_device *vdev)
 {
 	return container_of(vdev->dev.parent, struct rproc_vdev, dev);
@@ -341,7 +362,7 @@ static void rproc_virtio_dev_release(struct device *dev)
  *
  * Return: 0 on success or an appropriate error value otherwise
  */
-int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id)
+static int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id)
 {
 	struct rproc *rproc = rvdev->rproc;
 	struct device *dev = &rvdev->dev;
@@ -449,10 +470,139 @@ int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id)
  *
  * Return: 0
  */
-int rproc_remove_virtio_dev(struct device *dev, void *data)
+static int rproc_remove_virtio_dev(struct device *dev, void *data)
 {
 	struct virtio_device *vdev = dev_to_virtio(dev);
 
 	unregister_virtio_device(vdev);
 	return 0;
 }
+
+static int rproc_vdev_do_start(struct rproc_subdev *subdev)
+{
+	struct rproc_vdev *rvdev = container_of(subdev, struct rproc_vdev, subdev);
+
+	return rproc_add_virtio_dev(rvdev, rvdev->id);
+}
+
+static void rproc_vdev_do_stop(struct rproc_subdev *subdev, bool crashed)
+{
+	struct rproc_vdev *rvdev = container_of(subdev, struct rproc_vdev, subdev);
+	int ret;
+
+	ret = device_for_each_child(&rvdev->dev, NULL, rproc_remove_virtio_dev);
+	if (ret)
+		dev_warn(&rvdev->dev, "can't remove vdev child device: %d\n", ret);
+}
+
+/**
+ * rproc_rvdev_release() - release the existence of a rvdev
+ *
+ * @dev: the subdevice's dev
+ */
+static void rproc_rvdev_release(struct device *dev)
+{
+	struct rproc_vdev *rvdev = container_of(dev, struct rproc_vdev, dev);
+
+	of_reserved_mem_device_release(dev);
+	dma_release_coherent_memory(dev);
+
+	kfree(rvdev);
+}
+
+struct rproc_vdev *
+rproc_rvdev_add_device(struct rproc *rproc, struct rproc_vdev_data *rvdev_data)
+{
+	struct rproc_vdev *rvdev;
+	struct fw_rsc_vdev *rsc = rvdev_data->rsc;
+	char name[16];
+	int i, ret;
+
+	rvdev = kzalloc(sizeof(*rvdev), GFP_KERNEL);
+	if (!rvdev)
+		return ERR_PTR(-ENOMEM);
+
+	kref_init(&rvdev->refcount);
+
+	rvdev->id = rvdev_data->id;
+	rvdev->rproc = rproc;
+	rvdev->index = rvdev_data->index;
+
+	/* Initialise vdev subdevice */
+	snprintf(name, sizeof(name), "vdev%dbuffer", rvdev->index);
+	rvdev->dev.parent = &rproc->dev;
+	rvdev->dev.release = rproc_rvdev_release;
+	dev_set_name(&rvdev->dev, "%s#%s", dev_name(rvdev->dev.parent), name);
+	dev_set_drvdata(&rvdev->dev, rvdev);
+
+	ret = device_register(&rvdev->dev);
+	if (ret) {
+		put_device(&rvdev->dev);
+		return ERR_PTR(ret);
+	}
+
+	ret = copy_dma_range_map(&rvdev->dev, rproc->dev.parent);
+	if (ret)
+		goto free_rvdev;
+
+	/* Make device dma capable by inheriting from parent's capabilities */
+	set_dma_ops(&rvdev->dev, get_dma_ops(rproc->dev.parent));
+
+	ret = dma_coerce_mask_and_coherent(&rvdev->dev,
+					   dma_get_mask(rproc->dev.parent));
+	if (ret) {
+		dev_warn(&rvdev->dev,
+			 "Failed to set DMA mask %llx. Trying to continue... (%pe)\n",
+			 dma_get_mask(rproc->dev.parent), ERR_PTR(ret));
+	}
+
+	/* parse the vrings */
+	for (i = 0; i < rsc->num_of_vrings; i++) {
+		ret = rproc_parse_vring(rvdev, rsc, i);
+		if (ret)
+			goto free_rvdev;
+	}
+
+	/* remember the resource offset*/
+	rvdev->rsc_offset = rvdev_data->rsc_offset;
+
+	/* allocate the vring resources */
+	for (i = 0; i < rsc->num_of_vrings; i++) {
+		ret = rproc_alloc_vring(rvdev, i);
+		if (ret)
+			goto unwind_vring_allocations;
+	}
+
+	rproc_add_rvdev(rproc, rvdev);
+
+	rvdev->subdev.start = rproc_vdev_do_start;
+	rvdev->subdev.stop = rproc_vdev_do_stop;
+
+	rproc_add_subdev(rproc, &rvdev->subdev);
+
+	return rvdev;
+
+unwind_vring_allocations:
+	for (i--; i >= 0; i--)
+		rproc_free_vring(&rvdev->vring[i]);
+free_rvdev:
+	device_unregister(&rvdev->dev);
+	return ERR_PTR(ret);
+}
+
+void rproc_vdev_release(struct kref *ref)
+{
+	struct rproc_vdev *rvdev = container_of(ref, struct rproc_vdev, refcount);
+	struct rproc_vring *rvring;
+	struct rproc *rproc = rvdev->rproc;
+	int id;
+
+	for (id = 0; id < ARRAY_SIZE(rvdev->vring); id++) {
+		rvring = &rvdev->vring[id];
+		rproc_free_vring(rvring);
+	}
+
+	rproc_remove_subdev(rproc, &rvdev->subdev);
+	rproc_remove_rvdev(rvdev);
+	device_unregister(&rvdev->dev);
+}
-- 
2.24.3


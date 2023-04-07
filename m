Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7DC6DADAC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 15:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbjDGNiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 09:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjDGNh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 09:37:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEF344B9
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 06:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680874634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0CvjsPSQL1L1z0z64C2CH04/VWrsTelzBiLbwWcaVEg=;
        b=T4bfvVrV+8oUqCDjWRQgQ/pmXYzYICfG2OuG2KBkBN9rl8SFPgjBm7x84lVfUZ9ds4vWUP
        54BBHnojN+gkcYALdXoDRVTlfMBZhabZA9eVTciNPQXS2NlnUQcHOV19tN5fHEQjEbgRlB
        jPi56elL3qj3zAujSDtzpjdQDMVyACM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-d6_QGmcsPQS7YywqLDGj6A-1; Fri, 07 Apr 2023 09:37:13 -0400
X-MC-Unique: d6_QGmcsPQS7YywqLDGj6A-1
Received: by mail-qk1-f199.google.com with SMTP id s190-20020ae9dec7000000b00746b7fae197so7764535qkf.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 06:37:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680874633; x=1683466633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0CvjsPSQL1L1z0z64C2CH04/VWrsTelzBiLbwWcaVEg=;
        b=6bxwNuJo0WKSuHyTFoAtsC7BSqK3Xt90AHKfLm9nWHaGZuIdfTO4TuXwM6mMyR1t7H
         aSm0T8jrGEGnxhu1GSRpY5dOERsY9H6vQV03IyucllcnQwOARAMhgCvhkBSAo+V8gqKn
         +bBSMMjynCAVQ7SjzShcp0VfaDW8S35XDoBXACtF/iQOCCvL86dPVJAU7/cTPdUtMgOn
         VPAXqiYEF6Bc6DOFNj1KC2N2TZE7mUOyUshYjMxYkOiheUgV36K3cNGg+UKb1H9wZHNK
         /YP99YTeu19CIOIr0sz3LM+cKRW1yuUw8rLea2RdjIcsyAo3FnsqFOW0WuRa2De42LUN
         f2oA==
X-Gm-Message-State: AAQBX9eMuTxQ4+14zGAuQyxeV6K1R47db3iWQiIadx+Ia3Q53EdfUR/y
        MH6pJ7PV2i5DMY5LeMgZ935ID7dTm8PUr5leIkIWgf3g9GUkkjlkmo2eZP/K7Ka/e6OGeqCYWZ8
        lsijJK7/pCzE4NCvVh6MXG3VD
X-Received: by 2002:ac8:5981:0:b0:3e3:7ce1:e746 with SMTP id e1-20020ac85981000000b003e37ce1e746mr4388227qte.15.1680874632876;
        Fri, 07 Apr 2023 06:37:12 -0700 (PDT)
X-Google-Smtp-Source: AKy350Z17fbTn/0ZgVYtRLhjxq5vHbWbH/sjK8zpzOJzIzXryFW2EI4gtQ4Epm8iHl4T+0kX2ItJrA==
X-Received: by 2002:ac8:5981:0:b0:3e3:7ce1:e746 with SMTP id e1-20020ac85981000000b003e37ce1e746mr4388190qte.15.1680874632601;
        Fri, 07 Apr 2023 06:37:12 -0700 (PDT)
Received: from step1.redhat.com ([5.77.69.107])
        by smtp.gmail.com with ESMTPSA id j25-20020ac874d9000000b003e394714c07sm1197688qtr.10.2023.04.07.06.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 06:37:11 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Alvaro Karsz <alvaro.karsz@solid-run.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Eugenio=20P=C3=A9rez=20Martin?= <eperezma@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 1/2] vdpa_sim: move buffer allocation in the devices
Date:   Fri,  7 Apr 2023 15:36:57 +0200
Message-Id: <20230407133658.66339-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230407133658.66339-1-sgarzare@redhat.com>
References: <20230407133658.66339-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the vdpa_sim core does not use the buffer, but only
allocates it.

The buffer is used by devices differently, and some future devices
may not use it. So let's move all its management inside the devices.

Add a new `free` device callback called to clean up the resources
allocated by the device.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.h     |  3 +--
 drivers/vdpa/vdpa_sim/vdpa_sim.c     |  7 ++---
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 40 +++++++++++++++++++++++-----
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 28 ++++++++++++++-----
 4 files changed, 57 insertions(+), 21 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
index 3a42887d05d9..bb137e479763 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
@@ -39,7 +39,6 @@ struct vdpasim_dev_attr {
 	u64 supported_features;
 	size_t alloc_size;
 	size_t config_size;
-	size_t buffer_size;
 	int nvqs;
 	u32 id;
 	u32 ngroups;
@@ -51,6 +50,7 @@ struct vdpasim_dev_attr {
 	int (*get_stats)(struct vdpasim *vdpasim, u16 idx,
 			 struct sk_buff *msg,
 			 struct netlink_ext_ack *extack);
+	void (*free)(struct vdpasim *vdpasim);
 };
 
 /* State of each vdpasim device */
@@ -67,7 +67,6 @@ struct vdpasim {
 	void *config;
 	struct vhost_iotlb *iommu;
 	bool *iommu_pt;
-	void *buffer;
 	u32 status;
 	u32 generation;
 	u64 features;
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 2c706bb18897..d343af4fa60e 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -261,10 +261,6 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
 	for (i = 0; i < vdpasim->dev_attr.nas; i++)
 		vhost_iotlb_init(&vdpasim->iommu[i], max_iotlb_entries, 0);
 
-	vdpasim->buffer = kvmalloc(dev_attr->buffer_size, GFP_KERNEL);
-	if (!vdpasim->buffer)
-		goto err_iommu;
-
 	for (i = 0; i < dev_attr->nvqs; i++)
 		vringh_set_iotlb(&vdpasim->vqs[i].vring, &vdpasim->iommu[0],
 				 &vdpasim->iommu_lock);
@@ -714,7 +710,8 @@ static void vdpasim_free(struct vdpa_device *vdpa)
 		vringh_kiov_cleanup(&vdpasim->vqs[i].in_iov);
 	}
 
-	kvfree(vdpasim->buffer);
+	vdpasim->dev_attr.free(vdpasim);
+
 	for (i = 0; i < vdpasim->dev_attr.nas; i++)
 		vhost_iotlb_reset(&vdpasim->iommu[i]);
 	kfree(vdpasim->iommu);
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
index 568119e1553f..c996e750dc02 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
@@ -43,6 +43,16 @@
 #define VDPASIM_BLK_AS_NUM	1
 #define VDPASIM_BLK_GROUP_NUM	1
 
+struct vdpasim_blk {
+	struct vdpasim vdpasim;
+	void *buffer;
+};
+
+static struct vdpasim_blk *sim_to_blk(struct vdpasim *vdpasim)
+{
+	return container_of(vdpasim, struct vdpasim_blk, vdpasim);
+}
+
 static char vdpasim_blk_id[VIRTIO_BLK_ID_BYTES] = "vdpa_blk_sim";
 
 static bool vdpasim_blk_check_range(struct vdpasim *vdpasim, u64 start_sector,
@@ -78,6 +88,7 @@ static bool vdpasim_blk_check_range(struct vdpasim *vdpasim, u64 start_sector,
 static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 				   struct vdpasim_virtqueue *vq)
 {
+	struct vdpasim_blk *blk = sim_to_blk(vdpasim);
 	size_t pushed = 0, to_pull, to_push;
 	struct virtio_blk_outhdr hdr;
 	bool handled = false;
@@ -144,8 +155,7 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 		}
 
 		bytes = vringh_iov_push_iotlb(&vq->vring, &vq->in_iov,
-					      vdpasim->buffer + offset,
-					      to_push);
+					      blk->buffer + offset, to_push);
 		if (bytes < 0) {
 			dev_dbg(&vdpasim->vdpa.dev,
 				"vringh_iov_push_iotlb() error: %zd offset: 0x%llx len: 0x%zx\n",
@@ -166,8 +176,7 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 		}
 
 		bytes = vringh_iov_pull_iotlb(&vq->vring, &vq->out_iov,
-					      vdpasim->buffer + offset,
-					      to_pull);
+					      blk->buffer + offset, to_pull);
 		if (bytes < 0) {
 			dev_dbg(&vdpasim->vdpa.dev,
 				"vringh_iov_pull_iotlb() error: %zd offset: 0x%llx len: 0x%zx\n",
@@ -247,7 +256,7 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 		}
 
 		if (type == VIRTIO_BLK_T_WRITE_ZEROES) {
-			memset(vdpasim->buffer + offset, 0,
+			memset(blk->buffer + offset, 0,
 			       num_sectors << SECTOR_SHIFT);
 		}
 
@@ -353,6 +362,13 @@ static void vdpasim_blk_get_config(struct vdpasim *vdpasim, void *config)
 
 }
 
+static void vdpasim_blk_free(struct vdpasim *vdpasim)
+{
+	struct vdpasim_blk *blk = sim_to_blk(vdpasim);
+
+	kvfree(blk->buffer);
+}
+
 static void vdpasim_blk_mgmtdev_release(struct device *dev)
 {
 }
@@ -366,6 +382,7 @@ static int vdpasim_blk_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 			       const struct vdpa_dev_set_config *config)
 {
 	struct vdpasim_dev_attr dev_attr = {};
+	struct vdpasim_blk *blk;
 	struct vdpasim *simdev;
 	int ret;
 
@@ -376,16 +393,25 @@ static int vdpasim_blk_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 	dev_attr.nvqs = VDPASIM_BLK_VQ_NUM;
 	dev_attr.ngroups = VDPASIM_BLK_GROUP_NUM;
 	dev_attr.nas = VDPASIM_BLK_AS_NUM;
-	dev_attr.alloc_size = sizeof(struct vdpasim);
+	dev_attr.alloc_size = sizeof(struct vdpasim_blk);
 	dev_attr.config_size = sizeof(struct virtio_blk_config);
 	dev_attr.get_config = vdpasim_blk_get_config;
 	dev_attr.work_fn = vdpasim_blk_work;
-	dev_attr.buffer_size = VDPASIM_BLK_CAPACITY << SECTOR_SHIFT;
+	dev_attr.free = vdpasim_blk_free;
 
 	simdev = vdpasim_create(&dev_attr, config);
 	if (IS_ERR(simdev))
 		return PTR_ERR(simdev);
 
+	blk = sim_to_blk(simdev);
+
+	blk->buffer = kvmalloc(VDPASIM_BLK_CAPACITY << SECTOR_SHIFT,
+			       GFP_KERNEL);
+	if (!blk->buffer) {
+		ret = -ENOMEM;
+		goto put_dev;
+	}
+
 	ret = _vdpa_register_device(&simdev->vdpa, VDPASIM_BLK_VQ_NUM);
 	if (ret)
 		goto put_dev;
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
index 55920502f76b..cfe962911804 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
@@ -58,6 +58,7 @@ struct vdpasim_net{
 	struct vdpasim_dataq_stats tx_stats;
 	struct vdpasim_dataq_stats rx_stats;
 	struct vdpasim_cq_stats cq_stats;
+	void *buffer;
 };
 
 static struct vdpasim_net *sim_to_net(struct vdpasim *vdpasim)
@@ -87,14 +88,15 @@ static bool receive_filter(struct vdpasim *vdpasim, size_t len)
 	size_t hdr_len = modern ? sizeof(struct virtio_net_hdr_v1) :
 				  sizeof(struct virtio_net_hdr);
 	struct virtio_net_config *vio_config = vdpasim->config;
+	struct vdpasim_net *net = sim_to_net(vdpasim);
 
 	if (len < ETH_ALEN + hdr_len)
 		return false;
 
-	if (is_broadcast_ether_addr(vdpasim->buffer + hdr_len) ||
-	    is_multicast_ether_addr(vdpasim->buffer + hdr_len))
+	if (is_broadcast_ether_addr(net->buffer + hdr_len) ||
+	    is_multicast_ether_addr(net->buffer + hdr_len))
 		return true;
-	if (!strncmp(vdpasim->buffer + hdr_len, vio_config->mac, ETH_ALEN))
+	if (!strncmp(net->buffer + hdr_len, vio_config->mac, ETH_ALEN))
 		return true;
 
 	return false;
@@ -225,8 +227,7 @@ static void vdpasim_net_work(struct vdpasim *vdpasim)
 
 		++tx_pkts;
 		read = vringh_iov_pull_iotlb(&txq->vring, &txq->out_iov,
-					     vdpasim->buffer,
-					     PAGE_SIZE);
+					     net->buffer, PAGE_SIZE);
 
 		tx_bytes += read;
 
@@ -245,7 +246,7 @@ static void vdpasim_net_work(struct vdpasim *vdpasim)
 		}
 
 		write = vringh_iov_push_iotlb(&rxq->vring, &rxq->in_iov,
-					      vdpasim->buffer, read);
+					      net->buffer, read);
 		if (write <= 0) {
 			++rx_errors;
 			break;
@@ -427,6 +428,13 @@ static void vdpasim_net_setup_config(struct vdpasim *vdpasim,
 		vio_config->mtu = cpu_to_vdpasim16(vdpasim, 1500);
 }
 
+static void vdpasim_net_free(struct vdpasim *vdpasim)
+{
+	struct vdpasim_net *net = sim_to_net(vdpasim);
+
+	kvfree(net->buffer);
+}
+
 static void vdpasim_net_mgmtdev_release(struct device *dev)
 {
 }
@@ -456,7 +464,7 @@ static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 	dev_attr.get_config = vdpasim_net_get_config;
 	dev_attr.work_fn = vdpasim_net_work;
 	dev_attr.get_stats = vdpasim_net_get_stats;
-	dev_attr.buffer_size = PAGE_SIZE;
+	dev_attr.free = vdpasim_net_free;
 
 	simdev = vdpasim_create(&dev_attr, config);
 	if (IS_ERR(simdev))
@@ -470,6 +478,12 @@ static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 	u64_stats_init(&net->rx_stats.syncp);
 	u64_stats_init(&net->cq_stats.syncp);
 
+	net->buffer = kvmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!net->buffer) {
+		ret = -ENOMEM;
+		goto reg_err;
+	}
+
 	/*
 	 * Initialization must be completed before this call, since it can
 	 * connect the device to the vDPA bus, so requests can arrive after
-- 
2.39.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C376DADAD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 15:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbjDGNiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 09:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbjDGNiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 09:38:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9867ED8
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 06:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680874642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tpRSctN0jCeuhjjA6kJE7wGPHdDwELgwrk4O7O5qFoQ=;
        b=hYEIuVD9wS7JpsRAhya585k1Zq7XYZqS0pPSy/dqrnCQPcmSf9t2qnThWqEaa+eO3TSP/L
        TPwOQ4/NsYHsrpNegGM5kpNYtRm6BNPo/QNK+cMXuuSnLab3jbckL4LZYVr2vNn7NJb1P/
        LJLm0QLvgV59oQXXkuQbATilT18X2i8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-up4zoJgLNkSlo3HmxF0J6A-1; Fri, 07 Apr 2023 09:37:20 -0400
X-MC-Unique: up4zoJgLNkSlo3HmxF0J6A-1
Received: by mail-qk1-f200.google.com with SMTP id 66-20020a370345000000b00746886b1593so19038140qkd.14
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 06:37:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680874640; x=1683466640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tpRSctN0jCeuhjjA6kJE7wGPHdDwELgwrk4O7O5qFoQ=;
        b=6DpIJGyf5cm39Y2JAyIxHVkOcIafKwABKZTo+PWeUOkjHZbDTOg+NrAx6bftwVt7fp
         r1DKqWDbeKvzw9nUp1b2CdTuIgTV1DCXl3IbNhxEyoERJvMFGUmm5SElkE7WyNmiILrX
         x3TaBbH+8YLI4TCQ/jnswRugJ5cRfoM7qpumT32A+91iuUdA6hkk5C2AawoXE/VVub/X
         9PXT12YwZA/lMSNWY9VdmLJFwR4FVOjcFXiRyg4AA5G95WoBJ+NKS6fZU+XbCWw3Vdog
         JegiLuFYDjlAtpNUoT1M+kMXJlvWx28A6bThr5V2pPVNfyYN5zXE6veREuZdaMbNwGMG
         xFKQ==
X-Gm-Message-State: AAQBX9cPohUKogxvFTVUgXj8HWRuMarHwVZxMSD033R7kr7Is5QhhWrn
        RXN7uniJyCY8ok3HDErAqnApu/i/QCcGZm+fKH6cz1A7wQeg0MNafxcimMl/LKmTvvWUJy+jn+L
        +s2w5FL48dhj0rcHWMYnH5HE+
X-Received: by 2002:a05:6214:c2f:b0:5a4:548e:4ed6 with SMTP id a15-20020a0562140c2f00b005a4548e4ed6mr4329610qvd.40.1680874640413;
        Fri, 07 Apr 2023 06:37:20 -0700 (PDT)
X-Google-Smtp-Source: AKy350bXs4iAie/qz64HuzAtlTPD297dbypTAD80jqfK809WSZrnMp+K5iTEUwMbyItqqdh9DaB+VA==
X-Received: by 2002:a05:6214:c2f:b0:5a4:548e:4ed6 with SMTP id a15-20020a0562140c2f00b005a4548e4ed6mr4329582qvd.40.1680874640146;
        Fri, 07 Apr 2023 06:37:20 -0700 (PDT)
Received: from step1.redhat.com ([5.77.69.107])
        by smtp.gmail.com with ESMTPSA id x85-20020a376358000000b0074a28c33df7sm1300194qkb.84.2023.04.07.06.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 06:37:19 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Alvaro Karsz <alvaro.karsz@solid-run.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Eugenio=20P=C3=A9rez=20Martin?= <eperezma@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 2/2] vdpa_sim_blk: support shared backend
Date:   Fri,  7 Apr 2023 15:36:58 +0200
Message-Id: <20230407133658.66339-3-sgarzare@redhat.com>
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

The vdpa_sim_blk simulator uses a ramdisk as the backend. To test live
migration, we need two devices that share the backend to have the data
synchronized with each other.

Add a new module parameter to make the buffer shared between all devices.

The shared_buffer_mutex is used just to ensure that each operation is
atomic, but it is up to the user to use the devices knowing that the
underlying ramdisk is shared.

For example, when we do a migration, the VMM (e.g., QEMU) will guarantee
to write to the destination device, only after completing operations with
the source device.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 57 ++++++++++++++++++++++++----
 1 file changed, 50 insertions(+), 7 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
index c996e750dc02..00d7d72713be 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
@@ -46,6 +46,7 @@
 struct vdpasim_blk {
 	struct vdpasim vdpasim;
 	void *buffer;
+	bool shared_backend;
 };
 
 static struct vdpasim_blk *sim_to_blk(struct vdpasim *vdpasim)
@@ -55,6 +56,26 @@ static struct vdpasim_blk *sim_to_blk(struct vdpasim *vdpasim)
 
 static char vdpasim_blk_id[VIRTIO_BLK_ID_BYTES] = "vdpa_blk_sim";
 
+static bool shared_backend;
+module_param(shared_backend, bool, 0444);
+MODULE_PARM_DESC(shared_backend, "Enable the shared backend between virtio-blk devices");
+
+static void *shared_buffer;
+/* mutex to synchronize shared_buffer access */
+static DEFINE_MUTEX(shared_buffer_mutex);
+
+static void vdpasim_blk_buffer_lock(struct vdpasim_blk *blk)
+{
+	if (blk->shared_backend)
+		mutex_lock(&shared_buffer_mutex);
+}
+
+static void vdpasim_blk_buffer_unlock(struct vdpasim_blk *blk)
+{
+	if (blk->shared_backend)
+		mutex_unlock(&shared_buffer_mutex);
+}
+
 static bool vdpasim_blk_check_range(struct vdpasim *vdpasim, u64 start_sector,
 				    u64 num_sectors, u64 max_sectors)
 {
@@ -154,8 +175,10 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 			break;
 		}
 
+		vdpasim_blk_buffer_lock(blk);
 		bytes = vringh_iov_push_iotlb(&vq->vring, &vq->in_iov,
 					      blk->buffer + offset, to_push);
+		vdpasim_blk_buffer_unlock(blk);
 		if (bytes < 0) {
 			dev_dbg(&vdpasim->vdpa.dev,
 				"vringh_iov_push_iotlb() error: %zd offset: 0x%llx len: 0x%zx\n",
@@ -175,8 +198,10 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 			break;
 		}
 
+		vdpasim_blk_buffer_lock(blk);
 		bytes = vringh_iov_pull_iotlb(&vq->vring, &vq->out_iov,
 					      blk->buffer + offset, to_pull);
+		vdpasim_blk_buffer_unlock(blk);
 		if (bytes < 0) {
 			dev_dbg(&vdpasim->vdpa.dev,
 				"vringh_iov_pull_iotlb() error: %zd offset: 0x%llx len: 0x%zx\n",
@@ -256,8 +281,10 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 		}
 
 		if (type == VIRTIO_BLK_T_WRITE_ZEROES) {
+			vdpasim_blk_buffer_lock(blk);
 			memset(blk->buffer + offset, 0,
 			       num_sectors << SECTOR_SHIFT);
+			vdpasim_blk_buffer_unlock(blk);
 		}
 
 		break;
@@ -366,7 +393,8 @@ static void vdpasim_blk_free(struct vdpasim *vdpasim)
 {
 	struct vdpasim_blk *blk = sim_to_blk(vdpasim);
 
-	kvfree(blk->buffer);
+	if (!blk->shared_backend)
+		kvfree(blk->buffer);
 }
 
 static void vdpasim_blk_mgmtdev_release(struct device *dev)
@@ -404,12 +432,17 @@ static int vdpasim_blk_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 		return PTR_ERR(simdev);
 
 	blk = sim_to_blk(simdev);
-
-	blk->buffer = kvmalloc(VDPASIM_BLK_CAPACITY << SECTOR_SHIFT,
-			       GFP_KERNEL);
-	if (!blk->buffer) {
-		ret = -ENOMEM;
-		goto put_dev;
+	blk->shared_backend = shared_backend;
+
+	if (blk->shared_backend) {
+		blk->buffer = shared_buffer;
+	} else {
+		blk->buffer = kvmalloc(VDPASIM_BLK_CAPACITY << SECTOR_SHIFT,
+				       GFP_KERNEL);
+		if (!blk->buffer) {
+			ret = -ENOMEM;
+			goto put_dev;
+		}
 	}
 
 	ret = _vdpa_register_device(&simdev->vdpa, VDPASIM_BLK_VQ_NUM);
@@ -461,6 +494,15 @@ static int __init vdpasim_blk_init(void)
 	if (ret)
 		goto parent_err;
 
+	if (shared_backend) {
+		shared_buffer = kvmalloc(VDPASIM_BLK_CAPACITY << SECTOR_SHIFT,
+					 GFP_KERNEL);
+		if (!shared_buffer) {
+			ret = -ENOMEM;
+			goto parent_err;
+		}
+	}
+
 	return 0;
 
 parent_err:
@@ -470,6 +512,7 @@ static int __init vdpasim_blk_init(void)
 
 static void __exit vdpasim_blk_exit(void)
 {
+	kvfree(shared_buffer);
 	vdpa_mgmtdev_unregister(&mgmt_dev);
 	device_unregister(&vdpasim_blk_mgmtdev);
 }
-- 
2.39.2


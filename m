Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3ECC72951F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241623AbjFIJ3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241592AbjFIJ3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:29:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E27F3C0F
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 02:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686302511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1rO6a+xdfZtWaePxR/QAzOglehE9/nz9AmfIDcLwU6A=;
        b=FMJyqKVsnJYHf9jH0K8He2OMghhLsTfuSQy+outElY2QV86c5+Px5FOg8vdhdda1mF6IaU
        BRxM+LD48wUeEPbk6hDto+P0FNVtb/qdiBiTnNJoBktV7q8RQD4xSIzgm62t5vaS23UhZF
        A4CIvDdUSRbnWBhhflCGjbjD1j05z/g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-230-UYkEzIZQPV62AftoqrzJjw-1; Fri, 09 Jun 2023 05:21:45 -0400
X-MC-Unique: UYkEzIZQPV62AftoqrzJjw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 01DBF802355;
        Fri,  9 Jun 2023 09:21:43 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.193.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E24BF202696C;
        Fri,  9 Jun 2023 09:21:39 +0000 (UTC)
From:   =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To:     mst@redhat.com, Jason Wang <jasowang@redhat.com>
Cc:     Zhu Lingshan <lingshan.zhu@intel.com>,
        virtualization@lists.linux-foundation.org,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>, longpeng2@huawei.com,
        Lei Yang <leiyang@redhat.com>,
        Parav Pandit <parav@mellanox.com>,
        Gautam Dawar <gdawar@xilinx.com>,
        Dragos Tatulea <dtatulea@nvidia.com>,
        Laurent Vivier <lvivier@redhat.com>, linux-api@vger.kernel.org,
        Liuxiangdong <liuxiangdong5@huawei.com>,
        linux-kernel@vger.kernel.org, alvaro.karsz@solid-run.com,
        Shannon Nelson <snelson@pensando.io>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Cindy Lu <lulu@redhat.com>, si-wei.liu@oracle.com,
        Harpreet Singh Anand <hanand@xilinx.com>
Subject: [PATCH v2 3/4] vdpa: add get_backend_features vdpa operation
Date:   Fri,  9 Jun 2023 11:21:26 +0200
Message-Id: <20230609092127.170673-4-eperezma@redhat.com>
In-Reply-To: <20230609092127.170673-1-eperezma@redhat.com>
References: <20230609092127.170673-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This operation allow vdpa parent to expose its own backend feature bits.

Next patches introduce a feature not compatible with all parent drivers:
the ability to enable vq after driver_ok.  Each parent must declare if
it allows it or not.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/vhost/vdpa.c | 12 ++++++++++++
 include/linux/vdpa.h |  4 ++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index a3204406b73d..e1abf29fed5b 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -403,6 +403,17 @@ static long vhost_vdpa_get_features(struct vhost_vdpa *v, u64 __user *featurep)
 	return 0;
 }
 
+static u64 vhost_vdpa_get_backend_features(const struct vhost_vdpa *v)
+{
+	struct vdpa_device *vdpa = v->vdpa;
+	const struct vdpa_config_ops *ops = vdpa->config;
+
+	if (!ops->get_backend_features)
+		return 0;
+	else
+		return ops->get_backend_features(vdpa);
+}
+
 static long vhost_vdpa_set_features(struct vhost_vdpa *v, u64 __user *featurep)
 {
 	struct vdpa_device *vdpa = v->vdpa;
@@ -742,6 +753,7 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
 			features |= BIT_ULL(VHOST_BACKEND_F_SUSPEND);
 		if (vhost_vdpa_can_resume(v))
 			features |= BIT_ULL(VHOST_BACKEND_F_RESUME);
+		features |= vhost_vdpa_get_backend_features(v);
 		if (copy_to_user(featurep, &features, sizeof(features)))
 			r = -EFAULT;
 		break;
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index db1b0eaef4eb..0e652026b776 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -208,6 +208,9 @@ struct vdpa_map_file {
  *				@vdev: vdpa device
  *				Returns the virtio features support by the
  *				device
+ * @get_backend_features:	Get parent-specific backend features (optional)
+ *				Returns the vdpa features supported by the
+ *				device.
  * @set_driver_features:	Set virtio features supported by the driver
  *				@vdev: vdpa device
  *				@features: feature support by the driver
@@ -358,6 +361,7 @@ struct vdpa_config_ops {
 	u32 (*get_vq_align)(struct vdpa_device *vdev);
 	u32 (*get_vq_group)(struct vdpa_device *vdev, u16 idx);
 	u64 (*get_device_features)(struct vdpa_device *vdev);
+	u64 (*get_backend_features)(const struct vdpa_device *vdev);
 	int (*set_driver_features)(struct vdpa_device *vdev, u64 features);
 	u64 (*get_driver_features)(struct vdpa_device *vdev);
 	void (*set_config_cb)(struct vdpa_device *vdev,
-- 
2.31.1


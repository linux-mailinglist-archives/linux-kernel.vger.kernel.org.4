Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B3A729516
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240996AbjFIJ3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241592AbjFIJ2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:28:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CE86A49
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 02:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686302510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ECFSkBPZk6Hf9wW6u18xsllOKumXr/NSdBh2uJ9ps7g=;
        b=O3IF61vPH48SitPOY0YhEBM16FELK7vCrGd/fd7y+F/LCfgJKlVd3TIt7sEba+BZAC6fpV
        5S+/rAY6s6kzgIdJZqGP3XgCd+apV73N2nAiAuaTLI4uXFSAltwMPFUAdtT3gVMzWF11qv
        tz4FsQpUBWbRimmHIyaNMpTMW4aAWzA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-497-r4toiCbLPEavcdV3x29TIg-1; Fri, 09 Jun 2023 05:21:47 -0400
X-MC-Unique: r4toiCbLPEavcdV3x29TIg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5BF45101A593;
        Fri,  9 Jun 2023 09:21:46 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.193.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4888A20268C6;
        Fri,  9 Jun 2023 09:21:43 +0000 (UTC)
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
Subject: [PATCH v2 4/4] vdpa_sim: offer VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK
Date:   Fri,  9 Jun 2023 11:21:27 +0200
Message-Id: <20230609092127.170673-5-eperezma@redhat.com>
In-Reply-To: <20230609092127.170673-1-eperezma@redhat.com>
References: <20230609092127.170673-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Start offering the feature in the simulator.  Other parent drivers can
follow this code to offer it too.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index d343af4fa60e..76d41058add9 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -18,6 +18,7 @@
 #include <linux/vdpa.h>
 #include <linux/vhost_iotlb.h>
 #include <uapi/linux/vdpa.h>
+#include <uapi/linux/vhost_types.h>
 
 #include "vdpa_sim.h"
 
@@ -410,6 +411,11 @@ static u64 vdpasim_get_device_features(struct vdpa_device *vdpa)
 	return vdpasim->dev_attr.supported_features;
 }
 
+static u64 vdpasim_get_backend_features(const struct vdpa_device *vdpa)
+{
+	return BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK);
+}
+
 static int vdpasim_set_driver_features(struct vdpa_device *vdpa, u64 features)
 {
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
@@ -733,6 +739,7 @@ static const struct vdpa_config_ops vdpasim_config_ops = {
 	.get_vq_align           = vdpasim_get_vq_align,
 	.get_vq_group           = vdpasim_get_vq_group,
 	.get_device_features    = vdpasim_get_device_features,
+	.get_backend_features   = vdpasim_get_backend_features,
 	.set_driver_features    = vdpasim_set_driver_features,
 	.get_driver_features    = vdpasim_get_driver_features,
 	.set_config_cb          = vdpasim_set_config_cb,
@@ -770,6 +777,7 @@ static const struct vdpa_config_ops vdpasim_batch_config_ops = {
 	.get_vq_align           = vdpasim_get_vq_align,
 	.get_vq_group           = vdpasim_get_vq_group,
 	.get_device_features    = vdpasim_get_device_features,
+	.get_backend_features   = vdpasim_get_backend_features,
 	.set_driver_features    = vdpasim_set_driver_features,
 	.get_driver_features    = vdpasim_get_driver_features,
 	.set_config_cb          = vdpasim_set_config_cb,
-- 
2.31.1


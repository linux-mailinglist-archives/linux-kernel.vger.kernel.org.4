Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEB5689B8D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 15:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbjBCO0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 09:26:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232736AbjBCOZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 09:25:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74AE323304
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 06:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675434309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=9N2hOTys/+lGMc2Icse9u7NTCoYhCX2MBJqWpddTKDI=;
        b=AAdkG8IrAuQkb1JviOzELj/QI1oGtvYoTuypHi89t+lxgSsB/30wZxjh7pK6/pDgddROmf
        UiztBOwvWOlzA0JcUgLFkcYGG9ER2tAX0CLhrcLuq8YRe9uTdOTXxY/6tG5m32GYuVwuxW
        Llb5tWZaNWP/q6B0CmFksQFJdLWEdbs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-44-Zt1xpZnCO8i2hEkM63CUWA-1; Fri, 03 Feb 2023 09:25:06 -0500
X-MC-Unique: Zt1xpZnCO8i2hEkM63CUWA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EC29C802314;
        Fri,  3 Feb 2023 14:25:05 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.194.221])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BD6172026D37;
        Fri,  3 Feb 2023 14:25:02 +0000 (UTC)
From:   =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To:     mst@redhat.com
Cc:     lulu@redhat.com, virtualization@lists.linux-foundation.org,
        si-wei.liu@oracle.com, leiyang@redhat.com,
        Gautam Dawar <gdawar@xilinx.com>, Eli Cohen <elic@nvidia.com>,
        longpeng2@huawei.com, parav@nvidia.com,
        linux-kernel@vger.kernel.org, sgarzare@redhat.com,
        Zhu Lingshan <lingshan.zhu@intel.com>,
        alvaro.karsz@solid-run.com, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v2] vdpa_sim: set last_used_idx as last_avail_idx in vdpasim_queue_ready
Date:   Fri,  3 Feb 2023 15:25:01 +0100
Message-Id: <20230203142501.300125-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Starting from an used_idx different than 0 is needed in use cases like
virtual machine migration.  Not doing so and letting the caller set an
avail idx different than 0 causes destination device to try to use old
buffers that source driver already recover and are not available
anymore.

Since vdpa_sim does not support receive inflight descriptors as a
destination of a migration, let's set both avail_idx and used_idx the
same at vq start.  This is how vhost-user works in a
VHOST_SET_VRING_BASE call.

Although the simple fix is to set last_used_idx at vdpasim_set_vq_state,
it would be reset at vdpasim_queue_ready.  The last_avail_idx case is
fixed with commit a09f493c ("vdpa_sim: not reset state in
vdpasim_queue_ready").  Since the only option is to make it equal to
last_avail_idx, adding the only change needed here.

This was discovered and tested live migrating the vdpa_sim_net device.

Fixes: 2c53d0f64c06 ("vdpasim: vDPA device simulator")
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
Cherry-picked from patch 2/2 of the series [1]. Differences are:
* Set the value of used_idx at vdpasim_queue_ready instead of fetching
  from the guest vring like vhost-kernel.

v2: Actually update last_used_idx only at vdpasim_queue_ready.

Note that commit id present in the patch text is not in master but in
git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git.

[1] https://lkml.org/lkml/2023/1/18/1041
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 6a0a65814626..79ac585e40b9 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -68,6 +68,7 @@ static void vdpasim_queue_ready(struct vdpasim *vdpasim, unsigned int idx)
 			  (uintptr_t)vq->device_addr);
 
 	vq->vring.last_avail_idx = last_avail_idx;
+	vq->vring.last_used_idx = last_avail_idx;
 	vq->vring.notify = vdpasim_vq_notify;
 }
 
-- 
2.31.1


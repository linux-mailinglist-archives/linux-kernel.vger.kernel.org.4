Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80966A886D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 19:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjCBSTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 13:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCBSTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 13:19:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103F834018
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 10:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677781146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=zNb9G022CJaLitYkR75dWvbL+tzU0OIY68F+4x3NvFU=;
        b=foLBudfeKdoVNlduyV5w5zzW8Xxj70ePneJF4n3gYhsjCPOwylmK0XM3BuNaeByizyEufb
        /NRr4OUve9nfYayFVz5zyFdYMj2e4kWD7+WpFoVNO/jlPuiYzfdhQteQPi6Dm/LPTHDzJx
        6s/BfjnhJWRYP+KcYW1/1e6w+m2kki0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-611-Y4RiKZHtNR-CrzCYnLW_HA-1; Thu, 02 Mar 2023 13:19:02 -0500
X-MC-Unique: Y4RiKZHtNR-CrzCYnLW_HA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3E4AD101A52E;
        Thu,  2 Mar 2023 18:19:02 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.193.119])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F33A51FF;
        Thu,  2 Mar 2023 18:18:59 +0000 (UTC)
From:   =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To:     mst@redhat.com
Cc:     lulu@redhat.com, parav@nvidia.com, longpeng2@huawei.com,
        Zhu Lingshan <lingshan.zhu@intel.com>,
        Gautam Dawar <gdawar@xilinx.com>, alvaro.karsz@solid-run.com,
        Laurent Vivier <lvivier@redhat.com>, sgarzare@redhat.com,
        si-wei.liu@oracle.com, Eli Cohen <elic@nvidia.com>,
        linux-kernel@vger.kernel.org, leiyang@redhat.com,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v3] vdpa_sim: set last_used_idx as last_avail_idx in vdpasim_queue_ready
Date:   Thu,  2 Mar 2023 19:18:57 +0100
Message-Id: <20230302181857.925374-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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
fixed with commit 0e84f918fac8 ("vdpa_sim: not reset state in
vdpasim_queue_ready").  Since the only option is to make it equal to
last_avail_idx, adding the only change needed here.

This was discovered and tested live migrating the vdpa_sim_net device.

Fixes: 2c53d0f64c06 ("vdpasim: vDPA device simulator")
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
Cherry-picked from patch 2/2 of the series [1]. Differences are:
* Set the value of used_idx at vdpasim_queue_ready instead of fetching
  from the guest vring like vhost-kernel.

v3:
* Fix commit id in the patch message.
* Add in code comment following the patch message about why it is done
  this way.
v2: Actually update last_used_idx only at vdpasim_queue_ready.

Note that commit id present in the patch text is not in master but in
git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git.

[1] https://lkml.org/lkml/2023/1/18/1041
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 6a0a65814626..eea23c630f7c 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -68,6 +68,17 @@ static void vdpasim_queue_ready(struct vdpasim *vdpasim, unsigned int idx)
 			  (uintptr_t)vq->device_addr);
 
 	vq->vring.last_avail_idx = last_avail_idx;
+
+	/*
+	 * Since vdpa_sim does not support receive inflight descriptors as a
+	 * destination of a migration, let's set both avail_idx and used_idx
+	 * the same at vq start.  This is how vhost-user works in a
+	 * VHOST_SET_VRING_BASE call.
+	 *
+	 * Although the simple fix is to set last_used_idx at
+	 * vdpasim_set_vq_state, it would be reset at vdpasim_queue_ready.
+	 */
+	vq->vring.last_used_idx = last_avail_idx;
 	vq->vring.notify = vdpasim_vq_notify;
 }
 
-- 
2.31.1


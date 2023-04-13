Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4306E0726
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 08:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjDMGlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 02:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjDMGlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 02:41:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCF683FE
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 23:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681368050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gpLT5R5/zK3cbjxkCACuzxBqVGqeFsHPUxNqi6hiv3s=;
        b=GF+F6+SXmlotNN14FvAjzyJwKeYvCpA7yOYCh+EJbaWfYxGxUbxgw8Vfyu5sVuLmWvAZDm
        95G7iC3jZbt8sFfNPdJLBOx5lJad5Zvkl7kY52bNlQ36q0WnV+nJYSfeO1IHTciwcbzRJj
        DTPdOQ3Fe4rF9JceGvuDNix1V0f3B0I=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-152-BOUUWfWAONeJnvX6gK18fg-1; Thu, 13 Apr 2023 02:40:49 -0400
X-MC-Unique: BOUUWfWAONeJnvX6gK18fg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AD9DE3C025B3;
        Thu, 13 Apr 2023 06:40:48 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-72.pek2.redhat.com [10.72.12.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 20C6140C6F87;
        Thu, 13 Apr 2023 06:40:42 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, maxime.coquelin@redhat.com,
        alvaro.karsz@solid-run.com, eperezma@redhat.com,
        xuanzhuo@linux.alibaba.com, david.marchand@redhat.com
Subject: [PATCH net-next V2 2/2] virtio-net: sleep instead of busy waiting for cvq command
Date:   Thu, 13 Apr 2023 14:40:27 +0800
Message-Id: <20230413064027.13267-3-jasowang@redhat.com>
In-Reply-To: <20230413064027.13267-1-jasowang@redhat.com>
References: <20230413064027.13267-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We used to busy waiting on the cvq command this tends to be
problematic since there no way for to schedule another process which
may serve for the control virtqueue. This might be the case when the
control virtqueue is emulated by software. This patch switches to use
completion to allow the CPU to sleep instead of busy waiting for the
cvq command.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
Changes since V1:
- use completion for simplicity
- don't try to harden the CVQ command which requires more thought
Changes since RFC:
- break the device when timeout
- get buffer manually since the virtio core check more_used() instead
---
 drivers/net/virtio_net.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 2e56bbf86894..d3eb8fd6c9dc 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -19,6 +19,7 @@
 #include <linux/average.h>
 #include <linux/filter.h>
 #include <linux/kernel.h>
+#include <linux/completion.h>
 #include <net/route.h>
 #include <net/xdp.h>
 #include <net/net_failover.h>
@@ -295,6 +296,8 @@ struct virtnet_info {
 
 	/* failover when STANDBY feature enabled */
 	struct failover *failover;
+
+	struct completion completion;
 };
 
 struct padded_vnet_hdr {
@@ -1709,6 +1712,13 @@ static bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq,
 	return !oom;
 }
 
+static void virtnet_cvq_done(struct virtqueue *cvq)
+{
+	struct virtnet_info *vi = cvq->vdev->priv;
+
+	complete(&vi->completion);
+}
+
 static void skb_recv_done(struct virtqueue *rvq)
 {
 	struct virtnet_info *vi = rvq->vdev->priv;
@@ -2169,12 +2179,8 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
 	if (unlikely(!virtqueue_kick(vi->cvq)))
 		return vi->ctrl->status == VIRTIO_NET_OK;
 
-	/* Spin for a response, the kick causes an ioport write, trapping
-	 * into the hypervisor, so the request should be handled immediately.
-	 */
-	while (!virtqueue_get_buf(vi->cvq, &tmp) &&
-	       !virtqueue_is_broken(vi->cvq))
-		cpu_relax();
+	wait_for_completion(&vi->completion);
+	virtqueue_get_buf(vi->cvq, &tmp);
 
 	return vi->ctrl->status == VIRTIO_NET_OK;
 }
@@ -3672,7 +3678,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
 
 	/* Parameters for control virtqueue, if any */
 	if (vi->has_cvq) {
-		callbacks[total_vqs - 1] = NULL;
+		callbacks[total_vqs - 1] = virtnet_cvq_done;
 		names[total_vqs - 1] = "control";
 	}
 
@@ -4122,6 +4128,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 	if (vi->has_rss || vi->has_rss_hash_report)
 		virtnet_init_default_rss(vi);
 
+	init_completion(&vi->completion);
 	enable_rx_mode_work(vi);
 
 	/* serialize netdev register + virtio_device_ready() with ndo_open() */
-- 
2.25.1


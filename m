Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D97B652CD8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 07:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbiLUGWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 01:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiLUGWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 01:22:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB1FBDB
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 22:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671603714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=YbUTDBvvbkpTowLUKuY9NOUf0QooGXIhFhvRisHIr4Q=;
        b=JePHgRy26hFhNadvyPVcajPaPJYxfsVNvQVBfOCE34/JQ16jvBVaeMqcmz/WwWis7oLVrH
        dq+m3SS9XjWvlCaHTv2r9Y7N6Ye66PPSFtg2uykZFjNBpnTeJRI8EaZay9oBwmhEf/i86Y
        TZJwWj8o4OSXp6niMaLGmCevdKmyGug=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-26-uqvySR1SPRev5hYvxGYHgg-1; Wed, 21 Dec 2022 01:21:52 -0500
X-MC-Unique: uqvySR1SPRev5hYvxGYHgg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 323612823807;
        Wed, 21 Dec 2022 06:21:52 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-236.pek2.redhat.com [10.72.13.236])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 298E4112132C;
        Wed, 21 Dec 2022 06:21:48 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     sgarzare@redhat.com, eperezma@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] vdpa_sim: use weak barriers
Date:   Wed, 21 Dec 2022 14:21:46 +0800
Message-Id: <20221221062146.15356-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vDPA simulators are software emulated device, so let's switch to use
weak barriers to avoid extra overhead in the driver.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index b071f0d842fb..eeaeaf43b476 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -68,7 +68,7 @@ static void vdpasim_queue_ready(struct vdpasim *vdpasim, unsigned int idx)
 	struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
 
 	vringh_init_iotlb(&vq->vring, vdpasim->dev_attr.supported_features,
-			  VDPASIM_QUEUE_MAX, false,
+			  VDPASIM_QUEUE_MAX, true,
 			  (struct vring_desc *)(uintptr_t)vq->desc_addr,
 			  (struct vring_avail *)
 			  (uintptr_t)vq->driver_addr,
-- 
2.25.1


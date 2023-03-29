Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3EF56CD793
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 12:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbjC2KXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 06:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjC2KXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 06:23:14 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637321991
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 03:23:10 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id y19so8966180pgk.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 03:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680085389;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lRXvVjCt5CgRtnPCELX2ysNWqd55c6EfIdDskRFfoOQ=;
        b=fdJlPYm3uFhEVmwI6e8y1w2//oOg3rTwoINYzpSQBzoTuiXPYcY5Boltm5DbB+QjMW
         5GQXxUEyvsOJASaSgZL+kQH8p7GbtUvNEi3lZlNeHPuYV8Wlp6y0l10cuEZHnd1KJkLL
         MduaeMpgMmnvyVPQ8kU+I2I7pjHzl56rqegT4PJKcUMPaRmOKun1ZAfqBBpgow3aGByg
         +XP+0RFSuz5tNOg+z0jMT5dy+5TLzLqLm4HNdNBayx6zLTTRm9W76CcH8hQA1yTm6Z3B
         /HEp8o9FavltqXiUPRpXDgs1NzrQDqAO3l4wljKOnxIPIuSBRrnkb7KFC1QCm1aJMICW
         9K3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680085389;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lRXvVjCt5CgRtnPCELX2ysNWqd55c6EfIdDskRFfoOQ=;
        b=PNmHLejGpS4Iq6VZ3UZMxiIfoNJUmL50N4xzbr62fKjuSlscFa9R7KqGBiA3YGxNVz
         wL7Z6Vf2Qeba9n80s8l4E87G4ELEf2qjB6NqnDo2oBdau0bkP6CiwN4slUu8YCKu1N+n
         FQpXx+kSsHaQGEt0qhAWjZB2KRqkUwSaHDEZdXQjwhBoazBdqQnHtqJtQWp9RKZYlaAq
         q41KvUkukvDxznSkRmvWUvVIqyVRL1FsMHQkkRpoR+UzQ26miZsO13VxVy64ky2zcAR4
         +DILfdR9JuLRzSy1xJhxcM4gO/Oprv3aWq01tO8wwmRSTIXCsNzR+bfaur2wsIDacH43
         8r5A==
X-Gm-Message-State: AAQBX9cKpbuFGwkqDQxg+1XcNgggfj91w2dg1TfFteMMnEHpquLx8oAj
        J1jfOrTdUBAcbnFKPvY3IWXaQMywlKbQ6o8giRA=
X-Google-Smtp-Source: AKy350aMJ3UgosDpevtbOA0YSySqSCJdvY1FokuzjqO9ol2EuG1Izo3701El3y/1Qq7Ohummu1Q0bw==
X-Received: by 2002:a62:18d5:0:b0:625:ff85:21ec with SMTP id 204-20020a6218d5000000b00625ff8521ecmr17895331pfy.26.1680085389512;
        Wed, 29 Mar 2023 03:23:09 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id s17-20020a62e711000000b00575d1ba0ecfsm22759931pfh.133.2023.03.29.03.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 03:23:08 -0700 (PDT)
From:   Albert Huang <huangjie.albert@bytedance.com>
To:     Jason Wang <jasowang@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>
Cc:     "huangjie.albert" <huangjie.albert@bytedance.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] virtio_ring: interrupt disable flag updated to vq even with event_triggered is set
Date:   Wed, 29 Mar 2023 18:23:00 +0800
Message-Id: <20230329102300.61000-1-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "huangjie.albert" <huangjie.albert@bytedance.com>

in virtio_net, if we disable the napi_tx, when we triger a tx interrupt,
the vq->event_triggered will be set to true. It will no longer be set to
false. Unless we explicitly call virtqueue_enable_cb_delayed or
virtqueue_enable_cb_prepare.

If we disable the napi_tx, it will only be called when the tx ring
buffer is relatively small.

Because event_triggered is true. Therefore, VRING_AVAIL_F_NO_INTERRUPT or
VRING_PACKED_EVENT_FLAG_DISABLE will not be set. So we update
vring_used_event(&vq->split.vring) or vq->packed.vring.driver->off_wrap
every time we call virtqueue_get_buf_ctx.This bring more interruptions.

To summarize:
1) event_triggered was set to true in vring_interrupt()
2) after this nothing will happen for virtqueue_disable_cb() so
   VRING_AVAIL_F_NO_INTERRUPT is not set in avail_flags_shadow
3) virtqueue_get_buf_ctx_split() will still think the cb is enabled
   then it tries to publish new event

To fix:
update VRING_AVAIL_F_NO_INTERRUPT or VRING_PACKED_EVENT_FLAG_DISABLE to vq
when we call virtqueue_disable_cb even the event_triggered is set to true.

Tested with iperf:
iperf3 tcp stream:
vm1 -----------------> vm2
vm2 just receives tcp data stream from vm1, and sends the ack to vm1,
there are many tx interrupts in vm2.
but without event_triggered there are just a few tx interrupts.

v2->v3:
-update the interrupt disable flag even with the event_triggered is set,
-instead of checking whether event_triggered is set in
-virtqueue_get_buf_ctx_{packed/split}, will cause the drivers  which have
-not called virtqueue_{enable/disable}_cb to miss notifications.

v3->v4:
-remove change for
-"if (vq->packed.event_flags_shadow != VRING_PACKED_EVENT_FLAG_DISABLE)"
-in virtqueue_disable_cb_packed

Fixes: 8d622d21d248 ("virtio: fix up virtio_disable_cb")
Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index cbeeea1b0439..ec7ab8e04846 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -931,6 +931,14 @@ static void virtqueue_disable_cb_split(struct virtqueue *_vq)
 
 	if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT)) {
 		vq->split.avail_flags_shadow |= VRING_AVAIL_F_NO_INTERRUPT;
+
+		/*
+		 * If device triggered an event already it won't trigger one again:
+		 * no need to disable.
+		 */
+		if (vq->event_triggered)
+			return;
+
 		if (vq->event)
 			/* TODO: this is a hack. Figure out a cleaner value to write. */
 			vring_used_event(&vq->split.vring) = 0x0;
@@ -1761,6 +1769,14 @@ static void virtqueue_disable_cb_packed(struct virtqueue *_vq)
 
 	if (vq->packed.event_flags_shadow != VRING_PACKED_EVENT_FLAG_DISABLE) {
 		vq->packed.event_flags_shadow = VRING_PACKED_EVENT_FLAG_DISABLE;
+
+		/*
+		 * If device triggered an event already it won't trigger one again:
+		 * no need to disable.
+		 */
+		if (vq->event_triggered)
+			return;
+
 		vq->packed.vring.driver->flags =
 			cpu_to_le16(vq->packed.event_flags_shadow);
 	}
@@ -2462,12 +2478,6 @@ void virtqueue_disable_cb(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
-	/* If device triggered an event already it won't trigger one again:
-	 * no need to disable.
-	 */
-	if (vq->event_triggered)
-		return;
-
 	if (vq->packed_ring)
 		virtqueue_disable_cb_packed(_vq);
 	else
-- 
2.20.1


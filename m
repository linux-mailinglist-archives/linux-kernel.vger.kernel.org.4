Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466886CD340
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 09:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjC2HcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 03:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjC2Hbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 03:31:51 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711853C0F
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 00:29:04 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id ix20so14119221plb.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 00:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680074932;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=22LODKDRCsluZyudoWo7KCI2qd/LFxfCN6vG8QOiOSk=;
        b=fGAozHrFoYPurbj60xdYlQnOAY75ZTkmq8ngaA32cd30xXzluTIP0WD9dDvmvjK9De
         ZkXEmY5ZjUgBvGlyeV1jdOxSYk1E3kGHhDRganjXAN3jpyUNlC9lh6a3/1yi1XECJHOt
         o7XqTTA4z6BP8IaqbgBYqNf4xuXWBMK6PGKgkZuPOeT6u/U5ZlPFgFaECUWl+shoY2N+
         yobMxgqGgI5QW5DYrZSIOBtjZFC5Al52e3zgaZXE9LYIxgYm0Pvn3qqwrgHEGvZ9v1n8
         cLCJj6Ejja2W6nVPrWCWZNGey9BIhP46k/8Yx9Bfdca2HfW3zAUmHBelGnVkoDN4oSzu
         6BgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680074932;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=22LODKDRCsluZyudoWo7KCI2qd/LFxfCN6vG8QOiOSk=;
        b=T8Xx4nquFAUOg2ppJ/dH2MA8tA8WqAwa0nMzvxXBSuon44bZNRpzoYGF9F95pcevh9
         3QYqF14o07l/Q6uQd3c3mc3X6WSv/gGw4ECN0rwqJOLu4MdkvSZ/Qb3R36VbSRnPxHoE
         4swej0GMaNEf+HChkC7gNQFIGuGrPCfc0v6SGJ8YYyTfh5ne3i6Ba6BDF5YGF2BodNOJ
         7YvDdPuVaw0jNau8TbPifu8wiR+mO2lzNkbMj52CO0ScA5LW91gNMwSkjXVK2dxf7WK9
         3ObMUJouRv1BoXtwbk5D+rjkZ3EFIVHQDwBuA1lKHzukFMsGuGjd4jva9bplloNHrBk7
         tMTQ==
X-Gm-Message-State: AAQBX9c7rF1Otof8TrvlxO+2W+79nLl6a7LWwxaYou9ePDF6HVXolsPO
        t4ewOsoU5fUpRQYbDSitWGOtfQ==
X-Google-Smtp-Source: AKy350bWyw8+NmBKn1QTp1cmoKHcb9kyFRxvwq87osgdfS7AGYGF989Dc1ln6TxkQfe7dwuBaVnNzg==
X-Received: by 2002:a17:90b:1e49:b0:233:76bd:9faa with SMTP id pi9-20020a17090b1e4900b0023376bd9faamr20794160pjb.47.1680074931997;
        Wed, 29 Mar 2023 00:28:51 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id u21-20020a17090ae01500b002369d3b282csm748463pjy.40.2023.03.29.00.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 00:28:51 -0700 (PDT)
From:   Albert Huang <huangjie.albert@bytedance.com>
To:     Jason Wang <jasowang@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>
Cc:     "huangjie.albert" <huangjie.albert@bytedance.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] virtio_ring: interrupt disable flag updated to vq even with event_triggered is set
Date:   Wed, 29 Mar 2023 15:28:41 +0800
Message-Id: <20230329072841.45304-1-huangjie.albert@bytedance.com>
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

Fixes: 8d622d21d248 ("virtio: fix up virtio_disable_cb")
Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 307e139cb11d..ad74463a48ee 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -812,6 +812,14 @@ static void virtqueue_disable_cb_split(struct virtqueue *_vq)
 
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
@@ -1544,8 +1552,16 @@ static void virtqueue_disable_cb_packed(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
-	if (vq->packed.event_flags_shadow != VRING_PACKED_EVENT_FLAG_DISABLE) {
+	if (!(vq->packed.event_flags_shadow & VRING_PACKED_EVENT_FLAG_DISABLE)) {
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
@@ -2063,12 +2079,6 @@ void virtqueue_disable_cb(struct virtqueue *_vq)
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
2.31.1


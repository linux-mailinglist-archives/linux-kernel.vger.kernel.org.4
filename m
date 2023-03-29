Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46CA76CD2D9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 09:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjC2HWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 03:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjC2HWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 03:22:23 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168D02701
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 00:21:58 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id z10so8713183pgr.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 00:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680074517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22LODKDRCsluZyudoWo7KCI2qd/LFxfCN6vG8QOiOSk=;
        b=jIH3tYV8tMb17FhEKUidOuK43R2XrhCOhz4acFM5RwkFPfneTZIxz4VaG+CARawzvE
         1v8oTZXIuurGyy3IXTH0UGn/bkfO1q25uloNiZirvRENta2d1Mc5ADobjmLsK/NEyN8z
         6OtK/sTs6QQNWGC1aPKsthQitcDhFL+qyme4KGGbLAN38kOt9zHplf3tNnI8XiPQdxva
         HckUb/tnmBFMaZEPEZgvf7Fcaj3pX5oP5GuyTBWDSICh1j+41b4575M4l3gWO3rs3xmw
         RVIFr7BFWPizV/jgABNKEijumeYj2UAmGiFnJ0bDzaOaecCd4av7znZEzSFtqpdb1HF5
         V5lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680074517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=22LODKDRCsluZyudoWo7KCI2qd/LFxfCN6vG8QOiOSk=;
        b=FrJrVCWpCZ50iqXB6WlAwggl+yQGcLXAJMKGeVPGAhMTFlv9ZzBckTZYuHGh+TFsHZ
         /KK5axCFtZnkF3zQLxrI4It++wA9IWehBrMpQ09ERODf0T0+4aCcBEdWtIRbwm3/8Jwg
         XlPJkvXwC0X+3dhQhrYWuqBgH68xhC2hPP5SAh16VLTc6w2BGyihuzoC6dqZDZhR9ziM
         ye2912CXl5JdKhno3m6hKoKR+gtk0BNdwSA3VFu2jNCZBdhwzCihe1wp3sxsNiKBuUZq
         Il4w6iecJs5V8iAEMv/fMmitDWpQmQCHwLM48P+h14lTDyLRmePzeUAcqn3EUG/2x6ad
         Pryw==
X-Gm-Message-State: AAQBX9cb88sC4z9/UCZp3tneEj5ae4z/leFD/5Vn3QQSdfS0EApfoVyk
        G9Lmwwz8ST9BQs3uaJQJSHIDNg==
X-Google-Smtp-Source: AKy350aC0lnzGg7FkYWDAl2mwrPLTyo6splQEsyvEu0VZohXnoMfCQgEUBs6lUIKRFnPkIoXyC5SOQ==
X-Received: by 2002:a62:2581:0:b0:628:1b3:d499 with SMTP id l123-20020a622581000000b0062801b3d499mr16486470pfl.21.1680074517356;
        Wed, 29 Mar 2023 00:21:57 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id c11-20020aa781cb000000b0062d84986823sm5074319pfn.169.2023.03.29.00.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 00:21:56 -0700 (PDT)
From:   Albert Huang <huangjie.albert@bytedance.com>
To:     Jason Wang <jasowang@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>
Cc:     "huangjie.albert" <huangjie.albert@bytedance.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] virtio_ring: interrupt disable flag updated to vq even with event_triggered is set
Date:   Wed, 29 Mar 2023 15:21:35 +0800
Message-Id: <20230329072135.44757-1-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230329012908-mutt-send-email-mst@kernel.org>
References: <20230329012908-mutt-send-email-mst@kernel.org>
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


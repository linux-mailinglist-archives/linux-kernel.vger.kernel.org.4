Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86776C8D25
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 12:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjCYK5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 06:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjCYK5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 06:57:01 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBD714211
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 03:56:58 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id cu12so2742114pfb.13
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 03:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1679741818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tUmNpRj9iLzMHNJowxi+GGj1Iad+xEZ1rbuOVmNiyCg=;
        b=kTLmLyXDjAbBndnWWfzUnEBbt1RE+b1y2qZluTh30nWzWEZyjKSzgnyw47OvZABmJJ
         OH7ZINStV3QO8x7nL1JGCgKgepfs4Gy/lBGV/TT6r1yjM3xc4XMUWZQ/IzhjVijhVKN+
         4eVNtGGnLz+y481WGFU3Ni49jKNUTL+piHZrPU6QEhlUEInn01LYABPF0LJlsNuf3lPm
         AwfkBtV5HBMTMRaZnlkMRsJD66A78oROvWI8L87UligCFUtDXB+T2yyymx2UKRMWaIqh
         2E7LgbwbpNecC1RbHlidWP34pHuayTW4DdomLbwaWR1OcZdWsIfm8uxv0NqTCJkfjIj+
         iSMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679741818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tUmNpRj9iLzMHNJowxi+GGj1Iad+xEZ1rbuOVmNiyCg=;
        b=6wHiPhiGkXt8z4nZ1EP7xKZ7ebaVrVUBtQUH8NbPeHT+ykeaUm2F6je/mB5QhCdoLg
         Dxoor8xPIHKiSNFvMGqWt9Ubj19oqAc08zjp0l8naGQ/47uPkQ/2nCQkrox6GL/qdjFz
         CGWqQJTaz12GPiWy69N0IlplAH2BL/dTaFnI1q54rQumbIxmXq87cLGSH9n3pBZrDHRc
         U3aha63qL8bHl5wzeOoEIAhi1oxIdo44WE6hL22zL8mnEGvS6WbyV6xiQRXSNSoEJcFv
         rvmr6oULwZeZMEUcT+eWQWvTKZijf5aQXTrlxNdGW0zRTtTQr4kRuImRDl3f8Zs4p3Ld
         cpaA==
X-Gm-Message-State: AAQBX9ckjTVErga4dj1Eev02xrc4I9+5lr0VrbgcRydwZ0WZe/X/7L47
        y/QogflpPs8Adu9kZx1sopUJYEWNCBY2BjlBCXs=
X-Google-Smtp-Source: AKy350ZChY96HdPZmduKykfHZRNBNM0trwZ+XpWembGypweiMwDXvfCgeOhZ/2KZbomncbMrSmahpw==
X-Received: by 2002:a62:8496:0:b0:627:f659:a771 with SMTP id k144-20020a628496000000b00627f659a771mr6633520pfd.12.1679741817897;
        Sat, 25 Mar 2023 03:56:57 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id p21-20020aa78615000000b005dd98927cc5sm11206072pfn.76.2023.03.25.03.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 03:56:57 -0700 (PDT)
From:   Albert Huang <huangjie.albert@bytedance.com>
To:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Albert Huang <huangjie.albert@bytedance.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] virtio_ring: don't update event idx on get_buf
Date:   Sat, 25 Mar 2023 18:56:33 +0800
Message-Id: <20230325105633.58592-1-huangjie.albert@bytedance.com>
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

in virtio_net, if we disable the napi_tx, when we triger a tx interrupt,
the vq->event_triggered will be set to true. It will no longer be set to
false. Unless we explicitly call virtqueue_enable_cb_delayed or
virtqueue_enable_cb_prepare.

If we disable the napi_tx, it will only be called when the tx ring
buffer is relatively small.

Because event_triggered is true. Therefore, VRING_AVAIL_F_NO_INTERRUPT or
VRING_PACKED_EVENT_FLAG_DISABLE will not be set. So we update
vring_used_event(&vq->split.vring) or vq->packed.vring.driver->off_wrap
every time we call virtqueue_get_buf_ctx. This will bring more interruptions.

To summarize:
1) event_triggered was set to true in vring_interrupt()
2) after this nothing will happen for virtqueue_disable_cb() so
   VRING_AVAIL_F_NO_INTERRUPT is not set in avail_flags_shadow
3) virtqueue_get_buf_ctx_split() will still think the cb is enabled
   then it tries to publish new event

To fix, if event_triggered is set to true, do not update
vring_used_event(&vq->split.vring) or vq->packed.vring.driver->off_wrap

Tested with iperf:
iperf3 tcp stream:
vm1 -----------------> vm2
vm2 just receives tcp data stream from vm1, and sends the ack to vm1,
there are many tx interrupts in vm2.
but without event_triggered there are just a few tx interrupts.

Fixes: 8d622d21d248 ("virtio: fix up virtio_disable_cb")
Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
Message-Id: <20230321085953.24949-1-huangjie.albert@bytedance.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_ring.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index cbeeea1b0439..1c36fa477966 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -914,7 +914,8 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
 	/* If we expect an interrupt for the next entry, tell host
 	 * by writing event index and flush out the write before
 	 * the read in the next get_buf call. */
-	if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT))
+	if (unlikely(!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT) &&
+		     !vq->event_triggered))
 		virtio_store_mb(vq->weak_barriers,
 				&vring_used_event(&vq->split.vring),
 				cpu_to_virtio16(_vq->vdev, vq->last_used_idx));
@@ -1744,7 +1745,8 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
 	 * by writing event index and flush out the write before
 	 * the read in the next get_buf call.
 	 */
-	if (vq->packed.event_flags_shadow == VRING_PACKED_EVENT_FLAG_DESC)
+	if (unlikely(vq->packed.event_flags_shadow == VRING_PACKED_EVENT_FLAG_DESC &&
+		     !vq->event_triggered))
 		virtio_store_mb(vq->weak_barriers,
 				&vq->packed.vring.driver->off_wrap,
 				cpu_to_le16(vq->last_used_idx));
-- 
2.37.0 (Apple Git-136)


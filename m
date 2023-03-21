Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88216C2D6B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 10:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjCUJC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 05:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjCUJCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 05:02:38 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9A935ECF
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 02:00:54 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id mp3-20020a17090b190300b0023fcc8ce113so4504930pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 02:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1679389209;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b7WQ13znr3CN4XKk2kspE4hbceE3ioQVtB8Zu2USju8=;
        b=KmxEM5dn2jCC/nTRsrAfzPq82YzxBSOhtYw2Nl30BeA4kCmQ/z3QVVVjAN9LgjsqNy
         71HnsWGOIgYv+Y4wMLKI3VJvw/yydPfyYzEFkikTdy/Y7kVPkYMgZiVJhc1T+LsSGzli
         2LXawa0Y+MnBmMmtKLyO+62eYYktHMeBLcTW+Ka1hw5joUlHaW5psnZgywRtbS4Qs4DK
         f/xwH+H7SOPW8WIw7yLTPaFH8g7SNVxJ5RSq4QjNRKF/4Odrk4WYdMEGTKAtw4JlVrUZ
         vsS3uBcP13Ux3nK0DhJSLUXefAYpxJiKwpFPWyivHN6cJ11LZAuNq5MVPt5AbV73mFJC
         85rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679389209;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b7WQ13znr3CN4XKk2kspE4hbceE3ioQVtB8Zu2USju8=;
        b=FVxt7FYFTB/Br1g4IyHSvvN3GPrBP5iEp3SqMjUGyxX2k1djuPyNsKgrntOOHP23b8
         GK8600XXigiExU8C8Wi8c1A4jSpE060wxioSexUOq1d41pDVC0v0+qMIHLqzmZwvOe4t
         DxfrBB+zXKswOOPv3xBOPupiW7dis5plqzaC9KmasRNlTyRm3gxj46cDYVDjb0wkJdn3
         sO4q68UOkSxMdCsqYm3W7o/6Kt5jEiVhu0mcqbFChM2xhWf+bOJGeOu3OmIajiswbu6T
         AcqVlkShd4A5d5Q2AzIBN/kH1/XpX2RkL10Nz2tZaLZIErzCKovUjWSD6Q9nJuUebE0b
         VuRA==
X-Gm-Message-State: AO0yUKXf26VXowXeg0ZQ9jVFtV+iuSEYSRflaWlXjKMrXefUHitM0hJC
        DyHc5PgiKFlRd310zTIQa1Pre0G+hYPTzpUbzz4=
X-Google-Smtp-Source: AK7set/sZeqcabFkGQKy9nUl08cmT93CpV6W+gT5eaz8VVrZJqEgBsnsDyCKuWlFggRBDbjFAQkGVg==
X-Received: by 2002:a05:6a20:1a24:b0:da:b92c:a949 with SMTP id cj36-20020a056a201a2400b000dab92ca949mr1060077pzb.36.1679389208860;
        Tue, 21 Mar 2023 02:00:08 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id e15-20020a62ee0f000000b0058bacd6c4e8sm7586443pfi.207.2023.03.21.02.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 02:00:08 -0700 (PDT)
From:   Albert Huang <huangjie.albert@bytedance.com>
To:     "Michael S . Tsirkin " <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     "huangjie.albert" <huangjie.albert@bytedance.com>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO CORE AND
        NET DRIVERS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] virtio_ring: Suppress tx interrupt when napi_tx disable
Date:   Tue, 21 Mar 2023 16:59:53 +0800
Message-Id: <20230321085953.24949-1-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "huangjie.albert" <huangjie.albert@bytedance.com>

fix commit 8d622d21d248 ("virtio: fix up virtio_disable_cb")

if we disable the napi_tx. when we triger a tx interrupt, the
vq->event_triggered will be set to true. It will no longer be
set to false. Unless we explicitly call virtqueue_enable_cb_delayed
or virtqueue_enable_cb_prepare

if we disable the napi_tx, It will only be called when the tx ring
buffer is relatively small:
virtio_net->start_xmit:
	if (sq->vq->num_free < 2+MAX_SKB_FRAGS) {
		netif_stop_subqueue(dev, qnum);
		if (!use_napi &&
		    unlikely(!virtqueue_enable_cb_delayed(sq->vq))) {
			/* More just got used, free them then recheck. */
			free_old_xmit_skbs(sq, false);
			if (sq->vq->num_free >= 2+MAX_SKB_FRAGS) {
				netif_start_subqueue(dev, qnum);
				virtqueue_disable_cb(sq->vq);
			}
		}
	}
Because event_triggered is true.Therefore, VRING_AVAIL_F_NO_INTERRUPT or
VRING_PACKED_EVENT_FLAG_DISABLE will not be set.So we update
vring_used_event(&vq->split.vring) or vq->packed.vring.driver->off_wrap
every time we call virtqueue_get_buf_ctx.This will bring more interruptions.

if event_triggered is set to true, do not update vring_used_event(&vq->split.vring)
or vq->packed.vring.driver->off_wrap

Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
---
 drivers/virtio/virtio_ring.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 307e139cb11d..f486cccadbeb 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -795,7 +795,8 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
 	/* If we expect an interrupt for the next entry, tell host
 	 * by writing event index and flush out the write before
 	 * the read in the next get_buf call. */
-	if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT))
+	if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT)
+			&& (vq->event_triggered == false))
 		virtio_store_mb(vq->weak_barriers,
 				&vring_used_event(&vq->split.vring),
 				cpu_to_virtio16(_vq->vdev, vq->last_used_idx));
@@ -1529,7 +1530,8 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
 	 * by writing event index and flush out the write before
 	 * the read in the next get_buf call.
 	 */
-	if (vq->packed.event_flags_shadow == VRING_PACKED_EVENT_FLAG_DESC)
+	if (vq->packed.event_flags_shadow == VRING_PACKED_EVENT_FLAG_DESC
+			&& (vq->event_triggered == false))
 		virtio_store_mb(vq->weak_barriers,
 				&vq->packed.vring.driver->off_wrap,
 				cpu_to_le16(vq->last_used_idx));
-- 
2.31.1


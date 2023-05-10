Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70BD16FD3F6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 04:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235203AbjEJC5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 22:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjEJC5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 22:57:08 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2533030FF
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 19:56:42 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-643b7b8f8ceso3042328b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 19:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1683687401; x=1686279401;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hTSesuixdo5vZ8I9+v28R7iSHBf2PWhulvCTlSJ6srA=;
        b=AJvosUCnaL7DVrTLt0wEHVdYm9nezT1Xn8WsRYZ5yIuyP3499YqOnLadpQLSAn9yt2
         05U+onyUhUO0mNusq+LU34DX+jo3WaPD3xduRVgLNMAF77mNjHIkNOYFHbwMi2ZH2trk
         WPZ9SWFvn+9Oms0zV++Xge+Rah4vggZDy/1Uo3NnXa+zOnJLgi0MH0+/ob20TT8QWfu1
         +J9vUcfhAUXHBr43YbyXF3BjQRTXP98x9z9WWJpyRvW/zsSk21J5ZhzoJQPAtU2vN7IN
         xvHx8OiV3wiV9PenK6h+w2quENNK8h/hjJOEtp1BW6HfgIuiAPKYOvDkMTW2ow/8lFG0
         T2vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683687401; x=1686279401;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hTSesuixdo5vZ8I9+v28R7iSHBf2PWhulvCTlSJ6srA=;
        b=j4NY28Z1HqdLcqcacwLzargonPtf9TE/AHTbEwNWSJyEqJa5a8I501bojnrmYxiiLb
         ajkn7UQA+Mx1HGcztfcoJa3YZS1fNMRrxDJudStERpZHTYWJsGJBtx9Ioossp65X0/dm
         aGxisfeSGCwEJEZjrZeFwEsCVmH+ehUVBLOovetEIXvypyB7bz0BzsdFhqVR/QvqoXR5
         MkhdM/xp3vSKy7Zn6s5ZfBfbhP0zmj9Xj/HhDiW4nIWkME6Jmj6eWMWgM1FTXP7KOteV
         t00bWpDNVSVloxS54eS72lXiuadH/eFyLXfkr/hG8Cy0pV83m4+Mk3JMZdZPtmqP6xNP
         DSnA==
X-Gm-Message-State: AC+VfDxo9+Yql+hBblAXc9cxVn6M8XZQ41151RmpTVx/g4LIvi8tlkgt
        Akzhht9kEjv92CZffqnMr2K8Vw==
X-Google-Smtp-Source: ACHHUZ7epXyNWWiXW4YoeAFuCY/XUA4Zk4Pul30toUu70L0SWA9Ls5aa6OrepD3ODL0dvoiAKxTHbw==
X-Received: by 2002:a05:6a20:4421:b0:101:914e:da75 with SMTP id ce33-20020a056a20442100b00101914eda75mr3401063pzb.25.1683687401584;
        Tue, 09 May 2023 19:56:41 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.213.176.13])
        by smtp.gmail.com with ESMTPSA id h13-20020a63e14d000000b00524cfd635cesm2083080pgk.69.2023.05.09.19.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 19:56:41 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, xuanzhuo@linux.alibaba.com,
        zhenwei pi <pizhenwei@bytedance.com>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH] virtio_ring: use u32 for virtio_max_dma_size
Date:   Wed, 10 May 2023 10:54:37 +0800
Message-Id: <20230510025437.377807-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both split ring and packed ring use 32bits to describe the length of
a descriptor: see struct vring_desc and struct vring_packed_desc.
This means the max segment size supported by virtio is U32_MAX.

An example of virtio_max_dma_size in virtio_blk.c:
  u32 v, max_size;

  max_size = virtio_max_dma_size(vdev);  -> implicit convert
  err = virtio_cread_feature(vdev, VIRTIO_BLK_F_SIZE_MAX,
                             struct virtio_blk_config, size_max, &v);
  max_size = min(max_size, v);

There is a risk during implicit convert here, once virtio_max_dma_size
returns 4G, max_size becomes 0.

Fixes: e6d6dd6c875e ("virtio: Introduce virtio_max_dma_size()")
Cc: Joerg Roedel <jroedel@suse.de>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/virtio/virtio_ring.c | 12 ++++++++----
 include/linux/virtio.h       |  2 +-
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index c5310eaf8b46..55cfecf030a1 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -289,12 +289,16 @@ static bool vring_use_dma_api(const struct virtio_device *vdev)
 	return false;
 }
 
-size_t virtio_max_dma_size(const struct virtio_device *vdev)
+u32 virtio_max_dma_size(const struct virtio_device *vdev)
 {
-	size_t max_segment_size = SIZE_MAX;
+	u32 max_segment_size = U32_MAX;
 
-	if (vring_use_dma_api(vdev))
-		max_segment_size = dma_max_mapping_size(vdev->dev.parent);
+	if (vring_use_dma_api(vdev)) {
+		size_t max_dma_size = dma_max_mapping_size(vdev->dev.parent);
+
+		if (max_dma_size < max_segment_size)
+			max_segment_size = max_dma_size;
+	}
 
 	return max_segment_size;
 }
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index b93238db94e3..1a605f408329 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -147,7 +147,7 @@ int virtio_device_restore(struct virtio_device *dev);
 #endif
 void virtio_reset_device(struct virtio_device *dev);
 
-size_t virtio_max_dma_size(const struct virtio_device *vdev);
+u32 virtio_max_dma_size(const struct virtio_device *vdev);
 
 #define virtio_device_for_each_vq(vdev, vq) \
 	list_for_each_entry(vq, &vdev->vqs, list)
-- 
2.20.1


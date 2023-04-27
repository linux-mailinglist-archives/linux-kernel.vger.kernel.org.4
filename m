Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD986F0468
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 12:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243618AbjD0KrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 06:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243511AbjD0Kq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 06:46:57 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6755BA2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 03:46:29 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1a68f2345c5so65093275ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 03:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1682592389; x=1685184389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UsGPjHUd/JAVdo+0tuStqIz7Tm1YkeItSZg+vCTmFL0=;
        b=JM6o5QGGGy8NHFxp+jMI0o2BPvgkkxMoQh8Om3wlcmGZJIBWzdH5AqaRXvhfeXntHl
         lYsszsPCPSDD8e3ZtrvAG+A7zNYKunwG2xjdx5jMuvN61OoH8yJDRiQf5SSi9dQwYKNX
         +lYv8VegaYwV1GYDO3Lq1Wq6RwLjYoX4bFbkYCCbDqidd3kmyfH5mzUneklGWgrJTLmt
         npDQorgqDxoSrnzZ+fy9KNunE7iGzhUgrh6esipJgIRwmQnpnBZ7DT9yQmYG8iO2YV27
         I04Gkq3E6SPnFCzGO1/ZqnvyJMU+JMqPQB7jAH5jERK1l4en08l+ZnU5LtA4VziL3WbY
         eKWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682592389; x=1685184389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UsGPjHUd/JAVdo+0tuStqIz7Tm1YkeItSZg+vCTmFL0=;
        b=jTP8IxQQWKxUepSoSiGZEnjsoOmqCTpbZE3iZAUlK+uyg6dD8gJSp6LmzFf4gpFbvr
         0rLLvsuU7cg/aYUPdQBplVruj5hjv9GO9mp9N0NkMWCyO5cQxu8IZO52l/h0nkiMKjJ0
         j0ZUAO0OJWswkxD0sVR269iSw5GvJAfSmBQM98MbsgTkWa4aoBwCK0A/z0UKK9P2HBdP
         U3y8J8h5+P5GkpsECI61LjOf1qTUDMcCwaWdsZ0iC44p17FUM7QG2jpgdNTT3uNk14QV
         6aX0hVffQEHZ5B8xBa6I5/SJykJyYfgQQq29Li15vM7BVPppUsggNKq/VVCWC0nKPaZp
         J8ig==
X-Gm-Message-State: AC+VfDwf9jeNxYSKDvJ7cUxIaNYjyoBbM1hsqSB7JGa9lBsBYXskWB/8
        +7qxZxcDBaFLCeLPfiaBHfbNrf1ymqbZO9kKzUyI+A==
X-Google-Smtp-Source: ACHHUZ7Rw2wRiqnDQPcc6z1GD+UNLlLOHJb7RSzx0K1ocvv5G1bl79P10rGncGnyS0bTIFZb5ZwM8A==
X-Received: by 2002:a17:902:e807:b0:1a9:5d38:75e2 with SMTP id u7-20020a170902e80700b001a95d3875e2mr1155117plg.54.1682592389235;
        Thu, 27 Apr 2023 03:46:29 -0700 (PDT)
Received: from n137-048-144.byted.org ([121.30.179.80])
        by smtp.gmail.com with ESMTPSA id p1-20020a170902a40100b001a95c7742bbsm8376021plq.9.2023.04.27.03.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 03:46:28 -0700 (PDT)
From:   Wenliang Wang <wangwenliang.1995@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wenliang Wang <wangwenliang.1995@bytedance.com>
Subject: [PATCH v2] virtio_net: suppress cpu stall when free_unused_bufs
Date:   Thu, 27 Apr 2023 18:46:18 +0800
Message-Id: <20230427104618.3297348-1-wangwenliang.1995@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1682585517.595783-3-xuanzhuo@linux.alibaba.com>
References: <1682585517.595783-3-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For multi-queue and large ring-size use case, the following error
occurred when free_unused_bufs:
rcu: INFO: rcu_sched self-detected stall on CPU.

Signed-off-by: Wenliang Wang <wangwenliang.1995@bytedance.com>
---
v2:
-add need_resched check.
-apply same logic to sq.
---
 drivers/net/virtio_net.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index ea1bd4bb326d..573558b69a60 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3559,12 +3559,16 @@ static void free_unused_bufs(struct virtnet_info *vi)
 		struct virtqueue *vq = vi->sq[i].vq;
 		while ((buf = virtqueue_detach_unused_buf(vq)) != NULL)
 			virtnet_sq_free_unused_buf(vq, buf);
+		if (need_resched())
+			schedule();
 	}
 
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		struct virtqueue *vq = vi->rq[i].vq;
 		while ((buf = virtqueue_detach_unused_buf(vq)) != NULL)
 			virtnet_rq_free_unused_buf(vq, buf);
+		if (need_resched())
+			schedule();
 	}
 }
 
-- 
2.20.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4D06F62EF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 04:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjEDC1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 22:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjEDC1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 22:27:50 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57DB1B0
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 19:27:48 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-64374860853so24228b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 19:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1683167268; x=1685759268;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u+BgJuHtqJ6xHJQzKeFgk31WipZJ6dbt5GNbeuwFI6E=;
        b=SlMNXjdGsbfr6N9kkbZZeyQ43lxVvkoMsCd0YWIFya3W1IZe5rU7VOgbO3UVhc43eH
         g06ZGzXgN0/NNLgGmKCYkuKabXwfcBLb6i7HCPR7VLv9wm/uuuEi8bVqUBEhieYeRciB
         eaF7AVNvwHQCmhNhS72C+iUrCgVz3YOvhh3ZUTufEkG8kpdc6uu7+q7utraGNVEMZ6UO
         baw0GRKFuihvmQ51q1SoimeqotVxGOtqNlIKg/L2j0Q5AkI/wflyQ5Zo39dwKYwYDmD8
         j/l8qg936kNf89L9H4QGXmxUJZoRGpMuyQCLF1T+LbFmIxd38cdREerkfVUJr3uU8OYI
         yHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683167268; x=1685759268;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u+BgJuHtqJ6xHJQzKeFgk31WipZJ6dbt5GNbeuwFI6E=;
        b=GZO01k6SMssPptlpTWSOmea0RXW9yJmiNNs/zdIbehGU0PY3aGNRa1i0EASQYYMfql
         jV7SMrTwaTsjDYP3CTAXtpcbE2P+nrAW+T8WTliPLkls4iBhJfuMomnphZkv2JxxgYzQ
         5mVBhKuxTlAfvpXhNyLHybLB0kMdjEUC6+SMS2HwH5hzBqv9cD9SlKpYoIzX60m2Cp/e
         FvYjWU5HazXXn0xHz2jRNyx5XY/++aFBg57sbl7pfmrpjvDjhtRRwOiGNYNx8OEiMS0P
         QOk4Jq32GnrS50JkJThK1O7bs1c2n8yZE6uZeVlsE+aaMRZTzceRvPKtegSH4qEQlsda
         ptbA==
X-Gm-Message-State: AC+VfDynTN5GX0wF7K8fwpFXlwFPsElQu/YXsuVH0KNXdBHxDA5g10Ho
        eMEb7VmtVZDtKyd4mP3/LA3y9w==
X-Google-Smtp-Source: ACHHUZ66w6gN6afzXEUhNGIYJlXlkcmFTjIO96e8ArI9LnEnVDhNQ8YF+0PLg9M1pCuReLWyEeRgIQ==
X-Received: by 2002:a05:6a00:2d0b:b0:641:a6d:46b0 with SMTP id fa11-20020a056a002d0b00b006410a6d46b0mr849513pfb.22.1683167268316;
        Wed, 03 May 2023 19:27:48 -0700 (PDT)
Received: from localhost.localdomain ([2408:8207:2421:6760:ecda:417a:920f:8647])
        by smtp.gmail.com with ESMTPSA id c16-20020a62e810000000b00643355ff6a6sm1911751pfi.99.2023.05.03.19.27.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 May 2023 19:27:47 -0700 (PDT)
From:   Wenliang Wang <wangwenliang.1995@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        zhengqi.arch@bytedance.com, willemdebruijn.kernel@gmail.com
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, xuanzhuo@linux.alibaba.com,
        Wenliang Wang <wangwenliang.1995@bytedance.com>
Subject: [PATCH v4] virtio_net: suppress cpu stall when free_unused_bufs
Date:   Thu,  4 May 2023 10:27:06 +0800
Message-Id: <1683167226-7012-1-git-send-email-wangwenliang.1995@bytedance.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For multi-queue and large ring-size use case, the following error
occurred when free_unused_bufs:
rcu: INFO: rcu_sched self-detected stall on CPU.

Fixes: 986a4f4d452d ("virtio_net: multiqueue support")
Signed-off-by: Wenliang Wang <wangwenliang.1995@bytedance.com>
---
v2:
-add need_resched check.
-apply same logic to sq.
v3:
-use cond_resched instead.
v4:
-add fixes tag
---
 drivers/net/virtio_net.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 8d8038538fc4..a12ae26db0e2 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3560,12 +3560,14 @@ static void free_unused_bufs(struct virtnet_info *vi)
 		struct virtqueue *vq = vi->sq[i].vq;
 		while ((buf = virtqueue_detach_unused_buf(vq)) != NULL)
 			virtnet_sq_free_unused_buf(vq, buf);
+		cond_resched();
 	}
 
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		struct virtqueue *vq = vi->rq[i].vq;
 		while ((buf = virtqueue_detach_unused_buf(vq)) != NULL)
 			virtnet_rq_free_unused_buf(vq, buf);
+		cond_resched();
 	}
 }
 
-- 
2.20.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C546F2544
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 17:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjD2Psu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 11:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbjD2Pss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 11:48:48 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0716D172E
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 08:48:23 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-63b4960b015so760462b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 08:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1682783302; x=1685375302;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9P2mZM7ci2Xw5rF6VxKlkFONlC9SOUfJRYGLbDsm7w=;
        b=EPryO+NxFUtz9gXpD8UMe0U5isNA42gRV9JOeOHlwB4AGQBAibZPgaE4LOrecks1QL
         l6wz6P04lHKe6XUTwN/Pkwuil/ZsU3QoZX+gYMOtX7ZGSMuRt4TAwZDHkrCVAEPEK/oh
         wZDAX7L9z9uxy7K/e66iA62dFXPjPFZUy6bYI1eCHuCEYgPf4VUE5lFazVEYRpYq1lz8
         y3yL9gaixAd4XjG3pEFuHOV76sSDkLIUDyxiOxZhgaxOghBTMw1wY1zphhp2Gi0m6qdz
         Cpca1ksWQcuzs7oDyUYGnYZzvpR7FpHj9yrvoMaCnLeX3JXWcYm2z4Aiwpp5lvaNtqbd
         OD+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682783302; x=1685375302;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+9P2mZM7ci2Xw5rF6VxKlkFONlC9SOUfJRYGLbDsm7w=;
        b=d6jUb/TDLo7ib97Tx4hvPLEFfWtymcJd/C/0AMLRDm22XZp7ACdrJBauetF8s+e3a2
         ef+UOKjIxXPp0g3zOH60AxvqEE/qZwiN694I6tAlDYE//DIT8QQjE97fWJe+OKMklZrN
         op2J7AVn2XgfJKksgH8slzAMWV3O68RmCd9GOHOFGnfYyGKeHo0cbDAHIJsr087NS71n
         2GuDm/34vyfSz8dHZyEWIFLzxwPn3+9U+J2M/2btFuuNDijjH8hG2iP676fdxaFHw9l+
         25P5zG5rau82AfuIAKqTNUlPctWgRDLYOtG2unm7xisJtB3OGRCjUNDPqqPG2u0VRKXB
         XL3A==
X-Gm-Message-State: AC+VfDybp6Z0EMWHrFoL6NjiCZl8iKpuql+mpBeotfFQjySwj0Y8nnQ8
        2Wf+ittgpEl/jF/Ouzm2Tc3Qjw==
X-Google-Smtp-Source: ACHHUZ53Fj9h6nZ4V5lFVpFEXCq+C8z+ue/01AyizM4xlHjhyXzWh1UbrK6VxXY1/kvtAHXIsCZDMg==
X-Received: by 2002:a05:6a00:1515:b0:640:e12a:3a20 with SMTP id q21-20020a056a00151500b00640e12a3a20mr13492262pfu.1.1682783302499;
        Sat, 29 Apr 2023 08:48:22 -0700 (PDT)
Received: from localhost.localdomain ([2408:8207:2423:d60:94ce:3d97:123:5b2c])
        by smtp.gmail.com with ESMTPSA id c17-20020a056a000ad100b005ae02dc5b94sm17170554pfl.219.2023.04.29.08.48.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Apr 2023 08:48:22 -0700 (PDT)
From:   Wenliang Wang <wangwenliang.1995@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        zhengqi.arch@bytedance.com, willemdebruijn.kernel@gmail.com
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wenliang Wang <wangwenliang.1995@bytedance.com>
Subject: [PATCH v3] virtio_net: suppress cpu stall when free_unused_bufs
Date:   Sat, 29 Apr 2023 23:47:58 +0800
Message-Id: <1682783278-12819-1-git-send-email-wangwenliang.1995@bytedance.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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
v3:
-use cond_resched instead.
---
 drivers/net/virtio_net.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index ea1bd4bb326d..744bdc8a1abd 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3559,12 +3559,14 @@ static void free_unused_bufs(struct virtnet_info *vi)
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


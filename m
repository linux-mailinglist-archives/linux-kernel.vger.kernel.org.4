Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C564865DD65
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 21:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbjADUIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 15:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239774AbjADUIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 15:08:24 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F6811C19
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 12:08:00 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id 192so37827653ybt.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 12:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2BpLJr+Yx20N63OuZrSWnIJ9uSTdI4PPQVV/gfLgc40=;
        b=vs1GwV9bxf64lqjj/kWvqmFvLa5RwKxJQjA+1MM3wf+kil0DBTiNIORB1SIX4ygP2q
         6Nu6hRI2Zs3pz/GM/o+36qzYKRUC+2Bd+sKabdsgPqb/y9VmZ1SOp5USxQEL42q3pszY
         LjK7fLpc5NvfNQB55DhII+BhROuse6DWGK0nBt+QYZiZKa5VTBkei3jUu68WvsYAV2mF
         uT/tWIZXRyStlf14YidBHKu2AgduaI9YIjTbB25Ia0JO2CFjZ5HMUFmfjswlxvEP9WRJ
         bdI5fDnkrV+TViJ/vdAZZz1toV4xoOUICM4dAhAByjVVh8ZMB6xAE+S2PTAY2AQnBbke
         LRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2BpLJr+Yx20N63OuZrSWnIJ9uSTdI4PPQVV/gfLgc40=;
        b=OqE6fbF2bLXHXR8cMVeRMXwEXPvMG8mkpnBqhwFd/01B6+7wkjVgh7zW6WH67+io17
         S2r8FmJ+T6Duqdbd27ftQrNx8hLtXGSW9J9h6nuJTVNlFJ0+d1F7hMZh6kgCUgqAXXta
         fgujF/gxpjLklI3VUPEMG1sLrnZdRQQ/rQcAWy8LzQooFGUxKMxHUMPhED2Ze89PUjSJ
         PC0FJlw17Nsfuskl92ckw66DSnmtwtrtColqOmeNDDKWlvs7nIaX6nvZAJiFOWn9AsUF
         rUzvTJJCi64oQye5r5fKszTpI3N6EYhmXR6SRDeKaa/yd4oNRwSfog8LkoeNh+UGUoXs
         DwTQ==
X-Gm-Message-State: AFqh2krab/7Lt6U5xvxdSFLgxKLG25rWMzrnML0EC/eb/AvoheT3v3to
        SeI6KblU6G1f0bquhOCQK4RF9A==
X-Google-Smtp-Source: AMrXdXvFnWP23hqMJnFc9ic6gBF8u9t2DcaJ0f48JU7N8FSqvoH8H/OOJ+2VkMhZwxOV5LIvfK/N5Q==
X-Received: by 2002:a5b:b8f:0:b0:79b:4165:c8ce with SMTP id l15-20020a5b0b8f000000b0079b4165c8cemr12978682ybq.14.1672862879914;
        Wed, 04 Jan 2023 12:07:59 -0800 (PST)
Received: from n217-072-012.byted.org ([147.160.184.123])
        by smtp.gmail.com with ESMTPSA id bs32-20020a05620a472000b007049f19c736sm24551707qkb.7.2023.01.04.12.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 12:07:59 -0800 (PST)
From:   Bobby Eshleman <bobby.eshleman@bytedance.com>
Cc:     Bobby Eshleman <bobbyeshleman@gmail.com>,
        Bobby Eshleman <bobby.eshleman@bytedance.com>,
        Cong Wang <cong.wang@bytedance.com>,
        Jiang Wang <jiang.wang@bytedance.com>,
        Krasnov Arseniy <oxffffaa@gmail.com>,
        syzbot+30b72abaa17c07fe39dd@syzkaller.appspotmail.com,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Abeni <pabeni@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] vhost/vsock: check length in rx header
Date:   Wed,  4 Jan 2023 20:06:41 +0000
Message-Id: <20230104200642.4071622-1-bobby.eshleman@bytedance.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check that the rx packet length indicated by the header does not exceed
the iov length.

Fixes: b68396fad17f ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")
Reported-by: syzbot+30b72abaa17c07fe39dd@syzkaller.appspotmail.com
Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
---
 drivers/vhost/vsock.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 982ca479c659..84dec9ac62c1 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -365,8 +365,9 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
 	if (!payload_len)
 		return skb;
 
-	/* The pkt is too big */
-	if (payload_len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE) {
+	/* The pkt is too big or the length in the header is invalid */
+	if (payload_len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE ||
+	    payload_len > len) {
 		kfree_skb(skb);
 		return NULL;
 	}
-- 
2.20.1


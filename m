Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D957620D71
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 11:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233966AbiKHKf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 05:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233922AbiKHKfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 05:35:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4A54090E
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 02:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667903685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jnEQ/6uclYdSedN00zhcPF82VnGpN8n10b9g5MbTnn0=;
        b=CVy8Xvpd6yVBllRxXHMwaZkOzymHzFbHcH6mapNZQS5O62Ey4U0Mmo5Rj1gOsyGgXjB9k9
        cJNZl9WvQ2J8mp4tIEltPFPdga97qUKKxexRZPX9jlga75qDq7Zc+OCH1Yf6cRP3noy/fp
        GE6AF5u3m5RVsVfWbIwkz2wanUZR94s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-660-hAtSb8RlMvKGWA-X2JbZ-A-1; Tue, 08 Nov 2022 05:34:43 -0500
X-MC-Unique: hAtSb8RlMvKGWA-X2JbZ-A-1
Received: by mail-wr1-f72.google.com with SMTP id j25-20020adfa559000000b0023d5d7f95a2so2269367wrb.21
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 02:34:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jnEQ/6uclYdSedN00zhcPF82VnGpN8n10b9g5MbTnn0=;
        b=qQvfEGz3XXcTAcfJL5remhy+m0l7Zil4yrkDXEGFspInokgUnSh9LQQQV3YXUzE/Zw
         A5fQ1ZvbtTCqF9FeiB5LnUmXJU2D7Ngf/LXdVAfB9kHd1hx12pb8PqzAIupmN6XEfl/b
         jSFuhqMKjy9YT56mCRslpMRvTuXn5wjfdH80MjJ5T8Haf9DsLUR1bnNDhO52mXOyunnS
         V/1gLvL4P/qL1sazsUbQmQoucB2YydpkyQOGU/HPCVq9YEKglDJ+fuGKrC7G21iAbM/G
         m3i+Loxzf5wDGDeH5hg/PIeSh7WxnjiwABCZt27N/YMknVa3m1XsH2/UQmtNuGmGM9RM
         aiDw==
X-Gm-Message-State: ACrzQf0jnsLpDlaiSw1kFWK0pPJfFTJpl4Dha3cXGtrnJkA1/AHrJe5P
        QpFEquKxPbY2vIlsHFfqw/LMEfZikAQI1aXadpoa1tT5Ri+lWRj4CQ7qe8T9HApMzZIqph1f5Qt
        0yl0CMBZiSdfjvbveQQVJm4om
X-Received: by 2002:adf:f303:0:b0:236:d1c0:79dc with SMTP id i3-20020adff303000000b00236d1c079dcmr29615256wro.695.1667903682489;
        Tue, 08 Nov 2022 02:34:42 -0800 (PST)
X-Google-Smtp-Source: AMsMyM60F4oRwRyS4YKIr5SpakIIdGyqUKYKutX+9xZI1DBbeFzrSYNiUGX7Pq6GFACc6ESaUV3XiQ==
X-Received: by 2002:adf:f303:0:b0:236:d1c0:79dc with SMTP id i3-20020adff303000000b00236d1c079dcmr29615240wro.695.1667903682285;
        Tue, 08 Nov 2022 02:34:42 -0800 (PST)
Received: from step1.redhat.com (host-82-53-134-234.retail.telecomitalia.it. [82.53.134.234])
        by smtp.gmail.com with ESMTPSA id m11-20020a5d4a0b000000b0022ca921dc67sm9632802wrq.88.2022.11.08.02.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 02:34:41 -0800 (PST)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 2/2] vhost: fix range used in translate_desc()
Date:   Tue,  8 Nov 2022 11:34:37 +0100
Message-Id: <20221108103437.105327-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221108103437.105327-1-sgarzare@redhat.com>
References: <20221108103437.105327-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vhost_iotlb_itree_first() requires `start` and `last` parameters
to search for a mapping that overlaps the range.

In translate_desc() we cyclically call vhost_iotlb_itree_first(),
incrementing `addr` by the amount already translated, so rightly
we move the `start` parameter passed to vhost_iotlb_itree_first(),
but we should hold the `last` parameter constant.

Let's fix it by saving the `last` parameter value before incrementing
`addr` in the loop.

Fixes: 0bbe30668d89 ("vhost: factor out IOTLB")
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---

I'm not sure about the fixes tag. On the one I used this patch should
apply cleanly, but looking at the latest stable (4.9), maybe we should
use

Fixes: a9709d6874d5 ("vhost: convert pre sorted vhost memory array to interval tree")

Suggestions?
---
 drivers/vhost/vhost.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 40097826cff0..3c2359570df9 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2053,7 +2053,7 @@ static int translate_desc(struct vhost_virtqueue *vq, u64 addr, u32 len,
 	struct vhost_dev *dev = vq->dev;
 	struct vhost_iotlb *umem = dev->iotlb ? dev->iotlb : dev->umem;
 	struct iovec *_iov;
-	u64 s = 0;
+	u64 s = 0, last = addr + len - 1;
 	int ret = 0;
 
 	while ((u64)len > s) {
@@ -2063,7 +2063,7 @@ static int translate_desc(struct vhost_virtqueue *vq, u64 addr, u32 len,
 			break;
 		}
 
-		map = vhost_iotlb_itree_first(umem, addr, addr + len - 1);
+		map = vhost_iotlb_itree_first(umem, addr, last);
 		if (map == NULL || map->start > addr) {
 			if (umem != dev->iotlb) {
 				ret = -EFAULT;
-- 
2.38.1


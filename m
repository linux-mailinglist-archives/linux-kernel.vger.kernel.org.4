Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E12624404
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 15:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbiKJOPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 09:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiKJOOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 09:14:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710E2FD15
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 06:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668089631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=EGdeBqZHdvW6TGtz0bzuryVKHsywKrh20LlxuiZOelI=;
        b=b8dwHhiMkkgH0Ibj+9bDLY8AihyPeEXpAjNnQ5J44dGQ7EFjkv/V3vrDdDZvIXmJETfp4P
        CIKBpDNBV2fs/cuf4X1cPje8cCkp+Y5XQUQCT8elmvVn4oK2Y+0uFbStc369AVdmRnlc3U
        jgMOFrdPrhiVYhyuEN9UnXdi4ZnyI+o=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-196-I9jTOKIpPQuvOR7sX9yOog-1; Thu, 10 Nov 2022 09:13:50 -0500
X-MC-Unique: I9jTOKIpPQuvOR7sX9yOog-1
Received: by mail-pj1-f71.google.com with SMTP id n4-20020a17090a2fc400b002132adb9485so1190654pjm.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 06:13:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EGdeBqZHdvW6TGtz0bzuryVKHsywKrh20LlxuiZOelI=;
        b=bZnMr4GN6Nz2AuoMyd8+SP7SVAafrKedIcZHUDGwRnmIcO1o5w2Pu8X6rxhlgEeNiJ
         qS9GI8pkdcv5wcJOyl21eXIypd1tjjqWn/z7+DO/0ZKS8AxN2uuMyxvCHSw88jPdiP7r
         SW36UMJD2pSd9B6TlYUBJy3yzsmjepgEr9+BXI24kZiaT26Wsy3a7F7y6Iy/7H6Zq2wJ
         Worv5uEMsPoqpqNpMTcIWzKGbAl9/Ca0zV8i9QnK1UijyI1dg5rWIqv3zgJ/L4y4I4mm
         THuXrxn669Av50KeK81AD3jDZTmgzhVeRnBrPaA5B8xhGiE27dNGbsuFgTFMdwbbG9UW
         LuHQ==
X-Gm-Message-State: ACrzQf0+FiipXrfmU1kGbs0JTZ+VR0JaXUtB4W+fhTBghgsPgRcnZ7WW
        Gy9dhVgnFR9DBCOiN+g+FYAoj1rt3412rGdZwgdyks2DUJRUiKexHSVSeXpVWbzB642mVCOUl0z
        NlLRqpyOSweg/RsvFiULYU4ko
X-Received: by 2002:a17:902:ccc2:b0:178:29f9:5c5e with SMTP id z2-20020a170902ccc200b0017829f95c5emr62089268ple.21.1668089628823;
        Thu, 10 Nov 2022 06:13:48 -0800 (PST)
X-Google-Smtp-Source: AMsMyM4pTVwwwoLGWtQena1F0pLzfeP30NWs5AAYEwbAd4Bo+neGArXMZ1NL4blW72ZgkwHqxgCYsw==
X-Received: by 2002:a17:902:ccc2:b0:178:29f9:5c5e with SMTP id z2-20020a170902ccc200b0017829f95c5emr62089242ple.21.1668089628429;
        Thu, 10 Nov 2022 06:13:48 -0800 (PST)
Received: from step1.redhat.com (host-82-53-134-234.retail.telecomitalia.it. [82.53.134.234])
        by smtp.gmail.com with ESMTPSA id o24-20020aa79798000000b0056a7486da77sm10503973pfp.13.2022.11.10.06.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 06:13:47 -0800 (PST)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        Eugenio Perez Martin <eperezma@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH] vdpa_sim: fix vringh initialization in vdpasim_queue_ready()
Date:   Thu, 10 Nov 2022 15:13:35 +0100
Message-Id: <20221110141335.62171-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we initialize vringh, we should pass the features and the
number of elements in the virtqueue negotiated with the driver,
otherwise operations with vringh may fail.

This was discovered in a case where the driver sets a number of
elements in the virtqueue different from the value returned by
.get_vq_num_max().

In vdpasim_vq_reset() is safe to initialize the vringh with
default values, since the virtqueue will not be used until
vdpasim_queue_ready() is called again.

Fixes: 2c53d0f64c06 ("vdpasim: vDPA device simulator")
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index b071f0d842fb..b20689f8fe89 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -67,8 +67,7 @@ static void vdpasim_queue_ready(struct vdpasim *vdpasim, unsigned int idx)
 {
 	struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
 
-	vringh_init_iotlb(&vq->vring, vdpasim->dev_attr.supported_features,
-			  VDPASIM_QUEUE_MAX, false,
+	vringh_init_iotlb(&vq->vring, vdpasim->features, vq->num, false,
 			  (struct vring_desc *)(uintptr_t)vq->desc_addr,
 			  (struct vring_avail *)
 			  (uintptr_t)vq->driver_addr,
-- 
2.38.1


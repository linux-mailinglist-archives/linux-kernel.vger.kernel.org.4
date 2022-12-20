Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381F6651F9C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 12:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbiLTLYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 06:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiLTLYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 06:24:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A63C76
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 03:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671535431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=duDj4IDqPGRqUxwsqTLICchzA0MOp+dg3mI/1yy26NU=;
        b=PLiMmNGfst+HEbzeqfEVa1fMis3s4DiewpR8L/vWhygpk7upUM8en7GOSIIsCNhQeajLAz
        9g2gtcTeYfTypFOyi1oWoQuuGFlN58OQ8EQR6xvbTDt6Z8/1ib3LYGnDQgHLQpdmQECxio
        3XMOsqdZdTlZjz9RFbC+g3mejmYbars=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-589-5vbdsJVkOKu6YDv5ovZcVQ-1; Tue, 20 Dec 2022 06:23:51 -0500
X-MC-Unique: 5vbdsJVkOKu6YDv5ovZcVQ-1
Received: by mail-qv1-f70.google.com with SMTP id m4-20020ad44484000000b004c78122b496so6988832qvt.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 03:23:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=duDj4IDqPGRqUxwsqTLICchzA0MOp+dg3mI/1yy26NU=;
        b=fgKm+YPU00mOk0GpBccaudh5/J0/fYmfcWGN5E0HstgVIEMf3UlPeUSgxEqAzpsz/q
         b77kwbKM8k7FXhR32gDniM3LCOxh53guCyJgmQb1o7QCcigAgxu8/s1qUGIkv2VBGZuN
         SfUOzd/GAvq9exFu6Y7mJ6NFXKTLPGfVpRSd3N1YvGzPDNpp8B/cdOZVJtJA/tNtcQeQ
         p24OtrilKAqBr+VVlEOuzt9Zir3jw33ezJ9USS8teXyLZ+aLsg17yFMf0fwrHvifhceG
         JhNGeCu3Snz/9/arUTIP7QlmqG2G21zOcVNd04rVoYfKsXjaDMSUwtGgeBa/rc+fCXYO
         fwmA==
X-Gm-Message-State: ANoB5pkTPm+lYFxxlR0Dq2ozk0epVt0Arn2/wmLolc/SQFslqRnkeIaX
        hRnFoKnVsRp2bwYSUC6ZkZO1U4Jn9b0VKfg6TsJfY1UfUat/Ob5QS18AfHnd7zryuuLK8jsh5QI
        qLujUHxzR6rtPTIRxHr3xOIr04WKvSLkLW6y1t9EmhpZtEeV68kaQxOeZHgdTLa/i6y7AgA==
X-Received: by 2002:a05:622a:248c:b0:39c:da20:f700 with SMTP id cn12-20020a05622a248c00b0039cda20f700mr61864408qtb.36.1671535430307;
        Tue, 20 Dec 2022 03:23:50 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4bP41rEY68a1GRVkDxLGY+6MlclsHX3KN6pGPekhSNI+eQBndsuGUO2k0JwSQpg38SoIdbVg==
X-Received: by 2002:a05:622a:248c:b0:39c:da20:f700 with SMTP id cn12-20020a05622a248c00b0039cda20f700mr61864385qtb.36.1671535429995;
        Tue, 20 Dec 2022 03:23:49 -0800 (PST)
Received: from redhat.com ([37.19.199.118])
        by smtp.gmail.com with ESMTPSA id w8-20020a05620a444800b006fc92cf4703sm8722506qkp.132.2022.12.20.03.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 03:23:49 -0800 (PST)
Date:   Tue, 20 Dec 2022 06:23:44 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: [PATCH] virtio-blk: fix probe without CONFIG_BLK_DEV_ZONED
Message-ID: <20221220112340.518841-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building without CONFIG_BLK_DEV_ZONED, VIRTIO_BLK_F_ZONED
is excluded from array of driver features.
As a result virtio_has_feature panics in virtio_check_driver_offered_feature
since that by design verifies that a feature we are checking for
is listed in the feature array.

To fix, replace the call to virtio_has_feature with a stub.

Tested-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/block/virtio_blk.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 88b3639f8536..5ea1dc882a80 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -760,6 +760,10 @@ static int virtblk_probe_zoned_device(struct virtio_device *vdev,
 	return ret;
 }
 
+static inline bool virtblk_has_zoned_feature(struct virtio_device *vdev)
+{
+	return virtio_has_feature(vdev, VIRTIO_BLK_F_ZONED);
+}
 #else
 
 /*
@@ -775,6 +779,11 @@ static inline int virtblk_probe_zoned_device(struct virtio_device *vdev,
 {
 	return -EOPNOTSUPP;
 }
+
+static inline bool virtblk_has_zoned_feature(struct virtio_device *vdev)
+{
+	return false;
+}
 #endif /* CONFIG_BLK_DEV_ZONED */
 
 /* return id (s/n) string for *disk to *id_str
@@ -1480,7 +1489,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 	virtblk_update_capacity(vblk, false);
 	virtio_device_ready(vdev);
 
-	if (virtio_has_feature(vdev, VIRTIO_BLK_F_ZONED)) {
+	if (virtblk_has_zoned_feature(vdev)) {
 		err = virtblk_probe_zoned_device(vdev, vblk, q);
 		if (err)
 			goto out_cleanup_disk;
-- 
MST


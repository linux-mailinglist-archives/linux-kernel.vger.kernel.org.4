Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B371A653220
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 15:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbiLUOAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 09:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiLUOAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 09:00:20 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025E2F58B;
        Wed, 21 Dec 2022 06:00:20 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id i187-20020a1c3bc4000000b003d1e906ca23so1601108wma.3;
        Wed, 21 Dec 2022 06:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nkgr/PILpuVC3sCWYta0XXo8hnwU8RgWZjFpRgXAELg=;
        b=nsIQjMlh47JuKX0YRjs58BTfW1aBQ7t5ZpnD/DFRfzGo5NBhsoW9TqyXb1I4m7pgJz
         7gwgdDC8ybyqdZYc3oI1t4qIXXm11MsB9Wnw0++hgtJIgfn0O5Omzdl/VLpn+LJlNaCR
         MLwsTeF9OqoFAPRpZU8yGNBJMdO5YuAIWj3zCzROLJESoeAdWwvEZilLucSAWglY+bv9
         Gy0xn4Iv13/jCUtx2Bus2T4E90w3JWoXJ4aepFVAJkGthrGrdmigii0k207784ouqokB
         qCZRkdfhzTVykbbjlBDk5mD/IJ0mNi8zxZr2DyKF8EnIHuaeDD2RuJ/xhyckg6m39ke3
         efhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nkgr/PILpuVC3sCWYta0XXo8hnwU8RgWZjFpRgXAELg=;
        b=Yxzz7vrfVzDIEXQY2puBa02OHvkklGl88SksYi5FsCeMAdEgBnxqN7W/sjlixlVpdF
         x1tp9brDuN1l7yJaC5ihDZyPFKC8Yerr7z3wIozIhF1e0EsJTsQ9kERwT5ViQBZzvDOa
         8TpwP68xIrChQTf4zI5GfzSl8pJBMwaOczmoALcvEQ1GYOd73PRt0IvLDkR1U9Jul5LU
         yDxkdqzb3yNPONvamhQ3P1kiKj6SkVA59Hr3SybU+Vy423kG9DM7IsN1GUI2wRCLV7DX
         f4qXhYlI810f760ZM5lXKIy5XTvziZHdO6EmZa9huVMokD77YJiJEtsCcIxxXQ1IZwSn
         8frg==
X-Gm-Message-State: AFqh2koUhPkD+HX2r2WFEIpkMANhi3jquY5EHKyhLm8yi6PtOgbfc9SM
        j3ndlfAUMCVLiez26mCC4dsSlB5eCsk=
X-Google-Smtp-Source: AMrXdXtVfkIkIQra855/evVr+dkD00oysXSW/o0GiRK6c0X7b8rmOCfRryGzxGQdYcEv7gtbzjJKvw==
X-Received: by 2002:a05:600c:2252:b0:3d3:5d8b:7af with SMTP id a18-20020a05600c225200b003d35d8b07afmr1882310wmm.41.1671631218074;
        Wed, 21 Dec 2022 06:00:18 -0800 (PST)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id c12-20020a05600c0a4c00b003cfa3a12660sm7243731wmq.1.2022.12.21.06.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 06:00:17 -0800 (PST)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-block@vger.kernel.org,
        Dmitry Fomichev <dmitry.fomichev@wdc.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>,
        Sam Li <faithilikerun@gmail.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH] virtio-blk: avoid kernel panic on VIRTIO_BLK_F_ZONED check
Date:   Wed, 21 Dec 2022 14:00:12 +0000
Message-Id: <20221221140012.238494-1-lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

virtio zoned block device support is added by commit 0562d7bf1604
("virtio-blk: add support for zoned block devices") which adds
VIRTIO_BLK_F_ZONED to the features array in virtio_blk.c but makes it
conditional on CONFIG_BLK_DEV_ZONED.

In it virtblk_probe() calls virtio_has_feature(vdev, VIRTIO_BLK_F_ZONED)
unconditionally, which invokes virtio_check_driver_offered_feature().
This function checks whether virtio_blk.feature_table (assigned to
the static features array) contains the specified feature enum, and if not
_causes a kernel panic_ via BUG().

This therefore means that failing to enable CONFIG_BLK_DEV_ZONED while
using virtio is a guaranteed kernel panic. Fix the issue by making the
feature test also conditional on CONFIG_BLK_DEV_ZONED.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 drivers/block/virtio_blk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index ff49052e26f7..34fdc141fb21 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1580,11 +1580,13 @@ static int virtblk_probe(struct virtio_device *vdev)
 	virtblk_update_capacity(vblk, false);
 	virtio_device_ready(vdev);

+#ifdef CONFIG_BLK_DEV_ZONED
 	if (virtio_has_feature(vdev, VIRTIO_BLK_F_ZONED)) {
 		err = virtblk_probe_zoned_device(vdev, vblk, q);
 		if (err)
 			goto out_cleanup_disk;
 	}
+#endif /* CONFIG_BLK_DEV_ZONED */

 	dev_info(&vdev->dev, "blk config size: %zu\n",
 		sizeof(struct virtio_blk_config));
--
2.39.0

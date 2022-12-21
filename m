Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDB66532BF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 15:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbiLUOym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 09:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232603AbiLUOyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 09:54:39 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373F823BC7;
        Wed, 21 Dec 2022 06:54:39 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id a17so14037000wrt.11;
        Wed, 21 Dec 2022 06:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VMbqxbuRDI+bCHOQmmEigjmorE48SzrkTJ2QBJ9psbw=;
        b=OwIu9F/cBLhbKMRhGmr28+guDrzEqJEdYIsn3wOqorLhX0ELMhTZ/4XoY9rioKoMlS
         Gldhfzx1XURJNyJo9hXBciy1ugOko36X7jDbcy+TDSysr2yaA6TKAoK6Bhr4LWmSTHYh
         tcEKWIzKRAmF4EuAcVtaTGemJb7XcrGunLfR9XNwetRAeinATsWzhOibchnerN+qYpSo
         SEsUumoEFh8zdX9bLG6JWpYKwCAli6Kv+U/x9dM5FxmeOdx3Ajx9juB3icZEmrOyh51b
         J3g/7TboZj94UJRkGSZfzpt7IxI2JL3FyLf/s4D+zi6oeTH7u5FlLh7SPF3WsSU0WlPI
         H32Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VMbqxbuRDI+bCHOQmmEigjmorE48SzrkTJ2QBJ9psbw=;
        b=Y3Fw6SwKnpYB1lsfv+WVZyvy7sDx+wH7hAd6yltjNkjNK1e1ftNJKstCDgr99x9T9P
         Ov21F+N72b4kOOnSksFY9UrliyCWaMeLagUfIUzzgYjN/7K36xLkOq77I5Mu30iUWa2d
         ju2QGu5QtMK4hRERJFdfmn6XvnafVBDHGYiUA6P8NuSHiJrsJC2rzjJ4I9HBznuoTXjj
         n8SRK2epIwnWxuc+TwnX8rKzmc/TAMWVMRK/34ghbOldoMJht2dyrp5UW/+VTae76oG1
         v0wx9+vxImZ26IM88wteliB0E2i0UVLDIYhr9zZd3925CLnpjfHHkyojvlA4OTN0U0vH
         djlQ==
X-Gm-Message-State: AFqh2kq2DeY3oopUTahP2iknhke1oEgOchmhOZFu4BD8nsFW+YyDAoby
        xxj460WUD8wJatmTsh4MMbxPd1gEa1c=
X-Google-Smtp-Source: AMrXdXuZGI0m2k8KvdyfCEyIzio8FppBZ8Hp7bZKAoxqKYhfSY3s4jMM2e377/0wTYkIN1bzuwDhcg==
X-Received: by 2002:a5d:4578:0:b0:24e:f72a:4285 with SMTP id a24-20020a5d4578000000b0024ef72a4285mr1462971wrc.24.1671634477353;
        Wed, 21 Dec 2022 06:54:37 -0800 (PST)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id u1-20020a5d6ac1000000b00241cfe6e286sm15466752wrw.98.2022.12.21.06.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 06:54:36 -0800 (PST)
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
        Steven Rostedt <rostedt@goodmis.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v2] virtio-blk: avoid kernel panic on VIRTIO_BLK_F_ZONED check
Date:   Wed, 21 Dec 2022 14:54:33 +0000
Message-Id: <20221221145433.254805-1-lstoakes@gmail.com>
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
 drivers/block/virtio_blk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index ff49052e26f7..94d210b10ebb 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1580,7 +1580,8 @@ static int virtblk_probe(struct virtio_device *vdev)
 	virtblk_update_capacity(vblk, false);
 	virtio_device_ready(vdev);
 
-	if (virtio_has_feature(vdev, VIRTIO_BLK_F_ZONED)) {
+	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
+	    virtio_has_feature(vdev, VIRTIO_BLK_F_ZONED)) {
 		err = virtblk_probe_zoned_device(vdev, vblk, q);
 		if (err)
 			goto out_cleanup_disk;
-- 
2.39.0


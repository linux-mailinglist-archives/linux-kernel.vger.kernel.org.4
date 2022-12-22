Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56B36546A7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 20:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235628AbiLVTdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 14:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235660AbiLVTdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 14:33:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8DB183AC
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 11:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671737544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=zap0JwOZPciWQqxrEZrpNo6QM+wJhPmhrAnvkD5DXS8=;
        b=ZtlPFwu38hiyfcuUOArT9lg/y9ISPasgN0507VgZ8LgUZ5QnxoF2JAlwbB/vZzrMHjMcJQ
        AQ7NjqkkrBnhO3B9bch+MTDiPkQbJ9IJwogz/rQr1lqzD0ghaC/1y8yoNg/1RoZO0FSle0
        LoMrKg4C92EgEIkbNH1J67CcQYgjwfg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-260-2J-0IVrtOX6aNbmWdNMM6g-1; Thu, 22 Dec 2022 14:32:22 -0500
X-MC-Unique: 2J-0IVrtOX6aNbmWdNMM6g-1
Received: by mail-wm1-f69.google.com with SMTP id f1-20020a1cc901000000b003cf703a4f08so570804wmb.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 11:32:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zap0JwOZPciWQqxrEZrpNo6QM+wJhPmhrAnvkD5DXS8=;
        b=aNBxks0Qb6u8yCEa5LQsHhY1w/R1z56arCJqY5YKNPO7gUE6OG8+ONZ1hxjA0SSVft
         LeO9vH878SBU1RSDp1T4lyWX21lonYsrP8vwp5qBs48QEUnkUZoaVg7TN8DYwkhzJY7t
         qsYD5Fnq8NpO03TqrOEchIVRTZ2kTPXd8UROIYKBKE1eXgg8b8IYQE0xcbkFl+AcuNJq
         RMxawtuR2u3ZJta/Dy1P7C/4ozBrvY/vQoYQGiPn+TBy24EbqbMRio5Bo7G/dlg0V1ZN
         uMbVpzj4qiQ81JGBUL1ueKO4MuY9Dz/e7kCffIXyW/ec5DaZbN1M8XoHoLuiX+r6YbkW
         bv1A==
X-Gm-Message-State: AFqh2kqfBBuVchIUDoZuqHTrK6g6hjrG1g5FX4pPiieNHqbZ83GXLy8g
        5z2+p+CoGzSEa4ZGETATllmAv9qM0dJnpg0lueJ45DH7tEcKSXbZ1gWKPELcArRGkvWfr4yPNbM
        JcRHQiahf7EZhplkLFSe3/IxYW1/ngSkTPn7ZvoA2KgXy2FiQIOsYYUlsRBtBuNhLkDmJNg==
X-Received: by 2002:a7b:c3c9:0:b0:3d2:e28:647f with SMTP id t9-20020a7bc3c9000000b003d20e28647fmr5919282wmj.15.1671737540687;
        Thu, 22 Dec 2022 11:32:20 -0800 (PST)
X-Google-Smtp-Source: AMrXdXssW/ik7XCSyiY9jeoHIpwkMDNZnTvLvGPFUSuKuEA7Q3/AV+A2011ANA99S7Y8nFWZwfD4Yg==
X-Received: by 2002:a7b:c3c9:0:b0:3d2:e28:647f with SMTP id t9-20020a7bc3c9000000b003d20e28647fmr5919263wmj.15.1671737540417;
        Thu, 22 Dec 2022 11:32:20 -0800 (PST)
Received: from redhat.com ([2.55.175.215])
        by smtp.gmail.com with ESMTPSA id iz17-20020a05600c555100b003d1e1f421bfsm6600067wmb.10.2022.12.22.11.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 11:32:19 -0800 (PST)
Date:   Thu, 22 Dec 2022 14:32:17 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH] virtio_blk: mark all zone fields LE
Message-ID: <20221222193214.55146-1-mst@redhat.com>
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

zone is a virtio 1.x feature so all fields are LE,
they are handled as such, but have mistakenly been labeled
__virtioXX in the header.  This results in a bunch of sparse warnings.

Use the __leXX tags to make sparse happy.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/uapi/linux/virtio_blk.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
index f4d5ee7c6f30..ec3c3779406f 100644
--- a/include/uapi/linux/virtio_blk.h
+++ b/include/uapi/linux/virtio_blk.h
@@ -141,11 +141,11 @@ struct virtio_blk_config {
 
 	/* Zoned block device characteristics (if VIRTIO_BLK_F_ZONED) */
 	struct virtio_blk_zoned_characteristics {
-		__virtio32 zone_sectors;
-		__virtio32 max_open_zones;
-		__virtio32 max_active_zones;
-		__virtio32 max_append_sectors;
-		__virtio32 write_granularity;
+		__le32 zone_sectors;
+		__le32 max_open_zones;
+		__le32 max_active_zones;
+		__le32 max_append_sectors;
+		__le32 write_granularity;
 		__u8 model;
 		__u8 unused2[3];
 	} zoned;
@@ -245,11 +245,11 @@ struct virtio_blk_outhdr {
  */
 struct virtio_blk_zone_descriptor {
 	/* Zone capacity */
-	__virtio64 z_cap;
+	__le64 z_cap;
 	/* The starting sector of the zone */
-	__virtio64 z_start;
+	__le64 z_start;
 	/* Zone write pointer position in sectors */
-	__virtio64 z_wp;
+	__le64 z_wp;
 	/* Zone type */
 	__u8 z_type;
 	/* Zone state */
@@ -258,7 +258,7 @@ struct virtio_blk_zone_descriptor {
 };
 
 struct virtio_blk_zone_report {
-	__virtio64 nr_zones;
+	__le64 nr_zones;
 	__u8 reserved[56];
 	struct virtio_blk_zone_descriptor zones[];
 };
-- 
MST


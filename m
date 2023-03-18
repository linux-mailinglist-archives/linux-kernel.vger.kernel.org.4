Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3F76BFBE6
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 18:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjCRRgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 13:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjCRRgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 13:36:40 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C636E32524;
        Sat, 18 Mar 2023 10:36:33 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1679160991;
        bh=NdErJEpQNL3oycZkOJ45TpzNFulirMJTRP9tuheh7kc=;
        h=From:Subject:Date:To:Cc:From;
        b=tfKGUd52G2iuMgTbG3OHEOkFgA0v1F4sRNyGakt5lycUiOOHZzlvPZpjK8V++ehWc
         ALJKUrhseKnfKBnVlOgqGMdqZqB68XReAEiUYIaO782Hp/IY/5SvIvXv1fYnBzfE60
         OZzbv/djD4DGkLq1spu3tBWpq6Zeev5eIwXT3ckM=
Subject: [PATCH v3 0/3] blk-integrity: drop integrity_kobj from gendisk
Date:   Sat, 18 Mar 2023 17:36:22 +0000
Message-Id: <20230309-kobj_release-gendisk_integrity-v3-0-ceccb4493c46@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJb2FWQC/5WOwQ6CMBBEf8X0bM22aAme/A9jSFtWukqK6QJqD
 P9u8epFj28yeTMvwZgIWexXL5FwIqY+ZijWK+GDjS1KajILDbqAAip57d2lTtihZZQtxob4WlM
 csE00PCVq48F5pY21IkvcUnPJRh+yJo5dl8NbwjM9PqvHU+ZAPPTp+TkxqSX9eW9SUkmrt3Deb
 dF6A4c7EjP7MIZNxEEs/kn/59QSZGmU3UFTqgq+nfM8vwGTo6iLOgEAAA==
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1679160989; l=1424;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=NdErJEpQNL3oycZkOJ45TpzNFulirMJTRP9tuheh7kc=;
 b=gDOBEJPklTGWPIyiWeB6n43pOuWn4vosCnTZ5xwJkid796aor6ghJWA6VXJ9NXMC1kVUFHyc4
 pJF6zhEGSTWAaW9XNZlK/smLvNE2PY8fORFu8YoOX+cM3JSY9uQXosz
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The embedded member integrity_kobj member of struct gendisk violates
the assumption of the driver core that only one struct kobject should be
embedded into another object and then manages its lifetime.

As the integrity_kobj is only used to hold a few sysfs attributes it can
be replaced by direct device_attributes and removed.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v3:
- Style cleanups
- Register attributes directly via disk_attr_groups
- Link to v2: https://lore.kernel.org/r/20230309-kobj_release-gendisk_integrity-v2-0-761a50d71900@weissschuh.net

Changes in v2:
- Get rid of integrity_kobj completely
- Migrate to sysfs_emit helper
- Link to v1: https://lore.kernel.org/r/20230309-kobj_release-gendisk_integrity-v1-1-a240f54eac60@weissschuh.net

---
Thomas Weißschuh (3):
      blk-integrity: use sysfs_emit
      blk-integrity: convert to struct device_attribute
      blk-integrity: register sysfs attributes on struct device

 block/blk-integrity.c  | 175 +++++++++++++++++--------------------------------
 block/blk.h            |  10 +--
 block/genhd.c          |  12 ++--
 include/linux/blkdev.h |   3 -
 4 files changed, 66 insertions(+), 134 deletions(-)
---
base-commit: 478a351ce0d69cef2d2bf2a686a09b356b63a66c
change-id: 20230309-kobj_release-gendisk_integrity-e26c0bc126aa

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


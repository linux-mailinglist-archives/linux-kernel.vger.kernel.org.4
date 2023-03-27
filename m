Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8276CAD8D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 20:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjC0So5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 14:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbjC0Soi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 14:44:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3963549FD;
        Mon, 27 Mar 2023 11:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=5CScXy6gm0WpuGrf5zNEgp8T/jt1ism2S0gifdGwUFM=; b=mY4Rzbp51m2Fms0zWkLvPm9w1V
        1WxVviR1vQ6Hkxip9Wb+34EEhy2eYbuFh7RU5y9fZVi1uDoXNP2q7hd8JIttYBlmzIfacHrPVeRhC
        m1YQH384r1urB2EraN5JV1I3xrPm0rIJR8P8Pyy/eUbClrZh5RF7ricRRgWLMc4f2iCaLt3xTSbPo
        BvcGtyvH+A98jnm7lXLfmriC+ujN/dtPkAc1D2lNID4J7TRjbq/Sn+gWKp3/PrpEoJ/4hJjhDQZZL
        W0kEtdoeQLv7QZVceFpqWC7VhLJ79kWuClRCSTMsRZzUv7OBaHysYEm+W8Z43flw41P+9J3V2SaYf
        0GMqUBmg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pgrpF-00C5i4-0s;
        Mon, 27 Mar 2023 18:44:13 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, sth@linux.ibm.com, hoeppner@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH] block: annotate bdev_disk_changed() deprecation with a symbol namespace
Date:   Mon, 27 Mar 2023 11:44:10 -0700
Message-Id: <20230327184410.2881786-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of relying on fragile documentation which can easily let us
slip, use a symbol namespace to annotate which symbols should not be
used by others.

This ensures no other users pop up by mistake easily and provides
us a with an easy vehicle to do the same with other routines should
we need it later.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 block/partitions/core.c         | 6 +-----
 drivers/block/loop.c            | 2 ++
 drivers/s390/block/dasd_genhd.c | 2 ++
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index 7b8ef6296abd..9fdb69f08f4e 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -698,11 +698,7 @@ int bdev_disk_changed(struct gendisk *disk, bool invalidate)
 
 	return ret;
 }
-/*
- * Only exported for loop and dasd for historic reasons.  Don't use in new
- * code!
- */
-EXPORT_SYMBOL_GPL(bdev_disk_changed);
+EXPORT_SYMBOL_NS_GPL(bdev_disk_changed, BLOCK_DEPRECATED);
 
 void *read_part_sector(struct parsed_partitions *state, sector_t n, Sector *p)
 {
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 28eb59fd71ca..2e74cd93e8eb 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -37,6 +37,8 @@
 #include <linux/spinlock.h>
 #include <uapi/linux/loop.h>
 
+MODULE_IMPORT_NS(BLOCK_DEPRECATED);
+
 /* Possible states of device */
 enum {
 	Lo_unbound,
diff --git a/drivers/s390/block/dasd_genhd.c b/drivers/s390/block/dasd_genhd.c
index 998a961e1704..5ea244aec534 100644
--- a/drivers/s390/block/dasd_genhd.c
+++ b/drivers/s390/block/dasd_genhd.c
@@ -25,6 +25,8 @@
 
 #include "dasd_int.h"
 
+MODULE_IMPORT_NS(BLOCK_DEPRECATED);
+
 static unsigned int queue_depth = 32;
 static unsigned int nr_hw_queues = 4;
 
-- 
2.39.2


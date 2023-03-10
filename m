Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4728F6B54A2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 23:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjCJWkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 17:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbjCJWk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 17:40:27 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749EB12DDEF;
        Fri, 10 Mar 2023 14:40:22 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1678488020;
        bh=LhiQNQDzGsVSilvdHxI2IkQhBsPFCK1RowivwifIxYg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=sE22RVsHgnpqRoENj8xKSVxDb2gLhErFnxi24EOtLc5snn2SPouPKXHI1+QZeTMwc
         Tmin05cTU2K/1qp6kH/cc/4EEeBFI/pwWSi/yw8oysroY7SEWHU7ebJzUXq0dLKY5E
         WBa77Ug9kJYI/0rNqoh+944i97WJC+wQ7jCDMRfE=
Date:   Fri, 10 Mar 2023 22:40:05 +0000
Subject: [PATCH v2 4/4] blk-integrity: drop integrity_kobj from gendisk
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230309-kobj_release-gendisk_integrity-v2-4-761a50d71900@weissschuh.net>
References: <20230309-kobj_release-gendisk_integrity-v2-0-761a50d71900@weissschuh.net>
In-Reply-To: <20230309-kobj_release-gendisk_integrity-v2-0-761a50d71900@weissschuh.net>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678488015; l=688;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=LhiQNQDzGsVSilvdHxI2IkQhBsPFCK1RowivwifIxYg=;
 b=ws/Wvfp/YWGMguSZpa/0eVK1Y4chRivP0mRHGaoxtKT2wcJAWRAh4rzknNcDs85r+jURGecyF
 N6tZ3b6U93xD2Yt5BoOJT7vvlBNRO3UdsEN1iErpgkLDTPMMzK7+VJ2
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

The previous patches made the integrity_kobj member in struct gendisk
superfluous, remove it.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 include/linux/blkdev.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d1aee08f8c18..b5bc85c3166f 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -163,9 +163,6 @@ struct gendisk {
 	struct timer_rand_state *random;
 	atomic_t sync_io;		/* RAID */
 	struct disk_events *ev;
-#ifdef  CONFIG_BLK_DEV_INTEGRITY
-	struct kobject integrity_kobj;
-#endif	/* CONFIG_BLK_DEV_INTEGRITY */
 
 #ifdef CONFIG_BLK_DEV_ZONED
 	/*

-- 
2.39.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7109D6E7463
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 09:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbjDSHvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 03:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232468AbjDSHuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 03:50:39 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC828AF35;
        Wed, 19 Apr 2023 00:50:09 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1681890606;
        bh=PhuKSVM+kLkzr4vVCFko648fBsxNsNBCoE+R9yckFfk=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=g8M6e0S0q91u4AQ+9aU5tjzS+twC2zUotiDRCFi4HscFAA1cEXUHMYBWgfosZNu47
         SK8r0RvA8AzhmKIkejOWNSxJD8nJI4zVVzfHpR5K9F9b4QOfPxytmKi2yYHLw1PQYW
         SS3SMB9h43XXOxEKIDqLzkaWON/J4KE5fDACtx7g=
Date:   Wed, 19 Apr 2023 09:50:02 +0200
Subject: [PATCH 2/4] block: constify struct part_type part_type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230419-const-partition-v1-2-2d66f2d83873@weissschuh.net>
References: <20230419-const-partition-v1-0-2d66f2d83873@weissschuh.net>
In-Reply-To: <20230419-const-partition-v1-0-2d66f2d83873@weissschuh.net>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681890605; l=1158;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=PhuKSVM+kLkzr4vVCFko648fBsxNsNBCoE+R9yckFfk=;
 b=bM12H6NWeGSf35qtpumgJNsGsDZvkNlMhGe1dE92A+yhS7RAAbo1knoQIpfAJJIF4KoDRplPq
 VoqD3UbC4PiAhaBbkpAfBbLtYk6cW6L0MLvdkNOgt97sLlfGDr26cD/
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct is never modified so it can be const.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 block/partitions/core.c | 2 +-
 include/linux/blkdev.h  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index 667f3dcebd59..812407ea38e9 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -264,7 +264,7 @@ static int part_uevent(const struct device *dev, struct kobj_uevent_env *env)
 	return 0;
 }
 
-struct device_type part_type = {
+const struct device_type part_type = {
 	.name		= "partition",
 	.groups		= part_attr_groups,
 	.release	= part_release,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 941304f17492..de783481ec71 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -41,7 +41,7 @@ struct blk_stat_callback;
 struct blk_crypto_profile;
 
 extern const struct device_type disk_type;
-extern struct device_type part_type;
+extern const struct device_type part_type;
 extern struct class block_class;
 
 /* Must be consistent with blk_mq_poll_stats_bkt() */

-- 
2.40.0


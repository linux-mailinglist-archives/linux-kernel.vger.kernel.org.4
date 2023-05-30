Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B6F716A7A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 19:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233190AbjE3RKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 13:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjE3RKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 13:10:03 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97BABE;
        Tue, 30 May 2023 10:10:01 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1685466599;
        bh=hwbEAsSX9O3Q/FuzB+mJE3YvogxYgzykVJP1zCu7+7U=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=dm5eUFL/Yka8KKt3Elb7WyHilwbgTER89Scv87Yw00J6QKGMcZSyfiUp3TZm/mEHQ
         6uD706PdJm/hf8D42aD6iVBxmJZ/IzJrlmIf8VubNXHEv9DoFbRrqG/MpAojAD0mqm
         RQSSC9Jnbjq25duMBmt3HiqgvWID9DqTt9cEvrVM=
Date:   Tue, 30 May 2023 19:10:00 +0200
Subject: [PATCH v3 4/4] block: constify the whole_disk device_attribute
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230419-const-partition-v3-4-4e14e48be367@weissschuh.net>
References: <20230419-const-partition-v3-0-4e14e48be367@weissschuh.net>
In-Reply-To: <20230419-const-partition-v3-0-4e14e48be367@weissschuh.net>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685466599; l=692;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=hwbEAsSX9O3Q/FuzB+mJE3YvogxYgzykVJP1zCu7+7U=;
 b=7NcHib0T8ZH6rifFN3Q7kFkaNeaNU7I9XZVb1eBcPLgzE6m08e+M8Gl0HbY2viAm80dmpnutw
 S6PR66DIfqTCCyKdlad2aDDWuA7RusQ/vaGZnqjDuw5E9eFI/dahrcx
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
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index d5f5633bf725..82d26427deae 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -288,7 +288,7 @@ static ssize_t whole_disk_show(struct device *dev,
 {
 	return 0;
 }
-static DEVICE_ATTR(whole_disk, 0444, whole_disk_show, NULL);
+static const DEVICE_ATTR(whole_disk, 0444, whole_disk_show, NULL);
 
 /*
  * Must be called either with open_mutex held, before a disk can be opened or

-- 
2.40.1


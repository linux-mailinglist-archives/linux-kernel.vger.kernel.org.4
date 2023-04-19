Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E996E745B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 09:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbjDSHu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 03:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbjDSHuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 03:50:37 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39793CC3C;
        Wed, 19 Apr 2023 00:50:09 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1681890606;
        bh=30iMUBbhKpHPLuoBNwmZAzJbN0IHFShaDIG5piBY4Cs=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=nn0r6mzAaqoEhS1It3ZDwNC6g7FSCjF4ccKeZ3RmCUEo51z5AaiFxTsC+u9XTYjp7
         0XW3dazWJD4KDekWdHlKj1UkaeiTmqYe0SA44fMRABXngrzHnz6RJjo8IvYEmuTs4Q
         n0bYXh4cRg9bDizZT4iLDEdraieeNgmc9pLZigeg=
Date:   Wed, 19 Apr 2023 09:50:04 +0200
Subject: [PATCH 4/4] block: constify the whole_disk device_attribute
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230419-const-partition-v1-4-2d66f2d83873@weissschuh.net>
References: <20230419-const-partition-v1-0-2d66f2d83873@weissschuh.net>
In-Reply-To: <20230419-const-partition-v1-0-2d66f2d83873@weissschuh.net>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681890605; l=692;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=30iMUBbhKpHPLuoBNwmZAzJbN0IHFShaDIG5piBY4Cs=;
 b=hJFtQ8W2Kh0rQjAo0WwaHkKqDSvau9GymVQLfCCajbra4SOHaHwn2zHmFK3Jbzdf4zc+XQ4QO
 c/wCqiTrp1XA3gwuAv8Urx33x+/WMk/DYURZKsmlLmU8ePigUJp/oQq
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
index 032e415618cb..8efadc694e41 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -296,7 +296,7 @@ static ssize_t whole_disk_show(struct device *dev,
 {
 	return 0;
 }
-static DEVICE_ATTR(whole_disk, 0444, whole_disk_show, NULL);
+static const DEVICE_ATTR(whole_disk, 0444, whole_disk_show, NULL);
 
 /*
  * Must be called either with open_mutex held, before a disk can be opened or

-- 
2.40.0


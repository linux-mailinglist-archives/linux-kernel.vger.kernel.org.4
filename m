Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93EB6F2E0D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 05:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbjEADTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 23:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233782AbjEADQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 23:16:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC4B10D7;
        Sun, 30 Apr 2023 20:06:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88D81617AA;
        Mon,  1 May 2023 03:06:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54719C4339E;
        Mon,  1 May 2023 03:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682910376;
        bh=1sAK7siXULBkOdJo4LOofxcynx/scLOF9+4VyLSnkiA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nw+JstElzpm8vWUKIScpTtPbnq9HYTIF+f/W2sDvoqWUSgctSbNoSKTBuBY65pP6F
         P7L/8hoIG5/uCNqFWXRQ7+UA71ew1YU74Aqo5u5fe2FRGDCw/9qhLCLXhXt6+Dhazg
         1W4EUr6M9vEuT00iA8wautCaxmdaPfmL9RKA3tRzMdAK5vGfnMlrjcBHuspagEXawf
         VrDyCABVOqLA0WytoU1YQUQ6KTUau2totTKFKBlmYsKVuUfGV7itFyUTy1W32B8P6+
         p8fUAGYUfwu0uDMqJwR7+Bdc+1NEABCMASACT578zr8RTIcoyvii4v0eHbA9ghlo9j
         WJEXHOgT/4paA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, gregkh@linuxfoundation.org
Subject: [PATCH AUTOSEL 5.4 2/9] regmap: cache: Return error in cache sync operations for REGCACHE_NONE
Date:   Sun, 30 Apr 2023 23:06:02 -0400
Message-Id: <20230501030611.3255082-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501030611.3255082-1-sashal@kernel.org>
References: <20230501030611.3255082-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Stein <alexander.stein@ew.tq-group.com>

[ Upstream commit fd883d79e4dcd2417c2b80756f22a2ff03b0f6e0 ]

There is no sense in doing a cache sync on REGCACHE_NONE regmaps.
Instead of panicking the kernel due to missing cache_ops, return an error
to client driver.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Link: https://lore.kernel.org/r/20230313071812.13577-1-alexander.stein@ew.tq-group.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/regmap/regcache.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/regcache.c
index 7f4b3b62492ca..7fdd702e564ae 100644
--- a/drivers/base/regmap/regcache.c
+++ b/drivers/base/regmap/regcache.c
@@ -343,6 +343,9 @@ int regcache_sync(struct regmap *map)
 	const char *name;
 	bool bypass;
 
+	if (WARN_ON(map->cache_type == REGCACHE_NONE))
+		return -EINVAL;
+
 	BUG_ON(!map->cache_ops);
 
 	map->lock(map->lock_arg);
@@ -412,6 +415,9 @@ int regcache_sync_region(struct regmap *map, unsigned int min,
 	const char *name;
 	bool bypass;
 
+	if (WARN_ON(map->cache_type == REGCACHE_NONE))
+		return -EINVAL;
+
 	BUG_ON(!map->cache_ops);
 
 	map->lock(map->lock_arg);
-- 
2.39.2


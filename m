Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F646F2D29
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 05:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbjEADHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 23:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbjEADEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 23:04:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA2749EF;
        Sun, 30 Apr 2023 20:01:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A537261768;
        Mon,  1 May 2023 03:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A1E8C433EF;
        Mon,  1 May 2023 03:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682910022;
        bh=HLRyMgawJujuYVpZlrvvskARUUQdZ/XGpjg2b3W8cVk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qw0uqwaGsaR9/wY4e1zgk73fTnL+Us+NhCDlYGOC3xCf68rGXUptjkX7wTtOcKbZY
         Ep4ZE3LZJuNzB3QSGmvPX7F5Q5fraqQ0YkKEdvN/X7CBJ7Ji4/eQKeQbu6Fh2AgxE2
         s8G+/eob6Bq8R5t2VjDrSR05lU/vcDm7ExTbqZs7QTTCNL963hTLVoDOkW8Ajtd64v
         SekMTQ89BDbpMzsmPt7YDarU2xO6yYFgzM98htOCmQyHR95AGi2Cj2svMxAxqJuLGv
         gVba8O/qXMXNGuohbVBPbldIGoAAD5x5e1prUtD3hrRjWojGnyF+Dc2RggksQd3rv6
         11x2PEvvPWp/w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, gregkh@linuxfoundation.org
Subject: [PATCH AUTOSEL 6.2 08/37] regmap: cache: Return error in cache sync operations for REGCACHE_NONE
Date:   Sun, 30 Apr 2023 22:59:16 -0400
Message-Id: <20230501025945.3253774-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501025945.3253774-1-sashal@kernel.org>
References: <20230501025945.3253774-1-sashal@kernel.org>
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
index 362e043e26d86..8031007b4887d 100644
--- a/drivers/base/regmap/regcache.c
+++ b/drivers/base/regmap/regcache.c
@@ -349,6 +349,9 @@ int regcache_sync(struct regmap *map)
 	const char *name;
 	bool bypass;
 
+	if (WARN_ON(map->cache_type == REGCACHE_NONE))
+		return -EINVAL;
+
 	BUG_ON(!map->cache_ops);
 
 	map->lock(map->lock_arg);
@@ -418,6 +421,9 @@ int regcache_sync_region(struct regmap *map, unsigned int min,
 	const char *name;
 	bool bypass;
 
+	if (WARN_ON(map->cache_type == REGCACHE_NONE))
+		return -EINVAL;
+
 	BUG_ON(!map->cache_ops);
 
 	map->lock(map->lock_arg);
-- 
2.39.2


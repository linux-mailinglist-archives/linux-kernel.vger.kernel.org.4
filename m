Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B687316DD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343972AbjFOLhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343936AbjFOLhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:37:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCA42942;
        Thu, 15 Jun 2023 04:37:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51911638FA;
        Thu, 15 Jun 2023 11:37:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E553C433C0;
        Thu, 15 Jun 2023 11:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686829041;
        bh=hIpr6cRM5YuTDhM93dFrl4/JGBHe6WNnEi9JreoWTik=;
        h=From:To:Cc:Subject:Date:From;
        b=aRP//iCNZVIFd518UJp9EV+iF1t9ICKBPMkFymZynxlsfthdhW2un1IkS8YkMGaWa
         zyyP+fCCi+vTYlybM8QQw0USHMaPZt4gTABM+IJoCN7NkfykrRKiLPgnvTbm6h88fL
         4/1dMdgcI+zbAF6a2VHogFNtGcRW3QsKe5b8ZIwm7S2p6l2o9+dadQOxiEPK0QPdit
         sBK/l8uSm6W21gHMzXgWcoJbM1NIZiBIjkd4SkH6BPeaZk/CCe8d4ayRqFFs763sxU
         FKQJB4Olaek0PicDiPrTpmkres5lmCmq8fciAZ81BMGSh7OTgAh/3nNK7keoQH+JH+
         WX/d+egXuEUoA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jim Wylder <jwylder@google.com>, Sasha Levin <sashal@kernel.org>,
        broonie@kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH AUTOSEL 6.3 01/19] regmap: Account for register length when chunking
Date:   Thu, 15 Jun 2023 07:37:01 -0400
Message-Id: <20230615113719.648862-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.3.8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jim Wylder <jwylder@google.com>

[ Upstream commit 3981514180c987a79ea98f0ae06a7cbf58a9ac0f ]

Currently, when regmap_raw_write() splits the data, it uses the
max_raw_write value defined for the bus.  For any bus that includes
the target register address in the max_raw_write value, the chunked
transmission will always exceed the maximum transmission length.
To avoid this problem, subtract the length of the register and the
padding from the maximum transmission.

Signed-off-by: Jim Wylder <jwylder@google.com
Link: https://lore.kernel.org/r/20230517152444.3690870-2-jwylder@google.com
Signed-off-by: Mark Brown <broonie@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/regmap/regmap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index d2a54eb0efd9b..f9f38ab3f030e 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -2064,6 +2064,8 @@ int _regmap_raw_write(struct regmap *map, unsigned int reg,
 	size_t val_count = val_len / val_bytes;
 	size_t chunk_count, chunk_bytes;
 	size_t chunk_regs = val_count;
+	size_t max_data = map->max_raw_write - map->format.reg_bytes -
+			map->format.pad_bytes;
 	int ret, i;
 
 	if (!val_count)
@@ -2071,8 +2073,8 @@ int _regmap_raw_write(struct regmap *map, unsigned int reg,
 
 	if (map->use_single_write)
 		chunk_regs = 1;
-	else if (map->max_raw_write && val_len > map->max_raw_write)
-		chunk_regs = map->max_raw_write / val_bytes;
+	else if (map->max_raw_write && val_len > max_data)
+		chunk_regs = max_data / val_bytes;
 
 	chunk_count = val_count / chunk_regs;
 	chunk_bytes = chunk_regs * val_bytes;
-- 
2.39.2


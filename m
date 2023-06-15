Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542B973179B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344519AbjFOLny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344194AbjFOLnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:43:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5489430FA;
        Thu, 15 Jun 2023 04:40:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AAF42636C9;
        Thu, 15 Jun 2023 11:39:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77235C433C0;
        Thu, 15 Jun 2023 11:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686829199;
        bh=dadMN48TmGNucqM8EGne3slmxMZ8beXTzyLEgJRj85I=;
        h=From:To:Cc:Subject:Date:From;
        b=J8/bgCmvxKZfrawqaQS/yF96ZlR29m+0OU2tzFwuTmLDCeZscCg/BKuoGhJjRplwx
         URoMT2wXuI8kSh77L6cx/Rn5IOauZjXNmlLqFzXFTWMt27hF/DImau96h5VfXgo0oi
         O06E3D0occQmDOOEGe5tNsgJUwyvqd14lkrgyQrfMP2ViOwTHWXHxHHcScKGxScF46
         PtgwJl3w+PcmmM+YV41r7CyOlzPhUde0ZkrT/vtTsmo0IDIHUPKgr1ODBp8J90txRz
         +Xk441zKH0UtMn5PZWK63yMrZ4i3Eq7I8/V4mB1cHEoWZL4hVUcLUNkX39oVvOFGuh
         f3mifPbN4RkhQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jim Wylder <jwylder@google.com>, Sasha Levin <sashal@kernel.org>,
        broonie@kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH AUTOSEL 4.19 1/8] regmap: Account for register length when chunking
Date:   Thu, 15 Jun 2023 07:39:49 -0400
Message-Id: <20230615113956.649736-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.286
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
index 330ab9c85d1b8..540c879abe52c 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1825,6 +1825,8 @@ int _regmap_raw_write(struct regmap *map, unsigned int reg,
 	size_t val_count = val_len / val_bytes;
 	size_t chunk_count, chunk_bytes;
 	size_t chunk_regs = val_count;
+	size_t max_data = map->max_raw_write - map->format.reg_bytes -
+			map->format.pad_bytes;
 	int ret, i;
 
 	if (!val_count)
@@ -1832,8 +1834,8 @@ int _regmap_raw_write(struct regmap *map, unsigned int reg,
 
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


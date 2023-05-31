Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE7E7183F2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 15:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237441AbjEaNxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 09:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237488AbjEaNuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 09:50:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDFC35AF;
        Wed, 31 May 2023 06:46:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CFF663B94;
        Wed, 31 May 2023 13:46:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8406C4339B;
        Wed, 31 May 2023 13:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685540774;
        bh=amL2Nhm8cwIr7U0FiUt7GFoC1TGrk53k6QFJTZXMgDk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zf6OQ/pQnnQe8n5HGsRZ3Obp9iCFEwHc3eeWw/1a7UsZUAEAZf0hAB3XU5TqE7ryc
         U3PTqVRvLbkgKYdGbBMNf91tHsBM/kiFx+Lq+WSVtZG15i+D4/jok2wCvGH4ypp5el
         rrh+JL9dXXY5zab9wh5POgulAB0n3B/6ax7XPFxDACoJc2mD5jOyMI25sspPa/RTrw
         WOap2Rnz1j0d+BXnjtv/K4iDCM2/C64ymtM9TEDXNB7OQbgL9V7+nwoYlwpu7RccU8
         VT3PjCpvAEEI9MXte0Hxz9ZZGWR9w0qNdTdNmoTnvJt1/HKYhOIoQbOP1Tgw2ZxfWt
         6ncYm+tWcF/RQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Osama Muhammad <osmtendev@gmail.com>,
        Sasha Levin <sashal@kernel.org>, lgirdwood@gmail.com,
        broonie@kernel.org
Subject: [PATCH AUTOSEL 4.14 05/10] regulator: Fix error checking for debugfs_create_dir
Date:   Wed, 31 May 2023 09:46:01 -0400
Message-Id: <20230531134606.3385210-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531134606.3385210-1-sashal@kernel.org>
References: <20230531134606.3385210-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Osama Muhammad <osmtendev@gmail.com>

[ Upstream commit 2bf1c45be3b8f3a3f898d0756c1282f09719debd ]

This patch fixes the error checking in core.c in debugfs_create_dir.
The correct way to check if an error occurred is 'IS_ERR' inline function.

Signed-off-by: Osama Muhammad <osmtendev@gmail.com
Suggested-by: Ivan Orlov <ivan.orlov0322@gmail.com
Link: https://lore.kernel.org/r/20230515172938.13338-1-osmtendev@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 871d657a161f0..7898a54a324c4 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -3955,7 +3955,7 @@ static void rdev_init_debugfs(struct regulator_dev *rdev)
 	}
 
 	rdev->debugfs = debugfs_create_dir(rname, debugfs_root);
-	if (!rdev->debugfs) {
+	if (IS_ERR(rdev->debugfs)) {
 		rdev_warn(rdev, "Failed to create debugfs directory\n");
 		return;
 	}
@@ -4513,7 +4513,7 @@ static int __init regulator_init(void)
 	ret = class_register(&regulator_class);
 
 	debugfs_root = debugfs_create_dir("regulator", NULL);
-	if (!debugfs_root)
+	if (IS_ERR(debugfs_root))
 		pr_warn("regulator: Failed to create debugfs directory\n");
 
 	debugfs_create_file("supply_map", 0444, debugfs_root, NULL,
-- 
2.39.2


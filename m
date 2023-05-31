Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D587182A6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 15:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236458AbjEaNoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 09:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236645AbjEaNoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 09:44:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9639119B2;
        Wed, 31 May 2023 06:42:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB2EF63B31;
        Wed, 31 May 2023 13:42:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DE9FC433A1;
        Wed, 31 May 2023 13:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685540540;
        bh=VcYR0sWgzjXkIbKenJN0S77R4Sy48bDmMhkc9X+Yq0Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b4VVQkOz5w7TQA++C01pqztlK+XtHOQfF/pTMXargRm7rQ8nK4ekMj8ShM7vh2F6q
         /mtBNnCSi/bIismQdo69b7gEKAr2hlRUucRDypsUpTBbcpUd3qYUJw/x0tDbIM1EVq
         Mnk/1jFuzU0BsuUugqUSHHZsiW70f4RFDjJEK9vnFPkvpg+lQMNb2rhwWcQ6mo54eB
         o9x4z+K2CoUXNITnPRbTQro6D9cU09XHNokeyzgB0WzjM1rjZWlFzrnDOvr3CXNqFd
         t6SuYWqvcEceHhmeHJy0AUerTQ37ecJpB+den6n3TO3cIkelshbGOo7K93Tx2Wz1zX
         2CqsRfBoh74yA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Osama Muhammad <osmtendev@gmail.com>,
        Sasha Levin <sashal@kernel.org>, lgirdwood@gmail.com,
        broonie@kernel.org
Subject: [PATCH AUTOSEL 6.1 10/33] regulator: Fix error checking for debugfs_create_dir
Date:   Wed, 31 May 2023 09:41:36 -0400
Message-Id: <20230531134159.3383703-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531134159.3383703-1-sashal@kernel.org>
References: <20230531134159.3383703-1-sashal@kernel.org>
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
index c417eae887b2d..e01cade8be0c7 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5257,7 +5257,7 @@ static void rdev_init_debugfs(struct regulator_dev *rdev)
 	}
 
 	rdev->debugfs = debugfs_create_dir(rname, debugfs_root);
-	if (!rdev->debugfs) {
+	if (IS_ERR(rdev->debugfs)) {
 		rdev_warn(rdev, "Failed to create debugfs directory\n");
 		return;
 	}
@@ -6179,7 +6179,7 @@ static int __init regulator_init(void)
 	ret = class_register(&regulator_class);
 
 	debugfs_root = debugfs_create_dir("regulator", NULL);
-	if (!debugfs_root)
+	if (IS_ERR(debugfs_root))
 		pr_warn("regulator: Failed to create debugfs directory\n");
 
 #ifdef CONFIG_DEBUG_FS
-- 
2.39.2


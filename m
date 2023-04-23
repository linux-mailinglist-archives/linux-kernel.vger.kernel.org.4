Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719626EBF70
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 14:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjDWM3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 08:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjDWM3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 08:29:33 -0400
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76C81733
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 05:29:28 -0700 (PDT)
Received: from dd-virtual-machine.localdomain ([60.247.94.10])
        (user=u202114568@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 33NCRdFX003348-33NCRdFY003348
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Sun, 23 Apr 2023 20:27:53 +0800
From:   Yuchen Yang <u202114568@hust.edu.cn>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>
Cc:     hust-os-kernel-patches@googlegroups.com,
        Yuchen Yang <u202114568@hust.edu.cn>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: regulator: core: remove return value check of `regulator_init`
Date:   Sun, 23 Apr 2023 20:27:31 +0800
Message-Id: <20230423122732.31135-1-u202114568@hust.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: u202114568@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch complains that:
regulator_init() warn: 'debugfs_root' is an error pointer or valid

According to the documentation of the debugfs_create_dir() function,
there is no need to check the return value of this function.
Just delete the dead code.

Fixes: 247514344492 ("regulator: Remove ifdefs for debugfs code")
Signed-off-by: Yuchen Yang <u202114568@hust.edu.cn>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
---
 drivers/regulator/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 4fcd36055b02..b14f281b1a97 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -6109,8 +6109,6 @@ static int __init regulator_init(void)
 	ret = class_register(&regulator_class);
 
 	debugfs_root = debugfs_create_dir("regulator", NULL);
-	if (!debugfs_root)
-		pr_warn("regulator: Failed to create debugfs directory\n");
 
 #ifdef CONFIG_DEBUG_FS
 	debugfs_create_file("supply_map", 0444, debugfs_root, NULL,
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545D66EC3CA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 04:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjDXC7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 22:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjDXC7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 22:59:49 -0400
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB8B2721
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 19:59:43 -0700 (PDT)
Received: from dd-virtual-machine.localdomain ([60.247.94.10])
        (user=u202114568@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 33O2verx030312-33O2ves0030312
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 24 Apr 2023 10:57:52 +0800
From:   Yuchen Yang <u202114568@hust.edu.cn>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>
Cc:     hust-os-kernel-patches@googlegroups.com,
        Yuchen Yang <u202114568@hust.edu.cn>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        Liam Girdwood <lrg@slimlogic.co.uk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: regulator: core: remove return value check of `rdev->debugfs`
Date:   Mon, 24 Apr 2023 10:57:37 +0800
Message-Id: <20230424025738.34950-1-u202114568@hust.edu.cn>
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
rdev_init_debugfs() warn: 'rdev->debugfs' is an error pointer or valid

According to the documentation of the debugfs_create_dir() function, 
there is no need to check the return value of this function.
Just delete the dead code.

Fixes: 247514344492 ("regulator: Remove ifdefs for debugfs code")
Fixes: 1130e5b3ff4a ("regulator: Add initial per-regulator debugfs support")
Signed-off-by: Yuchen Yang <u202114568@hust.edu.cn>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
---
 drivers/regulator/core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 4fcd36055b02..979ee043f7a1 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5188,10 +5188,6 @@ static void rdev_init_debugfs(struct regulator_dev *rdev)
 	}
 
 	rdev->debugfs = debugfs_create_dir(rname, debugfs_root);
-	if (!rdev->debugfs) {
-		rdev_warn(rdev, "Failed to create debugfs directory\n");
-		return;
-	}
 
 	debugfs_create_u32("use_count", 0444, rdev->debugfs,
 			   &rdev->use_count);
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1216E7704
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 12:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbjDSKCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 06:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbjDSKC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 06:02:29 -0400
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB647DBA
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 03:02:27 -0700 (PDT)
Received: from archlinux.localdomain ([10.12.190.56])
        (user=zkhuang@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 33JA1VTK021595-33JA1VTL021595
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 19 Apr 2023 18:01:36 +0800
From:   Zhengkang Huang <zkhuang@hust.edu.cn>
To:     Benson Leung <bleung@chromium.org>
Cc:     Zhengkang Huang <zkhuang@hust.edu.cn>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] platform: chrome: wilco_ec: remove return value check of debugfs_create_dir()
Date:   Wed, 19 Apr 2023 18:03:03 +0800
Message-Id: <20230419100303.343379-1-zkhuang@hust.edu.cn>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: zkhuang@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch complains that:
wilco_ec_debugfs_probe() warn: 'debug_info->dir' is an error 
pointer or valid 

Debugfs checks are generally not supposed to be checked 
for errors and it is not necessary here. 

Just delete the dead code. 

Signed-off-by: Zhengkang Huang <zkhuang@hust.edu.cn>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
---
NOTES: The issue is found by static analysis and remains untested.
---

 drivers/platform/chrome/wilco_ec/debugfs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/platform/chrome/wilco_ec/debugfs.c b/drivers/platform/chrome/wilco_ec/debugfs.c
index a812788a0bdc..7a13f13b16cd 100644
--- a/drivers/platform/chrome/wilco_ec/debugfs.c
+++ b/drivers/platform/chrome/wilco_ec/debugfs.c
@@ -251,8 +251,6 @@ static int wilco_ec_debugfs_probe(struct platform_device *pdev)
 		return 0;
 	debug_info->ec = ec;
 	debug_info->dir = debugfs_create_dir("wilco_ec", NULL);
-	if (!debug_info->dir)
-		return 0;
 	debugfs_create_file("raw", 0644, debug_info->dir, NULL, &fops_raw);
 	debugfs_create_file("h1_gpio", 0444, debug_info->dir, ec,
 			    &fops_h1_gpio);
-- 
2.40.0


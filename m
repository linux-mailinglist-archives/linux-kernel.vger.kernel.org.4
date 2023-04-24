Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A916EC8BD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 11:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjDXJYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 05:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjDXJYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 05:24:12 -0400
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658E21FCC
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 02:23:50 -0700 (PDT)
Received: from huangjintao.. ([10.12.190.56])
        (user=u202017189@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 33O9Mveu031569-33O9Mvev031569
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 24 Apr 2023 17:23:03 +0800
From:   Jintao Huang <u202017189@hust.edu.cn>
To:     Sanjay R Mehta <sanju.mehta@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>
Cc:     hust-os-kernel-patches@googlegroups.com,
        Jintao Huang <u202017189@hust.edu.cn>,
        Dongliang Mu <dzm91@hust.edu.cn>, ntb@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] NTB: remove all the checks of the return values.
Date:   Mon, 24 Apr 2023 09:22:55 +0000
Message-Id: <20230424092255.29338-1-u202017189@hust.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: u202017189@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comments in debugfs_create_dir and debugfs_create_file point out that,
generally, we do not need to check the return arguments of the functions.
In this case, it will be useful to delete all the checks
about the return arguments.

Signed-off-by: Jintao Huang <u202017189@hust.edu.cn>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
---
This issue is found by static analyzer. The patched code has passed
Smatch checker, but remains untested on concrete running.
---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index 04550b1f984c..6b0f0c4bf278 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -934,21 +934,13 @@ static ssize_t ndev_debugfs_read(struct file *filp, char __user *ubuf,
 
 static void ndev_init_debugfs(struct amd_ntb_dev *ndev)
 {
-	if (!debugfs_dir) {
-		ndev->debugfs_dir = NULL;
-		ndev->debugfs_info = NULL;
-	} else {
-		ndev->debugfs_dir =
-			debugfs_create_dir(pci_name(ndev->ntb.pdev),
-					   debugfs_dir);
-		if (!ndev->debugfs_dir)
-			ndev->debugfs_info = NULL;
-		else
-			ndev->debugfs_info =
-				debugfs_create_file("info", S_IRUSR,
-						    ndev->debugfs_dir, ndev,
-						    &amd_ntb_debugfs_info);
-	}
+	ndev->debugfs_dir =
+		debugfs_create_dir(pci_name(ndev->ntb.pdev),
+				   debugfs_dir);
+	ndev->debugfs_info =
+		debugfs_create_file("info", 0400,
+				    ndev->debugfs_dir, ndev,
+				    &amd_ntb_debugfs_info);
 }
 
 static void ndev_deinit_debugfs(struct amd_ntb_dev *ndev)
-- 
2.34.1


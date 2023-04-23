Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713606EBF6C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 14:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjDWM1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 08:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjDWM1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 08:27:13 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC55107;
        Sun, 23 Apr 2023 05:27:12 -0700 (PDT)
Received: from dd-virtual-machine.localdomain ([60.247.94.10])
        (user=U202112064@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 33NCPgrJ015487-33NCPgrK015487
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Sun, 23 Apr 2023 20:25:49 +0800
From:   Jing Xu <U202112064@hust.edu.cn>
To:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     hust-os-kernel-patches@googlegroups.com,
        Jing Xu <U202112064@hust.edu.cn>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: mpt3sas: mpt3sas_debugfs: return value check of `mpt3sas_debugfs_root`
Date:   Sun, 23 Apr 2023 20:25:35 +0800
Message-Id: <20230423122535.31019-1-U202112064@hust.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: U202112064@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch complains that:
mpt3sas_init_debugfs() warn: 'mpt3sas_debugfs_root' is an error 
pointer or valid

There is no need to check the return value of the debugfs_create_dir() 
function, just delete the dead code.

Fixes: 2b01b293f359 ("scsi: mpt3sas: Capture IOC data for debugging purposes")
Signed-off-by: Jing Xu <U202112064@hust.edu.cn>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
---
 drivers/scsi/mpt3sas/mpt3sas_debugfs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_debugfs.c b/drivers/scsi/mpt3sas/mpt3sas_debugfs.c
index a6ab1db81167..c92e08c130b9 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_debugfs.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_debugfs.c
@@ -99,8 +99,6 @@ static const struct file_operations mpt3sas_debugfs_iocdump_fops = {
 void mpt3sas_init_debugfs(void)
 {
 	mpt3sas_debugfs_root = debugfs_create_dir("mpt3sas", NULL);
-	if (!mpt3sas_debugfs_root)
-		pr_info("mpt3sas: Cannot create debugfs root\n");
 }
 
 /*
-- 
2.25.1


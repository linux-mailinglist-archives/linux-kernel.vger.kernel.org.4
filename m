Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28986BE0C8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 06:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjCQFuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 01:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjCQFuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 01:50:20 -0400
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E2F38036;
        Thu, 16 Mar 2023 22:50:16 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R771e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Ve1mevH_1679032182;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0Ve1mevH_1679032182)
          by smtp.aliyun-inc.com;
          Fri, 17 Mar 2023 13:50:13 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     don.brace@microchip.com
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        storagedev@microchip.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] scsi: hpsa: Remove the unused variable transMethod
Date:   Fri, 17 Mar 2023 13:49:40 +0800
Message-Id: <20230317054940.86685-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable transMethod is not effectively used, so delete it.

drivers/scsi/hpsa.c:9478:16: warning: variable 'transMethod' set but not used.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4554
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/scsi/hpsa.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index fec7e17747f7..2f2b46a95102 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -9475,8 +9475,6 @@ static void hpsa_free_performant_mode(struct ctlr_info *h)
 static int hpsa_put_ctlr_into_performant_mode(struct ctlr_info *h)
 {
 	u32 trans_support;
-	unsigned long transMethod = CFGTBL_Trans_Performant |
-					CFGTBL_Trans_use_short_tags;
 	int i, rc;
 
 	if (hpsa_simple_mode)
@@ -9488,14 +9486,10 @@ static int hpsa_put_ctlr_into_performant_mode(struct ctlr_info *h)
 
 	/* Check for I/O accelerator mode support */
 	if (trans_support & CFGTBL_Trans_io_accel1) {
-		transMethod |= CFGTBL_Trans_io_accel1 |
-				CFGTBL_Trans_enable_directed_msix;
 		rc = hpsa_alloc_ioaccel1_cmd_and_bft(h);
 		if (rc)
 			return rc;
 	} else if (trans_support & CFGTBL_Trans_io_accel2) {
-		transMethod |= CFGTBL_Trans_io_accel2 |
-				CFGTBL_Trans_enable_directed_msix;
 		rc = hpsa_alloc_ioaccel2_cmd_and_bft(h);
 		if (rc)
 			return rc;
-- 
2.20.1.7.g153144c


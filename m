Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4E268FE22
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 04:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbjBIDwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 22:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbjBIDwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 22:52:36 -0500
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7120C2BED8;
        Wed,  8 Feb 2023 19:52:35 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VbEPjtv_1675914746;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VbEPjtv_1675914746)
          by smtp.aliyun-inc.com;
          Thu, 09 Feb 2023 11:52:33 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     ketan.mukadam@broadcom.com
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] scsi: be2iscsi: Remove the unused variable internal_page_offset
Date:   Thu,  9 Feb 2023 11:52:24 +0800
Message-Id: <20230209035224.90327-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable internal_page_offset is not effectively used, so delete it.

drivers/scsi/be2iscsi/be_cmds.c:1176:6: warning: variable 'internal_page_offset' set but not used.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4011
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/scsi/be2iscsi/be_cmds.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/be2iscsi/be_cmds.c b/drivers/scsi/be2iscsi/be_cmds.c
index 69b1a80e3687..0b59b63bce79 100644
--- a/drivers/scsi/be2iscsi/be_cmds.c
+++ b/drivers/scsi/be2iscsi/be_cmds.c
@@ -1173,7 +1173,6 @@ int be_cmd_iscsi_post_sgl_pages(struct be_ctrl_info *ctrl,
 	struct beiscsi_hba *phba = pci_get_drvdata(ctrl->pdev);
 	int status;
 	unsigned int curr_pages;
-	u32 internal_page_offset = 0;
 	u32 temp_num_pages = num_pages;
 
 	if (num_pages == 0xff)
@@ -1192,7 +1191,6 @@ int be_cmd_iscsi_post_sgl_pages(struct be_ctrl_info *ctrl,
 		req->page_offset = page_offset;
 		be_cmd_page_addrs_prepare(req->pages, req->num_pages, q_mem);
 		q_mem->dma = q_mem->dma + (req->num_pages * PAGE_SIZE);
-		internal_page_offset += req->num_pages;
 		page_offset += req->num_pages;
 		num_pages -= req->num_pages;
 
-- 
2.20.1.7.g153144c


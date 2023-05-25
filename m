Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9C27114C5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 20:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241897AbjEYSir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242035AbjEYSiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:38:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5957E2115;
        Thu, 25 May 2023 11:36:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6BB0648D7;
        Thu, 25 May 2023 18:35:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B8FFC433D2;
        Thu, 25 May 2023 18:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685039726;
        bh=PRWCD+xhEF1UZpcAgOovW3slI80wQJy3hmteQFBF7Aw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WryjnOAr5Yrk4dtaSb4qFtIYlevRojllHmbcpJOe9hHrzK1SLLEVx9cu32EE7Otpy
         DW37k5C3dmRGWu8D2CtADKFjApMaNpkemcPKK7lh2dbmX+X33EvG0EffwmSwIObUrB
         zfCAYCBBJVFqYl/AoFyy8JQt+X3KF2zwHLkXZ8nFTwKYFpNIxi89q/ROfKxZ/Sg8Fe
         tG3spPtNZhborHOnmbCG6RqLs+EPec1+1VeL8n+GvtsT1qaZctiRtYLHtT9tG4L0i8
         z9CdjOUjVZAHHK3RWftn9xKPr6po9/BESloLrKtraZ5pIvZljDnzD7hHO2Ot1cL/so
         zR9f4m2LqaiJg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Po-Wen Kao <powen.kao@mediatek.com>, Bean Huo <beanhuo@micron.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, jejb@linux.ibm.com,
        matthias.bgg@gmail.com, quic_cang@quicinc.com,
        quic_asutoshd@quicinc.com, alice.chao@mediatek.com,
        linux-scsi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.3 51/67] scsi: ufs: core: Fix MCQ nr_hw_queues
Date:   Thu, 25 May 2023 14:31:28 -0400
Message-Id: <20230525183144.1717540-51-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525183144.1717540-1-sashal@kernel.org>
References: <20230525183144.1717540-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

From: Po-Wen Kao <powen.kao@mediatek.com>

[ Upstream commit 72a81bb0b6fc9b759ac0fdaca3ec5884a8b2f304 ]

Since MAXQ is 0-based value, add one to obtain number of hardware queues.

Signed-off-by: Po-Wen Kao <powen.kao@mediatek.com>
Link: https://lore.kernel.org/r/20230504154454.26654-4-powen.kao@mediatek.com
Reviewed-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ufs/core/ufs-mcq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index 937933d3f77c2..51b3c6ae781df 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -150,7 +150,8 @@ static int ufshcd_mcq_config_nr_queues(struct ufs_hba *hba)
 	u32 hba_maxq, rem, tot_queues;
 	struct Scsi_Host *host = hba->host;
 
-	hba_maxq = FIELD_GET(MAX_QUEUE_SUP, hba->mcq_capabilities);
+	/* maxq is 0 based value */
+	hba_maxq = FIELD_GET(MAX_QUEUE_SUP, hba->mcq_capabilities) + 1;
 
 	tot_queues = UFS_MCQ_NUM_DEV_CMD_QUEUES + read_queues + poll_queues +
 			rw_queues;
-- 
2.39.2


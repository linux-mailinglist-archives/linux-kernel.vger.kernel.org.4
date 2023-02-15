Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCC2698416
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 20:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjBOTE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 14:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjBOTEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 14:04:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F6E39BB5;
        Wed, 15 Feb 2023 11:04:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 298B0B8236D;
        Wed, 15 Feb 2023 19:04:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A5EC433EF;
        Wed, 15 Feb 2023 19:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676487890;
        bh=FaRNhtG1pjZ8L7eZVmPD5vLGCZlfxjcuMkgF3wWZ6e4=;
        h=From:To:Cc:Subject:Date:From;
        b=pXCYJZ+b4a3P4bmJdT1ZZzw0DLBFCMTsfnN0V1uJMhdBT8zBZ/eMJfihC6nXXgNqa
         RrhVaRueDseaJcz7khXZYClYpq30BXgNXAuuJ9VMIOyQCoXTe0ao2d00PxMAzenUv1
         yLhSufoiL59X2Peh7kMzyf5Mf3rPgR79FlJU7Tnci/vCetZaRNYDRX+xnO2JMWzJoY
         zpoOncr7PYnS3bHA6yUe45K3UoN2CjW3kMgc1oAEeQQ8ZfjPJwxaH1E67RrTh9t+nV
         cNdWHAyyKHInOdXvnWVQCebmcOS7sbZJga6fUywLfQ9V+SdEX5wM6eGhNi99TyA/Xc
         NSt/HfeQRAraw==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Can Guo <cang@codeaurora.org>
Cc:     Jaegeuk Kim <jaegeuk@google.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] scsi: ufs: support IO traces for zoned block device
Date:   Wed, 15 Feb 2023 11:04:48 -0800
Message-Id: <20230215190448.1687786-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jaegeuk Kim <jaegeuk@google.com>

Let's support WRITE_16, READ_16, ZBC_IN, ZBC_OUT.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 drivers/ufs/core/ufshcd.c  | 8 ++++----
 include/trace/events/ufs.h | 4 +++-
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index e18c9f4463ec..235d2e2d828a 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -402,15 +402,15 @@ static void ufshcd_add_command_trace(struct ufs_hba *hba, unsigned int tag,
 
 	opcode = cmd->cmnd[0];
 
-	if (opcode == READ_10 || opcode == WRITE_10) {
-		/*
-		 * Currently we only fully trace read(10) and write(10) commands
-		 */
+	if (opcode == READ_10 || opcode == WRITE_10 ||
+				opcode == READ_16 || opcode == WRITE_16) {
 		transfer_len =
 		       be32_to_cpu(lrbp->ucd_req_ptr->sc.exp_data_transfer_len);
 		lba = scsi_get_lba(cmd);
 		if (opcode == WRITE_10)
 			group_id = lrbp->cmd->cmnd[6];
+		if (opcode == WRITE_16)
+			group_id = lrbp->cmd->cmnd[14];
 	} else if (opcode == UNMAP) {
 		/*
 		 * The number of Bytes to be unmapped beginning with the lba.
diff --git a/include/trace/events/ufs.h b/include/trace/events/ufs.h
index 599739ee7b20..f82a9e15fd78 100644
--- a/include/trace/events/ufs.h
+++ b/include/trace/events/ufs.h
@@ -18,7 +18,9 @@
 		{ READ_16,		"READ_16" },			\
 		{ READ_10,		"READ_10" },			\
 		{ SYNCHRONIZE_CACHE,	"SYNC" },			\
-		{ UNMAP,		"UNMAP" })
+		{ UNMAP,		"UNMAP" },			\
+		{ ZBC_IN,		"ZBC_IN" },			\
+		{ ZBC_OUT,		"ZBC_OUT" })
 
 #define UFS_LINK_STATES						\
 	EM(UIC_LINK_OFF_STATE,		"UIC_LINK_OFF_STATE")		\
-- 
2.39.1.581.gbfd45094c4-goog


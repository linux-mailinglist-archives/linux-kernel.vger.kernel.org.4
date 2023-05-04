Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7ACA6F75D0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 22:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbjEDUCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 16:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbjEDUBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 16:01:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C570A1890B;
        Thu,  4 May 2023 12:51:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38CB863846;
        Thu,  4 May 2023 19:49:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68A9C433EF;
        Thu,  4 May 2023 19:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683229789;
        bh=izABLxX+9a8wiRgDI3zSiWIjNG9o+UA2j3BELE3awTQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZmuJZnQRgaLkdSF+Z5kfWIqDK/kqXmJXpHEBXm4Pfz7AJHZkHJ00W5XxP6kO4mrMb
         53sm1CVjYcNq/K4dkpLYpde7BMzKNiV2B2hYHSTCq1LkJmsGiYytL2BiQN4/CDJiYc
         niQqICbHxsFms3nx0hhdrxXAt8N4kgiPIDZ5pTORKo2kfFttTt39AO08ZJIL+wMQyU
         yBkLWsZn5mmhnOEtfWbs6oSYcSrtJbtMDMh4u+DctkRgxlovoOn5iDCnc1p790eoPg
         j1lqynNbOP/kF7LH3PHL+Rz2GXstIGWKOrX8A4bDrvso6hPztmv33aVpR4Pz3g11em
         vpVTT6q4ki4Uw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Justin Tee <justin.tee@broadcom.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, james.smart@broadcom.com,
        dick.kennedy@broadcom.com, jejb@linux.ibm.com,
        linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 05/24] scsi: lpfc: Prevent lpfc_debugfs_lockstat_write() buffer overflow
Date:   Thu,  4 May 2023 15:49:18 -0400
Message-Id: <20230504194937.3808414-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504194937.3808414-1-sashal@kernel.org>
References: <20230504194937.3808414-1-sashal@kernel.org>
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

From: Justin Tee <justin.tee@broadcom.com>

[ Upstream commit c6087b82a9146826564a55c5ca0164cac40348f5 ]

A static code analysis tool flagged the possibility of buffer overflow when
using copy_from_user() for a debugfs entry.

Currently, it is possible that copy_from_user() copies more bytes than what
would fit in the mybuf char array.  Add a min() restriction check between
sizeof(mybuf) - 1 and nbytes passed from the userspace buffer to protect
against buffer overflow.

Link: https://lore.kernel.org/r/20230301231626.9621-2-justintee8345@gmail.com
Signed-off-by: Justin Tee <justin.tee@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc_debugfs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_debugfs.c b/drivers/scsi/lpfc/lpfc_debugfs.c
index fbc76d69ea0b4..2b77cbbcdccb6 100644
--- a/drivers/scsi/lpfc/lpfc_debugfs.c
+++ b/drivers/scsi/lpfc/lpfc_debugfs.c
@@ -2159,10 +2159,13 @@ lpfc_debugfs_lockstat_write(struct file *file, const char __user *buf,
 	char mybuf[64];
 	char *pbuf;
 	int i;
+	size_t bsize;
 
 	memset(mybuf, 0, sizeof(mybuf));
 
-	if (copy_from_user(mybuf, buf, nbytes))
+	bsize = min(nbytes, (sizeof(mybuf) - 1));
+
+	if (copy_from_user(mybuf, buf, bsize))
 		return -EFAULT;
 	pbuf = &mybuf[0];
 
@@ -2183,7 +2186,7 @@ lpfc_debugfs_lockstat_write(struct file *file, const char __user *buf,
 			qp->lock_conflict.wq_access = 0;
 		}
 	}
-	return nbytes;
+	return bsize;
 }
 #endif
 
-- 
2.39.2


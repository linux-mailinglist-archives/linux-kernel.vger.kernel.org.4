Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483CB6F74AD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 21:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjEDTw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 15:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbjEDTvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 15:51:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5914150F6;
        Thu,  4 May 2023 12:46:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E4336378D;
        Thu,  4 May 2023 19:46:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C949C4339C;
        Thu,  4 May 2023 19:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683229606;
        bh=nZM/AWGqSyHTp70fEuEdcirGn3Pwp5LUbpzLs2n5ud4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F0kaD8Rn9+dmJgcP6F2nY6sSK7XVFKmZjufbxr6espYovIQdnSFbMQPAfwFbx6mx2
         UihkxhCF1Y1Y3J41638sug8F5FMlFUpCoqvPL7VvHXjgdrXpWkmjzgMNxsVNi4FJb2
         8a7wrzm7nWk6Stu+cee4cyIsYjDRPT1gcqy4wMvWxsKIwuF5UBwEAzpBIkmD9WOwJJ
         tQ2l9n/KDVb8hks4RT1ruc2iOgCc/0QkY8SVO/BC6Ybm25Ux9XNgPIkoT5dR7NaX/X
         X0soJmg52E6ZOUHQI2iQMzrYYFuzrBlgQxMnd898/20GcVfeE3c1ycbwSrel1CB0xe
         HPA/WQY4OB9mg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Justin Tee <justin.tee@broadcom.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, james.smart@broadcom.com,
        dick.kennedy@broadcom.com, jejb@linux.ibm.com,
        linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 08/49] scsi: lpfc: Correct used_rpi count when devloss tmo fires with no recovery
Date:   Thu,  4 May 2023 15:45:45 -0400
Message-Id: <20230504194626.3807438-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504194626.3807438-1-sashal@kernel.org>
References: <20230504194626.3807438-1-sashal@kernel.org>
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

[ Upstream commit db651ec22524eb8f9c854fbb4d9acd5d7e5be9e4 ]

A fabric controller can sometimes send an RDP request right before a link
down event.  Because of this outstanding RDP request, the driver does not
remove the last reference count on its ndlp causing a potential leak of RPI
resources when devloss tmo fires.

In lpfc_cmpl_els_rsp(), modify the NPIV clause to always allow the
lpfc_drop_node() routine to execute when not registered with SCSI
transport.

This relaxes the contraint that an NPIV ndlp must be in a specific state in
order to call lpfc_drop node.  Logic is revised such that the
lpfc_drop_node() routine is always called to ensure the last ndlp decrement
occurs.

Signed-off-by: Justin Tee <justin.tee@broadcom.com>
Link: https://lore.kernel.org/r/20230301231626.9621-7-justintee8345@gmail.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc_els.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index 863b2125fed6c..ddd5949d8fc01 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -5402,18 +5402,20 @@ lpfc_cmpl_els_rsp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	 * these conditions and release the RPI.
 	 */
 	if (phba->sli_rev == LPFC_SLI_REV4 &&
-	    (vport && vport->port_type == LPFC_NPIV_PORT) &&
-	    !(ndlp->fc4_xpt_flags & SCSI_XPT_REGD) &&
-	    ndlp->nlp_flag & NLP_RELEASE_RPI) {
-		if (ndlp->nlp_state !=  NLP_STE_PLOGI_ISSUE &&
-		    ndlp->nlp_state != NLP_STE_REG_LOGIN_ISSUE) {
-			lpfc_sli4_free_rpi(phba, ndlp->nlp_rpi);
-			spin_lock_irq(&ndlp->lock);
-			ndlp->nlp_rpi = LPFC_RPI_ALLOC_ERROR;
-			ndlp->nlp_flag &= ~NLP_RELEASE_RPI;
-			spin_unlock_irq(&ndlp->lock);
-			lpfc_drop_node(vport, ndlp);
+	    vport && vport->port_type == LPFC_NPIV_PORT &&
+	    !(ndlp->fc4_xpt_flags & SCSI_XPT_REGD)) {
+		if (ndlp->nlp_flag & NLP_RELEASE_RPI) {
+			if (ndlp->nlp_state != NLP_STE_PLOGI_ISSUE &&
+			    ndlp->nlp_state != NLP_STE_REG_LOGIN_ISSUE) {
+				lpfc_sli4_free_rpi(phba, ndlp->nlp_rpi);
+				spin_lock_irq(&ndlp->lock);
+				ndlp->nlp_rpi = LPFC_RPI_ALLOC_ERROR;
+				ndlp->nlp_flag &= ~NLP_RELEASE_RPI;
+				spin_unlock_irq(&ndlp->lock);
+			}
 		}
+
+		lpfc_drop_node(vport, ndlp);
 	}
 
 	/* Release the originating I/O reference. */
-- 
2.39.2


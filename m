Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08DB6F7475
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 21:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjEDTuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 15:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbjEDTtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 15:49:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB8BAD0B;
        Thu,  4 May 2023 12:45:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D670C6376C;
        Thu,  4 May 2023 19:44:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65919C433EF;
        Thu,  4 May 2023 19:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683229482;
        bh=tKW8dUpdhSHpT2lZhf4Flzj//Bbc/0xy7Svv4E1su60=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gjy/vR8SGSH+GUO2ZXfQRKFvQgTyoErMBfcCkBABx+uquRJeSlT0r/U3ZnINJtOh3
         7FZpTLig7l9MGRsbqgOItDqFgUaIqd9q7cfsWHzW5fFQdvsa9KBqwktd/1qojiynDR
         6iF2iDmMYcUbEe73m8aVDcsu285fczKn4gzDbpnDChgRIh+pnpqv5A1Bp3mfFwbqOz
         tjQ3EmpfDvuJY/SwgoWt2G/vQ09h90a3ZbrPBYlA1KEziy2zYwmVIo4xsvDhm0jrC9
         dvqiOxRMTpbSK77ueJe2dRdcftQ1/Aj8/iBgtQcZz+jJMtsqLQGL9mutfbqPFdvHM1
         onbMYwu7VWS+A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Justin Tee <justin.tee@broadcom.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, james.smart@broadcom.com,
        dick.kennedy@broadcom.com, jejb@linux.ibm.com,
        linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.2 09/53] scsi: lpfc: Correct used_rpi count when devloss tmo fires with no recovery
Date:   Thu,  4 May 2023 15:43:29 -0400
Message-Id: <20230504194413.3806354-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504194413.3806354-1-sashal@kernel.org>
References: <20230504194413.3806354-1-sashal@kernel.org>
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
index 919741bbe267b..05719bd97f4d4 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -5428,18 +5428,20 @@ lpfc_cmpl_els_rsp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
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


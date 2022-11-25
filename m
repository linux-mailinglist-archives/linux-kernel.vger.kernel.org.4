Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1775163862C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 10:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiKYJ1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 04:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiKYJ1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 04:27:20 -0500
Received: from smtp.smtpout.orange.fr (smtp-27.smtpout.orange.fr [80.12.242.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A052AC6B
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 01:27:18 -0800 (PST)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id yUzKo4Eiu1SdMyUzKoWrLE; Fri, 25 Nov 2022 10:27:16 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 25 Nov 2022 10:27:16 +0100
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-scsi@vger.kernel.org
Subject: [PATCH] scsi: lpfc: Remove a useless variable
Date:   Fri, 25 Nov 2022 10:27:13 +0100
Message-Id: <0fa467c115ad75ba28959c909751abf2bfd2a30a.1669368420.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no point in using 'error' here. All other paths use 'rc'.
So use it here as well and remove the 'error' variable.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/scsi/lpfc/lpfc_init.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 25ba20e42825..6e85af92fb01 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -4700,7 +4700,6 @@ lpfc_create_port(struct lpfc_hba *phba, int instance, struct device *dev)
 	struct lpfc_vport *vport;
 	struct Scsi_Host  *shost = NULL;
 	struct scsi_host_template *template;
-	int error = 0;
 	int i;
 	uint64_t wwn;
 	bool use_no_reset_hba = false;
@@ -4829,8 +4828,8 @@ lpfc_create_port(struct lpfc_hba *phba, int instance, struct device *dev)
 	if (phba->sli3_options & LPFC_SLI3_BG_ENABLED)
 		lpfc_setup_bg(phba, shost);
 
-	error = scsi_add_host_with_dma(shost, dev, &phba->pcidev->dev);
-	if (error)
+	rc = scsi_add_host_with_dma(shost, dev, &phba->pcidev->dev);
+	if (rc)
 		goto out_free_vmid;
 
 	spin_lock_irq(&phba->port_list_lock);
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7266E6D3E65
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 09:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbjDCHtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 03:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbjDCHtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 03:49:01 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BA844AE;
        Mon,  3 Apr 2023 00:48:59 -0700 (PDT)
Received: from DESKTOP-7O4H7L3.localdomain ([10.12.183.64])
        (user=lishuchang@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 3337mgo2026190-3337mgo3026190
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 3 Apr 2023 15:48:42 +0800
From:   lishuchang@hust.edu.cn
To:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     hust-os-kernel-patches@googlegroups.com,
        Shuchang Li <lishuchang@hust.edu.cn>,
        Dongliang Mu <dzm91@hust.edu.cn>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: lpfc: fix ioremap issues in 'lpfc_sli4_pci_mem_setup'
Date:   Mon,  3 Apr 2023 15:48:21 +0800
Message-Id: <20230403074821.5121-1-lishuchang@hust.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: lishuchang@hust.edu.cn
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shuchang Li <lishuchang@hust.edu.cn>

When if_type equals to zero and pci_resource_start(pdev, PCI_64BIT_BAR4)
returns false, drbl_regs_memmap_p is not remapped. However, in the code
it goes to out_iounmap_all, where drbl_regs_memmap_p is unmapped. This
may cause some problems.

When if_type equals to six and pci_resource_start(pdev, PCI_64BIT_BAR4)
returns true, drbl_regs_memmap_p may has been remapped and
ctrl_regs_memmap_p is not remapped. However in the code it goes to
out_iounmap_ctrl, where ctrl_regs_memmap_p is unmapped and
drbl_regs_memmap_p is not unmapped. This may cause a leak and
some other problems.

To fix these issues, we need to add null checks before iounmap(), and
change some goto lables.

Signed-off-by: Shuchang Li <lishuchang@hust.edu.cn>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
---
 drivers/scsi/lpfc/lpfc_init.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 4f7485958c49..bd5e734487e3 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -12026,7 +12026,7 @@ lpfc_sli4_pci_mem_setup(struct lpfc_hba *phba)
 				goto out_iounmap_all;
 		} else {
 			error = -ENOMEM;
-			goto out_iounmap_all;
+			goto out_iounmap_ctrl;
 		}
 	}
 
@@ -12044,7 +12044,7 @@ lpfc_sli4_pci_mem_setup(struct lpfc_hba *phba)
 			dev_err(&pdev->dev,
 			   "ioremap failed for SLI4 HBA dpp registers.\n");
 			error = -ENOMEM;
-			goto out_iounmap_ctrl;
+			goto out_iounmap_all;
 		}
 		phba->pci_bar4_memmap_p = phba->sli4_hba.dpp_regs_memmap_p;
 	}
@@ -12069,9 +12069,11 @@ lpfc_sli4_pci_mem_setup(struct lpfc_hba *phba)
 	return 0;
 
 out_iounmap_all:
-	iounmap(phba->sli4_hba.drbl_regs_memmap_p);
+	if (!phba->sli4_hba.drbl_regs_memmap_p)
+		iounmap(phba->sli4_hba.drbl_regs_memmap_p);
 out_iounmap_ctrl:
-	iounmap(phba->sli4_hba.ctrl_regs_memmap_p);
+	if (!phba->sli4_hba.ctrl_regs_memmap_p)
+		iounmap(phba->sli4_hba.ctrl_regs_memmap_p);
 out_iounmap_conf:
 	iounmap(phba->sli4_hba.conf_regs_memmap_p);
 
-- 
2.25.1


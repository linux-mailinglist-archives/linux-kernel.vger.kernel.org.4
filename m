Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3006D5966
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 09:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbjDDHXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 03:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233864AbjDDHXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 03:23:05 -0400
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE8310E3;
        Tue,  4 Apr 2023 00:23:03 -0700 (PDT)
Received: from DESKTOP-7O4H7L3.localdomain ([10.12.183.64])
        (user=lishuchang@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 3347LYuw012411-3347LYux012411
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Tue, 4 Apr 2023 15:21:34 +0800
From:   lishuchang@hust.edu.cn
To:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     hust-os-kernel-patches@googlegroups.com,
        Shuchang Li <lishuchang@hust.edu.cn>,
        James Smart <jsmart2021@gmail.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] scsi: lpfc: fix ioremap issues in 'lpfc_sli4_pci_mem_setup'
Date:   Tue,  4 Apr 2023 15:21:32 +0800
Message-Id: <20230404072133.1022-1-lishuchang@hust.edu.cn>
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
returns false, drbl_regs_memmap_p is not remapped.This passes a NULL
pointer to iounmap(), which can trigger a WARN() on certain arches.

When if_type equals to six and pci_resource_start(pdev, PCI_64BIT_BAR4)
returns true, drbl_regs_memmap_p may has been remapped and
ctrl_regs_memmap_p is not remapped. This is a resource leak and passes
a NULL pointer to iounmap().

To fix these issues, we need to add null checks before iounmap(), and
change some goto lables.

Fixes: 1351e69fc6db ("scsi: lpfc: Add push-to-adapter support to sli4")
Signed-off-by: Shuchang Li <lishuchang@hust.edu.cn>
---
 drivers/scsi/lpfc/lpfc_init.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 4f7485958c49..ed75230b0209 100644
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
+	if (phba->sli4_hba.drbl_regs_memmap_p)
+		iounmap(phba->sli4_hba.drbl_regs_memmap_p);
 out_iounmap_ctrl:
-	iounmap(phba->sli4_hba.ctrl_regs_memmap_p);
+	if (phba->sli4_hba.ctrl_regs_memmap_p)
+		iounmap(phba->sli4_hba.ctrl_regs_memmap_p);
 out_iounmap_conf:
 	iounmap(phba->sli4_hba.conf_regs_memmap_p);
 
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C039A6AF229
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 19:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbjCGSut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 13:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbjCGSu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 13:50:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E005B049D;
        Tue,  7 Mar 2023 10:38:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97208B819CB;
        Tue,  7 Mar 2023 18:29:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 351E8C433A1;
        Tue,  7 Mar 2023 18:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678213742;
        bh=+PdG7LuHo65TVW4uUUZYYgxV38NtxliWQLubFtzevCU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SY7quN1LIgI9KYymuTOsWKvhQ5k0evvTaneTECnRFOvHxsEA9nDLe1yAlauzuEaeA
         wBJGLPGQ6jDCt2CFx+ELZyKZSjdC9s5tG/zRpS1jKQMONKJHjILx6cHD1fNc0DGCus
         dscMFNuOpEB57RsRHo4LyLf5ic1cTvp00XWxO7yady8VcOPU7UCWXyeaDT8wKw2Zyq
         QSfgdJCv5DNax4W3/7I06Aa5KCkov98uVmF8wh2ugIYWoPGmr9myfHHcbuWSQRD/K9
         R9/V9++fAGNuVSVdwE+epUGjC9RTz3Hzjj+NSaOGVGBfDHBnpAOYeu9mKfaaqbw22M
         dOpMu/MIdj87g==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Don Brace <don.brace@microchip.com>, storagedev@microchip.com
Subject: [PATCH 06/10] scsi: hpsa: Remove unnecessary pci_disable_pcie_error_reporting() comment
Date:   Tue,  7 Mar 2023 12:28:38 -0600
Message-Id: <20230307182842.870378-7-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230307182842.870378-1-helgaas@kernel.org>
References: <20230307182842.870378-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

105a3dbc7452 ("hpsa: clean up driver init") added a comment about
pci_disable_pcie_error_reporting(), but hpsa has never called either
pci_enable_pcie_error_reporting() or pci_disable_pcie_error_reporting().

Since f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is
native"), the PCI core is responsible for managing PCIe device error
reporting.

Remove the comment about pci_disable_pcie_error_reporting().

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Don Brace <don.brace@microchip.com>
Cc: storagedev@microchip.com
---
 drivers/scsi/hpsa.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index f6da34850af9..fec7e17747f7 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -9108,7 +9108,6 @@ static void hpsa_remove_one(struct pci_dev *pdev)
 
 	free_percpu(h->lockup_detected);		/* init_one 2 */
 	h->lockup_detected = NULL;			/* init_one 2 */
-	/* (void) pci_disable_pcie_error_reporting(pdev); */	/* init_one 1 */
 
 	hpda_free_ctlr_info(h);				/* init_one 1 */
 }
-- 
2.25.1


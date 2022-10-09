Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED195F89B4
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 08:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiJIGbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 02:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiJIGbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 02:31:37 -0400
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A972FC0C
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 23:31:35 -0700 (PDT)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id hPqWoUhz7OizNhPqWoCaRp; Sun, 09 Oct 2022 08:31:33 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 09 Oct 2022 08:31:33 +0200
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Vishal Bhakta <vbhakta@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Cathy Avery <cavery@redhat.com>,
        "Ewan D. Milne" <emilne@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Zheyu Ma <zheyuma97@gmail.com>, linux-scsi@vger.kernel.org
Subject: [PATCH] scsi: vmw_pvscsi: Fix an error handling path in pvscsi_probe()
Date:   Sun,  9 Oct 2022 08:31:24 +0200
Message-Id: <ed31652626b0d8133e90f6888ef2b56cbc46ee57.1665297058.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In all paths that end to "out_release_resources_and_disable", neither
pci_alloc_irq_vectors() nor request_irq() have been called yet. So, there
is no point in calling pvscsi_shutdown_intr() which undoes these calls.

Remove this erroneous call.

This should fix the bug report in [1].

[1]: https://lore.kernel.org/all/CAMhUBjnDdk7_bBzqgFhZ=xf-obJYMbsJf10wC_bsUeTzxXLK6A@mail.gmail.com/

Reported-by: Zheyu Ma <zheyuma97@gmail.com>
Fixes: 02f425f811ce ("scsi: vmw_pscsi: Rearrange code to avoid multiple calls to free_irq during unload")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
The Fixes: tag is maybe not optimal, the issue was there even before.
But I think that this commit reference should help in case of backport
(and it makes git-mail add Dan automagically in copy :) )
---
 drivers/scsi/vmw_pvscsi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/vmw_pvscsi.c b/drivers/scsi/vmw_pvscsi.c
index f88ecdb93a8a..1c8a72520e5b 100644
--- a/drivers/scsi/vmw_pvscsi.c
+++ b/drivers/scsi/vmw_pvscsi.c
@@ -1555,7 +1555,6 @@ static int pvscsi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return error;
 
 out_release_resources_and_disable:
-	pvscsi_shutdown_intr(adapter);
 	pvscsi_release_resources(adapter);
 	goto out_disable_device;
 }
-- 
2.34.1


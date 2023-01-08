Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE7966161F
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 16:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235027AbjAHPTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 10:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233807AbjAHPTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 10:19:11 -0500
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82547DF32;
        Sun,  8 Jan 2023 07:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1673191141; bh=A/eTZH7R8HYi3G8I9qn02EbBgc4fZ4a7jDAb8QMp5Ys=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=osnVmplmhvSBBoGzBLw94CL+qOdSJTKctykFzv6GB1khlj1gNR42T6cuXJ5wCiWRk
         D43WD9rTDMX4po3OPLawBkHpncJDRiqamwm1u29RAfaCGq0BGITF4hXvp0wBJWZNQZ
         AvXdJdESSornM0VrIbiTZcP3rn2wXtoCrG1WR04I=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sun,  8 Jan 2023 16:19:01 +0100 (CET)
X-EA-Auth: +LxKYHCdtFrREOXbK0ZeZCL9zE7QZ+NmrD0pJzlqCIVZmuEPfq60W4RWKXNWI4IyuKpPOJwbR5xYtnq3/cO2C8Tkc9zImSv6
Date:   Sun, 8 Jan 2023 20:48:56 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Brian King <brking@us.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Subject: [PATCH] scsi: ipr: Convert ipr_probe_ioa_part2 as void
Message-ID: <Y7re4OsT80mLPbQI@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert function ipr_probe_ioa_part2() to return void instead
of int since the current implementation always returns 0 to the caller.
The transformation also eliminates the dead code when calling
ipr_probe_ioa_part2() function.
Issue identified using returnvar Coccinelle semantic patch.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/scsi/ipr.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
index 2022ffb45041..2e3e12c83277 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -9504,12 +9504,9 @@ static pci_ers_result_t ipr_pci_error_detected(struct pci_dev *pdev,
  * Description: This is the second phase of adapter initialization
  * This function takes care of initilizing the adapter to the point
  * where it can accept new commands.
- * Return value:
- * 	0 on success / -EIO on failure
  **/
-static int ipr_probe_ioa_part2(struct ipr_ioa_cfg *ioa_cfg)
+static void ipr_probe_ioa_part2(struct ipr_ioa_cfg *ioa_cfg)
 {
-	int rc = 0;
 	unsigned long host_lock_flags = 0;

 	ENTER;
@@ -9525,7 +9522,6 @@ static int ipr_probe_ioa_part2(struct ipr_ioa_cfg *ioa_cfg)
 	spin_unlock_irqrestore(ioa_cfg->host->host_lock, host_lock_flags);

 	LEAVE;
-	return rc;
 }

 /**
@@ -10568,12 +10564,7 @@ static int ipr_probe(struct pci_dev *pdev, const struct pci_device_id *dev_id)
 		return rc;

 	ioa_cfg = pci_get_drvdata(pdev);
-	rc = ipr_probe_ioa_part2(ioa_cfg);
-
-	if (rc) {
-		__ipr_remove(pdev);
-		return rc;
-	}
+	ipr_probe_ioa_part2(ioa_cfg);

 	rc = scsi_add_host(ioa_cfg->host, &pdev->dev);

--
2.34.1




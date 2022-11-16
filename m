Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140F462B6E8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 10:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbiKPJul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 04:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiKPJuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 04:50:39 -0500
X-Greylist: delayed 382 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 16 Nov 2022 01:50:37 PST
Received: from forward106p.mail.yandex.net (forward106p.mail.yandex.net [77.88.28.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0109E266B;
        Wed, 16 Nov 2022 01:50:37 -0800 (PST)
Received: from sas2-e7f6fb703652.qloud-c.yandex.net (sas2-e7f6fb703652.qloud-c.yandex.net [IPv6:2a02:6b8:c14:4fa6:0:640:e7f6:fb70])
        by forward106p.mail.yandex.net (Yandex) with ESMTP id 6304D2FC33E0;
        Wed, 16 Nov 2022 12:41:52 +0300 (MSK)
Received: by sas2-e7f6fb703652.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id 3Hc0AlxaOn-fpVKvwam;
        Wed, 16 Nov 2022 12:41:51 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1668591711;
        bh=NxC0GTnHZ1GOnkVDWk1bYH/JQTZsJK3+UhL5Lol/IJ4=;
        h=Message-Id:Date:Cc:Subject:To:From;
        b=m8kbW1UotzyT81MDCGb5fPDRmKTigL06CtgPp5k5k80ZQBJ+w26nET4PZ42vdOw5G
         LlU10SuRHU9maAcN5WVIqL7zb+Dqfc7Z/ttBgc0+UmdBFiFyvi9qfrFHZbuQZMm+kf
         nmS+ltiy9ws7LrVDJC3X3JEfdtS8G0DDgXlaITV4=
Authentication-Results: sas2-e7f6fb703652.qloud-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Peter Kosyh <pkosyh@yandex.ru>
To:     Hannes Reinecke <hare@kernel.org>
Cc:     Peter Kosyh <pkosyh@yandex.ru>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: [PATCH] scsi: myrs: check return value of dma_alloc_coherent() instead of using dma_mapping_error()
Date:   Wed, 16 Nov 2022 12:41:47 +0300
Message-Id: <20221116094147.221640-1-pkosyh@yandex.ru>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_alloc_coherent() may leave third parameter uninitialized. So
it is not safe to use dma_mapping_error() without checking return
value of dma_alloc_coherent().

Check the return value of dma_alloc_coherent() to detect
an error.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Peter Kosyh <pkosyh@yandex.ru>
---
 drivers/scsi/myrs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/myrs.c b/drivers/scsi/myrs.c
index 7eb8c39da366..1811c1a6385b 100644
--- a/drivers/scsi/myrs.c
+++ b/drivers/scsi/myrs.c
@@ -498,14 +498,14 @@ static bool myrs_enable_mmio_mbox(struct myrs_hba *cs,
 	/* Temporary dma mapping, used only in the scope of this function */
 	mbox = dma_alloc_coherent(&pdev->dev, sizeof(union myrs_cmd_mbox),
 				  &mbox_addr, GFP_KERNEL);
-	if (dma_mapping_error(&pdev->dev, mbox_addr))
+	if (!mbox)
 		return false;
 
 	/* These are the base addresses for the command memory mailbox array */
 	cs->cmd_mbox_size = MYRS_MAX_CMD_MBOX * sizeof(union myrs_cmd_mbox);
 	cmd_mbox = dma_alloc_coherent(&pdev->dev, cs->cmd_mbox_size,
 				      &cs->cmd_mbox_addr, GFP_KERNEL);
-	if (dma_mapping_error(&pdev->dev, cs->cmd_mbox_addr)) {
+	if (!cmd_mbox) {
 		dev_err(&pdev->dev, "Failed to map command mailbox\n");
 		goto out_free;
 	}
-- 
2.38.1


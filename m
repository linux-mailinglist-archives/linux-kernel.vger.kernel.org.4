Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF5F6E4D7D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 17:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjDQPng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 11:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjDQPne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 11:43:34 -0400
X-Greylist: delayed 1788 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 17 Apr 2023 08:43:27 PDT
Received: from gw.red-soft.ru (red-soft.ru [188.246.186.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E60DD184;
        Mon, 17 Apr 2023 08:43:27 -0700 (PDT)
Received: from arch.red-soft.biz (unknown [10.81.81.211])
        by gw.red-soft.ru (Postfix) with ESMTPA id 0C4803E10E2;
        Mon, 17 Apr 2023 18:08:03 +0300 (MSK)
From:   Artem Chernyshev <artem.chernyshev@red-soft.ru>
To:     Don Brace <don.brace@microchip.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc:     Artem Chernyshev <artem.chernyshev@red-soft.ru>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        storagedev@microchip.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: [PATCH] scsi: hpsa: Remove unreachable code
Date:   Mon, 17 Apr 2023 18:07:57 +0300
Message-Id: <20230417150757.62902-1-artem.chernyshev@red-soft.ru>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 176767 [Apr 17 2023]
X-KLMS-AntiSpam-Version: 5.9.59.0
X-KLMS-AntiSpam-Envelope-From: artem.chernyshev@red-soft.ru
X-KLMS-AntiSpam-Rate: 0
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Auth: dkim=none
X-KLMS-AntiSpam-Info: LuaCore: 509 509 b12bcaa7ba85624b485f2b6b92324b70964a1c65, {Tracking_from_domain_doesnt_match_to}, red-soft.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;arch.red-soft.biz:7.1.1
X-MS-Exchange-Organization-SCL: -1
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: Clean, bases: 2023/04/17 13:10:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2023/04/17 09:07:00 #21118574
X-KLMS-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hpsa_lookup_board_id() can't return negative value, so we can
remove redundant if-statement

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: c8cd71f1f32a ("scsi: hpsa: Remove 'hpsa_allow_any' module option")
Signed-off-by: Artem Chernyshev <artem.chernyshev@red-soft.ru>
---
 drivers/scsi/hpsa.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index f6da34850af9..caf04295efac 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -7871,8 +7871,6 @@ static int hpsa_pci_init(struct ctlr_info *h)
 	bool legacy_board;
 
 	prod_index = hpsa_lookup_board_id(h->pdev, &h->board_id, &legacy_board);
-	if (prod_index < 0)
-		return prod_index;
 	h->product_name = products[prod_index].product_name;
 	h->access = *(products[prod_index].access);
 	h->legacy_board = legacy_board;
@@ -8670,12 +8668,7 @@ static int hpsa_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (number_of_controllers == 0)
 		printk(KERN_INFO DRIVER_NAME "\n");
 
-	rc = hpsa_lookup_board_id(pdev, &board_id, NULL);
-	if (rc < 0) {
-		dev_warn(&pdev->dev, "Board ID not found\n");
-		return rc;
-	}
-
+	hpsa_lookup_board_id(pdev, &board_id, NULL);
 	rc = hpsa_init_reset_devices(pdev, board_id);
 	if (rc) {
 		if (rc != -ENOTSUPP)
-- 
2.40.0


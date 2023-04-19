Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69A76E80AE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 19:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbjDSRzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 13:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjDSRzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 13:55:17 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA594ECB
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 10:55:16 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d10-20020a25cd0a000000b00b956d4a5a04so183533ybf.22
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 10:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681926915; x=1684518915;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hfKbsTvYMuDBJ3f8L2RgBa2t3+n8sbG5Rzd4mp8z1KE=;
        b=0pVIsViMHhkGqQpcek7+vhQ9W+oXFYe2LJRj96FsB7BgMi5SHS8QW+hLSYNgTqPtxn
         JqAsWl3L5h4nCg4EsUZXeKVPpMirFYNYyvmtzfqPP/ExjsfGXKM9nW1XUOTSAMzEOk8t
         OS07Yr4msyQd4vett/5WwJ/HRb/IN6AqQKI53ZJpfpOzYe1aJ3x+3vOOchmscpaJA7YA
         mDrn0KgKwCfHiunTE3uSxpmLMGMLZ1nuzM38wmnvF8u1BXlcWpRyG7aRALIShGn5RUWx
         CISnbxXrKjnph1jESJ6/0zWPu8yafJ5p+coupXok/+zO06hgDI2Ys5G1i52+zf6nuXX6
         1c0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681926915; x=1684518915;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hfKbsTvYMuDBJ3f8L2RgBa2t3+n8sbG5Rzd4mp8z1KE=;
        b=ChjaE87DJR7RdSv0Pbosu+HADov8hOp4VXMJdxUrcCUrb/AWa3P+6BjZGhjsEUs39B
         8aVRbxa4mBK7uLPA4XWWDulWON1udhTYuRO34jzXBQGFJl2YGieHgE9sANl5GhQZ1GeX
         d1NvsVkatZfbAYWnO/hQVdQAD97XbZPfCdDhRPmJYzuhdEuIVG/kikaXNZc6zwlDWhOV
         QC30CQoIIrwNXNfUzK3uRRxFBsxEnJJwY2iAej6cYcwuIhawmTmf3pCENBvkVzUF4x6C
         44x8Vc2lIsxxJvFOD/3kNkgSE3JUcYI2L1eg4fGP+hl/r0+PWkzSwXpCbSLAq1O8XiOT
         A/mQ==
X-Gm-Message-State: AAQBX9colqxV6MZAhn7qa/lM7L/y/Xrb8jA1wjPuEj/9zkNrJJ3Pq80X
        O6ctPRTR3bHJksMQvgNWV6YwJauAnfe4iw==
X-Google-Smtp-Source: AKy350ZnW4FMeGR7MYtF5Mj6A5GrZFl9LH1s+yJ9nRosIkTgHK6BQTU8w1BwI09rAqNvtLTH2oaG5zjMKLs9LQ==
X-Received: from pranav-first.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:390b])
 (user=pranavpp job=sendgmr) by 2002:a25:d0d2:0:b0:b92:5a75:9f55 with SMTP id
 h201-20020a25d0d2000000b00b925a759f55mr377324ybg.1.1681926915241; Wed, 19 Apr
 2023 10:55:15 -0700 (PDT)
Date:   Wed, 19 Apr 2023 17:55:02 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230419175502.919999-1-pranavpp@google.com>
Subject: [PATCH] scsi: pm80xx: Add GET_NVMD timeout during probe
From:   Pranav Prasad <pranavpp@google.com>
To:     Jack Wang <jinpu.wang@cloud.ionos.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changyuan Lyu <changyuanl@google.com>,
        Pranav Prasad <pranavpp@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changyuan Lyu <changyuanl@google.com>

Added a wait timeout to prevent the kernel from waiting for the 
GET_NVMD response forever during probe. Added a check for the
controller state before issuing GET_NVMD request.

Signed-off-by: Changyuan Lyu <changyuanl@google.com>
Signed-off-by: Pranav Prasad <pranavpp@google.com>
---
 drivers/scsi/pm8001/pm8001_init.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index 7e589fe3e010..5ca20ccdce34 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -666,7 +666,7 @@ static void  pm8001_post_sas_ha_init(struct Scsi_Host *shost,
  * Currently we just set the fixed SAS address to our HBA, for manufacture,
  * it should read from the EEPROM
  */
-static void pm8001_init_sas_add(struct pm8001_hba_info *pm8001_ha)
+static int pm8001_init_sas_add(struct pm8001_hba_info *pm8001_ha)
 {
 	u8 i, j;
 	u8 sas_add[8];
@@ -679,6 +679,12 @@ static void pm8001_init_sas_add(struct pm8001_hba_info *pm8001_ha)
 	struct pm8001_ioctl_payload payload;
 	u16 deviceid;
 	int rc;
+	unsigned long time_remaining;
+
+	if (PM8001_CHIP_DISP->fatal_errors(pm8001_ha)) {
+		pm8001_dbg(pm8001_ha, FAIL, "controller is in fatal error state\n");
+		return -EIO;
+	}
 
 	pci_read_config_word(pm8001_ha->pdev, PCI_DEVICE_ID, &deviceid);
 	pm8001_ha->nvmd_completion = &completion;
@@ -703,16 +709,23 @@ static void pm8001_init_sas_add(struct pm8001_hba_info *pm8001_ha)
 	payload.offset = 0;
 	payload.func_specific = kzalloc(payload.rd_length, GFP_KERNEL);
 	if (!payload.func_specific) {
-		pm8001_dbg(pm8001_ha, INIT, "mem alloc fail\n");
-		return;
+		pm8001_dbg(pm8001_ha, FAIL, "mem alloc fail\n");
+		return -ENOMEM;
 	}
 	rc = PM8001_CHIP_DISP->get_nvmd_req(pm8001_ha, &payload);
 	if (rc) {
 		kfree(payload.func_specific);
-		pm8001_dbg(pm8001_ha, INIT, "nvmd failed\n");
-		return;
+		pm8001_dbg(pm8001_ha, FAIL, "nvmd failed\n");
+		return -EIO;
+	}
+	time_remaining = wait_for_completion_timeout(&completion,
+				msecs_to_jiffies(60*1000)); // 1 min
+	if (!time_remaining) {
+		kfree(payload.func_specific);
+		pm8001_dbg(pm8001_ha, FAIL, "get_nvmd_req timeout\n");
+		return -EIO;
 	}
-	wait_for_completion(&completion);
+
 
 	for (i = 0, j = 0; i <= 7; i++, j++) {
 		if (pm8001_ha->chip_id == chip_8001) {
@@ -751,6 +764,7 @@ static void pm8001_init_sas_add(struct pm8001_hba_info *pm8001_ha)
 	memcpy(pm8001_ha->sas_addr, &pm8001_ha->phy[0].dev_sas_addr,
 		SAS_ADDR_SIZE);
 #endif
+	return 0;
 }
 
 /*
@@ -1166,7 +1180,8 @@ static int pm8001_pci_probe(struct pci_dev *pdev,
 		pm80xx_set_thermal_config(pm8001_ha);
 	}
 
-	pm8001_init_sas_add(pm8001_ha);
+	if (pm8001_init_sas_add(pm8001_ha))
+		goto err_out_shost;
 	/* phy setting support for motherboard controller */
 	rc = pm8001_configure_phy_settings(pm8001_ha);
 	if (rc)
-- 
2.40.0.634.g4ca3ef3211-goog


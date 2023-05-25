Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2AFF711A8D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 01:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbjEYXXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 19:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjEYXXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 19:23:47 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C0FE7;
        Thu, 25 May 2023 16:23:45 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-64d2b42a8f9so258763b3a.3;
        Thu, 25 May 2023 16:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685057025; x=1687649025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hxbKJUJKqBY+tS9q6+K4HDHYk7g6aDfMbgst5Uvaw3k=;
        b=CWUVCtDWP0g8/O5hFjQlXi2JULVtC9RDVYwXWbuSsaGLnwPQW+wJy9L/C1gjPTKKDr
         6NReYYfOwm9wFcdINIUDFENMZjGbWQGa95iFE3wZpX1O2dg3PPUFOdy2NzGCjjHA0ZY6
         WyCh0bKEa/K8qccNtrtMWPFt6VSellyXzu5yStPXrlPkdIMRQx8ohCFINBZboquXKgC7
         6/uZabIaqgvOD1+paF7x7zpMav+p9kHp7sH4/IrigSXHuUmLztk9MGzY16YiyCgod9T4
         lz9M3seLbVRn4/UFHE3NDyfc5xFvT3q9pJRzn57pMIQg/j58O8GeliNDJOSiZb7xcN41
         14NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685057025; x=1687649025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hxbKJUJKqBY+tS9q6+K4HDHYk7g6aDfMbgst5Uvaw3k=;
        b=lf2i/j5bzVc3GypjpgA/9SeGfR2V1sh5dZlTSJjo7nciRdWoO4u+u9Ft7fZPDXWn68
         UxSIi/BGSCKJFmAxMcgabYvG04K9+AU0NQE06TZSYBz8G1I6bp1oUGI9e7p8xjSJGV0u
         2lYYqhoRAxCB6yuOLqvIHyfbg8Oxn7rh2ayhMrb6031W0yyqiXTqFaApRxZAhzv5cMsy
         fzW1ESSu6UedbNET5sYbQ17TavK9bqB8qKPjmi9CialOaa/XE+GSTeGoir//2nWihX+R
         Jto/Yr1cyCQXXGWsNubJ0yG4P1wkufLh6l5IB/TjPtpcXinUssKdZkROyDhgYg0TdJZY
         vqPQ==
X-Gm-Message-State: AC+VfDyugd56Usab+rAZ/DlMW8j2lQOKWovNeL5st8n3pvb3DOBvzVZW
        +bDPJ2PWtQKBhWLKxodKtGI=
X-Google-Smtp-Source: ACHHUZ6kQKOtOwQbZsQsWvaY23r1mUkBjlyfPD0+I1+RiCNBr9wjhpyqQVJLLedvmyFSipAMc5Xf0w==
X-Received: by 2002:a05:6a21:78a7:b0:10a:dafc:aef5 with SMTP id bf39-20020a056a2178a700b0010adafcaef5mr25460653pzc.34.1685057025312;
        Thu, 25 May 2023 16:23:45 -0700 (PDT)
Received: from ubuntu777.domain.name (36-228-81-153.dynamic-ip.hinet.net. [36.228.81.153])
        by smtp.gmail.com with ESMTPSA id a29-20020a631a5d000000b00520b677c645sm1641935pgm.41.2023.05.25.16.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 16:23:44 -0700 (PDT)
From:   Min-Hua Chen <minhuadotchen@gmail.com>
To:     Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Min-Hua Chen <minhuadotchen@gmail.com>,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: megaraid: use correct types for __le32 and __le16
Date:   Fri, 26 May 2023 07:23:38 +0800
Message-Id: <20230525232340.38367-1-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes several sparse warnings.
No functional changes.

drivers/scsi/megaraid/megaraid_sas_base.c:294:31: sparse: warning: restricted __le16 degrades to integer
drivers/scsi/megaraid/megaraid_sas_base.c:7579:44: sparse: warning: restricted __le32 degrades to integer
drivers/scsi/megaraid/megaraid_sas_base.c:8805:46: sparse: warning: restricted __le32 degrades to integer
drivers/scsi/megaraid/megaraid_sas_fp.c:1188:28: sparse: warning: restricted __le16 degrades to integer

Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 6 +++---
 drivers/scsi/megaraid/megaraid_sas_fp.c   | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 317c944c68e3..70ac7d1da2ad 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -291,7 +291,7 @@ void megasas_set_dma_settings(struct megasas_instance *instance,
 	if (instance->consistent_mask_64bit) {
 		dcmd->sgl.sge64[0].phys_addr = cpu_to_le64(dma_addr);
 		dcmd->sgl.sge64[0].length = cpu_to_le32(dma_len);
-		dcmd->flags = cpu_to_le16(dcmd->flags | MFI_FRAME_SGL64);
+		dcmd->flags = cpu_to_le16(le16_to_cpu(dcmd->flags) | MFI_FRAME_SGL64);
 
 	} else {
 		dcmd->sgl.sge32[0].phys_addr =
@@ -7576,7 +7576,7 @@ static int megasas_probe_one(struct pci_dev *pdev,
 	 * Trigger SCSI to scan our drives
 	 */
 	if (!instance->enable_fw_dev_list ||
-	    (instance->host_device_list_buf->count > 0))
+	    (le32_to_cpu(instance->host_device_list_buf->count) > 0))
 		scsi_scan_host(host);
 
 	/*
@@ -8802,7 +8802,7 @@ void megasas_add_remove_devices(struct megasas_instance *instance,
 
 	if (instance->enable_fw_dev_list) {
 		targetid_list = instance->host_device_list_buf;
-		for (i = 0; i < targetid_list->count; i++) {
+		for (i = 0; i < le32_to_cpu(targetid_list->count); i++) {
 			targetid_entry = &targetid_list->host_device_list[i];
 			if (targetid_entry->flags.u.bits.is_sys_pd) {
 				channel = le16_to_cpu(targetid_entry->target_id) /
diff --git a/drivers/scsi/megaraid/megaraid_sas_fp.c b/drivers/scsi/megaraid/megaraid_sas_fp.c
index 4463a538102a..11d16fd128c6 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fp.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fp.c
@@ -1185,7 +1185,7 @@ MR_BuildRaidContext(struct megasas_instance *instance,
 					ref_in_start_stripe, io_info,
 					pRAID_Context, map);
 		/* If IO on an invalid Pd, then FP is not possible.*/
-		if (io_info->devHandle == MR_DEVHANDLE_INVALID)
+		if (io_info->devHandle == cpu_to_le16(MR_DEVHANDLE_INVALID))
 			io_info->fpOkForIo = false;
 		return retval;
 	} else if (isRead) {
-- 
2.34.1


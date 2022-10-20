Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801D9605518
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 03:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbiJTBiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 21:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbiJTBiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 21:38:10 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AE11D2B54;
        Wed, 19 Oct 2022 18:38:08 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id k9so18485454pll.11;
        Wed, 19 Oct 2022 18:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rLdPoJiwzSisIeOIqqvijJzMO8y8c5LDJmTeIyrYWCw=;
        b=d0kjFcYjCp4ntkJkSKDRemV2XINRpyl9e3lRUf53l8xdLWMmhDgyBdaaWhqqk2SzbB
         tIBLAEN3xQ6tweLq13fT2pUC2dMbkv9Ns0r9mV3yk/hLBPPCX2+yA/KaYOfIkN5lqK4o
         XQ/1cp3qH2QNYb37V3oFda2shBb0eWkQzwVa6ztbJ0rB6V/JiVA77RO2IQ9yX5yL2KyT
         p3fQrKlWJ3WgUeba435AAHJbFOnBCVHPyOc1wSULaUS7yBR0LBOau3eZMGTXAwI/oQeZ
         FCEyBgiDI6OvcB86pqN3+t0kU77yanniFVSVNJrDyybBSnKTf9f9pzYZ1ocVZxfx3VaV
         oyIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rLdPoJiwzSisIeOIqqvijJzMO8y8c5LDJmTeIyrYWCw=;
        b=3CW8++WgTE50Jb587CQsMQCkQ5b52RzLa9ZCCPzaA2PnUPYBgH6418UdWgna2y5DTh
         YV96GjKGD0koTgsBhqBOMWTi7+stIjM3cdS7Ns2XyWx5n8MVC1Y93jbHxSOjbZz5X9zN
         ECHyZpf9e7VSCvDlGjZBZgtXWt0Jaz7AKlXBfFufXKxTHwTOp3ZIJ46RDvzGCVXBdDyq
         1ynvJHsVzGzVA0uAr/ipaLynGjPva0hUMnwPqjEaAyJWU63xotKKG/tw3qfxRbomwcci
         Rv2GeSqiwnon/DdteBLlbjjMdtq88ERlisEP010sHxDM6y6QKxbrZUByuY2/FS+Hh6ku
         iq6A==
X-Gm-Message-State: ACrzQf2jFNtc6JQbu/s+EvzRTb7oyBD5SYXImxrcpoqLEc/AYPw45i88
        +u7ctC77LwbBWUxWPoKY9b4=
X-Google-Smtp-Source: AMsMyM4f/1grbFpogn5VBX32Tvl1DHQMWeI2mPxTq6OcFBhxY8QlD7USwyGlq5/NomwL6OKGX2UFRg==
X-Received: by 2002:a17:902:da92:b0:17f:9148:9b8c with SMTP id j18-20020a170902da9200b0017f91489b8cmr11672117plx.117.1666229887660;
        Wed, 19 Oct 2022 18:38:07 -0700 (PDT)
Received: from xm06403pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id z9-20020a170903018900b0017f7e0f4a4esm10238203plg.35.2022.10.19.18.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 18:38:07 -0700 (PDT)
From:   zhe wang <zhewang116@gmail.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        beanhuo@micron.com, stanley.chu@mediatek.com,
        adrian.hunter@intel.com, zhe.wang1@unisoc.com,
        zhenxiong.lai@unisoc.com, yuelin.tang@unisoc.com
Subject: [PATCH RESEND] scsi: ufs: core: Let delay value after LPM can be modified by vendor
Date:   Thu, 20 Oct 2022 09:35:35 +0800
Message-Id: <20221020013535.27843-1-zhewang116@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhe Wang <zhe.wang1@unisoc.com>

Some UFS devices require that the VCC should drop below 0.1V after
turning off, otherwise device may not resume successfully. And
because the power-off rate is different on different SOC platforms.
Therefore, we hope that the delay can be modified by vendor to
adjust the most appropriate delay value.

Signed-off-by: Zhe Wang <zhe.wang1@unisoc.com>
---
 drivers/ufs/core/ufshcd.c | 11 +++++++++--
 include/ufs/ufshcd.h      |  2 ++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 7256e6c43ca6..f6350231da0e 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -89,6 +89,9 @@
 /* Polling time to wait for fDeviceInit */
 #define FDEVICEINIT_COMPL_TIMEOUT 1500 /* millisecs */
 
+/* Default value of turn off VCC rail: 5000us */
+#define UFS_VCC_TURNOFF_DELAY_US 5000
+
 #define ufshcd_toggle_vreg(_dev, _vreg, _on)				\
 	({                                                              \
 		int _ret;                                               \
@@ -7784,6 +7787,9 @@ static int ufs_get_device_desc(struct ufs_hba *hba)
 
 	ufs_fixup_device_setup(hba);
 
+	if (hba->dev_quirks & UFS_DEVICE_QUIRK_DELAY_AFTER_LPM && !hba->vcc_turnoff_delay)
+		hba->vcc_turnoff_delay = UFS_VCC_TURNOFF_DELAY_US;
+
 	ufshcd_wb_probe(hba, desc_buf);
 
 	ufshcd_temp_notif_probe(hba, desc_buf);
@@ -8917,8 +8923,9 @@ static void ufshcd_vreg_set_lpm(struct ufs_hba *hba)
 	 * Some UFS devices require delay after VCC power rail is turned-off.
 	 */
 	if (vcc_off && hba->vreg_info.vcc &&
-		hba->dev_quirks & UFS_DEVICE_QUIRK_DELAY_AFTER_LPM)
-		usleep_range(5000, 5100);
+		hba->dev_quirks & UFS_DEVICE_QUIRK_DELAY_AFTER_LPM &&
+		hba->vcc_turnoff_delay)
+		usleep_range(hba->vcc_turnoff_delay, hba->vcc_turnoff_delay + 100);
 }
 
 #ifdef CONFIG_PM
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 9f28349ebcff..bfde3cb962fb 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -828,6 +828,7 @@ struct ufs_hba_monitor {
  *	device
  * @complete_put: whether or not to call ufshcd_rpm_put() from inside
  *	ufshcd_resume_complete()
+ * @vcc_turnoff_delay: VCC turnoff delay value.
  */
 struct ufs_hba {
 	void __iomem *mmio_base;
@@ -975,6 +976,7 @@ struct ufs_hba {
 #endif
 	u32 luns_avail;
 	bool complete_put;
+	u32 vcc_turnoff_delay;
 };
 
 /* Returns true if clocks can be gated. Otherwise false */
-- 
2.17.1


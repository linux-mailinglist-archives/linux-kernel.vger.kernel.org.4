Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050CE5FC2B0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 11:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiJLJJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 05:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiJLJJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 05:09:24 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4E0632C;
        Wed, 12 Oct 2022 02:09:23 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id h10so15694062plb.2;
        Wed, 12 Oct 2022 02:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rLdPoJiwzSisIeOIqqvijJzMO8y8c5LDJmTeIyrYWCw=;
        b=k0+AqjxmV5H1L1+MFjXbEOasiEddPlc5H3qhKHixQaYQujF7xmCcKKidQ4pmdRkYZ0
         z7mkGfal2GffrqXJPHHxGc/QEI3rz2rtLZj7cIrTbRRsInBbyZv9KT1UDd2keSm6rfR3
         2b2n5RGXVFArcnm34SXeMGzkXRSd16UAs6KA0fTioUcb9b13AGuLquEQjt/fsGUgiblI
         mzaEYA54QAcTKn4xRsm75CN7MwK8Is+nbo7FOS8n2OHySjA1QkspKFG0u/G8U/As+Bxz
         8nmdaKZXpNu56dMmUESnq/LeVb1GTv6BUu/RqQtKA6VphVcrxFPuwVLV+xfh+A54qaBi
         uWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rLdPoJiwzSisIeOIqqvijJzMO8y8c5LDJmTeIyrYWCw=;
        b=u5rd4mBdAzLZF5+Fcrifx2f0kklqh7K0efm+Wdm6scqT+hI7d+JhDNxx5eeDI63ZuD
         5k7cDFJvjDg+ARqVZrnL5GVyLpJx4oMyke3MC5bHBK4gXXbe7u6Ku05O+eMg8CJ3uP2+
         MreYItWC1J0Urgwf4LpEmGvW9xO+zD8ABH6BxOKkg7bt3lK0mLKI2ZWt6gWaDaD7BIJ5
         cVFWBXw/JWaDqXvuBKutu7rmRxGkL29rPkUPGJSUR2aisqxwJqzqZvU40uwrCsMW+eSV
         i63yWYa5XUMvOQmMJwzNv3lCuCzTt5dZqAuFFP02ehatB3XCISFEUs3W4EBF8dhgkMyL
         3RZA==
X-Gm-Message-State: ACrzQf3dpZrIZEWaJfOul3G3j5W+j1eM6MyDbwFAMWgKl7HBN4STCDM2
        uKiitFxLkM18UiCCgxNIiIc=
X-Google-Smtp-Source: AMsMyM6J7PDgFM7e3X4VbKV46Q/Hz7iJPl0wNpeWUZiFU6p3Fsn3jjOxoEnOfo7LLTaCJxzJU7DjsA==
X-Received: by 2002:a17:902:b70c:b0:179:eb79:cf9a with SMTP id d12-20020a170902b70c00b00179eb79cf9amr28819811pls.130.1665565762775;
        Wed, 12 Oct 2022 02:09:22 -0700 (PDT)
Received: from xm06403pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id z1-20020a623301000000b00562496395besm10897663pfz.170.2022.10.12.02.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 02:09:22 -0700 (PDT)
From:   zhe wang <zhewang116@gmail.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        beanhuo@micron.com, stanley.chu@mediatek.com,
        adrian.hunter@intel.com
Subject: [PATCH] scsi: ufs: core: Let delay value after LPM can be modified by vendor
Date:   Wed, 12 Oct 2022 17:09:02 +0800
Message-Id: <20221012090902.23237-1-zhewang116@gmail.com>
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


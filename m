Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458AB606D3B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 03:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiJUBwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 21:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiJUBwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 21:52:51 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96431158187;
        Thu, 20 Oct 2022 18:52:50 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id t10-20020a17090a4e4a00b0020af4bcae10so1404586pjl.3;
        Thu, 20 Oct 2022 18:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2FpfKKtKBVtEzIY0NvvrlI3I9Qric4iNRI6LMBeU0Jw=;
        b=QYvc9qdXiJix3RoWKBBmoJGCSdtrwYfX0bfPmE8cyjqhfa4fbgqRfLotOUOAkdjvA0
         DJ7ii/cNIvWK0sV4lqsQWsQdfkduc/brwyG9frZAMQs8dwql21/OqSZKe/xKz4p31ajP
         lz9KXO125vVjmFQx/XhoLNJ0GXAy6oGWi7yJQ9lqtAmhmN26UYdfwKs5hORLhQIQLn8J
         qLoDWmxXmlKMgrBcY5TGbTeRvGcpGeExhVJ97HkgA1+0ERE9sEglU/88/+UZVtqIC4A8
         D/RRm7C4Mc/v07G6vtDsh6oOsRwkVYzezb8sVZ8uBil5OgmxFq2KSSYn2AoWIYaCpq3r
         9LkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2FpfKKtKBVtEzIY0NvvrlI3I9Qric4iNRI6LMBeU0Jw=;
        b=TjcAemsKLdFRlMXnGceGqPI/Uy81ywfs+33mB5CL2JYhSlK7UqGTv9txkDo0KoMjLq
         leNMRzEDwaSZYGrhGEq+Fac3D4qQCqeaNBgS+3qGJsNcN9sSKVStysdrjoPxBeKqsj/j
         sJgXMbeqE4YN3UtvzPt66m/yev400H2/FRFuleo50X6H9i9aWbdCVrEXcDHqpNfrXoxz
         53quSBWo6OXnj3v/gYdTpEmeXM0XbIQi+aEnCnmE+glGq/CAwcuSg41iHKTYRaMTrcAj
         8FGIDTOK96tw0lROQ8/5UES4IQeWfGlyQQJLZBfn0kQhkbA0k6n+rMaryj0Nb9/HAi7n
         sGVQ==
X-Gm-Message-State: ACrzQf2dVdwUtfj0ZxfkO83FJ00oH6xbamQMqnXVS7rN3RoqusHZg07y
        Yyv4OMof8tNBFCPZzHEop3w=
X-Google-Smtp-Source: AMsMyM6XKqHW8jNhdjFTZaB1xBdIsPsaQp+AK9CFBvnJO4IPA1e2zIgoNkYe1ppnAUhtDY5S797U/Q==
X-Received: by 2002:a17:902:6546:b0:17f:7888:58b with SMTP id d6-20020a170902654600b0017f7888058bmr16224452pln.140.1666317170041;
        Thu, 20 Oct 2022 18:52:50 -0700 (PDT)
Received: from xm06403pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id i6-20020a17090332c600b001806f4fbf25sm13684279plr.182.2022.10.20.18.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 18:52:49 -0700 (PDT)
From:   Zhe Wang <zhewang116@gmail.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        beanhuo@micron.com, stanley.chu@mediatek.com,
        adrian.hunter@intel.com, zhe.wang1@unisoc.com,
        zhenxiong.lai@unisoc.com, yuelin.tang@unisoc.com
Subject: [PATCH V2] scsi: ufs: core: Let delay value after LPM can be modified by vendor
Date:   Fri, 21 Oct 2022 09:52:17 +0800
Message-Id: <20221021015217.20272-1-zhewang116@gmail.com>
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
V1 -> V2
- move turnoff_delay_us to struct ufs_vreg instead
- replace usleep_range with ufshcd_delay_us

 drivers/ufs/core/ufshcd.c | 9 ++++++++-
 include/ufs/ufs.h         | 1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 7256e6c43ca6..386ff6ed2f20 100644
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
@@ -7784,6 +7787,10 @@ static int ufs_get_device_desc(struct ufs_hba *hba)
 
 	ufs_fixup_device_setup(hba);
 
+	if (hba->dev_quirks & UFS_DEVICE_QUIRK_DELAY_AFTER_LPM &&
+	    !hba->vreg_info.vcc->turnoff_delay_us)
+		hba->vreg_info.vcc->turnoff_delay_us = UFS_VCC_TURNOFF_DELAY_US;
+
 	ufshcd_wb_probe(hba, desc_buf);
 
 	ufshcd_temp_notif_probe(hba, desc_buf);
@@ -8918,7 +8925,7 @@ static void ufshcd_vreg_set_lpm(struct ufs_hba *hba)
 	 */
 	if (vcc_off && hba->vreg_info.vcc &&
 		hba->dev_quirks & UFS_DEVICE_QUIRK_DELAY_AFTER_LPM)
-		usleep_range(5000, 5100);
+		ufshcd_delay_us(hba->vreg_info.vcc->turnoff_delay_us, 100);
 }
 
 #ifdef CONFIG_PM
diff --git a/include/ufs/ufs.h b/include/ufs/ufs.h
index 1bba3fead2ce..792335dfd70b 100644
--- a/include/ufs/ufs.h
+++ b/include/ufs/ufs.h
@@ -569,6 +569,7 @@ struct ufs_vreg {
 	bool always_on;
 	bool enabled;
 	int max_uA;
+	u32 turnoff_delay_us;
 };
 
 struct ufs_vreg_info {
-- 
2.17.1


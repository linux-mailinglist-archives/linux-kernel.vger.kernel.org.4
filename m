Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04499608FCC
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 23:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiJVVhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 17:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiJVVhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 17:37:09 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A786FA01F;
        Sat, 22 Oct 2022 14:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1666474620;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=hLVzOoSM0EISo0/xnWn5hNOztH7rYQQdOf8SYTOMMCg=;
    b=cRqSMDbVi6zrduwA/qWOozpv8F/85yoQ52ORIbbrCITcgbRAMER6r/LiGm/lCrSHeQ
    umjMhzBp4D4GcEOtJEZVF/HI0DX7SzZybWUE/FHKrZvZVGXnCMYe+Y7nJiI1khQURHrg
    4CHafbBd2TP1jiwA5nz5Era2nJbXqjuzNnlOAR5QaIe4TP8PhS5a/DwYXWM/AtHF5FnP
    TzY3Qj+I074PBHYOh1/+/vhxbX1+h1MQKRaZoMty3fIK4a7MygCKG/Y5LcQ5MoVov5cN
    mS2o1qut97vdiYSyWNAcoVm5ZmKooa0pSvnzyho+Vx0gg+hBUm0a6ucGyzviqfgfFT3G
    hg0w==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD/R51xABQjgP5pGGXp2Dw="
X-RZG-CLASS-ID: mo02
Received: from linux..
    by smtp.strato.de (RZmta 48.2.0 DYNA|AUTH)
    with ESMTPSA id zad98cy9MLaxnUU
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sat, 22 Oct 2022 23:36:59 +0200 (CEST)
From:   Bean Huo <beanhuo@iokpp.de>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com,
        asutoshd@codeaurora.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        cang@codeaurora.org, daejun7.park@samsung.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] scsi: ufs: core: Cleanup ufshcd_slave_alloc()
Date:   Sat, 22 Oct 2022 23:36:49 +0200
Message-Id: <20221022213650.626766-3-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221022213650.626766-1-beanhuo@iokpp.de>
References: <20221022213650.626766-1-beanhuo@iokpp.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

Combine ufshcd_get_lu_power_on_wp_status() and ufshcd_set_queue_depth()
into one single ufshcd_lu_init(), so that we only need to read the LUN
descriptor once.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/ufs/core/ufshcd.c | 150 ++++++++++++++------------------------
 1 file changed, 53 insertions(+), 97 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 8cdba9a54870..8599780022fb 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -4859,100 +4859,6 @@ static int ufshcd_verify_dev_init(struct ufs_hba *hba)
 	return err;
 }
 
-/**
- * ufshcd_set_queue_depth - set lun queue depth
- * @sdev: pointer to SCSI device
- *
- * Read bLUQueueDepth value and activate scsi tagged command
- * queueing. For WLUN, queue depth is set to 1. For best-effort
- * cases (bLUQueueDepth = 0) the queue depth is set to a maximum
- * value that host can queue.
- */
-static void ufshcd_set_queue_depth(struct scsi_device *sdev)
-{
-	int ret = 0;
-	u8 lun_qdepth;
-	struct ufs_hba *hba;
-
-	hba = shost_priv(sdev->host);
-
-	lun_qdepth = hba->nutrs;
-	ret = ufshcd_read_unit_desc_param(hba,
-					  ufshcd_scsi_to_upiu_lun(sdev->lun),
-					  UNIT_DESC_PARAM_LU_Q_DEPTH,
-					  &lun_qdepth,
-					  sizeof(lun_qdepth));
-
-	/* Some WLUN doesn't support unit descriptor */
-	if (ret == -EOPNOTSUPP)
-		lun_qdepth = 1;
-	else if (!lun_qdepth)
-		/* eventually, we can figure out the real queue depth */
-		lun_qdepth = hba->nutrs;
-	else
-		lun_qdepth = min_t(int, lun_qdepth, hba->nutrs);
-
-	dev_dbg(hba->dev, "%s: activate tcq with queue depth %d\n",
-			__func__, lun_qdepth);
-	scsi_change_queue_depth(sdev, lun_qdepth);
-}
-
-/*
- * ufshcd_get_lu_wp - returns the "b_lu_write_protect" from UNIT DESCRIPTOR
- * @hba: per-adapter instance
- * @lun: UFS device lun id
- * @b_lu_write_protect: pointer to buffer to hold the LU's write protect info
- *
- * Returns 0 in case of success and b_lu_write_protect status would be returned
- * @b_lu_write_protect parameter.
- * Returns -ENOTSUPP if reading b_lu_write_protect is not supported.
- * Returns -EINVAL in case of invalid parameters passed to this function.
- */
-static int ufshcd_get_lu_wp(struct ufs_hba *hba,
-			    u8 lun,
-			    u8 *b_lu_write_protect)
-{
-	int ret;
-
-	if (!b_lu_write_protect)
-		ret = -EINVAL;
-	/*
-	 * According to UFS device spec, RPMB LU can't be write
-	 * protected so skip reading bLUWriteProtect parameter for
-	 * it. For other W-LUs, UNIT DESCRIPTOR is not available.
-	 */
-	else if (lun >= hba->dev_info.max_lu_supported)
-		ret = -ENOTSUPP;
-	else
-		ret = ufshcd_read_unit_desc_param(hba,
-					  lun,
-					  UNIT_DESC_PARAM_LU_WR_PROTECT,
-					  b_lu_write_protect,
-					  sizeof(*b_lu_write_protect));
-	return ret;
-}
-
-/**
- * ufshcd_get_lu_power_on_wp_status - get LU's power on write protect
- * status
- * @hba: per-adapter instance
- * @sdev: pointer to SCSI device
- *
- */
-static inline void ufshcd_get_lu_power_on_wp_status(struct ufs_hba *hba,
-						    const struct scsi_device *sdev)
-{
-	if (hba->dev_info.f_power_on_wp_en &&
-	    !hba->dev_info.is_lu_power_on_wp) {
-		u8 b_lu_write_protect;
-
-		if (!ufshcd_get_lu_wp(hba, ufshcd_scsi_to_upiu_lun(sdev->lun),
-				      &b_lu_write_protect) &&
-		    (b_lu_write_protect == UFS_LU_POWER_ON_WP))
-			hba->dev_info.is_lu_power_on_wp = true;
-	}
-}
-
 /**
  * ufshcd_setup_links - associate link b/w device wlun and other luns
  * @sdev: pointer to SCSI device
@@ -4990,6 +4896,58 @@ static void ufshcd_setup_links(struct ufs_hba *hba, struct scsi_device *sdev)
 	}
 }
 
+/**
+ * ufshcd_lu_init - Initialize the relevant parameters of the LU
+ * @hba: per-adapter instance
+ * @sdev: pointer to SCSI device
+ */
+static void ufshcd_lu_init(struct ufs_hba *hba, struct scsi_device *sdev)
+{
+	int len = hba->desc_size[QUERY_DESC_IDN_UNIT];
+	u8 lun = ufshcd_scsi_to_upiu_lun(sdev->lun);
+	u8 lun_qdepth = hba->nutrs;
+	u8 *desc_buf;
+	int ret;
+
+	desc_buf = kzalloc(len, GFP_KERNEL);
+	if (!desc_buf)
+		goto set_qdepth;
+
+	ret = ufshcd_read_unit_desc_param(hba, lun, 0, desc_buf, len);
+	if (ret < 0) {
+		if (ret == -EOPNOTSUPP)
+			/* If LU doesn't support unit descriptor, its queue depth is set to 1 */
+			lun_qdepth = 1;
+		kfree(desc_buf);
+		goto set_qdepth;
+	}
+
+	if (desc_buf[UNIT_DESC_PARAM_LU_Q_DEPTH]) {
+		/*
+		 * In per-LU queueing architecture, bLUQueueDepth will not be 0, then we will
+		 * use the smaller between UFSHCI CAP.NUTRS and UFS LU bLUQueueDepth
+		 */
+		lun_qdepth = min_t(int, desc_buf[UNIT_DESC_PARAM_LU_Q_DEPTH], hba->nutrs);
+	}
+	/*
+	 * According to UFS device specification, the write protection mode is only supported by
+	 * normal LU, not supported by WLUN.
+	 */
+	if (hba->dev_info.f_power_on_wp_en && lun < hba->dev_info.max_lu_supported &&
+	    !hba->dev_info.is_lu_power_on_wp &&
+	    desc_buf[UNIT_DESC_PARAM_LU_WR_PROTECT] == UFS_LU_POWER_ON_WP)
+		hba->dev_info.is_lu_power_on_wp = true;
+
+	kfree(desc_buf);
+set_qdepth:
+	/*
+	 * For WLUNs that don't support unit descriptor, queue depth is set to 1. For LUs whose
+	 * bLUQueueDepth == 0, the queue depth is set to a maximum value that host can queue.
+	 */
+	dev_dbg(hba->dev, "Set LU %x queue depth %d\n", lun, lun_qdepth);
+	scsi_change_queue_depth(sdev, lun_qdepth);
+}
+
 /**
  * ufshcd_slave_alloc - handle initial SCSI device configurations
  * @sdev: pointer to SCSI device
@@ -5017,9 +4975,7 @@ static int ufshcd_slave_alloc(struct scsi_device *sdev)
 	/* WRITE_SAME command is not supported */
 	sdev->no_write_same = 1;
 
-	ufshcd_set_queue_depth(sdev);
-
-	ufshcd_get_lu_power_on_wp_status(hba, sdev);
+	ufshcd_lu_init(hba, sdev);
 
 	ufshcd_setup_links(hba, sdev);
 
-- 
2.34.1


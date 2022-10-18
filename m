Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB04603226
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 20:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiJRSQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 14:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiJRSQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 14:16:47 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25227D1EF;
        Tue, 18 Oct 2022 11:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1666116999;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=S91eEeMsyosroXGbKbWQ4sKh+HjZ4BdVLK1HuQ79ma4=;
    b=SMvpMKHAiIhPyP5VZ0gU8sdbi+TgCK//2f6arD8TC8fRW2PhXWkxHSZ667C2Vqlge8
    93fbl9Bnogr5fqRNtQZvkQxDrx5DQNDDtD4NK4LGUg2lH1t57hxG5o7M7f9cBRA3MATX
    V3e+wAcWVaJq/KdjOK3NuR8pSXUv067QZ3lXaNzfdUM5yPFbzcbKMGImDXAMEZfxeY90
    W24yPp4XN67Zck90rj2HGg+w0f5v6WRlVPFimpAcUntjhdudqanc9KzUojurGNrvbz6O
    xw12dIVIzBTk7JOZc9hKsyMoncVwfcND6+f4+2fJVvuasdHS1IxT4PW+5q3aPHkVCIls
    yo8Q==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD2QzemV2tdlNlNRZBXiUw="
X-RZG-CLASS-ID: mo01
Received: from linux.micron.com
    by smtp.strato.de (RZmta 48.2.0 AUTH)
    with ESMTPSA id zad98cy9IIGcYST
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 18 Oct 2022 20:16:38 +0200 (CEST)
From:   Bean Huo <beanhuo@iokpp.de>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com,
        asutoshd@codeaurora.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        cang@codeaurora.org, daejun7.park@samsung.com, huobean@gmail.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] scsi: ufs: core: Remove unnecessary if statement
Date:   Tue, 18 Oct 2022 20:16:25 +0200
Message-Id: <20221018181627.326657-2-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221018181627.326657-1-beanhuo@iokpp.de>
References: <20221018181627.326657-1-beanhuo@iokpp.de>
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

LUs with WB potential support are properly checked in ufshcd_wb_probe()
before calling ufshcd_read_unit_desc_param(), so remove this unnecessary
if-checkup in ufs_is_valid_unit_desc_lun() to match its function definition.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/ufs/core/ufs-sysfs.c   | 3 +--
 drivers/ufs/core/ufshcd-priv.h | 6 +-----
 drivers/ufs/core/ufshcd.c      | 2 +-
 3 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/ufs/core/ufs-sysfs.c b/drivers/ufs/core/ufs-sysfs.c
index 53aea56d1de1..eb6b278c4e79 100644
--- a/drivers/ufs/core/ufs-sysfs.c
+++ b/drivers/ufs/core/ufs-sysfs.c
@@ -1234,8 +1234,7 @@ static ssize_t _pname##_show(struct device *dev,			\
 	struct scsi_device *sdev = to_scsi_device(dev);			\
 	struct ufs_hba *hba = shost_priv(sdev->host);			\
 	u8 lun = ufshcd_scsi_to_upiu_lun(sdev->lun);			\
-	if (!ufs_is_valid_unit_desc_lun(&hba->dev_info, lun,		\
-				_duname##_DESC_PARAM##_puname))		\
+	if (!ufs_is_valid_unit_desc_lun(&hba->dev_info, lun))		\
 		return -EINVAL;						\
 	return ufs_sysfs_read_desc_param(hba, QUERY_DESC_IDN_##_duname,	\
 		lun, _duname##_DESC_PARAM##_puname, buf, _size);	\
diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
index f68ca33f6ac7..a9e8e1f5afe7 100644
--- a/drivers/ufs/core/ufshcd-priv.h
+++ b/drivers/ufs/core/ufshcd-priv.h
@@ -293,16 +293,12 @@ static inline int ufshcd_rpm_put(struct ufs_hba *hba)
  * @lun: LU number to check
  * @return: true if the lun has a matching unit descriptor, false otherwise
  */
-static inline bool ufs_is_valid_unit_desc_lun(struct ufs_dev_info *dev_info,
-		u8 lun, u8 param_offset)
+static inline bool ufs_is_valid_unit_desc_lun(struct ufs_dev_info *dev_info, u8 lun)
 {
 	if (!dev_info || !dev_info->max_lu_supported) {
 		pr_err("Max General LU supported by UFS isn't initialized\n");
 		return false;
 	}
-	/* WB is available only for the logical unit from 0 to 7 */
-	if (param_offset == UNIT_DESC_PARAM_WB_BUF_ALLOC_UNITS)
-		return lun < UFS_UPIU_MAX_WB_LUN_ID;
 	return lun == UFS_UPIU_RPMB_WLUN || (lun < dev_info->max_lu_supported);
 }
 
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 7c15cbc737b4..85679e8a043b 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -3609,7 +3609,7 @@ static inline int ufshcd_read_unit_desc_param(struct ufs_hba *hba,
 	 * Unit descriptors are only available for general purpose LUs (LUN id
 	 * from 0 to 7) and RPMB Well known LU.
 	 */
-	if (!ufs_is_valid_unit_desc_lun(&hba->dev_info, lun, param_offset))
+	if (!ufs_is_valid_unit_desc_lun(&hba->dev_info, lun))
 		return -EOPNOTSUPP;
 
 	return ufshcd_read_desc_param(hba, QUERY_DESC_IDN_UNIT, lun,
-- 
2.34.1


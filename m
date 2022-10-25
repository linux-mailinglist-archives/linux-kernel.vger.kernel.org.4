Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A36E60D702
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 00:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbiJYWZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 18:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiJYWZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 18:25:13 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62B25E573;
        Tue, 25 Oct 2022 15:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1666736696;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=F+Q9lWsGLwYwprnt2SVEQBWdOSFu9C8P5456RbyUtu8=;
    b=h5fLdsDOGp5myEJsI9ZyGs2FKKRV7pAhgD0jNzTWPX68T1t9bubwkXppPHF9k6+Zcq
    c3aHI/nlqpNnhZfsyIXCFLjyrmgKbnZoyDhRvb7fSEsWDmWgOqF5eqOCDwlqGn8t8EfN
    VwS0xCTBNos7i/Ak0CxBZX6m16CsUZLXLOsygsdjihSZOQpF80Er3BcT+bp2EyqHQo6c
    WNJdKQNxgNjZBF7ONT0V3FNvNFmoZsVWI/u7SBucww1VKCe+Yxo5w0ORrWXH+YKTNqE+
    +LaeUl9Wuo8XGeQWSwG4iKbfQAfdTr9zISpP8GMO8W1cewc3IpzgvC6fESX1Tv3wmlTR
    szqA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD/R51xABQjgPFtj5ophaE="
X-RZG-CLASS-ID: mo01
Received: from linux..
    by smtp.strato.de (RZmta 48.2.1 DYNA|AUTH)
    with ESMTPSA id z9cfbfy9PMOu2EB
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 26 Oct 2022 00:24:56 +0200 (CEST)
From:   Bean Huo <beanhuo@iokpp.de>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com,
        asutoshd@codeaurora.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        cang@codeaurora.org, daejun7.park@samsung.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Arthur Simchaev <arthur.simchaev@wdc.com>
Subject: [PATCH v5 1/3] scsi: ufs: core: Revert "WB is only available on LUN #0 to #7"
Date:   Wed, 26 Oct 2022 00:24:28 +0200
Message-Id: <20221025222430.277768-2-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221025222430.277768-1-beanhuo@iokpp.de>
References: <20221025222430.277768-1-beanhuo@iokpp.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

A newer 'commit d3d9c4570285 ("scsi: ufs: Fix memory corruption by
ufshcd_read_desc_param()")' has properly fixed stack overflow issue,
'commit a2fca52ee640 ("scsi: ufs: WB is only available on LUN #0 to #7")'
is no longer required, we can revert it now.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Arthur Simchaev <arthur.simchaev@wdc.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
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
index b2203dd79e8c..e8b8b213c420 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -3605,7 +3605,7 @@ static inline int ufshcd_read_unit_desc_param(struct ufs_hba *hba,
 	 * Unit descriptors are only available for general purpose LUs (LUN id
 	 * from 0 to 7) and RPMB Well known LU.
 	 */
-	if (!ufs_is_valid_unit_desc_lun(&hba->dev_info, lun, param_offset))
+	if (!ufs_is_valid_unit_desc_lun(&hba->dev_info, lun))
 		return -EOPNOTSUPP;
 
 	return ufshcd_read_desc_param(hba, QUERY_DESC_IDN_UNIT, lun,
-- 
2.34.1


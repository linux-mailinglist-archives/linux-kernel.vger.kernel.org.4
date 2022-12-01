Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C164063F23C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 15:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbiLAOFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 09:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbiLAOE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 09:04:58 -0500
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [81.169.146.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F21EA5184;
        Thu,  1 Dec 2022 06:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1669903492;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=c/FJw1eQjtrDqv72K4MlGdG6wEsHIdThMCAbiYaGxDU=;
    b=kREa1XxoNJ1LJ3ewyuLoUkQTmSeZlo/x3RF3D+z+28Da5UFbDnVwETEVXMIIZYeVbF
    KaFeFwAcWP4fC9zUFbuzwLyKah5VwFKdVPDJc6cnlKHQC3vAsIl3PkYqvYzYheRzBxeJ
    jeu1PP1QuYXfdjl5fl/PWgSuFjl+RD/PsCpND/0ZqXCfvm/SXwMDjrv+LVPJkTsMBQah
    QwRDfhkldEwwo2PFyU5KUAagpVlDNQW5UT3WE5v/6xkK65Bz7o2VfW8a/vPRrw5nG81i
    pLVL+OJ51KxVRCIa3vykz/9zEjKXksqyCqW476+6YPjxvn4AYRzmOX2rTg0Gdmf1vGK2
    pkiA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD2QzemV2tdlNlNRZBXiUw="
X-RZG-CLASS-ID: mo03
Received: from blinux.micron.com
    by smtp.strato.de (RZmta 48.2.1 AUTH)
    with ESMTPSA id z9cfbfyB1E4pHoX
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 1 Dec 2022 15:04:51 +0100 (CET)
From:   Bean Huo <beanhuo@iokpp.de>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        daejun7.park@samsung.com, quic_cang@quicinc.com,
        quic_nguyenb@quicinc.com, quic_xiaosenh@quicinc.com,
        quic_richardp@quicinc.com, quic_asutoshd@quicinc.com, hare@suse.de
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/7] ufs: core: Advanced RPMB detection
Date:   Thu,  1 Dec 2022 15:04:35 +0100
Message-Id: <20221201140437.549272-6-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221201140437.549272-1-beanhuo@iokpp.de>
References: <20221201140437.549272-1-beanhuo@iokpp.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

Check UFS Advanced RPMB LU enablement during ufshcd_lu_init().

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/ufs/core/ufshcd.c |  6 ++++++
 include/ufs/ufs.h         | 24 ++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index d1bcb4c4e4e4..641fed6dae5d 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -4954,6 +4954,12 @@ static void ufshcd_lu_init(struct ufs_hba *hba, struct scsi_device *sdev)
 	    desc_buf[UNIT_DESC_PARAM_LU_WR_PROTECT] == UFS_LU_POWER_ON_WP)
 		hba->dev_info.is_lu_power_on_wp = true;
 
+	/* In case of RPMB LU, check if advanced RPMB mode is enabled */
+	if (desc_buf[UNIT_DESC_PARAM_UNIT_INDEX] == UFS_UPIU_RPMB_WLUN &&
+	    desc_buf[RPMB_UNIT_DESC_PARAM_REGION_EN] & BIT(4))
+		hba->dev_info.b_advanced_rpmb_en = true;
+
+
 	kfree(desc_buf);
 set_qdepth:
 	/*
diff --git a/include/ufs/ufs.h b/include/ufs/ufs.h
index 1bba3fead2ce..17e401df674c 100644
--- a/include/ufs/ufs.h
+++ b/include/ufs/ufs.h
@@ -212,6 +212,28 @@ enum unit_desc_param {
 	UNIT_DESC_PARAM_WB_BUF_ALLOC_UNITS	= 0x29,
 };
 
+/* RPMB Unit descriptor parameters offsets in bytes*/
+enum rpmb_unit_desc_param {
+	RPMB_UNIT_DESC_PARAM_LEN		= 0x0,
+	RPMB_UNIT_DESC_PARAM_TYPE		= 0x1,
+	RPMB_UNIT_DESC_PARAM_UNIT_INDEX		= 0x2,
+	RPMB_UNIT_DESC_PARAM_LU_ENABLE		= 0x3,
+	RPMB_UNIT_DESC_PARAM_BOOT_LUN_ID	= 0x4,
+	RPMB_UNIT_DESC_PARAM_LU_WR_PROTECT	= 0x5,
+	RPMB_UNIT_DESC_PARAM_LU_Q_DEPTH		= 0x6,
+	RPMB_UNIT_DESC_PARAM_PSA_SENSITIVE	= 0x7,
+	RPMB_UNIT_DESC_PARAM_MEM_TYPE		= 0x8,
+	RPMB_UNIT_DESC_PARAM_REGION_EN		= 0x9,
+	RPMB_UNIT_DESC_PARAM_LOGICAL_BLK_SIZE	= 0xA,
+	RPMB_UNIT_DESC_PARAM_LOGICAL_BLK_COUNT	= 0xB,
+	RPMB_UNIT_DESC_PARAM_REGION0_SIZE	= 0x13,
+	RPMB_UNIT_DESC_PARAM_REGION1_SIZE	= 0x14,
+	RPMB_UNIT_DESC_PARAM_REGION2_SIZE	= 0x15,
+	RPMB_UNIT_DESC_PARAM_REGION3_SIZE	= 0x16,
+	RPMB_UNIT_DESC_PARAM_PROVISIONING_TYPE	= 0x17,
+	RPMB_UNIT_DESC_PARAM_PHY_MEM_RSRC_CNT	= 0x18,
+};
+
 /* Device descriptor parameters offsets in bytes*/
 enum device_desc_param {
 	DEVICE_DESC_PARAM_LEN			= 0x0,
@@ -601,6 +623,8 @@ struct ufs_dev_info {
 
 	bool	b_rpm_dev_flush_capable;
 	u8	b_presrv_uspc_en;
+
+	bool    b_advanced_rpmb_en;
 };
 
 /*
-- 
2.25.1


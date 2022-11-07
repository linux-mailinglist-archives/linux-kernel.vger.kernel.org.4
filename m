Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2EE061F40C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 14:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbiKGNLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 08:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbiKGNLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 08:11:03 -0500
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BE11C924;
        Mon,  7 Nov 2022 05:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1667826655;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=x0ChwJ2vaiy1SWOkttW7ZHW/S8+rHXWSvSwa65vCkNw=;
    b=dSEri47t1GEzZxTYXqvVC5tnr7NEBZL0M6SNWlSx2MmfyUSl+va+fNUI7TXCpwMm/9
    fjL+8f2ceMZZU30OfpnTOCpd1mgsggupQXaCGBjSG+GWfcJS/Kx5M5BqRNz0HC6YysFG
    fTAuOoEzQrLk9Q0eW+9kNpdSK6/m9NPeYgPN/cx/U9QbeoDeZPzL1Le2MuQCtWeckAIR
    97pwZf3bW+BCJanhZcU6A7o3XaHvLrGXt8ldu4J0Lmr6EIIavGYQM1qek2yYxwBmA9dn
    2Vnr+t2NriWeNBOgxxrZwba634ZLFpHGymC/sFtS5jKtjNimwELrNtcJRN7AgjuCAo5w
    xA+g==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD1QLj68UeUr1+U1RvWtIeMr7Q/U8vM/+oObyVBycbphAC+CkWyag=="
X-RZG-CLASS-ID: mo01
Received: from blinux.speedport.ip
    by smtp.strato.de (RZmta 48.2.1 AUTH)
    with ESMTPSA id z9cfbfyA7DAsjG9
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 7 Nov 2022 14:10:54 +0100 (CET)
From:   Bean Huo <beanhuo@iokpp.de>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        daejun7.park@samsung.com, quic_cang@quicinc.com,
        quic_nguyenb@quicinc.com, quic_xiaosenh@quicinc.com,
        quic_richardp@quicinc.com, quic_asutoshd@quicinc.com, hare@suse.de
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 1/2] ufs: core: Advanced RPMB detection
Date:   Mon,  7 Nov 2022 14:10:37 +0100
Message-Id: <20221107131038.201724-2-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221107131038.201724-1-beanhuo@iokpp.de>
References: <20221107131038.201724-1-beanhuo@iokpp.de>
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

Check UFS Advanced RPMB LU enablement during ufshcd_lu_init().

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/ufs/core/ufshcd.c | 4 ++++
 include/ufs/ufs.h         | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index ee73d7036133..d49e7a0b82ca 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -4940,6 +4940,10 @@ static void ufshcd_lu_init(struct ufs_hba *hba, struct scsi_device *sdev)
 	    desc_buf[UNIT_DESC_PARAM_LU_WR_PROTECT] == UFS_LU_POWER_ON_WP)
 		hba->dev_info.is_lu_power_on_wp = true;
 
+	if (desc_buf[UNIT_DESC_PARAM_UNIT_INDEX] == UFS_RPMB_UNIT &&
+	    desc_buf[UNIT_DESC_PARAM_RPMB_REGION_EN] & 1 << 4)
+			hba->dev_info.b_advanced_rpmb_en = true;
+
 	kfree(desc_buf);
 set_qdepth:
 	/*
diff --git a/include/ufs/ufs.h b/include/ufs/ufs.h
index 1bba3fead2ce..2e617ab87750 100644
--- a/include/ufs/ufs.h
+++ b/include/ufs/ufs.h
@@ -199,6 +199,7 @@ enum unit_desc_param {
 	UNIT_DESC_PARAM_PSA_SENSITIVE		= 0x7,
 	UNIT_DESC_PARAM_MEM_TYPE		= 0x8,
 	UNIT_DESC_PARAM_DATA_RELIABILITY	= 0x9,
+	UNIT_DESC_PARAM_RPMB_REGION_EN		= 0x9,
 	UNIT_DESC_PARAM_LOGICAL_BLK_SIZE	= 0xA,
 	UNIT_DESC_PARAM_LOGICAL_BLK_COUNT	= 0xB,
 	UNIT_DESC_PARAM_ERASE_BLK_SIZE		= 0x13,
@@ -601,6 +602,8 @@ struct ufs_dev_info {
 
 	bool	b_rpm_dev_flush_capable;
 	u8	b_presrv_uspc_en;
+
+	bool    b_advanced_rpmb_en;
 };
 
 /*
-- 
2.25.1


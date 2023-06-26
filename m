Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B84C73DC51
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 12:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjFZKdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 06:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjFZKdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 06:33:42 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F055910CC;
        Mon, 26 Jun 2023 03:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1687775611; x=1719311611;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YwJ4i9hAzCEWJpnziae69CZqoEbyx7XLquEgZ1d/STw=;
  b=G7a0+fOPj5adBhgFkpHf0mPNjK1x1d7+h3cNz9kXmiDwQGemK2t32wgG
   mUwzE/uZE8api4kmBMiL7DoBHkTmigey1Q/2J1HZEw2Owvvw8r6hWHm/D
   6kn0dO0+24DothXChRCq1tifd6E1gszE0dttY/+hnGYU1iZXG7H16SzaB
   CvaOwgEnl3BBbTl4Y/EFQw5GeJnDtbmdhU7eZzAdorNtds6z6FGbTHiWt
   rOT2uRX/VYNQU7mY+cHJLgnyt6UK6lfKLXkpsypxpn/IizG5uoqtxSgW8
   rKRtgNtz+6FL9SDPLxydbCc1dddQzaX6KSUq+EvBGQrHJcuCnFp4mWhWV
   A==;
X-IronPort-AV: E=Sophos;i="6.01,159,1684771200"; 
   d="scan'208";a="348405995"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2023 18:33:31 +0800
IronPort-SDR: SY0Q3fsj151+AgxSZoziW3a0Ot3W393u6hiNkMAfJJEnBHe8wvQJFyX+yZvSbpt7vKtKLZiBF9
 GA6iTkbZIMwert9M1pE5Z5FNrPP4l/5v51jTIW3mQ6FVDajFTx0kdkoCwlUsG+Ei7IUIPha3ro
 ZVskp7gXdhPIGxzJJAzGjkaBPn9zIiwx1XJyjBFNkmlI6inLMEMT0P9/JFNSM6P6WtV3cdvMxm
 W1/fLXNx768fVZRBHe6yhQQtRyq+sjWBW708jJG9KGVeSCJH1rD9bcXjkQTzGTPiG+r3LMT8Rk
 5pQ=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Jun 2023 02:47:51 -0700
IronPort-SDR: gDyp91hw6fMk9KyxM3BjsV/rrSvxxkaUdviXHO4Qsw6X1RgOTzYBsjUtQLO/59vRiwxx72R2XO
 JtFUquF/B1O+Z12+wyjAmUCzxluhaB0w6+J59WtsrMqxaUL/bMZR86LRaEIrc6E/RRksOakEDI
 0MJXlV5VMlUY0hjnNxtTK0EacSRt9DYR/T8wgmjRkCLelN7aNraICgNVtAh9d/zOSHT6myyKe6
 bEMrKpuK/3h4gqLxCX6fLFI7rhdKWjIqWsBqlhwZVb/Mjefd9UvfTLzhRe7UGg9vEuw/s8hunx
 H1w=
WDCIronportException: Internal
Received: from jd50rq2.ad.shared ([10.45.30.149])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Jun 2023 03:33:30 -0700
From:   Arthur Simchaev <arthur.simchaev@wdc.com>
To:     martin.petersen@oracle.com
Cc:     avri.altman@wdc.com, Avi.Shchislowski@wdc.com, beanhuo@micron.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bvanassche@acm.org, Arthur Simchaev <Arthur.Simchaev@wdc.com>
Subject: [RESEND v2] ufs: core: Add support for qTimestamp attribute
Date:   Mon, 26 Jun 2023 13:33:19 +0300
Message-Id: <20230626103320.8737-1-arthur.simchaev@wdc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arthur Simchaev <Arthur.Simchaev@wdc.com>

The new qTimestamp attribute was added to UFS 4.0 spec, in order to
synchronize timestamp between device logs and the host.The spec recommend
to send this attribute upon device power-on Reset/HW reset or when
switching to Active state (using SSU command). Due to this attribute,
the attribute's max value was extended to 8 bytes. As a result,
the new definition of struct utp_upiu_query_v4_0 was added.

Signed-off-by: Arthur Simchaev <Arthur.Simchaev@wdc.com>

-----------------
Changes to v2:
- Adressed Bart's comments
- Add missed response variable to ufshcd_set_timestamp_attr
---
 drivers/ufs/core/ufshcd.c        | 38 ++++++++++++++++++++++++++++++++
 include/uapi/scsi/scsi_bsg_ufs.h | 25 +++++++++++++++++++++
 include/ufs/ufs.h                |  1 +
 3 files changed, 64 insertions(+)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 358b3240b6c5..e2812911e462 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -8520,6 +8520,41 @@ static int ufshcd_device_params_init(struct ufs_hba *hba)
 	return ret;
 }
 
+static void ufshcd_set_timestamp_attr(struct ufs_hba *hba)
+{
+	int err;
+	struct ufs_query_req *request = NULL;
+	struct ufs_query_res *response = NULL;
+	struct ufs_dev_info *dev_info = &hba->dev_info;
+	struct utp_upiu_query_v4_0 *upiu_data;
+
+	if (dev_info->wspecversion < 0x400)
+		return;
+
+	ufshcd_hold(hba);
+
+	mutex_lock(&hba->dev_cmd.lock);
+
+	ufshcd_init_query(hba, &request, &response,
+			  UPIU_QUERY_OPCODE_WRITE_ATTR,
+			  QUERY_ATTR_IDN_TIMESTAMP, 0, 0);
+
+	request->query_func = UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST;
+
+	upiu_data = (struct utp_upiu_query_v4_0 *)&request->upiu_req;
+
+	put_unaligned_be64(ktime_get_real_ns(), &upiu_data->osf3);
+
+	err = ufshcd_exec_dev_cmd(hba, DEV_CMD_TYPE_QUERY, QUERY_REQ_TIMEOUT);
+
+	if (err)
+		dev_err(hba->dev, "%s: failed to set timestamp %d\n",
+			__func__, err);
+
+	mutex_unlock(&hba->dev_cmd.lock);
+	ufshcd_release(hba);
+}
+
 /**
  * ufshcd_add_lus - probe and add UFS logical units
  * @hba: per-adapter instance
@@ -8708,6 +8743,8 @@ static int ufshcd_device_init(struct ufs_hba *hba, bool init_dev_params)
 	ufshcd_set_ufs_dev_active(hba);
 	ufshcd_force_reset_auto_bkops(hba);
 
+	ufshcd_set_timestamp_attr(hba);
+
 	/* Gear up to HS gear if supported */
 	if (hba->max_pwr_info.is_valid) {
 		/*
@@ -9741,6 +9778,7 @@ static int __ufshcd_wl_resume(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 		ret = ufshcd_set_dev_pwr_mode(hba, UFS_ACTIVE_PWR_MODE);
 		if (ret)
 			goto set_old_link_state;
+		ufshcd_set_timestamp_attr(hba);
 	}
 
 	if (ufshcd_keep_autobkops_enabled_except_suspend(hba))
diff --git a/include/uapi/scsi/scsi_bsg_ufs.h b/include/uapi/scsi/scsi_bsg_ufs.h
index 2801b65299aa..fd3f9e5ee241 100644
--- a/include/uapi/scsi/scsi_bsg_ufs.h
+++ b/include/uapi/scsi/scsi_bsg_ufs.h
@@ -70,6 +70,31 @@ struct utp_upiu_query {
 	__be32 reserved[2];
 };
 
+/**
+ * struct utp_upiu_query_v4_0 - upiu request buffer structure for
+ * query request >= UFS 4.0 spec.
+ * @opcode: command to perform B-0
+ * @idn: a value that indicates the particular type of data B-1
+ * @index: Index to further identify data B-2
+ * @selector: Index to further identify data B-3
+ * @osf4: spec field B-5
+ * @osf5: spec field B 6,7
+ * @osf6: spec field DW 8,9
+ * @osf7: spec field DW 10,11
+ */
+struct utp_upiu_query_v4_0 {
+	__u8 opcode;
+	__u8 idn;
+	__u8 index;
+	__u8 selector;
+	__u8 osf3;
+	__u8 osf4;
+	__be16 osf5;
+	__be32 osf6;
+	__be32 osf7;
+	__be32 reserved;
+};
+
 /**
  * struct utp_upiu_cmd - Command UPIU structure
  * @data_transfer_len: Data Transfer Length DW-3
diff --git a/include/ufs/ufs.h b/include/ufs/ufs.h
index 4e8d6240e589..198cb391f9db 100644
--- a/include/ufs/ufs.h
+++ b/include/ufs/ufs.h
@@ -170,6 +170,7 @@ enum attr_idn {
 	QUERY_ATTR_IDN_WB_BUFF_LIFE_TIME_EST    = 0x1E,
 	QUERY_ATTR_IDN_CURR_WB_BUFF_SIZE        = 0x1F,
 	QUERY_ATTR_IDN_EXT_IID_EN		= 0x2A,
+	QUERY_ATTR_IDN_TIMESTAMP		= 0x30
 };
 
 /* Descriptor idn for Query requests */
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F3F73DBF1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 11:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjFZJ6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 05:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjFZJ6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 05:58:52 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF07CF;
        Mon, 26 Jun 2023 02:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1687773531; x=1719309531;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WfpjASZov298ZJyFvUAekLtOzcvxvaDIIQvIiTxJWz0=;
  b=MaVtOS3oj1u8sKUtS6PYD1HGldITFvBcPh0tLa9nlt60ZH4xuL7Rs0yq
   z092l3bTMBwk5rbkeztnpQIN+5RTeo55fTBpZ/oIZDeimmG/nvUtthESE
   B0FZB6GUae9HSwZfNznaTw2218IVhl8MxYYw/sYARtrgB9WMKUfkaUbd0
   XO3k1GZ9/3ndGuclvYs+aEqHvyEQCeYwaKQeATCtiDrPT1rmyRJ76BVI3
   79XUBLDvTM07rznGmj/1nhYETmijASSCXlTfYoiwhAivbAQMaik+y3+G5
   nGIRB0S2xcUXZYTvy/77wzpsrRrZJVLt9Y5Qah1cLfPrubL/itnZCHOe2
   g==;
X-IronPort-AV: E=Sophos;i="6.01,159,1684771200"; 
   d="scan'208";a="348403709"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2023 17:58:50 +0800
IronPort-SDR: 7Le8l+i3O0WZT+Q5RTH+0SLOjJoKc9ENXr9sPsxDbv4JIOJ335IrbC4eeP2kSjw2OjbRwFPT3P
 bXhe5gSJaWiDRUSirGC6HXm1GE4Sqi5j8qBR/VQq64faiioT4xzfXAvEf3XzpQVhf3nHmnZzgi
 U8n75UCe5vmAFupe0hw740jQmO6iVeaUBaeN25KDpmdq1S258MZN/HuPXfm+w0Bkz3qYyttvrU
 fDBhiZ5x0Bon6lP5M+JOyqtG+y3kgxsmAivd+nopr6DUApl2USiGcJ1EK+vGBowUkmV0mbBHjf
 Z4o=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Jun 2023 02:07:30 -0700
IronPort-SDR: QEt+1k5AizdUDvJQMgrOo/IptIh3wJAmhErrp1BtQLiXNpyIqBWQ3jdSP0Xyw4WoyPuINaSHXn
 WLYeZFMGFZC+MaZoDC6Ep6+TAOWtWai27KC46xyNx9173ZNulwMiudJgDm5nKp6PgVKy/9fsdi
 SIsbyTDowMpGtrUZesujBvv9uMUMqAl347uPw8GxJSeBo7ItAO1t5HHB6sha+YyXOJ+bpk/NJd
 KlPcLG3XXpubINLq6DUPTBopVaFUeLznwzHT37nNZ89LHyGw4XbKj3tisTugWIERsrf1sEwGX7
 wtE=
WDCIronportException: Internal
Received: from jd50rq2.ad.shared ([10.45.30.149])
  by uls-op-cesaip01.wdc.com with ESMTP; 26 Jun 2023 02:58:50 -0700
From:   Arthur Simchaev <arthur.simchaev@wdc.com>
To:     arthur.simchaev@wdc.com
Cc:     Arthur Simchaev <Arthur.Simchaev@wdc.com>, beanhuo@micron.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND v2] FW: [PATCH v1] ufs: core: Add support for qTimestamp attribute
Date:   Mon, 26 Jun 2023 12:58:43 +0300
Message-Id: <20230626095845.8615-1-arthur.simchaev@wdc.com>
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

-----Original Message-----
From: Arthur Simchaev <Arthur.Simchaev@wdc.com>
Sent: Tuesday, March 7, 2023 6:06 PM
To: martin.petersen@oracle.com; bvanassche@acm.org
Cc: beanhuo@micron.com; linux-scsi@vger.kernel.org; linux-kernel@vger.kernel.org; Arthur Simchaev <Arthur.Simchaev@wdc.com>
Subject: [PATCH v1] ufs: core: Add support for qTimestamp attribute

The new qTimestamp attribute was added to UFS 4.0 spec, in order to
synchronize timestamp between device logs and the host.The spec recommend
to send this attribute upon device power-on Reset/HW reset or when
switching to Active state (using SSU command). Due to this attribute,
the attribute's max value was extended to 8 bytes. As a result,
the new definition of struct utp_upiu_query_v4_0 was added.

Signed-off-by: Arthur Simchaev <Arthur.Simchaev@wdc.com>

--
Changes to v1:
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


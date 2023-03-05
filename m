Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D966AB18A
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 18:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjCERQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 12:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCERQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 12:16:53 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7802125B8;
        Sun,  5 Mar 2023 09:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678036612; x=1709572612;
  h=from:to:cc:subject:date:message-id;
  bh=YgHLYfMgJIfaFotHaMfy6wc+7QCxHH5ImBuCGOxV31k=;
  b=PAzUuS+U81Qh303tJ/IoonORSstG+x5Gz28kQZf8Lh8R5+f/6LdXIIEc
   s+JYKLuOzq1DJnAyf/kI/AWNqK0457FjjsojpSqbCnpwybhVLoEZDKrbD
   9jB60dKP1nJ/8asSyUzezwOhvBmmRtoeA2WcUSGEuGzfBVGqy1I6s5a3u
   tHal9n9U5exyE8vt5SbOWRLn7AqURNWC4b0lEdn9DuB0sBOVDZeWt+rT3
   5DhBAA2/g7h/Tw3LeqtH8Tb9TiSivRAPkET5gvHpfsBVCXhjpgaQW9nWf
   M3stPUl8dEXx3cXuXO1d8UtV3xuxEG874ydq+4LTC55IeBy+cPFr+flF+
   w==;
X-IronPort-AV: E=Sophos;i="5.98,236,1673884800"; 
   d="scan'208";a="223130994"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Mar 2023 01:16:32 +0800
IronPort-SDR: Ytu2dLfqx9MY66tl2qm8zrQxRl5ozezrK8H99k1g0p8/zoyPp6oKlue2SqplqPDqtlfBAYSczm
 sMf54s+m2kxJKDqr3bkLweiGrOLWwBvmfZx5M3AQ9xVh0eQayUgfyrPu/M25TQeVTwjMe+K9Mm
 cZzezXvTkKaSD6iTMo45IsSOAAi4Cc8Q67hlJdsPDLt16DnprKa802oiIF+pE7FLMRWYRpoRhf
 DWKFdQpdPHXL61hIiZyS/yWIA/vdgb5zcChkE1C9cjzX/jnwe3H7fXYOirCgqm/oaqvut+ZjvY
 hhg=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Mar 2023 08:27:33 -0800
IronPort-SDR: seNZIYL3rHeeGT8p9sLl88EgfKvf3bTE/peawXRpC/MstOBfXWsyCs+DK74XSp3IjLdTlI+vLS
 GU2hDerHRFT4beA3bwJx9/Spj3rCJaKe5u0V0IYQFZQRpFNuX7q7Ac3VGILoOZKOGKW1wWk50h
 eMdxP8i8PABQN7sUbKfAtPoedM3Y2EOmOLKlcD3oJBdfkr6FJoiQANbviLNXfInMC+jelmeEOh
 YIFfig+GcvIsleK/hHrjpT5B0Q5dGcBJ14p7Ql1LsOV7spTwnvqvo8JZNI7bBZn2pNW4QgQ2P9
 UhY=
WDCIronportException: Internal
Received: from ilb001078.ad.shared (HELO ilb001078.sdcorp.global.sandisk.com) ([10.45.31.219])
  by uls-op-cesaip02.wdc.com with ESMTP; 05 Mar 2023 09:16:30 -0800
From:   Arthur Simchaev <Arthur.Simchaev@wdc.com>
To:     martin.petersen@oracle.com
Cc:     avri.altman@wdc.com, Avi.Shchislowski@wdc.com, beanhuo@micron.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bvanassche@acm.org, Arthur Simchaev <Arthur.Simchaev@wdc.com>
Subject: [PATCH] ufs: core: Add support for qTimestamp attribute
Date:   Sun,  5 Mar 2023 19:16:27 +0200
Message-Id: <1678036587-26927-1-git-send-email-Arthur.Simchaev@wdc.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new qTimestamp attribute was added to UFS 4.0 spec, in order to
synchronize timestamp between device logs and the host.The spec recommend
to send this attribute upon device power-on Reset/HW reset or when
switching to Active state (using SSU command). Due to this attribute,
the attribute's max value was extended to 8 bytes. As a result,
the new definition of struct utp_upiu_query_v4_0 was added.

Signed-off-by: Arthur Simchaev <Arthur.Simchaev@wdc.com>
---
 drivers/ufs/core/ufshcd.c        | 37 +++++++++++++++++++++++++++++++++++++
 include/uapi/scsi/scsi_bsg_ufs.h | 25 +++++++++++++++++++++++++
 include/ufs/ufs.h                |  1 +
 3 files changed, 63 insertions(+)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 629442c..48ef2e3 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -8378,6 +8378,40 @@ static int ufshcd_device_params_init(struct ufs_hba *hba)
 	return ret;
 }
 
+static void ufshcd_set_timestamp_attr(struct ufs_hba *hba)
+{
+	int err;
+	struct ufs_query_req *request = NULL;
+	struct ufs_dev_info *dev_info = &hba->dev_info;
+	struct utp_upiu_query_v4_0 *upiu_data;
+
+	if (dev_info->wspecversion < 0x400)
+		return;
+
+	ufshcd_hold(hba, false);
+
+	mutex_lock(&hba->dev_cmd.lock);
+
+	ufshcd_init_query(hba, &request, 0,
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
@@ -8547,6 +8581,8 @@ static int ufshcd_device_init(struct ufs_hba *hba, bool init_dev_params)
 	ufshcd_set_ufs_dev_active(hba);
 	ufshcd_force_reset_auto_bkops(hba);
 
+	ufshcd_set_timestamp_attr(hba);
+
 	/* Gear up to HS gear if supported */
 	if (hba->max_pwr_info.is_valid) {
 		/*
@@ -9566,6 +9602,7 @@ static int __ufshcd_wl_resume(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 		ret = ufshcd_set_dev_pwr_mode(hba, UFS_ACTIVE_PWR_MODE);
 		if (ret)
 			goto set_old_link_state;
+		ufshcd_set_timestamp_attr(hba);
 	}
 
 	if (ufshcd_keep_autobkops_enabled_except_suspend(hba))
diff --git a/include/uapi/scsi/scsi_bsg_ufs.h b/include/uapi/scsi/scsi_bsg_ufs.h
index 2801b65..fd3f9e5e 100644
--- a/include/uapi/scsi/scsi_bsg_ufs.h
+++ b/include/uapi/scsi/scsi_bsg_ufs.h
@@ -71,6 +71,31 @@ struct utp_upiu_query {
 };
 
 /**
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
+/**
  * struct utp_upiu_cmd - Command UPIU structure
  * @data_transfer_len: Data Transfer Length DW-3
  * @cdb: Command Descriptor Block CDB DW-4 to DW-7
diff --git a/include/ufs/ufs.h b/include/ufs/ufs.h
index 4e8d624..198cb39 100644
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
2.7.4


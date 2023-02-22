Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A924A69F773
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 16:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbjBVPNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 10:13:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232360AbjBVPND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 10:13:03 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE3F11EAC;
        Wed, 22 Feb 2023 07:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677078782; x=1708614782;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Bp81ag4q73LTr7MlDdAbki1WewX0AM3VZjoOGTeLMD4=;
  b=DDGXqbbEGVOJbNxDoRz+L/XgtyDu14WyM+FGxIUF3rtQrpJTzHlDUYKe
   56hC7WsXCVzyBpnogZZzE/CNLeJpjWSxjiTPdUSLMV3Lf181PzYVsC7eV
   NWdBfI+ZWcXQuC9zX9pesDywtKtNp9Gy31Nd98STCys8MxrpDBXCRyinE
   bbVfeAHIcZlSSteuazNBRUlJHDkSEN7wOVt4Q+6p2VU45S0hgbDMFcaJb
   RZbaELVnhAPi08F1QrdrwACpzzvolxHMdk0PsN2fZW0Y7jsgw7au+woBW
   pBWres8UI8BJuV7Wv/Rf9ViEprTBUTexKSydtz5OUSB8wp+b9YdzJKRzt
   A==;
X-IronPort-AV: E=Sophos;i="5.97,319,1669046400"; 
   d="scan'208";a="223701435"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Feb 2023 23:13:01 +0800
IronPort-SDR: 8ym6kQlvEV8LM0bsL01EWy0LZrkBaGTgeytwLyO0ERd2yhWOaFMsyDu1qYItaM7Qqp99ZqGBhe
 4fdf/p1bos/brb1lJGvcuOc90TVY8w7VcNAaXjueVStTnG65EGxBcv0kRDVYneyiBuTltX9V3e
 IEfsffJeawyi1K0k6byZLIH/86z5rjYn5gWHuZRD6+sIAD3Sr0YqtdNTFFRBMiLRVunmDUQT5b
 SF15NDFS7JqTgmt0J2d+ygsatoFBhLwSMG8lbjTx7ZCpPSW4n10e9OmUj649V+b5fZoAjmLMQ3
 lpc=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Feb 2023 06:24:16 -0800
IronPort-SDR: UNNccfbyhMkuY6JLtDQ3lRWstgI0jO8B5SqeV8A0pncJBqn+6f6Z2mJDW1JPvTxbJNzf2R7e5x
 SbNEE8tN3XiOsdBKhCX6CA1366N41PnOkvajSc7maNCuZGc6UtFdPEDETP4238fwIs0QoJN+Ft
 qxCv0GD8Wb+5xqy1Vznku4aHlJQyc/mdJyZH2lhpRtUYsnf+5yAHOK17FWl1QrkPsJ3n1XoPDV
 fnIKjpNcvCzj5IIIRqEE9459lQvH0EPM2jgKNBCIKT7XrblY2ssZRpjEregxANHKLVyBO9/xoI
 Ybs=
WDCIronportException: Internal
Received: from ilb001078.ad.shared (HELO ilb001078.sdcorp.global.sandisk.com) ([10.45.31.219])
  by uls-op-cesaip01.wdc.com with ESMTP; 22 Feb 2023 07:13:00 -0800
From:   Arthur Simchaev <Arthur.Simchaev@wdc.com>
To:     martin.petersen@oracle.com
Cc:     beanhuo@micron.com, bvanassche@acm.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>
Subject: [PATCH 2/2] ufs: core: Providing Timestamp information to the device
Date:   Wed, 22 Feb 2023 17:12:50 +0200
Message-Id: <1677078770-30994-3-git-send-email-Arthur.Simchaev@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1677078770-30994-1-git-send-email-Arthur.Simchaev@wdc.com>
References: <1677078770-30994-1-git-send-email-Arthur.Simchaev@wdc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new qTimestamp attribute was added to UFS 4.0 spec, in order to
synchronize the timestamp between the host and the ufs device.
The spec recommend to send this attribute upon device power-on Reset/HW
reset or when switching to Active state (using SSU command)

Signed-off-by: Arthur Simchaev <Arthur.Simchaev@wdc.com>
---
 drivers/ufs/core/ufshcd.c | 36 ++++++++++++++++++++++++++++++++++++
 include/ufs/ufs.h         |  1 +
 2 files changed, 37 insertions(+)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index b08760d..22c29ff 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -8378,6 +8378,39 @@ static int ufshcd_device_params_init(struct ufs_hba *hba)
 	return ret;
 }
 
+static void ufshcd_set_timestamp_attr(struct ufs_hba *hba)
+{
+	int err;
+	struct ufs_query_req *request = NULL;
+	struct ufs_query_res *response = NULL;
+	struct ufs_dev_info *dev_info = &hba->dev_info;
+
+	if (dev_info->wspecversion < 0x400)
+		return;
+
+	ufshcd_hold(hba, false);
+
+	mutex_lock(&hba->dev_cmd.lock);
+
+	ufshcd_init_query(hba, &request, &response,
+			  UPIU_QUERY_OPCODE_WRITE_ATTR,
+			  QUERY_ATTR_IDN_TIMESTAMP, 0, 0);
+
+	request->query_func = UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST;
+
+	put_unaligned_be64(ktime_get_real_ns(), &request->upiu_req.osf3);
+
+	err = ufshcd_exec_dev_cmd(hba, DEV_CMD_TYPE_QUERY, QUERY_REQ_TIMEOUT);
+
+	if (err)
+		dev_err(hba->dev, "%s: failed to set timestamp %d\n",
+			__func__, err);
+
+	mutex_unlock(&hba->dev_cmd.lock);
+
+	ufshcd_release(hba);
+}
+
 /**
  * ufshcd_add_lus - probe and add UFS logical units
  * @hba: per-adapter instance
@@ -8547,6 +8580,8 @@ static int ufshcd_device_init(struct ufs_hba *hba, bool init_dev_params)
 	ufshcd_set_ufs_dev_active(hba);
 	ufshcd_force_reset_auto_bkops(hba);
 
+	ufshcd_set_timestamp_attr(hba);
+
 	/* Gear up to HS gear if supported */
 	if (hba->max_pwr_info.is_valid) {
 		/*
@@ -9566,6 +9601,7 @@ static int __ufshcd_wl_resume(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 		ret = ufshcd_set_dev_pwr_mode(hba, UFS_ACTIVE_PWR_MODE);
 		if (ret)
 			goto set_old_link_state;
+		ufshcd_set_timestamp_attr(hba);
 	}
 
 	if (ufshcd_keep_autobkops_enabled_except_suspend(hba))
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


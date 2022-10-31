Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6E8613B42
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 17:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbiJaQZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 12:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbiJaQZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 12:25:56 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2BA12639;
        Mon, 31 Oct 2022 09:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667233554; x=1698769554;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Oe6SAgVHvhyllaVSMJMPlFVIjI8mku2kauEtvEtytYM=;
  b=mZ67AAX4+3etVND9IlFar2dJzpHb0dMwdTCEK3mk1vq9fQOvRzd40FSf
   RtQbUW4nNNfGP0lt+1ohn1KLjfh6pRa7d6976bh9PSWYTSp/cWjsj0gWu
   4XMpqceR2OxuFxeT2QCCdW7Xet5kOWVwH0Ph/bf9MwixULEGUlMFYMvh4
   c5nG1+QAOIKQ1PAvnC+DryuDAlghIvnRGKeGT+GF96+hAxbzhtREWkhO+
   Ijmso0RWD7iUkSqUExw0V7bnswcrs0GIpdmoF86yTk0HH4DlqRDugvWz4
   g5XiBd+APVCxJJrq7RxlCFDJC6/4ZXVFzBPuVw6E0WrfToLFBUJlsFWle
   g==;
X-IronPort-AV: E=Sophos;i="5.95,228,1661788800"; 
   d="scan'208";a="215498904"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 Nov 2022 00:25:54 +0800
IronPort-SDR: zUbksTBZZSpaOiov2cw7LzCBZG2D1/GDOiFeny6jDZ88XH6QOupxnEZL0clPp1vBOKHWXYd+8v
 9271PuzbZvlWRzXu0W8lVSGVeKoDg+X9mPR17zRoxfyDB8yw5lEqf6NYP4+Hmh3V6f8Ab/Bns9
 CEzLpp9iK4Hz1XBYI72NVj3oCPjLZ99U/t8j1qiyFAW4CIAoZIkzoJrom3uKIigUbjG6VACf5I
 6KP8nb2ApxwSgiKDKczH4A8e/2w/hBPOGqETii05Ocy+FiDSwbOtsqlwE+9Zn8yg/gpxTrkh/Z
 OeLFHbH4dhhD4FxJkTdhHMax
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Oct 2022 08:39:26 -0700
IronPort-SDR: q0TT1b3sjpKIc0XLofY3oDrUqQswVd1EbTpg3h0DXMHEDDl3o3UYq36kslfVDuHU+3wqear+/j
 37p0AB5rpiXpXkMcu06UmzlHdNwm9nYRyCia4aITEBqGVUsVENpOX8Qrlju1b/oK+y8PtOvBDE
 5pdhLSUJnKqJmugPPhk37Vk26RWz2uQQHWbzDBvlLOMKuu584BGFRG3Tug256P2RBq6le9SoJ0
 yXb1WhAsWcRS33oHFnxHhbsEJKLIDLODHX8VWat/QTsMpqV06NjgV60qIQ6JUIJW09/54g2hG6
 Dw8=
WDCIronportException: Internal
Received: from ilb001078.ad.shared (HELO ilb001078.sdcorp.global.sandisk.com) ([10.45.31.219])
  by uls-op-cesaip02.wdc.com with ESMTP; 31 Oct 2022 09:25:51 -0700
From:   Arthur Simchaev <Arthur.Simchaev@wdc.com>
To:     martin.petersen@oracle.com
Cc:     avri.altman@wdc.com, Avi.Shchislowski@wdc.com, beanhuo@micron.com,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>
Subject: [PATCH 1/4] ufs: core: Remove redundant wb check
Date:   Mon, 31 Oct 2022 18:25:21 +0200
Message-Id: <1667233524-13715-2-git-send-email-Arthur.Simchaev@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1667233524-13715-1-git-send-email-Arthur.Simchaev@wdc.com>
References: <1667233524-13715-1-git-send-email-Arthur.Simchaev@wdc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We used to use the extended-feature field in the device descriptor,
as an indication that the device supports ufs2.2 or later.
Remove that as this check is specifically done few lines above.

Signed-off-by: Arthur Simchaev <Arthur.Simchaev@wdc.com>
---
 drivers/ufs/core/ufshcd.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index ee73d70..de4e7e7 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -7574,10 +7574,6 @@ static void ufshcd_wb_probe(struct ufs_hba *hba, const u8 *desc_buf)
 	     (hba->dev_quirks & UFS_DEVICE_QUIRK_SUPPORT_EXTENDED_FEATURES)))
 		goto wb_disabled;
 
-	if (hba->desc_size[QUERY_DESC_IDN_DEVICE] <
-	    DEVICE_DESC_PARAM_EXT_UFS_FEATURE_SUP + 4)
-		goto wb_disabled;
-
 	ext_ufs_feature = get_unaligned_be32(desc_buf +
 					DEVICE_DESC_PARAM_EXT_UFS_FEATURE_SUP);
 
-- 
2.7.4


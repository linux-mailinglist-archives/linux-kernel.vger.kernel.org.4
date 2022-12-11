Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875F0649455
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 14:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiLKNFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 08:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiLKNFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 08:05:25 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68349643C;
        Sun, 11 Dec 2022 05:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670763924; x=1702299924;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=SWyM7wbZEyZVPXuv8kFl6aITesnHHHDe8q6cAolkwg8=;
  b=II+8m1pftt5nLQS8PSxzXfEu6c+8z5I5rhhzhfKsR2uDAxE7gvVwmrRu
   Ss2bs5fHE3wyDOgCwXfmtooMNsMpGLJd3IowpkQPHCipVPgYlRq+wL/5e
   XQ+ope9NXkbqvWRo6QH+dDV6VvrJvSIZWAOPzMJSMIRJ+IER3Jh7gjyx5
   yKP+3y1RTMWz/bLRoM1qNvdhlaa30RBppY/NMYmz1NFV1FtpSOYx2EfLk
   7iFq928h+cotALMzgNQTwBQMCxVTW+8n8Tl5muN1CoF61jFLxskmRr45a
   yPzUcDt1pf759WPvKRzDEiO5ly+rVP07/In101TZrogRK8l0xhk5Ds5ep
   w==;
X-IronPort-AV: E=Sophos;i="5.96,236,1665417600"; 
   d="scan'208";a="218373507"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Dec 2022 21:05:24 +0800
IronPort-SDR: 2HA5PcRhNW7Y6YwBFvLW70UvDP035VWCPGycvBFwhePrKpNW1d6B2xb00nBF/9rTzykeAdhjU9
 o8lg6oR7BZ2cNJroJG2P8yh54KX3eqOlx8VDh6LY1rTVMsx9dZP6W9Xh1YVYrrcTcjLypCvsqI
 TmfsnRo6T0SbLCY8LwYmp/7106IMSBh+VBUYSE8afZx8IjakdWjZwi61eHS/YZLYTyhmgWGlLv
 ORj3QGUbsTPROP0eWULUoWFseDIwRwEQEGmcddC5w7/lbdPoQkTo5f3GfRBMPxbRsHsMS7CBT/
 aXQ=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Dec 2022 04:23:50 -0800
IronPort-SDR: v/6xWXe4O2pFf1I6vNnRRyGvaWgAaQTAWAjn4t5CaGRpoqlLWfFjYDjkYBM54bD+KEIip9P75w
 sCh4HFsBX2ykWd3jNBlh/TNwn4wdhJhvSXsEwJiU3RjERsaXfnj9fM+IRPRs5ttgq0fHTz995e
 uU6CWvH9mm0O7koXVCtGuqQYOfJgLX/3uD8V8gMKlnyfgB5wO0vckoH6eaWW20dwxnDQhY+S37
 piCkOaOfqqBlE2uV5HxX9TwKpy2dHns2wlcaTos/zZQThF5IpCpXXKBiUZIQv6NCBt/LnrFlmk
 66o=
WDCIronportException: Internal
Received: from ilb001078.ad.shared (HELO ilb001078.sdcorp.global.sandisk.com) ([10.45.31.219])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Dec 2022 05:05:22 -0800
From:   Arthur Simchaev <Arthur.Simchaev@wdc.com>
To:     martin.petersen@oracle.com
Cc:     beanhuo@micron.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>
Subject: [PATCH v5 1/4] ufs: core: Remove redundant wb check
Date:   Sun, 11 Dec 2022 15:05:08 +0200
Message-Id: <1670763911-8695-2-git-send-email-Arthur.Simchaev@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1670763911-8695-1-git-send-email-Arthur.Simchaev@wdc.com>
References: <1670763911-8695-1-git-send-email-Arthur.Simchaev@wdc.com>
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

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Bean Huo <beanhuo@micron.com>
Signed-off-by: Arthur Simchaev <Arthur.Simchaev@wdc.com>
---
 drivers/ufs/core/ufshcd.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 2dbe249..2e47c69 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -7608,10 +7608,6 @@ static void ufshcd_wb_probe(struct ufs_hba *hba, const u8 *desc_buf)
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


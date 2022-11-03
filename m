Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387C5618629
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 18:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiKCR2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 13:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbiKCR2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 13:28:30 -0400
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BCB260E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 10:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1667496496; bh=R6oCo297C1YGslSWKkB9sgAaUyp+oQZcJpPRFdf9HQg=;
        h=X-EA-Auth:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=N+ZuB7zPfHccP+yKzXwWKRP8zns20BHt2FLRT4KXbfeJiMmz4vV0NC2pWRBws1YkN
         xn244xTbl4xNGAgGRjcTfZlRD54lYT3G/7t+kP/OZNu/LURWS29oXuYRhKKNtYWh/G
         zo7OW27N9A+iuhMpPTZHY22ezSW1Xn+Vm+LgPpoE=
Received: by b-4.in.mailobj.net [192.168.90.14] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Thu,  3 Nov 2022 18:28:16 +0100 (CET)
X-EA-Auth: LIcWCQMLBGgV++9XGzMS/C3LO5PG0kmCnd3VqX0J6pRK+pz1jGbpWfL+yrccw6Bxe1o7cGOTPmMMz80ANIXfHvGZTo5Qwi0a
Date:   Thu, 3 Nov 2022 22:58:06 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     outreachy@lists.linux.dev,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxstaging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: r8188eu: remove unused ijk_matrix_regs_set
 implementation
Message-ID: <Y2P6Jj+IcPss0wFd@qemulion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instance IQKMatrixRegSetting of struct ijk_matrix_regs_set is
initialised and its member variables are assigned values, but it is
not used anywhere. Remove the structure and its unused implementation.

Suggested-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Deepak R Varma <drv@mailo.com>
---

Changes in v2:
   1. Instead of converting 2D array to 1D, remove the associated implementation
      since it is not used anywhere in the code.
      Feedback by gregkh@linuxfoundation.org
   2. Just for reference, the patch subject in v1 was:
      "staging: r8188eu: replace one element 2D array by 1D array"


 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c | 8 --------
 drivers/staging/r8188eu/include/odm.h        | 7 -------
 2 files changed, 15 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
index 622f95d3f2ed..26e710ef5134 100644
--- a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
+++ b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
@@ -882,14 +882,6 @@ void PHY_IQCalibrate_8188E(struct adapter *adapt, bool recovery)
 	if (RegE94 != 0)
 		patha_fill_iqk(adapt, pathaok, result, final_candidate, (RegEA4 == 0));

-/* To Fix BSOD when final_candidate is 0xff */
-/* by sherry 20120321 */
-	if (final_candidate < 4) {
-		for (i = 0; i < IQK_Matrix_REG_NUM; i++)
-			dm_odm->RFCalibrateInfo.IQKMatrixRegSetting.Value[0][i] = result[final_candidate][i];
-		dm_odm->RFCalibrateInfo.IQKMatrixRegSetting.bIQKDone = true;
-	}
-
 	_PHY_SaveADDARegisters(adapt, IQK_BB_REG_92C, dm_odm->RFCalibrateInfo.IQK_BB_backup_recover, 9);
 }

diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index 89b01dd614ba..8cea166b7b73 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -80,7 +80,6 @@ struct odm_rate_adapt {
 #define HP_THERMAL_NUM		8

 #define AVG_THERMAL_NUM		8
-#define IQK_Matrix_REG_NUM	8

 struct odm_phy_dbg_info {
 	/* ODM Write,debug info */
@@ -164,11 +163,6 @@ struct odm_ra_info {
 	u8 PTSmoothFactor;
 };

-struct ijk_matrix_regs_set {
-	bool	bIQKDone;
-	s32	Value[1][IQK_Matrix_REG_NUM];
-};
-
 struct odm_rf_cal {
 	/* for tx power tracking */
 	u32	RegA24; /*  for TempCCK */
@@ -206,7 +200,6 @@ struct odm_rf_cal {

 	u8	ThermalValue_HP[HP_THERMAL_NUM];
 	u8	ThermalValue_HP_index;
-	struct ijk_matrix_regs_set IQKMatrixRegSetting;

 	u8	Delta_IQK;
 	u8	Delta_LCK;
--
2.34.1




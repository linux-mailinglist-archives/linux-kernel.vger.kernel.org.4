Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5720C61A011
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 19:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbiKDSfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 14:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbiKDSfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 14:35:10 -0400
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA5012F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 11:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1667586901; bh=hp0FgrNepDKLSNCKZLrPBSzkRWyWgrFj8BHfBxyz8Ds=;
        h=X-EA-Auth:Date:From:To:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=mk6+ezgaLY4F7HfP3LNQvNUj7KQfYv16P21dszAGgTINmX5jjRQsOau8dEMRkoAOy
         cpA668cLDqi4y2A+rjqpxLXYtU1TzVyQjcyYRKnaFnj5opINE2PW3FaCogZjzPt09p
         QMyVN2OTdVGmLXLW9HAr5RrlblYKMkeTpOywE1Xk=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Fri,  4 Nov 2022 19:35:01 +0100 (CET)
X-EA-Auth: Mf2Unhvy4C6KZ0+FTvygUlpAP2szYr3OpQncwjcpdnKHkp+ZTvwxP4GYPJfKhSzlN2+evs3xGSpLXe1jKjzuFCVBufeArKhQ
Date:   Sat, 5 Nov 2022 00:04:56 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] staging: rtl8723bs: Simplify underutilized 2D array to
 1D array
Message-ID: <4fb8d9783553d15a58e774d7137519d46e58ee3a.1667586648.git.drv@mailo.com>
References: <cover.1667586648.git.drv@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1667586648.git.drv@mailo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Member variable "Value" of structure iqk_matrix_regs_setting is
declared to be a 2D array of [3][IQK_Matrix_REG_NUM] grid. However
the primary index of this array is only used for index 0, the other
two elements are never used. Simplify this array to a one dimension
degree. The resultant code is simpler and is easy to maintain.

Suggested-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c | 18 +++++++++---------
 drivers/staging/rtl8723bs/hal/odm.h            |  2 +-
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c b/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
index a52748f7b56e..9317a4462c02 100644
--- a/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
+++ b/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
@@ -244,8 +244,8 @@ void ODM_TxPwrTrackSetPwr_8723B(
 			Final_CCK_Swing_Index = 0;

 		setIqkMatrix_8723B(pDM_Odm, Final_OFDM_Swing_Index, RFPath,
-			pDM_Odm->RFCalibrateInfo.IQKMatrixRegSetting[ChannelMappedIndex].Value[0][0],
-			pDM_Odm->RFCalibrateInfo.IQKMatrixRegSetting[ChannelMappedIndex].Value[0][1]);
+			pDM_Odm->RFCalibrateInfo.IQKMatrixRegSetting[ChannelMappedIndex].Value[0],
+			pDM_Odm->RFCalibrateInfo.IQKMatrixRegSetting[ChannelMappedIndex].Value[1]);

 		setCCKFilterCoefficient(pDM_Odm, Final_CCK_Swing_Index);

@@ -257,8 +257,8 @@ void ODM_TxPwrTrackSetPwr_8723B(
 			pDM_Odm->Remnant_OFDMSwingIdx[RFPath] = Final_OFDM_Swing_Index - PwrTrackingLimit_OFDM;

 			setIqkMatrix_8723B(pDM_Odm, PwrTrackingLimit_OFDM, RFPath,
-				pDM_Odm->RFCalibrateInfo.IQKMatrixRegSetting[ChannelMappedIndex].Value[0][0],
-				pDM_Odm->RFCalibrateInfo.IQKMatrixRegSetting[ChannelMappedIndex].Value[0][1]);
+				pDM_Odm->RFCalibrateInfo.IQKMatrixRegSetting[ChannelMappedIndex].Value[0],
+				pDM_Odm->RFCalibrateInfo.IQKMatrixRegSetting[ChannelMappedIndex].Value[1]);

 			pDM_Odm->Modify_TxAGC_Flag_PathA = true;
 			PHY_SetTxPowerIndexByRateSection(Adapter, RFPath, pHalData->CurrentChannel, OFDM);
@@ -267,16 +267,16 @@ void ODM_TxPwrTrackSetPwr_8723B(
 			pDM_Odm->Remnant_OFDMSwingIdx[RFPath] = Final_OFDM_Swing_Index;

 			setIqkMatrix_8723B(pDM_Odm, 0, RFPath,
-				pDM_Odm->RFCalibrateInfo.IQKMatrixRegSetting[ChannelMappedIndex].Value[0][0],
-				pDM_Odm->RFCalibrateInfo.IQKMatrixRegSetting[ChannelMappedIndex].Value[0][1]);
+				pDM_Odm->RFCalibrateInfo.IQKMatrixRegSetting[ChannelMappedIndex].Value[0],
+				pDM_Odm->RFCalibrateInfo.IQKMatrixRegSetting[ChannelMappedIndex].Value[1]);

 			pDM_Odm->Modify_TxAGC_Flag_PathA = true;
 			PHY_SetTxPowerIndexByRateSection(Adapter, RFPath, pHalData->CurrentChannel, OFDM);
 			PHY_SetTxPowerIndexByRateSection(Adapter, RFPath, pHalData->CurrentChannel, HT_MCS0_MCS7);
 		} else {
 			setIqkMatrix_8723B(pDM_Odm, Final_OFDM_Swing_Index, RFPath,
-				pDM_Odm->RFCalibrateInfo.IQKMatrixRegSetting[ChannelMappedIndex].Value[0][0],
-				pDM_Odm->RFCalibrateInfo.IQKMatrixRegSetting[ChannelMappedIndex].Value[0][1]);
+				pDM_Odm->RFCalibrateInfo.IQKMatrixRegSetting[ChannelMappedIndex].Value[0],
+				pDM_Odm->RFCalibrateInfo.IQKMatrixRegSetting[ChannelMappedIndex].Value[1]);

 			if (pDM_Odm->Modify_TxAGC_Flag_PathA) { /* If TxAGC has changed, reset TxAGC again */
 				pDM_Odm->Remnant_OFDMSwingIdx[RFPath] = 0;
@@ -1760,7 +1760,7 @@ void PHY_IQCalibrate_8723B(
 /* by sherry 20120321 */
 	if (final_candidate < 4) {
 		for (i = 0; i < IQK_Matrix_REG_NUM; i++)
-			pDM_Odm->RFCalibrateInfo.IQKMatrixRegSetting[0].Value[0][i] = result[final_candidate][i];
+			pDM_Odm->RFCalibrateInfo.IQKMatrixRegSetting[0].Value[i] = result[final_candidate][i];
 		pDM_Odm->RFCalibrateInfo.IQKMatrixRegSetting[0].bIQKDone = true;
 	}

diff --git a/drivers/staging/rtl8723bs/hal/odm.h b/drivers/staging/rtl8723bs/hal/odm.h
index fe9782d2d4fd..e16a769850c5 100644
--- a/drivers/staging/rtl8723bs/hal/odm.h
+++ b/drivers/staging/rtl8723bs/hal/odm.h
@@ -481,7 +481,7 @@ enum odm_type_alna_e { /* tag_ODM_TYPE_ALNA_Definition */

 struct iqk_matrix_regs_setting { /* _IQK_MATRIX_REGS_SETTING */
 	bool bIQKDone;
-	s32 Value[3][IQK_Matrix_REG_NUM];
+	s32 Value[IQK_Matrix_REG_NUM];
 	bool bBWIqkResultSaved[3];
 };

--
2.34.1




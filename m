Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D4F61D99F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 12:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiKELQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 07:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKELQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 07:16:11 -0400
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D071401D
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 04:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1667646959; bh=qpdJDaTBBCeIGg/s5FF6Owl+Qmp6uRMXzQxAbIrbnuI=;
        h=X-EA-Auth:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=QEqVKTAPIE8aJpYbG134PB+D10efGJZIBF3i4rmr9CyGOt5QNa7T3Z3Oqr9ay+x4S
         2KdJvUt8JCf58UlxTFlFurGsWnIaNT2EbcrVNzRveBajL2cI3nq1J2xB1m0QOURsnL
         q1RLEaBbTFP2OHAc/zG0OLNitkQEuGQLTr/kLHKg=
Received: by b-4.in.mailobj.net [192.168.90.14] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sat,  5 Nov 2022 12:15:59 +0100 (CET)
X-EA-Auth: 0a3f/EhSvrbBZHBeZyD0G94mZtjjVEpUBuHyJrOYrVpONyWHt6JggA7qfN8IfBJcHiOq+0DctaiIqmf6ffj7q2hvF9duzjeM
Date:   Sat, 5 Nov 2022 16:45:52 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: rtl8723bs: replace underutilized struct by array
 variable
Message-ID: <Y2ZF6O1KU3zZ6r3C@qemulion>
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

For structure iqk_matrix_regs_setting, only the "Value" member variable
is utilized whereas the other struct members are only declared but not
utilised. Replace the struct declaration and implementation by an
equivalent variable similar to the only used struct member variable.
While in there, update the macro mixed case names to uppercase style.
The resultant code is simpler and is easy to maintain.

Suggested-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Deepak R Varma <drv@mailo.com>
---

Changes in v2:

This patch now replaces the earlier patchset titled: "staging: rtl8723bs: struct
iqk_matrix_regs_setting cleanup" made up of following two patches:
   1. staging: rtl8723bs: Simplify underutilized 2D array to 1D array
   2. staging: rtl8723bs: Remove unused member variable

Based on the feedback received from gregkh@linuxfoundation.org and further code
analysis, it is determined that the code can be further cleaned up and
simplified. Hence the changes are now consolidated into a single patch replacing
the earlier split patches.

The changes are compile tested only.


 .../staging/rtl8723bs/hal/HalPhyRf_8723B.c    | 21 +++++++++----------
 drivers/staging/rtl8723bs/hal/odm.h           | 12 +++--------
 2 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c b/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
index a52748f7b56e..22e33b97800d 100644
--- a/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
+++ b/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
@@ -244,8 +244,8 @@ void ODM_TxPwrTrackSetPwr_8723B(
 			Final_CCK_Swing_Index = 0;

 		setIqkMatrix_8723B(pDM_Odm, Final_OFDM_Swing_Index, RFPath,
-			pDM_Odm->RFCalibrateInfo.IQKMatrixRegSetting[ChannelMappedIndex].Value[0][0],
-			pDM_Odm->RFCalibrateInfo.IQKMatrixRegSetting[ChannelMappedIndex].Value[0][1]);
+			pDM_Odm->RFCalibrateInfo.iqk_matrix_regs_setting_value[ChannelMappedIndex][0],
+			pDM_Odm->RFCalibrateInfo.iqk_matrix_regs_setting_value[ChannelMappedIndex][1]);

 		setCCKFilterCoefficient(pDM_Odm, Final_CCK_Swing_Index);

@@ -257,8 +257,8 @@ void ODM_TxPwrTrackSetPwr_8723B(
 			pDM_Odm->Remnant_OFDMSwingIdx[RFPath] = Final_OFDM_Swing_Index - PwrTrackingLimit_OFDM;

 			setIqkMatrix_8723B(pDM_Odm, PwrTrackingLimit_OFDM, RFPath,
-				pDM_Odm->RFCalibrateInfo.IQKMatrixRegSetting[ChannelMappedIndex].Value[0][0],
-				pDM_Odm->RFCalibrateInfo.IQKMatrixRegSetting[ChannelMappedIndex].Value[0][1]);
+				pDM_Odm->RFCalibrateInfo.iqk_matrix_regs_setting_value[ChannelMappedIndex][0],
+				pDM_Odm->RFCalibrateInfo.iqk_matrix_regs_setting_value[ChannelMappedIndex][1]);

 			pDM_Odm->Modify_TxAGC_Flag_PathA = true;
 			PHY_SetTxPowerIndexByRateSection(Adapter, RFPath, pHalData->CurrentChannel, OFDM);
@@ -267,16 +267,16 @@ void ODM_TxPwrTrackSetPwr_8723B(
 			pDM_Odm->Remnant_OFDMSwingIdx[RFPath] = Final_OFDM_Swing_Index;

 			setIqkMatrix_8723B(pDM_Odm, 0, RFPath,
-				pDM_Odm->RFCalibrateInfo.IQKMatrixRegSetting[ChannelMappedIndex].Value[0][0],
-				pDM_Odm->RFCalibrateInfo.IQKMatrixRegSetting[ChannelMappedIndex].Value[0][1]);
+				pDM_Odm->RFCalibrateInfo.iqk_matrix_regs_setting_value[ChannelMappedIndex][0],
+				pDM_Odm->RFCalibrateInfo.iqk_matrix_regs_setting_value[ChannelMappedIndex][1]);

 			pDM_Odm->Modify_TxAGC_Flag_PathA = true;
 			PHY_SetTxPowerIndexByRateSection(Adapter, RFPath, pHalData->CurrentChannel, OFDM);
 			PHY_SetTxPowerIndexByRateSection(Adapter, RFPath, pHalData->CurrentChannel, HT_MCS0_MCS7);
 		} else {
 			setIqkMatrix_8723B(pDM_Odm, Final_OFDM_Swing_Index, RFPath,
-				pDM_Odm->RFCalibrateInfo.IQKMatrixRegSetting[ChannelMappedIndex].Value[0][0],
-				pDM_Odm->RFCalibrateInfo.IQKMatrixRegSetting[ChannelMappedIndex].Value[0][1]);
+				pDM_Odm->RFCalibrateInfo.iqk_matrix_regs_setting_value[ChannelMappedIndex][0],
+				pDM_Odm->RFCalibrateInfo.iqk_matrix_regs_setting_value[ChannelMappedIndex][1]);

 			if (pDM_Odm->Modify_TxAGC_Flag_PathA) { /* If TxAGC has changed, reset TxAGC again */
 				pDM_Odm->Remnant_OFDMSwingIdx[RFPath] = 0;
@@ -1759,9 +1759,8 @@ void PHY_IQCalibrate_8723B(
 /* To Fix BSOD when final_candidate is 0xff */
 /* by sherry 20120321 */
 	if (final_candidate < 4) {
-		for (i = 0; i < IQK_Matrix_REG_NUM; i++)
-			pDM_Odm->RFCalibrateInfo.IQKMatrixRegSetting[0].Value[0][i] = result[final_candidate][i];
-		pDM_Odm->RFCalibrateInfo.IQKMatrixRegSetting[0].bIQKDone = true;
+		for (i = 0; i < IQK_MATRIX_REG_NUM; i++)
+			pDM_Odm->RFCalibrateInfo.iqk_matrix_regs_setting_value[0][i] = result[final_candidate][i];
 	}

 	_PHY_SaveADDARegisters8723B(padapter, IQK_BB_REG_92C, pDM_Odm->RFCalibrateInfo.IQK_BB_backup_recover, 9);
diff --git a/drivers/staging/rtl8723bs/hal/odm.h b/drivers/staging/rtl8723bs/hal/odm.h
index fe9782d2d4fd..f5c804a1b9d5 100644
--- a/drivers/staging/rtl8723bs/hal/odm.h
+++ b/drivers/staging/rtl8723bs/hal/odm.h
@@ -193,8 +193,8 @@ struct odm_rate_adaptive {
 #define HP_THERMAL_NUM		8

 #define AVG_THERMAL_NUM		8
-#define IQK_Matrix_REG_NUM	8
-#define IQK_Matrix_Settings_NUM	14 /* Channels_2_4G_NUM */
+#define IQK_MATRIX_REG_NUM	8
+#define IQK_MATRIX_SETTINGS_NUM	14 /* Channels_2_4G_NUM */

 #define		DM_Type_ByFW			0
 #define		DM_Type_ByDriver		1
@@ -479,12 +479,6 @@ enum odm_type_alna_e { /* tag_ODM_TYPE_ALNA_Definition */
 	TYPE_ALNA3 = BIT(3)|BIT(2)|BIT(1)|BIT(0)
 };

-struct iqk_matrix_regs_setting { /* _IQK_MATRIX_REGS_SETTING */
-	bool bIQKDone;
-	s32 Value[3][IQK_Matrix_REG_NUM];
-	bool bBWIqkResultSaved[3];
-};
-
 /* Remove PATHDIV_PARA struct to odm_PathDiv.h */

 struct odm_rf_cal_t { /* ODM_RF_Calibration_Structure */
@@ -530,7 +524,7 @@ struct odm_rf_cal_t { /* ODM_RF_Calibration_Structure */

 	u8 ThermalValue_HP[HP_THERMAL_NUM];
 	u8 ThermalValue_HP_index;
-	struct iqk_matrix_regs_setting IQKMatrixRegSetting[IQK_Matrix_Settings_NUM];
+	s32 iqk_matrix_regs_setting_value[IQK_MATRIX_SETTINGS_NUM][IQK_MATRIX_REG_NUM];
 	bool bNeedIQK;
 	bool bIQKInProgress;
 	u8 Delta_IQK;
--
2.34.1




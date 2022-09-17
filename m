Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820B85BB643
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 06:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiIQE0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 00:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiIQEZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 00:25:46 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C77BA74F5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 21:25:44 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id 13so24501047ejn.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 21:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date;
        bh=VqhHMljAu1g+wJEyrHQ/EApSp/g9cqVTDobcVCKucEw=;
        b=S/ITtk/kUcYt+Hzp/FghonA+/KCyWnSUDXtE7AAnoADj1wMRjkBPtXhqc9wFDH5SSC
         w+nYfUWpqXMApvB7yyry2iQ6RUbQ3WEGu1+W4oUPdDa5oozGgATcDgoY3vp/hV1Q8tMV
         OCye+qICUXvD4uuyJf5D3iyRM2U+ot5BcufK5eBfIQq4GyRUYqg057lu1tr2EAiRwmTJ
         5V78f36ZoFRwuSlGZn1M1zMGzThp+DFFMtZM9m3MViBIpRiPTd2C8KZjjXBrFqsyb6d5
         ESfqgPlwfXMlruN1wUmPuuTRHYnMVLyZVnGy5BRbfNZ98pL4RiC4nkA1AsjZcaLbZRpm
         fN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=VqhHMljAu1g+wJEyrHQ/EApSp/g9cqVTDobcVCKucEw=;
        b=CEYCJnnOXnVw56E5bKIXGRLIQmkbzwNbOcOLhNvCFAgGjRURf+EAOiKSBEeti+Zlx6
         yPqh5+CFDiqi+WaPPzsxulTQh5MLEQCZ0WDuUW5MxtwYqinw/JgbY812a8p2hGVXa+Q1
         Zie5bNvdWGEqA4jwhLtbl1doR0oXghyaUvaO70A9zRKLm3cPhgxAnGzz7Xx46CNWrziB
         O9bjZfP47l7qnemRe0p8srRCoCSu0+S/jJg7onWGUXIcP09WSXqKhibFtQYt0OK1L9Hh
         lub0bXoSEwOS15OeoZYIM9HL0IltojwwIszYOlTTymq/k6YbBgesAYTF+zUPQe2S3ZeA
         v+3w==
X-Gm-Message-State: ACrzQf38BIz9S3Ww+EsOnT0qltYSDnmwT1ErcEimB/BgRfFBdVjQ16hg
        xKPUA4nRcSNFRbJvH1EsCJ4=
X-Google-Smtp-Source: AMsMyM4TxqqojMZbf0FRtgj3oivhttDIZRVpH0bA+lqrWm/hIb6G7hTNkYd5x/UY+OsVbKJKVm6TRg==
X-Received: by 2002:a17:907:3f12:b0:77b:8d8:f353 with SMTP id hq18-20020a1709073f1200b0077b08d8f353mr5477575ejc.349.1663388742807;
        Fri, 16 Sep 2022 21:25:42 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id w11-20020a056402128b00b0044e7adbe0c5sm14890745edv.87.2022.09.16.21.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 21:25:42 -0700 (PDT)
Date:   Sat, 17 Sep 2022 06:25:40 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] staging: rtl8192e: Remove ftrace-like logging in rtl_dm.c
Message-ID: <bc0e2c9551ccf78fe388b27d18576b5bb195e2f7.1663387785.git.philipp.g.hortmann@gmail.com>
References: <cover.1663387785.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1663387785.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove "Unnecessary ftrace-like logging" as requested by checkpatch.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 165 ---------------------
 1 file changed, 165 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index 3ee52147960e..6d09b71d4993 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -268,8 +268,6 @@ static void _rtl92e_dm_check_ac_dc_power(struct net_device *dev)
 			 NULL};
 
 	if (priv->ResetProgress == RESET_TYPE_SILENT) {
-		RT_TRACE((COMP_INIT | COMP_POWER | COMP_RF),
-			 "GPIOChangeRFWorkItemCallBack(): Silent Reset!!!!!!!\n");
 		return;
 	}
 
@@ -333,8 +331,6 @@ static void _rtl92e_dm_check_rate_adaptive(struct net_device *dev)
 	static u8 ping_rssi_state;
 
 	if (!priv->up) {
-		RT_TRACE(COMP_RATE,
-			 "<---- %s: driver is going to unload\n", __func__);
 		return;
 	}
 
@@ -423,9 +419,6 @@ static void _rtl92e_dm_check_rate_adaptive(struct net_device *dev)
 			u32 ratr_value;
 
 			ratr_value = targetRATR;
-			RT_TRACE(COMP_RATE,
-				 "currentRATR = %x, targetRATR = %x\n",
-				 currentRATR, targetRATR);
 			if (priv->rf_type == RF_1T2R)
 				ratr_value &= ~(RATE_ALL_OFDM_2SS);
 			rtl92e_writel(dev, RATR0, ratr_value);
@@ -628,7 +621,6 @@ static void _rtl92e_dm_tx_power_tracking_callback_tssi(struct net_device *dev)
 	u16	Avg_TSSI_Meas, TSSI_13dBm, Avg_TSSI_Meas_from_driver = 0;
 	u32	delta = 0;
 
-	RT_TRACE(COMP_POWER_TRACKING, "%s()\n", __func__);
 	rtl92e_writeb(dev, Pw_Track_Flag, 0);
 	rtl92e_writeb(dev, FW_Busy_Flag, 0);
 	priv->rtllib->bdynamic_txpower_enable = false;
@@ -637,10 +629,6 @@ static void _rtl92e_dm_tx_power_tracking_callback_tssi(struct net_device *dev)
 	RF_Type = priv->rf_type;
 	Value = (RF_Type<<8) | powerlevelOFDM24G;
 
-	RT_TRACE(COMP_POWER_TRACKING, "powerlevelOFDM24G = %x\n",
-		 powerlevelOFDM24G);
-
-
 	for (j = 0; j <= 30; j++) {
 
 		tx_cmd.Op		= TXCMD_SET_TX_PWR_TRACKING;
@@ -656,15 +644,11 @@ static void _rtl92e_dm_tx_power_tracking_callback_tssi(struct net_device *dev)
 				mdelay(1);
 
 				if (priv->bResetInProgress) {
-					RT_TRACE(COMP_POWER_TRACKING,
-						 "we are in silent reset progress, so return\n");
 					rtl92e_writeb(dev, Pw_Track_Flag, 0);
 					rtl92e_writeb(dev, FW_Busy_Flag, 0);
 					return;
 				}
 				if (priv->rtllib->eRFPowerState != eRfOn) {
-					RT_TRACE(COMP_POWER_TRACKING,
-						 "we are in power save, so return\n");
 					rtl92e_writeb(dev, Pw_Track_Flag, 0);
 					rtl92e_writeb(dev, FW_Busy_Flag, 0);
 					return;
@@ -689,10 +673,6 @@ static void _rtl92e_dm_tx_power_tracking_callback_tssi(struct net_device *dev)
 					tmp_report[k] = rtl92e_readb(dev,
 							 Tssi_Report_Value2);
 
-				RT_TRACE(COMP_POWER_TRACKING,
-					 "TSSI_report_value = %d\n",
-					 tmp_report[k]);
-
 				if (tmp_report[k] <= 20) {
 					viviflag = true;
 					break;
@@ -702,8 +682,6 @@ static void _rtl92e_dm_tx_power_tracking_callback_tssi(struct net_device *dev)
 			if (viviflag) {
 				rtl92e_writeb(dev, Pw_Track_Flag, 0);
 				viviflag = false;
-				RT_TRACE(COMP_POWER_TRACKING,
-					 "we filted this data\n");
 				for (k = 0; k < 5; k++)
 					tmp_report[k] = 0;
 				break;
@@ -713,12 +691,7 @@ static void _rtl92e_dm_tx_power_tracking_callback_tssi(struct net_device *dev)
 				Avg_TSSI_Meas_from_driver += tmp_report[k];
 
 			Avg_TSSI_Meas_from_driver *= 100 / 5;
-			RT_TRACE(COMP_POWER_TRACKING,
-				 "Avg_TSSI_Meas_from_driver = %d\n",
-				 Avg_TSSI_Meas_from_driver);
 			TSSI_13dBm = priv->TSSI_13dBm;
-			RT_TRACE(COMP_POWER_TRACKING, "TSSI_13dBm = %d\n",
-				 TSSI_13dBm);
 
 			if (Avg_TSSI_Meas_from_driver > TSSI_13dBm)
 				delta = Avg_TSSI_Meas_from_driver - TSSI_13dBm;
@@ -729,20 +702,6 @@ static void _rtl92e_dm_tx_power_tracking_callback_tssi(struct net_device *dev)
 				priv->rtllib->bdynamic_txpower_enable = true;
 				rtl92e_writeb(dev, Pw_Track_Flag, 0);
 				rtl92e_writeb(dev, FW_Busy_Flag, 0);
-				RT_TRACE(COMP_POWER_TRACKING,
-					 "tx power track is done\n");
-				RT_TRACE(COMP_POWER_TRACKING,
-					 "priv->rfa_txpowertrackingindex = %d\n",
-					 priv->rfa_txpowertrackingindex);
-				RT_TRACE(COMP_POWER_TRACKING,
-					 "priv->rfa_txpowertrackingindex_real = %d\n",
-					 priv->rfa_txpowertrackingindex_real);
-				RT_TRACE(COMP_POWER_TRACKING,
-					 "priv->CCKPresentAttentuation_difference = %d\n",
-					 priv->CCKPresentAttentuation_difference);
-				RT_TRACE(COMP_POWER_TRACKING,
-					 "priv->CCKPresentAttentuation = %d\n",
-					 priv->CCKPresentAttentuation);
 				return;
 			}
 			if (Avg_TSSI_Meas_from_driver < TSSI_13dBm - E_FOR_TX_POWER_TRACK)
@@ -785,26 +744,12 @@ static void _rtl92e_dm_tx_power_tracking_callback_tssi(struct net_device *dev)
 				} else
 					rtl92e_dm_cck_txpower_adjust(dev, priv->bcck_in_ch14);
 			}
-			RT_TRACE(COMP_POWER_TRACKING,
-				 "priv->rfa_txpowertrackingindex = %d\n",
-				 priv->rfa_txpowertrackingindex);
-			RT_TRACE(COMP_POWER_TRACKING,
-				 "priv->rfa_txpowertrackingindex_real = %d\n",
-				 priv->rfa_txpowertrackingindex_real);
-			RT_TRACE(COMP_POWER_TRACKING,
-				 "priv->CCKPresentAttentuation_difference = %d\n",
-				 priv->CCKPresentAttentuation_difference);
-			RT_TRACE(COMP_POWER_TRACKING,
-				 "priv->CCKPresentAttentuation = %d\n",
-				 priv->CCKPresentAttentuation);
 
 			if (priv->CCKPresentAttentuation_difference <= -12 ||
 			    priv->CCKPresentAttentuation_difference >= 24) {
 				priv->rtllib->bdynamic_txpower_enable = true;
 				rtl92e_writeb(dev, Pw_Track_Flag, 0);
 				rtl92e_writeb(dev, FW_Busy_Flag, 0);
-				RT_TRACE(COMP_POWER_TRACKING,
-					 "tx power track--->limited\n");
 				return;
 			}
 
@@ -834,10 +779,6 @@ static void _rtl92e_dm_tx_power_tracking_cb_thermal(struct net_device *dev)
 		for (i = 0; i < OFDM_Table_Length; i++) {
 			if (tmpRegA == OFDMSwingTable[i]) {
 				priv->OFDM_index[0] = i;
-				RT_TRACE(COMP_POWER_TRACKING,
-					 "Initial reg0x%x = 0x%x, OFDM_index = 0x%x\n",
-					 rOFDM0_XATxIQImbalance, tmpRegA,
-					 priv->OFDM_index[0]);
 			}
 		}
 
@@ -845,10 +786,6 @@ static void _rtl92e_dm_tx_power_tracking_cb_thermal(struct net_device *dev)
 		for (i = 0; i < CCK_Table_length; i++) {
 			if (TempCCk == (u32)CCKSwingTable_Ch1_Ch13[i][0]) {
 				priv->CCK_index = i;
-				RT_TRACE(COMP_POWER_TRACKING,
-					 "Initial reg0x%x = 0x%x, CCK_index = 0x%x\n",
-					 rCCK0_TxFilter1, TempCCk,
-					 priv->CCK_index);
 				break;
 			}
 		}
@@ -857,12 +794,10 @@ static void _rtl92e_dm_tx_power_tracking_cb_thermal(struct net_device *dev)
 	}
 
 	tmpRegA = rtl92e_get_rf_reg(dev, RF90_PATH_A, 0x12, 0x078);
-	RT_TRACE(COMP_POWER_TRACKING, "Readback ThermalMeterA = %d\n", tmpRegA);
 	if (tmpRegA < 3 || tmpRegA > 13)
 		return;
 	if (tmpRegA >= 12)
 		tmpRegA = 12;
-	RT_TRACE(COMP_POWER_TRACKING, "Valid ThermalMeterA = %d\n", tmpRegA);
 	priv->ThermalMeter[0] = ThermalMeterVal;
 	priv->ThermalMeter[1] = ThermalMeterVal;
 
@@ -894,9 +829,6 @@ static void _rtl92e_dm_tx_power_tracking_cb_thermal(struct net_device *dev)
 
 	priv->Record_CCK_20Mindex = tmpCCK20Mindex;
 	priv->Record_CCK_40Mindex = tmpCCK40Mindex;
-	RT_TRACE(COMP_POWER_TRACKING,
-		 "Record_CCK_20Mindex / Record_CCK_40Mindex = %d / %d.\n",
-		 priv->Record_CCK_20Mindex, priv->Record_CCK_40Mindex);
 
 	if (priv->rtllib->current_network.channel == 14 &&
 	    !priv->bcck_in_ch14) {
@@ -919,9 +851,6 @@ static void _rtl92e_dm_tx_power_tracking_cb_thermal(struct net_device *dev)
 		priv->OFDM_index[0] = tmpOFDMindex;
 		rtl92e_set_bb_reg(dev, rOFDM0_XATxIQImbalance, bMaskDWord,
 				  OFDMSwingTable[priv->OFDM_index[0]]);
-		RT_TRACE(COMP_POWER_TRACKING, "Update OFDMSwing[%d] = 0x%x\n",
-			 priv->OFDM_index[0],
-			 OFDMSwingTable[priv->OFDM_index[0]]);
 	}
 	priv->txpower_count = 0;
 }
@@ -960,8 +889,6 @@ static void _rtl92e_dm_init_tx_power_tracking_thermal(struct net_device *dev)
 		priv->btxpower_tracking = false;
 	priv->txpower_count       = 0;
 	priv->btxpower_trackingInit = false;
-	RT_TRACE(COMP_POWER_TRACKING, "pMgntInfo->bTXPowerTracking = %d\n",
-		 priv->btxpower_tracking);
 }
 
 void rtl92e_dm_init_txpower_tracking(struct net_device *dev)
@@ -979,7 +906,6 @@ static void _rtl92e_dm_check_tx_power_tracking_tssi(struct net_device *dev)
 	struct r8192_priv *priv = rtllib_priv(dev);
 	static u32 tx_power_track_counter;
 
-	RT_TRACE(COMP_POWER_TRACKING, "%s()\n", __func__);
 	if (rtl92e_readb(dev, 0x11e) == 1)
 		return;
 	if (!priv->btxpower_tracking)
@@ -1086,44 +1012,29 @@ static void _rtl92e_dm_cck_tx_power_adjust_thermal_meter(struct net_device *dev,
 		TempVal = CCKSwingTable_Ch1_Ch13[priv->CCK_index][0] +
 			  (CCKSwingTable_Ch1_Ch13[priv->CCK_index][1] << 8);
 		rtl92e_set_bb_reg(dev, rCCK0_TxFilter1, bMaskHWord, TempVal);
-		RT_TRACE(COMP_POWER_TRACKING,
-			 "CCK not chnl 14, reg 0x%x = 0x%x\n", rCCK0_TxFilter1,
-			 TempVal);
 		TempVal = CCKSwingTable_Ch1_Ch13[priv->CCK_index][2] +
 			  (CCKSwingTable_Ch1_Ch13[priv->CCK_index][3] << 8) +
 			  (CCKSwingTable_Ch1_Ch13[priv->CCK_index][4] << 16)+
 			  (CCKSwingTable_Ch1_Ch13[priv->CCK_index][5] << 24);
 		rtl92e_set_bb_reg(dev, rCCK0_TxFilter2, bMaskDWord, TempVal);
-		RT_TRACE(COMP_POWER_TRACKING,
-			 "CCK not chnl 14, reg 0x%x = 0x%x\n", rCCK0_TxFilter2,
-			 TempVal);
 		TempVal = CCKSwingTable_Ch1_Ch13[priv->CCK_index][6] +
 			  (CCKSwingTable_Ch1_Ch13[priv->CCK_index][7] << 8);
 
 		rtl92e_set_bb_reg(dev, rCCK0_DebugPort, bMaskLWord, TempVal);
-		RT_TRACE(COMP_POWER_TRACKING,
-			 "CCK not chnl 14, reg 0x%x = 0x%x\n", rCCK0_DebugPort,
-			 TempVal);
 	} else {
 		TempVal = CCKSwingTable_Ch14[priv->CCK_index][0] +
 			  (CCKSwingTable_Ch14[priv->CCK_index][1] << 8);
 
 		rtl92e_set_bb_reg(dev, rCCK0_TxFilter1, bMaskHWord, TempVal);
-		RT_TRACE(COMP_POWER_TRACKING, "CCK chnl 14, reg 0x%x = 0x%x\n",
-			rCCK0_TxFilter1, TempVal);
 		TempVal = CCKSwingTable_Ch14[priv->CCK_index][2] +
 			  (CCKSwingTable_Ch14[priv->CCK_index][3] << 8) +
 			  (CCKSwingTable_Ch14[priv->CCK_index][4] << 16)+
 			  (CCKSwingTable_Ch14[priv->CCK_index][5] << 24);
 		rtl92e_set_bb_reg(dev, rCCK0_TxFilter2, bMaskDWord, TempVal);
-		RT_TRACE(COMP_POWER_TRACKING, "CCK chnl 14, reg 0x%x = 0x%x\n",
-			rCCK0_TxFilter2, TempVal);
 		TempVal = CCKSwingTable_Ch14[priv->CCK_index][6] +
 			  (CCKSwingTable_Ch14[priv->CCK_index][7]<<8);
 
 		rtl92e_set_bb_reg(dev, rCCK0_DebugPort, bMaskLWord, TempVal);
-		RT_TRACE(COMP_POWER_TRACKING, "CCK chnl 14, reg 0x%x = 0x%x\n",
-			rCCK0_DebugPort, TempVal);
 	}
 }
 
@@ -1141,32 +1052,12 @@ static void _rtl92e_dm_tx_power_reset_recovery(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 
-	RT_TRACE(COMP_POWER_TRACKING, "Start Reset Recovery ==>\n");
 	rtl92e_set_bb_reg(dev, rOFDM0_XATxIQImbalance, bMaskDWord,
 			  dm_tx_bb_gain[priv->rfa_txpowertrackingindex]);
-	RT_TRACE(COMP_POWER_TRACKING, "Reset Recovery: Fill in 0xc80 is %08x\n",
-		 dm_tx_bb_gain[priv->rfa_txpowertrackingindex]);
-	RT_TRACE(COMP_POWER_TRACKING,
-		 "Reset Recovery: Fill in RFA_txPowerTrackingIndex is %x\n",
-		 priv->rfa_txpowertrackingindex);
-	RT_TRACE(COMP_POWER_TRACKING,
-		 "Reset Recovery : RF A I/Q Amplify Gain is %d\n",
-		 dm_tx_bb_gain_idx_to_amplify(priv->rfa_txpowertrackingindex));
-	RT_TRACE(COMP_POWER_TRACKING,
-		 "Reset Recovery: CCK Attenuation is %d dB\n",
-		 priv->CCKPresentAttentuation);
 	rtl92e_dm_cck_txpower_adjust(dev, priv->bcck_in_ch14);
 
 	rtl92e_set_bb_reg(dev, rOFDM0_XCTxIQImbalance, bMaskDWord,
 			  dm_tx_bb_gain[priv->rfc_txpowertrackingindex]);
-	RT_TRACE(COMP_POWER_TRACKING, "Reset Recovery: Fill in 0xc90 is %08x\n",
-		 dm_tx_bb_gain[priv->rfc_txpowertrackingindex]);
-	RT_TRACE(COMP_POWER_TRACKING,
-		 "Reset Recovery: Fill in RFC_txPowerTrackingIndex is %x\n",
-		 priv->rfc_txpowertrackingindex);
-	RT_TRACE(COMP_POWER_TRACKING,
-		 "Reset Recovery : RF C I/Q Amplify Gain is %d\n",
-		 dm_tx_bb_gain_idx_to_amplify(priv->rfc_txpowertrackingindex));
 }
 
 void rtl92e_dm_restore_state(struct net_device *dev)
@@ -1176,8 +1067,6 @@ void rtl92e_dm_restore_state(struct net_device *dev)
 	u32 ratr_value;
 
 	if (!priv->up) {
-		RT_TRACE(COMP_RATE,
-			 "<---- %s: driver is going to unload\n", __func__);
 		return;
 	}
 
@@ -1218,17 +1107,6 @@ static void _rtl92e_dm_bb_initialgain_restore(struct net_device *dev)
 	bit_mask  = bMaskByte2;
 	rtl92e_set_bb_reg(dev, rCCK0_CCA, bit_mask,
 			  (u32)priv->initgain_backup.cca);
-
-	RT_TRACE(COMP_DIG, "dm_BBInitialGainRestore 0xc50 is %x\n",
-		 priv->initgain_backup.xaagccore1);
-	RT_TRACE(COMP_DIG, "dm_BBInitialGainRestore 0xc58 is %x\n",
-		 priv->initgain_backup.xbagccore1);
-	RT_TRACE(COMP_DIG, "dm_BBInitialGainRestore 0xc60 is %x\n",
-		 priv->initgain_backup.xcagccore1);
-	RT_TRACE(COMP_DIG, "dm_BBInitialGainRestore 0xc68 is %x\n",
-		 priv->initgain_backup.xdagccore1);
-	RT_TRACE(COMP_DIG, "dm_BBInitialGainRestore 0xa0a is %x\n",
-		 priv->initgain_backup.cca);
 	rtl92e_set_bb_reg(dev, UFWP, bMaskByte1, 0x1);
 
 }
@@ -1251,17 +1129,6 @@ void rtl92e_dm_backup_state(struct net_device *dev)
 	priv->initgain_backup.xdagccore1 = rtl92e_get_bb_reg(dev, rOFDM0_XDAGCCore1, bit_mask);
 	bit_mask  = bMaskByte2;
 	priv->initgain_backup.cca = (u8)rtl92e_get_bb_reg(dev, rCCK0_CCA, bit_mask);
-
-	RT_TRACE(COMP_DIG, "BBInitialGainBackup 0xc50 is %x\n",
-		 priv->initgain_backup.xaagccore1);
-	RT_TRACE(COMP_DIG, "BBInitialGainBackup 0xc58 is %x\n",
-		 priv->initgain_backup.xbagccore1);
-	RT_TRACE(COMP_DIG, "BBInitialGainBackup 0xc60 is %x\n",
-		 priv->initgain_backup.xcagccore1);
-	RT_TRACE(COMP_DIG, "BBInitialGainBackup 0xc68 is %x\n",
-		 priv->initgain_backup.xdagccore1);
-	RT_TRACE(COMP_DIG, "BBInitialGainBackup 0xa0a is %x\n",
-		 priv->initgain_backup.cca);
 }
 
 static void _rtl92e_dm_dig_init(struct net_device *dev)
@@ -1820,12 +1687,10 @@ static void _rtl92e_dm_check_rf_ctrl_gpio(void *data)
 	eRfPowerStateToSet = (tmp1byte&BIT1) ?  eRfOn : eRfOff;
 
 	if (priv->hw_radio_off && (eRfPowerStateToSet == eRfOn)) {
-		RT_TRACE(COMP_RF, "gpiochangeRF  - HW Radio ON\n");
 		netdev_info(dev, "gpiochangeRF  - HW Radio ON\n");
 		priv->hw_radio_off = false;
 		bActuallySet = true;
 	} else if (!priv->hw_radio_off && (eRfPowerStateToSet == eRfOff)) {
-		RT_TRACE(COMP_RF, "gpiochangeRF  - HW Radio OFF\n");
 		netdev_info(dev, "gpiochangeRF  - HW Radio OFF\n");
 		priv->hw_radio_off = true;
 		bActuallySet = true;
@@ -2173,10 +2038,6 @@ static void _rtl92e_dm_fsync_timer_callback(struct timer_list *t)
 		}
 		priv->rate_record = rate_count;
 		priv->rateCountDiffRecord = rate_count_diff;
-		RT_TRACE(COMP_HALDM,
-			 "rateRecord %d rateCount %d, rateCountdiff %d bSwitchFsync %d\n",
-			 priv->rate_record, rate_count, rate_count_diff,
-			 priv->bswitch_fsync);
 		if (priv->undecorated_smoothed_pwdb >
 		    priv->rtllib->fsync_rssi_threshold &&
 		    bSwitchFromCountDiff) {
@@ -2220,11 +2081,6 @@ static void _rtl92e_dm_fsync_timer_callback(struct timer_list *t)
 		priv->ContinueDiffCount = 0;
 		rtl92e_writel(dev, rOFDM0_RxDetector2, 0x465c52cd);
 	}
-	RT_TRACE(COMP_HALDM, "ContinueDiffCount %d\n", priv->ContinueDiffCount);
-	RT_TRACE(COMP_HALDM,
-		 "rateRecord %d rateCount %d, rateCountdiff %d bSwitchFsync %d\n",
-		 priv->rate_record, rate_count, rate_count_diff,
-		 priv->bswitch_fsync);
 }
 
 static void _rtl92e_dm_start_hw_fsync(struct net_device *dev)
@@ -2232,7 +2088,6 @@ static void _rtl92e_dm_start_hw_fsync(struct net_device *dev)
 	u8 rf_timing = 0x77;
 	struct r8192_priv *priv = rtllib_priv(dev);
 
-	RT_TRACE(COMP_HALDM, "%s\n", __func__);
 	rtl92e_writel(dev, rOFDM0_RxDetector2, 0x465c12cf);
 	priv->rtllib->SetHwRegHandler(dev, HW_VAR_RF_TIMING,
 				      (u8 *)(&rf_timing));
@@ -2244,7 +2099,6 @@ static void _rtl92e_dm_end_hw_fsync(struct net_device *dev)
 	u8 rf_timing = 0xaa;
 	struct r8192_priv *priv = rtllib_priv(dev);
 
-	RT_TRACE(COMP_HALDM, "%s\n", __func__);
 	rtl92e_writel(dev, rOFDM0_RxDetector2, 0x465c52cd);
 	priv->rtllib->SetHwRegHandler(dev, HW_VAR_RF_TIMING, (u8 *)
 				     (&rf_timing));
@@ -2255,7 +2109,6 @@ static void _rtl92e_dm_end_sw_fsync(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 
-	RT_TRACE(COMP_HALDM, "%s\n", __func__);
 	del_timer_sync(&(priv->fsync_timer));
 
 	if (priv->bswitch_fsync) {
@@ -2276,7 +2129,6 @@ static void _rtl92e_dm_start_sw_fsync(struct net_device *dev)
 	u32			rateIndex;
 	u32			rateBitmap;
 
-	RT_TRACE(COMP_HALDM, "%s\n", __func__);
 	priv->rate_record = 0;
 	priv->ContinueDiffCount = 0;
 	priv->rateCountDiffRecord = 0;
@@ -2315,17 +2167,6 @@ static void _rtl92e_dm_check_fsync(struct net_device *dev)
 	static u8 reg_c38_State = RegC38_Default;
 	static u32 reset_cnt;
 
-	RT_TRACE(COMP_HALDM,
-		 "RSSI %d TimeInterval %d MultipleTimeInterval %d\n",
-		 priv->rtllib->fsync_rssi_threshold,
-		 priv->rtllib->fsync_time_interval,
-		 priv->rtllib->fsync_multiple_timeinterval);
-	RT_TRACE(COMP_HALDM,
-		 "RateBitmap 0x%x FirstDiffRateThreshold %d SecondDiffRateThreshold %d\n",
-		 priv->rtllib->fsync_rate_bitmap,
-		 priv->rtllib->fsync_firstdiff_ratethreshold,
-		 priv->rtllib->fsync_seconddiff_ratethreshold);
-
 	if (priv->rtllib->state == RTLLIB_LINKED &&
 	    priv->rtllib->pHTInfo->IOTPeer == HT_IOT_PEER_BROADCOM) {
 		if (priv->rtllib->bfsync_enable == 0) {
@@ -2461,9 +2302,6 @@ static void _rtl92e_dm_dynamic_tx_power(struct net_device *dev)
 		txlowpower_threshold = TX_POWER_NEAR_FIELD_THRESH_LOW;
 	}
 
-	RT_TRACE(COMP_TXAGC, "priv->undecorated_smoothed_pwdb = %ld\n",
-		 priv->undecorated_smoothed_pwdb);
-
 	if (priv->rtllib->state == RTLLIB_LINKED) {
 		if (priv->undecorated_smoothed_pwdb >= txhipower_threshold) {
 			priv->bDynamicTxHighPower = true;
@@ -2484,9 +2322,6 @@ static void _rtl92e_dm_dynamic_tx_power(struct net_device *dev)
 
 	if ((priv->bDynamicTxHighPower != priv->bLastDTPFlag_High) ||
 	    (priv->bDynamicTxLowPower != priv->bLastDTPFlag_Low)) {
-		RT_TRACE(COMP_TXAGC, "SetTxPowerLevel8190()  channel = %d\n",
-			 priv->rtllib->current_network.channel);
-
 		rtl92e_set_tx_power(dev, priv->rtllib->current_network.channel);
 	}
 	priv->bLastDTPFlag_High = priv->bDynamicTxHighPower;
-- 
2.37.3


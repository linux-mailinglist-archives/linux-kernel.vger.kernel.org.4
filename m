Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9375BB642
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 06:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiIQEZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 00:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiIQEZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 00:25:38 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C7C98A7C
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 21:25:35 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id y3so53558574ejc.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 21:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date;
        bh=tMHw0bxiz6QFlmLnskahqo5U4mVjc6Q9TyqyNWew0Mg=;
        b=dCD9xLVCdbXKPOjhYqGUKg+70zBzSibpHKEkfUhN1TYDxqvBZ2wFcatAM+PI4R2fFh
         xID8fd1uU8lTEscFPor2mjB9PxAnsvTQo0Q7E/VTZXYJl9s58/XfkssdINvL+poE/CW7
         G0ZAu5JHGhmE+y9nYMSFCfF5dQkYjqW05Jub5rNTgf/MsoSWOSI5ojkwdlQIu2jd8mem
         SwrpooQE9mwjcnU8QW3bjQlUhHgTRyXt1RyOCLBs8Ejd9L0Jk6THKt77Sgd+9dbwug8B
         MOorNPnYh7eIcawyJjifY1u1TiVQ/DTc2yfPudocq8klegAaRkYkT/iNsVa+c4fkDBVI
         AjKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=tMHw0bxiz6QFlmLnskahqo5U4mVjc6Q9TyqyNWew0Mg=;
        b=m4WtUyQozgsfAUAoi9m6uTs037XWTFhDE4hF5s4EScv3wQtJe6WFz0A8Q8/Wu92ktx
         vQvOH+7q4sFZA0ErxGic9FNcYXDbPvaCv121RfhygnzOkzy2GY4vceltvBSJR/NzSwuw
         XAyCvVa8r32OlrOt0PUqn/KyzOjtRm7dWckn+Ol7dYM4QSUCbgNd9mMyAm7ZrJgCGoYh
         5o8GburIXRS/jZL7hDXcMpvkuZUs1hoCspoo2MVS+YNrpNsFbIQiYa80qevvfa8UvocY
         6pgIQbqUDTJkn3h/uqBLwoJhyfDdPFwRccISHHq415r14HMASxNXOlbfm1sPw79h3XN8
         PuMQ==
X-Gm-Message-State: ACrzQf3osOoj4WsJ+bPdqRnmXBq//ifwaq7gJ7Q8izCWvU9IDQnxpNYo
        hoXBZfP3/QaqK0uKskYj0Yg=
X-Google-Smtp-Source: AMsMyM76j6vr4WNDtQX8CXQ+NE0dLFuhZwXntKScdlFNtiM29k4sWYt+d3u2trknGG2HM0n6VveiIg==
X-Received: by 2002:a17:906:4787:b0:780:eca1:b5c3 with SMTP id cw7-20020a170906478700b00780eca1b5c3mr355017ejc.92.1663388734106;
        Fri, 16 Sep 2022 21:25:34 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id d12-20020a170906304c00b007807e4f6b30sm2605318ejd.103.2022.09.16.21.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 21:25:33 -0700 (PDT)
Date:   Sat, 17 Sep 2022 06:25:31 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] staging: rtl8192e: Remove ftrace-like logging in
 r8192E_phy.c
Message-ID: <7315b22f54d62c5b56e8b9284426eca4cb641f77.1663387785.git.philipp.g.hortmann@gmail.com>
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
 .../staging/rtl8192e/rtl8192e/r8192E_phy.c    | 132 ------------------
 1 file changed, 132 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index f92551094738..d1c4d44bfc87 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -117,8 +117,6 @@ static u32 _rtl92e_phy_rf_read(struct net_device *dev,
 		} else
 			NewOffset = Offset;
 	} else {
-		RT_TRACE((COMP_PHY|COMP_ERR),
-			 "check RF type here, need to be 8256\n");
 		NewOffset = Offset;
 	}
 	rtl92e_set_bb_reg(dev, pPhyReg->rfHSSIPara2, bLSSIReadAddress,
@@ -173,8 +171,6 @@ static void _rtl92e_phy_rf_write(struct net_device *dev,
 		} else
 			NewOffset = Offset;
 	} else {
-		RT_TRACE((COMP_PHY|COMP_ERR),
-			 "check RF type here, need to be 8256\n");
 		NewOffset = Offset;
 	}
 
@@ -207,7 +203,6 @@ void rtl92e_set_rf_reg(struct net_device *dev, enum rf90_radio_path eRFPath,
 	if (priv->rtllib->eRFPowerState != eRfOn && !priv->being_init_adapter)
 		return;
 
-	RT_TRACE(COMP_PHY, "FW RF CTRL is not ready now\n");
 	if (priv->Rf_Mode == RF_OP_By_FW) {
 		if (BitMask != bMask12Bits) {
 			Original_Value = _rtl92e_phy_rf_fw_read(dev, eRFPath,
@@ -312,19 +307,14 @@ void rtl92e_config_mac(struct net_device *dev)
 	struct r8192_priv *priv = rtllib_priv(dev);
 
 	if (priv->bTXPowerDataReadFromEEPORM) {
-		RT_TRACE(COMP_PHY, "Rtl819XMACPHY_Array_PG\n");
 		dwArrayLen = MACPHY_Array_PGLength;
 		pdwArray = Rtl819XMACPHY_Array_PG;
 
 	} else {
-		RT_TRACE(COMP_PHY, "Read rtl819XMACPHY_Array\n");
 		dwArrayLen = MACPHY_ArrayLength;
 		pdwArray = Rtl819XMACPHY_Array;
 	}
 	for (i = 0; i < dwArrayLen; i += 3) {
-		RT_TRACE(COMP_DBG,
-			 "The Rtl8190MACPHY_Array[0] is %x Rtl8190MACPHY_Array[1] is %x Rtl8190MACPHY_Array[2] is %x\n",
-			 pdwArray[i], pdwArray[i+1], pdwArray[i+2]);
 		if (pdwArray[i] == 0x318)
 			pdwArray[i+2] = 0x00000800;
 		rtl92e_set_bb_reg(dev, pdwArray[i], pdwArray[i+1],
@@ -357,20 +347,12 @@ static void _rtl92e_phy_config_bb(struct net_device *dev, u8 ConfigType)
 			rtl92e_set_bb_reg(dev, Rtl819XPHY_REGArray_Table[i],
 					  bMaskDWord,
 					  Rtl819XPHY_REGArray_Table[i+1]);
-			RT_TRACE(COMP_DBG,
-				 "i: %x, The Rtl819xUsbPHY_REGArray[0] is %x Rtl819xUsbPHY_REGArray[1] is %x\n",
-				 i, Rtl819XPHY_REGArray_Table[i],
-				 Rtl819XPHY_REGArray_Table[i+1]);
 		}
 	} else if (ConfigType == BaseBand_Config_AGC_TAB) {
 		for (i = 0; i < AGCTAB_ArrayLen; i += 2) {
 			rtl92e_set_bb_reg(dev, Rtl819XAGCTAB_Array_Table[i],
 					  bMaskDWord,
 					  Rtl819XAGCTAB_Array_Table[i+1]);
-			RT_TRACE(COMP_DBG,
-				 "i:%x, The rtl819XAGCTAB_Array[0] is %x rtl819XAGCTAB_Array[1] is %x\n",
-				 i, Rtl819XAGCTAB_Array_Table[i],
-				 Rtl819XAGCTAB_Array_Table[i+1]);
 		}
 	}
 }
@@ -478,8 +460,6 @@ bool rtl92e_check_bb_and_rf(struct net_device *dev, enum hw90_block CheckBlock,
 	WriteAddr[HW90_BLOCK_PHY0] = 0x900;
 	WriteAddr[HW90_BLOCK_PHY1] = 0x800;
 	WriteAddr[HW90_BLOCK_RF] = 0x3;
-	RT_TRACE(COMP_PHY, "=======>%s(), CheckBlock:%d\n", __func__,
-		 CheckBlock);
 
 	if (CheckBlock == HW90_BLOCK_MAC) {
 		netdev_warn(dev, "%s(): No checks available for MAC block.\n",
@@ -543,9 +523,6 @@ static bool _rtl92e_bb_config_para_file(struct net_device *dev)
 						   (enum hw90_block)eCheckItem,
 						   (enum rf90_radio_path)0);
 		if (!rtStatus) {
-			RT_TRACE((COMP_ERR | COMP_PHY),
-				 "rtl92e_config_rf():Check PHY%d Fail!!\n",
-				 eCheckItem-1);
 			return rtStatus;
 		}
 	}
@@ -602,15 +579,9 @@ void rtl92e_get_tx_power(struct net_device *dev)
 	priv->DefaultInitialGain[1] = rtl92e_readb(dev, rOFDM0_XBAGCCore1);
 	priv->DefaultInitialGain[2] = rtl92e_readb(dev, rOFDM0_XCAGCCore1);
 	priv->DefaultInitialGain[3] = rtl92e_readb(dev, rOFDM0_XDAGCCore1);
-	RT_TRACE(COMP_INIT,
-		 "Default initial gain (c50=0x%x, c58=0x%x, c60=0x%x, c68=0x%x)\n",
-		 priv->DefaultInitialGain[0], priv->DefaultInitialGain[1],
-		 priv->DefaultInitialGain[2], priv->DefaultInitialGain[3]);
 
 	priv->framesync = rtl92e_readb(dev, rOFDM0_RxDetector3);
 	priv->framesyncC34 = rtl92e_readl(dev, rOFDM0_RxDetector2);
-	RT_TRACE(COMP_INIT, "Default framesync (0x%x) = 0x%x\n",
-		rOFDM0_RxDetector3, priv->framesync);
 	priv->SifsTime = rtl92e_readw(dev, SIFS);
 }
 
@@ -813,9 +784,6 @@ static u8 _rtl92e_phy_switch_channel_step(struct net_device *dev, u8 channel,
 	struct sw_chnl_cmd *CurrentCmd = NULL;
 	u8		eRFPath;
 
-	RT_TRACE(COMP_TRACE, "====>%s()====stage:%d, step:%d, channel:%d\n",
-		  __func__, *stage, *step, channel);
-
 	if (!rtllib_legal_channel(priv->rtllib, channel)) {
 		netdev_err(dev, "Invalid channel requested: %d\n", channel);
 		return true;
@@ -976,21 +944,13 @@ static void _rtl92e_phy_switch_channel_work_item(struct net_device *dev)
 
 	struct r8192_priv *priv = rtllib_priv(dev);
 
-	RT_TRACE(COMP_TRACE, "==> SwChnlCallback819xUsbWorkItem()\n");
-
-	RT_TRACE(COMP_TRACE, "=====>--%s(), set chan:%d, priv:%p\n", __func__,
-		 priv->chan, priv);
-
 	_rtl92e_phy_switch_channel(dev, priv->chan);
-
-	RT_TRACE(COMP_TRACE, "<== SwChnlCallback819xUsbWorkItem()\n");
 }
 
 u8 rtl92e_set_channel(struct net_device *dev, u8 channel)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 
-	RT_TRACE(COMP_PHY, "=====>%s()\n", __func__);
 	if (!priv->up) {
 		netdev_err(dev, "%s(): Driver is not initialized\n", __func__);
 		return false;
@@ -1060,10 +1020,6 @@ static void _rtl92e_cck_tx_power_track_bw_switch_tssi(struct net_device *dev)
 		if (priv->CCKPresentAttentuation < 0)
 			priv->CCKPresentAttentuation = 0;
 
-		RT_TRACE(COMP_POWER_TRACKING,
-			 "20M, priv->CCKPresentAttentuation = %d\n",
-			 priv->CCKPresentAttentuation);
-
 		if (priv->rtllib->current_network.channel == 14 &&
 		    !priv->bcck_in_ch14) {
 			priv->bcck_in_ch14 = true;
@@ -1082,9 +1038,6 @@ static void _rtl92e_cck_tx_power_track_bw_switch_tssi(struct net_device *dev)
 			priv->CCKPresentAttentuation_40Mdefault +
 			priv->CCKPresentAttentuation_difference;
 
-		RT_TRACE(COMP_POWER_TRACKING,
-			 "40M, priv->CCKPresentAttentuation = %d\n",
-			 priv->CCKPresentAttentuation);
 		if (priv->CCKPresentAttentuation >
 		    (CCKTxBBGainTableLength - 1))
 			priv->CCKPresentAttentuation =
@@ -1123,16 +1076,10 @@ static void _rtl92e_cck_tx_power_track_bw_switch_thermal(struct net_device *dev)
 		if (priv->Record_CCK_20Mindex == 0)
 			priv->Record_CCK_20Mindex = 6;
 		priv->CCK_index = priv->Record_CCK_20Mindex;
-		RT_TRACE(COMP_POWER_TRACKING,
-			 "20MHz, %s,CCK_index = %d\n", __func__,
-			 priv->CCK_index);
 	break;
 
 	case HT_CHANNEL_WIDTH_20_40:
 		priv->CCK_index = priv->Record_CCK_40Mindex;
-		RT_TRACE(COMP_POWER_TRACKING,
-			 "40MHz, %s, CCK_index = %d\n", __func__,
-			 priv->CCK_index);
 	break;
 	}
 	rtl92e_dm_cck_txpower_adjust(dev, priv->bcck_in_ch14);
@@ -1154,12 +1101,6 @@ static void _rtl92e_set_bw_mode_work_item(struct net_device *dev)
 	struct r8192_priv *priv = rtllib_priv(dev);
 	u8 regBwOpMode;
 
-	RT_TRACE(COMP_SWBW,
-		 "==>%s Switch to %s bandwidth\n", __func__,
-		 priv->CurrentChannelBW == HT_CHANNEL_WIDTH_20 ?
-			 "20MHz" : "40MHz");
-
-
 	if (priv->rf_chip == RF_PSEUDO_11N) {
 		priv->SetBWModeInProgress = false;
 		return;
@@ -1251,8 +1192,6 @@ static void _rtl92e_set_bw_mode_work_item(struct net_device *dev)
 
 	atomic_dec(&(priv->rtllib->atm_swbw));
 	priv->SetBWModeInProgress = false;
-
-	RT_TRACE(COMP_SWBW, "<==SetBWMode819xUsb()");
 }
 
 void rtl92e_set_bw_mode(struct net_device *dev, enum ht_channel_width Bandwidth,
@@ -1291,8 +1230,6 @@ void rtl92e_init_gain(struct net_device *dev, u8 Operation)
 	if (priv->up) {
 		switch (Operation) {
 		case IG_Backup:
-			RT_TRACE(COMP_SCAN,
-				 "IG_Backup, backup the initial gain.\n");
 			initial_gain = SCAN_RX_INITIAL_GAIN;
 			BitMask = bMaskByte0;
 			if (dm_digtable.dig_algorithm ==
@@ -1314,35 +1251,13 @@ void rtl92e_init_gain(struct net_device *dev, u8 Operation)
 			priv->initgain_backup.cca = (u8)rtl92e_get_bb_reg(dev,
 						    rCCK0_CCA, BitMask);
 
-			RT_TRACE(COMP_SCAN,
-				 "Scan InitialGainBackup 0xc50 is %x\n",
-				 priv->initgain_backup.xaagccore1);
-			RT_TRACE(COMP_SCAN,
-				 "Scan InitialGainBackup 0xc58 is %x\n",
-				 priv->initgain_backup.xbagccore1);
-			RT_TRACE(COMP_SCAN,
-				 "Scan InitialGainBackup 0xc60 is %x\n",
-				 priv->initgain_backup.xcagccore1);
-			RT_TRACE(COMP_SCAN,
-				 "Scan InitialGainBackup 0xc68 is %x\n",
-				 priv->initgain_backup.xdagccore1);
-			RT_TRACE(COMP_SCAN,
-				 "Scan InitialGainBackup 0xa0a is %x\n",
-				 priv->initgain_backup.cca);
-
-			RT_TRACE(COMP_SCAN, "Write scan initial gain = 0x%x\n",
-				 initial_gain);
 			rtl92e_writeb(dev, rOFDM0_XAAGCCore1, initial_gain);
 			rtl92e_writeb(dev, rOFDM0_XBAGCCore1, initial_gain);
 			rtl92e_writeb(dev, rOFDM0_XCAGCCore1, initial_gain);
 			rtl92e_writeb(dev, rOFDM0_XDAGCCore1, initial_gain);
-			RT_TRACE(COMP_SCAN, "Write scan 0xa0a = 0x%x\n",
-				 POWER_DETECTION_TH);
 			rtl92e_writeb(dev, 0xa0a, POWER_DETECTION_TH);
 			break;
 		case IG_Restore:
-			RT_TRACE(COMP_SCAN,
-				 "IG_Restore, restore the initial gain.\n");
 			BitMask = 0x7f;
 			if (dm_digtable.dig_algorithm ==
 			    DIG_ALGO_BY_FALSE_ALARM)
@@ -1360,22 +1275,6 @@ void rtl92e_init_gain(struct net_device *dev, u8 Operation)
 			rtl92e_set_bb_reg(dev, rCCK0_CCA, BitMask,
 					 (u32)priv->initgain_backup.cca);
 
-			RT_TRACE(COMP_SCAN,
-				 "Scan BBInitialGainRestore 0xc50 is %x\n",
-				 priv->initgain_backup.xaagccore1);
-			RT_TRACE(COMP_SCAN,
-				 "Scan BBInitialGainRestore 0xc58 is %x\n",
-				 priv->initgain_backup.xbagccore1);
-			RT_TRACE(COMP_SCAN,
-				 "Scan BBInitialGainRestore 0xc60 is %x\n",
-				 priv->initgain_backup.xcagccore1);
-			RT_TRACE(COMP_SCAN,
-				 "Scan BBInitialGainRestore 0xc68 is %x\n",
-				 priv->initgain_backup.xdagccore1);
-			RT_TRACE(COMP_SCAN,
-				 "Scan BBInitialGainRestore 0xa0a is %x\n",
-				 priv->initgain_backup.cca);
-
 			rtl92e_set_tx_power(dev,
 					 priv->rtllib->current_network.channel);
 
@@ -1383,9 +1282,6 @@ void rtl92e_init_gain(struct net_device *dev, u8 Operation)
 			    DIG_ALGO_BY_FALSE_ALARM)
 				rtl92e_set_bb_reg(dev, UFWP, bMaskByte1, 0x1);
 			break;
-		default:
-			RT_TRACE(COMP_SCAN, "Unknown IG Operation.\n");
-			break;
 		}
 	}
 }
@@ -1416,14 +1312,12 @@ static bool _rtl92e_set_rf_power_state(struct net_device *dev,
 
 	if (priv->SetRFPowerStateInProgress)
 		return false;
-	RT_TRACE(COMP_PS, "===========> %s!\n", __func__);
 	priv->SetRFPowerStateInProgress = true;
 
 	switch (priv->rf_chip) {
 	case RF_8256:
 		switch (eRFPowerState) {
 		case eRfOn:
-			RT_TRACE(COMP_PS, "%s eRfOn!\n", __func__);
 			if ((priv->rtllib->eRFPowerState == eRfOff) &&
 			     RT_IN_PS_LEVEL(pPSC, RT_RF_OFF_LEVL_HALT_NIC)) {
 				bool rtstatus;
@@ -1481,16 +1375,11 @@ static bool _rtl92e_set_rf_power_state(struct net_device *dev,
 					QueueID++;
 					continue;
 				} else {
-					RT_TRACE((COMP_POWER|COMP_RF),
-						 "eRf Off/Sleep: %d times TcbBusyQueue[%d] !=0 before doze!\n",
-						 (i+1), QueueID);
 					udelay(10);
 					i++;
 				}
 
 				if (i >= MAX_DOZE_WAITING_TIMES_9x) {
-					RT_TRACE(COMP_POWER, "\n\n\n TimeOut!! %s: eRfOff: %d times TcbBusyQueue[%d] != 0 !!!\n",
-						 __func__, MAX_DOZE_WAITING_TIMES_9x, QueueID);
 					break;
 				}
 			}
@@ -1498,8 +1387,6 @@ static bool _rtl92e_set_rf_power_state(struct net_device *dev,
 			break;
 
 		case eRfOff:
-			RT_TRACE(COMP_PS, "%s eRfOff/Sleep !\n", __func__);
-
 			for (QueueID = 0, i = 0; QueueID < MAX_TX_QUEUE; ) {
 				ring = &priv->tx_ring[QueueID];
 
@@ -1507,18 +1394,11 @@ static bool _rtl92e_set_rf_power_state(struct net_device *dev,
 					QueueID++;
 					continue;
 				} else {
-					RT_TRACE(COMP_POWER,
-						 "eRf Off/Sleep: %d times TcbBusyQueue[%d] !=0 before doze!\n",
-						 (i+1), QueueID);
 					udelay(10);
 					i++;
 				}
 
 				if (i >= MAX_DOZE_WAITING_TIMES_9x) {
-					RT_TRACE(COMP_POWER,
-						 "\n\n\n SetZebra: RFPowerState8185B(): eRfOff: %d times TcbBusyQueue[%d] != 0 !!!\n",
-						 MAX_DOZE_WAITING_TIMES_9x,
-						 QueueID);
 					break;
 				}
 			}
@@ -1563,7 +1443,6 @@ static bool _rtl92e_set_rf_power_state(struct net_device *dev,
 	}
 
 	priv->SetRFPowerStateInProgress = false;
-	RT_TRACE(COMP_PS, "<=========== %s bResult = %d!\n", __func__, bResult);
 	return bResult;
 }
 
@@ -1574,19 +1453,12 @@ bool rtl92e_set_rf_power_state(struct net_device *dev,
 
 	bool bResult = false;
 
-	RT_TRACE(COMP_PS,
-		 "---------> %s: eRFPowerState(%d)\n", __func__, eRFPowerState);
 	if (eRFPowerState == priv->rtllib->eRFPowerState &&
 	    priv->bHwRfOffAction == 0) {
-		RT_TRACE(COMP_PS, "<--------- %s: discard the request for eRFPowerState(%d) is the same.\n",
-			 __func__, eRFPowerState);
 		return bResult;
 	}
 
 	bResult = _rtl92e_set_rf_power_state(dev, eRFPowerState);
-
-	RT_TRACE(COMP_PS, "<--------- %s: bResult(%d)\n", __func__, bResult);
-
 	return bResult;
 }
 
@@ -1603,10 +1475,6 @@ void rtl92e_scan_op_backup(struct net_device *dev, u8 Operation)
 		case SCAN_OPT_RESTORE:
 			priv->rtllib->InitialGainHandler(dev, IG_Restore);
 			break;
-
-		default:
-			RT_TRACE(COMP_SCAN, "Unknown Scan Backup Operation.\n");
-			break;
 		}
 	}
 }
-- 
2.37.3


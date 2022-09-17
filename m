Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4074A5BB641
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 06:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiIQEZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 00:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiIQEZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 00:25:30 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12ACD7FF92
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 21:25:28 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a26so24778201ejc.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 21:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date;
        bh=Dzu/JwSGOZqPvNidvpwXW1mcinQ+25pDmoY3rOtbTQQ=;
        b=T2ouHS9gsO64LtVG6VoaIXBgUWLaFN88qP3rbq8NiICS7UgKvgCQPWOmrAEIhn2Yri
         SXf+NBSsCnuyZ/f6Ieu0UPW4aPLF8xuahcjAjkznp88CID5abkiZwOn35I8fwfVswL+Z
         sJLO+3ArTW2ZidG48BV6Mf2DAzKKm/MHTh9PLAprQXrzAEWGPLmGKNixHbJNHEoF+s3n
         7554eFe5l1HAJYkgbct/x2pKO8+Ukqc4S3L8HKVp/ZZRjZUdxLclxQd24WRjJcpnDrDp
         z5s3eknA8gv7Og41UO+1OmWi7/bo+wKVa3oIg1LofKkEb6YERK9vHtYYf8cANhlcrgkw
         fD0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Dzu/JwSGOZqPvNidvpwXW1mcinQ+25pDmoY3rOtbTQQ=;
        b=adK+5G+G0Bi4Kw5CF+kqk2HN2cvNNHY4YN6TgnYNg+kCqlTf71yOsWTP2WYNMrrs/5
         w/pDXtWbNXqeVy8DkZDi7gwi33GwjIUxD0bEeIENqFNUfPy7K+wLC3OcwZq4oVrF8qTh
         umQK25mVx8RZMKe2IL4lo1czCAUGLd36eBdAazOKx65nVLKDJkhT+4cCToZugAgq9pSk
         qKCIebNzO1cynGqxtXht5aZzwj6SVijR50Y30yqXgZtSZCffSicim6k8Kg9k5q7qtwc8
         FNIGNPFcOOpcsUQNLPZEH/aNsMsBtKCdA7VOFWpVHIuSyIIOiVDLu+2OceL5v6qhlEtD
         p6jw==
X-Gm-Message-State: ACrzQf0EDp3JYvGpnZa8uuxR3i4nT8M74hLElkSSeLnmrMlrFoz/xqIt
        lNL+MuAwxD0oJ6+gAMztHYedRU570Gc=
X-Google-Smtp-Source: AMsMyM61s94Da5wHrrq61H6S/L5IjQ6TnHxWK8IbkyATf0VdSn5Pqd8qhCGm8h8LAQun+3CF7ArsGA==
X-Received: by 2002:a17:906:5a4d:b0:76f:bb35:48f4 with SMTP id my13-20020a1709065a4d00b0076fbb3548f4mr5329223ejc.686.1663388726214;
        Fri, 16 Sep 2022 21:25:26 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id s19-20020a1709062ed300b0073c10031dc9sm11301533eji.80.2022.09.16.21.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 21:25:25 -0700 (PDT)
Date:   Sat, 17 Sep 2022 06:25:23 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] staging: rtl8192e: Remove ftrace-like logging in
 r8192E_dev.c
Message-ID: <425e1b015c34ddb6df425bc516df64c40a70a58a.1663387785.git.philipp.g.hortmann@gmail.com>
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
 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    | 161 +-----------------
 1 file changed, 1 insertion(+), 160 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 4b9249195b5a..5832ccdb4e50 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -186,8 +186,6 @@ void rtl92e_set_reg(struct net_device *dev, u8 variable, u8 *val)
 				 AC_PARAM_ECW_MIN_OFFSET) |
 				(((u32)u1bAIFS) << AC_PARAM_AIFS_OFFSET);
 
-		RT_TRACE(COMP_DBG, "%s():HW_VAR_AC_PARAM eACI:%x:%x\n",
-			 __func__, eACI, u4bAcParam);
 		switch (eACI) {
 		case AC1_BK:
 			rtl92e_writel(dev, EDCAPARA_BK, u4bAcParam);
@@ -226,8 +224,6 @@ void rtl92e_set_reg(struct net_device *dev, u8 variable, u8 *val)
 		u8 acm = pAciAifsn->f.acm;
 		u8 AcmCtrl = rtl92e_readb(dev, AcmHwCtrl);
 
-		RT_TRACE(COMP_DBG, "===========>%s():HW_VAR_ACM_CTRL:%x\n",
-			 __func__, eACI);
 		AcmCtrl = AcmCtrl | ((priv->AcmMethod == 2) ? 0x0 : 0x1);
 
 		if (acm) {
@@ -243,12 +239,6 @@ void rtl92e_set_reg(struct net_device *dev, u8 variable, u8 *val)
 			case AC3_VO:
 				AcmCtrl |= AcmHw_VoqEn;
 				break;
-
-			default:
-				RT_TRACE(COMP_QOS,
-					 "SetHwReg8185(): [HW_VAR_ACM_CTRL] acm set failed: eACI is %d\n",
-					 eACI);
-				break;
 			}
 		} else {
 			switch (eACI) {
@@ -268,10 +258,6 @@ void rtl92e_set_reg(struct net_device *dev, u8 variable, u8 *val)
 				break;
 			}
 		}
-
-		RT_TRACE(COMP_QOS,
-			 "SetHwReg8190pci(): [HW_VAR_ACM_CTRL] Write 0x%X\n",
-			 AcmCtrl);
 		rtl92e_writeb(dev, AcmHwCtrl, AcmCtrl);
 		break;
 	}
@@ -304,8 +290,6 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 	u16 i, usValue, IC_Version;
 	u16 EEPROMId;
 
-	RT_TRACE(COMP_INIT, "====> %s\n", __func__);
-
 	EEPROMId = rtl92e_eeprom_read(dev, 0);
 	if (EEPROMId != RTL8190_EEPROM_ID) {
 		netdev_err(dev, "%s(): Invalid EEPROM ID: %x\n", __func__,
@@ -329,8 +313,6 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 
 		ICVer8192 = IC_Version & 0xf;
 		ICVer8256 = (IC_Version & 0xf0)>>4;
-		RT_TRACE(COMP_INIT, "\nICVer8192 = 0x%x\n", ICVer8192);
-		RT_TRACE(COMP_INIT, "\nICVer8256 = 0x%x\n", ICVer8256);
 		if (ICVer8192 == 0x2) {
 			if (ICVer8256 == 0x5)
 				priv->card_8192_version = VERSION_8190_BE;
@@ -343,22 +325,14 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 			priv->card_8192_version = VERSION_8190_BD;
 			break;
 		}
-		RT_TRACE(COMP_INIT, "\nIC Version = 0x%x\n",
-			  priv->card_8192_version);
 	} else {
 		priv->card_8192_version = VERSION_8190_BD;
 		priv->eeprom_vid = 0;
 		priv->eeprom_did = 0;
 		priv->eeprom_CustomerID = 0;
 		priv->eeprom_ChannelPlan = 0;
-		RT_TRACE(COMP_INIT, "\nIC Version = 0x%x\n", 0xff);
 	}
 
-	RT_TRACE(COMP_INIT, "EEPROM VID = 0x%4x\n", priv->eeprom_vid);
-	RT_TRACE(COMP_INIT, "EEPROM DID = 0x%4x\n", priv->eeprom_did);
-	RT_TRACE(COMP_INIT, "EEPROM Customer ID: 0x%2x\n",
-		 priv->eeprom_CustomerID);
-
 	if (!priv->AutoloadFailFlag) {
 		u8 addr[ETH_ALEN];
 
@@ -372,9 +346,6 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 		eth_hw_addr_set(dev, bMac_Tmp_Addr);
 	}
 
-	RT_TRACE(COMP_INIT, "Permanent Address = %pM\n",
-		 dev->dev_addr);
-
 	if (priv->card_8192_version > VERSION_8190_BD)
 		priv->bTXPowerDataReadFromEEPORM = true;
 	else
@@ -395,8 +366,6 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 		} else {
 			priv->EEPROMLegacyHTTxPowerDiff = 0x04;
 		}
-		RT_TRACE(COMP_INIT, "EEPROMLegacyHTTxPowerDiff = %d\n",
-			priv->EEPROMLegacyHTTxPowerDiff);
 
 		if (!priv->AutoloadFailFlag)
 			priv->EEPROMThermalMeter = ((rtl92e_eeprom_read(dev,
@@ -404,8 +373,6 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 						   0xff00) >> 8;
 		else
 			priv->EEPROMThermalMeter = EEPROM_Default_ThermalMeter;
-		RT_TRACE(COMP_INIT, "ThermalMeter = %d\n",
-			 priv->EEPROMThermalMeter);
 		priv->TSSI_13dBm = priv->EEPROMThermalMeter * 100;
 
 		if (priv->epromtype == EEPROM_93C46) {
@@ -421,10 +388,6 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 				priv->EEPROMCrystalCap =
 					 EEPROM_Default_TxPwDiff_CrystalCap;
 			}
-			RT_TRACE(COMP_INIT, "EEPROMAntPwDiff = %d\n",
-				 priv->EEPROMAntPwDiff);
-			RT_TRACE(COMP_INIT, "EEPROMCrystalCap = %d\n",
-				 priv->EEPROMCrystalCap);
 
 			for (i = 0; i < 14; i += 2) {
 				if (!priv->AutoloadFailFlag)
@@ -434,12 +397,6 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 					usValue = EEPROM_Default_TxPower;
 				*((u16 *)(&priv->EEPROMTxPowerLevelCCK[i])) =
 								 usValue;
-				RT_TRACE(COMP_INIT,
-					 "CCK Tx Power Level, Index %d = 0x%02x\n",
-					 i, priv->EEPROMTxPowerLevelCCK[i]);
-				RT_TRACE(COMP_INIT,
-					 "CCK Tx Power Level, Index %d = 0x%02x\n",
-					 i+1, priv->EEPROMTxPowerLevelCCK[i+1]);
 			}
 			for (i = 0; i < 14; i += 2) {
 				if (!priv->AutoloadFailFlag)
@@ -449,13 +406,6 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 					usValue = EEPROM_Default_TxPower;
 				*((u16 *)(&priv->EEPROMTxPowerLevelOFDM24G[i]))
 							 = usValue;
-				RT_TRACE(COMP_INIT,
-					 "OFDM 2.4G Tx Power Level, Index %d = 0x%02x\n",
-					 i, priv->EEPROMTxPowerLevelOFDM24G[i]);
-				RT_TRACE(COMP_INIT,
-					 "OFDM 2.4G Tx Power Level, Index %d = 0x%02x\n",
-					 i + 1,
-					 priv->EEPROMTxPowerLevelOFDM24G[i+1]);
 			}
 		}
 		if (priv->epromtype == EEPROM_93C46) {
@@ -508,22 +458,6 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 				priv->TxPowerLevelOFDM24G_C[i] =
 					 priv->EEPROMRfCOfdmChnlTxPwLevel[2];
 			}
-			for (i = 0; i < 14; i++)
-				RT_TRACE(COMP_INIT,
-					 "priv->TxPowerLevelCCK_A[%d] = 0x%x\n",
-					 i, priv->TxPowerLevelCCK_A[i]);
-			for (i = 0; i < 14; i++)
-				RT_TRACE(COMP_INIT,
-					 "priv->TxPowerLevelOFDM24G_A[%d] = 0x%x\n",
-					 i, priv->TxPowerLevelOFDM24G_A[i]);
-			for (i = 0; i < 14; i++)
-				RT_TRACE(COMP_INIT,
-					 "priv->TxPowerLevelCCK_C[%d] = 0x%x\n",
-					 i, priv->TxPowerLevelCCK_C[i]);
-			for (i = 0; i < 14; i++)
-				RT_TRACE(COMP_INIT,
-					 "priv->TxPowerLevelOFDM24G_C[%d] = 0x%x\n",
-					 i, priv->TxPowerLevelOFDM24G_C[i]);
 			priv->LegacyHTTxPowerDiff =
 				 priv->EEPROMLegacyHTTxPowerDiff;
 			priv->AntennaTxPwDiff[0] = 0;
@@ -536,13 +470,6 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 		}
 	}
 
-	if (priv->rf_type == RF_1T2R) {
-		/* no matter what checkpatch says, the braces are needed */
-		RT_TRACE(COMP_INIT, "\n1T2R config\n");
-	} else if (priv->rf_type == RF_2T4R) {
-		RT_TRACE(COMP_INIT, "\n2T4R config\n");
-	}
-
 	rtl92e_init_adaptive_rate(dev);
 
 	priv->rf_chip = RF_8256;
@@ -574,8 +501,6 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 			priv->ChannelPlan = priv->eeprom_ChannelPlan&0x7f;
 		else
 			priv->ChannelPlan = 0x0;
-		RT_TRACE(COMP_INIT, "Toshiba ChannelPlan = 0x%x\n",
-			priv->ChannelPlan);
 		break;
 	case EEPROM_CID_Nettronix:
 		priv->ScanDelay = 100;
@@ -602,10 +527,6 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 		priv->rtllib->bSupportRemoteWakeUp = true;
 	else
 		priv->rtllib->bSupportRemoteWakeUp = false;
-
-	RT_TRACE(COMP_INIT, "RegChannelPlan(%d)\n", priv->RegChannelPlan);
-	RT_TRACE(COMP_INIT, "ChannelPlan = %d\n", priv->ChannelPlan);
-	RT_TRACE(COMP_TRACE, "<==== ReadAdapterInfo\n");
 }
 
 void rtl92e_get_eeprom_size(struct net_device *dev)
@@ -613,14 +534,9 @@ void rtl92e_get_eeprom_size(struct net_device *dev)
 	u16 curCR;
 	struct r8192_priv *priv = rtllib_priv(dev);
 
-	RT_TRACE(COMP_INIT, "===========>%s()\n", __func__);
 	curCR = rtl92e_readw(dev, EPROM_CMD);
-	RT_TRACE(COMP_INIT, "read from Reg Cmd9346CR(%x):%x\n", EPROM_CMD,
-		 curCR);
 	priv->epromtype = (curCR & EPROM_CMD_9356SEL) ? EEPROM_93C56 :
 			  EEPROM_93C46;
-	RT_TRACE(COMP_INIT, "<===========%s(), epromtype:%d\n", __func__,
-		 priv->epromtype);
 	_rtl92e_read_eeprom_info(dev);
 }
 
@@ -697,7 +613,6 @@ bool rtl92e_start_adapter(struct net_device *dev)
 	int i = 0;
 	u32 retry_times = 0;
 
-	RT_TRACE(COMP_INIT, "====>%s()\n", __func__);
 	priv->being_init_adapter = true;
 
 start:
@@ -732,13 +647,11 @@ bool rtl92e_start_adapter(struct net_device *dev)
 			rtl92e_writeb(dev, SWREGULATOR, 0xb8);
 		}
 	}
-	RT_TRACE(COMP_INIT, "BB Config Start!\n");
 	rtStatus = rtl92e_config_bb(dev);
 	if (!rtStatus) {
 		netdev_warn(dev, "%s(): Failed to configure BB\n", __func__);
 		return rtStatus;
 	}
-	RT_TRACE(COMP_INIT, "BB Config Finished!\n");
 
 	priv->LoopbackMode = RTL819X_NO_LOOPBACK;
 	if (priv->ResetProgress == RESET_TYPE_NORESET) {
@@ -818,19 +731,7 @@ bool rtl92e_start_adapter(struct net_device *dev)
 
 	tmpvalue = rtl92e_readb(dev, IC_VERRSION);
 	priv->IC_Cut = tmpvalue;
-	RT_TRACE(COMP_INIT, "priv->IC_Cut= 0x%x\n", priv->IC_Cut);
-	if (priv->IC_Cut >= IC_VersionCut_D) {
-		if (priv->IC_Cut == IC_VersionCut_D) {
-			/* no matter what checkpatch says, braces are needed */
-			RT_TRACE(COMP_INIT, "D-cut\n");
-		} else if (priv->IC_Cut == IC_VersionCut_E) {
-			RT_TRACE(COMP_INIT, "E-cut\n");
-		}
-	} else {
-		RT_TRACE(COMP_INIT, "Before C-cut\n");
-	}
 
-	RT_TRACE(COMP_INIT, "Load Firmware!\n");
 	bfirmwareok = rtl92e_init_fw(dev);
 	if (!bfirmwareok) {
 		if (retry_times < 10) {
@@ -841,15 +742,13 @@ bool rtl92e_start_adapter(struct net_device *dev)
 			goto end;
 		}
 	}
-	RT_TRACE(COMP_INIT, "Load Firmware finished!\n");
+
 	if (priv->ResetProgress == RESET_TYPE_NORESET) {
-		RT_TRACE(COMP_INIT, "RF Config Started!\n");
 		rtStatus = rtl92e_config_phy(dev);
 		if (!rtStatus) {
 			netdev_info(dev, "RF Config failed\n");
 			return rtStatus;
 		}
-		RT_TRACE(COMP_INIT, "RF Config Finished!\n");
 	}
 
 	rtl92e_set_bb_reg(dev, rFPGA0_RFMOD, bCCKEn, 0x1);
@@ -858,23 +757,12 @@ bool rtl92e_start_adapter(struct net_device *dev)
 	rtl92e_writeb(dev, 0x87, 0x0);
 
 	if (priv->RegRfOff) {
-		RT_TRACE((COMP_INIT | COMP_RF | COMP_POWER),
-			  "%s(): Turn off RF for RegRfOff ----------\n",
-			  __func__);
 		rtl92e_set_rf_state(dev, eRfOff, RF_CHANGE_BY_SW);
 	} else if (priv->rtllib->RfOffReason > RF_CHANGE_BY_PS) {
-		RT_TRACE((COMP_INIT|COMP_RF|COMP_POWER),
-			 "%s(): Turn off RF for RfOffReason(%d) ----------\n",
-			 __func__, priv->rtllib->RfOffReason);
 		rtl92e_set_rf_state(dev, eRfOff, priv->rtllib->RfOffReason);
 	} else if (priv->rtllib->RfOffReason >= RF_CHANGE_BY_IPS) {
-		RT_TRACE((COMP_INIT|COMP_RF|COMP_POWER),
-			 "%s(): Turn off RF for RfOffReason(%d) ----------\n",
-			 __func__, priv->rtllib->RfOffReason);
 		rtl92e_set_rf_state(dev, eRfOff, priv->rtllib->RfOffReason);
 	} else {
-		RT_TRACE((COMP_INIT|COMP_RF|COMP_POWER), "%s(): RF-ON\n",
-			  __func__);
 		priv->rtllib->eRFPowerState = eRfOn;
 		priv->rtllib->RfOffReason = 0;
 	}
@@ -915,18 +803,6 @@ bool rtl92e_start_adapter(struct net_device *dev)
 			priv->CCKPresentAttentuation_difference = 0;
 			priv->CCKPresentAttentuation =
 				  priv->CCKPresentAttentuation_20Mdefault;
-			RT_TRACE(COMP_POWER_TRACKING,
-				 "priv->rfa_txpowertrackingindex_initial = %d\n",
-				 priv->rfa_txpowertrackingindex);
-			RT_TRACE(COMP_POWER_TRACKING,
-				 "priv->rfa_txpowertrackingindex_real__initial = %d\n",
-				 priv->rfa_txpowertrackingindex_real);
-			RT_TRACE(COMP_POWER_TRACKING,
-				 "priv->CCKPresentAttentuation_difference_initial = %d\n",
-				  priv->CCKPresentAttentuation_difference);
-			RT_TRACE(COMP_POWER_TRACKING,
-				 "priv->CCKPresentAttentuation_initial = %d\n",
-				 priv->CCKPresentAttentuation);
 			priv->btxpower_tracking = false;
 		}
 	}
@@ -1237,7 +1113,6 @@ void  rtl92e_fill_tx_desc(struct net_device *dev, struct tx_desc *pdesc,
 		static u8 tmp;
 
 		if (!tmp) {
-			RT_TRACE(COMP_DBG, "==>================hw sec\n");
 			tmp = 1;
 		}
 		switch (priv->rtllib->pairwise_key_type) {
@@ -1350,12 +1225,6 @@ static u8 _rtl92e_rate_hw_to_mgn(bool bIsHT, u8 rate)
 		case DESC90_RATE54M:
 			ret_rate = MGN_54M;
 			break;
-
-		default:
-			RT_TRACE(COMP_RECV,
-				 "%s: Non supportedRate [%x], bIsHT = %d!!!\n",
-				 __func__, rate, bIsHT);
-			break;
 		}
 
 	} else {
@@ -1411,12 +1280,6 @@ static u8 _rtl92e_rate_hw_to_mgn(bool bIsHT, u8 rate)
 		case DESC90_RATEMCS32:
 			ret_rate = 0x80 | 0x20;
 			break;
-
-		default:
-			RT_TRACE(COMP_RECV,
-				 "%s: Non supported Rate [%x], bIsHT = %d!!!\n",
-				 __func__, rate, bIsHT);
-			break;
 		}
 	}
 
@@ -1721,9 +1584,6 @@ static void _rtl92e_process_phyinfo(struct r8192_priv *priv, u8 *buffer,
 		for (rfpath = RF90_PATH_A; rfpath < RF90_PATH_C; rfpath++) {
 			if (!rtl92e_is_legal_rf_path(priv->rtllib->dev, rfpath))
 				continue;
-			RT_TRACE(COMP_DBG,
-				 "Jacken -> pPreviousstats->RxMIMOSignalStrength[rfpath]  = %d\n",
-				 prev_st->RxMIMOSignalStrength[rfpath]);
 			if (priv->stats.rx_rssi_percentage[rfpath] == 0) {
 				priv->stats.rx_rssi_percentage[rfpath] =
 					 prev_st->RxMIMOSignalStrength[rfpath];
@@ -1745,9 +1605,6 @@ static void _rtl92e_process_phyinfo(struct r8192_priv *priv, u8 *buffer,
 				   (prev_st->RxMIMOSignalStrength[rfpath])) /
 				   (RX_SMOOTH);
 			}
-			RT_TRACE(COMP_DBG,
-				 "Jacken -> priv->RxStats.RxRSSIPercentage[rfPath]  = %d\n",
-				 priv->stats.rx_rssi_percentage[rfpath]);
 		}
 	}
 
@@ -1772,11 +1629,6 @@ static void _rtl92e_process_phyinfo(struct r8192_priv *priv, u8 *buffer,
 		if (prev_st->RxPWDBAll >= 3)
 			prev_st->RxPWDBAll -= 3;
 	}
-
-	RT_TRACE(COMP_RXDESC, "Smooth %s PWDB = %d\n",
-				prev_st->bIsCCK ? "CCK" : "OFDM",
-				prev_st->RxPWDBAll);
-
 	if (prev_st->bPacketToSelf || prev_st->bPacketBeacon ||
 	    prev_st->bToSelfBA) {
 		if (priv->undecorated_smoothed_pwdb < 0)
@@ -2052,11 +1904,6 @@ bool rtl92e_get_rx_stats(struct net_device *dev, struct rtllib_rx_stats *stats,
 	stats->RxIs40MHzPacket = pDrvInfo->BW;
 
 	_rtl92e_translate_rx_signal_stats(dev, skb, stats, pdesc, pDrvInfo);
-
-	if (pDrvInfo->FirstAGGR == 1 || pDrvInfo->PartAggr == 1)
-		RT_TRACE(COMP_RXDESC,
-			 "pDrvInfo->FirstAGGR = %d, pDrvInfo->PartAggr = %d\n",
-			 pDrvInfo->FirstAGGR, pDrvInfo->PartAggr);
 	skb_trim(skb, skb->len - 4/*sCrcLng*/);
 
 
@@ -2261,9 +2108,6 @@ bool rtl92e_is_rx_stuck(struct net_device *dev)
 	u8		i;
 	u8		SilentResetRxSoltNum = 4;
 
-	RT_TRACE(COMP_RESET, "%s(): RegRxCounter is %d, RxCounter is %d\n",
-		 __func__, RegRxCounter, priv->RxCounter);
-
 	rx_chk_cnt++;
 	if (priv->undecorated_smoothed_pwdb >= (RateAdaptiveTH_High+5)) {
 		rx_chk_cnt = 0;
@@ -2321,9 +2165,6 @@ bool rtl92e_is_tx_stuck(struct net_device *dev)
 	bool	bStuck = false;
 	u16	RegTxCounter = rtl92e_readw(dev, 0x128);
 
-	RT_TRACE(COMP_RESET, "%s():RegTxCounter is %d,TxCounter is %d\n",
-		 __func__, RegTxCounter, priv->TxCounter);
-
 	if (priv->TxCounter == RegTxCounter)
 		bStuck = true;
 
-- 
2.37.3


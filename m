Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55B15BB640
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 06:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiIQEZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 00:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiIQEZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 00:25:15 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033FC7F256
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 21:25:11 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id e18so34186422edj.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 21:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date;
        bh=rhTLpkykF4OIBIAgt6GfJteNOLtelxdClp8gG/XYfIU=;
        b=LUr4ht16I3o7wvdeRweapl2G61E7DGkQchVXPNMhb6xfp7pwYN4NqQKJXK8QAV5RFd
         ON9GylEMCYc8vpiu1K16lL0zEeoKiPZQwXLlRDPmTHUY2EnmFbuQ0JvJy990vzxirfLN
         87QkeJuRJRn2L4213RYJ7DW0WzDm8FmGd7r3t9nhTL/cQXoLx2uFEbPcQpv0GJQHagOd
         ddkp0sjhfbE9ZtmvQp+L6AmfEoDKjEGwJcLgWCFwYQpngbYw4Bl5xJYHnw3pInLV/LiF
         L/6wWOTe4MDlhmeHRkCWT5jnfgG+a2kAVyQ6NSXTIvcwAYXaIevEZs261gck76jvxwnI
         hJjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=rhTLpkykF4OIBIAgt6GfJteNOLtelxdClp8gG/XYfIU=;
        b=Ves2XxOpYxSVBoegeJvay/I5EKWmfZWZXxlG6KQwABUxWAIs67XZ6I3pETE0JVAPZ1
         6kWyLZiIWG6smjdgDy7bcIBso1fPCvKoqIkjSSjscBTcrnTsvge4HEXUO9X0/fruRRZ6
         Gl/Mbi/Qo4v6ag/av/KQc/IUuuv2nNTHVvOexgibqT5KCO903IxsJ5WcblwvUQ3ZEXoZ
         KyjhSiA0ifuGJltUPvXAAxVw695+viMh5DVnOM4dzGExi3OZxWTgujD9/t4LVuL0rTe5
         MjOYT59e5cIIE/TlY5Fn2S4GbNs/sHwEGTzhaox5vGuE7xYvqSmiFz5rx8xIQPAF1u4X
         cSUg==
X-Gm-Message-State: ACrzQf2ZjnmzLDTsKvxh+LwWSdxX/1QU57yFtLAEJ45zXeYkFn+nqDLg
        wy5+oxQFFUrOmbX3ZVW6Yf5taBNyFh8=
X-Google-Smtp-Source: AMsMyM6XW+83/ogTlj/dVpFegiV7H0eKgs4+XcF+rz4bT6Qggu3WWo5GfzqdUrA3MrQNLrjg7neAEw==
X-Received: by 2002:a05:6402:2789:b0:451:a578:74dd with SMTP id b9-20020a056402278900b00451a57874ddmr6547860ede.72.1663388710111;
        Fri, 16 Sep 2022 21:25:10 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id e19-20020a50ec93000000b004528a535b44sm7435052edr.32.2022.09.16.21.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 21:25:09 -0700 (PDT)
Date:   Sat, 17 Sep 2022 06:25:07 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] staging: rtl8192e: Remove ftrace-like logging in
 r8192E_firmware.c, ...
Message-ID: <370f47919a69f2f1717f50123c1617cabc78ceca.1663387785.git.philipp.g.hortmann@gmail.com>
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
 .../staging/rtl8192e/rtl8192e/r8190P_rtl8256.c   |  6 ------
 .../staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c    |  2 --
 .../staging/rtl8192e/rtl8192e/r8192E_firmware.c  |  7 -------
 drivers/staging/rtl8192e/rtl8192e/rtl_cam.c      | 16 ----------------
 drivers/staging/rtl8192e/rtl8192e/rtl_pci.c      |  2 --
 drivers/staging/rtl8192e/rtl8192e/rtl_pm.c       |  1 -
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c       |  8 --------
 7 files changed, 42 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c b/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c
index 4abec7b42993..956e8e2a728c 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c
@@ -115,10 +115,6 @@ bool rtl92e_config_rf(struct net_device *dev)
 						(enum rf90_radio_path)eRFPath,
 						RegOffSetToBeCheck,
 						bMask12Bits);
-			RT_TRACE(COMP_RF,
-				 "RF %d %d register final value: %x\n",
-				 eRFPath, RegOffSetToBeCheck,
-				 RF3_Final_Value);
 			RetryTimes--;
 		}
 
@@ -142,8 +138,6 @@ bool rtl92e_config_rf(struct net_device *dev)
 			goto fail;
 		}
 	}
-
-	RT_TRACE(COMP_PHY, "PHY Initialization Success\n");
 	return true;
 
 fail:
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c
index cd8bbc358d01..df6e1043fe19 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c
@@ -21,8 +21,6 @@ bool rtl92e_send_cmd_pkt(struct net_device *dev, u32 type, const void *data,
 
 	struct tx_fwinfo_8190pci *pTxFwInfo = NULL;
 
-	RT_TRACE(COMP_CMDPKT, "%s(),buffer_len is %d\n", __func__, len);
-
 	do {
 		if ((len - frag_offset) > CMDPACKET_FRAG_SIZE) {
 			frag_length = CMDPACKET_FRAG_SIZE;
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_firmware.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_firmware.c
index 38110fa4f36d..789d288d7503 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_firmware.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_firmware.c
@@ -77,10 +77,6 @@ static bool _rtl92e_fw_check_ready(struct net_device *dev,
 		rt_status = _rtl92e_wait_for_fw(dev, CPU_GEN_FIRM_RDY, 20);
 		if (rt_status)
 			pfirmware->status = FW_STATUS_5_READY;
-		else
-			RT_TRACE(COMP_FIRMWARE,
-				 "_rtl92e_is_fw_ready fail(%d)!\n",
-				 rt_status);
 		break;
 	default:
 		rt_status = false;
@@ -149,9 +145,6 @@ bool rtl92e_init_fw(struct net_device *dev)
 	} else if (pfirmware->status == FW_STATUS_5_READY) {
 		rst_opt = OPT_FIRMWARE_RESET;
 		starting_state = FW_INIT_STEP2_DATA;
-	} else {
-		RT_TRACE(COMP_FIRMWARE,
-			 "PlatformInitFirmware: undefined firmware state\n");
 	}
 
 	for (i = starting_state; i <= FW_INIT_STEP2_DATA; i++) {
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c b/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c
index 6b372b0dd6bc..8dba8606bda1 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c
@@ -46,10 +46,6 @@ void rtl92e_enable_hw_security_config(struct net_device *dev)
 		ieee->hwsec_active = 0;
 		SECR_value &= ~SCR_RxDecEnable;
 	}
-
-	RT_TRACE(COMP_SEC, "%s:, hwsec:%d, pairwise_key:%d, SECR_value:%x\n",
-		 __func__, ieee->hwsec_active, ieee->pairwise_key_type,
-		 SECR_value);
 	rtl92e_writeb(dev, SECR, SECR_value);
 }
 
@@ -60,10 +56,6 @@ void rtl92e_set_swcam(struct net_device *dev, u8 EntryNo, u8 KeyIndex,
 	struct r8192_priv *priv = rtllib_priv(dev);
 	struct rtllib_device *ieee = priv->rtllib;
 
-	RT_TRACE(COMP_DBG,
-		 "===========>%s():EntryNo is %d,KeyIndex is %d,KeyType is %d,is_mesh is %d\n",
-		 __func__, EntryNo, KeyIndex, KeyType, is_mesh);
-
 	if (EntryNo >= TOTAL_CAM_ENTRY)
 		return;
 
@@ -107,10 +99,6 @@ void rtl92e_set_key(struct net_device *dev, u8 EntryNo, u8 KeyIndex,
 		return;
 	}
 
-	RT_TRACE(COMP_SEC,
-		 "====>to %s, dev:%p, EntryNo:%d, KeyIndex:%d,KeyType:%d, MacAddr %pM\n",
-		 __func__, dev, EntryNo, KeyIndex, KeyType, MacAddr);
-
 	if (DefaultKey)
 		usConfig |= BIT15 | (KeyType<<2);
 	else
@@ -144,7 +132,6 @@ void rtl92e_set_key(struct net_device *dev, u8 EntryNo, u8 KeyIndex,
 			}
 		}
 	}
-	RT_TRACE(COMP_SEC, "=========>after set key, usconfig:%x\n", usConfig);
 }
 
 void rtl92e_cam_restore(struct net_device *dev)
@@ -163,9 +150,6 @@ void rtl92e_cam_restore(struct net_device *dev)
 		0xff, 0xff, 0xff, 0xff, 0xff, 0xff
 	};
 
-	RT_TRACE(COMP_SEC, "%s:\n", __func__);
-
-
 	if ((priv->rtllib->pairwise_key_type == KEY_TYPE_WEP40) ||
 	    (priv->rtllib->pairwise_key_type == KEY_TYPE_WEP104)) {
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_pci.c b/drivers/staging/rtl8192e/rtl8192e/rtl_pci.c
index 1d992d5c4e17..886bf4ba2adf 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_pci.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_pci.c
@@ -20,8 +20,6 @@ static void _rtl92e_parse_pci_configuration(struct pci_dev *pdev,
 
 	pcie_capability_read_word(priv->pdev, PCI_EXP_LNKCTL, &LinkCtrlReg);
 
-	RT_TRACE(COMP_INIT, "Link Control Register =%x\n", LinkCtrlReg);
-
 	pci_read_config_byte(pdev, 0x98, &tmp);
 	tmp |= BIT4;
 	pci_write_config_byte(pdev, 0x98, tmp);
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_pm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_pm.c
index 5575186caebd..ced00de89114 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_pm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_pm.c
@@ -86,7 +86,6 @@ int rtl92e_resume(struct device *dev_d)
 		rtl92e_set_rf_state(dev, eRfOn, RF_CHANGE_BY_INIT);
 
 out:
-	RT_TRACE(COMP_POWER, "<================r8192E resume call.\n");
 	return 0;
 }
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
index ab0bd12ddfda..bfb963768fc3 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
@@ -149,8 +149,6 @@ static int _rtl92e_wx_force_reset(struct net_device *dev,
 
 	mutex_lock(&priv->wx_mutex);
 
-	RT_TRACE(COMP_DBG, "%s(): force reset ! extra is %d\n",
-		 __func__, *extra);
 	priv->force_reset = *extra;
 	mutex_unlock(&priv->wx_mutex);
 	return 0;
@@ -167,8 +165,6 @@ static int _rtl92e_wx_adapter_power_status(struct net_device *dev,
 
 	mutex_lock(&priv->wx_mutex);
 
-	RT_TRACE(COMP_POWER, "%s(): %s\n", __func__, (*extra == 6) ?
-		 "DC power" : "AC power");
 	if (*extra || priv->force_lps) {
 		priv->ps_force = false;
 		pPSC->bLeisurePs = true;
@@ -427,9 +423,6 @@ static int _rtl92e_wx_set_scan(struct net_device *dev,
 					mutex_unlock(&priv->wx_mutex);
 					return -1;
 				}
-				RT_TRACE(COMP_PS,
-					 "=========>%s(): rtl92e_ips_leave\n",
-					 __func__);
 				mutex_lock(&priv->rtllib->ips_mutex);
 				rtl92e_ips_leave(dev);
 				mutex_unlock(&priv->rtllib->ips_mutex);
@@ -681,7 +674,6 @@ static int _rtl92e_wx_set_enc(struct net_device *dev,
 	mutex_unlock(&priv->rtllib->ips_mutex);
 	mutex_lock(&priv->wx_mutex);
 
-	RT_TRACE(COMP_SEC, "Setting SW wep key");
 	ret = rtllib_wx_set_encode(priv->rtllib, info, wrqu, key);
 	mutex_unlock(&priv->wx_mutex);
 
-- 
2.37.3


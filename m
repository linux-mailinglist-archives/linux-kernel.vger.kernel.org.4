Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F11F6B63B2
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 08:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjCLHdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 03:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCLHcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 03:32:55 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D2858C3E
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 23:32:53 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id fd5so2990786edb.7
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 23:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678606372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IFYZU47XkXjicVnEpx8yCobIE8+cWTc7ZMui+nf3Ps4=;
        b=giMTbccCtjpUC2oY4joSSUdFAijCqiLIPIh+vaQVYxVlAwjD9jNzJMsHnaMwLkNsfl
         sBmMfGsEKefw9H8hBRpVyqbTMvoegX1beqkl4cMZmMYb2+GwTvrUCwWFZ2A5Z/74PG9L
         xZjCaphb/9Cd0zTqavQGBi3jWvNgi5dV8Sf7Uh7Af07GTUTaOcxZDZI9Ioc63UU9C+x6
         l59fEzSBRuJdFMZsGRIgqcXe3jw94iupVM/xMBAkdyqamezYHAqiI1E7wngOw8bNFces
         GdjbWVov00iOTB71ji6KmlS0+mraha9DOeTMhasaJfOX0pyzuwhyuWG0x0LBk8o76bg6
         AR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678606372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IFYZU47XkXjicVnEpx8yCobIE8+cWTc7ZMui+nf3Ps4=;
        b=rA2yKX/uY4iF5u7Htn1dWjMMSqWwsWNGrUb6l9v4mO/9S7ytCCfRtJ0LNF42Jjlif6
         i6T2YFK3dyF7Om/95WOyxxt0lDaU3zxjCqx4xnZb+cLJLn1zQjKDG9foO0RS6I5VFYRD
         W1hq52YjdBtp0ssGBAgeRPwQYEZwLVYOQRZ2dOKfzs853gshecQyunTmBq7juWYzIVVV
         lGi8sdihMJkzJvW0PkaiJGGiEvmdBQc6HWirI0TNhlV2lNMkgVTSvlTxLvkeVnIYCB8/
         yRTZv069YkQF2ROr42KLa0OJjwY78KxYKKibnqRc60riPf9Xt7iJaDfJ3xPdu/DuSy38
         tpBw==
X-Gm-Message-State: AO0yUKVKL5PSNUk5aCryHwDBmZTVq7z4pvIoyW920ymWTj/dl2t02kJA
        8FVagVG6nFY7ZnBAFWrYE0U=
X-Google-Smtp-Source: AK7set9LPlEBfOg7tv8n9D5mDIrecrYgghGjIxF1WxCpbeV84MEXETMqpXi2b4RJdA5LV1KQ2J8yPA==
X-Received: by 2002:a17:907:c68a:b0:8de:acd1:90f6 with SMTP id ue10-20020a170907c68a00b008deacd190f6mr34691560ejc.4.1678606372469;
        Sat, 11 Mar 2023 23:32:52 -0800 (PST)
Received: from localhost.localdomain (ip5f5abbfa.dynamic.kabel-deutschland.de. [95.90.187.250])
        by smtp.gmail.com with ESMTPSA id dc8-20020a170906c7c800b008d1dc5f5692sm1928841ejb.76.2023.03.11.23.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 23:32:52 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/2] staging: rtl8192u: rtl8192_SetRFPowerState() is not used
Date:   Sun, 12 Mar 2023 08:32:46 +0100
Message-Id: <20230312073247.9822-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230312073247.9822-1-straube.linux@gmail.com>
References: <20230312073247.9822-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function rtl8192_SetRFPowerState() is not used anywhere, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_phy.c | 87 ---------------------------
 drivers/staging/rtl8192u/r819xU_phy.h |  2 -
 2 files changed, 89 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_phy.c b/drivers/staging/rtl8192u/r819xU_phy.c
index 97f4d89500ae..e6836eacc7aa 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.c
+++ b/drivers/staging/rtl8192u/r819xU_phy.c
@@ -1044,93 +1044,6 @@ static void rtl8192_SetTxPowerLevel(struct net_device *dev, u8 channel)
 	}
 }
 
-/******************************************************************************
- * function:  This function sets RF state on or off
- * input:     net_device         *dev
- *            RT_RF_POWER_STATE  eRFPowerState  //Power State to set
- * output:    none
- * return:    none
- * notice:
- *****************************************************************************/
-bool rtl8192_SetRFPowerState(struct net_device *dev,
-			     RT_RF_POWER_STATE eRFPowerState)
-{
-	bool				bResult = true;
-	struct r8192_priv *priv = ieee80211_priv(dev);
-
-	if (eRFPowerState == priv->ieee80211->eRFPowerState)
-		return false;
-
-	if (priv->SetRFPowerStateInProgress)
-		return false;
-
-	priv->SetRFPowerStateInProgress = true;
-
-	switch (priv->rf_chip) {
-	case RF_8256:
-		switch (eRFPowerState) {
-		case eRfOn:
-			/* RF-A, RF-B */
-			/* enable RF-Chip A/B - 0x860[4] */
-			rtl8192_setBBreg(dev, rFPGA0_XA_RFInterfaceOE, BIT(4),
-					 0x1);
-			/* analog to digital on - 0x88c[9:8] */
-			rtl8192_setBBreg(dev, rFPGA0_AnalogParameter4, 0x300,
-					 0x3);
-			/* digital to analog on - 0x880[4:3] */
-			rtl8192_setBBreg(dev, rFPGA0_AnalogParameter1, 0x18,
-					 0x3);
-			/* rx antenna on - 0xc04[1:0] */
-			rtl8192_setBBreg(dev, rOFDM0_TRxPathEnable, 0x3, 0x3);
-			/* rx antenna on - 0xd04[1:0] */
-			rtl8192_setBBreg(dev, rOFDM1_TRxPathEnable, 0x3, 0x3);
-			/* analog to digital part2 on - 0x880[6:5] */
-			rtl8192_setBBreg(dev, rFPGA0_AnalogParameter1, 0x60,
-					 0x3);
-
-			break;
-
-		case eRfSleep:
-
-			break;
-
-		case eRfOff:
-			/* RF-A, RF-B */
-			/* disable RF-Chip A/B - 0x860[4] */
-			rtl8192_setBBreg(dev, rFPGA0_XA_RFInterfaceOE, BIT(4),
-					 0x0);
-			/* analog to digital off, for power save */
-			rtl8192_setBBreg(dev, rFPGA0_AnalogParameter4, 0xf00,
-					 0x0); /* 0x88c[11:8] */
-			/* digital to analog off, for power save - 0x880[4:3] */
-			rtl8192_setBBreg(dev, rFPGA0_AnalogParameter1, 0x18,
-					 0x0);
-			/* rx antenna off - 0xc04[3:0] */
-			rtl8192_setBBreg(dev, rOFDM0_TRxPathEnable, 0xf, 0x0);
-			/* rx antenna off - 0xd04[3:0] */
-			rtl8192_setBBreg(dev, rOFDM1_TRxPathEnable, 0xf, 0x0);
-			/* analog to digital part2 off, for power save */
-			rtl8192_setBBreg(dev, rFPGA0_AnalogParameter1, 0x60,
-					 0x0); /* 0x880[6:5] */
-
-			break;
-
-		default:
-			bResult = false;
-			RT_TRACE(COMP_ERR, "%s(): unknown state to set: 0x%X\n",
-				 __func__, eRFPowerState);
-			break;
-		}
-		break;
-	default:
-		RT_TRACE(COMP_ERR, "Not support rf_chip(%x)\n", priv->rf_chip);
-		break;
-	}
-	priv->SetRFPowerStateInProgress = false;
-
-	return bResult;
-}
-
 /******************************************************************************
  * function:  This function sets command table variable (struct sw_chnl_cmd).
  * input:     sw_chnl_cmd      *CmdTable    //table to be set
diff --git a/drivers/staging/rtl8192u/r819xU_phy.h b/drivers/staging/rtl8192u/r819xU_phy.h
index 8c2933264407..bafaa6a90c50 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.h
+++ b/drivers/staging/rtl8192u/r819xU_phy.h
@@ -74,8 +74,6 @@ void rtl8192_SetBWMode(struct net_device *dev,
 		       enum ht_extension_chan_offset offset);
 void rtl8192_SwChnl_WorkItem(struct net_device *dev);
 void rtl8192_SetBWModeWorkItem(struct net_device *dev);
-bool rtl8192_SetRFPowerState(struct net_device *dev,
-			     RT_RF_POWER_STATE eRFPowerState);
 void InitialGain819xUsb(struct net_device *dev, u8 Operation);
 
 void InitialGainOperateWorkItemCallBack(struct work_struct *work);
-- 
2.39.2


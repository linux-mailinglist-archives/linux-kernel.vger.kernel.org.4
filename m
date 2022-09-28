Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA425EDF09
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 16:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbiI1Ont (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 10:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234500AbiI1Oni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 10:43:38 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B73AFAF0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 07:43:36 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id a13so2444472edj.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 07:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=DQ8HHYpQxDNrGQzA7YE7Q7g3HvNU2igDf32G4BPOhWk=;
        b=pGj7M0SIsViJW0CS8/WI/bu74agYYT3JeREK7omiyxbvkYU5iKKeqvDnHNnaQczP8G
         3YTlaao6cdQg5atV0A1f9vIhahCO4UJ47D0ceOXDnRXitBCBHrZ53o579YdDVe9Ou1e0
         roZy5KTWQ+9yRzgh+XXCqWULjwGjJgbGCd1xXI4SXUIPCPs5VIPF5R3LkHNPIckbz0he
         cScrPRfCAcjBGHvTuRXpkFijd85FvdvxuamNQGHfreZmzHnGTvHIijjyL6QXAlA+hS2y
         4jYtk4Pu0DLrC+1nzG2zNb1tl0lADQ3A28p2De7AwzRX36EWuRJnR8Vgd0pa/pV2/pap
         pB0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=DQ8HHYpQxDNrGQzA7YE7Q7g3HvNU2igDf32G4BPOhWk=;
        b=j5CT/JPrt8JgyfhHDq578DE/G75mcxGplYlrUzVKxtXDe7RM46206H36tJDuHbETr+
         x9GfspUsFrmzuNAGuZVnsMlBNr5644ZK2l79ElPWmjYELYNnryDcwjLtxMbVgDGkrj+y
         y1FIrSObVV3UkJlUSV2VvLKMP5oQ3ieRZUMqFKxdplz9ml2Ykx+1JPeoljmJlLLiU/Ak
         YX54HUrO0VBm0A3j1ZOWVIzrrsApWtMx335DNVsCm41Wwk12/CW99rQfgSLF4k7qDuPl
         nFrZ0MqY4rYBPrR6IVk7xZu84T88r9RCvkX3gmbJ4rvC12n/T2v+bacpoL9np7wfK9TM
         gkHQ==
X-Gm-Message-State: ACrzQf1JKhSNwb8tNMTT0m4qCijRd11+Him2zwnfH+5tT5Jz0V/Esbf+
        jOQdd92BChuaw/URVZ0rEk8=
X-Google-Smtp-Source: AMsMyM6NKJHU1wiq68xzq+nYBWKg7JrHqfhy336/EuQKXS/PaCRHLiIptiwCc+nUHFvY2z2QQg93BA==
X-Received: by 2002:a05:6402:348f:b0:451:7390:c6d4 with SMTP id v15-20020a056402348f00b004517390c6d4mr33885397edc.236.1664376214824;
        Wed, 28 Sep 2022 07:43:34 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb59.dynamic.kabel-deutschland.de. [95.90.187.89])
        by smtp.gmail.com with ESMTPSA id u9-20020a50eac9000000b00456c6b4b777sm3456973edp.69.2022.09.28.07.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 07:43:34 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/4] staging: r8188eu: convert ODM_ReadAndConfig_RadioA_1T_8188E() to int
Date:   Wed, 28 Sep 2022 16:43:21 +0200
Message-Id: <20220928144323.13164-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220928144323.13164-1-straube.linux@gmail.com>
References: <20220928144323.13164-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function ODM_ReadAndConfig_RadioA_1T_8188E() has return type
'enum HAL_STATUS'. Convert the return type to int and use common
kernel error logic. Return 0 on success and negative values on
failure. The goal is to get rid of enum HAL_STATUS in the end.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c     | 9 ++++-----
 drivers/staging/r8188eu/hal/rtl8188e_rf6052.c      | 2 +-
 drivers/staging/r8188eu/include/HalHWImg8188E_RF.h | 2 +-
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c b/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c
index ea123817e3d5..a4c3d3d149f7 100644
--- a/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c
+++ b/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c
@@ -160,7 +160,7 @@ static void odm_ConfigRF_RadioA_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr, u
 	odm_ConfigRFReg_8188E(pDM_Odm, Addr, Data, Addr | maskforPhySet);
 }
 
-enum HAL_STATUS ODM_ReadAndConfig_RadioA_1T_8188E(struct odm_dm_struct *pDM_Odm)
+int ODM_ReadAndConfig_RadioA_1T_8188E(struct odm_dm_struct *pDM_Odm)
 {
 	#define READ_NEXT_PAIR(v1, v2, i) do	\
 		 { i += 2; v1 = Array[i];	\
@@ -174,7 +174,6 @@ enum HAL_STATUS ODM_ReadAndConfig_RadioA_1T_8188E(struct odm_dm_struct *pDM_Odm)
 	struct adapter *Adapter =  pDM_Odm->Adapter;
 	struct xmit_frame *pxmit_frame = NULL;
 	u8 bndy_cnt = 1;
-	enum HAL_STATUS rst = HAL_STATUS_SUCCESS;
 
 	hex += ODM_ITRF_USB << 8;
 	hex += ODM_CE << 16;
@@ -185,7 +184,7 @@ enum HAL_STATUS ODM_ReadAndConfig_RadioA_1T_8188E(struct odm_dm_struct *pDM_Odm)
 		pxmit_frame = rtw_IOL_accquire_xmit_frame(Adapter);
 		if (!pxmit_frame) {
 			pr_info("rtw_IOL_accquire_xmit_frame failed\n");
-			return HAL_STATUS_FAILURE;
+			return -ENOMEM;
 		}
 	}
 
@@ -262,9 +261,9 @@ enum HAL_STATUS ODM_ReadAndConfig_RadioA_1T_8188E(struct odm_dm_struct *pDM_Odm)
 	}
 	if (biol) {
 		if (!rtl8188e_IOL_exec_cmds_sync(pDM_Odm->Adapter, pxmit_frame, 1000, bndy_cnt)) {
-			rst = HAL_STATUS_FAILURE;
 			pr_info("~~~ IOL Config %s Failed !!!\n", __func__);
+			return -1;
 		}
 	}
-	return rst;
+	return 0;
 }
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c b/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
index 0dc902b0abae..e5ec6e563fbd 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
@@ -396,7 +396,7 @@ int phy_RF6052_Config_ParaFile(struct adapter *Adapter)
 	udelay(1);/* PlatformStallExecution(1); */
 
 	/*----Initialize RF fom connfiguration file----*/
-	if (ODM_ReadAndConfig_RadioA_1T_8188E(&pHalData->odmpriv) == HAL_STATUS_FAILURE)
+	if (ODM_ReadAndConfig_RadioA_1T_8188E(&pHalData->odmpriv))
 		rtStatus = _FAIL;
 
 	/*----Restore RFENV control type----*/;
diff --git a/drivers/staging/r8188eu/include/HalHWImg8188E_RF.h b/drivers/staging/r8188eu/include/HalHWImg8188E_RF.h
index 0c67c3df20b9..880feadb4340 100644
--- a/drivers/staging/r8188eu/include/HalHWImg8188E_RF.h
+++ b/drivers/staging/r8188eu/include/HalHWImg8188E_RF.h
@@ -8,6 +8,6 @@
  *                           RadioA_1T.TXT
  ******************************************************************************/
 
-enum HAL_STATUS ODM_ReadAndConfig_RadioA_1T_8188E(struct odm_dm_struct *odm);
+int ODM_ReadAndConfig_RadioA_1T_8188E(struct odm_dm_struct *odm);
 
 #endif /*  end of HWIMG_SUPPORT */
-- 
2.37.3


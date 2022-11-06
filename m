Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A84661E0DF
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 09:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiKFIbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 03:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiKFIbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 03:31:37 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0216BC84
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 01:31:34 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id l6so8023837pjj.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 01:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QAn4ayFDcY1ljL5JrQGh7qC0mRQ6YUvrsVxRS5lz8ds=;
        b=m6WBwe6PMeJj87bfQMjJ87WMfqMuysO4S/LU4azPFJr9WpE30j5TnZIOyuvsiTtpQO
         nsY4dOVvfEygzoynkH2RpQPseuSVQOgnYW3mtl7GUiyWXp0/AyuV9YCeCJt8EUBHGhWP
         jlsab9Hxw34PTBJGxQtkKqfKD8X8Qrf62bhkjU8q4FSfBLPU47vSfh3FqSms2I3NWwF3
         xl3HgAx6itGiwbN7BON/Ja1r7c5CrysOulzdWeGMQhgyhhWBphiv7w8YMbjpjeJOZaTl
         RcF9mzGss9hlODvUtifkWekXT7IOiRMDVVcUBCnX48fIFqN9Vpzx3Pojy1K8S/8qD+x9
         aotg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QAn4ayFDcY1ljL5JrQGh7qC0mRQ6YUvrsVxRS5lz8ds=;
        b=IFcOcN+yQQdnFfWLLI5i75tNUsUkd2NUbs8M2BBZgxBYZw6ATVAKbJMOuVdi5yvlDa
         8EJ5NumqMFMLkQ0I5/UqiLUeqnn9S5u4M/1oZlsB9k/WoBdp0Ph8nr3MF0poOsUmNChg
         0pHHHboMRUzJb1zGRwQdZVmbb5+2qCMjiLAqok/mw4f7qlSP02raEGqT/48ejijBsrNs
         j7phD5jb9gDnoqBtXsLFjGxvB1pxj031yEduzWikywjh+Aq4UGAtH/aqRYz6n4Q2d4yG
         fEng68fCevlyQ3qwb8+vCQPudgRtszH3b1p6Jm5HpS5DJuxpjCdRFV1hXxlvFm3cDCni
         EDlw==
X-Gm-Message-State: ACrzQf36pDxT6rbttbohUKKUHKHYSp8QGLkuhnPkegQd3fMWmBeBujhS
        8DajmeIpIdyH+0jg/Hbxh+DBM7s0gHZeEP4G
X-Google-Smtp-Source: AMsMyM6Jus/syQDUf/uRIMg8UUuFUai6zv9Q+NIw6U8FJWWnDkDUFtOqSwZ8RzK53P5SPVznNymMkQ==
X-Received: by 2002:a17:90a:1a07:b0:214:247a:1932 with SMTP id 7-20020a17090a1a0700b00214247a1932mr472362pjk.187.1667723494199;
        Sun, 06 Nov 2022 01:31:34 -0700 (PDT)
Received: from jacob-Ubuntu (126.224.215.218.sta.wbroadband.net.au. [218.215.224.126])
        by smtp.gmail.com with ESMTPSA id n8-20020a170903110800b00186b69157ecsm2757236plh.202.2022.11.06.01.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 01:31:33 -0700 (PDT)
From:   Jacob Bai <jacob.bai.au@gmail.com>
To:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] staging: rtl8192e: replace macro defines with ARRAY_SIZE
Date:   Sun,  6 Nov 2022 19:31:18 +1100
Message-Id: <13fddf4affd15a58c191be717ddee75772849f4e.1667723306.git.jacob.bai.au@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1667723306.git.jacob.bai.au@gmail.com>
References: <cover.1667723306.git.jacob.bai.au@gmail.com>
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

use ARRAY_SIZE() to replace  macro defines

Signed-off-by: Jacob Bai <jacob.bai.au@gmail.com>
---
 .../staging/rtl8192e/rtl8192e/r8192E_phy.c    | 52 +++++++++----------
 .../staging/rtl8192e/rtl8192e/r8192E_phy.h    | 20 -------
 drivers/staging/rtl8192e/rtl8192e/table.c     | 32 ++++++++----
 drivers/staging/rtl8192e/rtl8192e/table.h     | 36 ++++++-------
 4 files changed, 65 insertions(+), 75 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index eabb4187d907..aad1842857c0 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -307,12 +307,12 @@ void rtl92e_config_mac(struct net_device *dev)
 	struct r8192_priv *priv = rtllib_priv(dev);
 
 	if (priv->bTXPowerDataReadFromEEPORM) {
-		dwArrayLen = MACPHY_Array_PGLength;
-		pdwArray = Rtl819XMACPHY_Array_PG;
+		dwArrayLen = RTL8192E_MAC_ARRAY_PG_LEN;
+		pdwArray = RTL8192E_MAC_ARRAY_PG;
 
 	} else {
-		dwArrayLen = MACPHY_ArrayLength;
-		pdwArray = Rtl819XMACPHY_Array;
+		dwArrayLen = RTL8192E_MAC_ARRAY_LEN;
+		pdwArray = RTL8192E_MAC_ARRAY;
 	}
 	for (i = 0; i < dwArrayLen; i += 3) {
 		if (pdwArray[i] == 0x318)
@@ -332,14 +332,14 @@ static void _rtl92e_phy_config_bb(struct net_device *dev, u8 ConfigType)
 	u16 AGCTAB_ArrayLen, PHY_REGArrayLen = 0;
 	struct r8192_priv *priv = rtllib_priv(dev);
 
-	AGCTAB_ArrayLen = AGCTAB_ArrayLength;
-	Rtl819XAGCTAB_Array_Table = Rtl819XAGCTAB_Array;
+	AGCTAB_ArrayLen = RTL8192E_AGC_TAB_ARRAY_LEN;
+	Rtl819XAGCTAB_Array_Table = RTL8192E_AGC_TAB_ARRAY;
 	if (priv->rf_type == RF_2T4R) {
-		PHY_REGArrayLen = PHY_REGArrayLength;
-		Rtl819XPHY_REGArray_Table = Rtl819XPHY_REGArray;
+		PHY_REGArrayLen = RTL8192E_PHY_REG_ARRAY_LEN;
+		Rtl819XPHY_REGArray_Table = RTL8192E_PHY_REG_ARRAY;
 	} else if (priv->rf_type == RF_1T2R) {
-		PHY_REGArrayLen = PHY_REG_1T2RArrayLength;
-		Rtl819XPHY_REGArray_Table = Rtl819XPHY_REG_1T2RArray;
+		PHY_REGArrayLen = RTL8192E_PHY_REG_1T2R_ARRAY_LEN;
+		Rtl819XPHY_REGArray_Table = RTL8192E_PHY_REG_1T2R_ARRAY;
 	}
 
 	if (ConfigType == BaseBand_Config_PHY_REG) {
@@ -668,50 +668,50 @@ u8 rtl92e_config_rf_path(struct net_device *dev, enum rf90_radio_path eRFPath)
 
 	switch (eRFPath) {
 	case RF90_PATH_A:
-		for (i = 0; i < RadioA_ArrayLength; i += 2) {
-			if (Rtl819XRadioA_Array[i] == 0xfe) {
+		for (i = 0; i < RTL8192E_RADIOA_ARRAY_LEN; i += 2) {
+			if (RTL8192E_RADIOA_ARRAY[i] == 0xfe) {
 				msleep(100);
 				continue;
 			}
-			rtl92e_set_rf_reg(dev, eRFPath, Rtl819XRadioA_Array[i],
+			rtl92e_set_rf_reg(dev, eRFPath, RTL8192E_RADIOA_ARRAY[i],
 					  bMask12Bits,
-					  Rtl819XRadioA_Array[i+1]);
+					  RTL8192E_RADIOA_ARRAY[i+1]);
 
 		}
 		break;
 	case RF90_PATH_B:
-		for (i = 0; i < RadioB_ArrayLength; i += 2) {
-			if (Rtl819XRadioB_Array[i] == 0xfe) {
+		for (i = 0; i < RTL8192E_RADIOB_ARRAY_LEN; i += 2) {
+			if (RTL8192E_RADIOB_ARRAY[i] == 0xfe) {
 				msleep(100);
 				continue;
 			}
-			rtl92e_set_rf_reg(dev, eRFPath, Rtl819XRadioB_Array[i],
+			rtl92e_set_rf_reg(dev, eRFPath, RTL8192E_RADIOB_ARRAY[i],
 					  bMask12Bits,
-					  Rtl819XRadioB_Array[i+1]);
+					  RTL8192E_RADIOB_ARRAY[i+1]);
 
 		}
 		break;
 	case RF90_PATH_C:
-		for (i = 0; i < RadioC_ArrayLength; i += 2) {
-			if (Rtl819XRadioC_Array[i] == 0xfe) {
+		for (i = 0; i < RTL8192E_RADIOC_ARRAY_LEN; i += 2) {
+			if (RTL8192E_RADIOC_ARRAY[i] == 0xfe) {
 				msleep(100);
 				continue;
 			}
-			rtl92e_set_rf_reg(dev, eRFPath, Rtl819XRadioC_Array[i],
+			rtl92e_set_rf_reg(dev, eRFPath, RTL8192E_RADIOC_ARRAY[i],
 					  bMask12Bits,
-					  Rtl819XRadioC_Array[i+1]);
+					  RTL8192E_RADIOC_ARRAY[i+1]);
 
 		}
 		break;
 	case RF90_PATH_D:
-		for (i = 0; i < RadioD_ArrayLength; i += 2) {
-			if (Rtl819XRadioD_Array[i] == 0xfe) {
+		for (i = 0; i < RTL8192E_RADIOD_ARRAY_LEN; i += 2) {
+			if (RTL8192E_RADIOD_ARRAY[i] == 0xfe) {
 				msleep(100);
 				continue;
 			}
-			rtl92e_set_rf_reg(dev, eRFPath, Rtl819XRadioD_Array[i],
+			rtl92e_set_rf_reg(dev, eRFPath, RTL8192E_RADIOD_ARRAY[i],
 					  bMask12Bits,
-					  Rtl819XRadioD_Array[i+1]);
+					  RTL8192E_RADIOD_ARRAY[i+1]);
 
 		}
 		break;
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
index e1c1f19b71a3..5e6527e835db 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
@@ -9,26 +9,6 @@
 
 #define MAX_DOZE_WAITING_TIMES_9x 64
 
-#define AGCTAB_ArrayLength			RTL8192E_AGC_TAB_ARRAY_LEN
-#define MACPHY_ArrayLength			RTL8192E_MAC_ARRAY_LEN
-#define RadioA_ArrayLength			RTL8192E_RADIOA_ARRAY_LEN
-#define RadioB_ArrayLength			RTL8192E_RADIOB_ARRAY_LEN
-#define MACPHY_Array_PGLength			RTL8192E_MAC_ARRAY_PG_LEN
-#define RadioC_ArrayLength			RTL8192E_RADIOC_ARRAY_LEN
-#define RadioD_ArrayLength			RTL8192E_RADIOD_ARRAY_LEN
-#define PHY_REGArrayLength			RTL8192E_PHY_REG_ARRAY_LEN
-#define PHY_REG_1T2RArrayLength			RTL8192E_PHY_REG_1T2R_ARRAY_LEN
-
-#define Rtl819XMACPHY_Array_PG			RTL8192E_MAC_ARRAY_PG
-#define Rtl819XMACPHY_Array			RTL8192E_MAC_ARRAY
-#define Rtl819XRadioA_Array			RTL8192E_RADIOA_ARRAY
-#define Rtl819XRadioB_Array			RTL8192E_RADIOB_ARRAY
-#define Rtl819XRadioC_Array			RTL8192E_RADIOC_ARRAY
-#define Rtl819XRadioD_Array			RTL8192E_RADIOD_ARRAY
-#define Rtl819XAGCTAB_Array			RTL8192E_AGC_TAB_ARRAY
-#define Rtl819XPHY_REGArray			RTL8192E_PHY_REG_ARRAY
-#define Rtl819XPHY_REG_1T2RArray		RTL8192E_PHY_REG_1T2R_ARRAY
-
 extern u32 rtl819XAGCTAB_Array[];
 
 enum hw90_block {
diff --git a/drivers/staging/rtl8192e/rtl8192e/table.c b/drivers/staging/rtl8192e/rtl8192e/table.c
index 2e75f40db874..936f2ea180cd 100644
--- a/drivers/staging/rtl8192e/rtl8192e/table.c
+++ b/drivers/staging/rtl8192e/rtl8192e/table.c
@@ -4,11 +4,13 @@
  *
  * Contact Information: wlanfae <wlanfae@realtek.com>
  */
+#include <linux/kernel.h>
 #include "table.h"
 
-u32 RTL8192E_PHY_REG_ARRAY[RTL8192E_PHY_REG_ARRAY_LEN] = {0x0,};
+u32 RTL8192E_PHY_REG_ARRAY[] = {0x0,};
+u32 RTL8192E_PHY_REG_ARRAY_LEN = ARRAY_SIZE(RTL8192E_PHY_REG_ARRAY);
 
-u32 RTL8192E_PHY_REG_1T2R_ARRAY[RTL8192E_PHY_REG_1T2R_ARRAY_LEN] = {
+u32 RTL8192E_PHY_REG_1T2R_ARRAY[] = {
 	0x800, 0x00000000,
 	0x804, 0x00000001,
 	0x808, 0x0000fc00,
@@ -158,8 +160,9 @@ u32 RTL8192E_PHY_REG_1T2R_ARRAY[RTL8192E_PHY_REG_1T2R_ARRAY_LEN] = {
 	0xe18, 0x161a1a1a,
 	0xe1c, 0x12121416,
 };
+u32 RTL8192E_PHY_REG_1T2R_ARRAY_LEN = ARRAY_SIZE(RTL8192E_PHY_REG_1T2R_ARRAY);
 
-u32 RTL8192E_RADIOA_ARRAY[RTL8192E_RADIOA_ARRAY_LEN] = {
+u32 RTL8192E_RADIOA_ARRAY[] = {
 	0x019, 0x00000003,
 	0x000, 0x000000bf,
 	0x001, 0x00000ee0,
@@ -284,8 +287,9 @@ u32 RTL8192E_RADIOA_ARRAY[RTL8192E_RADIOA_ARRAY_LEN] = {
 	0x004, 0x00000975,
 	0x007, 0x00000700,
 };
+u32 RTL8192E_RADIOA_ARRAY_LEN = ARRAY_SIZE(RTL8192E_RADIOA_ARRAY);
 
-u32 RTL8192E_RADIOB_ARRAY[RTL8192E_RADIOB_ARRAY_LEN] = {
+u32 RTL8192E_RADIOB_ARRAY[] = {
 	0x019, 0x00000003,
 	0x000, 0x000000bf,
 	0x001, 0x000006e0,
@@ -326,14 +330,17 @@ u32 RTL8192E_RADIOB_ARRAY[RTL8192E_RADIOB_ARRAY_LEN] = {
 	0x004, 0x00000975,
 	0x007, 0x00000700,
 };
+u32 RTL8192E_RADIOB_ARRAY_LEN = ARRAY_SIZE(RTL8192E_RADIOB_ARRAY);
 
-u32 RTL8192E_RADIOC_ARRAY[RTL8192E_RADIOC_ARRAY_LEN] = {
-	0x0,  };
+u32 RTL8192E_RADIOC_ARRAY[] = {
+	0x0, 0x0 };
+u32 RTL8192E_RADIOC_ARRAY_LEN = ARRAY_SIZE(RTL8192E_RADIOC_ARRAY);
 
-u32 RTL8192E_RADIOD_ARRAY[RTL8192E_RADIOD_ARRAY_LEN] = {
-	0x0, };
+u32 RTL8192E_RADIOD_ARRAY[] = {
+	0x0, 0x0 };
+u32 RTL8192E_RADIOD_ARRAY_LEN = ARRAY_SIZE(RTL8192E_RADIOD_ARRAY);
 
-u32 RTL8192E_MAC_ARRAY[RTL8192E_MAC_ARRAY_LEN] = {
+u32 RTL8192E_MAC_ARRAY[] = {
 	0x03c, 0xffff0000, 0x00000f0f,
 	0x340, 0xffffffff, 0x161a1a1a,
 	0x344, 0xffffffff, 0x12121416,
@@ -341,8 +348,9 @@ u32 RTL8192E_MAC_ARRAY[RTL8192E_MAC_ARRAY_LEN] = {
 	0x12c, 0xffffffff, 0x04000802,
 	0x318, 0x00000fff, 0x00000100,
 };
+u32 RTL8192E_MAC_ARRAY_LEN = ARRAY_SIZE(RTL8192E_MAC_ARRAY);
 
-u32 RTL8192E_MAC_ARRAY_PG[RTL8192E_MAC_ARRAY_PG_LEN] = {
+u32 RTL8192E_MAC_ARRAY_PG[] = {
 	0x03c, 0xffff0000, 0x00000f0f,
 	0xe00, 0xffffffff, 0x06090909,
 	0xe04, 0xffffffff, 0x00030306,
@@ -354,8 +362,9 @@ u32 RTL8192E_MAC_ARRAY_PG[RTL8192E_MAC_ARRAY_PG_LEN] = {
 	0x12c, 0xffffffff, 0x04000802,
 	0x318, 0x00000fff, 0x00000800,
 };
+u32 RTL8192E_MAC_ARRAY_PG_LEN = ARRAY_SIZE(RTL8192E_MAC_ARRAY_PG);
 
-u32 RTL8192E_AGC_TAB_ARRAY[RTL8192E_AGC_TAB_ARRAY_LEN] = {
+u32 RTL8192E_AGC_TAB_ARRAY[] = {
 	0xc78, 0x7d000001,
 	0xc78, 0x7d010001,
 	0xc78, 0x7d020001,
@@ -549,3 +558,4 @@ u32 RTL8192E_AGC_TAB_ARRAY[RTL8192E_AGC_TAB_ARRAY_LEN] = {
 	0xc78, 0x693e001e,
 	0xc78, 0x6a3f001e,
 };
+u32 RTL8192E_AGC_TAB_ARRAY_LEN = ARRAY_SIZE(RTL8192E_AGC_TAB_ARRAY);
diff --git a/drivers/staging/rtl8192e/rtl8192e/table.h b/drivers/staging/rtl8192e/rtl8192e/table.h
index a80176c47127..233beeec3e65 100644
--- a/drivers/staging/rtl8192e/rtl8192e/table.h
+++ b/drivers/staging/rtl8192e/rtl8192e/table.h
@@ -11,23 +11,23 @@
 
 #include <linux/types.h>
 
-#define RTL8192E_PHY_REG_ARRAY_LEN 1
-extern u32 RTL8192E_PHY_REG_ARRAY[RTL8192E_PHY_REG_ARRAY_LEN];
-#define RTL8192E_PHY_REG_1T2R_ARRAY_LEN 296
-extern u32 RTL8192E_PHY_REG_1T2R_ARRAY[RTL8192E_PHY_REG_1T2R_ARRAY_LEN];
-#define RTL8192E_RADIOA_ARRAY_LEN 246
-extern u32 RTL8192E_RADIOA_ARRAY[RTL8192E_RADIOA_ARRAY_LEN];
-#define RTL8192E_RADIOB_ARRAY_LEN 78
-extern u32 RTL8192E_RADIOB_ARRAY[RTL8192E_RADIOB_ARRAY_LEN];
-#define RTL8192E_RADIOC_ARRAY_LEN 2
-extern u32 RTL8192E_RADIOC_ARRAY[RTL8192E_RADIOC_ARRAY_LEN];
-#define RTL8192E_RADIOD_ARRAY_LEN 2
-extern u32 RTL8192E_RADIOD_ARRAY[RTL8192E_RADIOD_ARRAY_LEN];
-#define RTL8192E_MAC_ARRAY_LEN 18
-extern u32 RTL8192E_MAC_ARRAY[RTL8192E_MAC_ARRAY_LEN];
-#define RTL8192E_MAC_ARRAY_PG_LEN 30
-extern u32 RTL8192E_MAC_ARRAY_PG[RTL8192E_MAC_ARRAY_PG_LEN];
-#define RTL8192E_AGC_TAB_ARRAY_LEN 384
-extern u32 RTL8192E_AGC_TAB_ARRAY[RTL8192E_AGC_TAB_ARRAY_LEN];
+extern u32 RTL8192E_PHY_REG_ARRAY_LEN;
+extern u32 RTL8192E_PHY_REG_ARRAY[];
+extern u32 RTL8192E_PHY_REG_1T2R_ARRAY_LEN;
+extern u32 RTL8192E_PHY_REG_1T2R_ARRAY[];
+extern u32 RTL8192E_RADIOA_ARRAY_LEN;
+extern u32 RTL8192E_RADIOA_ARRAY[];
+extern u32 RTL8192E_RADIOB_ARRAY_LEN;
+extern u32 RTL8192E_RADIOB_ARRAY[];
+extern u32 RTL8192E_RADIOC_ARRAY_LEN;
+extern u32 RTL8192E_RADIOC_ARRAY[];
+extern u32 RTL8192E_RADIOD_ARRAY_LEN;
+extern u32 RTL8192E_RADIOD_ARRAY[];
+extern u32 RTL8192E_MAC_ARRAY_LEN;
+extern u32 RTL8192E_MAC_ARRAY[];
+extern u32 RTL8192E_MAC_ARRAY_PG_LEN;
+extern u32 RTL8192E_MAC_ARRAY_PG[];
+extern u32 RTL8192E_AGC_TAB_ARRAY_LEN;
+extern u32 RTL8192E_AGC_TAB_ARRAY[];
 
 #endif
-- 
2.34.1


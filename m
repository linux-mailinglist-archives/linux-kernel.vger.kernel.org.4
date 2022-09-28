Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576E15EDF0A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 16:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234220AbiI1Onp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 10:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234497AbiI1Oni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 10:43:38 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DB5AE85C
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 07:43:35 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id u24so2870996edb.11
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 07:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=H2TrdYROwP1L2hfid8Uw2/QbMnSXWJgTVN28DiuLGjU=;
        b=jEgXxzUqtTc5XPrM6ffa7w5nIF98pejjznSHooEXUa2tdp9xWVU4qIG1tW5mpiGRNw
         e9qNR1caJvmgugpRMDikADQfG/8J5wmZ4XRvn3fZK77wDW9YXvRW8chGXxzbEPaQatfF
         2Q5JQf+uQ5lObWL+vHX8Aci56A6Tkl4lBFwqEHzsGoEhiCWA6Al3YteD168Jvx91wmvY
         DOFKHxM6u6khXtxi3x/a2LqVpQcOSNQo7Ao3t+/DEiYcnIR5fA3mUyfN88d7wjCakOrT
         1E+pgnX+3ztFIbeexdZR3U6+lru7iIRKA44TRwJ4hZDcD8VLnmwWks9QPcHtBcfaLAMJ
         P3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=H2TrdYROwP1L2hfid8Uw2/QbMnSXWJgTVN28DiuLGjU=;
        b=dCl6h1ssM7zTOOVYu724wtlfHVveH5lt2Mrjkmr7TdjM3uKI+EA3IQihA5k7iMF17v
         T2USddzdLUvFPg37U73/JN0xDYxpW46jF/F9oa6yQRAUvZ7v3tz4wl9V/VZ4bgH+1dZ/
         TxwiwcYSREmQCB2QQkM5bQNRPSSBKiZHf/lecVj13MRGkmybzPYqNMTqtRK8MfW/wuBb
         yu2Li0WTzAm9ORPpiCOZRoB0Z6kfNfwAH59exqGXNfYPE3MzLSCmP3njA7zgGV2myfgu
         95CUYzU1VFpPQqbM04n2i/saoJMxX0dSzIRKMIMmAh/Rf6CzoEDqJcfwaTzlNtxzvKgc
         Xhsw==
X-Gm-Message-State: ACrzQf2uw40LP103lKc9wU94g+0fnn1A73GWI/37cMb20sZLzExoq7AJ
        HiUJ7W3tj2xF/X64cVc7wEc=
X-Google-Smtp-Source: AMsMyM5hf8SsCoqcTY/9v9JLTqv1HFwAveL+9hwJiKq9pH1WzTzzmpD7kOerEyN0aM8yix5lqPf3hQ==
X-Received: by 2002:a05:6402:2549:b0:452:8292:b610 with SMTP id l9-20020a056402254900b004528292b610mr33536545edb.199.1664376214136;
        Wed, 28 Sep 2022 07:43:34 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb59.dynamic.kabel-deutschland.de. [95.90.187.89])
        by smtp.gmail.com with ESMTPSA id u9-20020a50eac9000000b00456c6b4b777sm3456973edp.69.2022.09.28.07.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 07:43:33 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/4] staging: r8188eu: convert ODM_ReadAndConfig_MAC_REG_8188E() to int
Date:   Wed, 28 Sep 2022 16:43:20 +0200
Message-Id: <20220928144323.13164-2-straube.linux@gmail.com>
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

The function ODM_ReadAndConfig_MAC_REG_8188E() has return type
'enum HAL_STATUS'. Convert the return type to int and use common
kernel error logic. Return 0 on success and negative values on
failure. The goal is to get rid of enum HAL_STATUS in the end.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c     | 9 ++++-----
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c       | 2 +-
 drivers/staging/r8188eu/include/HalHWImg8188E_MAC.h | 3 +--
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c b/drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c
index e615bc37c74f..da71867bcca3 100644
--- a/drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c
+++ b/drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c
@@ -131,7 +131,7 @@ static void odm_ConfigMAC_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr, u8 Data
 	rtw_write8(pDM_Odm->Adapter, Addr, Data);
 }
 
-enum HAL_STATUS ODM_ReadAndConfig_MAC_REG_8188E(struct odm_dm_struct *dm_odm)
+int ODM_ReadAndConfig_MAC_REG_8188E(struct odm_dm_struct *dm_odm)
 {
 	#define READ_NEXT_PAIR(v1, v2, i) do { i += 2; v1 = array[i]; v2 = array[i + 1]; } while (0)
 
@@ -144,7 +144,6 @@ enum HAL_STATUS ODM_ReadAndConfig_MAC_REG_8188E(struct odm_dm_struct *dm_odm)
 	struct adapter *adapt =  dm_odm->Adapter;
 	struct xmit_frame	*pxmit_frame = NULL;
 	u8 bndy_cnt = 1;
-	enum HAL_STATUS rst = HAL_STATUS_SUCCESS;
 	hex += ODM_ITRF_USB << 8;
 	hex += ODM_CE << 16;
 	hex += 0xFF000000;
@@ -155,7 +154,7 @@ enum HAL_STATUS ODM_ReadAndConfig_MAC_REG_8188E(struct odm_dm_struct *dm_odm)
 		pxmit_frame = rtw_IOL_accquire_xmit_frame(adapt);
 		if (!pxmit_frame) {
 			pr_info("rtw_IOL_accquire_xmit_frame failed\n");
-			return HAL_STATUS_FAILURE;
+			return -ENOMEM;
 		}
 	}
 
@@ -206,8 +205,8 @@ enum HAL_STATUS ODM_ReadAndConfig_MAC_REG_8188E(struct odm_dm_struct *dm_odm)
 	if (biol) {
 		if (!rtl8188e_IOL_exec_cmds_sync(dm_odm->Adapter, pxmit_frame, 1000, bndy_cnt)) {
 			pr_info("~~~ MAC IOL_exec_cmds Failed !!!\n");
-			rst = HAL_STATUS_FAILURE;
+			return -1;
 		}
 	}
-	return rst;
+	return 0;
 }
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
index 731179635c54..7bcaddc9128b 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
@@ -323,7 +323,7 @@ s32 PHY_MACConfig8188E(struct adapter *Adapter)
 	/*  */
 	/*  Config MAC */
 	/*  */
-	if (HAL_STATUS_FAILURE == ODM_ReadAndConfig_MAC_REG_8188E(&pHalData->odmpriv))
+	if (ODM_ReadAndConfig_MAC_REG_8188E(&pHalData->odmpriv))
 		rtStatus = _FAIL;
 
 	/*  2010.07.13 AMPDU aggregation number B */
diff --git a/drivers/staging/r8188eu/include/HalHWImg8188E_MAC.h b/drivers/staging/r8188eu/include/HalHWImg8188E_MAC.h
index 391c1754b0b6..b3d67c1a8050 100644
--- a/drivers/staging/r8188eu/include/HalHWImg8188E_MAC.h
+++ b/drivers/staging/r8188eu/include/HalHWImg8188E_MAC.h
@@ -7,7 +7,6 @@
 /******************************************************************************
 *                           MAC_REG.TXT
 ******************************************************************************/
-
-enum HAL_STATUS ODM_ReadAndConfig_MAC_REG_8188E(struct odm_dm_struct *pDM_Odm);
+int ODM_ReadAndConfig_MAC_REG_8188E(struct odm_dm_struct *pDM_Odm);
 
 #endif /*  end of HWIMG_SUPPORT */
-- 
2.37.3


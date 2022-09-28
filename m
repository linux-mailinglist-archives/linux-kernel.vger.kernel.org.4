Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4535EDF0B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 16:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234512AbiI1On4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 10:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234476AbiI1Onj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 10:43:39 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA09EAF49B
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 07:43:37 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z13so17503309edb.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 07:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=h0QBqL8bDYRDNQY1NCC3Lk6vT+duKqCdRuYqj6GWkXI=;
        b=QyN+97jyeY7R8iLI/2ntliULvowBQuIoRdx5avccfIQxBNOcjMzC3UOT8KcV1FPVs+
         eITlF6hKTfSKpUtwlVyOZUbjp7ofB5rNaBL2Di3mlzDVQKH5ZEUfj2DgotiNBxRTAkCX
         Teoo8/QbQ0UboNN+BLp1c/nmh+7ZbeFHxt8US4Zx+LcmKCWs7jaWqEQYksxYhqe3xQE0
         II6VirD0i+ZTaGdsv+6elFpbWxa13EuBA9fvxuhCAKfmKGGfZ2ZKu4WLmqKrrfXjpdyW
         vPFeuEE7NDQloDiUKFkS6XRkCPOYNd7GVrROCAc7n9vh4gNuCdIS3AkXeMvQ+lxvCIQv
         BtPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=h0QBqL8bDYRDNQY1NCC3Lk6vT+duKqCdRuYqj6GWkXI=;
        b=xGPU/g06X0M6FTIqoYWub2XcRponR/s+MnwkGPB3rRgGE7IpN49pwh9ePJfAVYlRkN
         GhzFvQ2u9olxbZUjMdJaWlgESYqrc0DAbleN2BZy4QzaMtZUhVaR32jLuh39EdYqRa5A
         Y7IbdpCAEKyKmAc/J3t5/vFH/pFL/tqZEL4BXdTDU1hWBSecOYmfopz5gmxOnTJiR+wJ
         eKWOVgvznW0tjAeO/Hv495Ad1YTt29tURk9G9YJ/7gqD4q3EqmsReGqUf+OeBxsz4eAr
         dchvEDK5sEAvrHTHx84lKJ1yXQ5Ee0vl3dRjTUJRGeZDZrIsB9ye2GI6qChdji6LnUN1
         jNsw==
X-Gm-Message-State: ACrzQf0D70rnBixqxZ2UpuFV5J823jcCXO3wlAdE+Bld7gdiAVffGLBv
        pz0iEI9TtHardthx+3ewZ9s=
X-Google-Smtp-Source: AMsMyM6qc9LlM9+jqiBtZ0HKIGwaR1YU0CC3QqeqNdgKaaj+wiblS2r+PjguN+7gqISLh84Z9icvVw==
X-Received: by 2002:aa7:c58a:0:b0:457:463d:c19d with SMTP id g10-20020aa7c58a000000b00457463dc19dmr16417452edq.323.1664376216170;
        Wed, 28 Sep 2022 07:43:36 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb59.dynamic.kabel-deutschland.de. [95.90.187.89])
        by smtp.gmail.com with ESMTPSA id u9-20020a50eac9000000b00456c6b4b777sm3456973edp.69.2022.09.28.07.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 07:43:35 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/4] staging: r8188eu: convert ODM_ReadAndConfig_AGC_TAB_1T_8188E() to int
Date:   Wed, 28 Sep 2022 16:43:23 +0200
Message-Id: <20220928144323.13164-5-straube.linux@gmail.com>
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

The function ODM_ReadAndConfig_AGC_TAB_1T_8188E() has return type
'enum HAL_STATUS'. Convert the return type to int and use common
kernel error logic. Return 0 on success and negative values on
failure. The enum HAL_STATUS is unused now and we can remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c     | 9 ++++-----
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c      | 2 +-
 drivers/staging/r8188eu/include/HalHWImg8188E_BB.h | 2 +-
 drivers/staging/r8188eu/include/odm_types.h        | 5 -----
 4 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c b/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c
index 8d60eee7ab50..23b7205722b5 100644
--- a/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c
+++ b/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c
@@ -173,7 +173,7 @@ static void odm_ConfigBB_AGC_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr, u32
 	udelay(1);
 }
 
-enum HAL_STATUS ODM_ReadAndConfig_AGC_TAB_1T_8188E(struct odm_dm_struct *dm_odm)
+int ODM_ReadAndConfig_AGC_TAB_1T_8188E(struct odm_dm_struct *dm_odm)
 {
 	u32     hex         = 0;
 	u32     i           = 0;
@@ -183,7 +183,6 @@ enum HAL_STATUS ODM_ReadAndConfig_AGC_TAB_1T_8188E(struct odm_dm_struct *dm_odm)
 	struct adapter *adapter =  dm_odm->Adapter;
 	struct xmit_frame *pxmit_frame = NULL;
 	u8 bndy_cnt = 1;
-	enum HAL_STATUS rst = HAL_STATUS_SUCCESS;
 
 	hex += ODM_ITRF_USB << 8;
 	hex += ODM_CE << 16;
@@ -194,7 +193,7 @@ enum HAL_STATUS ODM_ReadAndConfig_AGC_TAB_1T_8188E(struct odm_dm_struct *dm_odm)
 		pxmit_frame = rtw_IOL_accquire_xmit_frame(adapter);
 		if (!pxmit_frame) {
 			pr_info("rtw_IOL_accquire_xmit_frame failed\n");
-			return HAL_STATUS_FAILURE;
+			return -ENOMEM;
 		}
 	}
 
@@ -245,10 +244,10 @@ enum HAL_STATUS ODM_ReadAndConfig_AGC_TAB_1T_8188E(struct odm_dm_struct *dm_odm)
 	if (biol) {
 		if (!rtl8188e_IOL_exec_cmds_sync(dm_odm->Adapter, pxmit_frame, 1000, bndy_cnt)) {
 			printk("~~~ %s IOL_exec_cmds Failed !!!\n", __func__);
-			rst = HAL_STATUS_FAILURE;
+			return -1;
 		}
 	}
-	return rst;
+	return 0;
 }
 
 /******************************************************************************
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
index f31c1b7a469a..532c63bce0bf 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
@@ -465,7 +465,7 @@ static	int phy_BB8188E_Config_ParaFile(struct adapter *Adapter)
 	}
 
 	/*  3. BB AGC table Initialization */
-	if (HAL_STATUS_FAILURE == ODM_ReadAndConfig_AGC_TAB_1T_8188E(&pHalData->odmpriv))
+	if (ODM_ReadAndConfig_AGC_TAB_1T_8188E(&pHalData->odmpriv))
 		return _FAIL;
 
 	return _SUCCESS;
diff --git a/drivers/staging/r8188eu/include/HalHWImg8188E_BB.h b/drivers/staging/r8188eu/include/HalHWImg8188E_BB.h
index 787fd2cf8d4e..0a290bc31c4d 100644
--- a/drivers/staging/r8188eu/include/HalHWImg8188E_BB.h
+++ b/drivers/staging/r8188eu/include/HalHWImg8188E_BB.h
@@ -10,7 +10,7 @@
 *                           AGC_TAB_1T.TXT
 ******************************************************************************/
 
-enum HAL_STATUS ODM_ReadAndConfig_AGC_TAB_1T_8188E(struct odm_dm_struct *odm);
+int ODM_ReadAndConfig_AGC_TAB_1T_8188E(struct odm_dm_struct *odm);
 
 /******************************************************************************
 *                           PHY_REG_1T.TXT
diff --git a/drivers/staging/r8188eu/include/odm_types.h b/drivers/staging/r8188eu/include/odm_types.h
index 08ba7a418ba8..76302df4b330 100644
--- a/drivers/staging/r8188eu/include/odm_types.h
+++ b/drivers/staging/r8188eu/include/odm_types.h
@@ -6,11 +6,6 @@
 
 #define	ODM_CE			0x04	/* BIT(2) */
 
-enum HAL_STATUS {
-	HAL_STATUS_SUCCESS,
-	HAL_STATUS_FAILURE,
-};
-
 #define SET_TX_DESC_ANTSEL_A_88E(__ptxdesc, __value)			\
 	le32p_replace_bits((__le32 *)(__ptxdesc + 8), __value, BIT(24))
 #define SET_TX_DESC_ANTSEL_B_88E(__ptxdesc, __value)			\
-- 
2.37.3


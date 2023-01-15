Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C1D66B411
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 22:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbjAOVIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 16:08:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbjAOVHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 16:07:53 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECB414488
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 13:07:50 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id v10so37143876edi.8
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 13:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HgoF6Yn8695zBMkTSi4Lbg1WNVYK5ieGNugObJcQ8Z4=;
        b=fBVQUEjrppTt6brIUzcXyf7TbCnuWrZP3D/yM/oPP3cVbVix7Iv7j0KCnV1u626wOG
         serum4zDSVIlU/ObY0dKlbL0Fy3WXR+kdPiWYXUfjcxc1jrquKw+02Ma4DCuwjJqu3hG
         WeVHnyw97ZnXiguZuvBXQB3B1nCLuvoeUpuUZ8u2DtvOOBIj4TtsRZUEqs9nxeKJKIKV
         c1nPw6s0ECJSqDPdTiGRVC6dj7oehlgeIkBmfCt3aYOdhfo0jjxb3j9fwndSIOqdJVZY
         g3cNerpw89r7n2HEYAQF7sbP7ce8PdrU3OUXnmKg57Ml9MBjrjVDBoFLUa2lQm39DUF0
         xgFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HgoF6Yn8695zBMkTSi4Lbg1WNVYK5ieGNugObJcQ8Z4=;
        b=mmOgBEK7+ehQLMBBHXM6MnBuH9NPxPquwPwxJdtU79J3jC0hIn4AKkItAoTkGjZNj2
         0Ozs8fzhuFEtJPz40oveYWyZSZ8Hbo76ibxs6xhvktd6+lHl4V6zJmNBdrYomL6uFozS
         A91XqO/PlQiWjrSLlgaPYoLQ03b51cMwfuZuveHgewk3vD40rpy43os7XjCSt1ChZsse
         qsvJLb2OfTLgP9W96wJP/rZ1HwQpxC1MHF0Q5jaIllIjdnAA4CohEEnmiw63anS3IEQX
         yWEq+FOmVxKLBmduLSGcSW/WK2qr+z61nJACmurGU0+BMz+15qjKUFhCieFubVoFWN/+
         6S9A==
X-Gm-Message-State: AFqh2krCq+V/Z81HeaJuzYl2ZgPlKo6ib8R7nDko1QDzzWVpoAtHXitK
        AqrlbkJend1hJBFKoomaCl8=
X-Google-Smtp-Source: AMrXdXtuO3WzQ6xrAKfcFd7vfCH6z/n8acSWH1cTRINwJVZ8NrNfRrrzX+HyjBCojwe+VtIP1/baOg==
X-Received: by 2002:a05:6402:48d:b0:46f:d386:117d with SMTP id k13-20020a056402048d00b0046fd386117dmr7427368edv.33.1673816868693;
        Sun, 15 Jan 2023 13:07:48 -0800 (PST)
Received: from localhost.localdomain (ip5f5abbb0.dynamic.kabel-deutschland.de. [95.90.187.176])
        by smtp.gmail.com with ESMTPSA id a11-20020aa7d74b000000b0049e08f781e3sm1010421eds.3.2023.01.15.13.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jan 2023 13:07:48 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/4] staging: r8188eu: convert PHY_BBConfig8188E() to common error logic
Date:   Sun, 15 Jan 2023 22:07:34 +0100
Message-Id: <20230115210734.18610-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230115210734.18610-1-straube.linux@gmail.com>
References: <20230115210734.18610-1-straube.linux@gmail.com>
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

Convert the function PHY_BBConfig8188E() away from returning _FAIL or
_SUCCESS which uses inverted error logic. Use the common error logic
instead. Return 0 for success and negative values for failure.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c | 14 ++++++--------
 drivers/staging/r8188eu/hal/usb_halinit.c     |  5 ++---
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
index c52af93f1669..f4edf4a8f5c2 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
@@ -478,18 +478,17 @@ PHY_BBConfig8188E(
 		struct adapter *Adapter
 	)
 {
-	int	rtStatus = _SUCCESS;
 	struct hal_data_8188e *pHalData = &Adapter->haldata;
 	u16 RegVal;
 	u8 CrystalCap;
-	int res;
+	int err;
 
 	phy_InitBBRFRegisterDefinition(Adapter);
 
 	/*  Enable BB and RF */
-	res = rtw_read16(Adapter, REG_SYS_FUNC_EN, &RegVal);
-	if (res)
-		return _FAIL;
+	err = rtw_read16(Adapter, REG_SYS_FUNC_EN, &RegVal);
+	if (err)
+		return err;
 
 	rtw_write16(Adapter, REG_SYS_FUNC_EN, (u16)(RegVal | BIT(13) | BIT(0) | BIT(1)));
 
@@ -500,14 +499,13 @@ PHY_BBConfig8188E(
 	rtw_write8(Adapter, REG_SYS_FUNC_EN, FEN_USBA | FEN_USBD | FEN_BB_GLB_RSTn | FEN_BBRSTB);
 
 	/*  Config BB and AGC */
-	if (phy_BB8188E_Config_ParaFile(Adapter))
-		rtStatus = _FAIL;
+	err = phy_BB8188E_Config_ParaFile(Adapter);
 
 	/*  write 0x24[16:11] = 0x24[22:17] = CrystalCap */
 	CrystalCap = pHalData->CrystalCap & 0x3F;
 	rtl8188e_PHY_SetBBReg(Adapter, REG_AFE_XTAL_CTRL, 0x7ff800, (CrystalCap | (CrystalCap << 6)));
 
-	return rtStatus;
+	return err;
 }
 
 static void getTxPowerIndex88E(struct adapter *Adapter, u8 channel, u8 *cckPowerLevel,
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index cb36b42c5ecc..b7c9e5fd9a59 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -606,9 +606,8 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	/*  */
 	/* d. Initialize BB related configurations. */
 	/*  */
-	status = PHY_BBConfig8188E(Adapter);
-	if (status == _FAIL)
-		goto exit;
+	if (PHY_BBConfig8188E(Adapter))
+		return _FAIL;
 
 	if (phy_RF6052_Config_ParaFile(Adapter))
 		return _FAIL;
-- 
2.39.0


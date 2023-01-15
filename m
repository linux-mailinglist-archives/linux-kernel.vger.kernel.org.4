Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C015B66B40F
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 22:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjAOVH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 16:07:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjAOVHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 16:07:51 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D901449E
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 13:07:48 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id w14so21034180edi.5
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 13:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rl6qXidu5WIs9nfrJNjX3YLrFPQ+UzUlEvm+lb6ejX8=;
        b=aGSmoHCRnDPbu3N95+i267CwF+b32AnPcEYIvug5tlCBNTeM1W0fglKna1UmjjojvN
         crchnx4bR1DHF+8hMK4nPuHuLaLtBd5bDrq43Ki+7s0mlvNHp05bd82W50uZzKWXDqWi
         eUdTI8NoEIyb8BZikP7ML3RywovN2V8hr6o9EeDpdxOaH+94Ev+x+Rf2PJ8KfhDYmsby
         LzKgWWj2OVxe9kbfYq+Hrtw+eR9fje64hc5a33K1qIMcbImqxqDxEPRC0LOXI5ztwu2B
         ArN5ZR2yH4iI8gi6cIo919g3GKBxp0kR3l2OJ50v8E6xcMzgx8d7zrviJwKk0071V2lO
         ay8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rl6qXidu5WIs9nfrJNjX3YLrFPQ+UzUlEvm+lb6ejX8=;
        b=ctxIhE5F92sdESM6H36N9AGDpYZ2Jde4xrtsQB+vjbbkoPi5OpS+9UGe91RUk5jLWe
         i0RgyPA1/O3aEiGlW0wc3ZTypiVmHIs58gr9CcqWAaCrThzOjjfuIIb0GRxuBtvDbc6D
         pVx/alpktMrUFxiNHw2UXJsF/6OrhLgyRDoh2o+mCuDVSiZJ1Rq7zFCl4HD1moNgTGXh
         fAclpRufG+n2fTUAj/fzdO5aAJmhkLKGrUniwGONPzwz1XpfkrdfM0HS3xUvKEA6uHtJ
         PC3VTs+tK89bYv6ei26HRBVJAu8lkEGqyhgvVe/Z03bCDdJwg9t32k6n4pIFIqbm+n/6
         Os7w==
X-Gm-Message-State: AFqh2kpk949H6y/vnkBtLE3lVqdBh9PKfzrLMU5zr2PCrBdXgMe4F3fv
        OJUURdrxHEW9Jgo77phhhYM=
X-Google-Smtp-Source: AMrXdXufqCOOueR+Yc/0f6cIbPCMMF9bsP5YeESLYnR0rHZm/SLRRRVF1ctzhqOi0jfj9Yy6Sg22Yw==
X-Received: by 2002:a05:6402:380d:b0:47e:eaae:9a5b with SMTP id es13-20020a056402380d00b0047eeaae9a5bmr76135871edb.42.1673816867306;
        Sun, 15 Jan 2023 13:07:47 -0800 (PST)
Received: from localhost.localdomain (ip5f5abbb0.dynamic.kabel-deutschland.de. [95.90.187.176])
        by smtp.gmail.com with ESMTPSA id a11-20020aa7d74b000000b0049e08f781e3sm1010421eds.3.2023.01.15.13.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jan 2023 13:07:47 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/4] staging: r8188eu: convert phy_RF6052_Config_ParaFile() to common error logic
Date:   Sun, 15 Jan 2023 22:07:32 +0100
Message-Id: <20230115210734.18610-3-straube.linux@gmail.com>
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

Convert the function phy_RF6052_Config_ParaFile() away from returning
_FAIL or _SUCCESS which uses inverted error logic. Use the common error
logic instead. Return 0 for success and negative values for failure.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_rf6052.c | 7 +++----
 drivers/staging/r8188eu/hal/usb_halinit.c     | 5 ++---
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c b/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
index e5ec6e563fbd..1988fb6e780a 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
@@ -371,7 +371,7 @@ int phy_RF6052_Config_ParaFile(struct adapter *Adapter)
 	struct bb_reg_def *pPhyReg;
 	struct hal_data_8188e *pHalData = &Adapter->haldata;
 	u32 u4RegValue = 0;
-	int rtStatus = _SUCCESS;
+	int err;
 
 	/* Initialize RF */
 
@@ -396,11 +396,10 @@ int phy_RF6052_Config_ParaFile(struct adapter *Adapter)
 	udelay(1);/* PlatformStallExecution(1); */
 
 	/*----Initialize RF fom connfiguration file----*/
-	if (ODM_ReadAndConfig_RadioA_1T_8188E(&pHalData->odmpriv))
-		rtStatus = _FAIL;
+	err = ODM_ReadAndConfig_RadioA_1T_8188E(&pHalData->odmpriv);
 
 	/*----Restore RFENV control type----*/;
 	rtl8188e_PHY_SetBBReg(Adapter, pPhyReg->rfintfs, bRFSI_RFENV, u4RegValue);
 
-	return rtStatus;
+	return err;
 }
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 9ba6a526e90d..cb36b42c5ecc 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -610,9 +610,8 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	if (status == _FAIL)
 		goto exit;
 
-	status = phy_RF6052_Config_ParaFile(Adapter);
-	if (status == _FAIL)
-		goto exit;
+	if (phy_RF6052_Config_ParaFile(Adapter))
+		return _FAIL;
 
 	status = rtl8188e_iol_efuse_patch(Adapter);
 	if (status == _FAIL)
-- 
2.39.0


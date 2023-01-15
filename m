Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF14666B40D
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 22:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbjAOVHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 16:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbjAOVHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 16:07:50 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215531448B
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 13:07:48 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id ud5so63904326ejc.4
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 13:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+5N1rXSfVPzLU7ZKBzI7cYGDRpk01puVVQT6NPAi1o=;
        b=jcN9F7eXKvSGmUgLLg6dzI3dRFBeoFJsef5UJB/M15r6NhBJER1HOfqzotw2DxpKXO
         vX5zrtjhrccQEuBUR07GhVUzObjfbuUfUhPHW48PAjR2imZH6M81m7W9I5DXoS2jFN9Y
         a6PtqYC8nlgCirn+hafNwZXAbuLWGl3JF13HulCDSNctv+uZaK0c0XvMmqzI6MpOkdbO
         1TNKHuq5hQZUE7QW1RbmKmdjbnGmEMgqnUb6b4cVkGBzj+OhNjqhRi6n09MkfsDSdpVe
         o7hOe6rGLh1oNQZggDdQDhve8M7q5+2WoNCohdNbzUqUVqmr9s9+G0AHSwCyRjIuPAGu
         2IqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U+5N1rXSfVPzLU7ZKBzI7cYGDRpk01puVVQT6NPAi1o=;
        b=4SCdR6+P9OoWgvq4W/VrTIGtlvVviB2AYKCI6dxi4jR4dSPohmjCG3Js/lEzVC1wZU
         wEcHbblQt3EE3i6df7UIaokE0TzzUPB+PaB+rHmxr9KW6TAEB5h5nQzWoiQU9Ii1FYUs
         tU+9FAjQjpfhbMKhYOrOBWbVj0v6yjTMdSYcbO1U4sqMsOa5/SAMxPNkEtadPKVvE66J
         mCnpkS9E0KldOb7oLtNJ9HG4AxPP3EFkB7HL7uXJAND2cP/Nv8DiefkUhaK/FWkt+nlt
         N+KiB7x6jFULg0NgKnUxwWvbTaSv2N8O7em4yjC8y3w0d8VQNn2AmAqSEK7n8qVzq9b/
         75yA==
X-Gm-Message-State: AFqh2koXTbP+Q61Ys7gh69aAr/ErvMrXlYTu9V+GL8Fc6AqrDwZXR0qm
        dRyiEK7OoIjvTtmmKnOphS0=
X-Google-Smtp-Source: AMrXdXst4D2SRJG02W2JtgxucFf+eXdtI3QE0xU5NO4BcY0cLVtjS+Pc/v+KPVRLGsBqZVFr5JY7iA==
X-Received: by 2002:a17:907:3e26:b0:839:74cf:7c4f with SMTP id hp38-20020a1709073e2600b0083974cf7c4fmr103277586ejc.8.1673816866654;
        Sun, 15 Jan 2023 13:07:46 -0800 (PST)
Received: from localhost.localdomain (ip5f5abbb0.dynamic.kabel-deutschland.de. [95.90.187.176])
        by smtp.gmail.com with ESMTPSA id a11-20020aa7d74b000000b0049e08f781e3sm1010421eds.3.2023.01.15.13.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jan 2023 13:07:46 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/4] staging: r8188eu: convert PHY_MACConfig8188E() to common error logic
Date:   Sun, 15 Jan 2023 22:07:31 +0100
Message-Id: <20230115210734.18610-2-straube.linux@gmail.com>
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

Convert the function PHY_MACConfig8188E() away from returning _FAIL or
_SUCCESS which uses inverted error logic. Use the common error logic
instead. Return 0 for success and negative values for failure.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c | 9 ++++-----
 drivers/staging/r8188eu/hal/usb_halinit.c     | 5 ++---
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
index b7f3c7a670fb..204c1c30377b 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
@@ -315,21 +315,20 @@ rtl8188e_PHY_SetRFReg(
  *  08/12/2008	MHC		Create Version 0.
  *
  *---------------------------------------------------------------------------*/
-s32 PHY_MACConfig8188E(struct adapter *Adapter)
+int PHY_MACConfig8188E(struct adapter *Adapter)
 {
 	struct hal_data_8188e *pHalData = &Adapter->haldata;
-	int rtStatus = _SUCCESS;
+	int err;
 
 	/*  */
 	/*  Config MAC */
 	/*  */
-	if (ODM_ReadAndConfig_MAC_REG_8188E(&pHalData->odmpriv))
-		rtStatus = _FAIL;
+	err = ODM_ReadAndConfig_MAC_REG_8188E(&pHalData->odmpriv);
 
 	/*  2010.07.13 AMPDU aggregation number B */
 	rtw_write16(Adapter, REG_MAX_AGGR_NUM, MAX_AGGR_NUM);
 
-	return rtStatus;
+	return err;
 }
 
 /**
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index d28b4dc2a767..9ba6a526e90d 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -600,9 +600,8 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	Adapter->pwrctrlpriv.bFwCurrentInPSMode = false;
 	haldata->LastHMEBoxNum = 0;
 
-	status = PHY_MACConfig8188E(Adapter);
-	if (status == _FAIL)
-		goto exit;
+	if (PHY_MACConfig8188E(Adapter))
+		return _FAIL;
 
 	/*  */
 	/* d. Initialize BB related configurations. */
-- 
2.39.0


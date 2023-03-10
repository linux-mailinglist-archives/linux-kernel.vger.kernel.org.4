Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A27D6B38D5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 09:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjCJIfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 03:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjCJIfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 03:35:13 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9F662D88
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 00:35:10 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id ec29so17358921edb.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 00:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678437309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oFs/e/K/gilrBIUS/3vF7+owOyPjJYDXNevbCxgiE/4=;
        b=RBkobFKJ41nf/fAPlQny3VRJNwdx8fMPH4lp5Z454gp+GwXUmlPcJuYgMoYmBq2a5N
         U37LQ2hsJ8LRI/fJFR/ctcpJIIeIJg6LzQTB7lMCzM/wUDtN1E/6TmFG+4FlPJ16w+Ir
         Z+KTbWNcggIOfMBWwUKuNgMC6ZInlEyST4ZsCMeaU68ZTSlVg97/Wzz/jJf+tkDknIBb
         +wVAWiEQUyP+spNrrcXCmczq06tzSyhWG0wKAnNtmGFZno/hgtDP4DYnTAvdtCyZoKzc
         qrEZRS/CxTmg0EAre8rcOxwkojquYa1OQvyxyy2skXFPoS1lZGeubw2/kYqyBlpOy6tA
         8zlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678437309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oFs/e/K/gilrBIUS/3vF7+owOyPjJYDXNevbCxgiE/4=;
        b=7x9vZEJJ9sRD6NSaMJegSgjvnjTMupwQ6cZvV7+HwQFCIKnDGp0A/2NDRPUuDSocO9
         CjQhfrZLSK29PiDUD/yqLbruGNWotJ4volM2zrUKu/cIU7mXXOixi/ckfiXCtsiirPJP
         brgM9/lek0HD4wQps6fDI7vFURVYNm2kTumTELpzgAVJklaevhLC5hA+951T+wnCs2Er
         9yD8bRwW/YggQ1ByhEFrdEbWdN/4l7jHxSOY17oGUN+v/at005+/eqDEovW9YVMp3J9F
         Jz+ZFBHFL9Isxr1O4CHAw+xx/MY3rGkWLmu6Ge6wbKVtZEBe1sx4p9/tTBRsLZE685fq
         LcUQ==
X-Gm-Message-State: AO0yUKXgLQqzb9l3UCTOfBBdrZp/dC8Zmdk9+HTxjHp1HvPFC9AzYYu6
        BWCB6rZCRuJIAwHZLL5f1cw=
X-Google-Smtp-Source: AK7set+1UXSQl+SRqmOeFWItIcmJaep95cXb1ps44FVISlcj/OWnPtRPQ4M8UE5ZmeungxVUnuDKmQ==
X-Received: by 2002:a17:906:fcb2:b0:8aa:c105:f0bf with SMTP id qw18-20020a170906fcb200b008aac105f0bfmr28935468ejb.17.1678437308902;
        Fri, 10 Mar 2023 00:35:08 -0800 (PST)
Received: from localhost.localdomain (ip5f5abbd3.dynamic.kabel-deutschland.de. [95.90.187.211])
        by smtp.gmail.com with ESMTPSA id h10-20020a17090619ca00b008ce5b426d77sm697888ejd.13.2023.03.10.00.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 00:35:08 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/5] staging: rtl8723bs: linked_info_dump() is not used
Date:   Fri, 10 Mar 2023 09:34:48 +0100
Message-Id: <20230310083449.23775-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230310083449.23775-1-straube.linux@gmail.com>
References: <20230310083449.23775-1-straube.linux@gmail.com>
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

The function linked_info_dump() is not used anywhere, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_com.c     | 21 ---------------------
 drivers/staging/rtl8723bs/include/hal_com.h |  1 -
 2 files changed, 22 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_com.c b/drivers/staging/rtl8723bs/hal/hal_com.c
index da68557c5b20..792636fe3270 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com.c
@@ -897,27 +897,6 @@ void rtw_hal_check_rxfifo_full(struct adapter *adapter)
 	}
 }
 
-void linked_info_dump(struct adapter *padapter, u8 benable)
-{
-	struct pwrctrl_priv *pwrctrlpriv = adapter_to_pwrctl(padapter);
-
-	if (padapter->bLinkInfoDump == benable)
-		return;
-
-	if (benable) {
-		pwrctrlpriv->org_power_mgnt = pwrctrlpriv->power_mgnt;/* keep org value */
-		rtw_pm_set_lps(padapter, PS_MODE_ACTIVE);
-
-		pwrctrlpriv->ips_org_mode = pwrctrlpriv->ips_mode;/* keep org value */
-		rtw_pm_set_ips(padapter, IPS_NONE);
-	} else {
-		rtw_pm_set_ips(padapter, pwrctrlpriv->ips_org_mode);
-
-		rtw_pm_set_lps(padapter, pwrctrlpriv->ips_org_mode);
-	}
-	padapter->bLinkInfoDump = benable;
-}
-
 #ifdef DBG_RX_SIGNAL_DISPLAY_RAW_DATA
 void rtw_get_raw_rssi_info(void *sel, struct adapter *padapter)
 {
diff --git a/drivers/staging/rtl8723bs/include/hal_com.h b/drivers/staging/rtl8723bs/include/hal_com.h
index 839d93d8a1df..c1aa7f0a35f9 100644
--- a/drivers/staging/rtl8723bs/include/hal_com.h
+++ b/drivers/staging/rtl8723bs/include/hal_com.h
@@ -149,7 +149,6 @@ bool eqNByte(u8 *str1, u8 *str2, u32 num);
 
 bool GetU1ByteIntegerFromStringInDecimal(char *str, u8 *in);
 
-void linked_info_dump(struct adapter *padapter, u8 benable);
 #ifdef DBG_RX_SIGNAL_DISPLAY_RAW_DATA
 void rtw_get_raw_rssi_info(void *sel, struct adapter *padapter);
 void rtw_store_phy_info(struct adapter *padapter, union recv_frame *prframe);
-- 
2.39.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4DFB5F21C3
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 09:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiJBHtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 03:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiJBHsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 03:48:54 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7722AE1D
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 00:48:50 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id c93so2054483edf.11
        for <linux-kernel@vger.kernel.org>; Sun, 02 Oct 2022 00:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=PQPZkn7E5IjiLWsvX5daUSv5IaF5YUgb6ZmfCxE/RZQ=;
        b=ZrGFv4b2DSYT5IqxyTQV6K+cYO43+OVSR1ZWMZJuvFAGqI0NmptJj+Z6x2AQtZOjUD
         lYBMiKS0GaxM1YygX6HIYW+II+2kSiR6aT+hcdfg5PKXY+AZX1l1pINWukruQW5SZBAn
         aGtK7FpfncUs1rxIgusSpUpGvIDKriOeBXyvWjnTq81VZBFEz9F7UXuGjb4X1mg1i4Zr
         FndW2PsjTolR9jG/jbWBiUIeBHXkElQur/4OF4NnKpQ/VvZNXhnID159e7PYGM9YCWPQ
         8drgIIgM44WtoYLjBDkK8clu0ZgjS5trJ8trCfFeRIGXr8jDuH5Yzi/8qLs8WO195mmg
         6QPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=PQPZkn7E5IjiLWsvX5daUSv5IaF5YUgb6ZmfCxE/RZQ=;
        b=SCAYpu4eGpjfFp1BSuzg9nLPPfzf0o4xojRBfh2MXyQBV4sjbxSEOCh3SAHxUs+r7g
         lgWE9nRaxYgaYKS0WiaQrhJWm1bb+gHKXjQKFKtUkm5+kBRX3eSxYJiCrrW9GItQl1Pl
         xx7Iup7J3mA11YiqrQuKyj1WG6QNNO6DZfEUZ9HGaTa4FhX0yigQO/YhkLppMLQUDY0H
         C3tRwrFClXYO7Mzf5Byb+dN1jlT+QDmkfAs1WWRDaE/ra8prsiQdBbx1emduNqe/nZfi
         0IaWllH7tIAJeNwNgxylGCfHPI0dm+MTxmS/XytWJmGbto6VSshBpOgJ29S22c1IS9UC
         z8vQ==
X-Gm-Message-State: ACrzQf2HlEbDiWDHrgKwiAILVvGoIM2748uFVeJ4ynupAx33jQJNNDmf
        bSP05aIRgvaoxPCZw23WdZY=
X-Google-Smtp-Source: AMsMyM7ZRWsWpq6K7vtK3ZZdsgqx0pVubQ570QaJcYyengIesZq4nhM1VWgrAV0/f3zPOYYiKlRUsw==
X-Received: by 2002:a05:6402:557:b0:458:7488:8958 with SMTP id i23-20020a056402055700b0045874888958mr9907041edx.242.1664696929291;
        Sun, 02 Oct 2022 00:48:49 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb59.dynamic.kabel-deutschland.de. [95.90.187.89])
        by smtp.gmail.com with ESMTPSA id q26-20020a17090676da00b0077ce503bd77sm3608536ejn.129.2022.10.02.00.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Oct 2022 00:48:49 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/5] staging: r8188eu: convert rtw_init_mlme_priv() to common error logic
Date:   Sun,  2 Oct 2022 09:48:26 +0200
Message-Id: <20221002074827.8566-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221002074827.8566-1-straube.linux@gmail.com>
References: <20221002074827.8566-1-straube.linux@gmail.com>
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

Convert the function rtw_init_mlme_priv() to common kernel error logic.
Return 0 on success and negative value on failure. This is part of
getting rid of returning _SUCCESS and _FAIL which uses inverted error
logic and is used all over the driver.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme.c   | 12 ++++--------
 drivers/staging/r8188eu/os_dep/os_intfs.c |  2 +-
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 5ca03d6cac32..1f69e5c57d5d 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -224,7 +224,6 @@ int rtw_init_mlme_priv(struct adapter *padapter)/* struct	mlme_priv *pmlmepriv)
 	u8	*pbuf;
 	struct wlan_network	*pnetwork;
 	struct mlme_priv		*pmlmepriv = &padapter->mlmepriv;
-	int	res = _SUCCESS;
 
 	/*  We don't need to memset padapter->XXX to zero, because adapter is allocated by vzalloc(). */
 
@@ -245,10 +244,9 @@ int rtw_init_mlme_priv(struct adapter *padapter)/* struct	mlme_priv *pmlmepriv)
 
 	pbuf = vzalloc(MAX_BSS_CNT * (sizeof(struct wlan_network)));
 
-	if (!pbuf) {
-		res = _FAIL;
-		goto exit;
-	}
+	if (!pbuf)
+		return -ENOMEM;
+
 	pmlmepriv->free_bss_buf = pbuf;
 
 	pnetwork = (struct wlan_network *)pbuf;
@@ -265,9 +263,7 @@ int rtw_init_mlme_priv(struct adapter *padapter)/* struct	mlme_priv *pmlmepriv)
 
 	rtw_init_mlme_timer(padapter);
 
-exit:
-
-	return res;
+	return 0;
 }
 
 void rtw_free_mlme_priv(struct mlme_priv *pmlmepriv)
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index 490e0c7dc034..d8b8a5291e40 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -473,7 +473,7 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
 		goto free_cmd_priv;
 	}
 
-	if (rtw_init_mlme_priv(padapter) == _FAIL) {
+	if (rtw_init_mlme_priv(padapter)) {
 		dev_err(dvobj_to_dev(padapter->dvobj), "rtw_init_mlme_priv failed\n");
 		goto free_evt_priv;
 	}
-- 
2.37.3


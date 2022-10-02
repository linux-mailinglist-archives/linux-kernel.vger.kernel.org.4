Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD035F21C4
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 09:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiJBHtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 03:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiJBHsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 03:48:54 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537882AE26
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 00:48:51 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id bj12so16629135ejb.13
        for <linux-kernel@vger.kernel.org>; Sun, 02 Oct 2022 00:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=VnF8lssJzqyw2+RAZUEdl7sARBhzjYhR50rZlgAc+Sc=;
        b=AgsVf+ypiATLgkFdL8xTjahYAFDUBpIrGcSiOhVz2XeAR17fVjssXQcRr7YCUxRAF7
         +Z7mKeB0oNvkkoeURFF3GynBOt0gkGbSRYnk0eq3U+KLBhAfSlJh17X3bj44MZSO8Dz7
         +WrZSJyAZCFXuXxx8clxSiEcxUweR2+teNDPEq+mj5UTAPnxed8gCXDHo+Dgx6bInhcQ
         T856Sh6ZTfqQDGSKjDTDjzqEVLVXVPE71ntc0NHlKByniY2gpS5cA34FhzeuCYjnk7cn
         1ZOrdk3ozEtKpOh6hmCBFjyveP7gfLOTONmROZ7PyC59P6WSf7Ko8ugbkhub7KQ/flUF
         zp6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=VnF8lssJzqyw2+RAZUEdl7sARBhzjYhR50rZlgAc+Sc=;
        b=2c8syxjtD8ImOpqSVY6g6tNZX9yiOZyqdA305IeLQ31yVsLCOXDYdvT4RYxgq3uMwk
         q5DEsch2GOtj6rvO59IRuL0souIHExXr5CeKwxqE6RUMrs5PV6PWlG5L4rYy3hZsS8WZ
         Ykasz+UlkC05Qqxq+RE0X/r3eQAzlNa5pptt4KhErGnEEWxMsAn7vHY0zj2ytA057+vo
         0YVgsRAF1je4WEg+yXv5bamFPfTsf4E3XUtUWe6IaXyo9iEvb8rjwKqnpuV6zyaTv6QX
         AZQPoTyB37Uwa7sHSKGH0eiWqH3ykf/KssGmgTWZlYr2VJhjhQDSDI1SKpEzDNRMku/q
         s4nw==
X-Gm-Message-State: ACrzQf1jE875laN3YPY83IQDlD4/0PNRvI4SBF/+mQe/0keRdXzYvXeL
        zf0L7nkp+mb76W56s0LrzZw=
X-Google-Smtp-Source: AMsMyM5Bj6mtOlkggNTfJbCLk9+jkGnGUlknm89bkPnTp4ivZGdb10+Kl4mKjdBqxWkgkrebOAmlMQ==
X-Received: by 2002:a17:906:fe45:b0:788:15a5:7495 with SMTP id wz5-20020a170906fe4500b0078815a57495mr7230253ejb.633.1664696929878;
        Sun, 02 Oct 2022 00:48:49 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb59.dynamic.kabel-deutschland.de. [95.90.187.89])
        by smtp.gmail.com with ESMTPSA id q26-20020a17090676da00b0077ce503bd77sm3608536ejn.129.2022.10.02.00.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Oct 2022 00:48:49 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 5/5] staging: r8188eu: convert _rtw_init_sta_priv() to common error logic
Date:   Sun,  2 Oct 2022 09:48:27 +0200
Message-Id: <20221002074827.8566-6-straube.linux@gmail.com>
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

Convert the function _rtw_init_sta_priv() to common kernel error logic.
Return 0 on success and negative value on failure. This is part of
getting rid of returning _SUCCESS and _FAIL which uses inverted error
logic and is used all over the driver.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_sta_mgt.c | 6 +++---
 drivers/staging/r8188eu/include/sta_info.h | 2 +-
 drivers/staging/r8188eu/os_dep/os_intfs.c  | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_sta_mgt.c b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
index 98eeb16cab6c..bbde5c03f9ae 100644
--- a/drivers/staging/r8188eu/core/rtw_sta_mgt.c
+++ b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
@@ -45,7 +45,7 @@ static void _rtw_init_stainfo(struct sta_info *psta)
 	psta->keep_alive_trycnt = 0;
 }
 
-u32	_rtw_init_sta_priv(struct	sta_priv *pstapriv)
+int _rtw_init_sta_priv(struct sta_priv *pstapriv)
 {
 	struct sta_info *psta;
 	s32 i;
@@ -53,7 +53,7 @@ u32	_rtw_init_sta_priv(struct	sta_priv *pstapriv)
 	pstapriv->pallocated_stainfo_buf = vzalloc(sizeof(struct sta_info) * NUM_STA + 4);
 
 	if (!pstapriv->pallocated_stainfo_buf)
-		return _FAIL;
+		return -ENOMEM;
 
 	pstapriv->pstainfo_buf = pstapriv->pallocated_stainfo_buf + 4 -
 		((size_t)(pstapriv->pallocated_stainfo_buf) & 3);
@@ -93,7 +93,7 @@ u32	_rtw_init_sta_priv(struct	sta_priv *pstapriv)
 	pstapriv->expire_to = 3; /*  3*2 = 6 sec */
 	pstapriv->max_num_sta = NUM_STA;
 
-	return _SUCCESS;
+	return 0;
 }
 
 inline int rtw_stainfo_offset(struct sta_priv *stapriv, struct sta_info *sta)
diff --git a/drivers/staging/r8188eu/include/sta_info.h b/drivers/staging/r8188eu/include/sta_info.h
index 4112c837bcef..f76e086b5701 100644
--- a/drivers/staging/r8188eu/include/sta_info.h
+++ b/drivers/staging/r8188eu/include/sta_info.h
@@ -295,7 +295,7 @@ static inline u32 wifi_mac_hash(u8 *mac)
 	return x;
 }
 
-extern u32	_rtw_init_sta_priv(struct sta_priv *pstapriv);
+extern int _rtw_init_sta_priv(struct sta_priv *pstapriv);
 extern void _rtw_free_sta_priv(struct sta_priv *pstapriv);
 
 #define stainfo_offset_valid(offset) (offset < NUM_STA && offset >= 0)
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index d8b8a5291e40..e43ef7e5ba70 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -494,7 +494,7 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
 		goto free_xmit_priv;
 	}
 
-	if (_rtw_init_sta_priv(&padapter->stapriv) == _FAIL) {
+	if (_rtw_init_sta_priv(&padapter->stapriv)) {
 		dev_err(dvobj_to_dev(padapter->dvobj), "_rtw_init_sta_priv failed\n");
 		goto free_recv_priv;
 	}
-- 
2.37.3


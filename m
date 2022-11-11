Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A89625576
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 09:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233236AbiKKIiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 03:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233194AbiKKIhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 03:37:50 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38072654DB
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 00:37:49 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id f5so11045043ejc.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 00:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4UYmpKHsIr2qFT7M5inAn4KP/0IUYZikxzDGvUZY1YE=;
        b=UQrzctyhSUruz7hukRcYiRergxj/lpzlJuqn9IYYCx8q8WcTX11QIA1Z2iEUcFt0gd
         GGrTTrNXaKpl9NdH6YqI0knvp1Bkdfh2lR2B2m8VYsQM+N48RKipOeF2348z0XToU7qY
         gbUiOYN6juqY1ITOusxq81EZ6HdxfYMjssineB6fCS5O95IMlMb+DMNeRpBLZD18+Ia2
         DC2Wo30qij3bKu0yc6YK6zcC6sgqk2ABtiQNlsJ/ajBDgiVXPEKHkf3aOUgrNu33RQDO
         HWTG83PvAM6lchc/LG3rrcnXFYSk1GZkD8asBbaQSuO6RxxGJhROJEqcOLw7bOvN1S/7
         cV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4UYmpKHsIr2qFT7M5inAn4KP/0IUYZikxzDGvUZY1YE=;
        b=vMJ1FPiE8Eo9s45d15IusnXorV/L1yuqBZmbgn3Qtx/9Kbtr6F8IbXrB9sy+QSwwbw
         j43DBNjIIQR4rlnJHKK4j2YfQrFdASGpp4nNqmWtVNsCnoYlYeXRgvpHrdXUmEc7xH3N
         Fho81YW/6a6YnGKU2fzdY7FGDvUtRkrXMvS6qQAYt7h5T66uSiC1t5o/JJpFbkD4EJPo
         WVX/JwMbg1MGQ6Um9ZOwDMFFNK1xQXJqQH5BmpABq0h4IoBUjz1KoGJq0h1tave4s/9L
         2sf0C6dp2i1U1sbZqDWGGUom33wa9VxuRWT3azBR0NFFJgjRnWlevgR8E0euwU61yn29
         13LQ==
X-Gm-Message-State: ANoB5pm6fGTQlqKEuLEmxrZ7iUH9TGuJU4gQice405IyUJsHrhXH8Sv+
        QY0wyeT3lkeG4y3eM+fGmNg=
X-Google-Smtp-Source: AA0mqf4qf1donTG8dSx7WM1waQY5qdS0lfSeMO4R2GESQE+fh8uIQOz13i3oUvfL5zJ3pqvFhIZQBA==
X-Received: by 2002:a17:906:5e05:b0:7ae:21bc:89f0 with SMTP id n5-20020a1709065e0500b007ae21bc89f0mr1089186eju.132.1668155867840;
        Fri, 11 Nov 2022 00:37:47 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb9a.dynamic.kabel-deutschland.de. [95.90.187.154])
        by smtp.gmail.com with ESMTPSA id b2-20020a1709063ca200b007ae566edb8bsm643190ejh.73.2022.11.11.00.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 00:37:47 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/4] staging: r8188eu: convert _rtw_init_xmit_priv() to common error logic
Date:   Fri, 11 Nov 2022 09:37:32 +0100
Message-Id: <20221111083733.3144-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221111083733.3144-1-straube.linux@gmail.com>
References: <20221111083733.3144-1-straube.linux@gmail.com>
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

Convert the function _rtw_init_xmit_priv() away from returning _FAIL
or _SUCCESS which uses inverted error logic. Use the common error
logic instead. Return 0 for success and negative values for failure.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_xmit.c    | 28 +++++++---------------
 drivers/staging/r8188eu/include/rtw_xmit.h |  2 +-
 drivers/staging/r8188eu/os_dep/os_intfs.c  |  2 +-
 3 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index c0fda6ce7c56..34494f08c0cd 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -59,12 +59,11 @@ static void rtw_xmit_resource_free(struct adapter *padapter, struct xmit_buf *px
 	kfree(pxmitbuf->pallocated_buf);
 }
 
-s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
+int _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 {
 	int i;
 	struct xmit_buf *pxmitbuf;
 	struct xmit_frame *pxframe;
-	int	res = _SUCCESS;
 	u32 max_xmit_extbuf_size = MAX_XMIT_EXTBUF_SZ;
 	u32 num_xmit_extbuf = NR_XMIT_EXTBUFF;
 
@@ -97,7 +96,6 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 
 	if (!pxmitpriv->pallocated_frame_buf) {
 		pxmitpriv->pxmit_frame_buf = NULL;
-		res = _FAIL;
 		goto exit;
 	}
 	pxmitpriv->pxmit_frame_buf = (u8 *)ALIGN((size_t)(pxmitpriv->pallocated_frame_buf), 4);
@@ -132,10 +130,8 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 
 	pxmitpriv->pallocated_xmitbuf = vzalloc(NR_XMITBUFF * sizeof(struct xmit_buf) + 4);
 
-	if (!pxmitpriv->pallocated_xmitbuf) {
-		res = _FAIL;
+	if (!pxmitpriv->pallocated_xmitbuf)
 		goto free_frame_buf;
-	}
 
 	pxmitpriv->pxmitbuf = (u8 *)ALIGN((size_t)(pxmitpriv->pallocated_xmitbuf), 4);
 	/* pxmitpriv->pxmitbuf = pxmitpriv->pallocated_xmitbuf + 4 - */
@@ -153,10 +149,8 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 		/* Tx buf allocation may fail sometimes, so sleep and retry. */
 		if (rtw_xmit_resource_alloc(padapter, pxmitbuf, (MAX_XMITBUF_SZ + XMITBUF_ALIGN_SZ))) {
 			msleep(10);
-			if (rtw_xmit_resource_alloc(padapter, pxmitbuf, (MAX_XMITBUF_SZ + XMITBUF_ALIGN_SZ))) {
-				res = _FAIL;
+			if (rtw_xmit_resource_alloc(padapter, pxmitbuf, (MAX_XMITBUF_SZ + XMITBUF_ALIGN_SZ)))
 				goto free_xmitbuf;
-			}
 		}
 
 		pxmitbuf->flags = XMIT_VO_QUEUE;
@@ -172,10 +166,8 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 
 	pxmitpriv->pallocated_xmit_extbuf = vzalloc(num_xmit_extbuf * sizeof(struct xmit_buf) + 4);
 
-	if (!pxmitpriv->pallocated_xmit_extbuf) {
-		res = _FAIL;
+	if (!pxmitpriv->pallocated_xmit_extbuf)
 		goto free_xmitbuf;
-	}
 
 	pxmitpriv->pxmit_extbuf = (u8 *)ALIGN((size_t)(pxmitpriv->pallocated_xmit_extbuf), 4);
 
@@ -188,10 +180,8 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 		pxmitbuf->padapter = padapter;
 		pxmitbuf->ext_tag = true;
 
-		if (rtw_xmit_resource_alloc(padapter, pxmitbuf, max_xmit_extbuf_size + XMITBUF_ALIGN_SZ)) {
-			res = _FAIL;
+		if (rtw_xmit_resource_alloc(padapter, pxmitbuf, max_xmit_extbuf_size + XMITBUF_ALIGN_SZ))
 			goto free_xmit_extbuf;
-		}
 
 		list_add_tail(&pxmitbuf->list, &pxmitpriv->free_xmit_extbuf_queue.queue);
 		pxmitbuf++;
@@ -199,10 +189,8 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 
 	pxmitpriv->free_xmit_extbuf_cnt = num_xmit_extbuf;
 
-	if (rtw_alloc_hwxmits(padapter)) {
-		res = _FAIL;
+	if (rtw_alloc_hwxmits(padapter))
 		goto free_xmit_extbuf;
-	}
 
 	rtw_init_hwxmits(pxmitpriv->hwxmits, pxmitpriv->hwxmit_entry);
 
@@ -225,7 +213,7 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 
 	rtl8188eu_init_xmit_priv(padapter);
 
-	return _SUCCESS;
+	return 0;
 
 free_xmit_extbuf:
 	pxmitbuf = (struct xmit_buf *)pxmitpriv->pxmit_extbuf;
@@ -245,7 +233,7 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 free_frame_buf:
 	vfree(pxmitpriv->pallocated_frame_buf);
 exit:
-	return res;
+	return -ENOMEM;
 }
 
 static void rtw_pkt_complete(struct adapter *padapter, struct sk_buff *pkt)
diff --git a/drivers/staging/r8188eu/include/rtw_xmit.h b/drivers/staging/r8188eu/include/rtw_xmit.h
index cff065554608..6e7ebea5362d 100644
--- a/drivers/staging/r8188eu/include/rtw_xmit.h
+++ b/drivers/staging/r8188eu/include/rtw_xmit.h
@@ -351,7 +351,7 @@ s32 rtw_txframes_pending(struct adapter *padapter);
 s32 rtw_txframes_sta_ac_pending(struct adapter *padapter,
 				struct pkt_attrib *pattrib);
 void rtw_init_hwxmits(struct hw_xmit *phwxmit, int entry);
-s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter);
+int _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter);
 void _rtw_free_xmit_priv(struct xmit_priv *pxmitpriv);
 int rtw_alloc_hwxmits(struct adapter *padapter);
 void rtw_free_hwxmits(struct adapter *padapter);
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index 66556e07ed93..44eb95a7682c 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -480,7 +480,7 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
 
 	init_mlme_ext_priv(padapter);
 
-	if (_rtw_init_xmit_priv(&padapter->xmitpriv, padapter) == _FAIL) {
+	if (_rtw_init_xmit_priv(&padapter->xmitpriv, padapter)) {
 		dev_err(dvobj_to_dev(padapter->dvobj), "_rtw_init_xmit_priv failed\n");
 		goto free_mlme_ext;
 	}
-- 
2.38.1


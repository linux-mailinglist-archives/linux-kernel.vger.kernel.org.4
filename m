Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D39625575
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 09:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbiKKIhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 03:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbiKKIht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 03:37:49 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC347C8DA
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 00:37:48 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id n12so10972392eja.11
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 00:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3DfnILufOOdX5Kg+pMaqFVKzb+AWaHeWfhqHmZ5gkkQ=;
        b=MS0P2McydCUAf7eSsNKhvvmIAlUVNE26AUM7kKUv7Uh0YTiBiU8DFPJuCHGx31eEtd
         Qkz3BNQd43fNTOrFoRHi3E7f/P0xAdFodl7EWgBj7QePxFQITOseXV5/8OcIdxdJry67
         DZF2UCG4dAH7RDbAJbV8WLcV2nf2m6RN/slhibUTcOFwu1ljkuQXHmWhLyj4ikvGA6hN
         e/l0i9aYwI7blBu9KMMP7wyeYSdzPx0ua2PChGIWjvHbKOfCLCuJaJ4R69OEXwgbJR6C
         rT/d2nFb/ztrtOZtyRiIOwV+uo/UjrjsZ+1IMNsFmbJ/3l8Ax6j3WdnGmDmfgUKyDwa6
         kZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3DfnILufOOdX5Kg+pMaqFVKzb+AWaHeWfhqHmZ5gkkQ=;
        b=H2es9m/gLHHF8vNBY91W4QR/SqjP3vW3hNlYYYyD9fr8K2f7NrTFbRrhgK1p+CfVGi
         ojRaX1W6IHyoBg6+xnV2H7VZqe6yPTefb9iBCxukSig2weF6JfAH334qBabJdNUbrwbP
         O9T8+eUcDEBVViUWghz3GEtJcfPSasT7jujjU+9GtZkDtvjLkuFNyHACFEPqMqXwCbwx
         VA7H3o9sslgcg2k8MEDJ+uNCvo8wLwzOXoXSBR6s9LMW2Dd1oEcHHgmve+/Z2WiguOAC
         AAnQQOKd89wx/MG1t+7F5HrWipanccwkr77rZGn/dPGh4uXLMCXlU7BowZ7TWGrPHvIj
         rTJQ==
X-Gm-Message-State: ANoB5pkD57Gv86XFGASREiucgWtK9Ct8hWnrQPxzam3wM9ofmVzO0m9y
        0HWk111ZZb/PLuuGZnWqYhI=
X-Google-Smtp-Source: AA0mqf5aiyxa09zAtPPNAiiRKTmfcLM33PYOCq9MCHSSdXzYg0180MJzHcdWo1PFH3B8iGrGbyeZfg==
X-Received: by 2002:a17:906:5054:b0:79b:413b:d64 with SMTP id e20-20020a170906505400b0079b413b0d64mr997764ejk.538.1668155867208;
        Fri, 11 Nov 2022 00:37:47 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb9a.dynamic.kabel-deutschland.de. [95.90.187.154])
        by smtp.gmail.com with ESMTPSA id b2-20020a1709063ca200b007ae566edb8bsm643190ejh.73.2022.11.11.00.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 00:37:46 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/4] staging: r8188eu: convert rtw_xmit_resource_alloc() to common error logic
Date:   Fri, 11 Nov 2022 09:37:31 +0100
Message-Id: <20221111083733.3144-3-straube.linux@gmail.com>
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

Convert the function rtw_xmit_resource_alloc() away from returning
_FAIL or _SUCCESS which uses inverted error logic. Use the common
error logic instead. Return 0 for success and negative values for
failure.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_xmit.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index bd6c1a401c59..c0fda6ce7c56 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -38,7 +38,7 @@ static int rtw_xmit_resource_alloc(struct adapter *padapter, struct xmit_buf *px
 {
 	pxmitbuf->pallocated_buf = kzalloc(alloc_sz, GFP_KERNEL);
 	if (!pxmitbuf->pallocated_buf)
-		return _FAIL;
+		return -ENOMEM;
 
 	pxmitbuf->pbuf = (u8 *)ALIGN((size_t)(pxmitbuf->pallocated_buf), XMITBUF_ALIGN_SZ);
 	pxmitbuf->dma_transfer_addr = 0;
@@ -46,10 +46,10 @@ static int rtw_xmit_resource_alloc(struct adapter *padapter, struct xmit_buf *px
 	pxmitbuf->pxmit_urb = usb_alloc_urb(0, GFP_KERNEL);
 	if (!pxmitbuf->pxmit_urb) {
 		kfree(pxmitbuf->pallocated_buf);
-		return _FAIL;
+		return -ENOMEM;
 	}
 
-	return _SUCCESS;
+	return 0;
 }
 
 static void rtw_xmit_resource_free(struct adapter *padapter, struct xmit_buf *pxmitbuf,
@@ -151,12 +151,12 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 		pxmitbuf->ext_tag = false;
 
 		/* Tx buf allocation may fail sometimes, so sleep and retry. */
-		res = rtw_xmit_resource_alloc(padapter, pxmitbuf, (MAX_XMITBUF_SZ + XMITBUF_ALIGN_SZ));
-		if (res == _FAIL) {
+		if (rtw_xmit_resource_alloc(padapter, pxmitbuf, (MAX_XMITBUF_SZ + XMITBUF_ALIGN_SZ))) {
 			msleep(10);
-			res = rtw_xmit_resource_alloc(padapter, pxmitbuf, (MAX_XMITBUF_SZ + XMITBUF_ALIGN_SZ));
-			if (res == _FAIL)
+			if (rtw_xmit_resource_alloc(padapter, pxmitbuf, (MAX_XMITBUF_SZ + XMITBUF_ALIGN_SZ))) {
+				res = _FAIL;
 				goto free_xmitbuf;
+			}
 		}
 
 		pxmitbuf->flags = XMIT_VO_QUEUE;
@@ -188,8 +188,7 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 		pxmitbuf->padapter = padapter;
 		pxmitbuf->ext_tag = true;
 
-		res = rtw_xmit_resource_alloc(padapter, pxmitbuf, max_xmit_extbuf_size + XMITBUF_ALIGN_SZ);
-		if (res == _FAIL) {
+		if (rtw_xmit_resource_alloc(padapter, pxmitbuf, max_xmit_extbuf_size + XMITBUF_ALIGN_SZ)) {
 			res = _FAIL;
 			goto free_xmit_extbuf;
 		}
-- 
2.38.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156BE60C7CC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 11:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiJYJTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 05:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbiJYJS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 05:18:59 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529B316C22C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 02:12:46 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id b2so10860283eja.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 02:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Z+J20nkyvf9zvzoex976NXQ4RyfsmUwd3Fi5lYS2+g=;
        b=JuwhEj+FIeI8r7Auq46FaNuvbKKNxmoG+Oo8YSiLsSh52Rqb0ken7YJuyO39BMy3gc
         HVioh9tgBUfywHgGRiaa8tu3pDanG+Y8UIDw1CQCE1BItWiSG3rLShOBZAZU+QICses7
         VlEQYvHYwuc9/s4ROpNuPTqPKYTTYm4dmb0wPfBajqeLwkvssLZwkLC4nqGVazVDHdlp
         lP1D4Wzmzeo3izM57PBYYmbI6R2dMdnrDlECR630TcuvjqSK6vA5NugwUi8gRLHY/YvN
         EXOOdNYmfM60qSiAzsmNJGA8eWlKCFjgI4cbyaO427EkK9NKud7d6fuvW9GoL+1HxC/j
         TCDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Z+J20nkyvf9zvzoex976NXQ4RyfsmUwd3Fi5lYS2+g=;
        b=xHyFHX+BIheruIv1A45/Miru0QCsj2mklOyqSHe11Z6L7RXdQaKSnx+0c6NtWb0RAr
         VyUSY/GfO43r5ShK62qripz4GepVrHzMs3nY7S6yCCLlwAI1NrAVKRcUmDo67ije5cEH
         SQS7/pL+SflEbzPJtfdDSzZs1hBdVGa8deEnWxn8xazU822YTWm5eRQYsJbJVgzddYRM
         xzLJLC1VXGcAkANfHQMFhYky6GZBIUmad836jPcRSvjV/RDDN4I8JGyjSnCdvRfsyrzh
         EUqnwE7mqtghs5B+ArNRKBlsM1vk90Vj8kYUcjp4DhyNXcDTPnykKrV72dJS4gNI8yWm
         5hpw==
X-Gm-Message-State: ACrzQf1VqDkpj6cWQ9HIiCWAwvkvvYPSiLgUsSsyQaI7auwYuyRHwtd5
        MB4bMbZ4yCgbualQiQ83Lps=
X-Google-Smtp-Source: AMsMyM6pxohNxoDB4Ay4qDRDLiEQmXWwybWKlDz+Sb4+rPb0gimKWaR2nLjgMzddJoCbPmyk/48jLQ==
X-Received: by 2002:a17:907:2c4a:b0:78d:ee99:a06b with SMTP id hf10-20020a1709072c4a00b0078dee99a06bmr30382254ejc.578.1666689164975;
        Tue, 25 Oct 2022 02:12:44 -0700 (PDT)
Received: from localhost.localdomain (ip-217-105-46-178.ip.prioritytelecom.net. [217.105.46.178])
        by smtp.gmail.com with ESMTPSA id bo12-20020a170906d04c00b00780f24b797dsm1061953ejb.108.2022.10.25.02.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 02:12:44 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     namcaov@gmail.com, Dan Carpenter <dan.carpenter@oracle.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] staging: rtl8712: fix potential memory leak
Date:   Tue, 25 Oct 2022 11:12:26 +0200
Message-Id: <0a3414b12031f6cdcba81a8725e91eb9567ff34f.1666688642.git.namcaov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1666688642.git.namcaov@gmail.com>
References: <cover.1666688642.git.namcaov@gmail.com>
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

In r8712_init_drv_sw(), whenever any function call returns error, it is
returned immediately without properly cleaning up the other successfully
executed functions. This can cause memory leak.

Instead of return immediately, free all the allocated buffers first.

Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 drivers/staging/rtl8712/os_intfs.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8712/os_intfs.c b/drivers/staging/rtl8712/os_intfs.c
index 205b7d66a40a..a2f3645be0cc 100644
--- a/drivers/staging/rtl8712/os_intfs.c
+++ b/drivers/staging/rtl8712/os_intfs.c
@@ -304,29 +304,42 @@ int r8712_init_drv_sw(struct _adapter *padapter)
 	padapter->cmdpriv.padapter = padapter;
 	ret = r8712_init_evt_priv(&padapter->evtpriv);
 	if (ret)
-		return ret;
+		goto free_cmd;
 	ret = r8712_init_mlme_priv(padapter);
 	if (ret)
-		return ret;
+		goto free_evt;
 	ret = _r8712_init_xmit_priv(&padapter->xmitpriv, padapter);
 	if (ret)
-		return ret;
+		goto free_mlme;
 	ret = _r8712_init_recv_priv(&padapter->recvpriv, padapter);
 	if (ret)
-		return ret;
+		goto free_xmit;
 	memset((unsigned char *)&padapter->securitypriv, 0,
 	       sizeof(struct security_priv));
 	timer_setup(&padapter->securitypriv.tkip_timer,
 		    r8712_use_tkipkey_handler, 0);
 	ret = _r8712_init_sta_priv(&padapter->stapriv);
 	if (ret)
-		return ret;
+		goto free_recv;
 	padapter->stapriv.padapter = padapter;
 	r8712_init_bcmc_stainfo(padapter);
 	r8712_init_pwrctrl_priv(padapter);
 	mp871xinit(padapter);
 	init_default_value(padapter);
 	r8712_InitSwLeds(padapter);
+
+	return 0;
+
+free_recv:
+	_r8712_free_recv_priv(&padapter->recvpriv);
+free_xmit:
+	_free_xmit_priv(&padapter->xmitpriv);
+free_mlme:
+	r8712_free_mlme_priv(&padapter->mlmepriv);
+free_evt:
+	r8712_free_evt_priv(&padapter->evtpriv);
+free_cmd:
+	r8712_free_cmd_priv(&padapter->cmdpriv);
 	return ret;
 }
 
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A384060C7CA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 11:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbiJYJTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 05:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbiJYJS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 05:18:59 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5405C16C222
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 02:12:45 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id y14so10821220ejd.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 02:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nnL9Vx35UQpnPWPx9ucZ8Qb9hN/sl4ozm2xfwelthM=;
        b=kx5QZu0qHt8rymUNVxiYWrTO2HQpqajmO5wdHAtw9jtTCP+MNWtxFzsJPomSCyLajs
         OSjT1WpjxUsEi71bg1q6Q+WA9IilwxVz8Ej7LY3cENBoKRJ78Vp1rMgcr/vTGok7LZsN
         hO1XXOvELxKQbA8hCFzJfZO6mm6YPS7FI23vRmySfYx0mRn+loTEWOUrOYQ04Ul8Xe2P
         3ihwcV7+EPmWvs8xG98LahytznKScHIObpmWyc152gQvwX6aAKi4lkVGgM1hAWtmMkH4
         lgmnfVQp9Q/hga43o3bs4DyLyTISq8b839SaiYWAbMU3Iq4KjzH4+06/mdZRVEEuxrLI
         NTLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1nnL9Vx35UQpnPWPx9ucZ8Qb9hN/sl4ozm2xfwelthM=;
        b=1H9AjFPmSoIBslyGMBsZOMCOd9SBo0NKStZwNleMtRiHThDJmkuJi1K8UsPcTyMZIT
         80vF5TJ5e7+FpqLiF3SaOVhDUwPfvqA8J/DU2umTZoe8BM6oeG/yvaWnLFnmdME/1Lts
         nXj2ohVDwYg7kbk4PbnaVJaptznu4qiLMXMmHAfZlbMe8Bua9vK8TLTB6jHghHdDxFsV
         SBSjr0cmC0CQSbIWHFCT0fxqtYSM9NBFhI8I2k8LJs8YEDmK8YWhdd6q/Ln9f4WIG4vY
         A7QkXYjDJKYvpScq2k1GCIwcg2WJ3TvX/WyDMI00b4Kfx6mwc5y+EDolSwKBw0W6hcJ9
         6MwA==
X-Gm-Message-State: ACrzQf1jxKsJDsZbNA5rNSnIRcGVF0A2JyEitAI3ccf30ot4Upt0Mko4
        umMXxoMJ72466NRmX/rO04w=
X-Google-Smtp-Source: AMsMyM4c3KFXfNUfoqU5lK6hptKPy3dzyKxxK31XxIxRA87RYFC7AmNX6CytiTyYhNI0u5NBV43S+g==
X-Received: by 2002:a17:906:99c2:b0:7a8:c167:1d93 with SMTP id s2-20020a17090699c200b007a8c1671d93mr7351570ejn.490.1666689163736;
        Tue, 25 Oct 2022 02:12:43 -0700 (PDT)
Received: from localhost.localdomain (ip-217-105-46-178.ip.prioritytelecom.net. [217.105.46.178])
        by smtp.gmail.com with ESMTPSA id bo12-20020a170906d04c00b00780f24b797dsm1061953ejb.108.2022.10.25.02.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 02:12:43 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     namcaov@gmail.com, Dan Carpenter <dan.carpenter@oracle.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] staging: rtl8712: check for alloc fail in _r8712_init_recv_priv()
Date:   Tue, 25 Oct 2022 11:12:24 +0200
Message-Id: <506ac35a667e511db568b06b86834fd0ceeba453.1666688642.git.namcaov@gmail.com>
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

The function _r8712_init_recv_priv() and also r8712_init_recv_priv()
just returns silently if they fail to allocate memory. Change their
return type to int and add necessary checks and handling if they return
-ENOMEM

Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 drivers/staging/rtl8712/os_intfs.c     |  4 +++-
 drivers/staging/rtl8712/recv_osdep.h   |  8 ++++----
 drivers/staging/rtl8712/rtl8712_recv.c |  7 ++++---
 drivers/staging/rtl8712/rtl871x_recv.c | 13 +++++++++----
 4 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8712/os_intfs.c b/drivers/staging/rtl8712/os_intfs.c
index 003e97205124..12adb470d216 100644
--- a/drivers/staging/rtl8712/os_intfs.c
+++ b/drivers/staging/rtl8712/os_intfs.c
@@ -309,7 +309,9 @@ int r8712_init_drv_sw(struct _adapter *padapter)
 	if (ret)
 		return ret;
 	_r8712_init_xmit_priv(&padapter->xmitpriv, padapter);
-	_r8712_init_recv_priv(&padapter->recvpriv, padapter);
+	ret = _r8712_init_recv_priv(&padapter->recvpriv, padapter);
+	if (ret)
+		return ret;
 	memset((unsigned char *)&padapter->securitypriv, 0,
 	       sizeof(struct security_priv));
 	timer_setup(&padapter->securitypriv.tkip_timer,
diff --git a/drivers/staging/rtl8712/recv_osdep.h b/drivers/staging/rtl8712/recv_osdep.h
index d8c1fa74f544..fbe3f2868506 100644
--- a/drivers/staging/rtl8712/recv_osdep.h
+++ b/drivers/staging/rtl8712/recv_osdep.h
@@ -18,15 +18,15 @@
 #include "drv_types.h"
 #include <linux/skbuff.h>
 
-void _r8712_init_recv_priv(struct recv_priv *precvpriv,
-			   struct _adapter *padapter);
+int _r8712_init_recv_priv(struct recv_priv *precvpriv,
+			  struct _adapter *padapter);
 void _r8712_free_recv_priv(struct recv_priv *precvpriv);
 void r8712_recv_entry(union recv_frame *precv_frame);
 void r8712_recv_indicatepkt(struct _adapter *adapter,
 			    union recv_frame *precv_frame);
 void r8712_handle_tkip_mic_err(struct _adapter *padapter, u8 bgroup);
-void r8712_init_recv_priv(struct recv_priv *precvpriv,
-			  struct _adapter *padapter);
+int r8712_init_recv_priv(struct recv_priv *precvpriv,
+			 struct _adapter *padapter);
 void r8712_free_recv_priv(struct recv_priv *precvpriv);
 void r8712_os_recv_resource_alloc(struct _adapter *padapter,
 				  union recv_frame *precvframe);
diff --git a/drivers/staging/rtl8712/rtl8712_recv.c b/drivers/staging/rtl8712/rtl8712_recv.c
index 7f1fdd058551..7da014ab0723 100644
--- a/drivers/staging/rtl8712/rtl8712_recv.c
+++ b/drivers/staging/rtl8712/rtl8712_recv.c
@@ -30,8 +30,8 @@
 
 static void recv_tasklet(struct tasklet_struct *t);
 
-void r8712_init_recv_priv(struct recv_priv *precvpriv,
-			  struct _adapter *padapter)
+int r8712_init_recv_priv(struct recv_priv *precvpriv,
+			 struct _adapter *padapter)
 {
 	int i;
 	struct recv_buf *precvbuf;
@@ -44,7 +44,7 @@ void r8712_init_recv_priv(struct recv_priv *precvpriv,
 	precvpriv->pallocated_recv_buf =
 		kzalloc(NR_RECVBUFF * sizeof(struct recv_buf) + 4, GFP_ATOMIC);
 	if (!precvpriv->pallocated_recv_buf)
-		return;
+		return -ENOMEM;
 	precvpriv->precv_buf = precvpriv->pallocated_recv_buf + 4 -
 			      ((addr_t)(precvpriv->pallocated_recv_buf) & 3);
 	precvbuf = (struct recv_buf *)precvpriv->precv_buf;
@@ -75,6 +75,7 @@ void r8712_init_recv_priv(struct recv_priv *precvpriv,
 		}
 		pskb = NULL;
 	}
+	return 0;
 }
 
 void r8712_free_recv_priv(struct recv_priv *precvpriv)
diff --git a/drivers/staging/rtl8712/rtl871x_recv.c b/drivers/staging/rtl8712/rtl871x_recv.c
index 4db7eed64a03..8a3566214af7 100644
--- a/drivers/staging/rtl8712/rtl871x_recv.c
+++ b/drivers/staging/rtl8712/rtl871x_recv.c
@@ -42,9 +42,10 @@ void _r8712_init_sta_recv_priv(struct sta_recv_priv *psta_recvpriv)
 	_init_queue(&psta_recvpriv->defrag_q);
 }
 
-void _r8712_init_recv_priv(struct recv_priv *precvpriv,
-			   struct _adapter *padapter)
+int _r8712_init_recv_priv(struct recv_priv *precvpriv,
+			  struct _adapter *padapter)
 {
+	int ret;
 	sint i;
 	union recv_frame *precvframe;
 
@@ -58,7 +59,7 @@ void _r8712_init_recv_priv(struct recv_priv *precvpriv,
 				sizeof(union recv_frame) + RXFRAME_ALIGN_SZ,
 				GFP_ATOMIC);
 	if (!precvpriv->pallocated_frame_buf)
-		return;
+		return -ENOMEM;
 	precvpriv->precv_frame_buf = precvpriv->pallocated_frame_buf +
 				    RXFRAME_ALIGN_SZ -
 				    ((addr_t)(precvpriv->pallocated_frame_buf) &
@@ -73,7 +74,11 @@ void _r8712_init_recv_priv(struct recv_priv *precvpriv,
 		precvframe++;
 	}
 	precvpriv->rx_pending_cnt = 1;
-	r8712_init_recv_priv(precvpriv, padapter);
+	ret = r8712_init_recv_priv(precvpriv, padapter);
+	if (ret)
+		kfree(precvpriv->pallocated_frame_buf);
+
+	return ret;
 }
 
 void _r8712_free_recv_priv(struct recv_priv *precvpriv)
-- 
2.25.1


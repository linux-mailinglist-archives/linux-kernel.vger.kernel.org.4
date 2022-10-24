Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3A460BE1E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 01:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiJXXDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 19:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbiJXXDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 19:03:06 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999D51C73E4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 14:24:28 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id r14so33568328edc.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 14:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TLGob7xf35t9SsnfBjxCcR4IfErklOduxxLTtm9ur1I=;
        b=nsu7fcq1ngbWdbFKhL4y1cafZxXzRGqhXLAb9vehKnW/VVlFTAqp0gyWgiYbWQvA9d
         XyDPBtYzEw9+y6N7oNFfU3S1IO8FlLnZjn0fvgaRX89MI3wqAQ32hgdN1cxjvwOxioVS
         54P9vIqyjxI+8Vc+TMluQTP2wLYIPsnQgR1zojywdne9Ysq2QNIAC++8XeuJmO7ESKHc
         czt/sZZ8tD9tpYsBU61IGHyPQaG+kmTgw1QzZKxKhTa0uz7uVyY7CMRTq8mIJ+1sg5jS
         v0/SmWZcf+XJDjqnFJw6q8dBGPboc62cYKd80DewdheSkojpdt1abxQqdAp5AREyyVL2
         zOqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TLGob7xf35t9SsnfBjxCcR4IfErklOduxxLTtm9ur1I=;
        b=5BVXOaVp9KnrSRIcRhAuWOMn1vb0mYSls248vVEa9SUDeLoZf/km+aDFmmiurrOW9K
         lLcV1eqV0cXZBkxK02LqWOtvbAa45wqIMYzy2CuxeDr4VGxYxNrsmniqZq6oDvxEpmAZ
         /SarZtll69L87z3CN/WV0G5X3V3yS7HLuJ/4tXQvHkQ14tVgTMhMSVIfo/44YnmJghcB
         uaEZSU+34TvTqIsa3Qs77BYX+uqN81padw40Ip9qOsimM+tke7NnXBdgTAabaZbcZZ6Q
         Il9oCA1O7xstqOCh371hnNDz+v9l/DVqL+A4RQPl5F6EpQRGhbLJJ8mBGJ/hOnrIuzJl
         oU8g==
X-Gm-Message-State: ACrzQf3xLWlBDphgfFulFAtLwobLY2pikYDGHqJzpt+cJdW0639U6g0S
        sflnlldUy/u629AYdEeCm2g=
X-Google-Smtp-Source: AMsMyM47ywCfVGcSh4I2R2rFVZ0cpbI0/DxOY01dcAOlsDEB5OVrxF6paOshzJno4w/uPzgQd68zHA==
X-Received: by 2002:a05:6402:2681:b0:461:cbda:fe4b with SMTP id w1-20020a056402268100b00461cbdafe4bmr5863506edd.124.1666646665641;
        Mon, 24 Oct 2022 14:24:25 -0700 (PDT)
Received: from localhost.localdomain (ip-217-105-46-178.ip.prioritytelecom.net. [217.105.46.178])
        by smtp.gmail.com with ESMTPSA id r1-20020a1709061ba100b007a9c3831409sm379354ejg.137.2022.10.24.14.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 14:24:25 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     namcaov@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] staging: rtl8712: check for alloc fail in _r8712_init_recv_priv()
Date:   Mon, 24 Oct 2022 23:24:07 +0200
Message-Id: <ce12408f17f90b3b368d077a7321a2a252f52b72.1666645510.git.namcaov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1666645510.git.namcaov@gmail.com>
References: <cover.1666645510.git.namcaov@gmail.com>
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
 drivers/staging/rtl8712/os_intfs.c     |  3 ++-
 drivers/staging/rtl8712/recv_osdep.h   |  8 ++++----
 drivers/staging/rtl8712/rtl8712_recv.c |  7 ++++---
 drivers/staging/rtl8712/rtl871x_recv.c | 13 +++++++++----
 4 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8712/os_intfs.c b/drivers/staging/rtl8712/os_intfs.c
index 003e97205124..47d7d998fa86 100644
--- a/drivers/staging/rtl8712/os_intfs.c
+++ b/drivers/staging/rtl8712/os_intfs.c
@@ -309,7 +309,8 @@ int r8712_init_drv_sw(struct _adapter *padapter)
 	if (ret)
 		return ret;
 	_r8712_init_xmit_priv(&padapter->xmitpriv, padapter);
-	_r8712_init_recv_priv(&padapter->recvpriv, padapter);
+	ret = _r8712_init_recv_priv(&padapter->recvpriv, padapter);
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


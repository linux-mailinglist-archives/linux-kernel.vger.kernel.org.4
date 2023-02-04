Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688AE68A967
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 11:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbjBDKRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 05:17:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbjBDKRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 05:17:03 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B33D28234
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 02:17:02 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id ud5so21749865ejc.4
        for <linux-kernel@vger.kernel.org>; Sat, 04 Feb 2023 02:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7RXm6Lsoznyg1+l0w/MAUy9nfuZ+z0HNP/nxhYlCK60=;
        b=jDQR2YXBY0vow0iYqDSlsL/5aCNCEeXev2H38cUYTDwmI7nDy+HUF69bToCKQgrmlb
         5T74kOp5VvKhzuTapNB6oj6uC00CFOlYcw8R5pzeY/9wi/PoOo3yjrjzYp3CORNTxzhS
         pomlTYRsMYj5cZJZwGJEukf4uf8IJ/7dohuANCAqrilAVXWYA5twsbLM9rERkezq3oIU
         GeJvoh3cneNmBQ+xTqR7i0g2F1+j7G0+exwBGyKHJFg2lRZHIbU9RtelYaTuIF7zwSNW
         +hs0ox6l7D4JgzQa3B9D3+qITF0p+tRkgrMO2pdqHqN+h1ONkwE5TaNoBl9YZyhsle1U
         PnKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7RXm6Lsoznyg1+l0w/MAUy9nfuZ+z0HNP/nxhYlCK60=;
        b=0sGPkVb4tJ23fXdZgvPTSqnri/G+BO8EeNDIqud91JTemQda5Vw7r2M9rKmwDa4DCp
         eI0KgLltq+2fZR5sauxHhgOQwMx1oNMl6UuoTLDxRxzeqWR0vz0bn4jKd6/19xSDMAG9
         ms0YrOMJGTyfj9Zq+DUbjHiWLsQDqzmuGKDK6RK+3gxKfxUNEXnv8WzSi84UzXA05Vdg
         Samk0oIKQK5LI0MK78azfas4X/pdwlXAf8BDtXFw3vyHjinDWJmKuo3naaVFEjBZ4FeU
         iXTY4fDmDMqQoe6yBdQEdSIqV6b7yYZRyyKgsQ5CA+quv9l02+x7NxWumKbnLyb6iMqB
         M/VQ==
X-Gm-Message-State: AO0yUKVXtFFhb/BRGkZy9ektd6vo2tXHeqB/WlajFsBMJwp2pOEL5+I6
        XX/D5cwRpEiSIbsyOOyNVi25Q/1BaguPYA==
X-Google-Smtp-Source: AK7set+gTHDdvdjvnSR1lvMyEf6oJzMST6F4DGgd9RoQt4+ql1Hwm7WlSWnmQ/u9ST7VV1bbKBQJ1g==
X-Received: by 2002:a17:906:4993:b0:88a:b6ca:7d3d with SMTP id p19-20020a170906499300b0088ab6ca7d3dmr13003608eju.8.1675505820728;
        Sat, 04 Feb 2023 02:17:00 -0800 (PST)
Received: from localhost.localdomain (ip5f5abbf9.dynamic.kabel-deutschland.de. [95.90.187.249])
        by smtp.gmail.com with ESMTPSA id m19-20020a1709061ed300b0088ed7de4821sm2632378ejj.158.2023.02.04.02.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Feb 2023 02:17:00 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/2] staging: r8188eu: correct error logic of rtl8188eu_init_recv_priv()
Date:   Sat,  4 Feb 2023 11:16:53 +0100
Message-Id: <20230204101654.10232-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230204101654.10232-1-straube.linux@gmail.com>
References: <20230204101654.10232-1-straube.linux@gmail.com>
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

Convert the function rtl8188eu_init_recv_priv() away from returning
_FAIL and _SUCCESS, which uses inverted error logic. Return 0 for
success and negative values for failure instead.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_recv.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 631c500dda42..70d43c10e53d 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -38,7 +38,7 @@ void _rtw_init_sta_recv_priv(struct sta_recv_priv *psta_recvpriv)
 static int rtl8188eu_init_recv_priv(struct adapter *padapter)
 {
 	struct recv_priv *precvpriv = &padapter->recvpriv;
-	int i, res = _SUCCESS;
+	int i, err = 0;
 	struct recv_buf *precvbuf;
 
 	tasklet_init(&precvpriv->recv_tasklet,
@@ -50,10 +50,8 @@ static int rtl8188eu_init_recv_priv(struct adapter *padapter)
 
 	precvpriv->pallocated_recv_buf = kzalloc(NR_RECVBUFF * sizeof(struct recv_buf) + 4,
 						 GFP_KERNEL);
-	if (!precvpriv->pallocated_recv_buf) {
-		res = _FAIL;
-		goto exit;
-	}
+	if (!precvpriv->pallocated_recv_buf)
+		return -ENOMEM;
 
 	precvpriv->precv_buf = (u8 *)ALIGN((size_t)(precvpriv->pallocated_recv_buf), 4);
 
@@ -64,7 +62,7 @@ static int rtl8188eu_init_recv_priv(struct adapter *padapter)
 		precvbuf->reuse = false;
 		precvbuf->purb = usb_alloc_urb(0, GFP_KERNEL);
 		if (!precvbuf->purb) {
-			res = _FAIL;
+			err = -ENOMEM;
 			break;
 		}
 		precvbuf->adapter = padapter;
@@ -94,8 +92,8 @@ static int rtl8188eu_init_recv_priv(struct adapter *padapter)
 			pskb = NULL;
 		}
 	}
-exit:
-	return res;
+
+	return err;
 }
 
 int _rtw_init_recv_priv(struct recv_priv *precvpriv, struct adapter *padapter)
@@ -141,7 +139,8 @@ int _rtw_init_recv_priv(struct recv_priv *precvpriv, struct adapter *padapter)
 	}
 	precvpriv->rx_pending_cnt = 1;
 
-	res = rtl8188eu_init_recv_priv(padapter);
+	if (rtl8188eu_init_recv_priv(padapter))
+		res = _FAIL;
 
 	timer_setup(&precvpriv->signal_stat_timer, rtw_signal_stat_timer_hdl, 0);
 	precvpriv->signal_stat_sampling_interval = 1000; /* ms */
-- 
2.39.1


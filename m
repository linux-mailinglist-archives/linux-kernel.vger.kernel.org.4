Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0C268A968
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 11:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbjBDKRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 05:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbjBDKRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 05:17:03 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A432828D06
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 02:17:02 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id p26so21614941ejx.13
        for <linux-kernel@vger.kernel.org>; Sat, 04 Feb 2023 02:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vvcz/YyCGtXoD5oGFLtUkYy0diaSuTeqxFRDCLmhIXc=;
        b=pXvfIB0Cbl+zg+3jyWscDCAcdybMl4jllRa1XNHVpVaICIe036QuFut6fX/my11LzX
         A29v2nBimcRhtWLjUq5fw79RqgtyHABYKzKmE0KalCMHnN5c1CjMnJgx+F2lxucQ8UTf
         KqKS8AndMwq3wphzn4/3QFajNcqwIFp4enopvQ0SLJv60TaOj+U1Ov1iVIjsXOQXI0zP
         4ZveSSV3Ts4PrpZypEWqHRuIiCYwWD/MRROHOG3gRAzVXWdRuhnU8t3WmelmBiF5zA3z
         Vs1ZgMrlT+89J5lHR13FyOLzn6F0Ch9vkZILAqUXZQS7vvHx3mZZ69nBErzW7x7PJLzJ
         j2fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vvcz/YyCGtXoD5oGFLtUkYy0diaSuTeqxFRDCLmhIXc=;
        b=6Ch3IK7GVsedvfUrC67aavFvEwT6UujYtD6j0MfGJA6tBjQJTOq2T55QUDgUe14D1F
         pBV3svdM47pWqcnJnyV3esLV6kmPwuYVOYZ8RnERwVpk8fCJQgYRwQ8jWXest+DFa57/
         ZgHs8OsnLKD+ggC19ism4wShaSz1GDPL4Wfl+24hsuFBhKaaJMHFV8F0sygJ0eAcpYvL
         xbmkI576fV6ndJ58RRSRBN6a8XQIYXTz/u/moyDGWWPu5kEISdv4ZnHoEVVGrLWeAPa0
         P6R357Zornrrn2guWemS1N61ZoQkcr1GK6/nKs7ffQSdkPzdjzg14dAxw83rVSazmTCS
         /5pw==
X-Gm-Message-State: AO0yUKWLGVRh26KtT6RiCyQSOSNdPxW4Aw29OnMoGIQbdtekpVh81t0t
        Bshfl+W/ZEGtGqmpbQ0cuoOvq4iHhpeqdg==
X-Google-Smtp-Source: AK7set+rsaWMwiBAhfM47aGYDWg49bocoSDLXaiAy4k7sANOvYkoIuM7c25hQ31xllHhBe/bSPS2Rw==
X-Received: by 2002:a17:907:1308:b0:88a:bb13:7329 with SMTP id vj8-20020a170907130800b0088abb137329mr12274825ejb.53.1675505821296;
        Sat, 04 Feb 2023 02:17:01 -0800 (PST)
Received: from localhost.localdomain (ip5f5abbf9.dynamic.kabel-deutschland.de. [95.90.187.249])
        by smtp.gmail.com with ESMTPSA id m19-20020a1709061ed300b0088ed7de4821sm2632378ejj.158.2023.02.04.02.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Feb 2023 02:17:01 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/2] staging: r8188eu: correct error logic of _rtw_init_recv_priv()
Date:   Sat,  4 Feb 2023 11:16:54 +0100
Message-Id: <20230204101654.10232-3-straube.linux@gmail.com>
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

Convert the function _rtw_init_recv_priv() away from returning _FAIL
and _SUCCESS, which uses inverted error logic. Return 0 for success
and negative values for failure instead.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_recv.c   | 17 +++++------------
 drivers/staging/r8188eu/os_dep/os_intfs.c |  2 +-
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 70d43c10e53d..4c823bbcc22b 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -99,10 +99,8 @@ static int rtl8188eu_init_recv_priv(struct adapter *padapter)
 int _rtw_init_recv_priv(struct recv_priv *precvpriv, struct adapter *padapter)
 {
 	int i;
-
 	struct recv_frame *precvframe;
-
-	int	res = _SUCCESS;
+	int err = 0;
 
 	spin_lock_init(&precvpriv->lock);
 
@@ -115,11 +113,8 @@ int _rtw_init_recv_priv(struct recv_priv *precvpriv, struct adapter *padapter)
 	precvpriv->free_recvframe_cnt = NR_RECVFRAME;
 
 	precvpriv->pallocated_frame_buf = vzalloc(NR_RECVFRAME * sizeof(struct recv_frame) + RXFRAME_ALIGN_SZ);
-
-	if (!precvpriv->pallocated_frame_buf) {
-		res = _FAIL;
-		goto exit;
-	}
+	if (!precvpriv->pallocated_frame_buf)
+		return -ENOMEM;
 
 	precvpriv->precv_frame_buf = (u8 *)ALIGN((size_t)(precvpriv->pallocated_frame_buf), RXFRAME_ALIGN_SZ);
 
@@ -139,16 +134,14 @@ int _rtw_init_recv_priv(struct recv_priv *precvpriv, struct adapter *padapter)
 	}
 	precvpriv->rx_pending_cnt = 1;
 
-	if (rtl8188eu_init_recv_priv(padapter))
-		res = _FAIL;
+	err = rtl8188eu_init_recv_priv(padapter);
 
 	timer_setup(&precvpriv->signal_stat_timer, rtw_signal_stat_timer_hdl, 0);
 	precvpriv->signal_stat_sampling_interval = 1000; /* ms */
 
 	rtw_set_signal_stat_timer(precvpriv);
-exit:
 
-	return res;
+	return err;
 }
 
 static void rtl8188eu_free_recv_priv(struct adapter *padapter)
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index cfc24420e70c..4130e8fe2952 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -482,7 +482,7 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
 		goto free_mlme_ext;
 	}
 
-	if (_rtw_init_recv_priv(&padapter->recvpriv, padapter) == _FAIL) {
+	if (_rtw_init_recv_priv(&padapter->recvpriv, padapter)) {
 		dev_err(dvobj_to_dev(padapter->dvobj), "_rtw_init_recv_priv failed\n");
 		goto free_xmit_priv;
 	}
-- 
2.39.1


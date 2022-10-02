Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D395D5F2399
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 16:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiJBOgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 10:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiJBOf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 10:35:56 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9318E27159
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 07:35:55 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id hy2so17616904ejc.8
        for <linux-kernel@vger.kernel.org>; Sun, 02 Oct 2022 07:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=5vFN5yAOwmazqPpcOCp2Q/JnJyLAgqeK+WWJJECXgaw=;
        b=Lp/NcjbUdSbrSK41+DIIG37FiJ3JuSZ0adZCyhcOFOJ+Ya/19D8126rVt6M5Pi5yBW
         q90awo980VKUM9KSG2OjuuZih4ZHZscCwEDCXvwXD34XzBZGEsouNzHuorrmXbIvddRu
         mCmDy+o4DsqLV23rJ+BK8gV/HEDT453nEtWsNPvngdykfYGnEFeMNH7sLzE1ec0m98hq
         GR8+vMz+Yt7nyxB0KbnaSECo/NUwUpOquBHuAGusIgT8AeoelYnG5DK9M16UEzAbcJga
         PAvEZISk41gmx9++UZhx3f8PqYRkxC9Jv9SHlD6tyrXNBlIwYi+U5Ei1ONGJhORC6GAV
         OBwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=5vFN5yAOwmazqPpcOCp2Q/JnJyLAgqeK+WWJJECXgaw=;
        b=M678MIV58OU6+lm7Vf0pS+nkiv3FambJwJ6gdkUovyHg+2yssKj/8el5JIBFiExHSY
         HVrH1eCLhDet2nvRi6w+mp4dsygtVZK53G13TfnUWLZ/6E1h8Hf19XJcGZb2zu/9x36s
         4QTeklRWTIANtnedpAVnxwgRA0SZrLoCLczd7OAE94lu3VnEz17WdkBoi0i6AEfXgB6j
         BJEt3p/FtBJwgP+M/2lKif/sZXWPhXyaxBaI23w0/rJb1aaB7UBxU0SQI68qIYiqvlTF
         TIaGRBm2cd/BC68T0nB6dU52u0npSTS24EBcN7JDd7L2OdvQmUYUACH5SzK4wXamtudJ
         kEFA==
X-Gm-Message-State: ACrzQf04YuLLPZzH1CbnAAD+M433zth1l4MrAfAevrDub1fXYDWsT9r5
        H4fmet+F74oJeks0T1xqPzXG3mUE7sc=
X-Google-Smtp-Source: AMsMyM6aEey8/d0zs/pRHrfr60+37ltEDeun6YHe6l8/DHqwPje8J1l+PtB2xUZkn44dNVTJwfFPaw==
X-Received: by 2002:a17:907:3f13:b0:782:1266:8c10 with SMTP id hq19-20020a1709073f1300b0078212668c10mr12372449ejc.197.1664721354033;
        Sun, 02 Oct 2022 07:35:54 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb59.dynamic.kabel-deutschland.de. [95.90.187.89])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906301100b00731582babcasm4082334ejz.71.2022.10.02.07.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Oct 2022 07:35:53 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/2] staging: r8188eu: convert rtw_reset_drv_sw() to void
Date:   Sun,  2 Oct 2022 16:35:43 +0200
Message-Id: <20221002143544.7974-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221002143544.7974-1-straube.linux@gmail.com>
References: <20221002143544.7974-1-straube.linux@gmail.com>
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

The function rtw_reset_drv_sw() always returns _SUCCESS. None of its
callers use the return value. Convert the return type of that function
from u8 to void. This is part of getting rid of _FAIL / _SUCCESS.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/osdep_intf.h | 2 +-
 drivers/staging/r8188eu/os_dep/os_intfs.c    | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/include/osdep_intf.h b/drivers/staging/r8188eu/include/osdep_intf.h
index 36511c469546..ce8e1bc4a61c 100644
--- a/drivers/staging/r8188eu/include/osdep_intf.h
+++ b/drivers/staging/r8188eu/include/osdep_intf.h
@@ -44,7 +44,7 @@ int netdev_close(struct net_device *pnetdev);
 
 u8 rtw_init_drv_sw(struct adapter *padapter);
 u8 rtw_free_drv_sw(struct adapter *padapter);
-u8 rtw_reset_drv_sw(struct adapter *padapter);
+void rtw_reset_drv_sw(struct adapter *padapter);
 
 u32 rtw_start_drv_threads(struct adapter *padapter);
 void rtw_stop_drv_threads (struct adapter *padapter);
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index e43ef7e5ba70..2983e665bd5c 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -433,7 +433,7 @@ static void rtw_init_default_value(struct adapter *padapter)
 	padapter->bShowGetP2PState = 1;
 }
 
-u8 rtw_reset_drv_sw(struct adapter *padapter)
+void rtw_reset_drv_sw(struct adapter *padapter)
 {
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
@@ -455,8 +455,6 @@ u8 rtw_reset_drv_sw(struct adapter *padapter)
 	padapter->mlmeextpriv.sitesurvey_res.state = SCAN_DISABLE;
 
 	rtw_set_signal_stat_timer(&padapter->recvpriv);
-
-	return _SUCCESS;
 }
 
 u8 rtw_init_drv_sw(struct adapter *padapter)
-- 
2.37.3


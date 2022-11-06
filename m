Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7C461E260
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 14:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiKFNe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 08:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiKFNez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 08:34:55 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E57DFBD
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 05:34:54 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id l11so13829515edb.4
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 05:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vczVhc3OPBbJJv7puS37X+vgFWWnV3V2UNdSHwQBMYc=;
        b=i1b1IJU/LpVhIaTvS94dUc2JKge3gJ6cj0xyMOOnQLqDgOEnYFCjY8jrr6cHsQwPot
         gg75MroaDsVi+JOeSjYDsJUR8/aVLPF/xmq+wCulcgZri2P1+PM2+ieYK09NQt12N1Pb
         gKfaYTqbwd7uY1lg88saCybSe/MukoIFM++tgDuV3057/dPcS5Crbmp3u1rxNyCG3Yvw
         bFrSraUWHeLs6go9xfRuRoLEmMdJGzyPXa6Nt9XVlNsFGb+FSEuhprfgD/uNvtMBHokQ
         MRN8pTDBEvgBLWaXT6i3mkG+DN4EQQwHWeAnBJAcwok9xtIsm+TlVBIstiGpy321oOLx
         AcBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vczVhc3OPBbJJv7puS37X+vgFWWnV3V2UNdSHwQBMYc=;
        b=vT65OFtEM9K19qg7s3PN3m/KS6uOuBPi/+MJ7R+AWTW5ag409a6etdOsAXZr1m5YmH
         P9mmVAm3Q3uGvOyrr4lL/jtKHbIEj2l2rqiInnk8q2dezhGSoAC9zC2dW8k4x571gJkF
         K0+NvTSvQOXeehqJ9fmJ98GvA8Jskb/v/XewA32QlvgCZcktY+3sO50ndkUsuAJqJMgA
         RaMoCU6QLjgnKSVJ4y3stXGqGkFQWPFTzuTlOd4Dx3zEmzoskUPcLmstlvyU4Ien4zVg
         35BOEU0DVlODFgRPM+NdR0q+prSnFbmXQhsfLrQaSGWEHqHga2udWJS3g1m25cmJ6tzW
         O58Q==
X-Gm-Message-State: ACrzQf1iKqZMop8AJ82AFBIFU2MBOgZiJMntJPII9xRjEqIT1uKSEAKn
        haOzGWNOUfgbK8aiErq88tk=
X-Google-Smtp-Source: AMsMyM58sIvXMQ7yJf2mzm4IBOjz5GUtQrFbrW0f3mcVLNuEfr7CyNdtZn7qfMBPLBJqthPifEvL5g==
X-Received: by 2002:a05:6402:1ca9:b0:461:30d8:6742 with SMTP id cz9-20020a0564021ca900b0046130d86742mr601164edb.172.1667741693392;
        Sun, 06 Nov 2022 05:34:53 -0800 (PST)
Received: from localhost.localdomain (ip5f5abba7.dynamic.kabel-deutschland.de. [95.90.187.167])
        by smtp.gmail.com with ESMTPSA id lj18-20020a170906f9d200b007adade0e9easm2103614ejb.85.2022.11.06.05.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 05:34:52 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: r8188eu: clean up error handling in rtw_start_drv_threads()
Date:   Sun,  6 Nov 2022 14:34:43 +0100
Message-Id: <20221106133443.8872-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.38.0
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

Convert the error handling in the function rtw_start_drv_threads() to
the common logic used in the kernel. Another step to get rid of _FAIL
and _SUCCESS which uses inverted logic.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/osdep_intf.h |  2 +-
 drivers/staging/r8188eu/os_dep/os_intfs.c    | 17 +++++++----------
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/r8188eu/include/osdep_intf.h b/drivers/staging/r8188eu/include/osdep_intf.h
index 0f7d74a3ff6d..6d66cb57225e 100644
--- a/drivers/staging/r8188eu/include/osdep_intf.h
+++ b/drivers/staging/r8188eu/include/osdep_intf.h
@@ -46,7 +46,7 @@ u8 rtw_init_drv_sw(struct adapter *padapter);
 void rtw_free_drv_sw(struct adapter *padapter);
 void rtw_reset_drv_sw(struct adapter *padapter);
 
-u32 rtw_start_drv_threads(struct adapter *padapter);
+int rtw_start_drv_threads(struct adapter *padapter);
 void rtw_stop_drv_threads (struct adapter *padapter);
 void rtw_cancel_all_timer(struct adapter *padapter);
 
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index 970f380bac96..66556e07ed93 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -363,18 +363,16 @@ struct net_device *rtw_init_netdev(struct adapter *old_padapter)
 	return pnetdev;
 }
 
-u32 rtw_start_drv_threads(struct adapter *padapter)
+int rtw_start_drv_threads(struct adapter *padapter)
 {
-	u32 _status = _SUCCESS;
-
 	padapter->cmdThread = kthread_run(rtw_cmd_thread, padapter, "RTW_CMD_THREAD");
 	if (IS_ERR(padapter->cmdThread))
-		_status = _FAIL;
-	else
-		/* wait for rtw_cmd_thread() to start running */
-		wait_for_completion(&padapter->cmdpriv.start_cmd_thread);
+		return PTR_ERR(padapter->cmdThread);
 
-	return _status;
+	/* wait for rtw_cmd_thread() to start running */
+	wait_for_completion(&padapter->cmdpriv.start_cmd_thread);
+
+	return 0;
 }
 
 void rtw_stop_drv_threads(struct adapter *padapter)
@@ -627,8 +625,7 @@ static int _netdev_open(struct net_device *pnetdev)
 
 		netdev_dbg(pnetdev, "MAC Address = %pM\n", pnetdev->dev_addr);
 
-		status = rtw_start_drv_threads(padapter);
-		if (status == _FAIL) {
+		if (rtw_start_drv_threads(padapter)) {
 			pr_info("Initialize driver software resource Failed!\n");
 			goto netdev_open_error;
 		}
-- 
2.38.0


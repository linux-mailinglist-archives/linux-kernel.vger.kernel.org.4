Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2B45F239B
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 16:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiJBOgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 10:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiJBOf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 10:35:58 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2878527FFA
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 07:35:56 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id f1so130593ejw.7
        for <linux-kernel@vger.kernel.org>; Sun, 02 Oct 2022 07:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=xsuu8vyf1+aAPyNecXht7B3Pctw9nXXV9eZ/TWvWGoE=;
        b=dZDQGqbD6lR7qmL7ye8w0iSe0nBCWd47e9LDFYJARpDBC4rK1RSSLff9POoZL+skSk
         FoNBSC8jpyyXLYzRUSomOmbBBL1lKj2Xp6q1S1rArRyoFlV7/TLQbRpPXMRbsFH8dJmx
         QiFPabNl+rxIr4s0WehJMNdm1VW9m0UDM1CBl94EC0qWqwsb8tQIMdNDLd96eo9xcDw+
         wEV6fzuCa9eRKe5azrbdPYLg82qkNWDJMgUbJ79S1acuoeUVe5MF69mQUHm8RyBu/7J9
         mGzeZy/6QZKj8ddp/t6SxDf+MoErKTFiAlZVFPnFLD3s/DjheHIxTokvXcS/Ic1IJ29j
         T+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=xsuu8vyf1+aAPyNecXht7B3Pctw9nXXV9eZ/TWvWGoE=;
        b=aQNO1l2+H/4SYygDdTXlKHLXDpc9mbW6JcmipmlI8ytSDb1ubQQo8izxKHw6kjcbNp
         2yWuA2D2Ug77bW18XZ4XUzNT99MHsZwmQ401lSJf8dhB+d+GdEs0UDAFI+MdYjmgHExY
         2E5f8VCIIJmPZODa/0h/vVLX6GmzUtT4X95ML5jpKsE3GMTZ+W9wRMRs5dqvGVX+zbzB
         kq+rGGD0RnNS5EqKtd+WvzPpChZ6WhNUgeZkc1C4RkMKHkpU5rsDm0c0WHbFUeit2rGV
         Hbmj7gyHb5oplQ6R/8k0WvlbkTmxZYdzuiIdx6xhb2CTlZYwENrJbDBxy7Y7wR9a4Of4
         PiVg==
X-Gm-Message-State: ACrzQf2NT/Fld999F/PJMgfmRmVAWHj20X09xWWupwel5Gw13VQ6Z8Hc
        +D6b9qy5UbvbUa1MsD3jEkg=
X-Google-Smtp-Source: AMsMyM530FLxsZ7RWNwOQOtzduGbjqr62XL42tL9uV0gwovJKdz5DWpf6aMKQ4HyJ3tz9GK8qdnJqQ==
X-Received: by 2002:a17:906:794c:b0:783:ce42:4d2 with SMTP id l12-20020a170906794c00b00783ce4204d2mr12197229ejo.517.1664721354732;
        Sun, 02 Oct 2022 07:35:54 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb59.dynamic.kabel-deutschland.de. [95.90.187.89])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906301100b00731582babcasm4082334ejz.71.2022.10.02.07.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Oct 2022 07:35:54 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/2] staging: r8188eu: convert rtw_free_drv_sw() to void
Date:   Sun,  2 Oct 2022 16:35:44 +0200
Message-Id: <20221002143544.7974-3-straube.linux@gmail.com>
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

The function rtw_free_drv_sw() always returns _SUCCESS. None of its
callers use the return value. Convert the return type of that function
from u8 to void. This is part of getting rid of _FAIL / _SUCCESS.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/osdep_intf.h | 2 +-
 drivers/staging/r8188eu/os_dep/os_intfs.c    | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/include/osdep_intf.h b/drivers/staging/r8188eu/include/osdep_intf.h
index ce8e1bc4a61c..0f7d74a3ff6d 100644
--- a/drivers/staging/r8188eu/include/osdep_intf.h
+++ b/drivers/staging/r8188eu/include/osdep_intf.h
@@ -43,7 +43,7 @@ int netdev_open(struct net_device *pnetdev);
 int netdev_close(struct net_device *pnetdev);
 
 u8 rtw_init_drv_sw(struct adapter *padapter);
-u8 rtw_free_drv_sw(struct adapter *padapter);
+void rtw_free_drv_sw(struct adapter *padapter);
 void rtw_reset_drv_sw(struct adapter *padapter);
 
 u32 rtw_start_drv_threads(struct adapter *padapter);
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index 2983e665bd5c..38e324754c8f 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -548,7 +548,7 @@ void rtw_cancel_all_timer(struct adapter *padapter)
 	_cancel_timer_ex(&padapter->recvpriv.signal_stat_timer);
 }
 
-u8 rtw_free_drv_sw(struct adapter *padapter)
+void rtw_free_drv_sw(struct adapter *padapter)
 {
 	/* we can call rtw_p2p_enable here, but: */
 	/*  1. rtw_p2p_enable may have IO operation */
@@ -585,8 +585,6 @@ u8 rtw_free_drv_sw(struct adapter *padapter)
 	/*  clear pbuddystruct adapter to avoid access wrong pointer. */
 	if (padapter->pbuddy_adapter)
 		padapter->pbuddy_adapter->pbuddy_adapter = NULL;
-
-	return _SUCCESS;
 }
 
 void netdev_br_init(struct net_device *netdev)
-- 
2.37.3


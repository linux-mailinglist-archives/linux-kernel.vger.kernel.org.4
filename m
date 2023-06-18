Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2454B734638
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 15:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjFRNGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 09:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjFRNGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 09:06:33 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9C71AB
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 06:06:32 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b55643507dso5581065ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 06:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687093592; x=1689685592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GrnRiINtmKsRPpdoYY28cns2m1Iqy+OAFvN9buTT+SU=;
        b=lZexxq7P3XtuZPtJJ5JNGgBbfUyPOyFIcg0Cf1k4PZUWTiouPub2JaLA0sUnZcqg7y
         sy5cTPc8wRDhABm2qeP7wQoyi0q2O/BZ00wmncwqtaP9WQssMnaKjq2B7BNnAz65FZlh
         RIKRJwVBJJF37fYkkIYX99CbN0gm0IFO+oHkUOjKLprNovaxDt6jlgDinvY+2IXrHbnB
         JyuAmnC1ULxFXQ1qWSvx6rpRoeM41/DR8Q6fnD8Nhty+eBdBVXAgJy163iv1sdu+MNQe
         xzh9ruZlmDgiDQzy8g4Chp4nDMXrKUP83aje03f68VOk3J8wzM/aPqwowMPLmk9ArNt6
         h28g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687093592; x=1689685592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GrnRiINtmKsRPpdoYY28cns2m1Iqy+OAFvN9buTT+SU=;
        b=OPqp0nJKXvkOTWZUkSJj+FszSArK42fvLW7ryGsOqkXOQQaeljZ0mOmfsTqi299HPi
         t7TZpPefxIKlpo9/T81+IZlN5FGmyTicBSBbRmp49uGanUCmWYkqipiEAnUtcmAav2ho
         VIyzm5XhSrRu2F2aylC1FZQmuCL8K/3Mg3krX/QSEiP/qhx5g1Mkp32QsSrWRB3LRZ/Z
         AI8tuZUNq3PvrX7uRsIEzI18SeGOvgQYZmSIov8/zMuWM5aIkGn44lRn9UxIQy/oEgcd
         +9ImnMNESfDCvL1GkUPcj7mstsgKgSMc6+emQyqyvaTJacyCe6Up5gFfjbtbRc+FH0Kh
         Oraw==
X-Gm-Message-State: AC+VfDx0KSOC693sjcnTFrtNS7iL9jlYZW1jL+Zm0OmaGTuicO5iZAa6
        lOpgPsIkztMxsgP7NL9pQNc=
X-Google-Smtp-Source: ACHHUZ7u0MlTI1QnE1/QfcX+1B04t7ijeC3d4SMCyrPu+0RQ8QpwZMt4KJuaa1PbrX26Fyi54isqOw==
X-Received: by 2002:a17:902:ee41:b0:1b3:de1d:1ce1 with SMTP id 1-20020a170902ee4100b001b3de1d1ce1mr6859808plo.61.1687093592061;
        Sun, 18 Jun 2023 06:06:32 -0700 (PDT)
Received: from zephyrusG14 ([103.251.210.211])
        by smtp.gmail.com with ESMTPSA id s11-20020a170902ea0b00b001b23eb0b4bbsm18670943plg.147.2023.06.18.06.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 06:06:31 -0700 (PDT)
Date:   Sun, 18 Jun 2023 18:36:26 +0530
From:   Yogesh Hegde <yogi.kernel@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     dan.carpenter@linaro.org, philipp.g.hortmann@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, ivan.orlov0322@gmail.com
Subject: [PATCH v3 3/4] staging: rtl8192e: Rename variable LeisurePSLeave
Message-ID: <b45c35593a3b080814cc3fc882907dfc1d367d76.1687092111.git.yogi.kernel@gmail.com>
References: <cover.1687092111.git.yogi.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1687092111.git.yogi.kernel@gmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable LeisurePSLeave to leisure_ps_leave to avoid
CamelCase which is not accepted by checkpatch.

Signed-off-by: Yogesh Hegde <yogi.kernel@gmail.com>
---

v3: Revert back to v1 of the patch as suggested by Greg Kroah-Hartman
    <gregkh@linuxfoundation.org>.

v2: Removed the variable and called the function directly instead of
    just renaming the variable as suggested by Greg Kroah-Hartman
    <gregkh@linuxfoundation.org>.
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h            | 2 +-
 drivers/staging/rtl8192e/rtllib_rx.c         | 2 +-
 drivers/staging/rtl8192e/rtllib_softmac_wx.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 68e921a3a0a8..b82d2b7aa26c 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -717,7 +717,7 @@ static void _rtl92e_init_priv_handler(struct net_device *dev)
 	priv->rtllib->handle_assoc_response	= _rtl92e_handle_assoc_response;
 	priv->rtllib->handle_beacon		= _rtl92e_handle_beacon;
 	priv->rtllib->set_wireless_mode		= rtl92e_set_wireless_mode;
-	priv->rtllib->LeisurePSLeave		= rtl92e_leisure_ps_leave;
+	priv->rtllib->leisure_ps_leave		= rtl92e_leisure_ps_leave;
 	priv->rtllib->set_bw_mode_handler	= rtl92e_set_bw_mode;
 	priv->rf_set_chan			= rtl92e_set_channel;
 
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index e79510258447..0ee9b99b4c5e 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1721,7 +1721,7 @@ struct rtllib_device {
 
 	void (*rtllib_ips_leave_wq)(struct net_device *dev);
 	void (*rtllib_ips_leave)(struct net_device *dev);
-	void (*LeisurePSLeave)(struct net_device *dev);
+	void (*leisure_ps_leave)(struct net_device *dev);
 
 	/* This must be the last item so that it points to the data
 	 * allocated beyond this structure by alloc_rtllib
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 46c77ed335ab..c00f72316a3d 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -1200,7 +1200,7 @@ static void rtllib_rx_check_leave_lps(struct rtllib_device *ieee, u8 unicast,
 			if (((ieee->link_detect_info.NumRxUnicastOkInPeriod +
 			    ieee->link_detect_info.NumTxOkInPeriod) > 8) ||
 			    (ieee->link_detect_info.NumRxUnicastOkInPeriod > 2)) {
-				ieee->LeisurePSLeave(ieee->dev);
+				ieee->leisure_ps_leave(ieee->dev);
 			}
 		}
 	}
diff --git a/drivers/staging/rtl8192e/rtllib_softmac_wx.c b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
index 6a7738a828e1..d7df6f698c0c 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
@@ -316,7 +316,7 @@ void rtllib_wx_sync_scan_wq(void *data)
 
 	chan = ieee->current_network.channel;
 
-	ieee->LeisurePSLeave(ieee->dev);
+	ieee->leisure_ps_leave(ieee->dev);
 	/* notify AP to be in PS mode */
 	rtllib_sta_ps_send_null_frame(ieee, 1);
 	rtllib_sta_ps_send_null_frame(ieee, 1);
-- 
2.34.1


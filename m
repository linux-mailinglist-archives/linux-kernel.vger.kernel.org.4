Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58832735957
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 16:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbjFSOS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 10:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjFSOSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 10:18:52 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6E0E66
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 07:18:41 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-543c6a2aa07so1788474a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 07:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687184321; x=1689776321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BmCAzAWDqWS9Ad0kyeEiBkiBoZ6up2YMzFBEN+N0Ip8=;
        b=B6WVAJqDiJLAXG9b4ZGy2XIQ6HiOn9GqBMho/mof+muGY9bmLwcprdE2HEkGOuOPyN
         XixtGDPtJuERtpjsx61nxjcEd4lhmTYbGIj6PVeSy+66t/wVTxelZZZLGBqo1lGC9nof
         zmMi+YxGcvXTFfJKU9M70asligvSN8duXvlEHhsn47UHI5sVmHiSyo3XvEK3yaSzxNO8
         qkp5U0k4sUHQE9NaJbm4Wu8e5CVMHX638sn1Ud+n58qr/any+eAskGGjSR0pD44b3xQz
         n+NmyXPFcQzRmO7Aby1NhzACk6Come91GOKeppfkHG8G+mh8j0HQ8Ge47zcAO51JVg/A
         DeIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687184321; x=1689776321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BmCAzAWDqWS9Ad0kyeEiBkiBoZ6up2YMzFBEN+N0Ip8=;
        b=lvxDo81UGNAz03lp2E41XSkXrCvfYesvWQWVfVEtfxLOwsEwYKZ/pmrZQafENOhuGm
         od8kMGUNsBI0ZqL8PFKDmaTeBE4zfsfGCSIrU/nUCGtCF+TP02D6q7qzDZN7e/T2wtqc
         6fI69eKOTldP0W/qn7PK79n7H5GoBQHqJwk8M2dU6QS27ABYkQc/TE38yph23yF+48jN
         /IxFrZyhXevmp1voHGf19jP4zHQ/uMT6gPTlR2dLEMFnCBcDs2Ti2n71petybSZAT7U7
         3VT8AUaAoDKj6Jc/7IQKeWQoF5RRytTNdK6RgelzMP+WIEC9zBXkH8FXYxBKBIdVECXq
         cihQ==
X-Gm-Message-State: AC+VfDyxTaXt3JDjUrlnPQchxljGbKxWVs5vAsPj9ezf/YO5jZrsEMQL
        3RZlTmn4JstdMgg0VF24LkY=
X-Google-Smtp-Source: ACHHUZ7xcDBg/eJwQDcCky0Y+QeQEEzc/J98U66tVAhRlEpnXikDQCsDUqHM+TSU/Vf+gTWZvfIr6Q==
X-Received: by 2002:a17:902:ab17:b0:1b4:65c3:ca68 with SMTP id ik23-20020a170902ab1700b001b465c3ca68mr6448951plb.66.1687184320743;
        Mon, 19 Jun 2023 07:18:40 -0700 (PDT)
Received: from zephyrusG14 ([103.251.210.211])
        by smtp.gmail.com with ESMTPSA id d4-20020a170903230400b001a67759f9f8sm18819812plh.106.2023.06.19.07.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 07:18:40 -0700 (PDT)
Date:   Mon, 19 Jun 2023 19:48:36 +0530
From:   Yogesh Hegde <yogi.kernel@gmail.com>
To:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     dan.carpenter@linaro.org, philipp.g.hortmann@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, ivan.orlov0322@gmail.com
Subject: [PATCH v4 3/4] staging: rtl8192e: Rename variable LeisurePSLeave
Message-ID: <3c63f4d750b7365f233c35c676325c5e4ca54a4c.1687183827.git.yogi.kernel@gmail.com>
References: <cover.1687183827.git.yogi.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1687183827.git.yogi.kernel@gmail.com>
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

v4: Rebase to latest staging-testing branch as suggested by Greg Kroah-Hartman
    <gregkh@linuxfoundation.org>.

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
index a06d1c4e778a..631cbe016ea9 100644
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
index b3d6699b31ed..37e6fcd4b1ec 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1703,7 +1703,7 @@ struct rtllib_device {
 
 	void (*rtllib_ips_leave_wq)(struct net_device *dev);
 	void (*rtllib_ips_leave)(struct net_device *dev);
-	void (*LeisurePSLeave)(struct net_device *dev);
+	void (*leisure_ps_leave)(struct net_device *dev);
 
 	/* This must be the last item so that it points to the data
 	 * allocated beyond this structure by alloc_rtllib
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 78d13ff1f14e..91dd3c373aef 100644
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
index d8c7b7377132..de3db873f305 100644
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A3B6A2B4A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 19:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjBYSVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 13:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjBYSVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 13:21:12 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD01EF9B
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 10:20:54 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id q16so2333295wrw.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 10:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677349253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pQfE6owmx25R9kpYaCFxHRafZIy5ewbzgQeY1A/MnUs=;
        b=NHG1Jgf18DnO1h8grz2aXe2DhmHOhucgvLlvFwzZDWtjWqruRlE5EB0CR2c8lHzmlL
         Y3/L8uer/t3Mrj2USY4BZG8LXC4G0ANpRuEJQjd1ejJZuBccAiAoZ1IgK9K9WHp9kZNA
         A0e+Z4vWuyq03m457GjSqGjxVUFEh6O31AQwnPcJj6sViKXUzXjOqfTj7Sqo/oq5nRAK
         +sY0cw7JMeWXaDXBffJGMkVmEKpF9otsR1dHBtiTIyk69JD2TMeiYUi+sc8H6XSmphEH
         Mpz850LHpgwnLU27UEowF7UoCZM63bSMlknlWurSDxrsQnSyB0/sZSPuHzERD3aNyAmq
         6Z4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677349253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQfE6owmx25R9kpYaCFxHRafZIy5ewbzgQeY1A/MnUs=;
        b=Dq1aVtYqdY/vcIZVk9ctMr5r/yFGyEO3+UQ0oNutQkdBkpcHe6QS8+BWwYhC1czsy7
         OAHTdb+bHFIoO49j0WJiaX5/F07JEqSUwQNflDefv8icLxdxJD1RomM54dhmdAKwg16T
         7VLzol9oLEu2NKxYnon/Dv2s32JfZFBJv/3gu5DxN0V92z/uTgSIa0QxG5wUnIkZ6a1M
         x4pv8cuQUtc13pV0wFGZ+efYD9ySCdF8Lb50Kbhp4YTTFqvBUbvRvI3oNEkpJWrOeU3Q
         PBpG1VA4Aq8ukG2ecAvlvftAoZlF/itRvXuMzLl92gDTeZJILRpqNQUEC+djrqo/FExp
         q1+A==
X-Gm-Message-State: AO0yUKUIfoRa3OUNcGA8pOmZJBZrJmAR2K4Nub80qyCmv18iFwMoQFKr
        5q1nuCBW8W2I85Tm5BMRvc4=
X-Google-Smtp-Source: AK7set/L/NtX8fyS60aJUMEv9ZTL6L153IChak5NBsXvwU+LDhkSU4/wRze1ZfIEAqOm4PU3ooBYTA==
X-Received: by 2002:adf:fb0f:0:b0:2c7:b5ef:9695 with SMTP id c15-20020adffb0f000000b002c7b5ef9695mr3493681wrr.3.1677349252894;
        Sat, 25 Feb 2023 10:20:52 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id y14-20020adfee0e000000b002c71b4d476asm2370349wrn.106.2023.02.25.10.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 10:20:52 -0800 (PST)
Date:   Sat, 25 Feb 2023 19:20:50 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] staging: rtl8192e: Remove checks of pointer to rtllib..
 and ScanOpera..
Message-ID: <8b01cbfaad2db4666b98bfeae29dd429d8c6cd07.1677345331.git.philipp.g.hortmann@gmail.com>
References: <cover.1677345331.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1677345331.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function pointers of rtllib_ips_leave and ScanOperationBackupHandler is
set while executing the probe function. Therefore a NULL pointer check is
not required. Remove checks as it is dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 3 +--
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c   | 8 ++------
 drivers/staging/rtl8192e/rtllib_softmac.c    | 6 ++----
 drivers/staging/rtl8192e/rtllib_softmac_wx.c | 6 ++----
 4 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 718d69b4ce16..47feb4248d25 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -703,8 +703,7 @@ static int _rtl92e_sta_down(struct net_device *dev, bool shutdownrf)
 	if (priv->up == 0)
 		return -1;
 
-	if (priv->rtllib->rtllib_ips_leave)
-		priv->rtllib->rtllib_ips_leave(dev);
+	priv->rtllib->rtllib_ips_leave(dev);
 
 	if (priv->rtllib->state == RTLLIB_LINKED)
 		rtl92e_leisure_ps_leave(dev);
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
index bf0030144e5d..cb28288a618b 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
@@ -432,15 +432,11 @@ static int _rtl92e_wx_set_scan(struct net_device *dev,
 		if (priv->rtllib->rf_power_state != rf_off) {
 			priv->rtllib->actscanning = true;
 
-			if (ieee->ScanOperationBackupHandler)
-				ieee->ScanOperationBackupHandler(ieee->dev,
-							 SCAN_OPT_BACKUP);
+			ieee->ScanOperationBackupHandler(ieee->dev, SCAN_OPT_BACKUP);
 
 			rtllib_start_scan_syncro(priv->rtllib, 0);
 
-			if (ieee->ScanOperationBackupHandler)
-				ieee->ScanOperationBackupHandler(ieee->dev,
-							 SCAN_OPT_RESTORE);
+			ieee->ScanOperationBackupHandler(ieee->dev, SCAN_OPT_RESTORE);
 		}
 		ret = 0;
 	} else {
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 7b73c5df5e2a..4923423aa85b 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1572,8 +1572,7 @@ static void rtllib_associate_procedure_wq(void *data)
 				     struct rtllib_device,
 				     associate_procedure_wq);
 	rtllib_stop_scan_syncro(ieee);
-	if (ieee->rtllib_ips_leave != NULL)
-		ieee->rtllib_ips_leave(ieee->dev);
+	ieee->rtllib_ips_leave(ieee->dev);
 	mutex_lock(&ieee->wx_mutex);
 
 	if (ieee->data_hard_stop)
@@ -2850,8 +2849,7 @@ void rtllib_stop_protocol(struct rtllib_device *ieee, u8 shutdown)
 	if (shutdown) {
 		ieee->proto_started = 0;
 		ieee->proto_stoppping = 1;
-		if (ieee->rtllib_ips_leave != NULL)
-			ieee->rtllib_ips_leave(ieee->dev);
+		ieee->rtllib_ips_leave(ieee->dev);
 	}
 
 	rtllib_stop_send_beacons(ieee);
diff --git a/drivers/staging/rtl8192e/rtllib_softmac_wx.c b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
index f90764d1d9ab..06f1d6de5cc7 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
@@ -355,8 +355,7 @@ void rtllib_wx_sync_scan_wq(void *data)
 	/* wait for ps packet to be kicked out successfully */
 	msleep(50);
 
-	if (ieee->ScanOperationBackupHandler)
-		ieee->ScanOperationBackupHandler(ieee->dev, SCAN_OPT_BACKUP);
+	ieee->ScanOperationBackupHandler(ieee->dev, SCAN_OPT_BACKUP);
 
 	if (ieee->ht_info->bCurrentHTSupport && ieee->ht_info->enable_ht &&
 	    ieee->ht_info->bCurBW40MHz) {
@@ -381,8 +380,7 @@ void rtllib_wx_sync_scan_wq(void *data)
 		ieee->set_chan(ieee->dev, chan);
 	}
 
-	if (ieee->ScanOperationBackupHandler)
-		ieee->ScanOperationBackupHandler(ieee->dev, SCAN_OPT_RESTORE);
+	ieee->ScanOperationBackupHandler(ieee->dev, SCAN_OPT_RESTORE);
 
 	ieee->state = RTLLIB_LINKED;
 	ieee->link_change(ieee->dev);
-- 
2.39.2


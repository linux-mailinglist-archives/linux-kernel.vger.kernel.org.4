Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070ED6BF18A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 20:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjCQTOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 15:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjCQTOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 15:14:24 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC86E41D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 12:13:57 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id w9so24321634edc.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 12:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679080435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Toyfbf+SoovM/Ffd1wohbkyOgiucLUqCVM5bj6+KSwQ=;
        b=P8CxN2t50zW4sh14dk+9j5eTgQg32NMyiv6U8kkgMQLC4bR/jtw9+wmNXHnqx8gS7E
         t4DpMRZyR1Zu2xahz4BmIxZXOusyiZ1/W1S1gPGNSp8LxrvYSEX2zrPfMzoDxl4qRjUI
         ouWK+qESjcCcJRpgwbE+j4FY8cYQxZXmSf/t3t2sdDHoqFjwY/5Ucp3qIgFFgNAwNS6e
         ttZ4Y/Y041latFqYcvj5zq1oDIISju8Z7FjaERojtbVldrs/TLlgG/Ma6bOqfeRjQLLH
         nZQTZbTYVhBmyncePjHa7LgInBm/PCinzJ8oP0ioObTBalz9ouw8rHkprMxOrJZPn7XC
         bE4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679080435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Toyfbf+SoovM/Ffd1wohbkyOgiucLUqCVM5bj6+KSwQ=;
        b=Y9UPlmP38mSAYAUdP9Ga5HjjILU/qkVjQIw8v1diBm3WrLNVEwXWS6dZY/SO1CQkW8
         K+OZHgXAUn6UfXu1uET68eR3HA2xdg6lxOberidbTZJ3GsGB91iZ0J47C5+B/VMlxfiq
         PaRQEF+GTRMCExGv778jPqMJ4om3eRs9/EPPqm0h5PZ/tEG+QdQgUIj442Y+Tc1VxNK5
         sfE35Fb0keMeAhkRuZ21T+ymbHvYtDK+WU6ZqgQn52S16lTpZ6TtMF51d+LgArLpuBoM
         lgIxfeoJ8aJg8LDdXPPILdGsrLS0ai4tESFw6Ofn3Fc6al3iUnsLbjhZ9qPbyYIGlECo
         hanA==
X-Gm-Message-State: AO0yUKU2NEZkYI0uz3o/fWUIu0ubK/Oei//sK/YsN/us0YJrdSUg0Glj
        +AC4d8q5WGrIKi31yqGNha4n3NYkTQg=
X-Google-Smtp-Source: AK7set/wdsH6FlZkPBPD2JR2ngRz2Neejya28b62B4zMgKKReOcRu4htp6mJKOJ3jZkOd+mac9c8vA==
X-Received: by 2002:a17:906:7399:b0:92b:dd20:16f5 with SMTP id f25-20020a170906739900b0092bdd2016f5mr7994154ejl.7.1679080434958;
        Fri, 17 Mar 2023 12:13:54 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id k8-20020a17090627c800b008d1693c212csm1273935ejc.8.2023.03.17.12.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 12:13:54 -0700 (PDT)
Date:   Fri, 17 Mar 2023 20:13:52 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] staging: rtl8192e: Replace macro container_of_work_rsl
 with standard f.
Message-ID: <58fa53b80fd866f2057d236f78144dda34d6f263.1679077522.git.philipp.g.hortmann@gmail.com>
References: <cover.1679077522.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1679077522.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace macro container_of_work_rsl with standard function container_of
to increase readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 9 +++------
 drivers/staging/rtl8192e/rtl8192e/rtl_ps.c   | 3 +--
 drivers/staging/rtl8192e/rtllib.h            | 1 -
 drivers/staging/rtl8192e/rtllib_softmac.c    | 2 +-
 drivers/staging/rtl8192e/rtllib_softmac_wx.c | 3 +--
 5 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index ea07b350b62a..3244aef12c05 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -311,8 +311,7 @@ static const struct rtllib_qos_parameters def_qos_parameters = {
 
 static void _rtl92e_update_beacon(void *data)
 {
-	struct r8192_priv *priv = container_of_work_rsl(data, struct r8192_priv,
-				  update_beacon_wq.work);
+	struct r8192_priv *priv = container_of(data, struct r8192_priv, update_beacon_wq.work);
 	struct net_device *dev = priv->rtllib->dev;
 	struct rtllib_device *ieee = priv->rtllib;
 	struct rtllib_network *net = &ieee->current_network;
@@ -326,8 +325,7 @@ static void _rtl92e_update_beacon(void *data)
 
 static void _rtl92e_qos_activate(void *data)
 {
-	struct r8192_priv *priv = container_of_work_rsl(data, struct r8192_priv,
-				  qos_activate);
+	struct r8192_priv *priv = container_of(data, struct r8192_priv, qos_activate);
 	struct net_device *dev = priv->rtllib->dev;
 	int i;
 
@@ -2033,8 +2031,7 @@ void rtl92e_commit(struct net_device *dev)
 
 static void _rtl92e_restart(void *data)
 {
-	struct r8192_priv *priv = container_of_work_rsl(data, struct r8192_priv,
-				  reset_wq);
+	struct r8192_priv *priv = container_of(data, struct r8192_priv, reset_wq);
 	struct net_device *dev = priv->rtllib->dev;
 
 	mutex_lock(&priv->wx_mutex);
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c b/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
index ef4f736ce325..5a1cd22f5e25 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
@@ -142,8 +142,7 @@ void rtl92e_ips_leave(struct net_device *dev)
 
 void rtl92e_ips_leave_wq(void *data)
 {
-	struct rtllib_device *ieee = container_of_work_rsl(data,
-				     struct rtllib_device, ips_leave_wq);
+	struct rtllib_device *ieee = container_of(data, struct rtllib_device, ips_leave_wq);
 	struct net_device *dev = ieee->dev;
 	struct r8192_priv *priv = (struct r8192_priv *)rtllib_priv(dev);
 
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index aa39f8b2bf09..669a9d9a5d18 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -62,7 +62,6 @@
 #define IW_CUSTOM_MAX	256	/* In bytes */
 #endif
 
-#define container_of_work_rsl(x, y, z) container_of(x, y, z)
 #define container_of_dwork_rsl(x, y, z)				\
 	container_of(to_delayed_work(x), y, z)
 
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 91fb5f150a00..b9886e83a6dc 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1498,7 +1498,7 @@ static void rtllib_associate_step2(struct rtllib_device *ieee)
 static void rtllib_associate_complete_wq(void *data)
 {
 	struct rtllib_device *ieee = (struct rtllib_device *)
-				     container_of_work_rsl(data,
+				     container_of(data,
 				     struct rtllib_device,
 				     associate_complete_wq);
 	struct rt_pwr_save_ctrl *psc = &ieee->pwr_save_ctrl;
diff --git a/drivers/staging/rtl8192e/rtllib_softmac_wx.c b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
index 06f1d6de5cc7..1f2fa711e60b 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
@@ -326,8 +326,7 @@ EXPORT_SYMBOL(rtllib_wx_set_mode);
 
 void rtllib_wx_sync_scan_wq(void *data)
 {
-	struct rtllib_device *ieee = container_of_work_rsl(data,
-				     struct rtllib_device, wx_sync_scan_wq);
+	struct rtllib_device *ieee = container_of(data, struct rtllib_device, wx_sync_scan_wq);
 	short chan;
 	enum ht_extchnl_offset chan_offset = 0;
 	enum ht_channel_width bandwidth = 0;
-- 
2.39.2


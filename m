Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3AE56BF187
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 20:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjCQTON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 15:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjCQTOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 15:14:11 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9D5E1FD0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 12:13:49 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id cy23so24167889edb.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 12:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679080427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JECvJ/K7E4yzQQFzJdiJ4lI6M7UJm3etUVtp/7RJfO0=;
        b=ZDQWi+ruPIg0G7N1WLOmgrTJdAETbuUbp4EiT0FBT5d3uj8cz9XfxioQJct/kgjey7
         V9LV+gBmkKwAdUNJOhaE3ONqW/g8mqs/kIcdx1Hih6grFgSTjNrtlE60sQanMmygQ/dA
         6LmWKzAuUG9tie6ce9+xkz1dIS8gAUBRjPkPJyJaqBeYH1zZlO8E8T6ubR0iyUal/dCj
         72zCQKu0yX2qnLP30sh35ku3XpKcpGZs3EXdoHICfcOLAHMSapBEto6B6iVvA9GptXOS
         2ct6k+7w9ztNOZ0U9BJTCo89RdiDe/dW+i+a/AGY7hiIjpKf5RMaxTmJxBmYaBhRv+Bj
         8AJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679080427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JECvJ/K7E4yzQQFzJdiJ4lI6M7UJm3etUVtp/7RJfO0=;
        b=jx2oGGuA0MBsXridXMVLIAKPis8z6YZiwSxYAeSXPLf8eMxPHK/W7QaLjShvWSfN6V
         cUPItW2wnoKnPxVmrFihH5t5yZ3Qh2upVvJiNDtw7a2HJkuqY+/9phEbz23NKmNXSHEm
         HEePQP0uiZMOVwZtHsNDddJsD4AtpiunpwGMPd9haYJdjcJzgCt037qNNwbH4eVU26Bd
         wR4bSSJZmkE9g8/Ic115RSCEdSMZta7N1m9xs+Pfvdn5jjvEgfJkoBQfRGqpaDp1olKW
         TDNFyQ9taE+K2XUtXlwK0jR3MbML2Ck5OFUxVMRiFhxECD1MS5CSDVWPMeEnDbLrTSl4
         xwNw==
X-Gm-Message-State: AO0yUKXlnvhFFrTeVbWWnfEZMCLitOQb/106CqQP0BGJmGm1eO4Mlr4T
        /JEoPUDZ18EUzv7cSyWyeHg=
X-Google-Smtp-Source: AK7set+6WGaX3+K8SqvjOOr6mdSz1pu0Gi63sVU1IaTvReUtHihVDxDNZkVRk/Y71DE5TV/ejgC3cA==
X-Received: by 2002:a05:6402:4413:b0:4bb:afe3:e0a with SMTP id y19-20020a056402441300b004bbafe30e0amr9497125eda.3.1679080427128;
        Fri, 17 Mar 2023 12:13:47 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id u6-20020a50d506000000b004fd2aab4953sm1458761edi.45.2023.03.17.12.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 12:13:46 -0700 (PDT)
Date:   Fri, 17 Mar 2023 20:13:45 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] staging: rtl8192e: Replace macro INIT_WORK_RSL with
 standard macro
Message-ID: <56290976510575f3b17ded786c452a9f6a52a7ee.1679077522.git.philipp.g.hortmann@gmail.com>
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

Replace macro INIT_WORK_RSL with standard macro INIT_WORK to increase
readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 7 +++----
 drivers/staging/rtl8192e/rtllib.h            | 2 --
 drivers/staging/rtl8192e/rtllib_softmac.c    | 6 ++----
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index a2263c41c6c8..ea07b350b62a 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -890,14 +890,13 @@ static void _rtl92e_init_priv_task(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 
-	INIT_WORK_RSL(&priv->reset_wq, (void *)_rtl92e_restart, dev);
-	INIT_WORK_RSL(&priv->rtllib->ips_leave_wq, (void *)rtl92e_ips_leave_wq,
-		      dev);
+	INIT_WORK(&priv->reset_wq, (void *)_rtl92e_restart);
+	INIT_WORK(&priv->rtllib->ips_leave_wq, (void *)rtl92e_ips_leave_wq);
 	INIT_DELAYED_WORK(&priv->watch_dog_wq, (void *)_rtl92e_watchdog_wq_cb);
 	INIT_DELAYED_WORK(&priv->txpower_tracking_wq, (void *)rtl92e_dm_txpower_tracking_wq);
 	INIT_DELAYED_WORK(&priv->rfpath_check_wq, (void *)rtl92e_dm_rf_pathcheck_wq);
 	INIT_DELAYED_WORK(&priv->update_beacon_wq, (void *)_rtl92e_update_beacon);
-	INIT_WORK_RSL(&priv->qos_activate, (void *)_rtl92e_qos_activate, dev);
+	INIT_WORK(&priv->qos_activate, (void *)_rtl92e_qos_activate);
 	INIT_DELAYED_WORK(&priv->rtllib->hw_wakeup_wq, (void *)rtl92e_hw_wakeup_wq);
 	INIT_DELAYED_WORK(&priv->rtllib->hw_sleep_wq, (void *)rtl92e_hw_sleep_wq);
 	tasklet_setup(&priv->irq_rx_tasklet, _rtl92e_irq_rx_tasklet);
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 8cbefa6dfd6e..aa39f8b2bf09 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -62,8 +62,6 @@
 #define IW_CUSTOM_MAX	256	/* In bytes */
 #endif
 
-#define INIT_WORK_RSL(x, y, z) INIT_WORK(x, y)
-
 #define container_of_work_rsl(x, y, z) container_of(x, y, z)
 #define container_of_dwork_rsl(x, y, z)				\
 	container_of(to_delayed_work(x), y, z)
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index c442fc98283d..91fb5f150a00 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -2998,13 +2998,11 @@ int rtllib_softmac_init(struct rtllib_device *ieee)
 
 	INIT_DELAYED_WORK(&ieee->link_change_wq, (void *)rtllib_link_change_wq);
 	INIT_DELAYED_WORK(&ieee->start_ibss_wq, (void *)rtllib_start_ibss_wq);
-	INIT_WORK_RSL(&ieee->associate_complete_wq,
-		      (void *)rtllib_associate_complete_wq, ieee);
+	INIT_WORK(&ieee->associate_complete_wq, (void *)rtllib_associate_complete_wq);
 	INIT_DELAYED_WORK(&ieee->associate_procedure_wq, (void *)rtllib_associate_procedure_wq);
 	INIT_DELAYED_WORK(&ieee->softmac_scan_wq, (void *)rtllib_softmac_scan_wq);
 	INIT_DELAYED_WORK(&ieee->associate_retry_wq, (void *)rtllib_associate_retry_wq);
-	INIT_WORK_RSL(&ieee->wx_sync_scan_wq, (void *)rtllib_wx_sync_scan_wq,
-		      ieee);
+	INIT_WORK(&ieee->wx_sync_scan_wq, (void *)rtllib_wx_sync_scan_wq);
 
 	mutex_init(&ieee->wx_mutex);
 	mutex_init(&ieee->scan_mutex);
-- 
2.39.2


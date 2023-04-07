Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2306DB5E7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 23:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbjDGVuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 17:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjDGVuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 17:50:37 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D2DC67E
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 14:50:31 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-930bc91df7bso151195066b.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 14:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680904231; x=1683496231;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eeN/ZVCekgyzBVdfluaI952fB28+NGzvtQuNBvQl0F4=;
        b=VY0sJqQ3cZGU0aI6sJKkIl5bCp7lmFG7XDgR9PfRzRPMjFABqmF4tgrEsEBerxguLO
         2zF0UVOU1FT91rXZ5zSy7Djb6Ml8udNz4CMKsT7r/Y5cYFAR+fV5sLzSIkg2gZx6VEzS
         BnYH6GfrKPXsY8OxehyIVu8+6cj96oZVchZJ6SAilDQYXDpE7fyUc/RbHvGg4mV0tUDk
         w0Qt/8AQ3+GL0psU4Dl7ggTRxRtTtqzB5Vnw4+ptmQf+0Oe2MOgmGz2fCSR9fA9eNIZV
         b1elK/+TEojuUT8C2R+fx1UduVNHNoX60uqTqCHMwQjQ64jveRJQqKLyhyznlM0uGQ3N
         T7Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680904231; x=1683496231;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eeN/ZVCekgyzBVdfluaI952fB28+NGzvtQuNBvQl0F4=;
        b=nfDLC5/QQhyL3ZMzoXix8DtVL1gZhn2HmruSkUSHyu9xGkXsfvGAIc8EfE5j6lJjR+
         8ukRDFBxwqlQMWV8jQ25gEF/mFmYBbvfnSOgq/ivkcUfkWOYTB5RPhrmwFFTEDmiBDLZ
         U7e/3I0g6p4TFcvL3uH6ESu51uR12cfDbOZgJ25L+WwrK1wYmvMvGCP1aeTWgbxg6vFi
         r0sHhEt/ZEY8+U2XlBHh9Bm9uH6ODYsnOKpVMuVO2jxLP5Fm4r3aMPW8MNBtDV420aJa
         mk0SNhkaW7Euda8DUpwKBLztc2dg1SxFEUB3AuSSm5rkGlebyfGtKu6SqNYvKR8zySLV
         2F4g==
X-Gm-Message-State: AAQBX9eQ4WuKn4H1dJNur11EHtjy/ZEUGQpGPxSpR06y0ta7jSTcNSgo
        CbVSDoiHcJm/YHKYLaP8P5w=
X-Google-Smtp-Source: AKy350aNc6Uj35BvHmzd2cTNLkO4RBcFCg5ttxdRc77YF1akvtaEdlLahTqrEGZoWDcANrTpiK8s4w==
X-Received: by 2002:a17:906:10c7:b0:947:f415:db23 with SMTP id v7-20020a17090610c700b00947f415db23mr690276ejv.1.1680904230791;
        Fri, 07 Apr 2023 14:50:30 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id r2-20020a17090638c200b0093034e71b94sm2456872ejd.65.2023.04.07.14.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 14:50:30 -0700 (PDT)
Date:   Fri, 7 Apr 2023 23:50:28 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] staging: rtl8192e: Remove unused function
 _rtl92e_dm_init_wa_broadcom_iot
Message-ID: <0e7a2a5b9edc85b7f8e3fc0f9e0e6ab7f2830d02.1680902603.git.philipp.g.hortmann@gmail.com>
References: <cover.1680902603.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1680902603.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused function _rtl92e_dm_init_wa_broadcom_iot and the variables
that are not any longer used.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 11 -----------
 drivers/staging/rtl8192e/rtl819x_HT.h      |  3 ---
 2 files changed, 14 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index 50486f2a6f3a..93504d5a8578 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -173,7 +173,6 @@ static void _rtl92e_dm_pd_th(struct net_device *dev);
 static void _rtl92e_dm_cs_ratio(struct net_device *dev);
 
 static	void _rtl92e_dm_init_cts_to_self(struct net_device *dev);
-static void _rtl92e_dm_init_wa_broadcom_iot(struct net_device *dev);
 
 static void _rtl92e_dm_check_edca_turbo(struct net_device *dev);
 static void _rtl92e_dm_check_rx_path_selection(struct net_device *dev);
@@ -1531,16 +1530,6 @@ static void _rtl92e_dm_cts_to_self(struct net_device *dev)
 	}
 }
 
-
-static void _rtl92e_dm_init_wa_broadcom_iot(struct net_device *dev)
-{
-	struct r8192_priv *priv = rtllib_priv((struct net_device *)dev);
-	struct rt_hi_throughput *ht_info = priv->rtllib->ht_info;
-
-	ht_info->bWAIotBroadcom = false;
-	ht_info->WAIotTH = WA_IOT_TH_VAL;
-}
-
 static void _rtl92e_dm_check_rf_ctrl_gpio(void *data)
 {
 	struct r8192_priv *priv = container_of_dwork_rsl(data,
diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index 22e4f126ed56..f4e9fa849796 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -162,9 +162,6 @@ struct rt_hi_throughput {
 	u8				IOTPeer;
 	u32 iot_action;
 	u8 iot_ra_func;
-
-	u8	bWAIotBroadcom;
-	u8	WAIotTH;
 } __packed;
 
 struct bss_ht {
-- 
2.40.0


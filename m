Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADD16E3599
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 09:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjDPHT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 03:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjDPHTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 03:19:54 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1616D358C
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 00:19:48 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f05f61adbeso5879595e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 00:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681629588; x=1684221588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JlBWI0Ks0qD6ovVmGF/S6pEdK+jxnqFwR9r0p5tYFXk=;
        b=oxJDFFo/k2jg6JAIz8X8BJqVZoCsd07p6Z/eM/8KtQJ4YeO8ZagSAfzAP1zo3K1I33
         kz51qmSc3TOyn4n9Ih+WWNzVwe/uHIKoFowrFre/Th32yFF+3+c8gThwQ5dSBgqM8Xq6
         qnPs7vOCvmywAHWcpP8ws7KI7YvaVNvWOQQyLfjR1fyxTI8WsKNj64hDvWQjj9dGoJ3K
         AYjxR0PsDPBRdbLRpTesd+FY4hFGzoJGZzEIUpVcnZ+eQbG7C9ix1eq325iAEIXq81vk
         fIJW+1h2yFkq3L3QynQQMhS3AHkQq0PYl6XV/ZG/oO//2lhSVCTgUyytc0kr7Xr6nJfO
         nHZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681629588; x=1684221588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JlBWI0Ks0qD6ovVmGF/S6pEdK+jxnqFwR9r0p5tYFXk=;
        b=N3m802E+JJAewI3Q4sCfywSVT9uvwVyelffuCGwLMekiXRXFvY3zWYEEcViz7Zsi3l
         VVBCi97zwFUtPBWABaffMGuRdrvtjRKvTlKEZlDuDbUnaAJa+YbY6XrUBx85cOqU7VJI
         80SzfCc7kZxnd7sqjX50xhRKGW3wRwBH+Lz93LJt6rQCIzUPvYxqA+oNAbAFag0SDO5U
         kVENnER9y1r3iExHBbCUfixZ4U8nGzPx6rDXJYDH+uEGOc43pCUjxH0l0WWM9DVWyh4h
         BGdSU3+ac5aWjBkX3Beg8951q/c/ZC2zAsNrOpP5zo7VlqbrIBvbNhbZqfnFw0bfk4RR
         MiWQ==
X-Gm-Message-State: AAQBX9eMqSvtO04Ug/1uTX4iv9ow2LK37SYfucseUXsIm/fwwIrEEIpr
        7zyP73S2b+Tpzld06hSHO5w=
X-Google-Smtp-Source: AKy350agzu/KqAP3xikKyPT9eXV2SN5ENPF2l9Ot66EfD6e1Nga2nW/CegA8GhimOq++asF0ED9i/w==
X-Received: by 2002:a05:6000:112:b0:2f9:ee11:e5c3 with SMTP id o18-20020a056000011200b002f9ee11e5c3mr325999wrx.2.1681629588144;
        Sun, 16 Apr 2023 00:19:48 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id s15-20020adfeb0f000000b002c55306f6edsm7412460wrn.54.2023.04.16.00.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 00:19:47 -0700 (PDT)
Date:   Sun, 16 Apr 2023 09:19:45 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] staging: rtl8192e: Remove unused function
 rtl92e_disable_nic
Message-ID: <5ce2ef58f66e25d7db7432c56c7b7c37a2b15fc1.1681627603.git.philipp.g.hortmann@gmail.com>
References: <cover.1681627603.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1681627603.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused function rtl92e_disable_nic to shorten code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 16 ----------------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h |  1 -
 2 files changed, 17 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index a644543015ee..a0c6d117211a 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -2302,22 +2302,6 @@ bool rtl92e_enable_nic(struct net_device *dev)
 	return init_status;
 }
 
-bool rtl92e_disable_nic(struct net_device *dev)
-{
-	struct r8192_priv *priv = rtllib_priv(dev);
-	u8 tmp_state = 0;
-
-	priv->bdisable_nic = true;
-	tmp_state = priv->rtllib->state;
-	rtllib_softmac_stop_protocol(priv->rtllib, 0, false);
-	priv->rtllib->state = tmp_state;
-	_rtl92e_cancel_deferred_work(priv);
-	rtl92e_irq_disable(dev);
-
-	rtl92e_stop_adapter(dev, false);
-	return true;
-}
-
 module_pci_driver(rtl8192_pci_driver);
 
 void rtl92e_check_rfctrl_gpio_timer(struct timer_list *t)
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index b0aa76574738..51240cbde0d3 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -433,7 +433,6 @@ u8 rtl92e_rx_db_to_percent(s8 antpower);
 void rtl92e_copy_mpdu_stats(struct rtllib_rx_stats *psrc_stats,
 			    struct rtllib_rx_stats *ptarget_stats);
 bool rtl92e_enable_nic(struct net_device *dev);
-bool rtl92e_disable_nic(struct net_device *dev);
 
 bool rtl92e_set_rf_state(struct net_device *dev,
 			 enum rt_rf_power_state state_to_set,
-- 
2.40.0


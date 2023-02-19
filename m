Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC4C69C2A1
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 22:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbjBSVPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 16:15:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbjBSVPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 16:15:39 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E107F199C4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 13:15:37 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id x22so4870543edd.10
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 13:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1676841336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FnARXeUlH8SP3sL9hF5FqRg/oldYCWKd88vCzYsrVf8=;
        b=gmOVl9JbMjaOA0bu1b5yHXa9Qw1edQArY83Zk2Z0JkwuCCXShjPrNavDcwtpO7F0j4
         v7mKMxB5DZXmn+oLeE2qJvQXh9/ncC/dFedduKdffqhEsDiVN6J4LgRwJUt84w1ihcVl
         3ZX8P2LHk03Tie/TPn9rVs493XforbGL2dG/j/h/dZsqsX/NWaKEUEh0WEHio5B5CuIx
         aflqrSMlKooqM0T7usi9vsKHFkdCBHpFuWvnMcAdyIdsdn3y8nQpx1rOMLV44YnEoJlJ
         +xG6Y3CNZmg0dt6/J+Ok7LApnQSeTaaqUFNA7oayP8P/Ai8NiZyiTbmxEs6kMtVxZh2E
         IHnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676841336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FnARXeUlH8SP3sL9hF5FqRg/oldYCWKd88vCzYsrVf8=;
        b=MGVyMwpDNjq1L1uwJ1pd8NLTffGNjIowDpXrv94cCIsMYb6QuV8sE9cKDl/KFAKyLk
         GGPCfXT0USkuGAv3ARmILTVKqN21AFwrM0a3X/IgJrX7Bdx7G+d0VkXAMeAg9CfWr6Nz
         5Pgz4Qnjj7SR2QNna+jcZ7REpitt8PngzvMaJqxgr5vL1f9nUrl9zcemtDBcD/3xHcD0
         ODYvtRO2FGPSILYvmp+zJbUGVZ93+MV2XnYxuPZu/6i8d+jtyK0K0oD91BLxkPHOEhdD
         tcXLAlSSdsbZi68f/ZrAASzcs2WStXMS7Gv+vEPpCj91FcyxZkDNN7Qbm8BKoeBr1EAm
         NLlg==
X-Gm-Message-State: AO0yUKUhCf5KkumGFOTZV39gvgZjzcX48/wi/r2cGn4oS6cJgDOVIjA7
        S9SmNeEVqFPD6MrCTz3dmNo=
X-Google-Smtp-Source: AK7set9TBHtisrMThzgiKhDzZGTIHy001NVA0sgocM+rw/8LBRwscckWSaATBqbPJZ50BKRo4QF66w==
X-Received: by 2002:a17:906:105e:b0:89a:8238:3323 with SMTP id j30-20020a170906105e00b0089a82383323mr6295288ejj.6.1676841336315;
        Sun, 19 Feb 2023 13:15:36 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id s12-20020a1709066c8c00b008d325e167f3sm330408ejr.201.2023.02.19.13.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 13:15:35 -0800 (PST)
Date:   Sun, 19 Feb 2023 22:15:33 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] staging: rtl8192e: Remove entry .get_eeprom_size from
 struct rtl819x_ops
Message-ID: <1323e1ae2b4f52dc42b7ce5debca5608c9c5aafd.1676840647.git.philipp.g.hortmann@gmail.com>
References: <cover.1676840647.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1676840647.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove entry .get_eeprom_size and replace it with function name
rtl92e_get_eeprom_size. This increases readability of the code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 3 +--
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 104b16cfa979..73f3d0973a5a 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -27,7 +27,6 @@ static char *ifname = "wlan%d";
 
 static const struct rtl819x_ops rtl819xp_ops = {
 	.nic_type			= NIC_8192E,
-	.get_eeprom_size		= rtl92e_get_eeprom_size,
 	.init_adapter_variable		= rtl92e_init_variables,
 	.initialize_adapter		= rtl92e_start_adapter,
 	.link_change			= rtl92e_link_change,
@@ -974,7 +973,7 @@ static short _rtl92e_init(struct net_device *dev)
 	_rtl92e_init_priv_variable(dev);
 	_rtl92e_init_priv_lock(priv);
 	_rtl92e_init_priv_task(dev);
-	priv->ops->get_eeprom_size(dev);
+	rtl92e_get_eeprom_size(dev);
 	priv->ops->init_adapter_variable(dev);
 	_rtl92e_get_channel_map(dev);
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index fd96eef90c7f..00e413a644d2 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -205,7 +205,6 @@ struct rtl8192_tx_ring {
 
 struct rtl819x_ops {
 	enum nic_t nic_type;
-	void (*get_eeprom_size)(struct net_device *dev);
 	void (*init_adapter_variable)(struct net_device *dev);
 	void (*init_before_adapter_start)(struct net_device *dev);
 	bool (*initialize_adapter)(struct net_device *dev);
-- 
2.39.2


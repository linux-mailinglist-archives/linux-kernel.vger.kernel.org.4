Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE48B6C8CAF
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 09:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbjCYIgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 04:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbjCYIgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 04:36:18 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA2B18AAD
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 01:36:17 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-93075ee221bso14102466b.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 01:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679733375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tXY6VvxPrL+Ft/OOHN7tVol0Ou3qPIGP5Ichat9gkls=;
        b=nZkUzNJPqrM3dg8D4xEm8V8C0pb+1R4E2r4qfWzkxHrtVfCZGNmLdoh5Om3KkvgJJf
         Ip9sTS8eIjIP0tWwcsGNhqVNtFRgvp7Wq2aEU1CEBWQtC+aPAsoGvaaInsstki7e4bkH
         lOECU1WDjnWbyvpF6r/ZThUcwZVVh0Y0G7BaoAHYaKluRp70yHL9RSicM4ozbx9pAdfs
         CPTw0ugCy3Pg0386U7dbU/Q2jmBSN+aLgT2qH8Av9/SFcj8rqAnUL79fzz5tXguGVdi4
         EbruRtt/WjOnl0tWRqucRQ/2svhPARFz7XHDFwkMHMxmfTfrRXy3ESIF5Qn+bxfLlfKh
         auVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679733375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tXY6VvxPrL+Ft/OOHN7tVol0Ou3qPIGP5Ichat9gkls=;
        b=oMxw7FV/C5apnBgrZCWpTS0xODt98WqKKej5tTl6YjBvGUndatAYV2WC45QBYNdjug
         DzjHwUDJzJzrziQd3BKeRw+dvZIQKT7mqfbg/OeJ0ErOBgeTuLWRqAx+OFCw9ymxXc6p
         CNNIZjBj05EfhPIHHbYa1GdAq9Q9e7SKI4iYfA43kIqn5SEm9/Jahu+Nv5mjCrnMB9jk
         dUvm00qZ2itl9Y3itCbhFBqCAiSLgFvttjAUGOkxopOUdhNJD9j2waLEjD6AyDvoDFsS
         P40l8Lalyf583vPeFc3OuDwvaYI1SP6kZsgvQ7VCgyQ1ucSGjyWtmyevdaKAKydrWbDE
         Whjg==
X-Gm-Message-State: AAQBX9es8Xfkno6btHTyJS+zqdDPn7jf4teHuk+BI1jFvZPvUPzrbp5o
        OSZt4HS3ecu9SwdzZFId8fc=
X-Google-Smtp-Source: AKy350ZUHl0k6VkdXzcetSXghQ3i9iL2W6iOcT/US1+29zXFLw9MU4rjNnwHIs1WrSkkOl4zhpozLA==
X-Received: by 2002:a17:906:2083:b0:92c:fc0:b229 with SMTP id 3-20020a170906208300b0092c0fc0b229mr4620756ejq.0.1679733375776;
        Sat, 25 Mar 2023 01:36:15 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id by22-20020a170906a2d600b008cecb8f374asm11389751ejb.0.2023.03.25.01.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 01:36:15 -0700 (PDT)
Date:   Sat, 25 Mar 2023 09:36:13 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 05/11] staging: rtl8192e: Remove priv->rf_chip in
 _rtl92e_set_tx_power_level
Message-ID: <465a789243287c1420fdce68f9a861784a164140.1679732276.git.philipp.g.hortmann@gmail.com>
References: <cover.1679732276.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1679732276.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

priv->rf_chip is initialized to RF_8256 and never changed. Remove
condition in function _rtl92e_set_tx_power_level as it is dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index e35085253e70..b528b8ab4b2b 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -542,21 +542,8 @@ static void _rtl92e_set_tx_power_level(struct net_device *dev, u8 channel)
 	u8	powerlevel = priv->tx_pwr_level_cck[channel - 1];
 	u8	powerlevelOFDM24G = priv->tx_pwr_level_ofdm_24g[channel - 1];
 
-	switch (priv->rf_chip) {
-	case RF_8225:
-		break;
-
-	case RF_8256:
-		rtl92e_set_cck_tx_power(dev, powerlevel);
-		rtl92e_set_ofdm_tx_power(dev, powerlevelOFDM24G);
-		break;
-
-	case RF_8258:
-		break;
-	default:
-		netdev_warn(dev, "%s(): Invalid RF Chip ID\n", __func__);
-		break;
-	}
+	rtl92e_set_cck_tx_power(dev, powerlevel);
+	rtl92e_set_ofdm_tx_power(dev, powerlevelOFDM24G);
 }
 
 static u8 _rtl92e_phy_set_sw_chnl_cmd_array(struct net_device *dev,
-- 
2.39.2


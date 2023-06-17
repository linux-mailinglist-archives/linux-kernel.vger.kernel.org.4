Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C66C734182
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 15:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235957AbjFQN4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 09:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235825AbjFQN4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 09:56:46 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E8F1704
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 06:56:45 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-98502b12fd4so46541166b.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 06:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687010204; x=1689602204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b7DeMqONapwDBFWxqll13s5Z4bgKhDNtxF1406ybhog=;
        b=Gh9nS0b0aiRQnGIzctHftCwqdKe3a8dVnxL6zDhEsOp4RV/4iSbkXxXt4lAJM38Jgi
         FCkogfJB/Y4BQDW8Evm89WeIm/ymdaVRg3FjBz7r9x3YYZoUVa3Ks2Q1ilVg5oRqKFiW
         lvITtV6lsyOw69kLQtUKWhacqLrR7sm4kO2Fx55hZVZ1jZ9Tl6DspBoiYYomh+3gobR7
         tK1GZvd2hz/Rv95f8cxPDayZajWplDTZ2OojjygozlojzxwDgeqEKIGgoVs6wGxgbCYe
         ADKHoplJel62AyCXuQeG8ZadW+gg3s67Ym/6mwDBK40RqVd58UuyS7ikuuE1MGGS4dM3
         j5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687010204; x=1689602204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b7DeMqONapwDBFWxqll13s5Z4bgKhDNtxF1406ybhog=;
        b=lODSRSN3kBc/eiU+YhL5UWVOKWkZOIVbhCizl4Be/octTdTND0l706vhyK5DUpCCoB
         Y1nlnmU4xYndye0RtgT4dFl0f1mR090Rj6G1mzxz1lgZlSyULrzNuuo2B9SR/UsYy4zz
         syTRIG45ucP3ZAVeV3iOzGuO16Xba+kMto8kaWWR9LDFc0Yw6xUnyGlman8w80dnASrU
         IS/fHj2ctwDLy6ON4Hedkar0XqDUcUvrZnm/ULJDjKv6U1gRtjE06QLkIz1gjiDT+tG8
         CYIN/qKCnFgoWkSC6xvMaLHwE4m6gjgW2cByhbG2F3RYXImZwJATJ5fvHUMbSRrXnhIS
         c8XQ==
X-Gm-Message-State: AC+VfDwLR3kXu65Ll8Ndjqy9+dlN3u40Vxb2ZvQHjsKzDwA+ZVGiBH8t
        P9G/AIkZjmAGNcpubxCE4dfILVL7a2k=
X-Google-Smtp-Source: ACHHUZ784+xHMbYwi2TQfZ+xm1+YADywPkb4sBfNUgQos/pr9lHCKzJ1hXsWoRe1LGEsEkGanCSzrw==
X-Received: by 2002:a17:906:7a5e:b0:987:6960:36c6 with SMTP id i30-20020a1709067a5e00b00987696036c6mr1319738ejo.5.1687010203765;
        Sat, 17 Jun 2023 06:56:43 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2e0b.dip0.t-ipconnect.de. [87.186.46.11])
        by smtp.gmail.com with ESMTPSA id n24-20020a170906165800b00977c7566ccbsm11970397ejd.164.2023.06.17.06.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 06:56:43 -0700 (PDT)
Date:   Sat, 17 Jun 2023 15:56:41 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] staging: rtl8192e: Remove variable stats->freq as it is
 constant
Message-ID: <4d8801d37889e6af4f43dff10d1426fc7918f562.1687007788.git.philipp.g.hortmann@gmail.com>
References: <cover.1687007788.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1687007788.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

stats->freq is initialized with 1 and then unchanged. All evaluations
will result accordingly. Remove resulting dead code and unused defines.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c |  1 -
 drivers/staging/rtl8192e/rtllib.h            |  5 -----
 drivers/staging/rtl8192e/rtllib_rx.c         | 19 +++++--------------
 3 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 17b70dde7eeb..20c0308eb3c1 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -1769,7 +1769,6 @@ static void _rtl92e_rx_normal(struct net_device *dev)
 		.signal = 0,
 		.noise = (u8)-98,
 		.rate = 0,
-		.freq = RTLLIB_24GHZ_BAND,
 	};
 	unsigned int count = priv->rxringcount;
 
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 87e9169214f6..b4fad9bf0f03 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -500,9 +500,6 @@ enum _REG_PREAMBLE_MODE {
 #define RTLLIB_CCK_MODULATION    (1<<0)
 #define RTLLIB_OFDM_MODULATION   (1<<1)
 
-#define RTLLIB_24GHZ_BAND     (1<<0)
-#define RTLLIB_52GHZ_BAND     (1<<1)
-
 #define RTLLIB_CCK_RATE_LEN		4
 #define RTLLIB_CCK_RATE_1MB			0x02
 #define RTLLIB_CCK_RATE_2MB			0x04
@@ -549,10 +546,8 @@ struct rtllib_rx_stats {
 	u8  signal;
 	u8  noise;
 	u16 rate; /* in 100 kbps */
-	u8  received_channel;
 	u8  control;
 	u8  mask;
-	u8  freq;
 	u16 len;
 	u64 tsf;
 	u32 beacon_time;
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 46c77ed335ab..36dace010203 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -2301,12 +2301,7 @@ static inline int rtllib_network_init(
 	network->CountryIeLen = 0;
 	memset(network->CountryIeBuf, 0, MAX_IE_LEN);
 	HTInitializeBssDesc(&network->bssht);
-	if (stats->freq == RTLLIB_52GHZ_BAND) {
-		/* for A band (No DS info) */
-		network->channel = stats->received_channel;
-	} else {
-		network->flags |= NETWORK_HAS_CCK;
-	}
+	network->flags |= NETWORK_HAS_CCK;
 
 	network->wpa_ie_len = 0;
 	network->rsn_ie_len = 0;
@@ -2321,14 +2316,10 @@ static inline int rtllib_network_init(
 
 	network->mode = 0;
 
-	if (stats->freq == RTLLIB_52GHZ_BAND) {
-		network->mode = IEEE_A;
-	} else {
-		if (network->flags & NETWORK_HAS_OFDM)
-			network->mode |= IEEE_G;
-		if (network->flags & NETWORK_HAS_CCK)
-			network->mode |= IEEE_B;
-	}
+	if (network->flags & NETWORK_HAS_OFDM)
+		network->mode |= IEEE_G;
+	if (network->flags & NETWORK_HAS_CCK)
+		network->mode |= IEEE_B;
 
 	if (network->mode == 0) {
 		netdev_dbg(ieee->dev, "Filtered out '%s (%pM)' network.\n",
-- 
2.40.1


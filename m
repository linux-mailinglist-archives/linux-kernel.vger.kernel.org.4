Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F5B73006B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 15:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245184AbjFNNsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 09:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245150AbjFNNsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 09:48:11 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8DE210B;
        Wed, 14 Jun 2023 06:47:56 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f62b552751so8633349e87.3;
        Wed, 14 Jun 2023 06:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686750474; x=1689342474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v1IkM5PACQr8LE1VV5+hRPuhOTTZL39mlBAwPbgHV4k=;
        b=Dsd4q/cPWLVpkM6lRBeECkoXfhw5k9SxPt9T776bC9i0Ti68NlAKY3cX9X3iAsavOU
         u3vK+YobsvXSDDsqI/A+0m2vDjk9iEPUiIbxclQAOx9m46hmFvlB+y8RqTu9+kyQ6N5B
         29R8CHTgGn4/STOnUZLuvWSyrVnp6m3z7oVbbfdzzRd45BA/d0G513I7GjM4sS6Qutk3
         b2APW3enGIRFcyIMGIqCnL07DIZxUFF9iMmeiJa3eQXrWN6bM/Ph0tiXxRLpqqR3xMMB
         hd6n+BLBebe/B1NHOSlOU/ZptSlyDU2u1tX9Ffknm2IpdS9T1K80BfRekHp9mmprIjjH
         oQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686750474; x=1689342474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v1IkM5PACQr8LE1VV5+hRPuhOTTZL39mlBAwPbgHV4k=;
        b=jlNslWI2BNi5ScrU8sNAF6HnSpt2b95CPETbvoObk3640vwHdx9IzqiY6RL3t1eYEh
         ikLcvxRj299h+Z8AgfWKj9E/1uBa24rm4eSnZYjJhaxkuNGvAIDRMa9Z9dvQRiJxRWUY
         e7lv1nG57YAKKYGfNWXnsSbCNB01etpXvlLHBrACjGu9vGvXpVnn/9mBQ3v0nkXFJ77d
         hjJaAGKJLXYXwLShXrUYIUqE0CZdEiisrdywOXsf01QY2R4upqiEbj3IHMDGTjyF1g4v
         GEZJmaPSDsdpnkEFnUfyXfuSnAx6P+6Wd5+cs2FhqOaHxMxrh15xw00+tYJYDVb109mW
         9dOg==
X-Gm-Message-State: AC+VfDz1hAPGNP8VDZuLy86NFM2lryN6UhK1LMzT5LIc6FrYfvfyAE2c
        7iOgjpGF/KMHQocDpANVlrg=
X-Google-Smtp-Source: ACHHUZ5dWEirg0lfgE55fbcjxiFlnqpGX6SccBNtKvKz6+p2Q+clFyAZTg7X3IBC18XUcu9Iu9PPnQ==
X-Received: by 2002:a2e:9f0f:0:b0:2b2:1bde:407f with SMTP id u15-20020a2e9f0f000000b002b21bde407fmr6509095ljk.6.1686750474115;
        Wed, 14 Jun 2023 06:47:54 -0700 (PDT)
Received: from U19.ag.local (static.187.76.181.135.clients.your-server.de. [135.181.76.187])
        by smtp.gmail.com with ESMTPSA id a19-20020a2eb173000000b002ad92dff470sm2583912ljm.134.2023.06.14.06.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 06:47:53 -0700 (PDT)
From:   Alibek Omarov <a1ba.omarov@gmail.com>
To:     linux-rockchip@lists.infradead.org
Cc:     a1ba.omarov@gmail.com, Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: rockchip: rk3568: Fix PLL rate setting for 78.75MHz
Date:   Wed, 14 Jun 2023 16:47:50 +0300
Message-Id: <20230614134750.1056293-1-a1ba.omarov@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PLL rate on RK356x is calculated through the simple formula:
((24000000 / _refdiv) * _fbdiv) / (_postdiv1 * _postdiv2)

The PLL rate setting for 78.75MHz seems to be copied from 96MHz
so this patch fixes it and configures it properly.

Signed-off-by: Alibek Omarov <a1ba.omarov@gmail.com>
Fixes: 842f4cb72639 ("clk: rockchip: Add more PLL rates for rk3568")
---
 drivers/clk/rockchip/clk-rk3568.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3568.c b/drivers/clk/rockchip/clk-rk3568.c
index 5dae960af4ce..48b8d06c305c 100644
--- a/drivers/clk/rockchip/clk-rk3568.c
+++ b/drivers/clk/rockchip/clk-rk3568.c
@@ -82,7 +82,7 @@ static struct rockchip_pll_rate_table rk3568_pll_rates[] = {
 	RK3036_PLL_RATE(101000000, 1, 101, 6, 4, 1, 0),
 	RK3036_PLL_RATE(100000000, 1, 150, 6, 6, 1, 0),
 	RK3036_PLL_RATE(96000000, 1, 96, 6, 4, 1, 0),
-	RK3036_PLL_RATE(78750000, 1, 96, 6, 4, 1, 0),
+	RK3036_PLL_RATE(78750000, 4, 315, 6, 4, 1, 0),
 	RK3036_PLL_RATE(74250000, 2, 99, 4, 4, 1, 0),
 	{ /* sentinel */ },
 };
-- 
2.34.1


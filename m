Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860C76192BD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 09:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbiKDIaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 04:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbiKDIaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 04:30:09 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94FD275F6
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 01:30:08 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id ud5so11431945ejc.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 01:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J0WWDPjFFiB5FkqfAdkJr8kHG7tGk0wrcMV56w0EsG4=;
        b=io9r1oscZpSSorDwWffkeSVLwWaxKhBdOA8oHFnKzyms3Tu9/GHZ+y5kkr+SNxbxnz
         FxrQVrq2wOxmdMFLrCsI00zYdSEF23biFhxbj/bl8ISM3fVUw61gZMvo/1cmH5G/2Ivu
         FLz0Xuiw5RyRILnUExDVTfN+uGp7F1vi5bSTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J0WWDPjFFiB5FkqfAdkJr8kHG7tGk0wrcMV56w0EsG4=;
        b=OuI1qA2l61J8zTO69zj5plT0nMRTb0mrPeYHKehwCnO8KAynrPFmfiqvclPSTMAN+X
         dsdC5e6jKNZQdQ4lj2nbKoNXmnHsl1AqO5HRwFs+P3o4R8UNXzBHF2g6ioA6mWFgpndp
         k/Q7H9KTVJokjBbSyfOCt+oPHHwbFVAGlHCdJq429Hy7v9SzyLYcSqqHRSHHkLTNvSCL
         6KwimJFzTzeWgCwMlbwSaKinvN7P1IVDsDABJArnEo4XV4Rciy3DQyz8OXkJzRcYYoIQ
         ouLpY2gpVrsK54d//CDt6Xs3QZsfGuvzj8fpB1TlGUXmiiDc4lw5OBKkN8Si5qQc1lWE
         +V8A==
X-Gm-Message-State: ACrzQf0420LTAUMis3FI1J0yBZBvLhyNmbRnDEIREkxHn8hfe1Ugb+Ar
        5rJ7AE7yzB7+MWnaZnBIT0tgSmyifWdIpeVjqKA=
X-Google-Smtp-Source: AMsMyM7BrUNV7InYCf/NzvNGYzXPv55tEbDE6bSYY59zpAi2DC7Pl4Yvuo4+URe4mVy+0aN8e8+hSw==
X-Received: by 2002:a17:907:97ca:b0:791:644c:491e with SMTP id js10-20020a17090797ca00b00791644c491emr33081519ejc.555.1667550607180;
        Fri, 04 Nov 2022 01:30:07 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id d8-20020a170906344800b0073dc5bb7c32sm1505870ejb.64.2022.11.04.01.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 01:30:06 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH] net: stmmac: dwmac-meson8b: fix meson8b_devm_clk_prepare_enable()
Date:   Fri,  4 Nov 2022 09:30:04 +0100
Message-Id: <20221104083004.2212520-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two problems with meson8b_devm_clk_prepare_enable(),
introduced in a54dc4a49045 (net: stmmac: dwmac-meson8b: Make the clock
enabling code re-usable):

- It doesn't pass the clk argument, but instead always the
  rgmii_tx_clk of the device.

- It silently ignores the return value of devm_add_action_or_reset().

The former didn't become an actual bug until another user showed up in
the next commit, 9308c47640d5 (net: stmmac: dwmac-meson8b: add support
for the RX delay configuration). The latter means the callers could
end up with the clock not actually prepared/enabled.

Fixes: a54dc4a49045 (net: stmmac: dwmac-meson8b: Make the clock enabling code re-usable)
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
Not tested in any way, just stumbled on this which didn't seem right.

It seems that the timing_adj_clk could be changed (with a bit of
refactoring) to use devm_clk_get_enabled() - i.e. don't make it
optional, but only get/prepare/enable it in the (delay_config &
PRG_ETH0_ADJ_ENABLE) branch where the code actually requires it.

But since there's no official devm_clk_prepare_enable, and the
rgmii_tx_clk isn't obtained via a clk_get, I don't see a simple way to
avoid this private implmentation of devm_clk_prepare_enable().

drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
index c7a6588d9398..e8b507f88fbc 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
@@ -272,11 +272,9 @@ static int meson8b_devm_clk_prepare_enable(struct meson8b_dwmac *dwmac,
 	if (ret)
 		return ret;
 
-	devm_add_action_or_reset(dwmac->dev,
-				 (void(*)(void *))clk_disable_unprepare,
-				 dwmac->rgmii_tx_clk);
-
-	return 0;
+	return devm_add_action_or_reset(dwmac->dev,
+					(void(*)(void *))clk_disable_unprepare,
+					clk);
 }
 
 static int meson8b_init_rgmii_delays(struct meson8b_dwmac *dwmac)
-- 
2.37.2


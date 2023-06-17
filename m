Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 190817341CB
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 17:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237208AbjFQPDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 11:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234911AbjFQPDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 11:03:19 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511BA10C0;
        Sat, 17 Jun 2023 08:03:18 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-341cb9528f5so8320235ab.1;
        Sat, 17 Jun 2023 08:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687014197; x=1689606197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tzTPe8onR/N23LI5oBvszIpSUyj+OYOJF/gBItcCYUo=;
        b=gvv/ozeksl8FCZoAYBt7y5n4+RwRIUn2dEzC/hbOLsJxYZPB95E6Hq++p1sRNf8bpE
         vouUQFQbhCCLJqVeE4vHfihpKqzAMuv6NaBvciuhhNQ170Y19UULvjouNCgkbfAKsoI4
         vOBApMH4g//fgBlD1KlvEZZTPA1uZVcepLe4DnwKCAfww3R/3Fx4Mmecrcq91rmYOpVF
         ec9Ku7DhYEbQ6grnl50uk/xS32S99io5wRZE3Ksm3ifRIGf+MRNm5nSoWKzYit/SfahB
         o2IGvqs9uLMC1g8BwjJBSngu2GP8X6grCkJQl3Eel6FgniIlPSa+v1zIEfUUhTrUKOLc
         1XAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687014197; x=1689606197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tzTPe8onR/N23LI5oBvszIpSUyj+OYOJF/gBItcCYUo=;
        b=BsusOa2P29vlH5k6YHEgwm8xEAIr6JcDl3qrtRHoSJlgImnQqQjb2dTjqPBWkNP1Ij
         XsgkpYc3hPn2EdTdALh4IxDreUvkgfNJe5HJy4QCRPw2Wlqi/3sG+c7kUqEsyvT0nxfz
         Vi8sXXp7704QMnE+hHqGl+ybCB73iCLO/fD3yaJCZl3R7EeILTtB5+z6MlMRsMc+D15O
         CdCWwjw+QrO5CPWEv8W+M6fWR5/5z0XsS5KD22foVY67H6NdTfvA/qC2uFTnBsGunCmI
         h+MtGF8gJCAwN5jbDIB0zh+7kq80J+1bEagkfSslGJa5HLsaLVluL97KKWv3UzMUhm3x
         JtHA==
X-Gm-Message-State: AC+VfDw7IqKaGg9AxFNvJINhzSDBQeiwSChj6vj9Cp2+5eWX/y1x+UiS
        e7YYHb7E2KKeuuHtB3WJusR4YNDyxXUrBw==
X-Google-Smtp-Source: ACHHUZ6mgJPGV1hXPLvOMfzt+wNibYm9apsNg4jLMNLIw+z2d1dT9e00aTl6z88V3BVBAukYCtDlkQ==
X-Received: by 2002:a5d:91d6:0:b0:77a:c741:b749 with SMTP id k22-20020a5d91d6000000b0077ac741b749mr2649483ior.1.1687014197206;
        Sat, 17 Jun 2023 08:03:17 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:2228:4762:4365:80b2])
        by smtp.gmail.com with ESMTPSA id q3-20020a6b7103000000b0077e24ace3edsm623679iog.52.2023.06.17.08.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 08:03:16 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] clk: renesas: r8a774e1: Add 3dge and ZG support
Date:   Sat, 17 Jun 2023 10:03:01 -0500
Message-Id: <20230617150302.38477-3-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230617150302.38477-1-aford173@gmail.com>
References: <20230617150302.38477-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 3dge and ZG clocks are necessary to support the 3D graphics.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/drivers/clk/renesas/r8a774e1-cpg-mssr.c b/drivers/clk/renesas/r8a774e1-cpg-mssr.c
index a790061db877..13fed5e59068 100644
--- a/drivers/clk/renesas/r8a774e1-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a774e1-cpg-mssr.c
@@ -76,6 +76,7 @@ static const struct cpg_core_clk r8a774e1_core_clks[] __initconst = {
 	/* Core Clock Outputs */
 	DEF_GEN3_Z("z",		R8A774E1_CLK_Z,     CLK_TYPE_GEN3_Z,  CLK_PLL0, 2, 8),
 	DEF_GEN3_Z("z2",	R8A774E1_CLK_Z2,    CLK_TYPE_GEN3_Z,  CLK_PLL2, 2, 0),
+	DEF_GEN3_Z("zg",	R8A774E1_CLK_ZG,    CLK_TYPE_GEN3_ZG, CLK_PLL4, 4, 24),
 	DEF_FIXED("ztr",        R8A774E1_CLK_ZTR,   CLK_PLL1_DIV2,  6, 1),
 	DEF_FIXED("ztrd2",      R8A774E1_CLK_ZTRD2, CLK_PLL1_DIV2, 12, 1),
 	DEF_FIXED("zt",         R8A774E1_CLK_ZT,    CLK_PLL1_DIV2,  4, 1),
@@ -124,6 +125,7 @@ static const struct cpg_core_clk r8a774e1_core_clks[] __initconst = {
 };
 
 static const struct mssr_mod_clk r8a774e1_mod_clks[] __initconst = {
+	DEF_MOD("3dge",			 112,	R8A774E1_CLK_ZG),
 	DEF_MOD("fdp1-1",		 118,	R8A774E1_CLK_S0D1),
 	DEF_MOD("fdp1-0",		 119,	R8A774E1_CLK_S0D1),
 	DEF_MOD("tmu4",			 121,	R8A774E1_CLK_S0D6),
-- 
2.39.2


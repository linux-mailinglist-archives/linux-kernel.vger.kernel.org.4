Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18CEA7341CA
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 17:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236116AbjFQPDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 11:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234167AbjFQPDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 11:03:17 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1725C10C0;
        Sat, 17 Jun 2023 08:03:17 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-77807e43b7cso76909739f.1;
        Sat, 17 Jun 2023 08:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687014196; x=1689606196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MMtX4woEKN0A3MNFsVIwLhJgYQ5p02sw/TskXfxeUhM=;
        b=OpKmY+453BwSW5znW7yJYTglsf6ND+RNjX/AbM1oGwcQb7R4q+8g79QMeCW9n9i9kJ
         2m3xffwm4q88wpwDcIIUvKqYDFfygcVkAs8Xga5fNixjvXeGgAbDyL1pVN76EGitWT9h
         bWsnKx1TDJTL+o2I8EjjBp/PATeeYBTqosTZwGYYVRRjOcWYPZK5BSFWJW+MMtmmftd/
         frQq0t42ivJ4WxsSR8U2pDRkrD9rp4N24r9X+d1VCs8Plrlcc98txatsgsV74c036oIM
         wubnonKK1AA5xbHXNQGtM/ELM+zFxM938WOudDYhpCVnYu/vLCksyza9nSDsEcqEWVRW
         8MOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687014196; x=1689606196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MMtX4woEKN0A3MNFsVIwLhJgYQ5p02sw/TskXfxeUhM=;
        b=Lh7UkRHjC2zp/JEvx8IMspRfdA/Dz1Xefl0bH/aSQKnzd5NUfDvtyax2itORK7OP0W
         APoKKJ7r30pMygBGhTffYYg33an2Wl66fafS5QM1rmNCaINb+T3hx0BNIaqb8D25bMgE
         7cPvfhCjinfiw1LMXq/O/KP2eGpmEtuLpw4Tm38HBLLMQXScaifrtFXAPFYzaIHHzLax
         TgyNEoPEo7UyE4iE87r1P2Me7KjUV3ADVAcMgKXxTMUuLc5tYGEfBakauNVMIeG/25lg
         x8PRqTNo0vXuLutBvIEBeovyh9V+qAJUw45TtBHk2NNhbcSC/lYi1tWdMKpGSm5BZR9U
         iqyw==
X-Gm-Message-State: AC+VfDzvmgFw3v/C75t2ELxs46+p5u8ssUnS9AuSrJqGVSclPrhxTXVd
        ewoBvx/V691Ow1Gbsok6tuT4lYEWzqcWzQ==
X-Google-Smtp-Source: ACHHUZ65TPckgptpj5gE5ryJiGjCojoSOEVlVuwEtsddc7FBDjJwNxvipC0Zwan2YNlvDXqwKnMlxg==
X-Received: by 2002:a6b:e408:0:b0:777:b7f9:18f1 with SMTP id u8-20020a6be408000000b00777b7f918f1mr3373365iog.17.1687014195927;
        Sat, 17 Jun 2023 08:03:15 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:2228:4762:4365:80b2])
        by smtp.gmail.com with ESMTPSA id q3-20020a6b7103000000b0077e24ace3edsm623679iog.52.2023.06.17.08.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 08:03:15 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] clk: renesas: r8a774a1: Add 3dge and ZG support
Date:   Sat, 17 Jun 2023 10:03:00 -0500
Message-Id: <20230617150302.38477-2-aford173@gmail.com>
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
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

diff --git a/drivers/clk/renesas/r8a774a1-cpg-mssr.c b/drivers/clk/renesas/r8a774a1-cpg-mssr.c
index ad03c09ebc1f..7e70c9a9affa 100644
--- a/drivers/clk/renesas/r8a774a1-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a774a1-cpg-mssr.c
@@ -76,6 +76,7 @@ static const struct cpg_core_clk r8a774a1_core_clks[] __initconst = {
 	/* Core Clock Outputs */
 	DEF_GEN3_Z("z",		R8A774A1_CLK_Z,     CLK_TYPE_GEN3_Z,  CLK_PLL0, 2, 8),
 	DEF_GEN3_Z("z2",	R8A774A1_CLK_Z2,    CLK_TYPE_GEN3_Z,  CLK_PLL2, 2, 0),
+	DEF_GEN3_Z("zg",	R8A774A1_CLK_ZG,    CLK_TYPE_GEN3_ZG, CLK_PLL4, 4, 24),
 	DEF_FIXED("ztr",        R8A774A1_CLK_ZTR,   CLK_PLL1_DIV2,  6, 1),
 	DEF_FIXED("ztrd2",      R8A774A1_CLK_ZTRD2, CLK_PLL1_DIV2, 12, 1),
 	DEF_FIXED("zt",         R8A774A1_CLK_ZT,    CLK_PLL1_DIV2,  4, 1),
@@ -123,6 +124,7 @@ static const struct cpg_core_clk r8a774a1_core_clks[] __initconst = {
 };
 
 static const struct mssr_mod_clk r8a774a1_mod_clks[] __initconst = {
+	DEF_MOD("3dge",			 112,	R8A774A1_CLK_ZG),
 	DEF_MOD("tmu4",			 121,	R8A774A1_CLK_S0D6),
 	DEF_MOD("tmu3",			 122,	R8A774A1_CLK_S3D2),
 	DEF_MOD("tmu2",			 123,	R8A774A1_CLK_S3D2),
-- 
2.39.2


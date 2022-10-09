Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542EC5F93B5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 01:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbiJIXmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 19:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiJIXlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 19:41:47 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C94F9C7E0;
        Sun,  9 Oct 2022 16:14:20 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id p26-20020a7bcc9a000000b003c384e59047so3489390wma.4;
        Sun, 09 Oct 2022 16:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uR3JBsPeUWL8GJ7HMbmzxwJZVM4Y7GwWcCapqwWfp+E=;
        b=HjbVEQkJ3X7FYvYtfn+UE0Z9pEjY1EZk+mUGjKnFlCkPjfL2Gijx8fUoOsnia99yjx
         6OUDX8/ACs3TwWy3KRf5RnrbYYjOKqQIFTXdnZMODJVaRdEB3nuO5GnJG3Pfi4egZMXS
         rOEMwLEAS7ctHkTxlQ/uUUqhvtAnSYne1ddiUrD89pI3Qlx/CZlrSs3URV5JLTZJToxf
         T5uUdybbo4nU3i+hNd10d7uEWb/bHlyRs9cxPevO3udtlLNHdb0AU+V2r5EeTFE6UXos
         aj34foGcnDRPP1e8zWHc1DR4ACiBOcT0FqvGIrDCLHqm/SNsEDPp7nxD4V3Jl1q84f34
         LvfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uR3JBsPeUWL8GJ7HMbmzxwJZVM4Y7GwWcCapqwWfp+E=;
        b=vEYM+h22KNLVVTluMhEZgtFWQGcYMjmQB0uuawGVVW3CNSPJG/K9WpcjzosXj0P34x
         yTWer3wjzZv88edZ/pht5zGRsVTk4htAMsnLS0Zo34QsEglXtLTtyJ3Kxt7x8J4TnR8h
         sKiVRYQlj217hsuS4hobJzomwbH+klbaAuIbKeZnwKuGqRB4OUB4oWkisCHZKUIga8QM
         gRfvIXmTwyoXGGvhlEKDJ+R14L4XqCY1A+DVZheXIavsMWN4jvK3IzXq8ixd3tdlYtiS
         gjpYOhzZVZd4KWR1GN0RMVfW8cydIvL/UH7fYeFEdsdmQZh6J/m+msoiYjiWe4odjBF5
         ZHlw==
X-Gm-Message-State: ACrzQf3y3vftVAZhabnrdC7VaH5TQhDA/5dMXet9Z3imgIUEuNP73H28
        IyFAxccCmn5O8N3q9sWCgf46daqmM+swEQ==
X-Google-Smtp-Source: AMsMyM4l9RyEElS54NCLBXPa//r1tmDKgKk+QnANVBVvjJXCGRjHx39IxOguhOHnZVcYj3W8CvciUA==
X-Received: by 2002:a05:600c:ace:b0:3b4:621f:93f4 with SMTP id c14-20020a05600c0ace00b003b4621f93f4mr10464640wmr.8.1665357182423;
        Sun, 09 Oct 2022 16:13:02 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:e4:5cde:80ab:dfd4])
        by smtp.gmail.com with ESMTPSA id v24-20020a1cf718000000b003a6125562e1sm8325155wmh.46.2022.10.09.16.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 16:13:01 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] clk: renesas: r9a07g043: Drop WDT2 clock and reset entry
Date:   Mon, 10 Oct 2022 00:12:53 +0100
Message-Id: <20221009231253.15592-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

WDT CH2 is specifically to check the operation of Cortex-M33 CPU and if
used from CA55 CPU would result in an unexpected behaviour. Hence drop
WDT2 clock and reset entries.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/clk/renesas/r9a07g043-cpg.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/clk/renesas/r9a07g043-cpg.c b/drivers/clk/renesas/r9a07g043-cpg.c
index 37475465100d..99f72bf590fa 100644
--- a/drivers/clk/renesas/r9a07g043-cpg.c
+++ b/drivers/clk/renesas/r9a07g043-cpg.c
@@ -158,10 +158,6 @@ static struct rzg2l_mod_clk r9a07g043_mod_clks[] = {
 				0x548, 0),
 	DEF_MOD("wdt0_clk",	R9A07G043_WDT0_CLK, R9A07G043_OSCCLK,
 				0x548, 1),
-	DEF_MOD("wdt2_pclk",	R9A07G043_WDT2_PCLK, R9A07G043_CLK_P0,
-				0x548, 4),
-	DEF_MOD("wdt2_clk",	R9A07G043_WDT2_CLK, R9A07G043_OSCCLK,
-				0x548, 5),
 	DEF_MOD("spi_clk2",	R9A07G043_SPI_CLK2, R9A07G043_CLK_SPI1,
 				0x550, 0),
 	DEF_MOD("spi_clk",	R9A07G043_SPI_CLK, R9A07G043_CLK_SPI0,
@@ -269,7 +265,6 @@ static struct rzg2l_reset r9a07g043_resets[] = {
 	DEF_RST(R9A07G043_OSTM1_PRESETZ, 0x834, 1),
 	DEF_RST(R9A07G043_OSTM2_PRESETZ, 0x834, 2),
 	DEF_RST(R9A07G043_WDT0_PRESETN, 0x848, 0),
-	DEF_RST(R9A07G043_WDT2_PRESETN, 0x848, 2),
 	DEF_RST(R9A07G043_SPI_RST, 0x850, 0),
 	DEF_RST(R9A07G043_SDHI0_IXRST, 0x854, 0),
 	DEF_RST(R9A07G043_SDHI1_IXRST, 0x854, 1),
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD56631259
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 04:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiKTDDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 22:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiKTDD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 22:03:26 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFCFB4073;
        Sat, 19 Nov 2022 19:03:25 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id k2so4808103qvo.1;
        Sat, 19 Nov 2022 19:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7dgDVBDG6kzNE0blQ38U8xpFqH7Lw5NDB8g90LgKm+A=;
        b=EI54pAD+yJy7v+Mc23XDBveyc3bFPpAJ6zNKS6GDjG1jtjGaruNQte+4PV0tHwUaot
         noQXn1NkMcjfcyU20nKhR/gfVYvSHSdGUw+8f5nYg/mKzDeSpH4RXI+50Qllsa68NafZ
         +KdGCCjj7RtWVeMI1TSUt0dYO4vBe21t0SaKwXJoMWn9gzVQ5BXNX8xuN77oCTe/Bb8L
         omaQ+y3YIh8WaNrtKoX2hej9/LDlNuxqKO5sfdH0z15otjILrbtfEdL03ByR7HZaIuYY
         pRi6Pm5V/Ok9znogEOB3Bpo9iRZu6UdDMUVAxE7ZNhHOcDK3CB/spUCGF4BOsBnDkvsY
         C5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7dgDVBDG6kzNE0blQ38U8xpFqH7Lw5NDB8g90LgKm+A=;
        b=z3woHmJHEAumZqqeJHBtAzH+L+fgJeqalo/OjOGh1k224hdiU+p1zw1s/ge6Hbgcv5
         U3f/7aJnY/4/99GFD3YlsRVbwY+bUdiMf2VGXu5F5mxXFffy9nZmspjrEsZNlcegCjfe
         jRYLOuCwRqedVZ7UQstz+BOmItD6JwZCTtfbae6Pmdcvnn5L3XhKIAmEhy7+bVRdFAWo
         ocmDqma5rypwsrkc/xJ8qAUJWowIcA9WgvF2XTSnnyFcpfWhg6d7NIJG+ctICzdNkvFN
         zSDbynrwj66qpJkNN06bGfN87bUnqEJi4eRkmLxhrJtYd5tRc75R5koqbJTNNh7EhwUc
         BcjA==
X-Gm-Message-State: ANoB5pkUwrXOsihMkO+mxMh7ODDSo71Qzq96AcPjfILIIpf74LwKVKXh
        /KgGSr/vfJgKq5Mb5Wosgdk=
X-Google-Smtp-Source: AA0mqf5G/cKxHVeXYjxJ/6dJ80KVaF8PojHDWBvTH12a05gNqFaILG/pt5n07XyeKn/b9pIwWh4IfQ==
X-Received: by 2002:a0c:cdc6:0:b0:4c6:9069:97d3 with SMTP id a6-20020a0ccdc6000000b004c6906997d3mr10671736qvn.106.1668913404706;
        Sat, 19 Nov 2022 19:03:24 -0800 (PST)
Received: from shaak.. (modemcable055.92-163-184.mc.videotron.ca. [184.163.92.55])
        by smtp.gmail.com with ESMTPSA id u8-20020ac80508000000b0039cc47752casm4522423qtg.77.2022.11.19.19.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 19:03:24 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     Liam Beguin <liambeguin@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v1 1/4] clk: lmk04832: declare variables as const when possible
Date:   Sat, 19 Nov 2022 22:02:54 -0500
Message-Id: <20221120030257.531153-2-liambeguin@gmail.com>
X-Mailer: git-send-email 2.37.1.223.g6a475b71f8c4
In-Reply-To: <20221120030257.531153-1-liambeguin@gmail.com>
References: <20221120030257.531153-1-liambeguin@gmail.com>
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

Fix the following warning reported by the kernel test robot.

	cppcheck possible warnings: (new ones prefixed by >>, may not real problems)
	>> drivers/clk/clk-lmk04832.c:357:15: warning: Variable 'pll2_p' can be declared with const [constVariable]
	    unsigned int pll2_p[] = {8, 2, 2, 3, 4, 5, 6, 7};

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/all/202203312017.5YW13Jr4-lkp@intel.com/
Signed-off-by: Liam Beguin <liambeguin@gmail.com>
---
 drivers/clk/clk-lmk04832.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-lmk04832.c b/drivers/clk/clk-lmk04832.c
index f416f8bc2898..9d18fd23bea0 100644
--- a/drivers/clk/clk-lmk04832.c
+++ b/drivers/clk/clk-lmk04832.c
@@ -371,7 +371,7 @@ static unsigned long lmk04832_vco_recalc_rate(struct clk_hw *hw,
 					      unsigned long prate)
 {
 	struct lmk04832 *lmk = container_of(hw, struct lmk04832, vco);
-	unsigned int pll2_p[] = {8, 2, 2, 3, 4, 5, 6, 7};
+	const unsigned int pll2_p[] = {8, 2, 2, 3, 4, 5, 6, 7};
 	unsigned int pll2_n, p, pll2_r;
 	unsigned int pll2_misc;
 	unsigned long vco_rate;
@@ -633,7 +633,7 @@ static int lmk04832_register_vco(struct lmk04832 *lmk)
 
 static int lmk04832_clkout_set_ddly(struct lmk04832 *lmk, int id)
 {
-	int dclk_div_adj[] = {0, 0, -2, -2, 0, 3, -1, 0};
+	const int dclk_div_adj[] = {0, 0, -2, -2, 0, 3, -1, 0};
 	unsigned int sclkx_y_ddly = 10;
 	unsigned int dclkx_y_ddly;
 	unsigned int dclkx_y_div;
-- 
2.37.1.223.g6a475b71f8c4


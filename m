Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8BDB5FDA14
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 15:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiJMNOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 09:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiJMNOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 09:14:35 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE6714D8D8;
        Thu, 13 Oct 2022 06:14:34 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id sc25so3772145ejc.12;
        Thu, 13 Oct 2022 06:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sGUo79V8IknEK9RaV+1rr5dfMkYi9KkvLOC/DC9705Q=;
        b=AVen059q46QGaA+8FXo1xeVtCkArAxsMnZBK5w7Ry+FszVgIdYDCyXZkSlXU0yY5bw
         hN8oOJWkxYwbb4NkjupmcmuddUwq683rib3T/pzH3Fl/c+KwaxKCLolw+MOaHSlr06SR
         ZGLVYXYxr+cfvB7t2Xk22h5wHVYorLFm6n6Gkq2qlS9cno7Ufe1zXdImwp3qao74//+x
         o21OK2caMqf6E3DGYfe2b/nR5I7WfTfxLNrNswQQB815OBuIyKoQ48rWNnbq70H4slrc
         SRVG1YFyeuD0wt8g64Q/3j31qhk6+wnmfFL1NvYxsxHTE45hrql5/OaW68YYRqvM4gb0
         +Onw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sGUo79V8IknEK9RaV+1rr5dfMkYi9KkvLOC/DC9705Q=;
        b=wSS+PtL8+WaMmqoHglzILAai4HwoCDxibnDR7gstxpxSslm1Qwmla6WLDzQ2JxPIU0
         +UPHemiiJUBhYQuuIYRmVYVoPNHm+w6WbcvsmaXjLVyCUWEAjt/jG72NoOvtb+hcRK1d
         JP7KJTi0ucaASjIhbNsvqC08gj/mFd2p5Hv2mZMm59gsRg7zcHElelJMkInY+XDPMDWj
         WROZy5k4CRMKw6YNGZx7gGHSJKl2c4M6pCyuXttlMXkcfaaTGXzUIqvqggRDzvkLvImx
         T0svmjWkOhGpC/bwKAawCdNraHQYp+z3n0D+o3Yce3/1n3Iwnm8bJUcgGOvtgIFXnIFX
         ToZQ==
X-Gm-Message-State: ACrzQf2jF//oSmb/PZ3UMALgI6LIPcSuCU1Q/Ev9eGd/8JtT//WWaX5x
        d+M8JT1CFxODMkyF2jvUvls=
X-Google-Smtp-Source: AMsMyM6LOGJYoYQIpmmtN2CdUldLXR3AacaXVeUiEDZltHjmtGeGxJJ8+SKyLWJ9CpR56YDPfAgWWw==
X-Received: by 2002:a17:907:75dc:b0:78b:339:63c7 with SMTP id jl28-20020a17090775dc00b0078b033963c7mr26357963ejc.480.1665666872691;
        Thu, 13 Oct 2022 06:14:32 -0700 (PDT)
Received: from localhost.localdomain ([2a02:ab88:368f:2080:5d6e:322:57b6:5f03])
        by smtp.googlemail.com with ESMTPSA id kv11-20020a17090778cb00b0078d4e39d87esm2926083ejc.225.2022.10.13.06.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 06:14:32 -0700 (PDT)
From:   David Virag <virag.david003@gmail.com>
Cc:     David Virag <virag.david003@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] clk: samsung: exynos7885: Correct "div4" clock parents
Date:   Thu, 13 Oct 2022 17:13:40 +0200
Message-Id: <20221013151341.151208-1-virag.david003@gmail.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"div4" DIVs which divide PLLs by 4 are actually dividing "div2" DIVs by
2 to achieve a by 4 division, thus their parents are the respective
"div2" DIVs. These DIVs were mistakenly set to have the PLLs as parents.
This leads to the kernel thinking "div4"s and everything under them run
at 2x the clock speed. Fix this.

Fixes: 45bd8166a1d8 ("clk: samsung: Add initial Exynos7885 clock driver")
Signed-off-by: David Virag <virag.david003@gmail.com>
---
 drivers/clk/samsung/clk-exynos7885.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos7885.c b/drivers/clk/samsung/clk-exynos7885.c
index a7b106302706..368c50badd15 100644
--- a/drivers/clk/samsung/clk-exynos7885.c
+++ b/drivers/clk/samsung/clk-exynos7885.c
@@ -182,7 +182,7 @@ static const struct samsung_div_clock top_div_clks[] __initconst = {
 	    CLK_CON_DIV_PLL_SHARED0_DIV2, 0, 1),
 	DIV(CLK_DOUT_SHARED0_DIV3, "dout_shared0_div3", "fout_shared0_pll",
 	    CLK_CON_DIV_PLL_SHARED0_DIV3, 0, 2),
-	DIV(CLK_DOUT_SHARED0_DIV4, "dout_shared0_div4", "fout_shared0_pll",
+	DIV(CLK_DOUT_SHARED0_DIV4, "dout_shared0_div4", "dout_shared0_div2",
 	    CLK_CON_DIV_PLL_SHARED0_DIV4, 0, 1),
 	DIV(CLK_DOUT_SHARED0_DIV5, "dout_shared0_div5", "fout_shared0_pll",
 	    CLK_CON_DIV_PLL_SHARED0_DIV5, 0, 3),
@@ -190,7 +190,7 @@ static const struct samsung_div_clock top_div_clks[] __initconst = {
 	    CLK_CON_DIV_PLL_SHARED1_DIV2, 0, 1),
 	DIV(CLK_DOUT_SHARED1_DIV3, "dout_shared1_div3", "fout_shared1_pll",
 	    CLK_CON_DIV_PLL_SHARED1_DIV3, 0, 2),
-	DIV(CLK_DOUT_SHARED1_DIV4, "dout_shared1_div4", "fout_shared1_pll",
+	DIV(CLK_DOUT_SHARED1_DIV4, "dout_shared1_div4", "dout_shared1_div2",
 	    CLK_CON_DIV_PLL_SHARED1_DIV4, 0, 1),
 
 	/* CORE */
-- 
2.35.1


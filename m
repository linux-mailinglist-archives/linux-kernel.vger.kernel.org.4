Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6876E3B6E
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 21:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjDPTLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 15:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjDPTLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 15:11:06 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23121270E;
        Sun, 16 Apr 2023 12:11:05 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id e18so5033989iow.3;
        Sun, 16 Apr 2023 12:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681672264; x=1684264264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SmvuhiuxAuYruekpO+qXlWQPF8+XI+RH2XWoXviPemo=;
        b=ZIHTPjOUCR94YgZBoBC07HVxE4rP94v/zZDYXN6aBcPoXdvTzVLR4trcoiAOlJx1f9
         0eNzOd6RkX/tss0cX9dmnRtjbCVeOlYs2OP2lAMKx//keXEHCjxJNRWvmPE+uZNL/D2Q
         qRZRjxyteAHApDYuCn0xLEoySzKZxtff35fvegFCFtaCAbTqGLHukJZMRpmWjS9NW8eq
         8ENSnZFqiq4Kjs2aEUt2+1aqzufeeXoa+dAmjACHjGhBVPXXhB1etPwCkhzeELEzdimt
         w53BtkTQPfwYWxYezaZOCwi9ckEO38949lxwV4lYSw5r2njgcXJW0/FXW6f1I7yyH7Ya
         /vgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681672264; x=1684264264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SmvuhiuxAuYruekpO+qXlWQPF8+XI+RH2XWoXviPemo=;
        b=RkSch88GnQke/Es+WGOMksZmRotc3P3tGebVSclIkexh06hPo5bXVtd1VY/4tfrJJl
         qYu6oJhV3Lra4rm7mOT/Ru4c77HNk6xS3H34obrZ/ZNdC3iWcQgpraB20Oacc9I+TBaC
         mJ6SpL9jNLrCA641a5RafAwtbkkdioZK2ALvaUssNmRAZJSmylg4LLCxCF9VCOpIdDXz
         AQIOXzLoA256umXVvXWje3R5V4TNfrF0zhz8kNzVrcZF89fkqKrQBfSMhDONbD2javif
         ODogZxb3yStN6E6kEFE7n1P1Z/y35hoqAzvPOJ7gkxJVMBw9IXClCQ+Q4fX6FnY0hUX0
         N8IA==
X-Gm-Message-State: AAQBX9dM0tWgLnUOsadM8e4qtq+m0mCE5xKG4GK+VvRwgLBc3DnfvKSG
        ywWlbzBIo/d5crzxeCjyYFmXx62yu20=
X-Google-Smtp-Source: AKy350aHI9BFLDvQFzvCMlI58HEGk+XF8iA0SsxyxfvB8/fRqh4zXzOhXz0kXd44cappd02de0zbZg==
X-Received: by 2002:a6b:e506:0:b0:760:ea10:757 with SMTP id y6-20020a6be506000000b00760ea100757mr2589189ioc.20.1681672264056;
        Sun, 16 Apr 2023 12:11:04 -0700 (PDT)
Received: from localhost.localdomain ([2601:447:d001:897f:af57:910a:275a:1164])
        by smtp.gmail.com with ESMTPSA id t9-20020a02b189000000b0040f8abd7c05sm1685044jah.151.2023.04.16.12.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 12:11:03 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: imx: composite-8m:  Fix clock divisions greater than 8
Date:   Sun, 16 Apr 2023 14:10:51 -0500
Message-Id: <20230416191051.106513-1-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
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

When adding imx8m_clk_divider_determine_rate to let the imx8mm
and imx8mn get finer granulatiry of video clocks, it accidentally
broke the imx8mp ability to divide clocks by more than 8 on clocks
when the CLK_SET_RATE_PARENT flag is not set.

On the imx8mp, the CLK_SET_RATE_PARENT flag cannot be set on either
media_disp1_pix or media_disp2_pix, because they both share the
video_pll as a common clock, and if two displays are used, the
parent clock needs to be something that both child clocks can
divide.

imx8m_clk_divider_determine_rate ends up calling clk_divider_bestdiv
which uses the value of 'width' to setup the maximum divisor.  The
clk-composite-8m driver sets the with to 3 which means the maximum
divisor is 8, but these clocks can divide by up to 64.

Currently, if the video_pll is set to 1039500000, the slowest clock
rate achievable is 129937500 which breaks a whole bunch of lower
resolution and refresh options for both media_disp1_pix and
media_disp2_pix.

By changing the 'width' variable to PCG_DIV_WIDTH, the maximum
divisor becomes 64 which allows the clocks to divide down more,
so the lower resolutions and refresh rates are achievable again.

Fixes: 156e96ff2172 ("clk: imx: composite-8m: Add support to determine_rate")
Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-composite-8m.c
index 6883a8199b6c..805e6aada83d 100644
--- a/drivers/clk/imx/clk-composite-8m.c
+++ b/drivers/clk/imx/clk-composite-8m.c
@@ -47,6 +47,7 @@ static unsigned long imx8m_clk_composite_divider_recalc_rate(struct clk_hw *hw,
 				   divider->flags, PCG_DIV_WIDTH);
 }
 
+
 static int imx8m_clk_composite_compute_dividers(unsigned long rate,
 						unsigned long parent_rate,
 						int *prediv, int *postdiv)
@@ -215,12 +216,12 @@ struct clk_hw *__imx8m_clk_hw_composite(const char *name,
 		mux_ops = &imx8m_clk_composite_mux_ops;
 	} else if (composite_flags & IMX_COMPOSITE_BUS) {
 		div->shift = PCG_PREDIV_SHIFT;
-		div->width = PCG_PREDIV_WIDTH;
+		div->width = PCG_DIV_WIDTH;
 		divider_ops = &imx8m_clk_composite_divider_ops;
 		mux_ops = &imx8m_clk_composite_mux_ops;
 	} else {
 		div->shift = PCG_PREDIV_SHIFT;
-		div->width = PCG_PREDIV_WIDTH;
+		div->width = PCG_DIV_WIDTH;
 		divider_ops = &imx8m_clk_composite_divider_ops;
 		mux_ops = &clk_mux_ops;
 		if (!(composite_flags & IMX_COMPOSITE_FW_MANAGED))
-- 
2.39.2


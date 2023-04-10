Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6A66DC624
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 13:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjDJLKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 07:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjDJLKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 07:10:52 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D488E5264;
        Mon, 10 Apr 2023 04:10:25 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id e13so4071906plc.12;
        Mon, 10 Apr 2023 04:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681125022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IrGWkObbHZex0RD5jh5ZL+1MH7Eazo5YGcbtvBP2RIo=;
        b=nXhSYENdtZfSXY+Agxl/fbkiNyw9tIFWVmquf0aZfF/3vNm+BYJg5fAWkLbPTDc7yO
         mlNzhWYc4l0fP/vRMPwc7HFeC8vxxI9Aof7k+1VMwKkXKtPEF+X2QvJhT65AWcRHb/vb
         NvPzIxgsE7PKdKlagy5+ivXJsSCslcpo1v2Bk70GVau/lNsojdcE6mQyDlM66qH74iYH
         yDurkIHeGjUfkNWTmYJPEmfzniHPRhCsUeAaergp5piTIH3CxqoJ6vnvv82k5xynuEQ+
         kkExJrzhWpy+r5fr87ExIpbIcHj6njdJ15lpyRopHWBDVTs6prV/hMLlBFTD5nmNd8VC
         Xd7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681125022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IrGWkObbHZex0RD5jh5ZL+1MH7Eazo5YGcbtvBP2RIo=;
        b=Xfajs5EzfY852nuDtPYLfSzYHpz1x0LZ23z0uwMbfxKrB9/mFQiDl54pT74GRoGyE3
         nTZrM9G+pZndXpRKCd5Ngu1eKnYk9MAAUajYRJKZ9gZDH85mJJm84C4VeMXHWrhZyQG1
         K2xdwOtWWuFhqQXQ9r5BaWE4tu3p4LzBETMcVD8yyINv6ZA4xckGhowNLCWpmA1Y0KQ0
         xEfwLG8LZkFsaKx1vCfx1nZ2OKoe9nX0K6CbguqMcRzi8MDBNEcLz2fIGrVmSUWo/95h
         YgD9e158MP18ohqtPW6zRj9LVKZg9mg04RueFrBndscXHm94K1CBZukNjPBDtr4oziCA
         dGmg==
X-Gm-Message-State: AAQBX9cJ5rP/VhcsBwfVReAZXUN7C5AUOEAhTYkmy/Rh17IoPO5tsHuE
        ywS/m+JC1xNLtO17HXKQjGzixJhrydKk4lN9Sv0=
X-Google-Smtp-Source: AKy350bXPsiLqz13ZywfB6KNEPButH+N+CWkYfp7XUUaV2buqsnAgNYeIOhRxE4iK38IcdjOx2I1+g==
X-Received: by 2002:a17:903:234c:b0:1a1:8d4e:a71d with SMTP id c12-20020a170903234c00b001a18d4ea71dmr15818760plh.46.1681125022671;
        Mon, 10 Apr 2023 04:10:22 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.213.201])
        by smtp.gmail.com with ESMTPSA id r5-20020a170902be0500b001a076568da9sm7464728pls.216.2023.04.10.04.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 04:10:22 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 12/14] clk: hisilicon: hip04: Convert into platform driver module
Date:   Mon, 10 Apr 2023 19:07:24 +0800
Message-Id: <20230410110733.192151-13-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230410110733.192151-1-mmyangfl@gmail.com>
References: <20230410110733.192151-1-mmyangfl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use common helper functions and register clks with a single of_device_id
data.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/clk/hisilicon/clk-hip04.c | 39 +++++++++++++++++++------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/hisilicon/clk-hip04.c b/drivers/clk/hisilicon/clk-hip04.c
index 785b9faf3ea5..230702057e3b 100644
--- a/drivers/clk/hisilicon/clk-hip04.c
+++ b/drivers/clk/hisilicon/clk-hip04.c
@@ -10,11 +10,8 @@
 
 #include <linux/kernel.h>
 #include <linux/clk-provider.h>
-#include <linux/io.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
+#include <linux/module.h>
 #include <linux/of_device.h>
-#include <linux/slab.h>
 
 #include <dt-bindings/clock/hip04-clock.h>
 
@@ -27,16 +24,28 @@ static struct hisi_fixed_rate_clock hip04_fixed_rate_clks[] __initdata = {
 	{ HIP04_CLK_168M, "clk168m",  NULL, 0, 168750000, },
 };
 
-static void __init hip04_clk_init(struct device_node *np)
-{
-	struct hisi_clock_data *clk_data;
+static const struct hisi_clocks hip04_clks = {
+	.fixed_rate_clks = hip04_fixed_rate_clks,
+	.fixed_factor_clks_num = ARRAY_SIZE(hip04_fixed_rate_clks),
+};
+
+static const struct of_device_id hip04_clk_match_table[] = {
+	{ .compatible = "hisilicon,hip04-clock",
+	  .data = &hip04_clks },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, hip04_clk_match_table);
+
+static struct platform_driver hip04_clk_driver = {
+	.probe = hisi_clk_probe,
+	.remove = hisi_clk_remove,
+	.driver		= {
+		.name	= "hip04-clock",
+		.of_match_table = hip04_clk_match_table,
+	},
+};
 
-	clk_data = hisi_clk_init(np, HIP04_NR_CLKS);
-	if (!clk_data)
-		return;
+module_platform_driver(hip04_clk_driver);
 
-	hisi_clk_register_fixed_rate(hip04_fixed_rate_clks,
-				     ARRAY_SIZE(hip04_fixed_rate_clks),
-				     clk_data);
-}
-CLK_OF_DECLARE(hip04_clk, "hisilicon,hip04-clock", hip04_clk_init);
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("HiSilicon HiP04 Clock Driver");
-- 
2.39.2


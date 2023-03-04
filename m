Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518936AA86B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 07:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjCDGgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 01:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjCDGg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 01:36:29 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B2439BB2;
        Fri,  3 Mar 2023 22:36:04 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id ce8-20020a17090aff0800b0023a61cff2c6so3737887pjb.0;
        Fri, 03 Mar 2023 22:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677911763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FUhLsNyPmVU+p4nSMuQbubSNewYgCXTqVnlGe5Mdtbg=;
        b=XkFEtjm3ITcnamfj0spR6XohYiAAYiLssKqVvqFuhJ0UMCDeJyUDp6K5F2fKO2J+js
         eznSZgxdJlOqR4FqEh5zxA66yHr075lAuaLjubSh7EPEijdsxbYjjmra4dKY6Z7+xDTN
         lXR5/YVky1B/slIlY5RZvbJlZ2H67X3Qt3HJvVoIqe7wbbmUed8hFJbx8Slmmyk77Z04
         /NgGp3BgLyFaDJKqS4R6EwLb6l/0+5n9xsUUYRlR8pDS48XBrE4JuTVZOcz7BN+ZE6Wc
         LdvN6KOtm3N7lF9ZPQ31NvNGvqyeh7TQqBSPQLAqn7T6dNUT6HNN3NThgE13nKj1w5s1
         dzDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677911763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FUhLsNyPmVU+p4nSMuQbubSNewYgCXTqVnlGe5Mdtbg=;
        b=hnHmrVgTrOH51VmCA1YedJlezeg84KUl30JJU/C8rn9HRVp6p6/Oy5BdyF6rrJl9j9
         tHcBZXsL7zZB9QF9yFRiiWweyCcBE+yvHMBDbkB7i/30x6FB76TySfGQ/z7NEhqHuP4A
         MjllM6z2lw+pn27hvf9Bp9E5773y6jCX1hisxsykRgELppSU5ts2OyFzVf+ubJkIHAjn
         hF9OF5HRtc2Bn9ZOTUMek89RnrbUknn5cI8/ow2kTvtB1pQYdjAM+2a+iIS9DSdb6PD4
         L4UNX7yFE8VnGzb1PUna1gmgMkxEnpqbLmONDo8mb1UwYMgse9YKv5PilNE3ot6XQZXx
         SHiQ==
X-Gm-Message-State: AO0yUKVUQCtYZBsmqXkFRqvqsTxWVOM+ygVPMIWbTJkLfFiDvExjcLr2
        VRKZCAH4c4YqgBqf5U6Z7kk=
X-Google-Smtp-Source: AK7set9f77/6UAPw5fR9MvNxEP6vyq1lRFhvGhZCIYgDsV0rL9U8oekW7ZwPMvdKM9qKPS7ClnDMbg==
X-Received: by 2002:a17:902:d2c7:b0:19e:8bfe:7d70 with SMTP id n7-20020a170902d2c700b0019e8bfe7d70mr5697179plc.52.1677911762938;
        Fri, 03 Mar 2023 22:36:02 -0800 (PST)
Received: from y.ha.lan ([104.28.245.199])
        by smtp.gmail.com with ESMTPSA id t5-20020a170902e84500b0019aa6bf4450sm2520938plg.188.2023.03.03.22.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 22:36:02 -0800 (PST)
From:   David Yang <mmyangfl@gmail.com>
To:     mmyangfl@gmail.com
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] clk: hisilicon: Add inner clocks for Hi3798MV100
Date:   Sat,  4 Mar 2023 14:33:28 +0800
Message-Id: <20230304063333.162309-7-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230304063333.162309-1-mmyangfl@gmail.com>
References: <20230304063333.162309-1-mmyangfl@gmail.com>
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

These are inner clocks for Hi3798MV100, but not exist on Hi3798CV200.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/clk/hisilicon/crg-hi3798.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/hisilicon/crg-hi3798.c b/drivers/clk/hisilicon/crg-hi3798.c
index b52d44350..8a6e978f3 100644
--- a/drivers/clk/hisilicon/crg-hi3798.c
+++ b/drivers/clk/hisilicon/crg-hi3798.c
@@ -38,6 +38,9 @@
 #define HI3798_FIXED_166P5M		84
 #define HI3798_SDIO0_MUX			85
 #define HI3798_COMBPHY0_MUX		86
+#define HI3798_FIXED_3M				87
+#define HI3798_FIXED_15M			88
+#define HI3798_FIXED_83P3M			89
 
 #define HI3798_CRG_NR_CLKS			128
 
@@ -45,13 +48,16 @@ static const struct hisi_fixed_rate_clock hi3798_fixed_rate_clks[] = {
 	{ HISTB_OSC_CLK, "clk_osc", NULL, 0, 24000000, },
 	{ HISTB_APB_CLK, "clk_apb", NULL, 0, 100000000, },
 	{ HISTB_AHB_CLK, "clk_ahb", NULL, 0, 200000000, },
+	{ HI3798_FIXED_3M, "3m", NULL, 0, 3000000, },
 	{ HI3798_FIXED_12M, "12m", NULL, 0, 12000000, },
+	{ HI3798_FIXED_15M, "15m", NULL, 0, 15000000, },
 	{ HI3798_FIXED_24M, "24m", NULL, 0, 24000000, },
 	{ HI3798_FIXED_25M, "25m", NULL, 0, 25000000, },
 	{ HI3798_FIXED_48M, "48m", NULL, 0, 48000000, },
 	{ HI3798_FIXED_50M, "50m", NULL, 0, 50000000, },
 	{ HI3798_FIXED_60M, "60m", NULL, 0, 60000000, },
 	{ HI3798_FIXED_75M, "75m", NULL, 0, 75000000, },
+	{ HI3798_FIXED_83P3M, "83p3m", NULL, 0, 83333333, },
 	{ HI3798_FIXED_100M, "100m", NULL, 0, 100000000, },
 	{ HI3798_FIXED_150M, "150m", NULL, 0, 150000000, },
 	{ HI3798_FIXED_166P5M, "166p5m", NULL, 0, 165000000, },
-- 
2.39.2


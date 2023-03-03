Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D326A9A6C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 16:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjCCPQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 10:16:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbjCCPQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 10:16:23 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A48C1ABE5;
        Fri,  3 Mar 2023 07:16:11 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id h11-20020a17090a2ecb00b00237c740335cso2544291pjs.3;
        Fri, 03 Mar 2023 07:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677856570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uVLpRrnbJZYVSWnf+8w+Ja+4k+GNp4CYJagkV8lja6A=;
        b=MYZlbShpiWJ8tuVB+tv5E9GwjjdpSgKTQegKaVgGsW5ffcy3jf0ZyB5HSZ7sJlibMz
         54j91VyFRpmq2oNU6dxVfd3vNBs7EqX7gy3ATDdOgRFYoUHJH4YP40P1aSdSFdXOx0zX
         XQ62kdJGbazjYbRnRcgPonp2qAn3lfn4NhOvdOdyOoJuUUmT8x1w9QYkOkcONwoNpHXe
         1pih8PhDi7ZGqZ0fqZScvwO4dCQpofJ+0FY4ZgFYJ3lLSWpeYc+osCAzxuIXxh0PtQT/
         MwECweGSZ0nKY0k02zPy5VPjH0R0DC1Yp0zKMYQPo/d6tiwVUPS3VqQDgovaySSOybrz
         Syyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677856570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uVLpRrnbJZYVSWnf+8w+Ja+4k+GNp4CYJagkV8lja6A=;
        b=3Sne2ZHHZ4kp7UQfFaqU3vRSPHvFRSM0CZ0nNB7/hs0J49SqiA+GwLkvAYzOyxLN03
         ASPUNd+DmC1eCD3uErRBu7lssqWKf1UiqH2xwFUOSXOZFbOEMerqPgJBMmkAnUejUdw6
         bsDdMgVcRgznAoVXk1KDv9+BiVTeRoKrBDjcRsY2HYKAs8U08MaSfSNLYtSQfkFSII6m
         eVJmwKC23p06WMMMVs/+MdYw+qfJ65Fv4TaPgE3BaJ8fUPhXueytkkr78QAC/OlumD7K
         VEgJhrA1CG7ULRUXFe1ArsMpg/3/GlhJ4D/NCoT/LTLsdiWTR3K4Bj+ZsJss7RqhIHRZ
         hHRw==
X-Gm-Message-State: AO0yUKXIk5qlWLDhr8rLhNcm5Lv6WkUsJuygQQOH7RPVSOS91wNvbWRe
        pYOVOC4GSDwbhYXT7P4xLv8=
X-Google-Smtp-Source: AK7set//3HDVBop2h/1zLx+IbiprMVSqg6SHbc5+SfsnVlXYSG0MEU/3epuUYU90e362SxjkfmjlRQ==
X-Received: by 2002:a05:6a20:748b:b0:cd:83b1:4236 with SMTP id p11-20020a056a20748b00b000cd83b14236mr2258340pzd.36.1677856570607;
        Fri, 03 Mar 2023 07:16:10 -0800 (PST)
Received: from y.ha.lan ([104.28.213.199])
        by smtp.gmail.com with ESMTPSA id p4-20020aa78604000000b005a8bdc18453sm1739721pfn.35.2023.03.03.07.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 07:16:09 -0800 (PST)
From:   David Yang <mmyangfl@gmail.com>
To:     mmyangfl@gmail.com
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] clk: hisilicon: Add inner clocks for Hi3798MV100
Date:   Fri,  3 Mar 2023 23:14:12 +0800
Message-Id: <20230303151417.104321-5-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303151417.104321-1-mmyangfl@gmail.com>
References: <20230303151417.104321-1-mmyangfl@gmail.com>
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
index f834805d7..791d39e6a 100644
--- a/drivers/clk/hisilicon/crg-hi3798.c
+++ b/drivers/clk/hisilicon/crg-hi3798.c
@@ -36,6 +36,9 @@
 #define HI3798_FIXED_166P5M		84
 #define HI3798_SDIO0_MUX			85
 #define HI3798_COMBPHY0_MUX		86
+#define HI3798_FIXED_3M				87
+#define HI3798_FIXED_15M			88
+#define HI3798_FIXED_83P3M			89
 
 #define HI3798_CRG_NR_CLKS			128
 
@@ -43,13 +46,16 @@ static const struct hisi_fixed_rate_clock hi3798_fixed_rate_clks[] = {
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
2.39.1


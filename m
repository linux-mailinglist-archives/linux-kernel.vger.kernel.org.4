Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B745EA14E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 12:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbiIZKrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 06:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236851AbiIZKow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 06:44:52 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B698564DF
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 03:25:47 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id j6-20020a17090a694600b00200bba67dadso6251552pjm.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 03:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=dHvW2mH0yZiCOpVix1KpaCgJFkZzSxad+cGKtiAaGB8=;
        b=RR2mK+4EOLZeN2sV7vuva88OhXlVdJgc07lHJrrM/3kAtVbhudmeUXxGhqeApoNlF3
         dn1ig/9OK1FDFXgKmAshSICrlPAiCcoXHD+oeNZ/af2UFeNqS77kewikCdl7O0oJmW3+
         0usfVX0ObdYmWEtqJBTSXlJGh787/7Jyd+LNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=dHvW2mH0yZiCOpVix1KpaCgJFkZzSxad+cGKtiAaGB8=;
        b=64/slcSx2TeU5qngajPAqjXLIdhjOupPjr057y0cEoj0tgXnrqH4/xz14FroCJbKWr
         sAOKnD0bfx2Op1bxg4rSsujEqIPUjLAQD9mfiYqhNveTUv+tuLfvW7osEm/r4JLrQMib
         N9mYIkNxyH7b7pqrbHqpf0z+3wi8oBgf1I3LjtymtpYQbJlitolDQQhxXszYijqm2iiM
         NvRFndAGXjKsBc7UtCiM+/g5lMngRTqm2N/2vuAayORpEpVppG+8Nl/VXHufBmuNK1cA
         RHUNpKV7RjqY6OZBLfFWMIX0ymZE5ZbB3EARX+UVa8H31AJPNU3VtxFFg2Pb7kjnDMqg
         F8YA==
X-Gm-Message-State: ACrzQf0Fuz75K14y9+SH4/MaFosBP3NUEliNB0386gbs//J2oaddCeRb
        YJBNkHUNYvJHB9XyFroiG+HmTA==
X-Google-Smtp-Source: AMsMyM6GO+xZ/4H55pKgg7oGLLiGoq5xAuQEHhVv4iONQ8d2QBXxbflaWwxcIu+dHBA+3JhyfTC7lA==
X-Received: by 2002:a17:90a:f28b:b0:203:627c:7ba1 with SMTP id fs11-20020a17090af28b00b00203627c7ba1mr35851443pjb.191.1664187946492;
        Mon, 26 Sep 2022 03:25:46 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:1340:7319:2f7a:3be9])
        by smtp.gmail.com with ESMTPSA id y23-20020aa79af7000000b00536aa488062sm11750236pfp.163.2022.09.26.03.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 03:25:45 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] clk: mediatek: mt8192: Do not re-register top_early_divs in probe function
Date:   Mon, 26 Sep 2022 18:25:20 +0800
Message-Id: <20220926102523.2367530-4-wenst@chromium.org>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
In-Reply-To: <20220926102523.2367530-1-wenst@chromium.org>
References: <20220926102523.2367530-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

top_early_divs are registered in the CLK_OF_DECLARE_DRIVER() half of the
topckgen clk driver. Don't try to register it again in the actual probe
function. This gets rid of the "Trying to register duplicate clock ..."
warning.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/clk-mt8192.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mt8192.c b/drivers/clk/mediatek/clk-mt8192.c
index ebbd2798d9a3..e39012583675 100644
--- a/drivers/clk/mediatek/clk-mt8192.c
+++ b/drivers/clk/mediatek/clk-mt8192.c
@@ -1235,7 +1235,6 @@ static int clk_mt8192_top_probe(struct platform_device *pdev)
 		return PTR_ERR(base);
 
 	mtk_clk_register_fixed_clks(top_fixed_clks, ARRAY_SIZE(top_fixed_clks), top_clk_data);
-	mtk_clk_register_factors(top_early_divs, ARRAY_SIZE(top_early_divs), top_clk_data);
 	mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), top_clk_data);
 	mtk_clk_register_muxes(top_mtk_muxes, ARRAY_SIZE(top_mtk_muxes), node, &mt8192_clk_lock,
 			       top_clk_data);
-- 
2.37.3.998.g577e59143f-goog


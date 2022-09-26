Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD53C5EA143
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 12:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233996AbiIZKrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 06:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236777AbiIZKok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 06:44:40 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C128564C1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 03:25:43 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id e68so6251878pfe.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 03:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=A/piew8Fp8myCT2H8kL5OBdjHwCVZfK2/VXVhRTmvrA=;
        b=QZE3s8uY6O3BJZAekWSS/9P/kvQFZmhBge/VrG6u8e1drv/yDzwLtC1XSjk4XpTPO2
         nt3wgJn/zYSSxkBu7vCt8GdORaOm9mUOv0by5SOZZPG/Lxst3srJU0lIC0GX6OhQtbEY
         EMTlRzW9Dihz3h/rW6QMpgIKvSOqZwbwmX7QE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=A/piew8Fp8myCT2H8kL5OBdjHwCVZfK2/VXVhRTmvrA=;
        b=zxTzM960X6oNLoQRrV0/TEwU6ZoOECfDgCJPi4h329Pq0AN+uoju3qRCYnPh3LSVRB
         Fney9WLv2wHt0fptac7W2O9wv1LoUcFc3fYT8SfdyErJXeUU2XQfU6AIEniuEddj2aPd
         q1pBYgLnsjp5qRvr3eYDYWqzittaa7LS/tObk7GpD+iVxpZdegWr96l+KtHY9YadIIEN
         Y56au76feZYoBjd7vbazWyU2r4ptkj0o9wEVhq1oSog4Imj+buOZG54cxi7yqG7unNxv
         BQHre0zOZyT85rvY5p+Tuv58oFnDt0OubyXexmWjHiXCw1++/ObqUB++mdgLkPox1MYZ
         RWbg==
X-Gm-Message-State: ACrzQf0PcQIm7voEV4RHaFUhXY6XZnrVec5vs9xuwQgt72QCITIx3Sr4
        YFpWQg6RUyTkHvOmVe3eRkY9tQ==
X-Google-Smtp-Source: AMsMyM5LeLpH/v+lk+tfYQJnPOUrdY5XAVfRKUVAvafdYHbHQUM9imjsantKF6FAiXJ+CvJvmxQhGg==
X-Received: by 2002:a63:6c08:0:b0:43c:7bd5:2d3c with SMTP id h8-20020a636c08000000b0043c7bd52d3cmr9778327pgc.145.1664187942786;
        Mon, 26 Sep 2022 03:25:42 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:1340:7319:2f7a:3be9])
        by smtp.gmail.com with ESMTPSA id y23-20020aa79af7000000b00536aa488062sm11750236pfp.163.2022.09.26.03.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 03:25:40 -0700 (PDT)
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
Subject: [PATCH 2/6] clk: mediatek: Migrate remaining clk_unregister_*() to clk_hw_unregister_*()
Date:   Mon, 26 Sep 2022 18:25:19 +0800
Message-Id: <20220926102523.2367530-3-wenst@chromium.org>
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

During the previous |struct clk| to |struct clk_hw| clk provider API
migration in commit 6f691a586296 ("clk: mediatek: Switch to clk_hw
provider APIs"), a few clk_unregister_*() calls were missed.

Migrate the remaining ones to the |struct clk_hw| provider API, i.e.
change clk_unregister_*() to clk_hw_unregister_*().

Fixes: 6f691a586296 ("clk: mediatek: Switch to clk_hw provider APIs")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/clk-mtk.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 174d0645be38..a8ae65302837 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -80,7 +80,7 @@ int mtk_clk_register_fixed_clks(const struct mtk_fixed_clk *clks, int num,
 		if (IS_ERR_OR_NULL(clk_data->hws[rc->id]))
 			continue;
 
-		clk_unregister_fixed_rate(clk_data->hws[rc->id]->clk);
+		clk_hw_unregister_fixed_rate(clk_data->hws[rc->id]);
 		clk_data->hws[rc->id] = ERR_PTR(-ENOENT);
 	}
 
@@ -102,7 +102,7 @@ void mtk_clk_unregister_fixed_clks(const struct mtk_fixed_clk *clks, int num,
 		if (IS_ERR_OR_NULL(clk_data->hws[rc->id]))
 			continue;
 
-		clk_unregister_fixed_rate(clk_data->hws[rc->id]->clk);
+		clk_hw_unregister_fixed_rate(clk_data->hws[rc->id]);
 		clk_data->hws[rc->id] = ERR_PTR(-ENOENT);
 	}
 }
@@ -146,7 +146,7 @@ int mtk_clk_register_factors(const struct mtk_fixed_factor *clks, int num,
 		if (IS_ERR_OR_NULL(clk_data->hws[ff->id]))
 			continue;
 
-		clk_unregister_fixed_factor(clk_data->hws[ff->id]->clk);
+		clk_hw_unregister_fixed_factor(clk_data->hws[ff->id]);
 		clk_data->hws[ff->id] = ERR_PTR(-ENOENT);
 	}
 
@@ -168,7 +168,7 @@ void mtk_clk_unregister_factors(const struct mtk_fixed_factor *clks, int num,
 		if (IS_ERR_OR_NULL(clk_data->hws[ff->id]))
 			continue;
 
-		clk_unregister_fixed_factor(clk_data->hws[ff->id]->clk);
+		clk_hw_unregister_fixed_factor(clk_data->hws[ff->id]);
 		clk_data->hws[ff->id] = ERR_PTR(-ENOENT);
 	}
 }
@@ -414,7 +414,7 @@ void mtk_clk_unregister_dividers(const struct mtk_clk_divider *mcds, int num,
 		if (IS_ERR_OR_NULL(clk_data->hws[mcd->id]))
 			continue;
 
-		clk_unregister_divider(clk_data->hws[mcd->id]->clk);
+		clk_hw_unregister_divider(clk_data->hws[mcd->id]);
 		clk_data->hws[mcd->id] = ERR_PTR(-ENOENT);
 	}
 }
-- 
2.37.3.998.g577e59143f-goog


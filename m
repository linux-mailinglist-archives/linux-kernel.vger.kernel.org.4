Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D085EA145
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 12:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236407AbiIZKrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 06:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236782AbiIZKol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 06:44:41 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED89558D0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 03:25:41 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id bh13so6159605pgb.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 03:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=O4AFSEm4LB6qxx3Sb5LYIkYBm4L4/UlSqT6dVKfvuN4=;
        b=dl+3CNlZui8oNWXXu4YFMr45DptQ+4JyM9MHVGTDmC1u5pYdc22pE31BLQiV32TSaq
         owmiP02AvC0D7MucfFZwmmEIETbCIYl05LVhYMKaK7JfCiKZEsHW6w6A2DFgJGzd3pZy
         yd2+zLzB0qZEQ35B1KaXHncQti9IoyhY4msyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=O4AFSEm4LB6qxx3Sb5LYIkYBm4L4/UlSqT6dVKfvuN4=;
        b=tW3cdXYmAn3QH6s/telrTb0YvFOojO0JXVqHDQX/JOncZx4KJISjQGJoAXjZCTat7m
         zbzCBPEolfK68iY3wcvyxkQaZBdr6idPi0qKN1TxxXCZRrooKZfvA6mLCW5yDrdX1mul
         QDsmt38owSlQmD8EGAG4WyZWm1swosJQbgWGAR7Ko8C6cYhkUVYWYHs+lc8Hq7cHtXOG
         9xW/5Q+YEYpqd2WrT5MGFjEu17VATJbfhoaU8khlfr+DsftCbtY7ltqWU+zSjlM3l6ua
         Z8uPn79kUzDEGalfKpqVgKkht2rkKJJsnUx7R3tvfpza1VpW1Dj81kcajsVQF6CU6+pD
         LHDg==
X-Gm-Message-State: ACrzQf3usuuQEzvJUadr5kNm/CDNzWWGQjtk8lbjoyT+sSh+YByXWn5e
        XCM4U3ScrXsJYNi97Xi6E8j8wQ==
X-Google-Smtp-Source: AMsMyM6X/OE4U7u8QXgyKJhL4/M4HGtxHlhFxAAR/N87RBO9psjoUIWS1mEQNDKvb+OHhc91E49WlQ==
X-Received: by 2002:a05:6a00:140a:b0:540:bdb4:aa54 with SMTP id l10-20020a056a00140a00b00540bdb4aa54mr22762892pfu.17.1664187938480;
        Mon, 26 Sep 2022 03:25:38 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:1340:7319:2f7a:3be9])
        by smtp.gmail.com with ESMTPSA id y23-20020aa79af7000000b00536aa488062sm11750236pfp.163.2022.09.26.03.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 03:25:36 -0700 (PDT)
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
Subject: [PATCH 1/6] clk: mediatek: fix unregister function in mtk_clk_register_dividers cleanup
Date:   Mon, 26 Sep 2022 18:25:18 +0800
Message-Id: <20220926102523.2367530-2-wenst@chromium.org>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
In-Reply-To: <20220926102523.2367530-1-wenst@chromium.org>
References: <20220926102523.2367530-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the cleanup paths for the various clk register APIs in the MediaTek
clk library were added, the one in the dividers type used the wrong type
of unregister function. This would result in incorrect dereferencing of
the clk pointer and freeing of invalid pointers.

Fix this by switching to the correct type of clk unregistration call.

Fixes: 3c3ba2ab0226 ("clk: mediatek: mtk: Implement error handling in register APIs")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/clk-mtk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 3a8875b6c37f..174d0645be38 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -393,7 +393,7 @@ int mtk_clk_register_dividers(const struct mtk_clk_divider *mcds, int num,
 		if (IS_ERR_OR_NULL(clk_data->hws[mcd->id]))
 			continue;
 
-		mtk_clk_unregister_composite(clk_data->hws[mcd->id]);
+		clk_hw_unregister_divider(clk_data->hws[mcd->id]);
 		clk_data->hws[mcd->id] = ERR_PTR(-ENOENT);
 	}
 
-- 
2.37.3.998.g577e59143f-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E968F5EA14F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 12:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiIZKrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 06:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236427AbiIZKpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 06:45:23 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0305456B87
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 03:25:51 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id w20so5792817ply.12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 03:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ZcjMxa2oa+nNSgVobg8BYi3nOn8RkspzQwdQr25nofU=;
        b=OMxiqQX8klwSiTnH9e9oVMFD2NRMrLyCvdOnToTR9NqWO8Xje08UhWK3SnMI7HlfEv
         ZqBipRTznMLPjzOZ5r4GDjpC8pG8OM/dmLUNbzZoT9ZhDagkPSMnRlwbwTrUyhHRpTRn
         XrYyoxSWMX3clEunMXnmZ1a8x5VnLM46a9gms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ZcjMxa2oa+nNSgVobg8BYi3nOn8RkspzQwdQr25nofU=;
        b=A7rapAzxHUG/DYIcqSLnUhinBuAO+SZ7wg1dLD9o+g8nEER1skG/xjaHs3hkAISHYI
         NHBEn72QNPs3KUsdv7jUX5eoAubx1BGqlylqjp2RnqsgehYDzAJryD966lyevfvcHt9U
         Bda8qFLcyScsMnCmeMK1/+hclh2g6KoSk5KGchLwueNshFx1tZMaQ75LJ/VkU5qHuFNg
         aPE2iAtiB67ZAqzvgzbIvSGcm9Cn02d1af6S3+4xUvHgcK5kyv37kB6BRl6M9Dbw4H3X
         RpmkKrOY8xUq7uNIOZMhHzxRASRzbDC6PkHl0TawUgtwvrNb855vZbNSEe6ckY4vBXIO
         h+nQ==
X-Gm-Message-State: ACrzQf1MWTfaoO1/JvtlbIy/JrftRjsCu5a2ADmQlAVHHar/67i6SXB+
        pcGWemM7L4DxAVTa2QDnWejGJw==
X-Google-Smtp-Source: AMsMyM7rm/4uF8tsgKbxdB8WUvp8S7VPaRGhX5QYj4RqmRAMsvZnozyIL13tvcR0AVrdkEnDbmUMqw==
X-Received: by 2002:a17:902:d4ce:b0:177:fe49:19eb with SMTP id o14-20020a170902d4ce00b00177fe4919ebmr21053793plg.170.1664187950840;
        Mon, 26 Sep 2022 03:25:50 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:1340:7319:2f7a:3be9])
        by smtp.gmail.com with ESMTPSA id y23-20020aa79af7000000b00536aa488062sm11750236pfp.163.2022.09.26.03.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 03:25:48 -0700 (PDT)
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
Subject: [PATCH 4/6] clk: mediatek: mt8192: Avoid duplicate OF clk provider for topckgen
Date:   Mon, 26 Sep 2022 18:25:21 +0800
Message-Id: <20220926102523.2367530-5-wenst@chromium.org>
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

The MT8192 topckgen clock driver is split into two parts, an early
CLK_OF_DECLARE_DRIVER() part which registers one clock solely for the
system timer, and a standard platform driver part that handles the rest.

In both parts, of_clk_hw_add_provider() is called, causing the clk
provider to be added twice. While this doesn't cause issues, it isn't
clean either.

Remove the existing entry before calling of_clk_hw_add_provider() in
the platform driver probe function. This ensures that there is only
one entry, and the OF related code still runs on the full set of
clocks.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/clk-mt8192.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt8192.c b/drivers/clk/mediatek/clk-mt8192.c
index e39012583675..c2ce72df6db0 100644
--- a/drivers/clk/mediatek/clk-mt8192.c
+++ b/drivers/clk/mediatek/clk-mt8192.c
@@ -1246,6 +1246,12 @@ static int clk_mt8192_top_probe(struct platform_device *pdev)
 	if (r)
 		return r;
 
+	/*
+	 * Remove clock provider set in clk_mt8192_top_init_early() first
+	 * to avoid duplicate entry, and re-add it so the OF related code
+	 * gets run again with the full set of clocks.
+	 */
+	of_clk_del_provider(node);
 	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get,
 				      top_clk_data);
 }
-- 
2.37.3.998.g577e59143f-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE123709F93
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 21:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjESTFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 15:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjESTF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 15:05:28 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCAE115;
        Fri, 19 May 2023 12:05:27 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-213-050.ewe-ip-backbone.de [91.248.213.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CA6BC6606841;
        Fri, 19 May 2023 20:05:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684523125;
        bh=HpjGcJhdbon56V9LWjtK9jrg/LgraseB0ozVjRfM3/4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NmEmBvYU1h3OEZHJG3dkKV9Mi0NeNy1Ehx44n3ehZ+5dFDAYG6CSha+94a9LGuJba
         vrmYGbQd+2TFdN1dHgq+FfYSHjOnhq646fA7tapYLNl4uYzuZbGspcYBPrwpGZjUD4
         Pk5LudCePjsEiKa+GIu3Wvn/V3Ru/ft5h3HJcrVg6hGvKCHGq4bEID5Mq/nNtaSSX4
         MEWRBT4R3sOrj2v07bEhq1yUM3K5Nt/H6iYsVr3AoCAavELYL+KgYFREHaGu071Qv/
         kZny/UGvEtm64sroFNNbS23Fq3uAlfFvk4W1n8882IU90Un8S1kvbEMLVeX8mBx4ma
         YVH1QmWeZ+6Ww==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 88A2E4805B8; Fri, 19 May 2023 21:05:23 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com, stable@vger.kernel.org
Subject: [PATCH v1 1/2] clk: composite: Fix handling of high clock rates
Date:   Fri, 19 May 2023 21:05:21 +0200
Message-Id: <20230519190522.194729-2-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230519190522.194729-1-sebastian.reichel@collabora.com>
References: <20230519190522.194729-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ULONG_MAX is used by a few drivers to figure out the highest available
clock rate via clk_round_rate(clk, ULONG_MAX). Since abs() takes a
signed value as input, the current logic effectively calculates with
ULONG_MAX = -1, which results in the worst parent clock being chosen
instead of the best one.

For example on Rockchip RK3588 the eMMC driver tries to figure out
the highest available clock rate. There are three parent clocks
available resulting in the following rate diffs with the existing
logic:

GPLL:   abs(18446744073709551615 - 1188000000) = 1188000001
CPLL:   abs(18446744073709551615 - 1500000000) = 1500000001
XIN24M: abs(18446744073709551615 -   24000000) =   24000001

As a result the clock framework will promote a maximum supported
clock rate of 24 MHz, even though 1.5GHz are possible. With the
updated logic any casting between signed and unsigned is avoided
and the numbers look like this instead:

GPLL:   18446744073709551615 - 1188000000 = 18446744072521551615
CPLL:   18446744073709551615 - 1500000000 = 18446744072209551615
XIN24M: 18446744073709551615 -   24000000 = 18446744073685551615

As a result the parent with the highest acceptable rate is chosen
instead of the parent clock with the lowest one.

Cc: stable@vger.kernel.org
Fixes: 49502408007b ("mmc: sdhci-of-dwcmshc: properly determine max clock on Rockchip")
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/clk/clk-composite.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
index edfa94641bbf..66759fe28fad 100644
--- a/drivers/clk/clk-composite.c
+++ b/drivers/clk/clk-composite.c
@@ -119,7 +119,10 @@ static int clk_composite_determine_rate(struct clk_hw *hw,
 			if (ret)
 				continue;
 
-			rate_diff = abs(req->rate - tmp_req.rate);
+			if (req->rate >= tmp_req.rate)
+				rate_diff = req->rate - tmp_req.rate;
+			else
+				rate_diff = tmp_req.rate - req->rate;
 
 			if (!rate_diff || !req->best_parent_hw
 				       || best_rate_diff > rate_diff) {
-- 
2.39.2


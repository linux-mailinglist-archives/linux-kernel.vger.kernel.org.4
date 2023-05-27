Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0CB67134FD
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 15:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbjE0N2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 09:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjE0N2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 09:28:24 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050:0:465::101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD34A6;
        Sat, 27 May 2023 06:28:22 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4QT2fl1DKwz9sZf;
        Sat, 27 May 2023 15:28:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1685194095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xCkY+0YMty2Tdhd1Y9tZlY6x9qv5DdKhwiRQK/bh6ws=;
        b=n9z6hRYncmjSRlIQD8fqKNMxq0KursHy0vY+TFGAvJ8y5Kcpc23vtkcWrFLxhMp2C7Lv9T
        fIcMrB6u+BgipYwZZ+IVs+BA9hQ0roYoPen0O6wF6PNr6kvnKc9plVIOpG9ES95mPxVUhu
        RocJ+vPjb1+ErdiWC30xE5PTwm/eh4Kmt4evEI2o1iBEhC1N5s4xhD0Ji5hUT9NwHF4sAW
        Yc34+lvSJv+Wm328W1Fz3Hyu6bNhHV3cMx9YFsONS7/sNga0Y0M9taBihJ5s31yIZC+Aek
        5TtOi5UqZYs5fPitBGk2kVpswN8zsztIOPjaO1eIugzsv/tGgAYmuCK69YIj7g==
From:   Frank Oltmanns <frank@oltmanns.dev>
To:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Cc:     Frank Oltmanns <frank@oltmanns.dev>,
        Andre Przywara <andre.przywara@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [RFC PATCH 1/3] clk: sunxi-ng: nkm: Minimize difference when finding rate
Date:   Sat, 27 May 2023 15:27:45 +0200
Message-Id: <20230527132747.83196-2-frank@oltmanns.dev>
In-Reply-To: <20230527132747.83196-1-frank@oltmanns.dev>
References: <20230527132747.83196-1-frank@oltmanns.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of selecting the first rate that is less than the requested
rate, select the rate that minimizes the absolute difference with the
requested rate. This ensures a more accurate rate selection, when the
closest available rate is higher than the requested rate.

Also stop searching once an exact match is found.

Adjust mux to this change in rate selection.

Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
---
 drivers/clk/sunxi-ng/ccu_mux.c |  2 +-
 drivers/clk/sunxi-ng/ccu_nkm.c | 13 +++++++++----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu_mux.c b/drivers/clk/sunxi-ng/ccu_mux.c
index 9303e1f02ffd..6fe0a8d098f1 100644
--- a/drivers/clk/sunxi-ng/ccu_mux.c
+++ b/drivers/clk/sunxi-ng/ccu_mux.c
@@ -145,7 +145,7 @@ int ccu_mux_helper_determine_rate(struct ccu_common *common,
 			goto out;
 		}
 
-		if ((req->rate - tmp_rate) < (req->rate - best_rate)) {
+		if (abs(req->rate - tmp_rate) < abs(req->rate - best_rate)) {
 			best_rate = tmp_rate;
 			best_parent_rate = parent_rate;
 			best_parent = parent;
diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nkm.c
index a0978a50edae..94d2a83992b2 100644
--- a/drivers/clk/sunxi-ng/ccu_nkm.c
+++ b/drivers/clk/sunxi-ng/ccu_nkm.c
@@ -19,7 +19,7 @@ struct _ccu_nkm {
 static unsigned long ccu_nkm_find_best(unsigned long parent, unsigned long rate,
 				       struct _ccu_nkm *nkm)
 {
-	unsigned long best_rate = 0;
+	unsigned long best_rate = 0, best_diff = ULONG_MAX;
 	unsigned long best_n = 0, best_k = 0, best_m = 0;
 	unsigned long _n, _k, _m;
 
@@ -27,21 +27,26 @@ static unsigned long ccu_nkm_find_best(unsigned long parent, unsigned long rate,
 		for (_n = nkm->min_n; _n <= nkm->max_n; _n++) {
 			for (_m = nkm->min_m; _m <= nkm->max_m; _m++) {
 				unsigned long tmp_rate;
+				unsigned long tmp_diff;
 
 				tmp_rate = parent * _n * _k / _m;
 
-				if (tmp_rate > rate)
-					continue;
-				if ((rate - tmp_rate) < (rate - best_rate)) {
+				tmp_diff = abs(rate - tmp_rate);
+
+				if (tmp_diff < best_diff) {
 					best_rate = tmp_rate;
+					best_diff = tmp_diff;
 					best_n = _n;
 					best_k = _k;
 					best_m = _m;
+					if (best_diff == 0)
+						goto out;
 				}
 			}
 		}
 	}
 
+out:
 	nkm->n = best_n;
 	nkm->k = best_k;
 	nkm->m = best_m;
-- 
2.40.1


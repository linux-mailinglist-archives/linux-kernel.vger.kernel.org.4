Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650786937B5
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 15:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjBLOMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 09:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjBLOMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 09:12:02 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056B6F77D;
        Sun, 12 Feb 2023 06:12:02 -0800 (PST)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 3BA1DD38CF;
        Sun, 12 Feb 2023 14:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1676211090; bh=qFK6KiGkL2Ya37v4r7g08gVdvQ3WQ3Zqy1iFF42jPdE=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=HC5VzDU/7oVhktaUl5K/8a0J1ijbpNVD36QUZjlqGNHwGD5jKpZujIwxf1Bm3V+Xu
         GsF/PYnLzj0JrFvC4NC6wGuSi60h48B5/brIGiOhitoBxifK911M4jgenPxFp/jabf
         t+mcd1cC4pC0WiAL9t5FyqGwG3YzGAFprjPoCMe4=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Sun, 12 Feb 2023 15:11:09 +0100
Subject: [PATCH 2/2] clk: qcom: clk-hfpll: switch to .determine_rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230212-clk-qcom-determine_rate-v1-2-b4e447d4926e@z3ntu.xyz>
References: <20230212-clk-qcom-determine_rate-v1-0-b4e447d4926e@z3ntu.xyz>
In-Reply-To: <20230212-clk-qcom-determine_rate-v1-0-b4e447d4926e@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1899; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=qFK6KiGkL2Ya37v4r7g08gVdvQ3WQ3Zqy1iFF42jPdE=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBj6POQHw2eHpO2tucbsPLIsE0wWtIoMbeD9jIxo
 SytZgYbKcOJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCY+jzkAAKCRBy2EO4nU3X
 Vi4rD/9aHBRishQyFuZrmzfeCFOYgln9UKcBbsJrygK4Vbwnqb4xslopUl9KlyBR58kEWbD0Xc/
 RKvsoc9Szll8iLmYrEvsiJsLTiDHwqQFXjvyq54Sawq7W40gTPKeI4ziM0SPr5TBrDpEVT+1aDj
 FMbOXk0KpnkFdCcnxvmz6kYx/Q47Afqnd73nwJsIqd64CEZhPtSzKbIXOuOgkRZiY8BzCsYSHA4
 hmguo8kbjK86zg3qia6SEPKX0QnwuV+fL1LCLhk2RORfA0zA0BU2h8xkJt0JVRYTvw5xOscoOES
 Xniy6uLAWFETt9e5kr5npADuAJYGjYWHcc22nc9a0To5vR+EnqwR9ipLW8TCC3ol0V5H1ueyWyX
 7itGwlOR9WKAJgwAKvlUUHZN4hu1+XMkDu53gFPXl0zJLUcr4mt9Zz7iEouhqykV+lK347Y0gFZ
 +Zm83dRyrn6PmHg2pMgJP/eusBBOwWeREVPz3qurX2QRXcMKS1Fpr7KDWACeTa8xX1H/CVD9AVq
 c9ALLqnTW5SyUfPNuuc8bKFYWQPGxfteAAgEmfFmFyapK4Av+UNO8r7IJiT3YCOCsgrK2LUA1Hw
 s2WIT5czzWQqvIzHbtWyqNuA3g5YBEnxoUW8vOdQkkshCVUfPyfaS8szTNerLFtAzt6Xbv9+A2I
 c05/x4oM7rXP0Nw==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

.determine_rate is meant to replace .round_rate. The former comes with a
benefit which is especially relevant on 32-bit systems: since
.determine_rate uses an "unsigned long" (compared to a "signed long"
which is used by .round_rate) the maximum value on 32-bit systems
increases from 2^31 (or approx. 2.14GHz) to 2^32 (or approx. 4.29GHz).

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 drivers/clk/qcom/clk-hfpll.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/qcom/clk-hfpll.c b/drivers/clk/qcom/clk-hfpll.c
index 7dd17c184b69..86f728dc69e5 100644
--- a/drivers/clk/qcom/clk-hfpll.c
+++ b/drivers/clk/qcom/clk-hfpll.c
@@ -128,20 +128,20 @@ static void clk_hfpll_disable(struct clk_hw *hw)
 	spin_unlock_irqrestore(&h->lock, flags);
 }
 
-static long clk_hfpll_round_rate(struct clk_hw *hw, unsigned long rate,
-				 unsigned long *parent_rate)
+static int clk_hfpll_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
 {
 	struct clk_hfpll *h = to_clk_hfpll(hw);
 	struct hfpll_data const *hd = h->d;
 	unsigned long rrate;
 
-	rate = clamp(rate, hd->min_rate, hd->max_rate);
+	req->rate = clamp(req->rate, hd->min_rate, hd->max_rate);
 
-	rrate = DIV_ROUND_UP(rate, *parent_rate) * *parent_rate;
+	rrate = DIV_ROUND_UP(req->rate, req->best_parent_rate) * req->best_parent_rate;
 	if (rrate > hd->max_rate)
-		rrate -= *parent_rate;
+		rrate -= req->best_parent_rate;
 
-	return rrate;
+	req->rate = rrate;
+	return 0;
 }
 
 /*
@@ -241,7 +241,7 @@ const struct clk_ops clk_ops_hfpll = {
 	.enable = clk_hfpll_enable,
 	.disable = clk_hfpll_disable,
 	.is_enabled = hfpll_is_enabled,
-	.round_rate = clk_hfpll_round_rate,
+	.determine_rate = clk_hfpll_determine_rate,
 	.set_rate = clk_hfpll_set_rate,
 	.recalc_rate = clk_hfpll_recalc_rate,
 	.init = clk_hfpll_init,

-- 
2.39.1


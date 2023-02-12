Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAE26937B0
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 15:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjBLOLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 09:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjBLOLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 09:11:32 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF20BEFA6;
        Sun, 12 Feb 2023 06:11:31 -0800 (PST)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id E3777D38CE;
        Sun, 12 Feb 2023 14:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1676211090; bh=zgU9o39Da84lHLJi0IKg+G0/E6H+7pf3Yl35nbVnhXM=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=l4GcRgRTaw5gtb36Y/l+6sEP23S71FBY0Nl34dDdZt928O1Jdt87HB8yqnXNPAm6z
         43ShmMzd0wTZYz7sJCs/jUcXLSAdckLpXehdJGL4FblVF9K18jCex54TjNHJ3asF/9
         6rx+sZpRD3CRxZ6c6ZRNZ6cHkVXEBHvKwD/0vGMU=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Sun, 12 Feb 2023 15:11:08 +0100
Subject: [PATCH 1/2] clk: qcom: clk-krait: switch to .determine_rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230212-clk-qcom-determine_rate-v1-1-b4e447d4926e@z3ntu.xyz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1744; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=zgU9o39Da84lHLJi0IKg+G0/E6H+7pf3Yl35nbVnhXM=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBj6POPcdsS/gifaIu4UFZa8WGjK78dpkq1QvZwa
 8ON314kV/uJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCY+jzjwAKCRBy2EO4nU3X
 VtA2D/99YPIAtzECC44BWhqCo45QGJjoJ4lpLfbFdGVWFeF+7Fbc+L0x+OkkABTb7SJpM8I+Z18
 Stqw5u9D9i00t9piOAC/DsMuwFWV0XkXLsGFZ68tk9RRvQ9FNJIBvUn+kgdge+yS7IWHhkwLM9f
 4mkF9dHrDtX/77CfAe0LPW6npvSvHO589Qn2yHW6bYjAlS4hzmIs/xaHo9T7k7Js9vz0xozoMkU
 JcXh4nwtTF1Ik17YmWwYMTIuntHG48eCuX41J9MSh8AhftILIyVKkiITjn+WdD9/d0VSdoz7nRS
 3P+ZPzajx7KZocYItw5XH2ywMfD24W3vKKG0yBIFAJfBWai0FFugTJv48SUn2tKWPH5AiV5cN5l
 VoGMpElwv0MH0EPNHqRiPNhMi1CkCuYUJZyioSdPSEsMgX03VxdMaiLTC7ZWBk7rjvqX3VElPYZ
 CW37nQyxle5X5+x6/+1gnISofaEghd5HSUCDmxGGYOHQAx6Yj5wUgyhClmuX5uLYsHJUj96ay89
 YK6Gi2AAPWpxMz8SFhOjZXSZrF4HPUsuclC54eCwwS16V+ROrJPxSwGu0IWaoAhwlfumloOxFaX
 ENXdG7QuzKhCxW0xleWXsjEqFiIXp6ObMxHNZJwT7Ibo1LkygovQtV30vFeDxkaNQGT5Dl8mGV4
 hKmrQS0EtwT/hhw==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/clk/qcom/clk-krait.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/qcom/clk-krait.c b/drivers/clk/qcom/clk-krait.c
index 293a9dfa7151..f5ce403e1e27 100644
--- a/drivers/clk/qcom/clk-krait.c
+++ b/drivers/clk/qcom/clk-krait.c
@@ -97,11 +97,11 @@ const struct clk_ops krait_mux_clk_ops = {
 EXPORT_SYMBOL_GPL(krait_mux_clk_ops);
 
 /* The divider can divide by 2, 4, 6 and 8. But we only really need div-2. */
-static long krait_div2_round_rate(struct clk_hw *hw, unsigned long rate,
-				  unsigned long *parent_rate)
+static int krait_div2_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
 {
-	*parent_rate = clk_hw_round_rate(clk_hw_get_parent(hw), rate * 2);
-	return DIV_ROUND_UP(*parent_rate, 2);
+	req->best_parent_rate = clk_hw_round_rate(clk_hw_get_parent(hw), req->rate * 2);
+	req->rate = DIV_ROUND_UP(req->best_parent_rate, 2);
+	return 0;
 }
 
 static int krait_div2_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -142,7 +142,7 @@ krait_div2_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 }
 
 const struct clk_ops krait_div2_clk_ops = {
-	.round_rate = krait_div2_round_rate,
+	.determine_rate = krait_div2_determine_rate,
 	.set_rate = krait_div2_set_rate,
 	.recalc_rate = krait_div2_recalc_rate,
 };

-- 
2.39.1


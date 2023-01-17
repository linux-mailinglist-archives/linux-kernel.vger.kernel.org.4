Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F4A66DFA7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 14:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjAQNzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 08:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjAQNz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 08:55:26 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812CC35B4;
        Tue, 17 Jan 2023 05:55:25 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id o17-20020a05600c511100b003db021ef437so3122962wms.4;
        Tue, 17 Jan 2023 05:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fl9uAlkhTt9RYlBsdPZ+Iiwc7QljNWDz/51SBuY/ELg=;
        b=SHOi6CAIQZ7rSBG5BxuEzyBPFJstWdOK7h2G7Ar8FpFxLmE+y4RBFp4If/5kNcNC/U
         jW+hHR/cw8753ZF0q9sQ7kz5ebAmQkRUMmdzEa9hyA4LagyPc+FYJQzGCLAveabAd1EV
         1XDl1dcIsY3Qou5QdHqpmCJLjXUeIHxPbuKG8LUyoOSFaxyPMK9SVIqoe8+76jk9LMhZ
         ErhcL7k/UKkWHR1nmqqeBQfkTAur2dd/8jN2jCgI2sHdzcgRfoADMm5MrXVpWKDnxKk2
         R3BRhYfJAQ7N/N/5rVd0S63ckGH6HESJbJZT9MXVh7YFv98lnF6pH418eIWHDbiENQik
         9t9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fl9uAlkhTt9RYlBsdPZ+Iiwc7QljNWDz/51SBuY/ELg=;
        b=Xx76wQ751FzzCaTUUhvMyGl/P/bXjxvmJg+1EoxkoSOGQT44/nToTJgdFrBhtXUKMN
         YT5E/zp01HLbblexu7eWVhtA5SxcEBeYX3Jl2rjU2IRGvk+Ud7HyN47UNVgYhTuuL7WF
         J1KiEsiTnrXbgXYE/dNvGfQ/X8WogFeEn5aHeoeqXY/grKdTBE429PJ0b8k1N6jYyvo9
         weyVvhsoYumXnHNtNEJyIthWHYzcSvOzW2qhbPo6CnANgpAgFfJ4uOu0JQlkulcnTbce
         OpZ26v5XAmNldfmdrPrykSKFHAs3c9y44IMJEqjdPzpUCWpPniS6gsQ0KIPj0ynMbJ8m
         sjNw==
X-Gm-Message-State: AFqh2kqD5ljZx7xHKLQf4b4hz0wCjYz7Z4yv+FpRr3E6pH415xOY4eMr
        j3b+1Mn0ZPRyeRSR0qzCIMk=
X-Google-Smtp-Source: AMrXdXv9XygiAycq3Y9mWQOdd3pRR48L8ciEgoMDiZDWN+y0RdzFXdFHvwFqTCz7AGReZtKgVTeu0A==
X-Received: by 2002:a05:600c:3c83:b0:3d9:e5d3:bf with SMTP id bg3-20020a05600c3c8300b003d9e5d300bfmr3110851wmb.32.1673963724002;
        Tue, 17 Jan 2023 05:55:24 -0800 (PST)
Received: from localhost.localdomain (93-34-92-88.ip49.fastwebnet.it. [93.34.92.88])
        by smtp.googlemail.com with ESMTPSA id s7-20020a1cf207000000b003d98438a43asm35147461wmc.34.2023.01.17.05.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 05:55:23 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v3 4/6] clk: qcom: clk-rcg2: don't re-search config on rcg2_set_rate
Date:   Tue, 17 Jan 2023 14:54:57 +0100
Message-Id: <20230117135459.16868-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230117135459.16868-1-ansuelsmth@gmail.com>
References: <20230117135459.16868-1-ansuelsmth@gmail.com>
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

Currently the rcg2 driver search the rate to apply 2 times.
- In _freq_tbl_determine_rate for the determine_rate function used by
  core clk to understand the best rate to set with set_rate
- In rcg2_set_rate where the suggested rate is not trusted and searched
  another time using a CEIL or FLOOR policy.

This is fundamentally wrong as we are ignoring what core clock is
deciding and just setting whatever clock configuration we want for the
suggested clock. The problem is in the fact that the correct clock
should have already be searched and selected with the determine_rate
function and set_rate should just apply whatever clock was provided.

Rework the function using the find_req_exact and by trusting whatever
core clk is asking to set.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/clk-rcg2.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index 76551534f10d..3f15e993dc04 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -352,23 +352,12 @@ static int clk_rcg2_configure(struct clk_rcg2 *rcg, const struct freq_tbl *f)
 	return update_config(rcg);
 }
 
-static int __clk_rcg2_set_rate(struct clk_hw *hw, unsigned long rate,
-			       enum freq_policy policy)
+static int __clk_rcg2_set_rate(struct clk_hw *hw, unsigned long rate)
 {
 	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
 	const struct freq_tbl *f;
 
-	switch (policy) {
-	case FLOOR:
-		f = qcom_find_freq_floor(rcg->freq_tbl, rate);
-		break;
-	case CEIL:
-		f = qcom_find_freq(rcg->freq_tbl, rate);
-		break;
-	default:
-		return -EINVAL;
-	}
-
+	f = qcom_find_freq_exact(rcg->freq_tbl, rate);
 	if (!f)
 		return -EINVAL;
 
@@ -378,25 +367,25 @@ static int __clk_rcg2_set_rate(struct clk_hw *hw, unsigned long rate,
 static int clk_rcg2_set_rate(struct clk_hw *hw, unsigned long rate,
 			    unsigned long parent_rate)
 {
-	return __clk_rcg2_set_rate(hw, rate, CEIL);
+	return __clk_rcg2_set_rate(hw, rate);
 }
 
 static int clk_rcg2_set_floor_rate(struct clk_hw *hw, unsigned long rate,
 				   unsigned long parent_rate)
 {
-	return __clk_rcg2_set_rate(hw, rate, FLOOR);
+	return __clk_rcg2_set_rate(hw, rate);
 }
 
 static int clk_rcg2_set_rate_and_parent(struct clk_hw *hw,
 		unsigned long rate, unsigned long parent_rate, u8 index)
 {
-	return __clk_rcg2_set_rate(hw, rate, CEIL);
+	return __clk_rcg2_set_rate(hw, rate);
 }
 
 static int clk_rcg2_set_floor_rate_and_parent(struct clk_hw *hw,
 		unsigned long rate, unsigned long parent_rate, u8 index)
 {
-	return __clk_rcg2_set_rate(hw, rate, FLOOR);
+	return __clk_rcg2_set_rate(hw, rate);
 }
 
 static int clk_rcg2_get_duty_cycle(struct clk_hw *hw, struct clk_duty *duty)
-- 
2.38.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD08E655E59
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 22:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbiLYV0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 16:26:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiLYV0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 16:26:43 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833CB1010;
        Sun, 25 Dec 2022 13:26:42 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id t17so23044618eju.1;
        Sun, 25 Dec 2022 13:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/q0ndmNr0G5VO5mmrpAzqld+fYwSSkJR22yhfnom9II=;
        b=hZzER+iF+6hFcPJzUmNyCqQJO42nRu6a+rSLJdUpP4qgdSLC0kNAdio44GrPx2rp9s
         7JW7lZSrypqXi/G5o6hCj8apS25LAMJhksaUUPytaSKi88V8H98y4cWDn9z1jUiEI+Js
         NFzHnJRIB6xFdV+pZQlrvUUYYbfwSyCVbmUFMxgLxXCKyMku5rBfEEU9rPIuVH1D7B5C
         Tgn3rNX4zOvZOZj+04gmtAhksU2ObGaiHPvEQQNSpN7hTYFKkrsTSXr5Er8nOhQLRhPa
         CfVFb9GnAXMDFgnt+MtVLTPDyknH3kJ2lNrApx1w0SH2x6Jx2r21caCKweEGr6Z/+7Ep
         yPVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/q0ndmNr0G5VO5mmrpAzqld+fYwSSkJR22yhfnom9II=;
        b=4K8DEhss9KTl3BjBktaNVbB8aFhWtTd6G95wAsOMpQNZ1mfG9ybnxhX+h6Z39I0JOr
         jLDCqRZ8QbuiStfxQMwDNLnd2XQrb+l4WtGl9hdmRyq6H8evWNxQiScrBSuVyIjbvRnf
         qIC6y8SKvRhDWnWuLl0uRuhnkeFoJLSBCTK/c8qtkNdmW8F/89fQdLZRrcAK4JHNSKhr
         DZhWJpd79cY01hz9+P4iVe0usTkxTFLTzYFAAcLc7dOhwVz9401IV3CD5O6nOe32bB1T
         nlog+6DSQNU/131QkSswQ1RWxQXf3TjQ4EnEwNt/GySvKdU0DNgHRNM+ZAZjFYt8Rpvo
         lOPg==
X-Gm-Message-State: AFqh2kqAxGBaQpVRWOGeEwidg0hrw7aEi4RiYshkerm12gut0Tei3qWp
        lIdIYtfW1miaOnQob9Q+4nuJRiaTa9Y=
X-Google-Smtp-Source: AMrXdXulU6HQ5AbjrG194lmk0/WASSPSZALAdNIlkF8e/aZPlXkPMtxRnnbn210+u+td80qyWroVAg==
X-Received: by 2002:a17:906:374e:b0:7c1:f64:61f1 with SMTP id e14-20020a170906374e00b007c10f6461f1mr17775820ejc.45.1672003600942;
        Sun, 25 Dec 2022 13:26:40 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c23-c49f-b200-0000-0000-0000-0e63.c23.pool.telefonica.de. [2a01:c23:c49f:b200::e63])
        by smtp.googlemail.com with ESMTPSA id ku22-20020a170907789600b007c10d47e748sm4062567ejc.36.2022.12.25.13.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Dec 2022 13:26:40 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        jbrunet@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v1 1/4] clk: meson: mpll: Switch from .round_rate to .determine_rate
Date:   Sun, 25 Dec 2022 22:26:29 +0100
Message-Id: <20221225212632.2760126-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221225212632.2760126-1-martin.blumenstingl@googlemail.com>
References: <20221225212632.2760126-1-martin.blumenstingl@googlemail.com>
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

clk_ops.round_rate will be removed at some point. It's replacement is
.determine_rate. Switch clk-mpll over to use .determine_rate.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/clk-mpll.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/meson/clk-mpll.c b/drivers/clk/meson/clk-mpll.c
index fc9df4860872..20255e129b37 100644
--- a/drivers/clk/meson/clk-mpll.c
+++ b/drivers/clk/meson/clk-mpll.c
@@ -87,16 +87,22 @@ static unsigned long mpll_recalc_rate(struct clk_hw *hw,
 	return rate < 0 ? 0 : rate;
 }
 
-static long mpll_round_rate(struct clk_hw *hw,
-			    unsigned long rate,
-			    unsigned long *parent_rate)
+static int mpll_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
 {
 	struct clk_regmap *clk = to_clk_regmap(hw);
 	struct meson_clk_mpll_data *mpll = meson_clk_mpll_data(clk);
 	unsigned int sdm, n2;
+	long rate;
+
+	params_from_rate(req->rate, req->best_parent_rate, &sdm, &n2,
+			 mpll->flags);
 
-	params_from_rate(rate, *parent_rate, &sdm, &n2, mpll->flags);
-	return rate_from_params(*parent_rate, sdm, n2);
+	rate = rate_from_params(req->best_parent_rate, sdm, n2);
+	if (rate < 0)
+		return rate;
+
+	req->rate = rate;
+	return 0;
 }
 
 static int mpll_set_rate(struct clk_hw *hw,
@@ -157,13 +163,13 @@ static int mpll_init(struct clk_hw *hw)
 
 const struct clk_ops meson_clk_mpll_ro_ops = {
 	.recalc_rate	= mpll_recalc_rate,
-	.round_rate	= mpll_round_rate,
+	.determine_rate	= mpll_determine_rate,
 };
 EXPORT_SYMBOL_GPL(meson_clk_mpll_ro_ops);
 
 const struct clk_ops meson_clk_mpll_ops = {
 	.recalc_rate	= mpll_recalc_rate,
-	.round_rate	= mpll_round_rate,
+	.determine_rate	= mpll_determine_rate,
 	.set_rate	= mpll_set_rate,
 	.init		= mpll_init,
 };
-- 
2.39.0


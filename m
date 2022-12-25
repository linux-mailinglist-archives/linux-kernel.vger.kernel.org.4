Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286E3655E5B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 22:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbiLYV06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 16:26:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbiLYV0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 16:26:45 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0669810FE;
        Sun, 25 Dec 2022 13:26:44 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id u19so22998877ejm.8;
        Sun, 25 Dec 2022 13:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5KI4GVi+gdxgp2ZGUw6TN4YhL63JS7cfevWElXB6z0s=;
        b=k1dJC42zQSl4nfLJ3K+ztzbqAJDFEdIdZPy7L1D89hkbY9HXKlLJuFXxqcw+FK/TVV
         ORaWIG/HNaJQAbqAPyI+2xwzcx1ahZY8BJEoDP1sNYxx03NhCDNBQjPBeYlUjFko1CD/
         1UIgfoKNhvBPrVy0u3EwiUhk86D0GXglDirGyqsPUsgX3Hbv+3r3k35idjNm+A6EXBKo
         fSRIGXrsl5YQVLyIkXWZERnfTGb9NHOb316NquZAOWKF7AEOBy9GJ1o7Mf/aaU/F9nad
         WUKlGJE3AeozEso1BQe9/tOHkRtMwjM+VjGdnVcAPbrJhBv9SQHd8qBjduSmTpkxxCLt
         OFNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5KI4GVi+gdxgp2ZGUw6TN4YhL63JS7cfevWElXB6z0s=;
        b=Ur/FFQPQwIEyVkrBMwAPRZ+VDEcashd+CPWu6HFNQyM3rmwW8fCIF1F7PiJlo9baaI
         yqhslFwHi+9fL3nnXdVLBS8CPOV+Wcyz7tJBjEUmt0ESUplUu1bgcyhMqG6SP445FF4+
         hd9Q4/3VbYqDv1jm5fzXhS9SBf7CrDINPxbn2Zm00cyyAoFGbbgHU3zNCTmPW8C6H8Iz
         W6CiQcHhwWcH+mTg8dDAvbdlK2iADEOiimxZN5uCiETJSoyyrUuoyMCWjZvZPJScGulR
         Ldf6GhIf2BxMpa/0W4BxmSV1OoLQ4hqJ9S2fF9BB/EAWY9/oHqRwkf4hoLosMpsxLyv5
         mthQ==
X-Gm-Message-State: AFqh2ko+OzmV/iH+BP9Znszv887sQBD+bH4WX6MD0qox0aTczwRc/D7X
        GtGvDbv2r/6NWIChCKYzAML86e1Vszg=
X-Google-Smtp-Source: AMrXdXs+KZaDdvm9udYW4BX/Q7fJqqvrvx1jef2GpmyfmYMmtA8FXASDVeM8/iE11rZbyMM520xcFA==
X-Received: by 2002:a17:906:2813:b0:829:59d5:e661 with SMTP id r19-20020a170906281300b0082959d5e661mr13997700ejc.29.1672003602528;
        Sun, 25 Dec 2022 13:26:42 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c23-c49f-b200-0000-0000-0000-0e63.c23.pool.telefonica.de. [2a01:c23:c49f:b200::e63])
        by smtp.googlemail.com with ESMTPSA id ku22-20020a170907789600b007c10d47e748sm4062567ejc.36.2022.12.25.13.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Dec 2022 13:26:42 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        jbrunet@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v1 3/4] clk: meson: sclk-div: switch from .round_rate to .determine_rate
Date:   Sun, 25 Dec 2022 22:26:31 +0100
Message-Id: <20221225212632.2760126-4-martin.blumenstingl@googlemail.com>
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
.determine_rate. Switch sclk-div over to use .determine_rate.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/sclk-div.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/meson/sclk-div.c b/drivers/clk/meson/sclk-div.c
index 76d31c0a3342..d12c45c4c261 100644
--- a/drivers/clk/meson/sclk-div.c
+++ b/drivers/clk/meson/sclk-div.c
@@ -96,16 +96,17 @@ static int sclk_div_bestdiv(struct clk_hw *hw, unsigned long rate,
 	return bestdiv;
 }
 
-static long sclk_div_round_rate(struct clk_hw *hw, unsigned long rate,
-				unsigned long *prate)
+static int sclk_div_determine_rate(struct clk_hw *hw,
+				   struct clk_rate_request *req)
 {
 	struct clk_regmap *clk = to_clk_regmap(hw);
 	struct meson_sclk_div_data *sclk = meson_sclk_div_data(clk);
 	int div;
 
-	div = sclk_div_bestdiv(hw, rate, prate, sclk);
+	div = sclk_div_bestdiv(hw, req->rate, &req->best_parent_rate, sclk);
+	req->rate = DIV_ROUND_UP_ULL((u64)req->best_parent_rate, div);
 
-	return DIV_ROUND_UP_ULL((u64)*prate, div);
+	return 0;
 }
 
 static void sclk_apply_ratio(struct clk_regmap *clk,
@@ -237,7 +238,7 @@ static int sclk_div_init(struct clk_hw *hw)
 
 const struct clk_ops meson_sclk_div_ops = {
 	.recalc_rate	= sclk_div_recalc_rate,
-	.round_rate	= sclk_div_round_rate,
+	.determine_rate	= sclk_div_determine_rate,
 	.set_rate	= sclk_div_set_rate,
 	.enable		= sclk_div_enable,
 	.disable	= sclk_div_disable,
-- 
2.39.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E89655E5A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 22:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbiLYV0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 16:26:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbiLYV0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 16:26:44 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BF010F7;
        Sun, 25 Dec 2022 13:26:43 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id qk9so23046653ejc.3;
        Sun, 25 Dec 2022 13:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u624ykL0rVa4TXbrwRaAQyInF1fSqtT2CkhukAfQEcQ=;
        b=f/MsTWFfmvfxD5qcKbMT7oSwdnOKOaRdPUMvgkI2Jq8dI4tvIFNTeHhXg9Bwd/ruae
         tzb+0N1eg5KRzMTTLUa+3EGQAe4FBSiyKw0PN09VvPKBp5z2cEQdgN1n/RZ67Pi3DxgX
         zqVP99Ebigki9FcU1vJEllBPWjXQoe1LCQ1giR/X5qmveAWPNFNdMtGyd80NfY9mcmXl
         3YLoCn9h46stJVIgEukqaVwNM1AdsRrfOIHJHEbf2Z0R5rvnaR45bf7qxlW9rFZBoARu
         FTTr6DSfpszUmwVcM86NR9YW2Pvu10+gfzhcstH/oSgc2s1aIe4uq2SAQ4UwHla9mnzq
         DcoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u624ykL0rVa4TXbrwRaAQyInF1fSqtT2CkhukAfQEcQ=;
        b=oyp7jjSD6SHvw7qvkLa9Wp8eTlvS2SRhhPODwquePJw5ZwYiy5HaMsUrjOTJ8HBLgO
         XgWZoqrxrP5S7jX1+qr//isNYKms0AOmI008J/XGtRAmeuiEOn9OQoYvrEBG1idKRZP5
         qtVoQRi6/84gOgWwX+EUl0IRKfmO9clKj11255g+TZJrKmuY/Bqf6xQlVtz6/UlECsvG
         a+UEol4zzRDoVONvj9+s7faPd42/1z7E+oY2WGWXIu+IAnB729y6MHWq4qa5p9VAbaDa
         r501EgBeLzwOeYlRKiEtU7rH+m3QPhci5YiqomcB/MzIs1Sad3YvX4iGqJ+Ndc228eqL
         hWXw==
X-Gm-Message-State: AFqh2kq81TbVQ5pJwP+OZZmq+pRUranK+ECw+24mcSp4k1bv3ypWmITk
        LlBBeo/zEn3VTEcJxKllXZtpqyZ9nrk=
X-Google-Smtp-Source: AMrXdXuCzu/HDHjuswM3QCZzhciUAtgvKrG9dMjbyMfkd/nCUrMHqfXuaTRTRxok7K/obbmNdWAs8g==
X-Received: by 2002:a17:907:d604:b0:7ad:d62d:9d31 with SMTP id wd4-20020a170907d60400b007add62d9d31mr13566696ejc.67.1672003601830;
        Sun, 25 Dec 2022 13:26:41 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c23-c49f-b200-0000-0000-0000-0e63.c23.pool.telefonica.de. [2a01:c23:c49f:b200::e63])
        by smtp.googlemail.com with ESMTPSA id ku22-20020a170907789600b007c10d47e748sm4062567ejc.36.2022.12.25.13.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Dec 2022 13:26:41 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        jbrunet@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v1 2/4] clk: meson: dualdiv: switch from .round_rate to .determine_rate
Date:   Sun, 25 Dec 2022 22:26:30 +0100
Message-Id: <20221225212632.2760126-3-martin.blumenstingl@googlemail.com>
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
.determine_rate. Switch clk-dualdiv over to use .determine_rate.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/clk-dualdiv.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/meson/clk-dualdiv.c b/drivers/clk/meson/clk-dualdiv.c
index c5ca23a5e3e8..feae49a8f6dc 100644
--- a/drivers/clk/meson/clk-dualdiv.c
+++ b/drivers/clk/meson/clk-dualdiv.c
@@ -86,18 +86,23 @@ __dualdiv_get_setting(unsigned long rate, unsigned long parent_rate,
 	return (struct meson_clk_dualdiv_param *)&table[best_i];
 }
 
-static long meson_clk_dualdiv_round_rate(struct clk_hw *hw, unsigned long rate,
-					 unsigned long *parent_rate)
+static int meson_clk_dualdiv_determine_rate(struct clk_hw *hw,
+					    struct clk_rate_request *req)
 {
 	struct clk_regmap *clk = to_clk_regmap(hw);
 	struct meson_clk_dualdiv_data *dualdiv = meson_clk_dualdiv_data(clk);
-	const struct meson_clk_dualdiv_param *setting =
-		__dualdiv_get_setting(rate, *parent_rate, dualdiv);
+	const struct meson_clk_dualdiv_param *setting;
 
-	if (!setting)
-		return meson_clk_dualdiv_recalc_rate(hw, *parent_rate);
+	setting = __dualdiv_get_setting(req->rate, req->best_parent_rate,
+					dualdiv);
+	if (setting)
+		req->rate = __dualdiv_param_to_rate(req->best_parent_rate,
+						    setting);
+	else
+		req->rate = meson_clk_dualdiv_recalc_rate(hw,
+							  req->best_parent_rate);
 
-	return __dualdiv_param_to_rate(*parent_rate, setting);
+	return 0;
 }
 
 static int meson_clk_dualdiv_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -122,7 +127,7 @@ static int meson_clk_dualdiv_set_rate(struct clk_hw *hw, unsigned long rate,
 
 const struct clk_ops meson_clk_dualdiv_ops = {
 	.recalc_rate	= meson_clk_dualdiv_recalc_rate,
-	.round_rate	= meson_clk_dualdiv_round_rate,
+	.determine_rate	= meson_clk_dualdiv_determine_rate,
 	.set_rate	= meson_clk_dualdiv_set_rate,
 };
 EXPORT_SYMBOL_GPL(meson_clk_dualdiv_ops);
-- 
2.39.0


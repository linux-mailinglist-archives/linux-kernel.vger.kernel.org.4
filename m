Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3A8655E5C
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 22:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbiLYV1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 16:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbiLYV0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 16:26:45 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA29321BC;
        Sun, 25 Dec 2022 13:26:44 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id qk9so23046700ejc.3;
        Sun, 25 Dec 2022 13:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mS2mnfCDe8WfSbHmKHSJQj2MrPkmcqdFMVHuqcZiyk8=;
        b=E4mBLrjCAk8pk5rL+QRgcUmvps2R29MC3VaGBiwIw9+toDwRp5M4jlsenqTdLtq9Or
         7hQI/3vT/bnEiAqmUzimN8PfM2Xb7nHplHXfwuhpbSrOpwjtqY33hWzux2IDJ3FiORwJ
         zll0s73BQqoZAD2+sFAcXAHAofcAoz9Li/s8au7yaqdm7SLot94eHeKyRwIZ8GyZ4vvy
         CU/KIf2EOu59AIPSIhSZQeZrSq+vffPZqgysvkQM9jHcOAef3mnIVbDWxNDzBWVTmPTv
         PyrVswKYtDf3qfSOgYjnJtKDFefnRFuIKZDkCsfNmY8/oC2h1jiuZiQkz3o3SBrEjHwi
         xsIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mS2mnfCDe8WfSbHmKHSJQj2MrPkmcqdFMVHuqcZiyk8=;
        b=M1FN/UOABMt7RSDCzJq3WAAL95sUqSwoHy5vYgEDHkCUU4vH25uSensjx50BV3Uvif
         snAH8vp7xjdmpzNhRWzPzOG/vWMFrpFUiDa+rfdOU+RcMNJBv6USkhup28UjDEDc2+CA
         m85IPTXfPU+HVOJMfRwvid2MvEP3otnEMnRmAK9qcSjg2fr4URFZRXOspib2g99iObrS
         RYm6TzqmDekctfltJn3uYmEpsN8KjV13ByR7C05SV2g+eqI4Wm+/11pE9GBoWjKgcGuZ
         KiEXVLpLmMXcRBiox8d4E8Q305YZsDxCh+Gbyy8wHanF7wpRhxaOd0Ekm/nkdo+RCDT3
         ACaQ==
X-Gm-Message-State: AFqh2kqbCcjstlLBpyilZkNA9P8DXwVSHYIuMWp8Y7OxuNZAQ8mtMaKv
        zeuyzjJo+t54FIHU5SeLfLE=
X-Google-Smtp-Source: AMrXdXsRrd9q9OWeC8AnStIWOxpDaW977IsrARLPCsgjW7H43dn1dDU5swzaVavSTGLR0IJVptIGag==
X-Received: by 2002:a17:906:264c:b0:7c0:cc81:3d94 with SMTP id i12-20020a170906264c00b007c0cc813d94mr14307502ejc.13.1672003603392;
        Sun, 25 Dec 2022 13:26:43 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c23-c49f-b200-0000-0000-0000-0e63.c23.pool.telefonica.de. [2a01:c23:c49f:b200::e63])
        by smtp.googlemail.com with ESMTPSA id ku22-20020a170907789600b007c10d47e748sm4062567ejc.36.2022.12.25.13.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Dec 2022 13:26:42 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        jbrunet@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v1 4/4] clk: meson: clk-cpu-dyndiv: switch from .round_rate to .determine_rate
Date:   Sun, 25 Dec 2022 22:26:32 +0100
Message-Id: <20221225212632.2760126-5-martin.blumenstingl@googlemail.com>
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
.determine_rate. Switch clk-cpu-dyndiv over to use .determine_rate.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/clk-cpu-dyndiv.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/meson/clk-cpu-dyndiv.c b/drivers/clk/meson/clk-cpu-dyndiv.c
index 36976927fe82..8778c149d26a 100644
--- a/drivers/clk/meson/clk-cpu-dyndiv.c
+++ b/drivers/clk/meson/clk-cpu-dyndiv.c
@@ -27,14 +27,13 @@ static unsigned long meson_clk_cpu_dyndiv_recalc_rate(struct clk_hw *hw,
 				   NULL, 0, data->div.width);
 }
 
-static long meson_clk_cpu_dyndiv_round_rate(struct clk_hw *hw,
-					    unsigned long rate,
-					    unsigned long *prate)
+static int meson_clk_cpu_dyndiv_determine_rate(struct clk_hw *hw,
+					       struct clk_rate_request *req)
 {
 	struct clk_regmap *clk = to_clk_regmap(hw);
 	struct meson_clk_cpu_dyndiv_data *data = meson_clk_cpu_dyndiv_data(clk);
 
-	return divider_round_rate(hw, rate, prate, NULL, data->div.width, 0);
+	return divider_determine_rate(hw, req, NULL, data->div.width, 0);
 }
 
 static int meson_clk_cpu_dyndiv_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -63,7 +62,7 @@ static int meson_clk_cpu_dyndiv_set_rate(struct clk_hw *hw, unsigned long rate,
 
 const struct clk_ops meson_clk_cpu_dyndiv_ops = {
 	.recalc_rate = meson_clk_cpu_dyndiv_recalc_rate,
-	.round_rate = meson_clk_cpu_dyndiv_round_rate,
+	.determine_rate = meson_clk_cpu_dyndiv_determine_rate,
 	.set_rate = meson_clk_cpu_dyndiv_set_rate,
 };
 EXPORT_SYMBOL_GPL(meson_clk_cpu_dyndiv_ops);
-- 
2.39.0


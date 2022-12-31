Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3930365A38C
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 11:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbiLaKsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 05:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiLaKrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 05:47:53 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B8F645F
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 02:47:52 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id fc4so56329939ejc.12
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 02:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MlxmeaIHk8OrzWPfE3cm09UY7yzoRBn0Uu2mQgPXmdk=;
        b=S+QfZYeGZv2u4Pj/RfMQHserifc6sZuTu+rOAN4eYOI89qwvHyEgnRIrVh8oBeeSgA
         y6kkfDGh4WOtOTFA4pXjUoEcJFaOLt48FlzmHzdxoHzDAbdtt+mGZ/NHSEtfJZWqC05o
         +Zr/ZptCwfmVuNOMQ4buPQs8qDjUQyV4k+GGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MlxmeaIHk8OrzWPfE3cm09UY7yzoRBn0Uu2mQgPXmdk=;
        b=srWfD9BW5b89KdL1n8rlbDUlmScrdGAQsCGRrD45w0zcq5P1vDnS62ySjuOc4pXUI9
         k0oi9TP3G/l0WSnPw+OA1tb3p3hGRyJuScpCAQ7Fwgiqs7XrJt3m2vndLiS5542dPT8T
         HZSp3ZTan0FuM4GI3p6yckWh9VIlF1BWvH30Mg7nyTmN6cEblDkh2Bs4Nm77WOsJzrhE
         HzupZyBCK2kk5xGsPXLU2mvzoeZUpKAOpXBDls/XoZFwTVMo6LlcfEK61Xnmrbc1eM7L
         DYbh+EouhGqFc/OiGOQDvOuJtsKIpUwSSSsLqu98aZ4Oi053g/oomQNoabYZAzBhHzmS
         /FXA==
X-Gm-Message-State: AFqh2koIvYP1h9VfZeUr4ENnBUnBgx6vJeQZXp9O+1tpqf5oe2RwegvQ
        BhsxdGtoVG6EcbNLMl36ehuHLND2LMAX3ApXZJ8=
X-Google-Smtp-Source: AMrXdXssd4th2tQ+K3pikob5HvmOdLstBIM/Xz4rVcfK8ulWOXsUv0KvoKsIAwFQcCOjQNqi6CJzBw==
X-Received: by 2002:a17:907:c296:b0:820:4046:1586 with SMTP id tk22-20020a170907c29600b0082040461586mr27687273ejc.12.1672483671115;
        Sat, 31 Dec 2022 02:47:51 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-80-180-23-57.retail.telecomitalia.it. [80.180.23.57])
        by smtp.gmail.com with ESMTPSA id z4-20020a17090655c400b0083ffb81f01esm10765438ejp.136.2022.12.31.02.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 02:47:50 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     tommaso.merciai@amarulasolutions.com,
        linux-amarula@amarulasolutions.com,
        Chen-Yu Tsai <wenst@chromium.org>, jagan@amarulasolutions.com,
        angelo@amarulasolutions.com, anthony@amarulasolutions.com,
        michael@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: [RFC PATCH 01/11] clk: imx: add structure to extend register accesses
Date:   Sat, 31 Dec 2022 11:47:26 +0100
Message-Id: <20221231104736.12635-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20221231104736.12635-1-dario.binacchi@amarulasolutions.com>
References: <20221231104736.12635-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The imx_clk_reg structure allows accessing both registers that belong to
specific modules and those that are registered in syscon through the use
of the regmap API.
This is a preparation patch for the upcoming support to setup clocks
directly from the device tree.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/clk/imx/clk.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 689b3ad927c0..86538c990a0d 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -89,6 +89,18 @@ struct imx_fracn_gppll_clk {
 	int flags;
 };
 
+/**
+ * struct imx_clk_reg - imx register declaration
+ * @base: the register base address
+ * @regmap: the register map
+ * @offset: the offset within @base or @regmap
+ */
+struct imx_clk_reg {
+	void __iomem *base;
+	struct regmap *regmap;
+	u16 offset;
+};
+
 struct clk_hw *imx_clk_fracn_gppll(const char *name, const char *parent_name, void __iomem *base,
 				   const struct imx_fracn_gppll_clk *pll_clk);
 
-- 
2.32.0


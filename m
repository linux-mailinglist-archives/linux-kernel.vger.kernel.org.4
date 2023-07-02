Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A378744F80
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 19:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjGBR4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 13:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjGBRz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 13:55:59 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050:0:465::101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1878DE67;
        Sun,  2 Jul 2023 10:55:57 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4QvGtz5c4Qz9sZZ;
        Sun,  2 Jul 2023 19:55:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1688320555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IZMNOAHPDl9b4RN7sUq38ZIUetqHmkZGYvLFzUrfFmY=;
        b=ZP3C25mm/2Mr1zTr4yzpNcFJDvHsxZPCxmErBcBbREuaK+PhUOEcJ0k6gxarSx+cc8iG6g
        qRxxK8qFy2mIHUkvhUVm3a4N7d4NJEho08eWIVK2srGxF9XKADVUhu9LrMBAxNBbBhvVoW
        qwYjPsLX43vZMc2HLnybyy/WZ+nBIjDmqot+Oz3vLDSFEiEQS7m7r4a3GtP86o7ArUb7YT
        +jS4thVX/N9A02xbhYw6gvwlht2Ah3KPL+6sipVfChTHok/BvXB8iQLrtfIHWerNKdY6aX
        DAo7jPBJhUdaH+5bAwomVTgzglUIg1haCabBfJE7qGy5K7vLtqfuCJ2NCs9AaA==
From:   Frank Oltmanns <frank@oltmanns.dev>
Date:   Sun, 02 Jul 2023 19:55:25 +0200
Subject: [PATCH v3 6/8] clk: sunxi-ng: mux: Support finding closest rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230702-pll-mipi_set_rate_parent-v3-6-46dcb8aa9cbc@oltmanns.dev>
References: <20230702-pll-mipi_set_rate_parent-v3-0-46dcb8aa9cbc@oltmanns.dev>
In-Reply-To: <20230702-pll-mipi_set_rate_parent-v3-0-46dcb8aa9cbc@oltmanns.dev>
To:     Maxime Ripard <maxime@cerno.tech>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Roman Beranek <me@crly.cz>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Frank Oltmanns <frank@oltmanns.dev>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2527; i=frank@oltmanns.dev;
 h=from:subject:message-id; bh=HsHfxFRs7DqOrFQiRdG6ZrjV1WoqnP7I3+QzdUYxcq4=;
 b=owEB7QES/pANAwAIAZppogiUStPHAcsmYgBkobocaAucRSds8Zel2B2AZiCmG1Rk5mjq8PIH7
 ek5IE04aoWJAbMEAAEIAB0WIQQC/SV7f5DmuaVET5aaaaIIlErTxwUCZKG6HAAKCRCaaaIIlErT
 x4U6C/0XkZefhQVUaII1v3aP3hDxww/N4F+dog+qiEvBVe/dTsFsOc9yPS85sDiiWVJHJ+Yvppy
 ZwCrAv5ZYb1QX0oyb/CZ0qAb5EtDU2Uix0urFYZPj2XWGZgXxZtYu6zO2p9fDmF00u9daMtcfI1
 oH8/qofO//Uzu0dGAbom6cIcJDAnkN884yKtknWrNlH0GQXzCgUiKVlNWre3AZkhaHVgIWmYSxF
 dDwOe5jOO0dyIA4oXRAIIyl25ZOctIPyln4yX8EtEXuXkwQh07x6d5T8J3eCUSwCEoN3xEVzvIs
 iH86hDfMS+2A06TZa2x08l+N8zaqS+M3IQDheh7pdPueA07sobAPhP13dMbfNrEVYSqLzohmI4c
 fPgbTUanW2ky8qUnuGpkYmnRFnV1IiCOkwy7rhbXZ2KXpwbFnozFWKBp3qf/jr9UnuRpQk8580F
 p6x+H8VwStv2Juvpv7crMUF44JdDWKgUOK42lwZg9BcY+1Cns6/llnbaEwblDaSqObhvU=
X-Developer-Key: i=frank@oltmanns.dev; a=openpgp;
 fpr=02FD257B7F90E6B9A5444F969A69A208944AD3C7
X-Rspamd-Queue-Id: 4QvGtz5c4Qz9sZZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When finding the best rate for a mux clock, consider rates that are
higher than the requested rate by introducing a new clk_ops structure
that uses the existing __clk_mux_determine_rate_closest function.
Furthermore introduce an initialization macro that uses this new
structure.

Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
---
 drivers/clk/sunxi-ng/ccu_mux.c | 13 +++++++++++++
 drivers/clk/sunxi-ng/ccu_mux.h | 17 +++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu_mux.c b/drivers/clk/sunxi-ng/ccu_mux.c
index 8594d6a4addd..49a592bdeacf 100644
--- a/drivers/clk/sunxi-ng/ccu_mux.c
+++ b/drivers/clk/sunxi-ng/ccu_mux.c
@@ -264,6 +264,19 @@ static unsigned long ccu_mux_recalc_rate(struct clk_hw *hw,
 					   parent_rate);
 }
 
+const struct clk_ops ccu_mux_closest_ops = {
+	.disable	= ccu_mux_disable,
+	.enable		= ccu_mux_enable,
+	.is_enabled	= ccu_mux_is_enabled,
+
+	.get_parent	= ccu_mux_get_parent,
+	.set_parent	= ccu_mux_set_parent,
+
+	.determine_rate	= __clk_mux_determine_rate_closest,
+	.recalc_rate	= ccu_mux_recalc_rate,
+};
+EXPORT_SYMBOL_NS_GPL(ccu_mux_closest_ops, SUNXI_CCU);
+
 const struct clk_ops ccu_mux_ops = {
 	.disable	= ccu_mux_disable,
 	.enable		= ccu_mux_enable,
diff --git a/drivers/clk/sunxi-ng/ccu_mux.h b/drivers/clk/sunxi-ng/ccu_mux.h
index 2c1811a445b0..c4ee14e43719 100644
--- a/drivers/clk/sunxi-ng/ccu_mux.h
+++ b/drivers/clk/sunxi-ng/ccu_mux.h
@@ -46,6 +46,22 @@ struct ccu_mux {
 	struct ccu_common	common;
 };
 
+#define SUNXI_CCU_MUX_TABLE_WITH_GATE_CLOSEST(_struct, _name, _parents, _table,	\
+				     _reg, _shift, _width, _gate,	\
+				     _flags)				\
+	struct ccu_mux _struct = {					\
+		.enable	= _gate,					\
+		.mux	= _SUNXI_CCU_MUX_TABLE(_shift, _width, _table),	\
+		.common	= {						\
+			.reg		= _reg,				\
+			.hw.init	= CLK_HW_INIT_PARENTS(_name,	\
+							      _parents, \
+							      &ccu_mux_closest_ops, \
+							      _flags),	\
+			.features	= CCU_FEATURE_CLOSEST_RATE,	\
+		}							\
+	}
+
 #define SUNXI_CCU_MUX_TABLE_WITH_GATE(_struct, _name, _parents, _table,	\
 				     _reg, _shift, _width, _gate,	\
 				     _flags)				\
@@ -113,6 +129,7 @@ static inline struct ccu_mux *hw_to_ccu_mux(struct clk_hw *hw)
 }
 
 extern const struct clk_ops ccu_mux_ops;
+extern const struct clk_ops ccu_mux_closest_ops;
 
 unsigned long ccu_mux_helper_apply_prediv(struct ccu_common *common,
 					  struct ccu_mux_internal *cm,

-- 
2.41.0


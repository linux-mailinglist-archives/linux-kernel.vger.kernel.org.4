Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60998744F81
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 19:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjGBR4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 13:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjGBRz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 13:55:59 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43DDE5F;
        Sun,  2 Jul 2023 10:55:58 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4QvGv12x10z9skJ;
        Sun,  2 Jul 2023 19:55:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1688320557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6fwdl+myIVhz4fju8/+Tg66+u2ifTeRnG8yD5hL50NQ=;
        b=tYNVri5o8GB1Ho/3fLOcVBK6rk4dIp2HluB9fOWZOnXV9Lx7MvaIPJeN73hY8NtpFb9g3F
        g09cJKXbcfsWLrO3WpqtTK883foyW9M9okqITkVus+8USg640nldFx5wZf00AaAHS2jhjb
        kSq2eH0p/GXwVlTNnsWdLdodW/1EY1YPptV9ESaXeoN7+N7+va5DQ/Kou3SuGYe/LUAGVr
        Y/cvJ2uvC1mxEVy/41xaICrmfz1Vj7vUPLMD5FSkPhIeFevRt9yfpLR2IqJ8gLho3i94sx
        XjWct/gbPhrTRs/L1ttV2cQ0TunG39RUXyrLldHXz4p8UozxrrGXd1d+s8Husg==
From:   Frank Oltmanns <frank@oltmanns.dev>
Date:   Sun, 02 Jul 2023 19:55:26 +0200
Subject: [PATCH v3 7/8] clk: sunxi-ng: div: Support finding closest rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230702-pll-mipi_set_rate_parent-v3-7-46dcb8aa9cbc@oltmanns.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2074; i=frank@oltmanns.dev;
 h=from:subject:message-id; bh=QteUt2cYVvavIEwNN/k9PvZ0L1ThFgIn+WnM3eoykB0=;
 b=owEB7QES/pANAwAIAZppogiUStPHAcsmYgBkobocOMfDMsDUymIH/PyoN0nvjIa6tG2TyObYR
 gaiaSGEjFuJAbMEAAEIAB0WIQQC/SV7f5DmuaVET5aaaaIIlErTxwUCZKG6HAAKCRCaaaIIlErT
 x96rC/9HxzJ9h5ODsSFizRvb4fETeTYNyXNwWX3Y6PuMx4fsp9pFEzSLDwTRnRr6mKeVfBvIr1j
 vTK+FkuVNn5x9Sy9WiUY92932dcAiDbli0+tXeP7fvd6zQSVDcVVoAbsC4F5dJAoAks85zT3i5M
 5abscfvPwDHgNAa1Q8GsgX6YupX145We9rnj0guyw572xf88z5tIVZJ5qYMOcjArB8hKNRKCtm8
 9jJv0Y+GvcC6WJdKwX3oLIILPdAfthP/Hj0z07kcTuLdzuh7cGN+Z61VnDlwIC5myXfcKQduOTI
 0FX3PxlP42tOc/J8GfWjHGjImK27iObWLvRCiv06d+a61mq4ZnBuP5Alxzzt3svRdDuP91YxEkn
 vh2Yo7uRPVn3Wc+kXrXHSke6oOWjvpmX92g44Ov7OYOYNT7srg2QXVoFc90GncYAwzyytLlUOiN
 6Q4BoFUApwyi5WcYJ3Z17TjG4rdD6OXTFuD4aXZC4F51mnmIJpQzwEkAlFsp+HPNH5qt0=
X-Developer-Key: i=frank@oltmanns.dev; a=openpgp;
 fpr=02FD257B7F90E6B9A5444F969A69A208944AD3C7
X-Rspamd-Queue-Id: 4QvGv12x10z9skJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initalization macros for divisor clocks with mux
(SUNXI_CCU_M_WITH_MUX) to support finding the closest rate. This clock
type requires the appropriate flags to be set in the .common structure
(for the mux part of the clock) and the .div part.

Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
---
 drivers/clk/sunxi-ng/ccu_div.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu_div.h b/drivers/clk/sunxi-ng/ccu_div.h
index 948e2b0c0c3b..90d49ee8e0cc 100644
--- a/drivers/clk/sunxi-ng/ccu_div.h
+++ b/drivers/clk/sunxi-ng/ccu_div.h
@@ -143,6 +143,26 @@ struct ccu_div {
 		},							\
 	}
 
+#define SUNXI_CCU_M_WITH_MUX_TABLE_GATE_CLOSEST(_struct, _name,		\
+						_parents, _table,	\
+						_reg,			\
+						_mshift, _mwidth,	\
+						_muxshift, _muxwidth,	\
+						_gate, _flags)		\
+	struct ccu_div _struct = {					\
+		.enable	= _gate,					\
+		.div	= _SUNXI_CCU_DIV_FLAGS(_mshift, _mwidth, CLK_DIVIDER_ROUND_CLOSEST), \
+		.mux	= _SUNXI_CCU_MUX_TABLE(_muxshift, _muxwidth, _table), \
+		.common	= {						\
+			.reg		= _reg,				\
+			.hw.init	= CLK_HW_INIT_PARENTS(_name,	\
+							      _parents, \
+							      &ccu_div_ops, \
+							      _flags),	\
+			.features	= CCU_FEATURE_CLOSEST_RATE,	\
+		},							\
+	}
+
 #define SUNXI_CCU_M_WITH_MUX_GATE(_struct, _name, _parents, _reg,	\
 				  _mshift, _mwidth, _muxshift, _muxwidth, \
 				  _gate, _flags)			\
@@ -152,6 +172,16 @@ struct ccu_div {
 					_muxshift, _muxwidth,		\
 					_gate, _flags)
 
+#define SUNXI_CCU_M_WITH_MUX_GATE_CLOSEST(_struct, _name, _parents,	\
+					  _reg, _mshift, _mwidth,	\
+					  _muxshift, _muxwidth,		\
+					  _gate, _flags)		\
+	SUNXI_CCU_M_WITH_MUX_TABLE_GATE_CLOSEST(_struct, _name,		\
+						_parents, NULL,		\
+						_reg, _mshift, _mwidth,	\
+						_muxshift, _muxwidth,	\
+						_gate, _flags)
+
 #define SUNXI_CCU_M_WITH_MUX(_struct, _name, _parents, _reg,		\
 			     _mshift, _mwidth, _muxshift, _muxwidth,	\
 			     _flags)					\

-- 
2.41.0


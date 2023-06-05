Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66866722F4F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234901AbjFETIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234818AbjFETIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:08:36 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2769210D;
        Mon,  5 Jun 2023 12:08:33 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4QZjnB011cz9sT1;
        Mon,  5 Jun 2023 21:08:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1685992110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MBJxXfSZlpnXqCUjbTwDSPXMgKyZwYKA6JDhh6cxKcs=;
        b=v+lJ13q9LUA3XetMGXqHTopXWMgAZRu1tBQj7NFqClleTCD7Rij6xCpZn7PYaPh3uewH4C
        g5ERw1pFi0m0pdMgKJAYbKqdC+m/vlffiRsvZ9QCPryneYcdJduwhiAnZCKv7u/pFLJn9I
        I4E3y0KWAF8ojWHPRi2AMG7vCouoGw0gamq34BDzqEHrOwOd0SME2xvMwWlwhCkFakX+Qa
        EA99uZqcztw7J6+zQxasHlOikvtrFlFH+o9FfVSwOKeaHZ/UgutFm+Arpb4y0WAfd3Ewcc
        UpSf9jPMMXmJc9wwgu4z0lcWim1IQe8nmjWxYU2RcT0I4JbT7L8XrQsOAxaqhg==
From:   Frank Oltmanns <frank@oltmanns.dev>
To:     Andre Przywara <andre.przywara@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Frank Oltmanns <frank@oltmanns.dev>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Michael Turquette <mturquette@baylibre.com>,
        Roman Beranek <me@crly.cz>,
        Samuel Holland <samuel@sholland.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: [PATCH 2/2] clk: sunxi-ng: a64: allow pll-mipi to set parent's rate
Date:   Mon,  5 Jun 2023 21:07:45 +0200
Message-Id: <20230605190745.366882-3-frank@oltmanns.dev>
In-Reply-To: <20230605190745.366882-1-frank@oltmanns.dev>
References: <20230605190745.366882-1-frank@oltmanns.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4QZjnB011cz9sT1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nkm clock now supports setting the parent's rate. Utilize this
option to find the optimal rate for pll-mipi.

Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
---
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
index eb36f8f77d55..125ae097d96c 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
@@ -179,7 +179,8 @@ static struct ccu_nkm pll_mipi_clk = {
 	.common		= {
 		.reg		= 0x040,
 		.hw.init	= CLK_HW_INIT("pll-mipi", "pll-video0",
-					      &ccu_nkm_ops, CLK_SET_RATE_UNGATE),
+					      &ccu_nkm_ops,
+					      CLK_SET_RATE_UNGATE | CLK_SET_RATE_PARENT),
 	},
 };
 
-- 
2.40.1


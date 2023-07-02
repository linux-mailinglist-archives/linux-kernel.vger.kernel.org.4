Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE75744F82
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 19:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjGBR4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 13:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjGBRz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 13:55:57 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E924EE5F;
        Sun,  2 Jul 2023 10:55:50 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4QvGts2SHHz9sbv;
        Sun,  2 Jul 2023 19:55:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1688320549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+F9Qzm6IdvX+YdAxJq37HDn1fqo5BDQOBMr0dvLlSyw=;
        b=kY6yKlEzhagJ9p+DAc9ZPZDEkC5M+2MaRy9XAhQy8JfO8vk17IuZvkHmDWDFIfpuTdfArn
        xA0XeUYlDCCHJY7uZbCABfEfE0lC8Uyn2OtWHZuftxqVlAEqZRrHFMPGKa40aMoPAiU5GK
        kpHYeVzuYgU8/VwZrnsCpFxEQkaM2qQwuHJtA+FKeFS/4yAAC9cqLgoVkJBPCOGD2zAVK6
        KLKBEDRcU/CZOmsUWsJnd2wb0jRIwcoOqw4H2UlR/06pGoTBpoZrNqeJm4duYzvnEQ3gz1
        VTLQctSrCeKsVpPxDADfs4ZVrj20qGgfNjwdx5Zqsa2MHF/SXXEHRTXEmMOaoQ==
From:   Frank Oltmanns <frank@oltmanns.dev>
Date:   Sun, 02 Jul 2023 19:55:21 +0200
Subject: [PATCH v3 2/8] clk: sunxi-ng: a64: allow pll-mipi to set parent's
 rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230702-pll-mipi_set_rate_parent-v3-2-46dcb8aa9cbc@oltmanns.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=806; i=frank@oltmanns.dev;
 h=from:subject:message-id; bh=6KqjBLS1Ov/nYPswsTAdcoLKG7a0XW4Ac8QXs1cSwVw=;
 b=owEB7QES/pANAwAIAZppogiUStPHAcsmYgBkobobka0bAipDKc0Ze1hPtisyY07V9gb2U08jO
 +hyzuXZYXiJAbMEAAEIAB0WIQQC/SV7f5DmuaVET5aaaaIIlErTxwUCZKG6GwAKCRCaaaIIlErT
 x12uC/9Ae6iMuCUPFpbZhqbKawdVnd6iFNqSqi/GCBjcMh2wXjRh0Du7zQZb7G5dt8d4AoCVdgM
 E1uD3Pf/FEtfKS1x1GMSN7UDx8gvDrI6b7cO/aMqvjInHWsuFHYVctDs+5Vxg+tMbODzLNF5mwv
 ZFy5Ytup/8Lw0cOtFcr4x3nief+pu6PmuRdl6lMHjXqqpV81nGrai/KxjY6OygCe/nSNG/jZ5wk
 GYpgO8+eIrtxDj1SnLIeHT/9C8loZ61RY9AfzKrX8bkc1FH0IfXKq+smvrEtGkVWOq/swT27tOA
 OwWLJqeyRwVgyeOSYafi4gFH1UplHB9k3cyuvN2sxqOFeqR1tj/b6yZcdoCPn69a5L6PElAwFyB
 QhLKejkhqq20rsae+CiDd7HmZCuQjMraBkv1knNdATdPbvAw0CpB1CKAszC1h0VS7f/+wSssRMH
 //RwPC3wEg1bGdQRfMM2/EG8+sAfGB+WwKpVc0Pq02k1lV/OQzPbBanP0TtlQUK6XPmyg=
X-Developer-Key: i=frank@oltmanns.dev; a=openpgp;
 fpr=02FD257B7F90E6B9A5444F969A69A208944AD3C7
X-Rspamd-Queue-Id: 4QvGts2SHHz9sbv
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
index 41519185600a..a139a5c438d4 100644
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
2.41.0


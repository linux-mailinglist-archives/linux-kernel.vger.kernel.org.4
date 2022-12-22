Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58DE65485A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 23:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235746AbiLVWXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 17:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiLVWXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 17:23:36 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953B613F7A;
        Thu, 22 Dec 2022 14:23:35 -0800 (PST)
Received: from hednb3.intra.ispras.ru (unknown [109.252.115.251])
        by mail.ispras.ru (Postfix) with ESMTPSA id BE990419E9CD;
        Thu, 22 Dec 2022 22:23:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru BE990419E9CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1671747812;
        bh=jk73c5NJJA/FvCk7056jbrerrHp19o8I8HwVkJyNo4c=;
        h=From:To:Cc:Subject:Date:From;
        b=MJJynVxzGehMCerhsCb3WTrMDabvMGhtsyAuU/YRQoizCP4vxkabfxZkchW2nS++z
         gdMlWE12JjaKL0Z55kJ4z+dQDFRXOo2uM7bQjyldTf+lX1iZUPuUwLpqbHLaDqZSZd
         fevtOuFjoKoDuBaA+RknfTMDf/Yo6aldh5Is4eSM=
From:   Alexey Khoroshilov <khoroshilov@ispras.ru>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Brandt <chris.brandt@renesas.com>
Cc:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: [PATCH] clk: renesas: cpg-mssr: Fix use after free if cpg_mssr_common_init() failed
Date:   Fri, 23 Dec 2022 01:23:18 +0300
Message-Id: <1671747798-12935-1-git-send-email-khoroshilov@ispras.ru>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If cpg_mssr_common_init() fails after assigning priv to global variable
cpg_mssr_priv, it deallocates priv, but cpg_mssr_priv keeps dangling
pointer that potentially can be used later.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 1f7db7bbf031 ("clk: renesas: cpg-mssr: Add early clock support")
Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/clk/renesas/renesas-cpg-mssr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas/renesas-cpg-mssr.c
index 1a0cdf001b2f..27da127ca4a8 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.c
+++ b/drivers/clk/renesas/renesas-cpg-mssr.c
@@ -1025,6 +1025,7 @@ static int __init cpg_mssr_common_init(struct device *dev,
 	if (priv->base)
 		iounmap(priv->base);
 	kfree(priv);
+	cpg_mssr_priv = NULL;
 
 	return error;
 }
-- 
2.7.4


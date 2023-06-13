Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4447272D6BF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 03:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238678AbjFMBMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 21:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238109AbjFMBMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 21:12:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A599101;
        Mon, 12 Jun 2023 18:12:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F404863079;
        Tue, 13 Jun 2023 01:12:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE91C433EF;
        Tue, 13 Jun 2023 01:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686618722;
        bh=s2B8jsyrAMp70vnL8t+VU1TAoQczCjHuMAecRCqHfbs=;
        h=From:To:Cc:Subject:Date:From;
        b=MDtbZq/YIgU4w5Mjy34aMseasppY5x6FJ2bJ3b/DNb3cmDYOXij8PSXRLNTtAlTPz
         oA06kJovpjEY4Ob3igRKSNBni3AWzrLC0k79X9basD0M9Uqc3bJK1kxUgbBMskamkC
         55sRnsgbYtCaOORxmCLwiP1+sbm3MNkSQYyyZKHWyqE4lL6Z2Zp0xPTlvkNw0sbKoS
         vP3WutOLeUdWFjxLFXYXuXHD4EMmlnO6uGfmapFQQirR/wS4No1G+FtTsFL7bnxdIO
         kcn4m0RWFdtuKa9L7yiNYU8/DxpxwKB7MqpUObwanJPxa9oEoSEInekRzPg3mYBwiK
         fSlhp9xn9aaKA==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        patches@lists.linux.dev, Maxime Ripard <maxime@cerno.tech>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] ASoC: tlv320aic32x4: pll: Remove impossible condition in clk_aic32x4_pll_determine_rate()
Date:   Mon, 12 Jun 2023 18:12:00 -0700
Message-ID: <20230613011201.1166753-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch warns:

sound/soc/codecs/tlv320aic32x4-clk.c:219 clk_aic32x4_pll_determine_rate() warn: unsigned 'rate' is never less than zero.

Cc: Maxime Ripard <maxime@cerno.tech>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202306101217.08CRVGcK-lkp@intel.com/
Fixes: 25d43ec352ea ("ASoC: tlv320aic32x4: pll: Switch to determine_rate")
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 sound/soc/codecs/tlv320aic32x4-clk.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4-clk.c b/sound/soc/codecs/tlv320aic32x4-clk.c
index a7ec501b4c69..c116e82f712d 100644
--- a/sound/soc/codecs/tlv320aic32x4-clk.c
+++ b/sound/soc/codecs/tlv320aic32x4-clk.c
@@ -208,18 +208,14 @@ static int clk_aic32x4_pll_determine_rate(struct clk_hw *hw,
 					  struct clk_rate_request *req)
 {
 	struct clk_aic32x4_pll_muldiv settings;
-	unsigned long rate;
 	int ret;
 
 	ret = clk_aic32x4_pll_calc_muldiv(&settings, req->rate, req->best_parent_rate);
 	if (ret < 0)
 		return -EINVAL;
 
-	rate = clk_aic32x4_pll_calc_rate(&settings, req->best_parent_rate);
-	if (rate < 0)
-		return rate;
+	req->rate = clk_aic32x4_pll_calc_rate(&settings, req->best_parent_rate);
 
-	req->rate = rate;
 	return 0;
 }
 
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git


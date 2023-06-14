Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C489A72F1D4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 03:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241455AbjFNB32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 21:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbjFNB3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 21:29:22 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E82CE57;
        Tue, 13 Jun 2023 18:29:21 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0Vl4DoHI_1686706156;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0Vl4DoHI_1686706156)
          by smtp.aliyun-inc.com;
          Wed, 14 Jun 2023 09:29:17 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     sboyd@kernel.org
Cc:     mturquette@baylibre.com, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next 2/3] clk: stm32: core: Fix unsigned comparison with less than zero
Date:   Wed, 14 Jun 2023 09:29:12 +0800
Message-Id: <20230614012913.122220-2-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20230614012913.122220-1-yang.lee@linux.alibaba.com>
References: <20230614012913.122220-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of the divider_ro_round_rate() is long.
However, the return value is being assigned to an unsigned
long variable 'rate', so making 'rate' to long.

silence the warnings:
./drivers/clk/stm32/clk-stm32-core.c:451:6-10: WARNING: Unsigned expression compared with zero: rate < 0
./drivers/clk/stm32/clk-stm32-core.c:461:5-9: WARNING: Unsigned expression compared with zero: rate < 0

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5519
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/clk/stm32/clk-stm32-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/stm32/clk-stm32-core.c b/drivers/clk/stm32/clk-stm32-core.c
index d5aa09e9fce4..067b918a8894 100644
--- a/drivers/clk/stm32/clk-stm32-core.c
+++ b/drivers/clk/stm32/clk-stm32-core.c
@@ -431,7 +431,7 @@ static int clk_stm32_composite_determine_rate(struct clk_hw *hw,
 {
 	struct clk_stm32_composite *composite = to_clk_stm32_composite(hw);
 	const struct stm32_div_cfg *divider;
-	unsigned long rate;
+	long rate;
 
 	if (composite->div_id == NO_STM32_DIV)
 		return 0;
-- 
2.20.1.7.g153144c


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 138C5634029
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 16:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbiKVP1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 10:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232742AbiKVP1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 10:27:13 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB1D69DC9;
        Tue, 22 Nov 2022 07:27:11 -0800 (PST)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NGp5B4knsz15MmH;
        Tue, 22 Nov 2022 23:26:38 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 23:27:08 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nobuhiro1.iwamatsu@toshiba.co.jp>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] clk: visconti: Fix memory leak in visconti_register_pll()
Date:   Tue, 22 Nov 2022 23:23:53 +0800
Message-ID: <20221122152353.204132-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

@pll->rate_table has allocated memory by kmemdup(), if clk_hw_register()
fails, it should be freed, otherwise it will cause memory leak issue,
this patch fixes it.

Fixes: b4cbe606dc36 ("clk: visconti: Add support common clock driver and reset driver")
Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 drivers/clk/visconti/pll.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/visconti/pll.c b/drivers/clk/visconti/pll.c
index a484cb945d67..1f3234f22667 100644
--- a/drivers/clk/visconti/pll.c
+++ b/drivers/clk/visconti/pll.c
@@ -277,6 +277,7 @@ static struct clk_hw *visconti_register_pll(struct visconti_pll_provider *ctx,
 	ret = clk_hw_register(NULL, &pll->hw);
 	if (ret) {
 		pr_err("failed to register pll clock %s : %d\n", name, ret);
+		kfree(pll->rate_table);
 		kfree(pll);
 		pll_hw_clk = ERR_PTR(ret);
 	}
-- 
2.17.1


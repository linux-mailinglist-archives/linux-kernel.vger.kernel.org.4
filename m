Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40162653D62
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 10:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbiLVJS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 04:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235166AbiLVJSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 04:18:24 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4ADA20F77;
        Thu, 22 Dec 2022 01:18:22 -0800 (PST)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Nd4TC6tY4zJqgL;
        Thu, 22 Dec 2022 17:17:19 +0800 (CST)
Received: from localhost.localdomain (10.157.217.52) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 22 Dec 2022 17:18:20 +0800
From:   Tao Lan <taolan@huawei.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <j.neuschaefer@gmx.net>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, taolan <taolan@huawei.com>
Subject: [PATCH] clk: fix memory leak in hisi_clk_init.
Date:   Thu, 22 Dec 2022 09:12:21 +0000
Message-ID: <20221222091221.28308-1-taolan@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.157.217.52]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: taolan <taolan@huawei.com>

when clk_data create fail, we also need to release base.

Signed-off-by: taolan <taolan@huawei.com>
---
 drivers/clk/hisilicon/clk.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/hisilicon/clk.c b/drivers/clk/hisilicon/clk.c
index 54d9fdc93599..9ca4fc05fa57 100644
--- a/drivers/clk/hisilicon/clk.c
+++ b/drivers/clk/hisilicon/clk.c
@@ -82,6 +82,10 @@ struct hisi_clock_data *hisi_clk_init(struct device_node *np,
 	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data->clk_data);
 	return clk_data;
 err_data:
+	if (base) {
+		iounmap(base);
+		base = NULL;
+	}
 	kfree(clk_data);
 err:
 	return NULL;
-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0CF362B044
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 01:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbiKPAxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 19:53:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKPAxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 19:53:13 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B432FC25
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 16:53:12 -0800 (PST)
Received: from kwepemi500023.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NBkvl45M9zqSSl;
        Wed, 16 Nov 2022 08:49:23 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemi500023.china.huawei.com
 (7.221.188.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 16 Nov
 2022 08:53:10 +0800
From:   Peng Wu <wupeng58@huawei.com>
To:     <zhuyinbo@loongson.cn>, <arnd@arndb.de>,
        <loongarch@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <liwei391@huawei.com>,
        Peng Wu <wupeng58@huawei.com>
Subject: [PATCH -next] soc: loongson: Fix an IS_ERR() vs NULL bug in loongson2_guts_probe()
Date:   Wed, 16 Nov 2022 00:51:23 +0000
Message-ID: <20221116005123.81140-1-wupeng58@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500023.china.huawei.com (7.221.188.76)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ioremap() function returns NULL on error, it doesn't return
error pointers.

Fixes: b82621ac8450 ("soc: loongson: add GUTS driver for loongson-2 platforms")
Signed-off-by: Peng Wu <wupeng58@huawei.com>
---
 drivers/soc/loongson/loongson2_guts.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/loongson/loongson2_guts.c b/drivers/soc/loongson/loongson2_guts.c
index bace4bc8e03b..52c222b1e6ef 100644
--- a/drivers/soc/loongson/loongson2_guts.c
+++ b/drivers/soc/loongson/loongson2_guts.c
@@ -108,8 +108,8 @@ static int loongson2_guts_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	guts->regs = ioremap(res->start, res->end - res->start + 1);
-	if (IS_ERR(guts->regs))
-		return PTR_ERR(guts->regs);
+	if (!guts->regs)
+		return -ENOMEM;
 
 	/* Register soc device */
 	root = of_find_node_by_path("/");
-- 
2.17.1


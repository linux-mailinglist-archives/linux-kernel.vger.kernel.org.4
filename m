Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9496AB4C3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 03:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjCFC4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 21:56:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjCFCz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 21:55:59 -0500
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC9312874
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 18:55:58 -0800 (PST)
Received: from localhost.localdomain ([172.16.0.254])
        (user=dzm91@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 3262thtC003642-3262thtF003642
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 6 Mar 2023 10:55:47 +0800
From:   Dongliang Mu <dzm91@hust.edu.cn>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Dongliang Mu <dzm91@hust.edu.cn>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] drivers: loongson: fix memory leak in loongson2_guts_probe
Date:   Mon,  6 Mar 2023 10:53:07 +0800
Message-Id: <20230306025308.248987-1-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: dzm91@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/soc/loongson/loongson2_guts.c:150 loongson2_guts_probe()
warn: 'guts->regs' from ioremap() not released on lines: 131,135,139,143.

Fix this by modifying ioremap to devm_ioremap.

Note that, this patch is not tested due to the loongson architecture.

Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
---
v1->v2: instead of modifying error handling code, directly change
ioremap to devm_ioremap.
 drivers/soc/loongson/loongson2_guts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/loongson/loongson2_guts.c b/drivers/soc/loongson/loongson2_guts.c
index bace4bc8e03b..a053e3fdae09 100644
--- a/drivers/soc/loongson/loongson2_guts.c
+++ b/drivers/soc/loongson/loongson2_guts.c
@@ -107,7 +107,7 @@ static int loongson2_guts_probe(struct platform_device *pdev)
 	guts->little_endian = of_property_read_bool(np, "little-endian");
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	guts->regs = ioremap(res->start, res->end - res->start + 1);
+	guts->regs = devm_ioremap(dev, res->start, res->end - res->start + 1);
 	if (IS_ERR(guts->regs))
 		return PTR_ERR(guts->regs);
 
-- 
2.39.2


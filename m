Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999306AB44D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 02:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjCFBY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 20:24:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCFBY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 20:24:56 -0500
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99661EB70
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 17:24:55 -0800 (PST)
Received: from localhost.localdomain ([172.16.0.254])
        (user=dzm91@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 3261OaYh027380-3261OaYk027380
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 6 Mar 2023 09:24:41 +0800
From:   Dongliang Mu <dzm91@hust.edu.cn>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Dongliang Mu <dzm91@hust.edu.cn>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: loongson: fix memory leak in loongson2_guts_probe/remove
Date:   Mon,  6 Mar 2023 09:22:00 +0800
Message-Id: <20230306012201.242413-1-dzm91@hust.edu.cn>
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

Fix this by invoking iounmap() in the error handling code and the remove
function.

Note that, this patch is not tested due to the loongson architecture.

Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
---
 drivers/soc/loongson/loongson2_guts.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/loongson/loongson2_guts.c b/drivers/soc/loongson/loongson2_guts.c
index bace4bc8e03b..ba330adb555c 100644
--- a/drivers/soc/loongson/loongson2_guts.c
+++ b/drivers/soc/loongson/loongson2_guts.c
@@ -98,6 +98,7 @@ static int loongson2_guts_probe(struct platform_device *pdev)
 	const struct loongson2_soc_die_attr *soc_die;
 	const char *machine;
 	u32 svr;
+	int rc = -ENOMEM;
 
 	/* Initialize guts */
 	guts = devm_kzalloc(dev, sizeof(*guts), GFP_KERNEL);
@@ -128,19 +129,21 @@ static int loongson2_guts_probe(struct platform_device *pdev)
 		soc_dev_attr.family = devm_kasprintf(dev, GFP_KERNEL, "Loongson");
 	}
 	if (!soc_dev_attr.family)
-		return -ENOMEM;
+		goto iounmap;
 	soc_dev_attr.soc_id = devm_kasprintf(dev, GFP_KERNEL,
 					     "svr:0x%08x", svr);
 	if (!soc_dev_attr.soc_id)
-		return -ENOMEM;
+		goto iounmap;
 	soc_dev_attr.revision = devm_kasprintf(dev, GFP_KERNEL, "%d.%d",
 					       (svr >>  4) & 0xf, svr & 0xf);
 	if (!soc_dev_attr.revision)
-		return -ENOMEM;
+		goto iounmap;
 
 	soc_dev = soc_device_register(&soc_dev_attr);
-	if (IS_ERR(soc_dev))
-		return PTR_ERR(soc_dev);
+	if (IS_ERR(soc_dev)) {
+		rc = PTR_ERR(soc_dev);
+		goto iounmap;
+	}
 
 	pr_info("Machine: %s\n", soc_dev_attr.machine);
 	pr_info("SoC family: %s\n", soc_dev_attr.family);
@@ -148,11 +151,16 @@ static int loongson2_guts_probe(struct platform_device *pdev)
 		soc_dev_attr.soc_id, soc_dev_attr.revision);
 
 	return 0;
+
+iounmap:
+	iounmap(guts->regs);
+	return rc;
 }
 
 static int loongson2_guts_remove(struct platform_device *dev)
 {
 	soc_device_unregister(soc_dev);
+	iounmap(guts->regs);
 
 	return 0;
 }
-- 
2.39.2


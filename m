Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1F86DC5BE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 12:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjDJK1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 06:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjDJK1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 06:27:01 -0400
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226C91722
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 03:26:59 -0700 (PDT)
Received: from foreverowl-virtual-machine.localdomain ([10.12.168.97])
        (user=m202071378@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 33AAPOkn009938-33AAPOkq009938
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 10 Apr 2023 18:25:24 +0800
From:   YAN SHI <m202071378@hust.edu.cn>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Wei Yongjun <weiyongjun1@huawei.com>
Cc:     YAN SHI <m202071378@hust.edu.cn>, Dongliang Mu <dzm91@hust.edu.cn>,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] Regulator: stm32-pwr: fix of_iomap leak
Date:   Mon, 10 Apr 2023 18:25:01 +0800
Message-Id: <20230410102501.13246-1-m202071378@hust.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: m202071378@hust.edu.cn
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch reports:
drivers/regulator/stm32-pwr.c:166 stm32_pwr_regulator_probe() warn:
'base' from of_iomap() not released on lines: 151,166.

In stm32_pwr_regulator_probe(), base is not released
when devm_kzalloc() fails to allocate memory or
devm_regulator_register() fails to register a new regulator device, 
which may cause a leak.

To fix this issue, replace of_iomap() with 
devm_platform_ioremap_resource(). devm_platform_ioremap_resource()
is a specialized function for platform devices. 
It allows 'base' to be automatically released whether the probe
function succeeds or fails.

Besides, use IS_ERR(base) instead of !base 
as the return value of devm_platform_ioremap_resource() 
can either be a pointer to the remapped memory or 
an ERR_PTR() encoded error code if the operation fails.

Fixes: dc62f951a6a8 ("regulator: stm32-pwr: Fix return value check in stm32_pwr_regulator_probe()")
Signed-off-by: YAN SHI <m202071378@hust.edu.cn>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
---
The issue is found by static analysis, and the patch remains untest.
---
 drivers/regulator/stm32-pwr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/stm32-pwr.c b/drivers/regulator/stm32-pwr.c
index 2a42acb7c24e..1df64e3513c6 100644
--- a/drivers/regulator/stm32-pwr.c
+++ b/drivers/regulator/stm32-pwr.c
@@ -136,10 +136,10 @@ static int stm32_pwr_regulator_probe(struct platform_device *pdev)
 	struct regulator_config config = { };
 	int i, ret = 0;
 
-	base = of_iomap(np, 0);
-	if (!base) {
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base)) {
 		dev_err(&pdev->dev, "Unable to map IO memory\n");
-		return -ENOMEM;
+		return PTR_ERR(base);
 	}
 
 	config.dev = &pdev->dev;
-- 
2.34.1


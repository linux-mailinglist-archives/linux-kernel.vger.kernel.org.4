Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D31765685C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 09:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiL0ITs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 03:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbiL0ITj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 03:19:39 -0500
Received: from out30-8.freemail.mail.aliyun.com (out30-8.freemail.mail.aliyun.com [115.124.30.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9930E8FD4;
        Tue, 27 Dec 2022 00:19:32 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VYCwgaT_1672129163;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VYCwgaT_1672129163)
          by smtp.aliyun-inc.com;
          Tue, 27 Dec 2022 16:19:29 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org, lee@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] mfd: qcom-pm8xxx: Remove set but unused variable 'rev'
Date:   Tue, 27 Dec 2022 16:19:21 +0800
Message-Id: <20221227081921.56448-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable rev is not effectively used in the function, so delete it.

drivers/mfd/qcom-pm8xxx.c:513:6: warning: variable 'rev' set but not used.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3558
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/mfd/qcom-pm8xxx.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mfd/qcom-pm8xxx.c b/drivers/mfd/qcom-pm8xxx.c
index 601106580e2e..9a948df8c28d 100644
--- a/drivers/mfd/qcom-pm8xxx.c
+++ b/drivers/mfd/qcom-pm8xxx.c
@@ -510,7 +510,6 @@ static int pm8xxx_probe(struct platform_device *pdev)
 	struct regmap *regmap;
 	int irq, rc;
 	unsigned int val;
-	u32 rev;
 	struct pm_irq_chip *chip;
 
 	data = of_device_get_match_data(&pdev->dev);
@@ -535,7 +534,6 @@ static int pm8xxx_probe(struct platform_device *pdev)
 		return rc;
 	}
 	pr_info("PMIC revision 1: %02X\n", val);
-	rev = val;
 
 	/* Read PMIC chip revision 2 */
 	rc = regmap_read(regmap, REG_HWREV_2, &val);
@@ -545,7 +543,6 @@ static int pm8xxx_probe(struct platform_device *pdev)
 		return rc;
 	}
 	pr_info("PMIC revision 2: %02X\n", val);
-	rev |= val << BITS_PER_BYTE;
 
 	chip = devm_kzalloc(&pdev->dev,
 			    struct_size(chip, config, data->num_irqs),
-- 
2.20.1.7.g153144c


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEDDF622380
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 06:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiKIFnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 00:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKIFnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 00:43:32 -0500
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6675EC5E;
        Tue,  8 Nov 2022 21:43:31 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VUMVrOK_1667972607;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VUMVrOK_1667972607)
          by smtp.aliyun-inc.com;
          Wed, 09 Nov 2022 13:43:29 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     rafael@kernel.org
Cc:     viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] cpufreq: Remove the unused variables
Date:   Wed,  9 Nov 2022 13:43:26 +0800
Message-Id: <20221109054326.89507-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function using variable 'acpi_cpufreq_online' has been deleted,
so it is redundant. Similarly, variable 'ret' assigned to
acpi_cpufreq_online is redundant, and 'ret' is not initialized,
because its assignment statement has also been eliminated.

Remove the unused variables to silence this warning:
drivers/cpufreq/acpi-cpufreq.c:960:9: note: initialize the variable
'ret' to silence this warning

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2824
Fixes: 13fdbc8b8da6 ("cpufreq: ACPI: Defer setting boost MSRs")
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/cpufreq/acpi-cpufreq.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index c8fdfcf659e6..74ef0e05ff7b 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -953,12 +953,8 @@ static struct cpufreq_driver acpi_cpufreq_driver = {
 	.attr		= acpi_cpufreq_attr,
 };
 
-static enum cpuhp_state acpi_cpufreq_online;
-
 static void __init acpi_cpufreq_boost_init(void)
 {
-	int ret;
-
 	if (!(boot_cpu_has(X86_FEATURE_CPB) || boot_cpu_has(X86_FEATURE_IDA))) {
 		pr_debug("Boost capabilities not present in the processor\n");
 		return;
@@ -966,8 +962,6 @@ static void __init acpi_cpufreq_boost_init(void)
 
 	acpi_cpufreq_driver.set_boost = set_boost;
 	acpi_cpufreq_driver.boost_enabled = boost_state(0);
-
-	acpi_cpufreq_online = ret;
 }
 
 static int __init acpi_cpufreq_init(void)
-- 
2.20.1.7.g153144c


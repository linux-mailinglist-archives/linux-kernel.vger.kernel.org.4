Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE5B633CDC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 13:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbiKVMtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 07:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbiKVMtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 07:49:41 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A26606AB;
        Tue, 22 Nov 2022 04:49:40 -0800 (PST)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NGkbL2hcyzHw4C;
        Tue, 22 Nov 2022 20:49:02 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 20:49:38 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <mani@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] cpufreq: qcom-hw: Fix memory leak in qcom_cpufreq_hw_driver_probe()
Date:   Tue, 22 Nov 2022 20:46:27 +0800
Message-ID: <20221122124627.174403-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If devm_clk_hw_register() fails, clk_init.name should be freed before
return error, otherwise will cause memory leak issue, fix it.

Fixes: 84063a1cbe9e ("cpufreq: qcom-hw: Add CPU clock provider support")
Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 1bd1e9ae5308..340fed35e45d 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -723,6 +723,7 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
 		ret = devm_clk_hw_register(dev, &data->cpu_clk);
 		if (ret < 0) {
 			dev_err(dev, "Failed to register clock %d: %d\n", i, ret);
+			kfree(clk_init.name);
 			return ret;
 		}
 
-- 
2.17.1


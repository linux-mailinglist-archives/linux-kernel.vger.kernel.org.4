Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78EF074CCC9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 08:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjGJGZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 02:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjGJGZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 02:25:24 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E4716128;
        Sun,  9 Jul 2023 23:25:22 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1C05D75;
        Sun,  9 Jul 2023 23:26:04 -0700 (PDT)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.40.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6F0B33F67D;
        Sun,  9 Jul 2023 23:25:16 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, gregkh@linuxfoundation.org,
        rafael@kernel.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
        Steve Clevenger <scclevenger@os.amperecomputing.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Len Brown <lenb@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V6 1/6] coresight: etm4x: Allocate and device assign 'struct etmv4_drvdata' earlier
Date:   Mon, 10 Jul 2023 11:54:55 +0530
Message-Id: <20230710062500.45147-2-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230710062500.45147-1-anshuman.khandual@arm.com>
References: <20230710062500.45147-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocate and device assign 'struct etmv4_drvdata' earlier during the driver
probe, ensuring that it can be retrieved in power management based runtime
callbacks if required. This will also help in dropping iomem base address
argument from the function etm4_probe() later.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 .../coresight/coresight-etm4x-core.c          | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 7e307022303a..264242ba345b 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -2046,17 +2046,14 @@ static int etm4_add_coresight_dev(struct etm4_init_arg *init_arg)
 
 static int etm4_probe(struct device *dev, void __iomem *base, u32 etm_pid)
 {
-	struct etmv4_drvdata *drvdata;
+	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev);
 	struct csdev_access access = { 0 };
 	struct etm4_init_arg init_arg = { 0 };
 	struct etm4_init_arg *delayed;
 
-	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
-	if (!drvdata)
+	if (WARN_ON(!drvdata))
 		return -ENOMEM;
 
-	dev_set_drvdata(dev, drvdata);
-
 	if (pm_save_enable == PARAM_PM_SAVE_FIRMWARE)
 		pm_save_enable = coresight_loses_context_with_cpu(dev) ?
 			       PARAM_PM_SAVE_SELF_HOSTED : PARAM_PM_SAVE_NEVER;
@@ -2108,6 +2105,7 @@ static int etm4_probe(struct device *dev, void __iomem *base, u32 etm_pid)
 
 static int etm4_probe_amba(struct amba_device *adev, const struct amba_id *id)
 {
+	struct etmv4_drvdata *drvdata;
 	void __iomem *base;
 	struct device *dev = &adev->dev;
 	struct resource *res = &adev->res;
@@ -2118,6 +2116,11 @@ static int etm4_probe_amba(struct amba_device *adev, const struct amba_id *id)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
+	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
+	if (!drvdata)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, drvdata);
 	ret = etm4_probe(dev, base, id->id);
 	if (!ret)
 		pm_runtime_put(&adev->dev);
@@ -2127,8 +2130,14 @@ static int etm4_probe_amba(struct amba_device *adev, const struct amba_id *id)
 
 static int etm4_probe_platform_dev(struct platform_device *pdev)
 {
+	struct etmv4_drvdata *drvdata;
 	int ret;
 
+	drvdata = devm_kzalloc(&pdev->dev, sizeof(*drvdata), GFP_KERNEL);
+	if (!drvdata)
+		return -ENOMEM;
+
+	dev_set_drvdata(&pdev->dev, drvdata);
 	pm_runtime_get_noresume(&pdev->dev);
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
-- 
2.25.1


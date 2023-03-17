Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5474F6BDF2D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 04:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbjCQDFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 23:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjCQDF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 23:05:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ECA31EC45;
        Thu, 16 Mar 2023 20:05:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63AFE1480;
        Thu, 16 Mar 2023 20:06:11 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.40.17])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CD4693F64C;
        Thu, 16 Mar 2023 20:05:21 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com
Cc:     scclevenger@os.amperecomputing.com,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] coresight: etm4x: Allocate and device assign 'struct etmv4_drvdata' earlier
Date:   Fri, 17 Mar 2023 08:34:55 +0530
Message-Id: <20230317030501.1811905-2-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230317030501.1811905-1-anshuman.khandual@arm.com>
References: <20230317030501.1811905-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
index 1ea8f173cca0..10119c223fbe 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -2050,17 +2050,14 @@ static int etm4_add_coresight_dev(struct etm4_init_arg *init_arg)
 
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
@@ -2112,6 +2109,7 @@ static int etm4_probe(struct device *dev, void __iomem *base, u32 etm_pid)
 
 static int etm4_probe_amba(struct amba_device *adev, const struct amba_id *id)
 {
+	struct etmv4_drvdata *drvdata;
 	void __iomem *base;
 	struct device *dev = &adev->dev;
 	struct resource *res = &adev->res;
@@ -2122,6 +2120,11 @@ static int etm4_probe_amba(struct amba_device *adev, const struct amba_id *id)
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
@@ -2131,8 +2134,14 @@ static int etm4_probe_amba(struct amba_device *adev, const struct amba_id *id)
 
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


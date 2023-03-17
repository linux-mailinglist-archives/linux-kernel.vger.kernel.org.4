Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8F26BDF44
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 04:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjCQDH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 23:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjCQDG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 23:06:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 77FFAB1B03;
        Thu, 16 Mar 2023 20:06:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0B3F1480;
        Thu, 16 Mar 2023 20:06:49 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.40.17])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 53D3E3F64C;
        Thu, 16 Mar 2023 20:06:00 -0700 (PDT)
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
Subject: [PATCH 7/7] coresight: etm4x: Drop the AMBA driver
Date:   Fri, 17 Mar 2023 08:35:01 +0530
Message-Id: <20230317030501.1811905-8-anshuman.khandual@arm.com>
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

MMIO based etm4x devices, represented with AMBA device tree entries are now
detected and operated via the common platform driver. An explicit dedicated
AMBA driver is no longer required, this just drops that off completely.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 .../coresight/coresight-etm4x-core.c          | 89 -------------------
 1 file changed, 89 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index fe494c9c6bad..e15551355975 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -2119,32 +2119,6 @@ static int etm4_probe(struct device *dev)
 	return etm4_add_coresight_dev(&init_arg);
 }
 
-static int etm4_probe_amba(struct amba_device *adev, const struct amba_id *id)
-{
-	struct etmv4_drvdata *drvdata;
-	void __iomem *base;
-	struct device *dev = &adev->dev;
-	struct resource *res = &adev->res;
-	int ret;
-
-	/* Validity for the resource is already checked by the AMBA core */
-	base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
-
-	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
-	if (!drvdata)
-		return -ENOMEM;
-
-	drvdata->base = base;
-	dev_set_drvdata(dev, drvdata);
-	ret = etm4_probe(dev);
-	if (!ret)
-		pm_runtime_put(&adev->dev);
-
-	return ret;
-}
-
 static int etm4_probe_platform_dev(struct platform_device *pdev)
 {
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -2205,15 +2179,6 @@ static int etm4_probe_cpu(unsigned int cpu)
 	return 0;
 }
 
-static struct amba_cs_uci_id uci_id_etm4[] = {
-	{
-		/*  ETMv4 UCI data */
-		.devarch	= ETM_DEVARCH_ETMv4x_ARCH,
-		.devarch_mask	= ETM_DEVARCH_ID_MASK,
-		.devtype	= ETM_DEVTYPE_ETMv4x_ARCH,
-	}
-};
-
 static void clear_etmdrvdata(void *info)
 {
 	int cpu = *(int *)info;
@@ -2253,14 +2218,6 @@ static int __exit etm4_remove_dev(struct etmv4_drvdata *drvdata)
 	return 0;
 }
 
-static void __exit etm4_remove_amba(struct amba_device *adev)
-{
-	struct etmv4_drvdata *drvdata = dev_get_drvdata(&adev->dev);
-
-	if (drvdata)
-		etm4_remove_dev(drvdata);
-}
-
 static int __exit etm4_remove_platform_dev(struct platform_device *pdev)
 {
 	int ret = 0;
@@ -2276,42 +2233,6 @@ static int __exit etm4_remove_platform_dev(struct platform_device *pdev)
 	return ret;
 }
 
-static const struct amba_id etm4_ids[] = {
-	CS_AMBA_ID(0x000bb95d),			/* Cortex-A53 */
-	CS_AMBA_ID(0x000bb95e),			/* Cortex-A57 */
-	CS_AMBA_ID(0x000bb95a),			/* Cortex-A72 */
-	CS_AMBA_ID(0x000bb959),			/* Cortex-A73 */
-	CS_AMBA_UCI_ID(0x000bb9da, uci_id_etm4),/* Cortex-A35 */
-	CS_AMBA_UCI_ID(0x000bbd05, uci_id_etm4),/* Cortex-A55 */
-	CS_AMBA_UCI_ID(0x000bbd0a, uci_id_etm4),/* Cortex-A75 */
-	CS_AMBA_UCI_ID(0x000bbd0c, uci_id_etm4),/* Neoverse N1 */
-	CS_AMBA_UCI_ID(0x000bbd41, uci_id_etm4),/* Cortex-A78 */
-	CS_AMBA_UCI_ID(0x000f0205, uci_id_etm4),/* Qualcomm Kryo */
-	CS_AMBA_UCI_ID(0x000f0211, uci_id_etm4),/* Qualcomm Kryo */
-	CS_AMBA_UCI_ID(0x000bb802, uci_id_etm4),/* Qualcomm Kryo 385 Cortex-A55 */
-	CS_AMBA_UCI_ID(0x000bb803, uci_id_etm4),/* Qualcomm Kryo 385 Cortex-A75 */
-	CS_AMBA_UCI_ID(0x000bb805, uci_id_etm4),/* Qualcomm Kryo 4XX Cortex-A55 */
-	CS_AMBA_UCI_ID(0x000bb804, uci_id_etm4),/* Qualcomm Kryo 4XX Cortex-A76 */
-	CS_AMBA_UCI_ID(0x000bbd0d, uci_id_etm4),/* Qualcomm Kryo 5XX Cortex-A77 */
-	CS_AMBA_UCI_ID(0x000cc0af, uci_id_etm4),/* Marvell ThunderX2 */
-	CS_AMBA_UCI_ID(0x000b6d01, uci_id_etm4),/* HiSilicon-Hip08 */
-	CS_AMBA_UCI_ID(0x000b6d02, uci_id_etm4),/* HiSilicon-Hip09 */
-	{},
-};
-
-MODULE_DEVICE_TABLE(amba, etm4_ids);
-
-static struct amba_driver etm4x_amba_driver = {
-	.drv = {
-		.name   = "coresight-etm4x",
-		.owner  = THIS_MODULE,
-		.suppress_bind_attrs = true,
-	},
-	.probe		= etm4_probe_amba,
-	.remove         = etm4_remove_amba,
-	.id_table	= etm4_ids,
-};
-
 #ifdef CONFIG_PM
 static int etm4_runtime_suspend(struct device *dev)
 {
@@ -2374,27 +2295,17 @@ static int __init etm4x_init(void)
 	if (ret)
 		return ret;
 
-	ret = amba_driver_register(&etm4x_amba_driver);
-	if (ret) {
-		pr_err("Error registering etm4x AMBA driver\n");
-		goto clear_pm;
-	}
-
 	ret = platform_driver_register(&etm4_platform_driver);
 	if (!ret)
 		return 0;
 
 	pr_err("Error registering etm4x platform driver\n");
-	amba_driver_unregister(&etm4x_amba_driver);
-
-clear_pm:
 	etm4_pm_clear();
 	return ret;
 }
 
 static void __exit etm4x_exit(void)
 {
-	amba_driver_unregister(&etm4x_amba_driver);
 	platform_driver_unregister(&etm4_platform_driver);
 	etm4_pm_clear();
 }
-- 
2.25.1


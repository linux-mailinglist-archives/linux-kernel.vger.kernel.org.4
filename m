Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A07574CCCC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 08:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjGJGZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 02:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjGJGZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 02:25:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 07C0418B;
        Sun,  9 Jul 2023 23:25:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDE101FB;
        Sun,  9 Jul 2023 23:26:11 -0700 (PDT)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.40.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1B6273F67D;
        Sun,  9 Jul 2023 23:25:22 -0700 (PDT)
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
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        James Clark <james.clark@arm.com>
Subject: [PATCH V6 2/6] coresight: etm4x: Drop iomem 'base' argument from etm4_probe()
Date:   Mon, 10 Jul 2023 11:54:56 +0530
Message-Id: <20230710062500.45147-3-anshuman.khandual@arm.com>
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

'struct etm4_drvdata' itself can carry the base address before etm4_probe()
gets called. Just drop that redundant argument from etm4_probe().

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 264242ba345b..bf93147c23ca 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -2044,7 +2044,7 @@ static int etm4_add_coresight_dev(struct etm4_init_arg *init_arg)
 	return 0;
 }
 
-static int etm4_probe(struct device *dev, void __iomem *base, u32 etm_pid)
+static int etm4_probe(struct device *dev, u32 etm_pid)
 {
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev);
 	struct csdev_access access = { 0 };
@@ -2065,8 +2065,6 @@ static int etm4_probe(struct device *dev, void __iomem *base, u32 etm_pid)
 			return -ENOMEM;
 	}
 
-	drvdata->base = base;
-
 	spin_lock_init(&drvdata->spinlock);
 
 	drvdata->cpu = coresight_get_cpu(dev);
@@ -2120,8 +2118,9 @@ static int etm4_probe_amba(struct amba_device *adev, const struct amba_id *id)
 	if (!drvdata)
 		return -ENOMEM;
 
+	drvdata->base = base;
 	dev_set_drvdata(dev, drvdata);
-	ret = etm4_probe(dev, base, id->id);
+	ret = etm4_probe(dev, id->id);
 	if (!ret)
 		pm_runtime_put(&adev->dev);
 
@@ -2137,6 +2136,7 @@ static int etm4_probe_platform_dev(struct platform_device *pdev)
 	if (!drvdata)
 		return -ENOMEM;
 
+	drvdata->base = NULL;
 	dev_set_drvdata(&pdev->dev, drvdata);
 	pm_runtime_get_noresume(&pdev->dev);
 	pm_runtime_set_active(&pdev->dev);
@@ -2147,7 +2147,7 @@ static int etm4_probe_platform_dev(struct platform_device *pdev)
 	 * HW by reading appropriate registers on the HW
 	 * and thus we could skip the PID.
 	 */
-	ret = etm4_probe(&pdev->dev, NULL, 0);
+	ret = etm4_probe(&pdev->dev, 0);
 
 	pm_runtime_put(&pdev->dev);
 	return ret;
-- 
2.25.1


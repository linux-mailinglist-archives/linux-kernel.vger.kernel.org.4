Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E76C74CCD2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 08:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjGJG0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 02:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjGJGZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 02:25:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8045B118;
        Sun,  9 Jul 2023 23:25:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 559741FB;
        Sun,  9 Jul 2023 23:26:18 -0700 (PDT)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.40.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4AAE73F67D;
        Sun,  9 Jul 2023 23:25:30 -0700 (PDT)
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
Subject: [PATCH V6 3/6] coresight: etm4x: Drop pid argument from etm4_probe()
Date:   Mon, 10 Jul 2023 11:54:57 +0530
Message-Id: <20230710062500.45147-4-anshuman.khandual@arm.com>
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

Coresight device pid can be retrieved from its iomem base address, which is
stored in 'struct etm4x_drvdata'. This drops pid argument from etm4_probe()
and 'struct etm4_init_arg'. Instead etm4_check_arch_features() derives the
coresight device pid with a new helper coresight_get_pid(), right before it
is consumed in etm4_hisi_match_pid().

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 .../coresight/coresight-etm4x-core.c          | 29 ++++++++++---------
 include/linux/coresight.h                     | 12 ++++++++
 2 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index bf93147c23ca..e91e59ecec53 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -66,7 +66,6 @@ static u64 etm4_get_access_type(struct etmv4_config *config);
 static enum cpuhp_state hp_online;
 
 struct etm4_init_arg {
-	unsigned int		pid;
 	struct device		*dev;
 	struct csdev_access	*csa;
 };
@@ -370,9 +369,17 @@ static void etm4_disable_arch_specific(struct etmv4_drvdata *drvdata)
 }
 
 static void etm4_check_arch_features(struct etmv4_drvdata *drvdata,
-				      unsigned int id)
+				     struct csdev_access *csa)
 {
-	if (etm4_hisi_match_pid(id))
+	/*
+	 * TRCPIDR* registers are not required for ETMs with system
+	 * instructions. They must be identified by the MIDR+REVIDRs.
+	 * Skip the TRCPID checks for now.
+	 */
+	if (!csa->io_mem)
+		return;
+
+	if (etm4_hisi_match_pid(coresight_get_pid(csa)))
 		set_bit(ETM4_IMPDEF_HISI_CORE_COMMIT, drvdata->arch_features);
 }
 #else
@@ -385,7 +392,7 @@ static void etm4_disable_arch_specific(struct etmv4_drvdata *drvdata)
 }
 
 static void etm4_check_arch_features(struct etmv4_drvdata *drvdata,
-				     unsigned int id)
+				     struct csdev_access *csa)
 {
 }
 #endif /* CONFIG_ETM4X_IMPDEF_FEATURE */
@@ -1161,7 +1168,7 @@ static void etm4_init_arch_data(void *info)
 	etm4_os_unlock_csa(drvdata, csa);
 	etm4_cs_unlock(drvdata, csa);
 
-	etm4_check_arch_features(drvdata, init_arg->pid);
+	etm4_check_arch_features(drvdata, csa);
 
 	/* find all capabilities of the tracing unit */
 	etmidr0 = etm4x_relaxed_read32(csa, TRCIDR0);
@@ -2044,7 +2051,7 @@ static int etm4_add_coresight_dev(struct etm4_init_arg *init_arg)
 	return 0;
 }
 
-static int etm4_probe(struct device *dev, u32 etm_pid)
+static int etm4_probe(struct device *dev)
 {
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev);
 	struct csdev_access access = { 0 };
@@ -2073,7 +2080,6 @@ static int etm4_probe(struct device *dev, u32 etm_pid)
 
 	init_arg.dev = dev;
 	init_arg.csa = &access;
-	init_arg.pid = etm_pid;
 
 	/*
 	 * Serialize against CPUHP callbacks to avoid race condition
@@ -2120,7 +2126,7 @@ static int etm4_probe_amba(struct amba_device *adev, const struct amba_id *id)
 
 	drvdata->base = base;
 	dev_set_drvdata(dev, drvdata);
-	ret = etm4_probe(dev, id->id);
+	ret = etm4_probe(dev);
 	if (!ret)
 		pm_runtime_put(&adev->dev);
 
@@ -2142,12 +2148,7 @@ static int etm4_probe_platform_dev(struct platform_device *pdev)
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
-	/*
-	 * System register based devices could match the
-	 * HW by reading appropriate registers on the HW
-	 * and thus we could skip the PID.
-	 */
-	ret = etm4_probe(&pdev->dev, 0);
+	ret = etm4_probe(&pdev->dev);
 
 	pm_runtime_put(&pdev->dev);
 	return ret;
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index bf70987240e4..255cfd283883 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -386,6 +386,18 @@ static inline u32 csdev_access_relaxed_read32(struct csdev_access *csa,
 	return csa->read(offset, true, false);
 }
 
+#define CORESIGHT_PIDRn(i)	(0xFE0 + ((i) * 4))
+
+static inline u32 coresight_get_pid(struct csdev_access *csa)
+{
+	u32 i, pid = 0;
+
+	for (i = 0; i < 4; i++)
+		pid |= csdev_access_relaxed_read32(csa, CORESIGHT_PIDRn(i)) << (i * 8);
+
+	return pid;
+}
+
 static inline u64 csdev_access_relaxed_read_pair(struct csdev_access *csa,
 						 u32 lo_offset, u32 hi_offset)
 {
-- 
2.25.1


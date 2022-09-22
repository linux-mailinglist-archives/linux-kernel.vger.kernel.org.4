Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055685E5C8F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 09:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbiIVHh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 03:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbiIVHh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 03:37:56 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B857ACDCF6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 00:37:55 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MY6WD1RqWzpVRd;
        Thu, 22 Sep 2022 15:35:04 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 15:37:53 +0800
Received: from huawei.com (10.175.113.32) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 22 Sep
 2022 15:37:53 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "Mark Brown" <broonie@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH] drivers/perf: arm_spe: fix ID_AA64DFR0_PMSVER_* undeclared
Date:   Thu, 22 Sep 2022 16:11:36 +0800
Message-ID: <20220922081136.2508758-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert ID_AA64DFR0_PMSVER_* to ID_AA64DFR0_EL1_PMSVer_*.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 drivers/perf/arm_spe_pmu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index db8a0a841062..00e3a637f7b6 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -676,9 +676,9 @@ static irqreturn_t arm_spe_pmu_irq_handler(int irq, void *dev)
 static u64 arm_spe_pmsevfr_res0(u16 pmsver)
 {
 	switch (pmsver) {
-	case ID_AA64DFR0_PMSVER_8_2:
+	case ID_AA64DFR0_EL1_PMSVer_IMP:
 		return SYS_PMSEVFR_EL1_RES0_8_2;
-	case ID_AA64DFR0_PMSVER_8_3:
+	case ID_AA64DFR0_EL1_PMSVer_V1P1:
 	/* Return the highest version we support in default */
 	default:
 		return SYS_PMSEVFR_EL1_RES0_8_3;
@@ -960,7 +960,7 @@ static void __arm_spe_pmu_dev_probe(void *info)
 	struct device *dev = &spe_pmu->pdev->dev;
 
 	fld = cpuid_feature_extract_unsigned_field(read_cpuid(ID_AA64DFR0_EL1),
-						   ID_AA64DFR0_PMSVER_SHIFT);
+						   ID_AA64DFR0_EL1_PMSVer_SHIFT);
 	if (!fld) {
 		dev_err(dev,
 			"unsupported ID_AA64DFR0_EL1.PMSVer [%d] on CPU %d\n",
-- 
2.25.1


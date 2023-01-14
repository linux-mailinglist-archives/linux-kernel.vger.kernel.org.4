Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB4C66AA5B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 10:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjANJRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 04:17:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjANJQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 04:16:58 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED8F5BA2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 01:16:52 -0800 (PST)
Received: from dggpeml500002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NvCGR6VRYzqV6d;
        Sat, 14 Jan 2023 17:11:59 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500002.china.huawei.com (7.185.36.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sat, 14 Jan 2023 17:16:49 +0800
From:   Junhao He <hejunhao3@huawei.com>
To:     <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <mike.leach@linaro.org>, <leo.yan@linaro.org>
CC:     <coresight@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <anshuman.khandual@arm.com>, <linuxarm@huawei.com>,
        <shenyang39@huawei.com>, <prime.zeng@hisilicon.com>,
        <hejunhao3@huawei.com>
Subject: [PATCH v2] coresight: etm4x: Fix accesses to TRCSEQRSTEVR and TRCSEQSTR
Date:   Sat, 14 Jan 2023 17:16:32 +0800
Message-ID: <20230114091632.60095-1-hejunhao3@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500002.china.huawei.com (7.185.36.158)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TRCSEQRSTEVR and TRCSEQSTR registers are not implemented if the
TRCIDR5.NUMSEQSTATE == 0. Skip accessing the registers in such cases.

Fixes: 2e1cdfe184b5 ("coresight-etm4x: Adding CoreSight ETM4x driver")

Signed-off-by: Junhao He <hejunhao3@huawei.com>
Reviewed-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 .../hwtracing/coresight/coresight-etm4x-core.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 1cc052979e01..77bca6932f01 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -427,8 +427,10 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 		etm4x_relaxed_write32(csa, config->vipcssctlr, TRCVIPCSSCTLR);
 	for (i = 0; i < drvdata->nrseqstate - 1; i++)
 		etm4x_relaxed_write32(csa, config->seq_ctrl[i], TRCSEQEVRn(i));
-	etm4x_relaxed_write32(csa, config->seq_rst, TRCSEQRSTEVR);
-	etm4x_relaxed_write32(csa, config->seq_state, TRCSEQSTR);
+	if (drvdata->nrseqstate) {
+		etm4x_relaxed_write32(csa, config->seq_rst, TRCSEQRSTEVR);
+		etm4x_relaxed_write32(csa, config->seq_state, TRCSEQSTR);
+	}
 	etm4x_relaxed_write32(csa, config->ext_inp, TRCEXTINSELR);
 	for (i = 0; i < drvdata->nr_cntr; i++) {
 		etm4x_relaxed_write32(csa, config->cntrldvr[i], TRCCNTRLDVRn(i));
@@ -1634,8 +1636,10 @@ static int __etm4_cpu_save(struct etmv4_drvdata *drvdata)
 	for (i = 0; i < drvdata->nrseqstate - 1; i++)
 		state->trcseqevr[i] = etm4x_read32(csa, TRCSEQEVRn(i));
 
-	state->trcseqrstevr = etm4x_read32(csa, TRCSEQRSTEVR);
-	state->trcseqstr = etm4x_read32(csa, TRCSEQSTR);
+	if (drvdata->nrseqstate) {
+		state->trcseqrstevr = etm4x_read32(csa, TRCSEQRSTEVR);
+		state->trcseqstr = etm4x_read32(csa, TRCSEQSTR);
+	}
 	state->trcextinselr = etm4x_read32(csa, TRCEXTINSELR);
 
 	for (i = 0; i < drvdata->nr_cntr; i++) {
@@ -1763,8 +1767,10 @@ static void __etm4_cpu_restore(struct etmv4_drvdata *drvdata)
 	for (i = 0; i < drvdata->nrseqstate - 1; i++)
 		etm4x_relaxed_write32(csa, state->trcseqevr[i], TRCSEQEVRn(i));
 
-	etm4x_relaxed_write32(csa, state->trcseqrstevr, TRCSEQRSTEVR);
-	etm4x_relaxed_write32(csa, state->trcseqstr, TRCSEQSTR);
+	if (drvdata->nrseqstate) {
+		etm4x_relaxed_write32(csa, state->trcseqrstevr, TRCSEQRSTEVR);
+		etm4x_relaxed_write32(csa, state->trcseqstr, TRCSEQSTR);
+	}
 	etm4x_relaxed_write32(csa, state->trcextinselr, TRCEXTINSELR);
 
 	for (i = 0; i < drvdata->nr_cntr; i++) {
-- 
2.33.0


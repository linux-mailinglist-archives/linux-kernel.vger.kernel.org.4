Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE7196434C2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 20:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235257AbiLETtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 14:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235104AbiLETtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 14:49:11 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7825C2AC47
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 11:46:25 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92279D6E;
        Mon,  5 Dec 2022 11:46:26 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7CF583F71A;
        Mon,  5 Dec 2022 11:46:16 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     will@kernel.org, mark.rutland@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf/arm-cmn: Reset DTM_PMU_CONFIG at probe
Date:   Mon,  5 Dec 2022 19:46:13 +0000
Message-Id: <ba5f38b3dc733cd06bfb5e659b697e76d18c2183.1670269572.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.36.1.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although we treat the DTM counters as free-running such that we're not
too concerned about the initial DTM state, it's possible for a previous
user to have left DTM counters enabled and paired with DTC counters.
Thus if the first events are scheduled using some, but not all, DTMs,
the as-yet-unused ones could end up adding spurious increments to the
event counts at the DTC. Make sure we sync our initial DTM_PMU_CONFIG
state to all the DTMs at probe time to avoid that possibility.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/arm-cmn.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 0b2df72cee9f..81b0dfd511aa 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -1862,6 +1862,7 @@ static void arm_cmn_init_dtm(struct arm_cmn_dtm *dtm, struct arm_cmn_node *xp, i
 
 	dtm->base = xp->pmu_base + CMN_DTM_OFFSET(idx);
 	dtm->pmu_config_low = CMN_DTM_PMU_CONFIG_PMU_EN;
+	writeq_relaxed(dtm->pmu_config_low, dtm->base + CMN_DTM_PMU_CONFIG);
 	for (i = 0; i < 4; i++) {
 		dtm->wp_event[i] = -1;
 		writeq_relaxed(0, dtm->base + CMN_DTM_WPn_MASK(i));
-- 
2.36.1.dirty


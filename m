Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789B55EA8CC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 16:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234516AbiIZOoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 10:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234674AbiIZOnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 10:43:08 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765AA6E2EA;
        Mon, 26 Sep 2022 06:05:29 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0VQo1ZLP_1664197498;
Received: from j66e01291.sqa.eu95.tbsite.net(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VQo1ZLP_1664197498)
          by smtp.aliyun-inc.com;
          Mon, 26 Sep 2022 21:05:24 +0800
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     john.garry@huawei.com, will@kernel.org, james.clark@arm.com,
        mike.leach@linaro.org, leo.yan@linaro.org, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, german.gomez@arm.com, timothy.hayes@arm.com,
        alisaidi@amazon.com, xueshuai@linux.alibaba.com,
        zhuo.song@linux.alibaba.com, renyu.zj@linux.alibaba.com
Subject: [PATCH] perf arm-spe: augment the data source type with neoverse_spe list
Date:   Mon, 26 Sep 2022 21:03:16 +0800
Message-Id: <1664197396-42672-1-git-send-email-renyu.zj@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When synthesizing event with SPE data source, commit 4e6430cbb1a9("perf
arm-spe: Use SPE data source for neoverse cores") augment the type with
source information by MIDR. However, is_midr_in_range only compares the
first entry in neoverse_spe.

Change is_midr_in_range to is_midr_in_range_list to traverse the
neoverse_spe array so that all neoverse cores synthesize event with data
source packet.

Fixes: 4e6430cbb1a9("perf arm-spe: Use SPE data source for neoverse cores")
Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
---
 tools/perf/util/arm-spe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 22dcfe0..906476a 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -498,7 +498,7 @@ static void arm_spe__synth_data_source_generic(const struct arm_spe_record *reco
 static u64 arm_spe__synth_data_source(const struct arm_spe_record *record, u64 midr)
 {
 	union perf_mem_data_src	data_src = { 0 };
-	bool is_neoverse = is_midr_in_range(midr, neoverse_spe);
+	bool is_neoverse = is_midr_in_range_list(midr, neoverse_spe);
 
 	if (record->op == ARM_SPE_LD)
 		data_src.mem_op = PERF_MEM_OP_LOAD;
-- 
1.8.3.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D673B6B562C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 01:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjCKAHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 19:07:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjCKAGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 19:06:53 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5A413E51C
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 16:06:45 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id x34so6888042pjj.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 16:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678493205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=B7QL62ne7xspG8r+3tPhE63tmfSAaS1hXK7nOe5vD3E=;
        b=n0xTQPTe8pqES0vIKyOOdIgJuU1v7f0nTP9ox96dIsL9yxnzB2O70ZPtacZWQ7IvPr
         WERUt3uCAASQqVKnw0sfH64d3t4TqNkRfzuygF0x3qCS3TVio43ikRYPe8fxyUmKsREy
         gx0s3H7eAsiCnYGcQyGu3NeDRf+XHkSxJ87YRY13NJQPj3sP1O4WpCI5DkVaLwliYu/a
         k3DBlAmiDKEt//asGCq4O4rTHvckP7cpMTverCNh7PPpZHZNbPhxkXesbzdvYvYo4DrB
         bT9DA0eOhxdv02KsKnFwFejZLiDphFQf0kH405GQb6pqjCrFOVVYJABr+6etgqUKbSi2
         YlYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678493205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7QL62ne7xspG8r+3tPhE63tmfSAaS1hXK7nOe5vD3E=;
        b=sMoCNi6uDtIZVow5Z02bwURgc4WU2AcVxPr2BbBxhGy01DQvraDV8j2V/keZxTtRgj
         klmFSCqEpsNQVvbwPOp6OzbkvAXySfWmO8SGrvUjjO0441lsTgEN05n2UwOEXgd5slTz
         FXBeKXDJyh35afmZLUqRaQ5V5DDU7eU/xRwC3Xc0ABQgi8oJHieWKCvDJFlD8T/8Fm4Q
         huYTZyVsL+eug+qxCFdh9DIb9FCKBXaCEoxhJ8bpSetQY6y3wmhiceBvw/p6YIkK2NQr
         0+zcFqmUOCCmLVDFQ5JR0ji05nVorXkngsWOLLQSOdU5BLkpoaAMcIs6RD+eMnM8xreN
         un+g==
X-Gm-Message-State: AO0yUKWjp01/YpqCU88+1W7uDpPeEr4dGnblxGnKFuUiobsHLsYkXTSN
        l1Py8Xw24dCTVSAa5ZJzov4=
X-Google-Smtp-Source: AK7set+M9O7MSFTxSQxlh9GYeksoKJjt4QTwCjugg3Sz3h9rkDgxAmYofKarB5sQrbcoP/1aEZL26w==
X-Received: by 2002:a17:902:f54c:b0:19c:a9b8:4349 with SMTP id h12-20020a170902f54c00b0019ca9b84349mr32754383plf.32.1678493205162;
        Fri, 10 Mar 2023 16:06:45 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:44b0:e32f:ca65:5413:8ef7])
        by smtp.gmail.com with ESMTPSA id lk15-20020a17090308cf00b0019b0937003esm505421plb.150.2023.03.10.16.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 16:06:44 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Ravi Bangoria <ravi.bangoria@amd.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] perf/x86/ibs: Set data_src.mem_lvl_num as well
Date:   Fri, 10 Mar 2023 16:06:42 -0800
Message-Id: <20230311000642.1270971-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IBS PMU driver sets data source of memory operations but it missed
mem_lvl_num field.  So I'm adding them here.

Most cases are straight-forward but please check if MEM_LVLNUM_ANY_CACHE
for peer cache hits is ok.  Also I wonder we can add MEM_REMOTE_REMOTE
for peer cache hits in a far CCX.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 arch/x86/events/amd/ibs.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 64582954b5f6..819869fc2dc7 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -724,6 +724,7 @@ static void perf_ibs_get_mem_lvl(union ibs_op_data2 *op_data2,
 	/* L1 Hit */
 	if (op_data3->dc_miss == 0) {
 		data_src->mem_lvl = PERF_MEM_LVL_L1 | PERF_MEM_LVL_HIT;
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L1;
 		return;
 	}
 
@@ -733,6 +734,7 @@ static void perf_ibs_get_mem_lvl(union ibs_op_data2 *op_data2,
 		if (boot_cpu_data.x86 != 0x19 || boot_cpu_data.x86_model > 0xF ||
 		    !(op_data3->sw_pf || op_data3->dc_miss_no_mab_alloc)) {
 			data_src->mem_lvl = PERF_MEM_LVL_L2 | PERF_MEM_LVL_HIT;
+			data_src->mem_lvl_num = PERF_MEM_LVLNUM_L2;
 			return;
 		}
 	}
@@ -748,12 +750,14 @@ static void perf_ibs_get_mem_lvl(union ibs_op_data2 *op_data2,
 	if (ibs_caps & IBS_CAPS_ZEN4) {
 		if (ibs_data_src == IBS_DATA_SRC_EXT_LOC_CACHE) {
 			data_src->mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_HIT;
+			data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
 			return;
 		}
 	} else {
 		if (ibs_data_src == IBS_DATA_SRC_LOC_CACHE) {
 			data_src->mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_REM_CCE1 |
 					    PERF_MEM_LVL_HIT;
+			data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
 			return;
 		}
 	}
@@ -762,6 +766,7 @@ static void perf_ibs_get_mem_lvl(union ibs_op_data2 *op_data2,
 	if (ibs_caps & IBS_CAPS_ZEN4 &&
 	    ibs_data_src == IBS_DATA_SRC_EXT_NEAR_CCX_CACHE) {
 		data_src->mem_lvl = PERF_MEM_LVL_REM_CCE1 | PERF_MEM_LVL_HIT;
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_ANY_CACHE;
 		return;
 	}
 
@@ -769,11 +774,13 @@ static void perf_ibs_get_mem_lvl(union ibs_op_data2 *op_data2,
 	if (ibs_caps & IBS_CAPS_ZEN4) {
 		if (ibs_data_src == IBS_DATA_SRC_EXT_FAR_CCX_CACHE) {
 			data_src->mem_lvl = PERF_MEM_LVL_REM_CCE2 | PERF_MEM_LVL_HIT;
+			data_src->mem_lvl_num = PERF_MEM_LVLNUM_ANY_CACHE;
 			return;
 		}
 	} else {
 		if (ibs_data_src == IBS_DATA_SRC_REM_CACHE) {
 			data_src->mem_lvl = PERF_MEM_LVL_REM_CCE2 | PERF_MEM_LVL_HIT;
+			data_src->mem_lvl_num = PERF_MEM_LVLNUM_ANY_CACHE;
 			return;
 		}
 	}
@@ -784,6 +791,7 @@ static void perf_ibs_get_mem_lvl(union ibs_op_data2 *op_data2,
 			data_src->mem_lvl = PERF_MEM_LVL_LOC_RAM | PERF_MEM_LVL_HIT;
 		else
 			data_src->mem_lvl = PERF_MEM_LVL_REM_RAM1 | PERF_MEM_LVL_HIT;
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_RAM;
 		return;
 	}
 
@@ -832,10 +840,12 @@ static void perf_ibs_get_mem_lvl(union ibs_op_data2 *op_data2,
 	 */
 	if (op_data3->dc_miss_no_mab_alloc) {
 		data_src->mem_lvl = PERF_MEM_LVL_LFB | PERF_MEM_LVL_HIT;
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_LFB;
 		return;
 	}
 
 	data_src->mem_lvl = PERF_MEM_LVL_NA;
+	data_src->mem_lvl_num = PERF_MEM_LVLNUM_NA;
 }
 
 static bool perf_ibs_cache_hit_st_valid(void)
-- 
2.40.0.rc1.284.g88254d51c5-goog


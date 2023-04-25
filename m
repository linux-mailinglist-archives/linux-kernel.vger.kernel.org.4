Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB396EDA9E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 05:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbjDYDY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 23:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjDYDYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 23:24:25 -0400
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EC6A8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 20:24:23 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R781e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=tianruidong@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VgyI3jM_1682393057;
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0VgyI3jM_1682393057)
          by smtp.aliyun-inc.com;
          Tue, 25 Apr 2023 11:24:21 +0800
From:   Ruidong Tian <tianruidong@linux.alibaba.com>
To:     tianruidong@linux.alibaba.com, coresight@lists.linaro.org
Cc:     suzuki.poulose@arm.com, mike.leach@linaro.org, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] coresight: perf: Release Coresight path when alloc trace id failed
Date:   Tue, 25 Apr 2023 11:24:16 +0800
Message-Id: <20230425032416.125542-1-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Error handler for etm_setup_aux can not release coresight path because
cpu mask was cleared when coresight_trace_id_get_cpu_id failed.

Call coresight_release_path function explicitly when alloc trace id filed.

Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 711f451b6946..89e8ed214ea4 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -402,6 +402,7 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
 		trace_id = coresight_trace_id_get_cpu_id(cpu);
 		if (!IS_VALID_CS_TRACE_ID(trace_id)) {
 			cpumask_clear_cpu(cpu, mask);
+			coresight_release_path(path);
 			continue;
 		}
 
-- 
2.33.1


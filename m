Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3306163FA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 14:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiKBNmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 09:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiKBNmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 09:42:38 -0400
X-Greylist: delayed 17075 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 02 Nov 2022 06:42:33 PDT
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CA7E5B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 06:42:33 -0700 (PDT)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4N2SkJ06f3z8RTZG;
        Wed,  2 Nov 2022 21:42:32 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl1.zte.com.cn with SMTP id 2A2DgO4J003202;
        Wed, 2 Nov 2022 21:42:24 +0800 (+08)
        (envelope-from zhang.songyi@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 2 Nov 2022 21:42:28 +0800 (CST)
Date:   Wed, 2 Nov 2022 21:42:28 +0800 (CST)
X-Zmail-TransId: 2af9636273c4ffffffffdcaf2ff3
X-Mailer: Zmail v1.0
Message-ID: <202211022142286140482@zte.com.cn>
Mime-Version: 1.0
From:   <zhang.songyi@zte.com.cn>
To:     <peterz@infradead.org>
Cc:     <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <zhang.songyi@zte.com.cn>,
        <jiang.xuexin@zte.com.cn>, <xue.zhihong@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIHBlcmYgc3RhdDogcmVtb3ZlIHJlZHVuZGFudCByZXQgdmFyaWFibGU=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2A2DgO4J003202
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 636273C8.000 by FangMail milter!
X-FangMail-Envelope: 1667396552/4N2SkJ06f3z8RTZG/636273C8.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<zhang.songyi@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 636273C8.000/4N2SkJ06f3z8RTZG
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From d377abf9906fa9533d4a31b576ca9aaafdcd7402 Mon Sep 17 00:00:00 2001
From: zhang songyi <zhang.songyi@zte.com.cn>
Date: Wed, 2 Nov 2022 21:10:40 +0800
Subject: [PATCH linux-next] perf stat: remove redundant ret variable

Return value from perf_stat__get_aggr() directly instead of taking this in
another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: zhang songyi <zhang.songyi@zte.com.cn>
---
 tools/perf/builtin-stat.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index e52601a54b26..16dc1d72880e 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1355,8 +1355,6 @@ static struct aggr_cpu_id perf_stat__get_cpu(struct perf_stat_config *config __m
 static struct aggr_cpu_id perf_stat__get_aggr(struct perf_stat_config *config,
                          aggr_get_id_t get_id, struct perf_cpu cpu)
 {
-   struct aggr_cpu_id id;
-
    /* per-process mode - should use global aggr mode */
    if (cpu.cpu == -1)
        return get_id(config, cpu);
@@ -1364,8 +1362,7 @@ static struct aggr_cpu_id perf_stat__get_aggr(struct perf_stat_config *config,
    if (aggr_cpu_id__is_empty(&config->cpus_aggr_map->map[cpu.cpu]))
        config->cpus_aggr_map->map[cpu.cpu] = get_id(config, cpu);

-   id = config->cpus_aggr_map->map[cpu.cpu];
-   return id;
+   return config->cpus_aggr_map->map[cpu.cpu];
 }

 static struct aggr_cpu_id perf_stat__get_socket_cached(struct perf_stat_config *config,
--
2.15.2

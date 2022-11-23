Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF0D6353FC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 10:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236874AbiKWJBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 04:01:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236880AbiKWJBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 04:01:06 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B363FFA8A;
        Wed, 23 Nov 2022 01:01:02 -0800 (PST)
Received: from mxct.zte.com.cn (unknown [192.168.251.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NHFTk5yf8z8RV6H;
        Wed, 23 Nov 2022 17:00:58 +0800 (CST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4NHFTh3b9Sz4y0tt;
        Wed, 23 Nov 2022 17:00:56 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl2.zte.com.cn with SMTP id 2AN90mIR055180;
        Wed, 23 Nov 2022 17:00:48 +0800 (+08)
        (envelope-from zhang.songyi@zte.com.cn)
Received: from mapi (xaxapp02[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 23 Nov 2022 17:00:50 +0800 (CST)
Date:   Wed, 23 Nov 2022 17:00:50 +0800 (CST)
X-Zmail-TransId: 2afa637de14266b30956
X-Mailer: Zmail v1.0
Message-ID: <202211231700506267036@zte.com.cn>
Mime-Version: 1.0
From:   <zhang.songyi@zte.com.cn>
To:     <peterz@infradead.org>, <zhengjun.xing@linux.intel.com>
Cc:     <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <kan.liang@linux.intel.com>,
        <irogers@google.com>, <zhang.songyi@zte.com.cn>,
        <adrian.hunter@intel.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIHBlcmYgc3RhdDogcmVtb3ZlIHJlZHVuZGFudCB2YXJpYWJsZSBpbgogYXJjaF9nZXRfdG9wZG93bl9wbXVfbmFtZQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2AN90mIR055180
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 637DE14A.000 by FangMail milter!
X-FangMail-Envelope: 1669194058/4NHFTk5yf8z8RV6H/637DE14A.000/192.168.251.13/[192.168.251.13]/mxct.zte.com.cn/<zhang.songyi@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 637DE14A.000/4NHFTk5yf8z8RV6H
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhang songyi <zhang.songyi@zte.com.cn>

Return value from arch_get_topdown_pmu_name directly instead of taking
this in another redundant variable.

Signed-off-by: zhang songyi <zhang.songyi@zte.com.cn>
---
 tools/perf/arch/x86/util/topdown.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tools/perf/arch/x86/util/topdown.c b/tools/perf/arch/x86/util/topdown.c
index 54810f9acd6f..5a5cdd6efe4d 100644
--- a/tools/perf/arch/x86/util/topdown.c
+++ b/tools/perf/arch/x86/util/topdown.c
@@ -84,8 +84,6 @@ bool arch_topdown_sample_read(struct evsel *leader)

 const char *arch_get_topdown_pmu_name(struct evlist *evlist, bool warn)
 {
-       const char *pmu_name;
-
        if (!perf_pmu__has_hybrid())
                return "cpu";

@@ -95,9 +93,7 @@ const char *arch_get_topdown_pmu_name(struct evlist *evlist, bool warn)
                evlist->hybrid_pmu_name = perf_pmu__hybrid_type_to_pmu("core");
        }

-       pmu_name = evlist->hybrid_pmu_name;
-
-       return pmu_name;
+       return evlist->hybrid_pmu_name;
 }

 int topdown_parse_events(struct evlist *evlist)
--
2.15.2

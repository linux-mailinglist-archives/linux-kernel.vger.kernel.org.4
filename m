Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13FE633C24
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 13:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233617AbiKVMLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 07:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbiKVMLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 07:11:12 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F064877B;
        Tue, 22 Nov 2022 04:11:10 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NGjld0LlWz8RV7H;
        Tue, 22 Nov 2022 20:11:09 +0800 (CST)
Received: from szxlzmapp04.zte.com.cn ([10.5.231.166])
        by mse-fl1.zte.com.cn with SMTP id 2AMCAvUB099604;
        Tue, 22 Nov 2022 20:10:57 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp02[null])
        by mapi (Zmail) with MAPI id mid14;
        Tue, 22 Nov 2022 20:11:00 +0800 (CST)
Date:   Tue, 22 Nov 2022 20:11:00 +0800 (CST)
X-Zmail-TransId: 2b04637cbc54ffffffffd22e5c5b
X-Mailer: Zmail v1.0
Message-ID: <202211222011006572179@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <mingo@redhat.com>
Cc:     <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <irogers@google.com>, <james.clark@arm.com>,
        <kan.liang@linux.intel.com>, <zhengjun.xing@linux.intel.com>,
        <cjense@google.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <xu.panda@zte.com.cn>,
        <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIHBlcmYgc3RhdDogdXNlIHN5c2ZzX3N0cmVxKCkgaW5zdGVhZCBvZiBzdHJuY21wKCk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2AMCAvUB099604
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 637CBC5D.000 by FangMail milter!
X-FangMail-Envelope: 1669119069/4NGjld0LlWz8RV7H/637CBC5D.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<yang.yang29@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 637CBC5D.000/4NGjld0LlWz8RV7H
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu Panda <xu.panda@zte.com.cn>

Replace the open-code with sysfs_streq().

Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
Signed-off-by: Yang Yang <yang.yang29@zte.com>
---
 tools/perf/util/stat-display.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index f5501760ff2e..1fd9f7e9d2a1 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -463,7 +463,7 @@ static bool valid_only_metric(const char *unit)
 static const char *fixunit(char *buf, struct evsel *evsel,
 			   const char *unit)
 {
-	if (!strncmp(unit, "of all", 6)) {
+	if (sysfs_streq(unit, "of all")) {
 		snprintf(buf, 1024, "%s %s", evsel__name(evsel),
 			 unit);
 		return buf;
@@ -767,8 +767,7 @@ static void uniquify_event_name(struct evsel *counter)
 	int ret = 0;

 	if (counter->uniquified_name || counter->use_config_name ||
-	    !counter->pmu_name || !strncmp(counter->name, counter->pmu_name,
-					   strlen(counter->pmu_name)))
+	    !counter->pmu_name || sysfs_streq(counter->name, counter->pmu_name))
 		return;

 	config = strchr(counter->name, '/');
-- 
2.15.2

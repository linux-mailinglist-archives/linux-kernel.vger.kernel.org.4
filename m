Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168536AFB10
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 01:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjCHA1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 19:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjCHA1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 19:27:35 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC77BA1FD2
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 16:27:33 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id n196-20020a2540cd000000b00889c54916f2so15961198yba.14
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 16:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678235253;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mWYo+xMJNjNNqpgF4TGynZqpAOyeMeI+jcBtHhYSVHg=;
        b=C67RkmTNFLNA5Ch6vBhB0wpdWJqLfcFfPsxbzrVhPo3nAPTNH2h4YVolTieBJYsV/k
         PSyWbuH4HmNNDNfQpVVYxzaW3Y50KGhaIRWiIK0lAYgcAdSx4JxuvpgPS9cHqJ2Gmy/m
         0pEYlk9ovA7NsB4eOqJEVYGOqKK5P/IMaNX1vU44PnQEAmV0VgOROo75Vt4CxLfuMXro
         Bb0P5/YRKNYpKaGwCRZUZfEmWkqESKqoISietCpJowZnEJhVONMLvOcR52YCEuVNAsXK
         mrcYV9UuTZoN5uYQdWOTwXW29ub28zxB8V9T7Jr6crsU9x+BBVQEeYmGCZIWpLfcAeCX
         fE0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678235253;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mWYo+xMJNjNNqpgF4TGynZqpAOyeMeI+jcBtHhYSVHg=;
        b=Q8kpG1CU1+Y8iS2bSYKMMTpzUMM7bRtC8H2JlbLL2D1uCAmDth3LgvD39niQ8XecA7
         IQTdR/agY4E+sDuxOkUygXNBcFXhK0MgA+21SB6KI1+UQc/rXLP/y/GVwc/jWro7th3S
         Xy6UhmGNtRC7YCVI2Tx8+tLcrZs6y6rCQ9Lh89f+6TxOXPlfZHmZoa1YAQTDrU9TW7Rx
         0SU2cHCwomUxjJXruyqM09hilzCuLLP2hUwnjd+TEoOVIsFq5GJHE8vPRF3aBOFKr4wy
         Q9XbpKAna6w8BdMjZ3cXoRKj2oXW8UVSGg+LldtsiPV/DnVuJ1sG7Qsy2C/+hNfa5hCv
         ZCzQ==
X-Gm-Message-State: AO0yUKVFKDmQjlG48WFrD0tl6kwbjelodRaDK2XllC5iijO7hSc9+Kr7
        d4jMs8Altr1bv44tD8naDVuVHSRwo6Ro
X-Google-Smtp-Source: AK7set9NhJf3r2M4roAs5BFf6UZftEpio2ChPi04lrVXkyOIyYZd58Hy1EhrQV9/ydUKPZ4+qrzxwJR5S95p
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:9a99:fbc4:7488:8b5f])
 (user=irogers job=sendgmr) by 2002:a81:a783:0:b0:533:9b80:a30e with SMTP id
 e125-20020a81a783000000b005339b80a30emr10019722ywh.10.1678235253159; Tue, 07
 Mar 2023 16:27:33 -0800 (PST)
Date:   Tue,  7 Mar 2023 16:27:14 -0800
Message-Id: <20230308002714.1755698-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Subject: [PATCH v1] perf test: Fix "PMU event table sanity" for NO_JEVENTS=1
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A table was renamed and needed to be renamed in the empty case.

Fixes: 62774db2a05d ("perf jevents: Generate metrics and events as separate tables")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/empty-pmu-events.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
index a938b74cf487..e74defb5284f 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -227,7 +227,7 @@ static const struct pmu_events_map pmu_events_map[] = {
 	},
 };
 
-static const struct pmu_event pme_test_soc_sys[] = {
+static const struct pmu_event pmu_events__test_soc_sys[] = {
 	{
 		.name = "sys_ddr_pmu.write_cycles",
 		.event = "event=0x2b",
@@ -258,8 +258,8 @@ struct pmu_sys_events {
 
 static const struct pmu_sys_events pmu_sys_event_tables[] = {
 	{
-		.table = { pme_test_soc_sys },
-		.name = "pme_test_soc_sys",
+		.table = { pmu_events__test_soc_sys },
+		.name = "pmu_events__test_soc_sys",
 	},
 	{
 		.table = { 0 }
-- 
2.40.0.rc0.216.gc4246ad0f0-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE1870A386
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 02:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjESX6g convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 19 May 2023 19:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjESX6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 19:58:35 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC3F1BD
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 16:58:33 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34JMOktb008078
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 16:58:32 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qpaujbf56-17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 16:58:32 -0700
Received: from twshared18891.17.frc2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 19 May 2023 16:58:28 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id 198041DE32C04; Fri, 19 May 2023 16:58:12 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <linux-kernel@vger.kernel.org>
CC:     <acme@redhat.com>, <jolsa@kernel.org>, <kernel-team@meta.com>,
        Song Liu <song@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH] perf: separate bpf_counter_list and bpf_filters
Date:   Fri, 19 May 2023 16:57:57 -0700
Message-ID: <20230519235757.3613719-1-song@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: n_wt1bOjAMChy9xpb3xwY-Wai45G1Q32
X-Proofpoint-ORIG-GUID: n_wt1bOjAMChy9xpb3xwY-Wai45G1Q32
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_17,2023-05-17_02,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

evsel uses a union for the two lists. This turned out to be error prone.
For example:

[root@quaco ~]# perf stat --bpf-prog 5246
Error: cpu-clock event does not have sample flags 66c660
failed to set filter "(null)" on event cpu-clock with 2 (No such file or
directory)

Fix this issue by separating the two lists.

Fixes: 56ec9457a4a2 ("perf bpf filter: Implement event sample filtering")
Signed-off-by: Song Liu <song@kernel.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/evsel.c | 1 +
 tools/perf/util/evsel.h | 6 ++----
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 2f5910b31fa9..c2dbb5647e75 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -282,6 +282,7 @@ void evsel__init(struct evsel *evsel,
 	evsel->bpf_fd	   = -1;
 	INIT_LIST_HEAD(&evsel->config_terms);
 	INIT_LIST_HEAD(&evsel->bpf_counter_list);
+	INIT_LIST_HEAD(&evsel->bpf_filters);
 	perf_evsel__object.init(evsel);
 	evsel->sample_size = __evsel__sample_size(attr->sample_type);
 	evsel__calc_id_pos(evsel);
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index df8928745fc6..0f54f28a69c2 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -151,10 +151,8 @@ struct evsel {
 	 */
 	struct bpf_counter_ops	*bpf_counter_ops;
 
-	union {
-		struct list_head	bpf_counter_list; /* for perf-stat -b */
-		struct list_head	bpf_filters; /* for perf-record --filter */
-	};
+	struct list_head	bpf_counter_list; /* for perf-stat -b */
+	struct list_head	bpf_filters; /* for perf-record --filter */
 
 	/* for perf-stat --use-bpf */
 	int			bperf_leader_prog_fd;
-- 
2.34.1


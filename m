Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7900E64A477
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 16:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbiLLPzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 10:55:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbiLLPzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 10:55:43 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0CC5064FA;
        Mon, 12 Dec 2022 07:55:43 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D77B2F4;
        Mon, 12 Dec 2022 07:56:23 -0800 (PST)
Received: from e126815.warwick.arm.com (e126815.arm.com [10.32.32.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4BBAA3F71E;
        Mon, 12 Dec 2022 07:55:40 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org
Cc:     Al.Grant@arm.com, James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        coresight@lists.linaro.org
Subject: [PATCH 1/5] perf: cs-etm: Print unknown header version as an error
Date:   Mon, 12 Dec 2022 15:55:09 +0000
Message-Id: <20221212155513.2259623-2-james.clark@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221212155513.2259623-1-james.clark@arm.com>
References: <20221212155513.2259623-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an error rather than just for the raw trace dump so always print
it as an error. Also remove the duplicate header version check.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/cs-etm.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 16db965ac995..aeb1e30888db 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -2623,14 +2623,7 @@ static void cs_etm__print_auxtrace_info(__u64 *val, int num)
 {
 	int i, cpu = 0, version, err;
 
-	/* bail out early on bad header version */
 	version = val[0];
-	if (version > CS_HEADER_CURRENT_VERSION) {
-		/* failure.. return */
-		fprintf(stdout, "	Unknown Header Version = %x, ", version);
-		fprintf(stdout, "Version supported <= %x\n", CS_HEADER_CURRENT_VERSION);
-		return;
-	}
 
 	for (i = 0; i < CS_HEADER_VERSION_MAX; i++)
 		fprintf(stdout, cs_etm_global_header_fmts[i], val[i]);
@@ -2916,9 +2909,8 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 	/* Look for version of the header */
 	hdr_version = ptr[0];
 	if (hdr_version > CS_HEADER_CURRENT_VERSION) {
-		/* print routine will print an error on bad version */
-		if (dump_trace)
-			cs_etm__print_auxtrace_info(auxtrace_info->priv, 0);
+		pr_err("\nCS ETM Trace: Unknown Header Version = %#" PRIx64, hdr_version);
+		pr_err(", version supported <= %x\n", CS_HEADER_CURRENT_VERSION);
 		return -EINVAL;
 	}
 
-- 
2.25.1


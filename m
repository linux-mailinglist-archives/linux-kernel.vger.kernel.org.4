Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FB564A47D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 16:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbiLLP4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 10:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232649AbiLLP4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 10:56:02 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1116213EB1;
        Mon, 12 Dec 2022 07:55:56 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 407CE15BF;
        Mon, 12 Dec 2022 07:56:37 -0800 (PST)
Received: from e126815.warwick.arm.com (e126815.arm.com [10.32.32.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1A1C93F71E;
        Mon, 12 Dec 2022 07:55:53 -0800 (PST)
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
Subject: [PATCH 5/5] perf: cs-etm: Print auxtrace info even if OpenCSD isn't linked
Date:   Mon, 12 Dec 2022 15:55:13 +0000
Message-Id: <20221212155513.2259623-6-james.clark@arm.com>
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

Printing the info doesn't have any dependency on OpenCSD, and neither
does recording Coresight data. Because it's sometimes useful to look at
the info for debugging, it makes sense to be able to see it on the same
platform that the recording was made on.

So pull the auxtrace info printing parts into a new file that is always
compiled into Perf.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/Build         |   1 +
 tools/perf/util/cs-etm-base.c | 174 ++++++++++++++++++++++++++++++++++
 tools/perf/util/cs-etm.c      | 170 ++-------------------------------
 tools/perf/util/cs-etm.h      |  12 ++-
 4 files changed, 191 insertions(+), 166 deletions(-)
 create mode 100644 tools/perf/util/cs-etm-base.c

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index ab37f588ee8b..1193b207ef7d 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -125,6 +125,7 @@ ifdef CONFIG_LIBOPENCSD
 perf-$(CONFIG_AUXTRACE) += cs-etm.o
 perf-$(CONFIG_AUXTRACE) += cs-etm-decoder/
 endif
+perf-$(CONFIG_AUXTRACE) += cs-etm-base.o
 
 perf-y += parse-branch-options.o
 perf-y += dump-insn.o
diff --git a/tools/perf/util/cs-etm-base.c b/tools/perf/util/cs-etm-base.c
new file mode 100644
index 000000000000..597542410854
--- /dev/null
+++ b/tools/perf/util/cs-etm-base.c
@@ -0,0 +1,174 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * File for any parts of the Coresight decoding that don't require
+ * OpenCSD.
+ */
+
+#include <errno.h>
+#include <inttypes.h>
+
+#include "cs-etm.h"
+
+static const char * const cs_etm_global_header_fmts[] = {
+	[CS_HEADER_VERSION]	= "	Header version		       %llx\n",
+	[CS_PMU_TYPE_CPUS]	= "	PMU type/num cpus	       %llx\n",
+	[CS_ETM_SNAPSHOT]	= "	Snapshot		       %llx\n",
+};
+
+static const char * const cs_etm_priv_fmts[] = {
+	[CS_ETM_MAGIC]		= "	Magic number		       %llx\n",
+	[CS_ETM_CPU]		= "	CPU			       %lld\n",
+	[CS_ETM_NR_TRC_PARAMS]	= "	NR_TRC_PARAMS		       %llx\n",
+	[CS_ETM_ETMCR]		= "	ETMCR			       %llx\n",
+	[CS_ETM_ETMTRACEIDR]	= "	ETMTRACEIDR		       %llx\n",
+	[CS_ETM_ETMCCER]	= "	ETMCCER			       %llx\n",
+	[CS_ETM_ETMIDR]		= "	ETMIDR			       %llx\n",
+};
+
+static const char * const cs_etmv4_priv_fmts[] = {
+	[CS_ETM_MAGIC]		= "	Magic number		       %llx\n",
+	[CS_ETM_CPU]		= "	CPU			       %lld\n",
+	[CS_ETM_NR_TRC_PARAMS]	= "	NR_TRC_PARAMS		       %llx\n",
+	[CS_ETMV4_TRCCONFIGR]	= "	TRCCONFIGR		       %llx\n",
+	[CS_ETMV4_TRCTRACEIDR]	= "	TRCTRACEIDR		       %llx\n",
+	[CS_ETMV4_TRCIDR0]	= "	TRCIDR0			       %llx\n",
+	[CS_ETMV4_TRCIDR1]	= "	TRCIDR1			       %llx\n",
+	[CS_ETMV4_TRCIDR2]	= "	TRCIDR2			       %llx\n",
+	[CS_ETMV4_TRCIDR8]	= "	TRCIDR8			       %llx\n",
+	[CS_ETMV4_TRCAUTHSTATUS] = "	TRCAUTHSTATUS		       %llx\n",
+	[CS_ETE_TRCDEVARCH]	= "	TRCDEVARCH                     %llx\n"
+};
+
+static const char * const param_unk_fmt =
+	"	Unknown parameter [%d]	       %"PRIx64"\n";
+static const char * const magic_unk_fmt =
+	"	Magic number Unknown	       %"PRIx64"\n";
+
+static int cs_etm__print_cpu_metadata_v0(u64 *val, int *offset)
+{
+	int i = *offset, j, nr_params = 0, fmt_offset;
+	u64 magic;
+
+	/* check magic value */
+	magic = val[i + CS_ETM_MAGIC];
+	if ((magic != __perf_cs_etmv3_magic) &&
+	    (magic != __perf_cs_etmv4_magic)) {
+		/* failure - note bad magic value */
+		fprintf(stdout, magic_unk_fmt, magic);
+		return -EINVAL;
+	}
+
+	/* print common header block */
+	fprintf(stdout, cs_etm_priv_fmts[CS_ETM_MAGIC], val[i++]);
+	fprintf(stdout, cs_etm_priv_fmts[CS_ETM_CPU], val[i++]);
+
+	if (magic == __perf_cs_etmv3_magic) {
+		nr_params = CS_ETM_NR_TRC_PARAMS_V0;
+		fmt_offset = CS_ETM_ETMCR;
+		/* after common block, offset format index past NR_PARAMS */
+		for (j = fmt_offset; j < nr_params + fmt_offset; j++, i++)
+			fprintf(stdout, cs_etm_priv_fmts[j], val[i]);
+	} else if (magic == __perf_cs_etmv4_magic) {
+		nr_params = CS_ETMV4_NR_TRC_PARAMS_V0;
+		fmt_offset = CS_ETMV4_TRCCONFIGR;
+		/* after common block, offset format index past NR_PARAMS */
+		for (j = fmt_offset; j < nr_params + fmt_offset; j++, i++)
+			fprintf(stdout, cs_etmv4_priv_fmts[j], val[i]);
+	}
+	*offset = i;
+	return 0;
+}
+
+static int cs_etm__print_cpu_metadata_v1(u64 *val, int *offset)
+{
+	int i = *offset, j, total_params = 0;
+	u64 magic;
+
+	magic = val[i + CS_ETM_MAGIC];
+	/* total params to print is NR_PARAMS + common block size for v1 */
+	total_params = val[i + CS_ETM_NR_TRC_PARAMS] + CS_ETM_COMMON_BLK_MAX_V1;
+
+	if (magic == __perf_cs_etmv3_magic) {
+		for (j = 0; j < total_params; j++, i++) {
+			/* if newer record - could be excess params */
+			if (j >= CS_ETM_PRIV_MAX)
+				fprintf(stdout, param_unk_fmt, j, val[i]);
+			else
+				fprintf(stdout, cs_etm_priv_fmts[j], val[i]);
+		}
+	} else if (magic == __perf_cs_etmv4_magic || magic == __perf_cs_ete_magic) {
+		/*
+		 * ETE and ETMv4 can be printed in the same block because the number of parameters
+		 * is saved and they share the list of parameter names. ETE is also only supported
+		 * in V1 files.
+		 */
+		for (j = 0; j < total_params; j++, i++) {
+			/* if newer record - could be excess params */
+			if (j >= CS_ETE_PRIV_MAX)
+				fprintf(stdout, param_unk_fmt, j, val[i]);
+			else
+				fprintf(stdout, cs_etmv4_priv_fmts[j], val[i]);
+		}
+	} else {
+		/* failure - note bad magic value and error out */
+		fprintf(stdout, magic_unk_fmt, magic);
+		return -EINVAL;
+	}
+	*offset = i;
+	return 0;
+}
+
+static void cs_etm__print_auxtrace_info(u64 *val, int num)
+{
+	int i, cpu = 0, version, err;
+
+	version = val[0];
+
+	for (i = 0; i < CS_HEADER_VERSION_MAX; i++)
+		fprintf(stdout, cs_etm_global_header_fmts[i], val[i]);
+
+	for (i = CS_HEADER_VERSION_MAX; cpu < num; cpu++) {
+		if (version == 0)
+			err = cs_etm__print_cpu_metadata_v0(val, &i);
+		else if (version == 1)
+			err = cs_etm__print_cpu_metadata_v1(val, &i);
+		if (err)
+			return;
+	}
+}
+
+/*
+ * Do some basic checks and print the auxtrace info header before calling
+ * into cs_etm__process_auxtrace_info_full() which requires OpenCSD to be
+ * linked in. This allows some basic debugging if OpenCSD is missing.
+ */
+int cs_etm__process_auxtrace_info(union perf_event *event,
+				  struct perf_session *session)
+{
+	struct perf_record_auxtrace_info *auxtrace_info = &event->auxtrace_info;
+	int event_header_size = sizeof(struct perf_event_header);
+	int num_cpu;
+	u64 *ptr = NULL;
+	u64 hdr_version;
+
+	if (auxtrace_info->header.size < (event_header_size + INFO_HEADER_SIZE))
+		return -EINVAL;
+
+	/* First the global part */
+	ptr = (u64 *) auxtrace_info->priv;
+
+	/* Look for version of the header */
+	hdr_version = ptr[0];
+	if (hdr_version > CS_HEADER_CURRENT_VERSION) {
+		pr_err("\nCS ETM Trace: Unknown Header Version = %#" PRIx64, hdr_version);
+		pr_err(", version supported <= %x\n", CS_HEADER_CURRENT_VERSION);
+		return -EINVAL;
+	}
+
+	if (dump_trace) {
+		num_cpu = ptr[CS_PMU_TYPE_CPUS] & 0xffffffff;
+		cs_etm__print_auxtrace_info(ptr, num_cpu);
+	}
+
+	return cs_etm__process_auxtrace_info_full(event, session);
+}
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index ab30591a6c6a..33303d03c2fa 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -2510,134 +2510,6 @@ static bool cs_etm__is_timeless_decoding(struct cs_etm_auxtrace *etm)
 	return timeless_decoding;
 }
 
-static const char * const cs_etm_global_header_fmts[] = {
-	[CS_HEADER_VERSION]	= "	Header version		       %llx\n",
-	[CS_PMU_TYPE_CPUS]	= "	PMU type/num cpus	       %llx\n",
-	[CS_ETM_SNAPSHOT]	= "	Snapshot		       %llx\n",
-};
-
-static const char * const cs_etm_priv_fmts[] = {
-	[CS_ETM_MAGIC]		= "	Magic number		       %llx\n",
-	[CS_ETM_CPU]		= "	CPU			       %lld\n",
-	[CS_ETM_NR_TRC_PARAMS]	= "	NR_TRC_PARAMS		       %llx\n",
-	[CS_ETM_ETMCR]		= "	ETMCR			       %llx\n",
-	[CS_ETM_ETMTRACEIDR]	= "	ETMTRACEIDR		       %llx\n",
-	[CS_ETM_ETMCCER]	= "	ETMCCER			       %llx\n",
-	[CS_ETM_ETMIDR]		= "	ETMIDR			       %llx\n",
-};
-
-static const char * const cs_etmv4_priv_fmts[] = {
-	[CS_ETM_MAGIC]		= "	Magic number		       %llx\n",
-	[CS_ETM_CPU]		= "	CPU			       %lld\n",
-	[CS_ETM_NR_TRC_PARAMS]	= "	NR_TRC_PARAMS		       %llx\n",
-	[CS_ETMV4_TRCCONFIGR]	= "	TRCCONFIGR		       %llx\n",
-	[CS_ETMV4_TRCTRACEIDR]	= "	TRCTRACEIDR		       %llx\n",
-	[CS_ETMV4_TRCIDR0]	= "	TRCIDR0			       %llx\n",
-	[CS_ETMV4_TRCIDR1]	= "	TRCIDR1			       %llx\n",
-	[CS_ETMV4_TRCIDR2]	= "	TRCIDR2			       %llx\n",
-	[CS_ETMV4_TRCIDR8]	= "	TRCIDR8			       %llx\n",
-	[CS_ETMV4_TRCAUTHSTATUS] = "	TRCAUTHSTATUS		       %llx\n",
-	[CS_ETE_TRCDEVARCH]	= "	TRCDEVARCH                     %llx\n"
-};
-
-static const char * const param_unk_fmt =
-	"	Unknown parameter [%d]	       %"PRIx64"\n";
-static const char * const magic_unk_fmt =
-	"	Magic number Unknown	       %"PRIx64"\n";
-
-static int cs_etm__print_cpu_metadata_v0(u64 *val, int *offset)
-{
-	int i = *offset, j, nr_params = 0, fmt_offset;
-	u64 magic;
-
-	/* check magic value */
-	magic = val[i + CS_ETM_MAGIC];
-	if ((magic != __perf_cs_etmv3_magic) &&
-	    (magic != __perf_cs_etmv4_magic)) {
-		/* failure - note bad magic value */
-		fprintf(stdout, magic_unk_fmt, magic);
-		return -EINVAL;
-	}
-
-	/* print common header block */
-	fprintf(stdout, cs_etm_priv_fmts[CS_ETM_MAGIC], val[i++]);
-	fprintf(stdout, cs_etm_priv_fmts[CS_ETM_CPU], val[i++]);
-
-	if (magic == __perf_cs_etmv3_magic) {
-		nr_params = CS_ETM_NR_TRC_PARAMS_V0;
-		fmt_offset = CS_ETM_ETMCR;
-		/* after common block, offset format index past NR_PARAMS */
-		for (j = fmt_offset; j < nr_params + fmt_offset; j++, i++)
-			fprintf(stdout, cs_etm_priv_fmts[j], val[i]);
-	} else if (magic == __perf_cs_etmv4_magic) {
-		nr_params = CS_ETMV4_NR_TRC_PARAMS_V0;
-		fmt_offset = CS_ETMV4_TRCCONFIGR;
-		/* after common block, offset format index past NR_PARAMS */
-		for (j = fmt_offset; j < nr_params + fmt_offset; j++, i++)
-			fprintf(stdout, cs_etmv4_priv_fmts[j], val[i]);
-	}
-	*offset = i;
-	return 0;
-}
-
-static int cs_etm__print_cpu_metadata_v1(u64 *val, int *offset)
-{
-	int i = *offset, j, total_params = 0;
-	u64 magic;
-
-	magic = val[i + CS_ETM_MAGIC];
-	/* total params to print is NR_PARAMS + common block size for v1 */
-	total_params = val[i + CS_ETM_NR_TRC_PARAMS] + CS_ETM_COMMON_BLK_MAX_V1;
-
-	if (magic == __perf_cs_etmv3_magic) {
-		for (j = 0; j < total_params; j++, i++) {
-			/* if newer record - could be excess params */
-			if (j >= CS_ETM_PRIV_MAX)
-				fprintf(stdout, param_unk_fmt, j, val[i]);
-			else
-				fprintf(stdout, cs_etm_priv_fmts[j], val[i]);
-		}
-	} else if (magic == __perf_cs_etmv4_magic || magic == __perf_cs_ete_magic) {
-		/*
-		 * ETE and ETMv4 can be printed in the same block because the number of parameters
-		 * is saved and they share the list of parameter names. ETE is also only supported
-		 * in V1 files.
-		 */
-		for (j = 0; j < total_params; j++, i++) {
-			/* if newer record - could be excess params */
-			if (j >= CS_ETE_PRIV_MAX)
-				fprintf(stdout, param_unk_fmt, j, val[i]);
-			else
-				fprintf(stdout, cs_etmv4_priv_fmts[j], val[i]);
-		}
-	} else {
-		/* failure - note bad magic value and error out */
-		fprintf(stdout, magic_unk_fmt, magic);
-		return -EINVAL;
-	}
-	*offset = i;
-	return 0;
-}
-
-static void cs_etm__print_auxtrace_info(u64 *val, int num)
-{
-	int i, cpu = 0, version, err;
-
-	version = val[0];
-
-	for (i = 0; i < CS_HEADER_VERSION_MAX; i++)
-		fprintf(stdout, cs_etm_global_header_fmts[i], val[i]);
-
-	for (i = CS_HEADER_VERSION_MAX; cpu < num; cpu++) {
-		if (version == 0)
-			err = cs_etm__print_cpu_metadata_v0(val, &i);
-		else if (version == 1)
-			err = cs_etm__print_cpu_metadata_v1(val, &i);
-		if (err)
-			return;
-	}
-}
-
 /*
  * Read a single cpu parameter block from the auxtrace_info priv block.
  *
@@ -2874,15 +2746,13 @@ static int cs_etm__queue_aux_records(struct perf_session *session)
 	return 0;
 }
 
-int cs_etm__process_auxtrace_info(union perf_event *event,
-				  struct perf_session *session)
+int cs_etm__process_auxtrace_info_full(union perf_event *event,
+				       struct perf_session *session)
 {
 	struct perf_record_auxtrace_info *auxtrace_info = &event->auxtrace_info;
 	struct cs_etm_auxtrace *etm = NULL;
 	struct int_node *inode;
-	unsigned int pmu_type;
 	int event_header_size = sizeof(struct perf_event_header);
-	int info_header_size;
 	int total_size = auxtrace_info->header.size;
 	int priv_size = 0;
 	int num_cpu, trcidr_idx;
@@ -2890,36 +2760,6 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 	int i, j;
 	u64 *ptr = NULL;
 	u64 **metadata = NULL;
-	u64 hdr_version;
-
-	/*
-	 * sizeof(auxtrace_info_event::type) +
-	 * sizeof(auxtrace_info_event::reserved) == 8
-	 */
-	info_header_size = 8;
-
-	if (total_size < (event_header_size + info_header_size))
-		return -EINVAL;
-
-	priv_size = total_size - event_header_size - info_header_size;
-
-	/* First the global part */
-	ptr = (u64 *) auxtrace_info->priv;
-
-	/* Look for version of the header */
-	hdr_version = ptr[0];
-	if (hdr_version > CS_HEADER_CURRENT_VERSION) {
-		pr_err("\nCS ETM Trace: Unknown Header Version = %#" PRIx64, hdr_version);
-		pr_err(", version supported <= %x\n", CS_HEADER_CURRENT_VERSION);
-		return -EINVAL;
-	}
-
-	num_cpu = ptr[CS_PMU_TYPE_CPUS] & 0xffffffff;
-	pmu_type = (unsigned int) ((ptr[CS_PMU_TYPE_CPUS] >> 32) &
-				    0xffffffff);
-
-	if (dump_trace)
-		cs_etm__print_auxtrace_info(ptr, num_cpu);
 
 	/*
 	 * Create an RB tree for traceID-metadata tuple.  Since the conversion
@@ -2930,6 +2770,9 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 	if (!traceid_list)
 		return -ENOMEM;
 
+	/* First the global part */
+	ptr = (u64 *) auxtrace_info->priv;
+	num_cpu = ptr[CS_PMU_TYPE_CPUS] & 0xffffffff;
 	metadata = zalloc(sizeof(*metadata) * num_cpu);
 	if (!metadata) {
 		err = -ENOMEM;
@@ -3008,6 +2851,7 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 	 * The following tests if the correct number of double words was
 	 * present in the auxtrace info section.
 	 */
+	priv_size = total_size - event_header_size - INFO_HEADER_SIZE;
 	if (i * 8 != priv_size) {
 		err = -EINVAL;
 		goto err_free_metadata;
@@ -3036,7 +2880,7 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 	etm->machine = &session->machines.host;
 
 	etm->num_cpu = num_cpu;
-	etm->pmu_type = pmu_type;
+	etm->pmu_type = (unsigned int) ((ptr[CS_PMU_TYPE_CPUS] >> 32) & 0xffffffff);
 	etm->snapshot_mode = (ptr[CS_ETM_SNAPSHOT] != 0);
 	etm->metadata = metadata;
 	etm->auxtrace_type = auxtrace_info->type;
diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index 401f74be98d6..5da50d5dae6b 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -202,9 +202,13 @@ struct cs_etm_packet_queue {
 #define CS_ETMV4_PRIV_SIZE (CS_ETMV4_PRIV_MAX * sizeof(u64))
 #define CS_ETE_PRIV_SIZE (CS_ETE_PRIV_MAX * sizeof(u64))
 
-#ifdef HAVE_CSTRACE_SUPPORT
+#define INFO_HEADER_SIZE (sizeof(((struct perf_record_auxtrace_info *)0)->type) + \
+			  sizeof(((struct perf_record_auxtrace_info *)0)->reserved__))
+
 int cs_etm__process_auxtrace_info(union perf_event *event,
 				  struct perf_session *session);
+
+#ifdef HAVE_CSTRACE_SUPPORT
 int cs_etm__get_cpu(u8 trace_chan_id, int *cpu);
 int cs_etm__get_pid_fmt(u8 trace_chan_id, u64 *pid_fmt);
 int cs_etm__etmq_set_tid(struct cs_etm_queue *etmq,
@@ -214,10 +218,12 @@ void cs_etm__etmq_set_traceid_queue_timestamp(struct cs_etm_queue *etmq,
 					      u8 trace_chan_id);
 struct cs_etm_packet_queue
 *cs_etm__etmq_get_packet_queue(struct cs_etm_queue *etmq, u8 trace_chan_id);
+int cs_etm__process_auxtrace_info_full(union perf_event *event __maybe_unused,
+				       struct perf_session *session __maybe_unused);
 #else
 static inline int
-cs_etm__process_auxtrace_info(union perf_event *event __maybe_unused,
-			      struct perf_session *session __maybe_unused)
+cs_etm__process_auxtrace_info_full(union perf_event *event __maybe_unused,
+				   struct perf_session *session __maybe_unused)
 {
 	pr_err("\nCS ETM Trace: OpenCSD is not linked in, please recompile with CORESIGHT=1\n");
 	return -1;
-- 
2.25.1


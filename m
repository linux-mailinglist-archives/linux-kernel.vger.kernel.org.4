Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031B25FF2BE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 19:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbiJNRKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 13:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbiJNRJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 13:09:57 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002361E730;
        Fri, 14 Oct 2022 10:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665767386; x=1697303386;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BfjeSY7KNgsN+P4GwvYyJZrJWkkSdPm7/zXQBtNNFk4=;
  b=U0IlDhdyvZhbsV/LC4L/j1/BucB5//BxJRMKM2PN19++Qq8qdTMpVeIu
   T5THxKIz3dWGHEX5lpO7pfdELg/9wZc6jV/O195D5TXsAcWGPvXOLNFah
   aYaXzb1+ayIEW0iEafBaTEDBg+m5L9+PMUEA5pXJxNJDaIKRCzoRizWRR
   DjfErPmmxPgx4ghOMZ4Zd+t1btcBBqR6pc5zrLhG0irIkxvGOJ2AlBfw0
   d3EBGQETrbfF1I+ZdrKIS/XZZHe7kwA09cff9abixoHQEqnfbascTY8B9
   p1dphRA8jLZp11OgC7+iJrfqHyjLIrAVd46Z7U3Hl2ISsa5O8Ne1EfoIW
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="303041997"
X-IronPort-AV: E=Sophos;i="5.95,184,1661842800"; 
   d="scan'208";a="303041997"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 10:09:43 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="696377013"
X-IronPort-AV: E=Sophos;i="5.95,184,1661842800"; 
   d="scan'208";a="696377013"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.43.79])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 10:09:37 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 5/7] perf test: test_intel_pt.sh: Add jitdump test
Date:   Fri, 14 Oct 2022 20:09:03 +0300
Message-Id: <20221014170905.64069-6-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221014170905.64069-1-adrian.hunter@intel.com>
References: <20221014170905.64069-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a test for decoding self-modifying code using a jitdump file.

The test creates a workload that uses self-modifying code and generates its
own jitdump file.  The result is processed with perf inject --jit and
checked for decoding errors.

Note the test will fail without patch "perf inject: Fix GEN_ELF_TEXT_OFFSET
for jit" applied.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/tests/shell/test_intel_pt.sh | 162 ++++++++++++++++++++++++
 1 file changed, 162 insertions(+)

diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/shell/test_intel_pt.sh
index 79dde57b561d..e0bf75981b9c 100755
--- a/tools/perf/tests/shell/test_intel_pt.sh
+++ b/tools/perf/tests/shell/test_intel_pt.sh
@@ -22,6 +22,7 @@ outfile="${temp_dir}/test-out.txt"
 errfile="${temp_dir}/test-err.txt"
 workload="${temp_dir}/workload"
 awkscript="${temp_dir}/awkscript"
+jitdump_workload="${temp_dir}/jitdump_workload"
 
 cleanup()
 {
@@ -50,6 +51,13 @@ perf_record_no_decode()
 	perf record -B -N --no-bpf-event "$@"
 }
 
+# perf record for testing should not need BPF events
+perf_record_no_bpf()
+{
+	# Options for no BPF events
+	perf record --no-bpf-event "$@"
+}
+
 have_workload=false
 cat << _end_of_file_ | /usr/bin/cc -o "${workload}" -xc - -pthread && have_workload=true
 #include <time.h>
@@ -269,6 +277,159 @@ test_per_thread()
 	return 0
 }
 
+test_jitdump()
+{
+	echo "--- Test tracing self-modifying code that uses jitdump ---"
+
+	script_path=$(realpath "$0")
+	script_dir=$(dirname "$script_path")
+	jitdump_incl_dir="${script_dir}/../../util"
+	jitdump_h="${jitdump_incl_dir}/jitdump.h"
+
+	if [ ! -e "${jitdump_h}" ] ; then
+		echo "SKIP: Include file jitdump.h not found"
+		return 2
+	fi
+
+	if [ -z "${have_jitdump_workload}" ] ; then
+		have_jitdump_workload=false
+		# Create a workload that uses self-modifying code and generates its own jitdump file
+		cat <<- "_end_of_file_" | /usr/bin/cc -o "${jitdump_workload}" -I "${jitdump_incl_dir}" -xc - -pthread && have_jitdump_workload=true
+		#define _GNU_SOURCE
+		#include <sys/mman.h>
+		#include <sys/types.h>
+		#include <stddef.h>
+		#include <stdio.h>
+		#include <stdint.h>
+		#include <unistd.h>
+		#include <string.h>
+
+		#include "jitdump.h"
+
+		#define CHK_BYTE 0x5a
+
+		static inline uint64_t rdtsc(void)
+		{
+			unsigned int low, high;
+
+			asm volatile("rdtsc" : "=a" (low), "=d" (high));
+
+			return low | ((uint64_t)high) << 32;
+		}
+
+		static FILE *open_jitdump(void)
+		{
+			struct jitheader header = {
+				.magic      = JITHEADER_MAGIC,
+				.version    = JITHEADER_VERSION,
+				.total_size = sizeof(header),
+				.pid        = getpid(),
+				.timestamp  = rdtsc(),
+				.flags      = JITDUMP_FLAGS_ARCH_TIMESTAMP,
+			};
+			char filename[256];
+			FILE *f;
+			void *m;
+
+			snprintf(filename, sizeof(filename), "jit-%d.dump", getpid());
+			f = fopen(filename, "w+");
+			if (!f)
+				goto err;
+			/* Create an MMAP event for the jitdump file. That is how perf tool finds it. */
+			m = mmap(0, 4096, PROT_READ | PROT_EXEC, MAP_PRIVATE, fileno(f), 0);
+			if (m == MAP_FAILED)
+				goto err_close;
+			munmap(m, 4096);
+			if (fwrite(&header,sizeof(header),1,f) != 1)
+				goto err_close;
+			return f;
+
+		err_close:
+			fclose(f);
+		err:
+			return NULL;
+		}
+
+		static int write_jitdump(FILE *f, void *addr, const uint8_t *dat, size_t sz, uint64_t *idx)
+		{
+			struct jr_code_load rec = {
+				.p.id          = JIT_CODE_LOAD,
+				.p.total_size  = sizeof(rec) + sz,
+				.p.timestamp   = rdtsc(),
+				.pid	       = getpid(),
+				.tid	       = gettid(),
+				.vma           = (unsigned long)addr,
+				.code_addr     = (unsigned long)addr,
+				.code_size     = sz,
+				.code_index    = ++*idx,
+			};
+
+			if (fwrite(&rec,sizeof(rec),1,f) != 1 ||
+			fwrite(dat, sz, 1, f) != 1)
+				return -1;
+			return 0;
+		}
+
+		static void close_jitdump(FILE *f)
+		{
+			fclose(f);
+		}
+
+		int main()
+		{
+			/* Get a memory page to store executable code */
+			void *addr = mmap(0, 4096, PROT_WRITE | PROT_EXEC, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+			/* Code to execute: mov CHK_BYTE, %eax ; ret */
+			uint8_t dat[] = {0xb8, CHK_BYTE, 0x00, 0x00, 0x00, 0xc3};
+			FILE *f = open_jitdump();
+			uint64_t idx = 0;
+			int ret = 1;
+
+			if (!f)
+				return 1;
+			/* Copy executable code to executable memory page */
+			memcpy(addr, dat, sizeof(dat));
+			/* Record it in the jitdump file */
+			if (write_jitdump(f, addr, dat, sizeof(dat), &idx))
+				goto out_close;
+			/* Call it */
+			ret = ((int (*)(void))addr)() - CHK_BYTE;
+		out_close:
+			close_jitdump(f);
+			return ret;
+		}
+		_end_of_file_
+	fi
+
+	if ! $have_jitdump_workload ; then
+		echo "SKIP: No jitdump workload"
+		return 2
+	fi
+
+	# Change to temp_dir so jitdump collateral files go there
+	cd "${temp_dir}"
+	perf_record_no_bpf -o "${tmpfile}" -e intel_pt//u "${jitdump_workload}"
+	perf inject -i "${tmpfile}" -o "${perfdatafile}" --jit
+	decode_br_cnt=$(perf script -i "${perfdatafile}" --itrace=b | wc -l)
+	# Note that overflow and lost errors are suppressed for the error count
+	decode_err_cnt=$(perf script -i "${perfdatafile}" --itrace=e-o-l | grep -ci error)
+	cd -
+	# Should be thousands of branches
+	if [ "${decode_br_cnt}" -lt 1000 ] ; then
+		echo "Decode failed, only ${decode_br_cnt} branches"
+		return 1
+	fi
+	# Should be no errors
+	if [ "${decode_err_cnt}" -ne 0 ] ; then
+		echo "Decode failed, ${decode_err_cnt} errors"
+		perf script -i "${perfdatafile}" --itrace=e-o-l
+		return 1
+	fi
+
+	echo OK
+	return 0
+}
+
 count_result()
 {
 	if [ "$1" -eq 2 ] ; then
@@ -286,6 +447,7 @@ ret=0
 test_system_wide_side_band		|| ret=$? ; count_result $ret ; ret=0
 test_per_thread "" ""			|| ret=$? ; count_result $ret ; ret=0
 test_per_thread "k" "(incl. kernel) "	|| ret=$? ; count_result $ret ; ret=0
+test_jitdump				|| ret=$? ; count_result $ret ; ret=0
 
 cleanup
 
-- 
2.25.1


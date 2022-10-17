Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814AE600F9B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 14:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbiJQM5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 08:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbiJQM5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 08:57:11 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669515E31F;
        Mon, 17 Oct 2022 05:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666011430; x=1697547430;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CAsm+JRYdkT6BEPXS744qkyuroCnDfGEdXUZ0TVxews=;
  b=KIOCjXEk625vA+vUzqEOS1+q2X549DrlNw745LA/jnRB+GqM65TYbElP
   oByjAqRTBefE832slDh6oxFRHw1PaPEQdvC5oUGT0kofEXJsr0atAXUFh
   Wd/lYCwhOJt44JHJwPQA5GjfV6dU4pCIaCGY8VwfcrbpFzsUaSx+WNPcd
   ur8cFAxsL3+MEXga0lH820irKnW5sNXLPkqWKtuSyr1wvlmlEa6XV45pV
   fpmyHd4f1QoncW9ta1utqKZXVq2JrNm4IC/hPszrvFswGlIbAL5PurlBr
   Hnpwda21RM8CsuUUNf06AQp72qFtcxaD6ERkGypeGVWowEgHxC2UGQVuX
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="303402996"
X-IronPort-AV: E=Sophos;i="5.95,191,1661842800"; 
   d="scan'208";a="303402996"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 05:57:09 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="957325706"
X-IronPort-AV: E=Sophos;i="5.95,191,1661842800"; 
   d="scan'208";a="957325706"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.44.19])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 05:57:07 -0700
Message-ID: <866b1317-d0cd-c730-8d32-e8885b1f45d7@intel.com>
Date:   Mon, 17 Oct 2022 15:57:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH 5/7] perf test: test_intel_pt.sh: Add jitdump test
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
References: <20221014170905.64069-1-adrian.hunter@intel.com>
 <20221014170905.64069-6-adrian.hunter@intel.com>
 <Y0mcWpc4KaeXpU+z@kernel.org>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <Y0mcWpc4KaeXpU+z@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/22 20:28, Arnaldo Carvalho de Melo wrote:
> Em Fri, Oct 14, 2022 at 08:09:03PM +0300, Adrian Hunter escreveu:
>> Add a test for decoding self-modifying code using a jitdump file.
>>
>> The test creates a workload that uses self-modifying code and generates its
>> own jitdump file.  The result is processed with perf inject --jit and
>> checked for decoding errors.
>>
>> Note the test will fail without patch "perf inject: Fix GEN_ELF_TEXT_OFFSET
>> for jit" applied.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>  tools/perf/tests/shell/test_intel_pt.sh | 162 ++++++++++++++++++++++++
>>  1 file changed, 162 insertions(+)
>>
>> diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/shell/test_intel_pt.sh
>> index 79dde57b561d..e0bf75981b9c 100755
>> --- a/tools/perf/tests/shell/test_intel_pt.sh
>> +++ b/tools/perf/tests/shell/test_intel_pt.sh
>> @@ -22,6 +22,7 @@ outfile="${temp_dir}/test-out.txt"
>>  errfile="${temp_dir}/test-err.txt"
>>  workload="${temp_dir}/workload"
>>  awkscript="${temp_dir}/awkscript"
>> +jitdump_workload="${temp_dir}/jitdump_workload"
>>  
>>  cleanup()
>>  {
>> @@ -50,6 +51,13 @@ perf_record_no_decode()
>>  	perf record -B -N --no-bpf-event "$@"
>>  }
>>  
>> +# perf record for testing should not need BPF events
>> +perf_record_no_bpf()
>> +{
>> +	# Options for no BPF events
>> +	perf record --no-bpf-event "$@"
>> +}
>> +
>>  have_workload=false
>>  cat << _end_of_file_ | /usr/bin/cc -o "${workload}" -xc - -pthread && have_workload=true
>>  #include <time.h>
>> @@ -269,6 +277,159 @@ test_per_thread()
>>  	return 0
>>  }
>>  
>> +test_jitdump()
>> +{
>> +	echo "--- Test tracing self-modifying code that uses jitdump ---"
>> +
>> +	script_path=$(realpath "$0")
>> +	script_dir=$(dirname "$script_path")
>> +	jitdump_incl_dir="${script_dir}/../../util"
>> +	jitdump_h="${jitdump_incl_dir}/jitdump.h"
> 
> So this requires one to test this being on the kernel (perf) sources
> dir? I think we should add this header to some 'perf test' directory to
> remove this requirement, ok?
> 

How about this:

From: Adrian Hunter <adrian.hunter@intel.com>
Date: Mon, 17 Oct 2022 15:14:25 +0300
Subject: [PATCH] perf test: test_intel_pt.sh: Install jitdump.h for use by
 tests

test_intel_pt.sh builds a workload for testing jitdump and the workload
includes file jitdump.h.

Currently, test_intel_pt.sh finds jitdump.h assuming the test is run in
the kernel source directory, and skips that test if it is not found.

To improve that situation, amend the build to install the jitdump.h file
in the test shell directory, and look there first, falling back to the
original way if that is not found.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Makefile.perf                |  1 +
 tools/perf/tests/shell/test_intel_pt.sh | 12 +++++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index a432e59afc42..c4ec66194465 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1013,6 +1013,7 @@ install-tests: all install-gtk
 		$(INSTALL) tests/attr/* -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/attr'; \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell'; \
 		$(INSTALL) tests/shell/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell'; \
+		$(INSTALL) util/jitdump.h -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell'; \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
 		$(INSTALL) tests/shell/lib/*.sh -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
 		$(INSTALL) tests/shell/lib/*.py -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/shell/test_intel_pt.sh
index 4c0aabbe33bd..3abf803f96b9 100755
--- a/tools/perf/tests/shell/test_intel_pt.sh
+++ b/tools/perf/tests/shell/test_intel_pt.sh
@@ -284,14 +284,20 @@ test_jitdump()
 
 	script_path=$(realpath "$0")
 	script_dir=$(dirname "$script_path")
-	jitdump_incl_dir="${script_dir}/../../util"
+	jitdump_incl_dir="${script_dir}"
 	jitdump_h="${jitdump_incl_dir}/jitdump.h"
 
 	if [ ! -e "${jitdump_h}" ] ; then
-		echo "SKIP: Include file jitdump.h not found"
-		return 2
+		jitdump_incl_dir="${script_dir}/../../util"
+		jitdump_h="${jitdump_incl_dir}/jitdump.h"
+		if [ ! -e "${jitdump_h}" ] ; then
+			echo "SKIP: Include file jitdump.h not found"
+			return 2
+		fi
 	fi
 
+	echo "Using include file: ${jitdump_h}"
+
 	if [ -z "${have_jitdump_workload}" ] ; then
 		have_jitdump_workload=false
 		# Create a workload that uses self-modifying code and generates its own jitdump file
-- 
2.25.1



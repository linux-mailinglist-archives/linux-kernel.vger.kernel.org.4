Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3626012A1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 17:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiJQPTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 11:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiJQPTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 11:19:32 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3A5B84E;
        Mon, 17 Oct 2022 08:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666019971; x=1697555971;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TowhcXWGpMPyFZ+TMyvVPZ+actA6yupwG3JPGkNFFes=;
  b=AYU2RrWzNFZO8LakzXAF7hgP4ZkSN+B50bW7PlQiqG8Uc3BrlFCKZuQC
   jes8SEHAGHAp0jF2b/Dzz44cNlIYmLcEB8ZasHKM9uaS7lsXjos9YgOGn
   vy2AbzeIO/WZIGHEWE7UspcrePLjZfa3PhmcOyfDgI0/Yr0iB3PvISwzl
   6CaehAtzPYzRaMBGd28N8nzqO3iatyI10KlKeEe2k0Lo2hQSJVBMKTWCO
   MC9O+tPx38/V6cRbRN9bN3LThABEHQk2tRWsF8kWq4HSq47XnAmOkTVG8
   MRMGw55FkGamXaQ9mizq9Hhqgb17ZGgw84rCtRtM3lAuK/XWso/WYGYSW
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="367849301"
X-IronPort-AV: E=Sophos;i="5.95,191,1661842800"; 
   d="scan'208";a="367849301"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 08:19:20 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="623258372"
X-IronPort-AV: E=Sophos;i="5.95,191,1661842800"; 
   d="scan'208";a="623258372"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.44.19])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 08:19:04 -0700
Message-ID: <e39f55e4-9a73-0c0a-0bf0-3ceb5359e310@intel.com>
Date:   Mon, 17 Oct 2022 12:35:41 +0300
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
 <866b1317-d0cd-c730-8d32-e8885b1f45d7@intel.com>
 <Y01cJoaB9q9iarhJ@kernel.org>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <Y01cJoaB9q9iarhJ@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/10/22 16:44, Arnaldo Carvalho de Melo wrote:
> Em Mon, Oct 17, 2022 at 03:57:03PM +0300, Adrian Hunter escreveu:
>> On 14/10/22 20:28, Arnaldo Carvalho de Melo wrote:
>>> Em Fri, Oct 14, 2022 at 08:09:03PM +0300, Adrian Hunter escreveu:
>>>> Add a test for decoding self-modifying code using a jitdump file.
>>>>
>>>> The test creates a workload that uses self-modifying code and generates its
>>>> own jitdump file.  The result is processed with perf inject --jit and
>>>> checked for decoding errors.
>>>>
>>>> Note the test will fail without patch "perf inject: Fix GEN_ELF_TEXT_OFFSET
>>>> for jit" applied.
>>>>
>>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>>>> ---
>>>>  tools/perf/tests/shell/test_intel_pt.sh | 162 ++++++++++++++++++++++++
>>>>  1 file changed, 162 insertions(+)
>>>>
>>>> diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/shell/test_intel_pt.sh
>>>> index 79dde57b561d..e0bf75981b9c 100755
>>>> --- a/tools/perf/tests/shell/test_intel_pt.sh
>>>> +++ b/tools/perf/tests/shell/test_intel_pt.sh
>>>> @@ -22,6 +22,7 @@ outfile="${temp_dir}/test-out.txt"
>>>>  errfile="${temp_dir}/test-err.txt"
>>>>  workload="${temp_dir}/workload"
>>>>  awkscript="${temp_dir}/awkscript"
>>>> +jitdump_workload="${temp_dir}/jitdump_workload"
>>>>  
>>>>  cleanup()
>>>>  {
>>>> @@ -50,6 +51,13 @@ perf_record_no_decode()
>>>>  	perf record -B -N --no-bpf-event "$@"
>>>>  }
>>>>  
>>>> +# perf record for testing should not need BPF events
>>>> +perf_record_no_bpf()
>>>> +{
>>>> +	# Options for no BPF events
>>>> +	perf record --no-bpf-event "$@"
>>>> +}
>>>> +
>>>>  have_workload=false
>>>>  cat << _end_of_file_ | /usr/bin/cc -o "${workload}" -xc - -pthread && have_workload=true
>>>>  #include <time.h>
>>>> @@ -269,6 +277,159 @@ test_per_thread()
>>>>  	return 0
>>>>  }
>>>>  
>>>> +test_jitdump()
>>>> +{
>>>> +	echo "--- Test tracing self-modifying code that uses jitdump ---"
>>>> +
>>>> +	script_path=$(realpath "$0")
>>>> +	script_dir=$(dirname "$script_path")
>>>> +	jitdump_incl_dir="${script_dir}/../../util"
>>>> +	jitdump_h="${jitdump_incl_dir}/jitdump.h"
>>>
>>> So this requires one to test this being on the kernel (perf) sources
>>> dir? I think we should add this header to some 'perf test' directory to
>>> remove this requirement, ok?
>>>
>>
>> How about this:
> 
> Better, but see below
>  
>> From: Adrian Hunter <adrian.hunter@intel.com>
>> Date: Mon, 17 Oct 2022 15:14:25 +0300
>> Subject: [PATCH] perf test: test_intel_pt.sh: Install jitdump.h for use by
>>  tests
>>
>> test_intel_pt.sh builds a workload for testing jitdump and the workload
>> includes file jitdump.h.
>>
>> Currently, test_intel_pt.sh finds jitdump.h assuming the test is run in
>> the kernel source directory, and skips that test if it is not found.
>>
>> To improve that situation, amend the build to install the jitdump.h file
>> in the test shell directory, and look there first, falling back to the
>> original way if that is not found.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>  tools/perf/Makefile.perf                |  1 +
>>  tools/perf/tests/shell/test_intel_pt.sh | 12 +++++++++---
>>  2 files changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
>> index a432e59afc42..c4ec66194465 100644
>> --- a/tools/perf/Makefile.perf
>> +++ b/tools/perf/Makefile.perf
>> @@ -1013,6 +1013,7 @@ install-tests: all install-gtk
>>  		$(INSTALL) tests/attr/* -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/attr'; \
>>  		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell'; \
>>  		$(INSTALL) tests/shell/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell'; \
>> +		$(INSTALL) util/jitdump.h -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell'; \
>>  		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
>>  		$(INSTALL) tests/shell/lib/*.sh -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
>>  		$(INSTALL) tests/shell/lib/*.py -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
>> diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/shell/test_intel_pt.sh
>> index 4c0aabbe33bd..3abf803f96b9 100755
>> --- a/tools/perf/tests/shell/test_intel_pt.sh
>> +++ b/tools/perf/tests/shell/test_intel_pt.sh
>> @@ -284,14 +284,20 @@ test_jitdump()
>>  
>>  	script_path=$(realpath "$0")
>>  	script_dir=$(dirname "$script_path")
>> -	jitdump_incl_dir="${script_dir}/../../util"
>> +	jitdump_incl_dir="${script_dir}"
>>  	jitdump_h="${jitdump_incl_dir}/jitdump.h"
>>  
>>  	if [ ! -e "${jitdump_h}" ] ; then
>> -		echo "SKIP: Include file jitdump.h not found"
>> -		return 2
>> +		jitdump_incl_dir="${script_dir}/../../util"
>> +		jitdump_h="${jitdump_incl_dir}/jitdump.h"
>> +		if [ ! -e "${jitdump_h}" ] ; then
>> +			echo "SKIP: Include file jitdump.h not found"
>> +			return 2
>> +		fi
>>  	fi
>>  
>> +	echo "Using include file: ${jitdump_h}"
> 
> Shouldn't this appear only with -v?

Yes, but shell scripts do not process -v.  Instead all output is
suppressed by perf test unless -v is used.  So it should be OK?

> 
> - Arnaldo
> 
>> +
>>  	if [ -z "${have_jitdump_workload}" ] ; then
>>  		have_jitdump_workload=false
>>  		# Create a workload that uses self-modifying code and generates its own jitdump file


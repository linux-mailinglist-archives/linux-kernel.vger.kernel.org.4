Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F052C5B82DE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 10:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiINIZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 04:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiINIZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 04:25:16 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9DD21815;
        Wed, 14 Sep 2022 01:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663143914; x=1694679914;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/MrEuffiTlBloWoItG/YCkossJlWMHolvgOHQGsREGM=;
  b=M2+dM7mSIZz6/HCy8XQfZu8urujco8oLuwLhFQSY5c7x6luCI+A123m3
   lE+U3Cv6xJ8rgCO59seIVeqtl/iZu98GwODJVuFw6ls2bpRGXBXDhlb9J
   GUWYm/9XeYosMd/bouF+PXGdkBIzLIwcMcaW2o825GlBzzPWI8Ft88emF
   K8ntK1C/QywLQdVoLEI4168Ik4JSGRRNuKQ5Ncs7zZe9KJtK5UOU4W9bx
   sDGLfjTkwctiDTx/aqmCOwIxOEzc9fmdIHrVB6CaOAwQoi/4Idox8brSf
   /QhtJd1o1i/iYavvLZjuvKsZEFY0Djm+4nDliA+scYRsF5z4PeWSQHq0U
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="297100936"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="297100936"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 01:25:14 -0700
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="678949294"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.32.55])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 01:25:11 -0700
Message-ID: <02c1e116-28e3-fe6f-5197-fae2f79c64bb@intel.com>
Date:   Wed, 14 Sep 2022 11:25:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 00/11] perf test: test_intel_pt.sh: Add per-thread test
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
References: <20220912083412.7058-1-adrian.hunter@intel.com>
 <CAM9d7ciRCnpNjOfoEbO27pNk28ddjg1vVdgrZtvWQ-mbD7jg0w@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAM9d7ciRCnpNjOfoEbO27pNk28ddjg1vVdgrZtvWQ-mbD7jg0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/22 20:41, Namhyung Kim wrote:
> On Mon, Sep 12, 2022 at 1:34 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> Hi
>>
>> Here is a new per-thread test for the test_intel_pt.sh test script.
>>
>> The first 9 patches are tidy-ups for the script, mostly based on results
>> from the shellcheck utility.
>>
>> The 10th patch adds debug prints that the script will capture to help
>> verify correct operation.
>>
>> The final patch actually adds the new test.
>>
>>
>> Adrian Hunter (11):
>>       perf test: test_intel_pt.sh: Add cleanup function
>>       perf test: test_intel_pt.sh: Use a temp directory
>>       perf test: test_intel_pt.sh: Fix redirection
>>       perf test: test_intel_pt.sh: Stop using expr
>>       perf test: test_intel_pt.sh: Stop using backticks
>>       perf test: test_intel_pt.sh: Use grep -c instead of grep plus wc -l
>>       perf test: test_intel_pt.sh: Use quotes around variable expansion
>>       perf test: test_intel_pt.sh: Fix return checking
>>       perf test: test_intel_pt.sh: Add more output in preparation for more tests
>>       perf tools: Add debug messages and comments for testing
>>       perf test: test_intel_pt.sh: Add per-thread test
> 
> I don't think I understood all the black magic in patch 11. :)

It is not that bad :-)

Consider the output from the test:


	$ perf test -v " intel pt"
	Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF maps, etc
	102: Miscellaneous Intel PT testing                                  :
	--- start ---
	test child forked, pid 155646
<SNIP>
	--- Test per-thread recording ---
	Workload PIDs are 155669 and 155670
	perf PID is 155681
	Waiting for "perf record has started" message
	OK
	pid 155669 cpu -1 fd 5 : sys_perf_event_open: pid 155669  cpu -1 group_fd -1  flags 0x8 = 5

awk has matched the debug message and determined the values for pid, cpu and fd

	pid 155673 cpu -1 fd 6 : sys_perf_event_open: pid 155673  cpu -1 group_fd -1  flags 0x8 = 6
	pid 155670 cpu -1 fd 7 : sys_perf_event_open: pid 155670  cpu -1 group_fd -1  flags 0x8 = 7
	pid 155672 cpu -1 fd 8 : sys_perf_event_open: pid 155672  cpu -1 group_fd -1  flags 0x8 = 8
	pid 155669 cpu -1 fd 9 : sys_perf_event_open: pid 155669  cpu -1 group_fd -1  flags 0x8 = 9
	pid 155673 cpu -1 fd 10 : sys_perf_event_open: pid 155673  cpu -1 group_fd -1  flags 0x8 = 10
	pid 155670 cpu -1 fd 11 : sys_perf_event_open: pid 155670  cpu -1 group_fd -1  flags 0x8 = 11
	pid 155672 cpu -1 fd 12 : sys_perf_event_open: pid 155672  cpu -1 group_fd -1  flags 0x8 = 12
	fd 5 : idx 0: mmapping fd 5
	
awk has matched the debug message and determined the values for fd
	
	fd 9 fd_to 5 : idx 0: set output fd 9 -> 5
	
awk has matched the debug message and determined the values for fd and fd_to

	fd 6 : idx 1: mmapping fd 6
	fd 10 fd_to 6 : idx 1: set output fd 10 -> 6
	fd 7 : idx 2: mmapping fd 7
	fd 11 fd_to 7 : idx 2: set output fd 11 -> 7
	fd 8 : idx 3: mmapping fd 8
	fd 12 fd_to 8 : idx 3: set output fd 12 -> 8
	Checking 8 fds

Now awk is checking:
- every fd is mmapped or set-output
- there is 1 mmap per unique pid
- there is 1 mmap per unique cpu
- there are the right number of different pids
i.e.
	END {
		print "Checking " length(fd_array) " fds"
		for (fd in fd_array) {
			if (fd in mmap_array) {
				pid = pid_array[fd]
				if (pid != -1) {
					if (pid in pids) {
						print "More than 1 mmap for PID " pid
						exit 1
					}
					pids[pid] = 1
				}
				cpu = cpu_array[fd]
				if (cpu != -1) {
					if (cpu in cpus) {
						print "More than 1 mmap for CPU " cpu
						exit 1
					}
					cpus[cpu] = 1
				}
			} else if (!(fd in set_output_array)) {
				print "No mmap for fd " fd
				exit 1
			}
		}
		n = length(pids)
		if (n != thread_cnt) {
			print "Expected " thread_cnt " per-thread mmaps - found " n
			exit 1
		}
	}

> At least we can move some helper functions to the lib and
> reuse them in other tests.  I'll test that later..
> 
> So for patch 01-10,
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> 
> Thanks,
> Namhyung
> 
> 
>>
>>  tools/lib/perf/evlist.c                 |   2 +
>>  tools/perf/builtin-record.c             |   8 +
>>  tools/perf/tests/shell/test_intel_pt.sh | 307 ++++++++++++++++++++++++++++++--
>>  tools/perf/util/evsel.c                 |   2 +
>>  4 files changed, 304 insertions(+), 15 deletions(-)
>>
>>
>> Regards
>> Adrian


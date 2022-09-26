Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8305EB167
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 21:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiIZTf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 15:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiIZTfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 15:35:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70BCBF61;
        Mon, 26 Sep 2022 12:35:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 476EBB80DBD;
        Mon, 26 Sep 2022 19:35:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5DE0C433D6;
        Mon, 26 Sep 2022 19:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664220921;
        bh=kmvK4go0XJzZ18Ymod6JWCTpr1sik+c3jYluVYAXTWM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CXcp9ulwxNaQZbTbeDNyX0TYWi8r6Ayi7jSlHb2fy6jNtrIt5Ov/5q28fJtJeXzqv
         LVQngelgj8XxUNboBNo5kvKqvnww6ISGs6TWo9MdWDapH2FuwImwVC9sgQ2PtypRF2
         nnVjmSrLfYadCaQv1CVgAhLLowETjcq1m1kLIHnrysbxmpoaKE2pLzbfC3jAtnJsd/
         Pkn2Rd0U6TOhqcG/tgn15wofjpcFl5is94bH4lzI6i5lUMQY9k4z8g9bJp0no15XFE
         TwZE02KYELKtaLccPOS8pFpobdAJyJ/eAzR9fNRn+azpxPdD/VpRpvZi3kK7BdPXK/
         47MHNxLh0z0Xw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5CA17403B0; Mon, 26 Sep 2022 20:35:18 +0100 (IST)
Date:   Mon, 26 Sep 2022 20:35:18 +0100
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Ian Rogers <irogers@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH 00/11] perf test: test_intel_pt.sh: Add per-thread test
Message-ID: <YzH+9mzUUXYWpSO3@kernel.org>
References: <20220912083412.7058-1-adrian.hunter@intel.com>
 <CAM9d7ciRCnpNjOfoEbO27pNk28ddjg1vVdgrZtvWQ-mbD7jg0w@mail.gmail.com>
 <02c1e116-28e3-fe6f-5197-fae2f79c64bb@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02c1e116-28e3-fe6f-5197-fae2f79c64bb@intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Sep 14, 2022 at 11:25:07AM +0300, Adrian Hunter escreveu:
> On 13/09/22 20:41, Namhyung Kim wrote:
> > On Mon, Sep 12, 2022 at 1:34 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>
> >> Hi
> >>
> >> Here is a new per-thread test for the test_intel_pt.sh test script.
> >>
> >> The first 9 patches are tidy-ups for the script, mostly based on results
> >> from the shellcheck utility.
> >>
> >> The 10th patch adds debug prints that the script will capture to help
> >> verify correct operation.
> >>
> >> The final patch actually adds the new test.
> >>
> >>
> >> Adrian Hunter (11):
> >>       perf test: test_intel_pt.sh: Add cleanup function
> >>       perf test: test_intel_pt.sh: Use a temp directory
> >>       perf test: test_intel_pt.sh: Fix redirection
> >>       perf test: test_intel_pt.sh: Stop using expr
> >>       perf test: test_intel_pt.sh: Stop using backticks
> >>       perf test: test_intel_pt.sh: Use grep -c instead of grep plus wc -l
> >>       perf test: test_intel_pt.sh: Use quotes around variable expansion
> >>       perf test: test_intel_pt.sh: Fix return checking
> >>       perf test: test_intel_pt.sh: Add more output in preparation for more tests
> >>       perf tools: Add debug messages and comments for testing
> >>       perf test: test_intel_pt.sh: Add per-thread test
> > 
> > I don't think I understood all the black magic in patch 11. :)
> 
> It is not that bad :-)

:-)

Thanks, applied the series.

- Arnaldo
 
> Consider the output from the test:
> 
> 
> 	$ perf test -v " intel pt"
> 	Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF maps, etc
> 	102: Miscellaneous Intel PT testing                                  :
> 	--- start ---
> 	test child forked, pid 155646
> <SNIP>
> 	--- Test per-thread recording ---
> 	Workload PIDs are 155669 and 155670
> 	perf PID is 155681
> 	Waiting for "perf record has started" message
> 	OK
> 	pid 155669 cpu -1 fd 5 : sys_perf_event_open: pid 155669  cpu -1 group_fd -1  flags 0x8 = 5
> 
> awk has matched the debug message and determined the values for pid, cpu and fd
> 
> 	pid 155673 cpu -1 fd 6 : sys_perf_event_open: pid 155673  cpu -1 group_fd -1  flags 0x8 = 6
> 	pid 155670 cpu -1 fd 7 : sys_perf_event_open: pid 155670  cpu -1 group_fd -1  flags 0x8 = 7
> 	pid 155672 cpu -1 fd 8 : sys_perf_event_open: pid 155672  cpu -1 group_fd -1  flags 0x8 = 8
> 	pid 155669 cpu -1 fd 9 : sys_perf_event_open: pid 155669  cpu -1 group_fd -1  flags 0x8 = 9
> 	pid 155673 cpu -1 fd 10 : sys_perf_event_open: pid 155673  cpu -1 group_fd -1  flags 0x8 = 10
> 	pid 155670 cpu -1 fd 11 : sys_perf_event_open: pid 155670  cpu -1 group_fd -1  flags 0x8 = 11
> 	pid 155672 cpu -1 fd 12 : sys_perf_event_open: pid 155672  cpu -1 group_fd -1  flags 0x8 = 12
> 	fd 5 : idx 0: mmapping fd 5
> 	
> awk has matched the debug message and determined the values for fd
> 	
> 	fd 9 fd_to 5 : idx 0: set output fd 9 -> 5
> 	
> awk has matched the debug message and determined the values for fd and fd_to
> 
> 	fd 6 : idx 1: mmapping fd 6
> 	fd 10 fd_to 6 : idx 1: set output fd 10 -> 6
> 	fd 7 : idx 2: mmapping fd 7
> 	fd 11 fd_to 7 : idx 2: set output fd 11 -> 7
> 	fd 8 : idx 3: mmapping fd 8
> 	fd 12 fd_to 8 : idx 3: set output fd 12 -> 8
> 	Checking 8 fds
> 
> Now awk is checking:
> - every fd is mmapped or set-output
> - there is 1 mmap per unique pid
> - there is 1 mmap per unique cpu
> - there are the right number of different pids
> i.e.
> 	END {
> 		print "Checking " length(fd_array) " fds"
> 		for (fd in fd_array) {
> 			if (fd in mmap_array) {
> 				pid = pid_array[fd]
> 				if (pid != -1) {
> 					if (pid in pids) {
> 						print "More than 1 mmap for PID " pid
> 						exit 1
> 					}
> 					pids[pid] = 1
> 				}
> 				cpu = cpu_array[fd]
> 				if (cpu != -1) {
> 					if (cpu in cpus) {
> 						print "More than 1 mmap for CPU " cpu
> 						exit 1
> 					}
> 					cpus[cpu] = 1
> 				}
> 			} else if (!(fd in set_output_array)) {
> 				print "No mmap for fd " fd
> 				exit 1
> 			}
> 		}
> 		n = length(pids)
> 		if (n != thread_cnt) {
> 			print "Expected " thread_cnt " per-thread mmaps - found " n
> 			exit 1
> 		}
> 	}
> 
> > At least we can move some helper functions to the lib and
> > reuse them in other tests.  I'll test that later..
> > 
> > So for patch 01-10,
> > 
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
> > 
> > Thanks,
> > Namhyung
> > 
> > 
> >>
> >>  tools/lib/perf/evlist.c                 |   2 +
> >>  tools/perf/builtin-record.c             |   8 +
> >>  tools/perf/tests/shell/test_intel_pt.sh | 307 ++++++++++++++++++++++++++++++--
> >>  tools/perf/util/evsel.c                 |   2 +
> >>  4 files changed, 304 insertions(+), 15 deletions(-)
> >>
> >>
> >> Regards
> >> Adrian

-- 

- Arnaldo

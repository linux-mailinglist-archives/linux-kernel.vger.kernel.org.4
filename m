Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE9F5FF2FF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 19:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiJNRc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 13:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJNRcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 13:32:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402851D1E23;
        Fri, 14 Oct 2022 10:32:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29D9F61BB5;
        Fri, 14 Oct 2022 17:32:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DDEDC433C1;
        Fri, 14 Oct 2022 17:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665768741;
        bh=Jk4EBDJ8ghjB5zn4b2gGQROlee3ts8rsAgyBgyQNDmo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dkv5Rq+BxBSmxZ+UfsAA7580dXssLiTCuwEeQEXNKSz0sb76leNbv0HpIIafcC/zw
         AugoBY3FgM5rz1K14VoZ2ksuzSVsvSE9HxJmqVy+tMKitr86r7potMUhFHW8QbkGmz
         e/wSFFEJL4rSKKm3bY64zybAMhxtGcWF6Gv0ud4ipfDRuHfJ/S5W63eUe4BB77OQuf
         OY2Vb3N13Ou7MbA1V1etvJg7RBiCW26GBuboSJ4C1k2wFFUrb6sUtfsNo5DMTfVT1r
         mWhmXKpDX2U4Nv2FRAuYDHG0E3lmXHVFdCw9pBz/jDXSJj+5ZVRJmm40EehFyxsOvA
         NGw0ZJcGTHgjA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6DF8C4062C; Fri, 14 Oct 2022 14:32:19 -0300 (-03)
Date:   Fri, 14 Oct 2022 14:32:19 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 5/7] perf test: test_intel_pt.sh: Add jitdump test
Message-ID: <Y0mdIxx630X5zi4V@kernel.org>
References: <20221014170905.64069-1-adrian.hunter@intel.com>
 <20221014170905.64069-6-adrian.hunter@intel.com>
 <Y0mcWpc4KaeXpU+z@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0mcWpc4KaeXpU+z@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Oct 14, 2022 at 02:28:58PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Oct 14, 2022 at 08:09:03PM +0300, Adrian Hunter escreveu:
> > Add a test for decoding self-modifying code using a jitdump file.
> > 
> > The test creates a workload that uses self-modifying code and generates its
> > own jitdump file.  The result is processed with perf inject --jit and
> > checked for decoding errors.
> > 
> > Note the test will fail without patch "perf inject: Fix GEN_ELF_TEXT_OFFSET
> > for jit" applied.
> > 
> > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> > ---
> >  tools/perf/tests/shell/test_intel_pt.sh | 162 ++++++++++++++++++++++++
> >  1 file changed, 162 insertions(+)
> > 
> > diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/shell/test_intel_pt.sh
> > index 79dde57b561d..e0bf75981b9c 100755
> > --- a/tools/perf/tests/shell/test_intel_pt.sh
> > +++ b/tools/perf/tests/shell/test_intel_pt.sh
> > @@ -22,6 +22,7 @@ outfile="${temp_dir}/test-out.txt"
> >  errfile="${temp_dir}/test-err.txt"
> >  workload="${temp_dir}/workload"
> >  awkscript="${temp_dir}/awkscript"
> > +jitdump_workload="${temp_dir}/jitdump_workload"
> >  
> >  cleanup()
> >  {
> > @@ -50,6 +51,13 @@ perf_record_no_decode()
> >  	perf record -B -N --no-bpf-event "$@"
> >  }
> >  
> > +# perf record for testing should not need BPF events
> > +perf_record_no_bpf()
> > +{
> > +	# Options for no BPF events
> > +	perf record --no-bpf-event "$@"
> > +}
> > +
> >  have_workload=false
> >  cat << _end_of_file_ | /usr/bin/cc -o "${workload}" -xc - -pthread && have_workload=true
> >  #include <time.h>
> > @@ -269,6 +277,159 @@ test_per_thread()
> >  	return 0
> >  }
> >  
> > +test_jitdump()
> > +{
> > +	echo "--- Test tracing self-modifying code that uses jitdump ---"
> > +
> > +	script_path=$(realpath "$0")
> > +	script_dir=$(dirname "$script_path")
> > +	jitdump_incl_dir="${script_dir}/../../util"
> > +	jitdump_h="${jitdump_incl_dir}/jitdump.h"
> 
> So this requires one to test this being on the kernel (perf) sources
> dir? I think we should add this header to some 'perf test' directory to
> remove this requirement, ok?
> 
> But this can be done on top, right now we just don't test jitdump:
> 
> fd 20 : idx 11: mmapping fd 20
> Checking 16 fds
> OK
> --- Test tracing self-modifying code that uses jitdump ---
> SKIP: Include file jitdump.h not found
> --- Cleaning up ---
> --- Done ---
> test child finished with 0
> ---- end ----
> Miscellaneous Intel PT testing: Ok

Actually:

--- Test tracing self-modifying code that uses jitdump ---
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.018 MB /tmp/perf-test-intel-pt-sh.GJoKOxGVFY/tmp-perf.data ]

Warning:
1 instruction trace errors
/home/acme/git/perf
Decode failed, 1 errors
Warning:
1 instruction trace errors
 instruction trace error type 1 time 494778.777081924 cpu 3 pid 309650 tid 309650 ip 0x7f0972f22009 code 5: Failed to get instruction
--- Cleaning up ---
--- Done ---
test child finished with -1
---- end ----
Miscellaneous Intel PT testing: FAILED!
[root@quaco perf]#
[root@quaco perf]# pwd
/home/acme/git/perf

Multiple runs end up failing, processor info:

[root@quaco perf]# grep -m1 -A26 vendor_id /proc/cpuinfo
vendor_id	: GenuineIntel
cpu family	: 6
model		: 142
model name	: Intel(R) Core(TM) i7-8650U CPU @ 1.90GHz
stepping	: 10
microcode	: 0xf0
cpu MHz		: 2100.000
cache size	: 8192 KB
physical id	: 0
siblings	: 8
core id		: 0
cpu cores	: 4
apicid		: 0
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 22
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb invpcid_single pti ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid mpx rdseed adx smap clflushopt intel_pt xsaveopt xsavec xgetbv1 xsaves dtherm ida arat pln pts hwp hwp_notify hwp_act_window hwp_epp md_clear flush_l1d arch_capabilities
vmx flags	: vnmi preemption_timer invvpid ept_x_only ept_ad ept_1gb flexpriority tsc_offset vtpr mtf vapic ept vpid unrestricted_guest ple shadow_vmcs pml ept_mode_based_exec
bugs		: cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf mds swapgs taa itlb_multihit srbds mmio_stale_data retbleed
bogomips	: 4199.88
clflush size	: 64
cache_alignment	: 64
address sizes	: 39 bits physical, 48 bits virtual
power management:

[root@quaco perf]#

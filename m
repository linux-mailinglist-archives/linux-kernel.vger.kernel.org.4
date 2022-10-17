Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D6B60106A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 15:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiJQNoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 09:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiJQNoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 09:44:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28666F02F;
        Mon, 17 Oct 2022 06:44:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C6E6AB81699;
        Mon, 17 Oct 2022 13:44:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A480C433D6;
        Mon, 17 Oct 2022 13:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666014249;
        bh=b2a97bEXgy3ihOsuuXeRl3W+4AKSP+YyKYf9t5QyzLA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dIb14rSdWa746yh22U+NssVbz10Y+SdXRme4OeVOkMoEuiMavL1tPYBeF78ctYcLv
         g2wT7fGEwXLywiR7qJDrxsigqjMa3LTalLemFrbhBFLmfqkQoZF3G7U/mTOALPzz9V
         oc7rnmqakG43Nlhy+g8XkxCYT2yDKVgFPfVdq6aQtXCQFFTWto0GcYUZeLQjx+QOuJ
         pZfBEYdGWwjm70n4tjAL9LBDkUooASoq7XiYJ+j8mgnfSS5Jpz641D0Ewk30oX0Vdr
         N7j90jt4SpsFs1oLT+MdafKDwE85oHEynmfjz0WSUb8u7+Q15fweOWANtCfjCKjOf0
         yuNzTe0gg9UYg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0092C403B6; Mon, 17 Oct 2022 10:44:06 -0300 (-03)
Date:   Mon, 17 Oct 2022 10:44:06 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 5/7] perf test: test_intel_pt.sh: Add jitdump test
Message-ID: <Y01cJoaB9q9iarhJ@kernel.org>
References: <20221014170905.64069-1-adrian.hunter@intel.com>
 <20221014170905.64069-6-adrian.hunter@intel.com>
 <Y0mcWpc4KaeXpU+z@kernel.org>
 <866b1317-d0cd-c730-8d32-e8885b1f45d7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <866b1317-d0cd-c730-8d32-e8885b1f45d7@intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 17, 2022 at 03:57:03PM +0300, Adrian Hunter escreveu:
> On 14/10/22 20:28, Arnaldo Carvalho de Melo wrote:
> > Em Fri, Oct 14, 2022 at 08:09:03PM +0300, Adrian Hunter escreveu:
> >> Add a test for decoding self-modifying code using a jitdump file.
> >>
> >> The test creates a workload that uses self-modifying code and generates its
> >> own jitdump file.  The result is processed with perf inject --jit and
> >> checked for decoding errors.
> >>
> >> Note the test will fail without patch "perf inject: Fix GEN_ELF_TEXT_OFFSET
> >> for jit" applied.
> >>
> >> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> >> ---
> >>  tools/perf/tests/shell/test_intel_pt.sh | 162 ++++++++++++++++++++++++
> >>  1 file changed, 162 insertions(+)
> >>
> >> diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/shell/test_intel_pt.sh
> >> index 79dde57b561d..e0bf75981b9c 100755
> >> --- a/tools/perf/tests/shell/test_intel_pt.sh
> >> +++ b/tools/perf/tests/shell/test_intel_pt.sh
> >> @@ -22,6 +22,7 @@ outfile="${temp_dir}/test-out.txt"
> >>  errfile="${temp_dir}/test-err.txt"
> >>  workload="${temp_dir}/workload"
> >>  awkscript="${temp_dir}/awkscript"
> >> +jitdump_workload="${temp_dir}/jitdump_workload"
> >>  
> >>  cleanup()
> >>  {
> >> @@ -50,6 +51,13 @@ perf_record_no_decode()
> >>  	perf record -B -N --no-bpf-event "$@"
> >>  }
> >>  
> >> +# perf record for testing should not need BPF events
> >> +perf_record_no_bpf()
> >> +{
> >> +	# Options for no BPF events
> >> +	perf record --no-bpf-event "$@"
> >> +}
> >> +
> >>  have_workload=false
> >>  cat << _end_of_file_ | /usr/bin/cc -o "${workload}" -xc - -pthread && have_workload=true
> >>  #include <time.h>
> >> @@ -269,6 +277,159 @@ test_per_thread()
> >>  	return 0
> >>  }
> >>  
> >> +test_jitdump()
> >> +{
> >> +	echo "--- Test tracing self-modifying code that uses jitdump ---"
> >> +
> >> +	script_path=$(realpath "$0")
> >> +	script_dir=$(dirname "$script_path")
> >> +	jitdump_incl_dir="${script_dir}/../../util"
> >> +	jitdump_h="${jitdump_incl_dir}/jitdump.h"
> > 
> > So this requires one to test this being on the kernel (perf) sources
> > dir? I think we should add this header to some 'perf test' directory to
> > remove this requirement, ok?
> > 
> 
> How about this:

Better, but see below
 
> From: Adrian Hunter <adrian.hunter@intel.com>
> Date: Mon, 17 Oct 2022 15:14:25 +0300
> Subject: [PATCH] perf test: test_intel_pt.sh: Install jitdump.h for use by
>  tests
> 
> test_intel_pt.sh builds a workload for testing jitdump and the workload
> includes file jitdump.h.
> 
> Currently, test_intel_pt.sh finds jitdump.h assuming the test is run in
> the kernel source directory, and skips that test if it is not found.
> 
> To improve that situation, amend the build to install the jitdump.h file
> in the test shell directory, and look there first, falling back to the
> original way if that is not found.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/Makefile.perf                |  1 +
>  tools/perf/tests/shell/test_intel_pt.sh | 12 +++++++++---
>  2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index a432e59afc42..c4ec66194465 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -1013,6 +1013,7 @@ install-tests: all install-gtk
>  		$(INSTALL) tests/attr/* -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/attr'; \
>  		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell'; \
>  		$(INSTALL) tests/shell/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell'; \
> +		$(INSTALL) util/jitdump.h -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell'; \
>  		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
>  		$(INSTALL) tests/shell/lib/*.sh -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
>  		$(INSTALL) tests/shell/lib/*.py -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
> diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/shell/test_intel_pt.sh
> index 4c0aabbe33bd..3abf803f96b9 100755
> --- a/tools/perf/tests/shell/test_intel_pt.sh
> +++ b/tools/perf/tests/shell/test_intel_pt.sh
> @@ -284,14 +284,20 @@ test_jitdump()
>  
>  	script_path=$(realpath "$0")
>  	script_dir=$(dirname "$script_path")
> -	jitdump_incl_dir="${script_dir}/../../util"
> +	jitdump_incl_dir="${script_dir}"
>  	jitdump_h="${jitdump_incl_dir}/jitdump.h"
>  
>  	if [ ! -e "${jitdump_h}" ] ; then
> -		echo "SKIP: Include file jitdump.h not found"
> -		return 2
> +		jitdump_incl_dir="${script_dir}/../../util"
> +		jitdump_h="${jitdump_incl_dir}/jitdump.h"
> +		if [ ! -e "${jitdump_h}" ] ; then
> +			echo "SKIP: Include file jitdump.h not found"
> +			return 2
> +		fi
>  	fi
>  
> +	echo "Using include file: ${jitdump_h}"

Shouldn't this appear only with -v?

- Arnaldo

> +
>  	if [ -z "${have_jitdump_workload}" ] ; then
>  		have_jitdump_workload=false
>  		# Create a workload that uses self-modifying code and generates its own jitdump file

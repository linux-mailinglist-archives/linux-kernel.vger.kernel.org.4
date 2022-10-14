Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13FE5FF2F9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 19:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiJNR3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 13:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJNR3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 13:29:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710C91D066C;
        Fri, 14 Oct 2022 10:29:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DDF67B8237A;
        Fri, 14 Oct 2022 17:29:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF95C433D6;
        Fri, 14 Oct 2022 17:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665768541;
        bh=U0AKPha49Aec80L7VXJBXtUQdEMHKmSvHmeOqv3Xp3o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mxOv5d5Sk/lNoSugprzx1IARt4Pddkv7CbyEhcIShZWrD+uQBD5HR3UrQLm6OK1Ew
         9sNBvTDe93A2uhx1kqgGs+1kQtTuh4E9GOjiI8y66f2mk4IHoutt/3Fp1HyG+4FqOH
         pVDg/ltUY7QnuSa+mR/2E+Ii+ypCgFmnT6JoTHuqUhSpFwSdlexI/Wi5AkZ/T+a1OM
         xkZ2q+SDBhyLBtRGK5iJGFwJ04mVODnOpf5ifNyLG3RD3tbo92j2vGwOvMW38GPXeW
         nCP91JYmZZFvtdgdTUwMAGwjKBptWZ9zVAmVe4pv486wkrF8qbSsMnOgduds8yYi4R
         z0GSFw13te42A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E1DE74062C; Fri, 14 Oct 2022 14:28:58 -0300 (-03)
Date:   Fri, 14 Oct 2022 14:28:58 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 5/7] perf test: test_intel_pt.sh: Add jitdump test
Message-ID: <Y0mcWpc4KaeXpU+z@kernel.org>
References: <20221014170905.64069-1-adrian.hunter@intel.com>
 <20221014170905.64069-6-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014170905.64069-6-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Oct 14, 2022 at 08:09:03PM +0300, Adrian Hunter escreveu:
> Add a test for decoding self-modifying code using a jitdump file.
> 
> The test creates a workload that uses self-modifying code and generates its
> own jitdump file.  The result is processed with perf inject --jit and
> checked for decoding errors.
> 
> Note the test will fail without patch "perf inject: Fix GEN_ELF_TEXT_OFFSET
> for jit" applied.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/tests/shell/test_intel_pt.sh | 162 ++++++++++++++++++++++++
>  1 file changed, 162 insertions(+)
> 
> diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/shell/test_intel_pt.sh
> index 79dde57b561d..e0bf75981b9c 100755
> --- a/tools/perf/tests/shell/test_intel_pt.sh
> +++ b/tools/perf/tests/shell/test_intel_pt.sh
> @@ -22,6 +22,7 @@ outfile="${temp_dir}/test-out.txt"
>  errfile="${temp_dir}/test-err.txt"
>  workload="${temp_dir}/workload"
>  awkscript="${temp_dir}/awkscript"
> +jitdump_workload="${temp_dir}/jitdump_workload"
>  
>  cleanup()
>  {
> @@ -50,6 +51,13 @@ perf_record_no_decode()
>  	perf record -B -N --no-bpf-event "$@"
>  }
>  
> +# perf record for testing should not need BPF events
> +perf_record_no_bpf()
> +{
> +	# Options for no BPF events
> +	perf record --no-bpf-event "$@"
> +}
> +
>  have_workload=false
>  cat << _end_of_file_ | /usr/bin/cc -o "${workload}" -xc - -pthread && have_workload=true
>  #include <time.h>
> @@ -269,6 +277,159 @@ test_per_thread()
>  	return 0
>  }
>  
> +test_jitdump()
> +{
> +	echo "--- Test tracing self-modifying code that uses jitdump ---"
> +
> +	script_path=$(realpath "$0")
> +	script_dir=$(dirname "$script_path")
> +	jitdump_incl_dir="${script_dir}/../../util"
> +	jitdump_h="${jitdump_incl_dir}/jitdump.h"

So this requires one to test this being on the kernel (perf) sources
dir? I think we should add this header to some 'perf test' directory to
remove this requirement, ok?

But this can be done on top, right now we just don't test jitdump:

fd 20 : idx 11: mmapping fd 20
Checking 16 fds
OK
--- Test tracing self-modifying code that uses jitdump ---
SKIP: Include file jitdump.h not found
--- Cleaning up ---
--- Done ---
test child finished with 0
---- end ----
Miscellaneous Intel PT testing: Ok


> +	if [ ! -e "${jitdump_h}" ] ; then
> +		echo "SKIP: Include file jitdump.h not found"
> +		return 2
> +	fi
> +
> +	if [ -z "${have_jitdump_workload}" ] ; then
> +		have_jitdump_workload=false
> +		# Create a workload that uses self-modifying code and generates its own jitdump file
> +		cat <<- "_end_of_file_" | /usr/bin/cc -o "${jitdump_workload}" -I "${jitdump_incl_dir}" -xc - -pthread && have_jitdump_workload=true
> +		#define _GNU_SOURCE
> +		#include <sys/mman.h>
> +		#include <sys/types.h>
> +		#include <stddef.h>
> +		#include <stdio.h>
> +		#include <stdint.h>
> +		#include <unistd.h>
> +		#include <string.h>
> +
> +		#include "jitdump.h"
> +
> +		#define CHK_BYTE 0x5a
> +
> +		static inline uint64_t rdtsc(void)
> +		{
> +			unsigned int low, high;
> +
> +			asm volatile("rdtsc" : "=a" (low), "=d" (high));
> +
> +			return low | ((uint64_t)high) << 32;
> +		}
> +
> +		static FILE *open_jitdump(void)
> +		{
> +			struct jitheader header = {
> +				.magic      = JITHEADER_MAGIC,
> +				.version    = JITHEADER_VERSION,
> +				.total_size = sizeof(header),
> +				.pid        = getpid(),
> +				.timestamp  = rdtsc(),
> +				.flags      = JITDUMP_FLAGS_ARCH_TIMESTAMP,
> +			};
> +			char filename[256];
> +			FILE *f;
> +			void *m;
> +
> +			snprintf(filename, sizeof(filename), "jit-%d.dump", getpid());
> +			f = fopen(filename, "w+");
> +			if (!f)
> +				goto err;
> +			/* Create an MMAP event for the jitdump file. That is how perf tool finds it. */
> +			m = mmap(0, 4096, PROT_READ | PROT_EXEC, MAP_PRIVATE, fileno(f), 0);
> +			if (m == MAP_FAILED)
> +				goto err_close;
> +			munmap(m, 4096);
> +			if (fwrite(&header,sizeof(header),1,f) != 1)
> +				goto err_close;
> +			return f;
> +
> +		err_close:
> +			fclose(f);
> +		err:
> +			return NULL;
> +		}
> +
> +		static int write_jitdump(FILE *f, void *addr, const uint8_t *dat, size_t sz, uint64_t *idx)
> +		{
> +			struct jr_code_load rec = {
> +				.p.id          = JIT_CODE_LOAD,
> +				.p.total_size  = sizeof(rec) + sz,
> +				.p.timestamp   = rdtsc(),
> +				.pid	       = getpid(),
> +				.tid	       = gettid(),
> +				.vma           = (unsigned long)addr,
> +				.code_addr     = (unsigned long)addr,
> +				.code_size     = sz,
> +				.code_index    = ++*idx,
> +			};
> +
> +			if (fwrite(&rec,sizeof(rec),1,f) != 1 ||
> +			fwrite(dat, sz, 1, f) != 1)
> +				return -1;
> +			return 0;
> +		}
> +
> +		static void close_jitdump(FILE *f)
> +		{
> +			fclose(f);
> +		}
> +
> +		int main()
> +		{
> +			/* Get a memory page to store executable code */
> +			void *addr = mmap(0, 4096, PROT_WRITE | PROT_EXEC, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> +			/* Code to execute: mov CHK_BYTE, %eax ; ret */
> +			uint8_t dat[] = {0xb8, CHK_BYTE, 0x00, 0x00, 0x00, 0xc3};
> +			FILE *f = open_jitdump();
> +			uint64_t idx = 0;
> +			int ret = 1;
> +
> +			if (!f)
> +				return 1;
> +			/* Copy executable code to executable memory page */
> +			memcpy(addr, dat, sizeof(dat));
> +			/* Record it in the jitdump file */
> +			if (write_jitdump(f, addr, dat, sizeof(dat), &idx))
> +				goto out_close;
> +			/* Call it */
> +			ret = ((int (*)(void))addr)() - CHK_BYTE;
> +		out_close:
> +			close_jitdump(f);
> +			return ret;
> +		}
> +		_end_of_file_
> +	fi
> +
> +	if ! $have_jitdump_workload ; then
> +		echo "SKIP: No jitdump workload"
> +		return 2
> +	fi
> +
> +	# Change to temp_dir so jitdump collateral files go there
> +	cd "${temp_dir}"
> +	perf_record_no_bpf -o "${tmpfile}" -e intel_pt//u "${jitdump_workload}"
> +	perf inject -i "${tmpfile}" -o "${perfdatafile}" --jit
> +	decode_br_cnt=$(perf script -i "${perfdatafile}" --itrace=b | wc -l)
> +	# Note that overflow and lost errors are suppressed for the error count
> +	decode_err_cnt=$(perf script -i "${perfdatafile}" --itrace=e-o-l | grep -ci error)
> +	cd -
> +	# Should be thousands of branches
> +	if [ "${decode_br_cnt}" -lt 1000 ] ; then
> +		echo "Decode failed, only ${decode_br_cnt} branches"
> +		return 1
> +	fi
> +	# Should be no errors
> +	if [ "${decode_err_cnt}" -ne 0 ] ; then
> +		echo "Decode failed, ${decode_err_cnt} errors"
> +		perf script -i "${perfdatafile}" --itrace=e-o-l
> +		return 1
> +	fi
> +
> +	echo OK
> +	return 0
> +}
> +
>  count_result()
>  {
>  	if [ "$1" -eq 2 ] ; then
> @@ -286,6 +447,7 @@ ret=0
>  test_system_wide_side_band		|| ret=$? ; count_result $ret ; ret=0
>  test_per_thread "" ""			|| ret=$? ; count_result $ret ; ret=0
>  test_per_thread "k" "(incl. kernel) "	|| ret=$? ; count_result $ret ; ret=0
> +test_jitdump				|| ret=$? ; count_result $ret ; ret=0
>  
>  cleanup
>  
> -- 
> 2.25.1

-- 

- Arnaldo

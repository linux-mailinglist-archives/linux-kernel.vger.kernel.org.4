Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E995A65C0B3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 14:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbjACNUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 08:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjACNUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 08:20:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7632287;
        Tue,  3 Jan 2023 05:20:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 03240B80EB9;
        Tue,  3 Jan 2023 13:20:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42EE4C433EF;
        Tue,  3 Jan 2023 13:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672752045;
        bh=nSf8CqQIVgh4XEKepa57w2WQwS/qEvlQhRRURqQE9sg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XN1Z9/IPJJZSGeieUdpU8ygxil/uwSlGJbxH4jzOv5I7Q1WzKciztDJCxUzjlNYAr
         dnNQ+OJAjHmgE8rVCibAFP4EGc2QjISBIfmV1rhlNi+2jqC2+gN6L2Wh9mLmh0e+5U
         +i+fMAKs4Vqt3t3EMT8kYFMgbHSx5+Tt2paMGwNvGTyc3HYe5LxR/rfW69NQnWazao
         FxwKXm/LoGlMwSc7ZjdtSLqy8fhgsYCPSoce/M3O0TX1Qv5zHeNlsrzxdO5RN8nl0J
         2io97MCqA2lViYdupETmq10OX+ayRKSD77lnHHamn5d9UlFL3Xm7i6j6eFMJja9oot
         Gl4WcC2x8OSjQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5F42E40468; Tue,  3 Jan 2023 10:20:42 -0300 (-03)
Date:   Tue, 3 Jan 2023 10:20:42 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        sumanthk@linux.ibm.com, svens@linux.ibm.com, gor@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <richter@de.ibm.com>
Subject: Re: [PATCH v2 2/2] perf/test: Fix test case 89 for x86
Message-ID: <Y7QrqshCjRocRlWP@kernel.org>
References: <20221228145704.2702487-1-tmricht@linux.ibm.com>
 <20221228145704.2702487-2-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221228145704.2702487-2-tmricht@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Dec 28, 2022 at 03:57:04PM +0100, Thomas Richter escreveu:
> From: Thomas Richter <richter@de.ibm.com>
> 
> perf test '89: probe libc's inet_pton & backtrace it with ping'
> fails on x86. Debugging revealed a changed stack trace for the
> ping command using probes:
> 
> ping 35729 [002]  8006.365063: probe_libc:inet_pton: (3ff9603e7c0)
>                   12be50 __GI___inet_pton+0x0 (/usr/lib64/libc.so.6)
>                   4fca main+0x139b (/usr/bin/ping)
> 
> The line getaddrinfo.... in the call stack is gone.
> It was introduced with glibc version 2.36.8 released
> with Fedora 37.

Humm, I'm testing and invetigating this issue and by looking at the
backtraces I see that it is just on the first entry that the getaddrinfo
isn't present, i.e. now there are two inet_pton() calls, one of them
doesn't come from getaddrinfo():

[root@quaco ~]# cat /tmp/perf.script.IUC
ping 623883 [006] 265438.471610: probe_libc:inet_pton: (7f32bcf314c0)
	          1314c0 __GI___inet_pton+0x0 (/usr/lib64/libc.so.6)
	           29510 __libc_start_call_main+0x80 (/usr/lib64/libc.so.6)

ping 623883 [006] 265438.471664: probe_libc:inet_pton: (7f32bcf314c0)
	          1314c0 __GI___inet_pton+0x0 (/usr/lib64/libc.so.6)
	           fa6c6 getaddrinfo+0x126 (/usr/lib64/libc.so.6)
	            491e [unknown] (/usr/bin/ping)

The above is the temp file for the perf script output from the collected
perf.data file See the second entry? Its as we expect:

[root@quaco ~]# cat /tmp/expected.aT6
ping[][0-9 \.:]+probe_libc:inet_pton: \([[:xdigit:]]+\)
.*inet_pton\+0x[[:xdigit:]]+[[:space:]]\(/usr/lib64/libc.so.6|inlined\)$
getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\(/usr/lib64/libc.so.6\)$
.*(\+0x[[:xdigit:]]+|\[unknown\])[[:space:]]\(.*/bin/ping.*\)$
[root@quaco ~]#

But if I just ignore that first one and match against the second event
instance:

[root@quaco ~]# perf test inet_pton
 90: probe libc's inet_pton & backtrace it with ping                 : Ok
[root@quaco ~]# perf test -v inet_pton
 90: probe libc's inet_pton & backtrace it with ping                 :
--- start ---
test child forked, pid 626199
ping 626222 [007] 266979.123047: probe_libc:inet_pton_1: (7f0650d314c0)
1314c0 __GI___inet_pton+0x0 (/usr/lib64/libc.so.6)
fa6c6 getaddrinfo+0x126 (/usr/lib64/libc.so.6)
491e n (/usr/bin/ping)
test child finished with 0
---- end ----
probe libc's inet_pton & backtrace it with ping: Ok
[root@quaco ~]#

So, can you try with the following patch in your s/390 system?

I wish 'perf script' had a --skip option that allowed us to ask for just
the second event, not having that I did a trick with tac + grep -m1 -B :-)

We can try to revisit your approach for the next merge window, as at
this point, for 6.2 we want for fixes to be as minimal as possible.

It works for me on Fedora 36, glibc 2.35-20.fc36, where it was failing,
I'll now try on a arm64 machine, thanks.

- Arnaldo

diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index 34c400ccbe046b59..216b6b64caa3011e 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -57,7 +57,7 @@ trace_libc_inet_pton_backtrace() {
 	perf_data=`mktemp -u /tmp/perf.data.XXX`
 	perf_script=`mktemp -u /tmp/perf.script.XXX`
 	perf record -e $event_name/$eventattr/ -o $perf_data ping -6 -c 1 ::1 > /dev/null 2>&1
-	perf script -i $perf_data > $perf_script
+	perf script -i $perf_data | tac | grep -m1 ^ping -B9 | tac > $perf_script
 
 	exec 3<$perf_script
 	exec 4<$expected


 
> To make the test case more robust to glibc changes resulting in changed
> call stacks, redesign the test completely.
> Read the output lines from the perf probe of the ping command.
> Create an array of expected patterns. Each array entry specifies a
> pattern that may appear in the perf probe output.
> Check that each probe output line is matched in the expected
> patterns array. If there is no match it is an error.
> However not every pattern in the expected pattern array must be hit
> as there may be redundant entries.
> 
> This scheme does not test the sequence of the call stack entries
> but the patterns itself are long and complicated enough.
> Also each perf probe output line has to be in the expected pattern
> array for the test to pass
> 
> Output before on x86
>  # ./perf test 89
>  89: probe libc's inet_pton & backtrace it with ping   : FAILED!
>  #
> 
> Output after on x86
>  # ./perf test 89
>  89: probe libc's inet_pton & backtrace it with ping   : Ok
>  #
> 
> Signed-off-by: Thomas Richter <richter@de.ibm.com>
> ---
>  .../shell/record+probe_libc_inet_pton.sh      | 70 +++++++++++++------
>  1 file changed, 47 insertions(+), 23 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> index 4e9de55d871a..3baef1aa92f5 100755
> --- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> +++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> @@ -30,28 +30,37 @@ add_libc_inet_pton_event() {
>  
>  trace_libc_inet_pton_backtrace() {
>  
> -	expected=`mktemp -u /tmp/expected.XXX`
> +	declare -a expected
> +	local -i idx=0 hit maxstack=4
>  
> -	echo "ping[][0-9 \.:]+$event_name: \([[:xdigit:]]+\)" > $expected
> -	echo ".*inet_pton\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$" >> $expected
> +	expected[0]='ping[][0-9 \.:]+'"$event_name"': \([[:xdigit:]]+\)'
> +	expected[1]='.*inet_pton\+0x[[:xdigit:]]+[[:space:]]\('"$libc"'|inlined\)$'
>  	case "$(uname -m)" in
>  	s390x)
> -		eventattr='call-graph=dwarf,max-stack=4'
> -		echo "text_to_binary_address.*\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$" >> $expected
> -		echo "gaih_inet.*\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$" >> $expected
> -		echo "(__GI_)?getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$" >> $expected
> -		echo "main\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$" >> $expected
> +		eventattr='call-graph=dwarf,max-stack='"$maxstack"
> +		expected[2]='text_to_binary_address.*\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$'
> +		expected[3]='gaih_inet.*\+0x[[:xdigit:]]+[[:space:]]\('"$libc"'|inlined\)$'
> +		expected[4]='(__GI_)?getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\('"$libc"'|inlined\)$'
> +		expected[5]='main\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$'
>  		;;
>  	ppc64|ppc64le)
> -		eventattr='max-stack=4'
> -		echo "gaih_inet.*\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" >> $expected
> -		echo "getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" >> $expected
> -		echo ".*(\+0x[[:xdigit:]]+|\[unknown\])[[:space:]]\(.*/bin/ping.*\)$" >> $expected
> +		eventattr='max-stack='"$maxstack"
> +		expected[2]='gaih_inet.*\+0x[[:xdigit:]]+[[:space:]]\('"$libc"'\)$'
> +		expected[3]='getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\('"$libc"'\)$'
> +		# Line valid with glibc 2.35.x with fedora 36
> +		expected[4]='.*(\+0x[[:xdigit:]]+|\[unknown\])[[:space:]]\(.*/bin/ping.*\)$'
> +		# New line introduced with glibc 2.36.x with fedora 37, replaces previous line
> +		expected[5]='[[:xdigit:]]+[[:space:]](\[unknown\]|main)\+0x[[:xdigit:]]+.*\(.*/bin/ping.*\)$'
>  		;;
>  	*)
> -		eventattr='max-stack=3'
> -		echo "getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" >> $expected
> -		echo ".*(\+0x[[:xdigit:]]+|\[unknown\])[[:space:]]\(.*/bin/ping.*\)$" >> $expected
> +		maxstack=3
> +		eventattr='max-stack='"$maxstack"
> +		expected[2]='getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\('"$libc"'\)$'
> +		# Line valid with glibc 2.35.x with fedora 36
> +		expected[3]='.*(\+0x[[:xdigit:]]+|\[unknown\])[[:space:]]\(.*/bin/ping.*\)$'
> +		# New lines introduced with glibc 2.36.x with fedora 37, replaces previous line
> +		expected[4]='[[:xdigit:]]+[[:space:]](\[unknown\]|main)\+0x[[:xdigit:]]+.*\(.*/bin/ping.*\)$'
> +		expected[5]='.*main\+0x[[:xdigit:]]+.*\('"$libc"'\)$'
>  		;;
>  	esac
>  
> @@ -60,16 +69,31 @@ trace_libc_inet_pton_backtrace() {
>  	perf record -e $event_name/$eventattr/ -o $perf_data ping -6 -c 1 ::1 > /dev/null 2>&1
>  	perf script -i $perf_data > $perf_script
>  
> +	# To make the call stack checking more robust to changes in the glibc
> +	# just check that each probe output line appears in the expected
> +	# patterns array.
> +	# This scheme does not check the sequence as before but tests
> +	# that every line in the call stack is expected. Considering the
> +	# long patterns this should be save too.
>  	exec 3<$perf_script
> -	exec 4<$expected
> -	while read line <&3 && read -r pattern <&4; do
> -		[ -z "$pattern" ] && break
> -		echo $line
> -		echo "$line" | grep -E -q "$pattern"
> -		if [ $? -ne 0 ] ; then
> -			printf "FAIL: expected backtrace entry \"%s\" got \"%s\"\n" "$pattern" "$line"
> +
> +	# Number of input lines to check, take value from max-stack attribute
> +	while read line <&3; do
> +		[ "$idx" -ge "$maxstack" ] && break
> +		[ -z "$line" ] && break
> +
> +		hit=0
> +		for pattern in "${expected[@]}"
> +		do
> +			echo "$line" | egrep -q "$pattern"
> +			[ $? -eq 0 ] && { hit=1; break; }
> +		done
> +		if [ "$hit" -eq 0 ]
> +		then
> +			printf "FAIL: missing backtrace entry for line \"%s\"\n" "$line"
>  			return 1
>  		fi
> +		((++idx))
>  	done
>  
>  	# If any statements are executed from this point onwards,
> @@ -92,6 +116,6 @@ skip_if_no_perf_probe && \
>  add_libc_inet_pton_event && \
>  trace_libc_inet_pton_backtrace
>  err=$?
> -rm -f ${perf_data} ${perf_script} ${expected}
> +rm -f ${perf_data} ${perf_script}
>  delete_libc_inet_pton_event
>  exit $err
> -- 
> 2.38.1

-- 

- Arnaldo

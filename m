Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9B7611128
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 14:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiJ1MWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 08:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiJ1MW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 08:22:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2EA0A1958EE;
        Fri, 28 Oct 2022 05:22:28 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21F9F1FB;
        Fri, 28 Oct 2022 05:22:34 -0700 (PDT)
Received: from [10.57.6.12] (unknown [10.57.6.12])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F8C13F7B4;
        Fri, 28 Oct 2022 05:22:26 -0700 (PDT)
Message-ID: <2265e166-da9c-f540-a108-0d0b133f7da9@arm.com>
Date:   Fri, 28 Oct 2022 13:22:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] perf test: Fix skipping branch stack sampling test
Content-Language: en-US
To:     atrajeev@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, Anshuman.Khandual@arm.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, acme@kernel.org
References: <20221028121913.745307-1-james.clark@arm.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20221028121913.745307-1-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/10/2022 13:19, James Clark wrote:
> Commit f4a2aade6809 ("perf tests powerpc: Fix branch stack sampling test
> to include sanity check for branch filter") added a skip if certain
> branch options aren't available. But the change added both -b
> (--branch-any) and --branch-filter options at the same time, which will
> always result in a failure on any platform because the arguments can't
> be used together.
> 
> Fix this by removing -b (--branch-any) and leaving --branch-filter which
> already specifies 'any'. Also add warning messages to the test and perf
> tool.
> 

Hi Athira,

Are you able to check if this still skips for you on PowerPC with this
new change?

Thanks
James

> Output on x86 before this fix:
> 
>    $ sudo ./perf test branch
>    108: Check branch stack sampling         : Skip
> 
> After:
> 
>    $ sudo ./perf test branch
>    108: Check branch stack sampling         : Ok
> 
> Fixes: f4a2aade6809 ("perf tests powerpc: Fix branch stack sampling test to include sanity check for branch filter")
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/tests/shell/test_brstack.sh | 5 ++++-
>  tools/perf/util/parse-branch-options.c | 4 +++-
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/test_brstack.sh b/tools/perf/tests/shell/test_brstack.sh
> index ec801cffae6b..d7ff5c4b4da4 100755
> --- a/tools/perf/tests/shell/test_brstack.sh
> +++ b/tools/perf/tests/shell/test_brstack.sh
> @@ -13,7 +13,10 @@ fi
>  
>  # skip the test if the hardware doesn't support branch stack sampling
>  # and if the architecture doesn't support filter types: any,save_type,u
> -perf record -b -o- -B --branch-filter any,save_type,u true > /dev/null 2>&1 || exit 2
> +if ! perf record -o- --no-buildid --branch-filter any,save_type,u -- true > /dev/null 2>&1 ; then
> +	echo "skip: system doesn't support filter types: any,save_type,u"
> +	exit 2
> +fi
>  
>  TMPDIR=$(mktemp -d /tmp/__perf_test.program.XXXXX)
>  
> diff --git a/tools/perf/util/parse-branch-options.c b/tools/perf/util/parse-branch-options.c
> index 00588b9db474..31faf2bb49ff 100644
> --- a/tools/perf/util/parse-branch-options.c
> +++ b/tools/perf/util/parse-branch-options.c
> @@ -102,8 +102,10 @@ parse_branch_stack(const struct option *opt, const char *str, int unset)
>  	/*
>  	 * cannot set it twice, -b + --branch-filter for instance
>  	 */
> -	if (*mode)
> +	if (*mode) {
> +		pr_err("Error: Can't use --branch-any (-b) with --branch-filter (-j).\n");
>  		return -1;
> +	}
>  
>  	return parse_branch_str(str, mode);
>  }

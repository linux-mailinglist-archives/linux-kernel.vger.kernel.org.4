Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7050C621E2D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 22:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiKHVBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 16:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiKHVA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 16:00:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E3A6069C;
        Tue,  8 Nov 2022 13:00:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAD686178B;
        Tue,  8 Nov 2022 21:00:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32294C433D6;
        Tue,  8 Nov 2022 21:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667941257;
        bh=TbBcZqlA9hZFZiK0znBTp3l6Bdf+6JHPlXaM56tzaKU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aKgCKTgU7ie+MzsF6DWCsZpUD2ScDZUag5Njqwow4yXbpmn9SUX4LfDt1MZy2QiPO
         zHDl6Oe9NzmhyaZgN4nTtwbmqvw0ZmikDjKDtD/suwTes1/Y45WLZVF2as/LZVbZz2
         QCBlmT+P8LULdn8Gut7KKw2QsLlA8I+YfcSFGGgJZSJoBIoZwU3of49K2n7lYXAwL9
         dXTlPevHC//WO4txEJ/PsCDc/owiQ9n7H+/WBnT3PrAhdjck7iIqpK6j9A865U2tAE
         Z4rtskjdhF0aMkg9WQFoM63evwRvDYuSFjuz4wjhZXHflL1qvYSpJ7Tzq2OEOAhbks
         skwsp3K0wPyKg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DEA3A4034E; Tue,  8 Nov 2022 18:00:54 -0300 (-03)
Date:   Tue, 8 Nov 2022 18:00:54 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     James Clark <james.clark@arm.com>,
        LKML <linux-kernel@vger.kernel.org>, Anshuman.Khandual@arm.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf test: Fix skipping branch stack sampling test
Message-ID: <Y2rDhkyn9ta5skDm@kernel.org>
References: <20221028121913.745307-1-james.clark@arm.com>
 <2265e166-da9c-f540-a108-0d0b133f7da9@arm.com>
 <F79AE69A-4D87-4F4E-A3FD-EF06A6E12839@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F79AE69A-4D87-4F4E-A3FD-EF06A6E12839@linux.vnet.ibm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 02, 2022 at 12:21:11PM +0530, Athira Rajeev escreveu:
> 
> 
> > On 28-Oct-2022, at 5:52 PM, James Clark <james.clark@arm.com> wrote:
> > 
> > 
> > 
> > On 28/10/2022 13:19, James Clark wrote:
> >> Commit f4a2aade6809 ("perf tests powerpc: Fix branch stack sampling test
> >> to include sanity check for branch filter") added a skip if certain
> >> branch options aren't available. But the change added both -b
> >> (--branch-any) and --branch-filter options at the same time, which will
> >> always result in a failure on any platform because the arguments can't
> >> be used together.
> >> 
> >> Fix this by removing -b (--branch-any) and leaving --branch-filter which
> >> already specifies 'any'. Also add warning messages to the test and perf
> >> tool.
> >> 
> > 
> > Hi Athira,
> > 
> > Are you able to check if this still skips for you on PowerPC with this
> > new change?
> > 
> 
> Hi James,
> 
> Sorry for the late response. I was out on vacation couple of days.
> 
> I tested with the new change and verified it skips on powerpc.
> 
> Tested-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>

Thanks, applied.

- Arnaldo

 
> Thanks
> Athira
> > Thanks
> > James
> > 
> >> Output on x86 before this fix:
> >> 
> >>   $ sudo ./perf test branch
> >>   108: Check branch stack sampling         : Skip
> >> 
> >> After:
> >> 
> >>   $ sudo ./perf test branch
> >>   108: Check branch stack sampling         : Ok
> >> 
> >> Fixes: f4a2aade6809 ("perf tests powerpc: Fix branch stack sampling test to include sanity check for branch filter")
> >> Signed-off-by: James Clark <james.clark@arm.com>
> >> ---
> >> tools/perf/tests/shell/test_brstack.sh | 5 ++++-
> >> tools/perf/util/parse-branch-options.c | 4 +++-
> >> 2 files changed, 7 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/tools/perf/tests/shell/test_brstack.sh b/tools/perf/tests/shell/test_brstack.sh
> >> index ec801cffae6b..d7ff5c4b4da4 100755
> >> --- a/tools/perf/tests/shell/test_brstack.sh
> >> +++ b/tools/perf/tests/shell/test_brstack.sh
> >> @@ -13,7 +13,10 @@ fi
> >> 
> >> # skip the test if the hardware doesn't support branch stack sampling
> >> # and if the architecture doesn't support filter types: any,save_type,u
> >> -perf record -b -o- -B --branch-filter any,save_type,u true > /dev/null 2>&1 || exit 2
> >> +if ! perf record -o- --no-buildid --branch-filter any,save_type,u -- true > /dev/null 2>&1 ; then
> >> +	echo "skip: system doesn't support filter types: any,save_type,u"
> >> +	exit 2
> >> +fi
> >> 
> >> TMPDIR=$(mktemp -d /tmp/__perf_test.program.XXXXX)
> >> 
> >> diff --git a/tools/perf/util/parse-branch-options.c b/tools/perf/util/parse-branch-options.c
> >> index 00588b9db474..31faf2bb49ff 100644
> >> --- a/tools/perf/util/parse-branch-options.c
> >> +++ b/tools/perf/util/parse-branch-options.c
> >> @@ -102,8 +102,10 @@ parse_branch_stack(const struct option *opt, const char *str, int unset)
> >> 	/*
> >> 	 * cannot set it twice, -b + --branch-filter for instance
> >> 	 */
> >> -	if (*mode)
> >> +	if (*mode) {
> >> +		pr_err("Error: Can't use --branch-any (-b) with --branch-filter (-j).\n");
> >> 		return -1;
> >> +	}
> >> 
> >> 	return parse_branch_str(str, mode);
> >> }

-- 

- Arnaldo

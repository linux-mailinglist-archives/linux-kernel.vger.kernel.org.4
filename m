Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5706E9264
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 13:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234333AbjDTLZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 07:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234232AbjDTLZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 07:25:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDFD7EE2;
        Thu, 20 Apr 2023 04:24:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A9F4615C8;
        Thu, 20 Apr 2023 11:23:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1EEEC433D2;
        Thu, 20 Apr 2023 11:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681989827;
        bh=jXACc+L1gNDsC8WHEpEt3sv4ju+THNheaCP19iu7+kc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VDfaP9sMJBv4XZlDvCF+L3NIL8S0vLhEDyxGW5wPDHc4W4FtG39RQiMN+ueGJm/aX
         Z8vtacFBJgR/bIjS/WNirtwYl8Pt/bz03XnLbEBnoepIxn9mg0uIVXSWSj0cdwlqtx
         S1Dw4FCIgN94ybquFSoEs4pnncjfvmZO2eHnK6ojBpjNbOmmA+jCqQq4enF/GjoqDZ
         P1I4jsW+SZced8lVKZ7RiXBbCZ2pU2RzWyEDc0jjORk2UQ9eq8y+i4YEjNL58urSFs
         AQaoa3UbwIvijNgRGgOWRyl8YGBbpLLPLE9eeeaX+8hPjfrYC3Pi61s1YfrO2AOsE/
         OoIDI/efGgEbw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D6D99403B5; Thu, 20 Apr 2023 08:23:44 -0300 (-03)
Date:   Thu, 20 Apr 2023 08:23:44 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf test: Fix maps use after put
Message-ID: <ZEEgwKYMaA9iTgFA@kernel.org>
References: <20230420030430.489243-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420030430.489243-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 19, 2023 at 08:04:30PM -0700, Ian Rogers escreveu:
> Fix a use after put reference count issue. maps is copied from leader,
> but the leader is put on line 79 and then maps is used to read the
> reference count below - so a use after put, with the put of maps
> happening within thread__put. Fix by reversing the order of puts so
> that the leader is put last.
> 
> To explain the reference count checker, I wrote this up as a little
> example here:
> https://perf.wiki.kernel.org/index.php/Reference_Count_Checking
> 
> Note, the bug was introduced by the committer and wasn't present in
> the original reference count patch set.

Yes, the bug predated your patch and is detected by the reference count
checking you contributed. 

This was just part of splitting up your series into smaller chunks, in
this case either we fix the problem detected while developing this
reference counting infrastructure or fix it later after the merged
infrastructure, when built with EXTRA_CFLAGS="-DREFCNT_CHECKING=1"
detects it when running 'perf test'.

Thanks for providing the separate patch fixing it.

Applied.

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/thread-maps-share.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/tests/thread-maps-share.c b/tools/perf/tests/thread-maps-share.c
> index 75ce8aedfc78..858e725318a9 100644
> --- a/tools/perf/tests/thread-maps-share.c
> +++ b/tools/perf/tests/thread-maps-share.c
> @@ -76,16 +76,16 @@ static int test__thread_maps_share(struct test_suite *test __maybe_unused, int s
>  	TEST_ASSERT_VAL("maps don't match", RC_CHK_ACCESS(other_maps) == RC_CHK_ACCESS(other_leader->maps));
>  
>  	/* release thread group */
> -	thread__put(leader);
> +	thread__put(t3);
>  	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(maps__refcnt(maps)), 3);
>  
> -	thread__put(t1);
> +	thread__put(t2);
>  	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(maps__refcnt(maps)), 2);
>  
> -	thread__put(t2);
> +	thread__put(t1);
>  	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(maps__refcnt(maps)), 1);
>  
> -	thread__put(t3);
> +	thread__put(leader);
>  
>  	/* release other group  */
>  	thread__put(other_leader);
> -- 
> 2.40.0.634.g4ca3ef3211-goog
> 

-- 

- Arnaldo

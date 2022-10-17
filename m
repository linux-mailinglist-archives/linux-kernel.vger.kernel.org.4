Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050D3601DB0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 01:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiJQXiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 19:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbiJQXiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 19:38:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008F8857D4;
        Mon, 17 Oct 2022 16:38:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E165612DC;
        Mon, 17 Oct 2022 23:38:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C676DC433C1;
        Mon, 17 Oct 2022 23:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666049892;
        bh=MlBnouHryaZbiw/93+me4ojj1DJ4whBS7dUdANGIhOU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ds4uccgRrpkr/UI3TrihXNnk4oluADnAMxef1aeu0RK+x8oeBp7saNgL73nidKfWf
         zeCaKLbvMIYeQbwbAwrmYivo+qu9bpoUsIY7aXJKvb7AXe70civYScJJpzml32/pGo
         qe8QHicr9T9QvrqCDdLV6UHJ6uDc9dp2agf50WZwQEGRYgrvfkO5EmIRIlPZK8oDCm
         1fBHB9UhRfEXwgoeZNbB1slzhVj8SnXb52hTdu53jNWrfHzML4lmriYTdr6WeCg2Pj
         bViRTE8ys2wXmXa04ajb5EC423TsCWglNfszCVN6u89jqyx7gI97eU+0nP4z0HTMkD
         tj/AJae0GwGtg==
From:   SeongJae Park <sj@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     sj@kernel.org, linux-perf-users@vger.kernel.org,
        peterz@infradead.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH] perf: Fix missing raw data on tracepoint events
Date:   Mon, 17 Oct 2022 23:38:09 +0000
Message-Id: <20221017233809.1476-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221012143857.48198-1-james.clark@arm.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Oct 2022 15:38:57 +0100 James Clark <james.clark@arm.com> wrote:

> Since commit 838d9bb62d13 ("perf: Use sample_flags for raw_data")
> raw data is not being output on tracepoints due to the PERF_SAMPLE_RAW
> field not being set. Fix this by setting it for tracepoint events.

I was also getting similar issue[1], and confirmed that this fixes it.  Thank
you for the fix!  Also, thank you for pointing me to this patch, Namhyung!

> 
> This fixes the following test failure:
> 
>   perf test "sched_switch" -vvv
> 
>    35: Track with sched_switch
>   --- start ---
>   test child forked, pid 1828
>   ...
>   Using CPUID 0x00000000410fd400
>   sched_switch: cpu: 2 prev_tid -14687 next_tid 0
>   sched_switch: cpu: 2 prev_tid -14687 next_tid 0
>   Missing sched_switch events
>   4613 events recorded
>   test child finished with -1
>   ---- end ----
>   Track with sched_switch: FAILED!
> 
> Fixes: 838d9bb62d13 ("perf: Use sample_flags for raw_data")
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: James Clark <james.clark@arm.com>

Tested-by: SeongJae Park <sj@kernel.org>


[1] https://lore.kernel.org/bpf/20221017192744.1403-1-sj@kernel.org/

Thanks,
SJ

> ---
>  kernel/events/core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index b981b879bcd8..824c23830272 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -9759,6 +9759,7 @@ void perf_tp_event(u16 event_type, u64 count, void *record, int entry_size,
>  
>  	perf_sample_data_init(&data, 0, 0);
>  	data.raw = &raw;
> +	data.sample_flags |= PERF_SAMPLE_RAW;
>  
>  	perf_trace_buf_update(record, event_type);
>  
> -- 
> 2.28.0

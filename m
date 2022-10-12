Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E4B5FC987
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 18:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiJLQwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 12:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiJLQwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 12:52:46 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E3DE0729;
        Wed, 12 Oct 2022 09:52:45 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id l5so19702023oif.7;
        Wed, 12 Oct 2022 09:52:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S/5xq2x209F1HQNndofzRRLO7+fGWFD7vQy4M5xyyDo=;
        b=1gVhmmi6hlg5BVqoQbRfIzeiSW56V1QoPdbjP0jLFKLGCxLzQ9s+77DVbeaXiXENMt
         gnsYbrdVnbffsNpxYdCXDQsgxeYT9NW741tzW8SDhWka6twuyZCOA2XINn7398QRJy1b
         iUukZisJpZ1/2akPQNMaEl3nL60pZXsAp/juPajX4Q08hOB4bdx+g6dTQoyWrgkqqzzi
         Yx+gF8IGvfaTF9BqZckCPkB0pnd9CH3Ft547UTvJC3JodeablpUiV7uoMPkfH1wpO90V
         78t1UA5JbJvH1Q0QVyn63aBzrfprvdYR+nyBqvPWP2+f/+4lUDRzAGOzQ/H4GTf35bti
         i3Kw==
X-Gm-Message-State: ACrzQf02GEma37xa9f1zq14AnnZXTaIrqmcFhwEZn4DJGDsirG6cO/h/
        uU9/ZpAosSpnhvL0fSR59NUTrFvGcV35PsN6XqY=
X-Google-Smtp-Source: AMsMyM43MdzORV1T5jtpSttpjtA28n05iNg+hBMk1ZV5r23rVBY1RkUq+3J9Wn0elJUoaksJBoCR3qAtncnR0kHmL/E=
X-Received: by 2002:a05:6808:1a09:b0:350:107b:f89a with SMTP id
 bk9-20020a0568081a0900b00350107bf89amr2644451oib.218.1665593564509; Wed, 12
 Oct 2022 09:52:44 -0700 (PDT)
MIME-Version: 1.0
References: <20221012143857.48198-1-james.clark@arm.com>
In-Reply-To: <20221012143857.48198-1-james.clark@arm.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 12 Oct 2022 09:52:33 -0700
Message-ID: <CAM9d7chCQRKwFoQ5OOXzqMvu5t9HamS3z9DdgaDgqCjPiD8G2A@mail.gmail.com>
Subject: Re: [PATCH] perf: Fix missing raw data on tracepoint events
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users <linux-perf-users@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 7:39 AM James Clark <james.clark@arm.com> wrote:
>
> Since commit 838d9bb62d13 ("perf: Use sample_flags for raw_data")
> raw data is not being output on tracepoints due to the PERF_SAMPLE_RAW
> field not being set. Fix this by setting it for tracepoint events.
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
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: James Clark <james.clark@arm.com>

Ouch.. thanks for the fix.

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


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
>         perf_sample_data_init(&data, 0, 0);
>         data.raw = &raw;
> +       data.sample_flags |= PERF_SAMPLE_RAW;
>
>         perf_trace_buf_update(record, event_type);
>
> --
> 2.28.0
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5F66A76CB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 23:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjCAW3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 17:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjCAW3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 17:29:50 -0500
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB8A2CC71
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 14:29:48 -0800 (PST)
Received: by mail-io1-f47.google.com with SMTP id y140so6024311iof.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 14:29:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677709788;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4XN5E5E+YGIwxeo2G8pzSmu44TfRDtKN+C0QGnvG8dg=;
        b=YeG+27iFPW27EX9HxNC0cQfl/15Ds7NSg0QmHr0tplVZxs9vr5Yk+Cn3BUiM/rgKzB
         Yx+3AVgtIJ5SIfM6SY+db6rHEBJyYni4xaeYK8yLCK/24tlj6jcKkjtg+UWu1MzIBsxG
         /1IPpF/vintXgnxqB21INciOe3P8KYbQUAR5pvi4op9PcU7Pbbv6dNHCV/+DPIudloOj
         qqSkC9zdF6x91x43JtY1L5VZ9HXDIqzOweQFf4Mae6Tz7Pag813FoTHRFyZAPenSLMNJ
         cI8Y8LqnVFpICV6np2+7m2xQcrxxN35B6dQbBFcrUdo4lxoinKmGQRWMnr/sTm/ChT90
         k6kA==
X-Gm-Message-State: AO0yUKW949g77/M0QT+WjKcjbR1M19r7hIpX46RPzVMHVRl4GmMTMjim
        yusb8YXJ+DRWK61Dmum3PQH1bL2x3hpDODGkkAM=
X-Google-Smtp-Source: AK7set9/mPzPtsWa76f/nOBr4j1cloWY6mw1ORnKgloQbCLfFpSJTdoT7LV0kPyVWY/i/X31Np/jXGrr0oNK9SXGfNY=
X-Received: by 2002:a6b:ee19:0:b0:745:405d:b703 with SMTP id
 i25-20020a6bee19000000b00745405db703mr3693612ioh.3.1677709788058; Wed, 01 Mar
 2023 14:29:48 -0800 (PST)
MIME-Version: 1.0
References: <20230228192145.2120675-1-song@kernel.org>
In-Reply-To: <20230228192145.2120675-1-song@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 1 Mar 2023 14:29:36 -0800
Message-ID: <CAM9d7chLaXDU4mMkD1U6YuOGZXcu7PFWGOuEkFKSkbrCLS+zWg@mail.gmail.com>
Subject: Re: [PATCH] perf: fix perf_event_context->time
To:     Song Liu <song@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Peter Zijlstra <peterz@infradead.org>
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

Hi Song,

On Tue, Feb 28, 2023 at 11:22 AM Song Liu <song@kernel.org> wrote:
>
> Time readers rely on perf_event_context->[time|timestamp|timeoffset] to get
> accurate time_enabled and time_running for an event. The difference between
> ctx->timestamp and ctx->time is the among of time when the context is not
> enabled. For cpuctx.ctx, time and timestamp should stay the same, however,

I'm not sure if it's correct.  The timestamp can go when the context is disabled
for example, in ctx_resched() even if the NMI watchdog is enabled, right?

> it is not the case at the moment. To show this with drgn [1]:
>
>     drgn 0.0.22 (using Python 3.8.6, elfutils 0.185, with libkdumpfile)
>     For help, type help(drgn).
>     ...
>     >>> ctx = per_cpu_ptr(prog['pmu'].pmu_cpu_context, 0).ctx
>     >>> ctx.timestamp * 1.0 / ctx.time
>     (double)1.0385869134111765
>     >>>
>
> ctx->timestamp is about 4% larger than ctx.time. This issue causes time
> read by perf_event_read_local() goes back in some cases.

I don't think the difference between the ctx.time and the timestamp
itself is a problem.  I think the problem is it CAN update the timestamp
(and the timeoffset) while the context is enabled.  Then depending on
the timing, event times can return smaller values than before.

>
> Fix this by updating the condition for __update_context_time(ctx, false).
> Specifically, it should only be called when we enable EVENT_TIME for the
> ctx.

So this change fixes the condition to update the timestamp only if
it moves from disabled to enabled state.

>
> [1] drgn: https://github.com/osandov/drgn
> Fixes: 09f5e7dc7ad7 ("perf: Fix perf_event_read_local() time")
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Song Liu <song@kernel.org>

Actually I got some similar reports lately but couldn't find time to
dig in deeply.  Thanks for the fix!

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  kernel/events/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 380476a934e8..67478f43e26e 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -3872,7 +3872,7 @@ ctx_sched_in(struct perf_event_context *ctx, enum event_type_t event_type)
>         if (likely(!ctx->nr_events))
>                 return;
>
> -       if (is_active ^ EVENT_TIME) {
> +       if (!(is_active & EVENT_TIME)) {
>                 /* start ctx time */
>                 __update_context_time(ctx, false);
>                 perf_cgroup_set_timestamp(cpuctx);
> --
> 2.30.2
>

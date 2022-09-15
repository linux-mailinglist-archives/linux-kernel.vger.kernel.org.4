Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C123B5B9FC6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 18:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiIOQle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 12:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiIOQlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 12:41:32 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5234D4F3B4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 09:41:30 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-127ba06d03fso48329821fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 09:41:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=C1FrMtKA4pBBKcaZOKqszlDUi5Nv8jC2XZMYweIIehA=;
        b=cMS8ncuT31cmql0FE9bPTF/8lAKQPdAnBIWw9Yt83IZPvBlhglQjL22sXA5SHuCuAj
         dRAKHAWDZogffprn9p2yXQeTi+tLQfYA2fr/ldl0i/QjFkDyRo3P1Au0FXA3WXMKd+bo
         Wz55TpKpHV3CTsLe6FHP69ysKnKg9THXWPwiqe3IrxN5HTOomvsBrddKqOanA5ZqPqA1
         KZBM9OCjuzFE6/gaAtZm304PLWSn8Qy8Lq5tm398A5/c+s8OugxDP9p1OCUdDhDMnkVB
         y4H+C2QffjQviWYRDC685UP43jmzaC5knb0oVZ5IQ4GWv2YcCGtB80WzIk1dL7gLg5it
         vuVg==
X-Gm-Message-State: ACrzQf0dPX4UEwGQ1KrSA646lGcb4KRyzMYnA5fd0GId6ANd7QwH86Zd
        11AX83p1cNVdoT4bnARyLHGyAxhCN9MX4mqcQj8=
X-Google-Smtp-Source: AMsMyM4KQSBYTM840gLemcZE2Ad0qtRJKan7THg93fappxP0K2D5vh9+vkkuLwdqEMP/ojt7JK/gwlKCLiBZEI71Kec=
X-Received: by 2002:a05:6870:a70f:b0:127:666a:658 with SMTP id
 g15-20020a056870a70f00b00127666a0658mr311868oam.218.1663260089593; Thu, 15
 Sep 2022 09:41:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220902181934.1082647-1-namhyung@kernel.org>
In-Reply-To: <20220902181934.1082647-1-namhyung@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 15 Sep 2022 09:41:18 -0700
Message-ID: <CAM9d7ciLL0Hd1qB1jmfJzWms4d4soo9CXu89uXxm=jF7gUWPEw@mail.gmail.com>
Subject: Re: [PATCH] perf/core: Increase lost_samples count only for samples
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Fri, Sep 2, 2022 at 11:19 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> The event->lost_samples count is intended to count (lost) sample records
> but it's also counted for non-sample records like PERF_RECORD_MMAP etc.
> This can be a problem when a sampling event tracks those side-band
> events together.
>
> As overflow handler for user events only calls perf_output_begin_
> {for,back}ward() before writing to the ring buffer, we can pass an
> additional flag to indicate that it's writing a sample record.

Could you please take a look?

Thanks,
Namhyung


>
> Fixes: 119a784c8127 ("perf/core: Add a new read format to get a number of lost samples")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  kernel/events/ring_buffer.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> index 726132039c38..5f38ee4edbdb 100644
> --- a/kernel/events/ring_buffer.c
> +++ b/kernel/events/ring_buffer.c
> @@ -149,7 +149,7 @@ static __always_inline int
>  __perf_output_begin(struct perf_output_handle *handle,
>                     struct perf_sample_data *data,
>                     struct perf_event *event, unsigned int size,
> -                   bool backward)
> +                   bool backward, bool sample)
>  {
>         struct perf_buffer *rb;
>         unsigned long tail, offset, head;
> @@ -174,7 +174,8 @@ __perf_output_begin(struct perf_output_handle *handle,
>         if (unlikely(rb->paused)) {
>                 if (rb->nr_pages) {
>                         local_inc(&rb->lost);
> -                       atomic64_inc(&event->lost_samples);
> +                       if (sample)
> +                               atomic64_inc(&event->lost_samples);
>                 }
>                 goto out;
>         }
> @@ -256,7 +257,8 @@ __perf_output_begin(struct perf_output_handle *handle,
>
>  fail:
>         local_inc(&rb->lost);
> -       atomic64_inc(&event->lost_samples);
> +       if (sample)
> +               atomic64_inc(&event->lost_samples);
>         perf_output_put_handle(handle);
>  out:
>         rcu_read_unlock();
> @@ -268,14 +270,14 @@ int perf_output_begin_forward(struct perf_output_handle *handle,
>                               struct perf_sample_data *data,
>                               struct perf_event *event, unsigned int size)
>  {
> -       return __perf_output_begin(handle, data, event, size, false);
> +       return __perf_output_begin(handle, data, event, size, false, true);
>  }
>
>  int perf_output_begin_backward(struct perf_output_handle *handle,
>                                struct perf_sample_data *data,
>                                struct perf_event *event, unsigned int size)
>  {
> -       return __perf_output_begin(handle, data, event, size, true);
> +       return __perf_output_begin(handle, data, event, size, true, true);
>  }
>
>  int perf_output_begin(struct perf_output_handle *handle,
> @@ -284,7 +286,7 @@ int perf_output_begin(struct perf_output_handle *handle,
>  {
>
>         return __perf_output_begin(handle, data, event, size,
> -                                  unlikely(is_write_backward(event)));
> +                                  unlikely(is_write_backward(event)), false);
>  }
>
>  unsigned int perf_output_copy(struct perf_output_handle *handle,
> --
> 2.37.2.789.g6183377224-goog
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C33656FC5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 22:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbiL0VKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 16:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbiL0VJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 16:09:16 -0500
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BE5DEB3;
        Tue, 27 Dec 2022 13:06:06 -0800 (PST)
Received: by mail-io1-f44.google.com with SMTP id h6so7428647iof.9;
        Tue, 27 Dec 2022 13:06:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vv+ZjSlUuwa317vbQX/rH0BLAZD6zsIjkQVH3w5ABrI=;
        b=ofPrzENKSDMOhKOytTnY4pk2WDF2jJNabvG1NNyZ0t+nDUODMzO0KnzFOhuIxNl/Al
         AVlNQNEAKivhHsdAOE3zhunzNWNCKqBsSGZUT7pg0ly2T2dRVdYfTpzj5YuQZ1RsRHX4
         inZqV5J+YOVQpMzMFf2X2Q8AX6SF7NannlgJuXLSOmePGBV1ftBp1lS5+9/Dt9lSUyXp
         YMRl3sBOkoQcjvMlpvZckvgwk09pAFysWK6sRQZpHaMgtYaH2MwDLSFbYOsysIqRER14
         nuOEIl3uauDrzuRqVAv1tRJkckxsrmBKWaIueqjgftUM4pabOWwAqohi2ZQV9qmi5xTa
         4lPw==
X-Gm-Message-State: AFqh2krwlOxHsxPMImAZHmRwl1s964f5Eni80lBVaFzAwAbBPPaqK5o2
        nB+H1AXKc+sGMc0wyiPYeeWUSOGpSPdS0egBfou7qHhvG7Y=
X-Google-Smtp-Source: AMrXdXvqUTIEjJrVWh/GKZcTQ0dBCWvu6Y4+VwEEP+Yr6/xefP8UNRmpiD7FCKGXfsOEVS1BrX2uGnQTfeQAIZ36d9Q=
X-Received: by 2002:a02:8562:0:b0:38a:4fbc:b85a with SMTP id
 g89-20020a028562000000b0038a4fbcb85amr1858364jai.277.1672175166010; Tue, 27
 Dec 2022 13:06:06 -0800 (PST)
MIME-Version: 1.0
References: <20221227130701.124278-1-yangjihong1@huawei.com>
In-Reply-To: <20221227130701.124278-1-yangjihong1@huawei.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 27 Dec 2022 13:05:54 -0800
Message-ID: <CAM9d7chDPQ9_J5=XLWbhp2AztiyVwTaRjTf20reCdriseTvX_A@mail.gmail.com>
Subject: Re: [PATCH] perf record: Fix coredump with --overwrite and --max-size
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, jiwei.sun@windriver.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2022 at 5:10 AM Yang Jihong <yangjihong1@huawei.com> wrote:
>
> When --overwrite and --max-size options of perf record are used together,
> a segmentation fault occurs. The following is an example:
>
>  # perf record -e sched:sched* --overwrite --max-size 1M -a -- sleep 1
>   [ perf record: Woken up 1 times to write data ]
>   perf: Segmentation fault
>   Obtained 1 stack frames.
>   [0xc4c67f]
>   Segmentation fault (core dumped)
>
> backtrace of the core file is as follows:
>
>   #0  0x0000000000417990 in process_locked_synthesized_event (tool=0x0, event=0x15, sample=0x1de0, machine=0xf8) at builtin-record.c:630
>   #1  0x000000000057ee53 in perf_event__synthesize_threads (nr_threads_synthesize=21, mmap_data=<optimized out>, needs_mmap=<optimized out>, machine=0x17ad9b0, process=<optimized out>, tool=0x0) at util/synthetic-events.c:1950
>   #2  __machine__synthesize_threads (nr_threads_synthesize=0, data_mmap=<optimized out>, needs_mmap=<optimized out>, process=<optimized out>, threads=0x8, target=0x8, tool=0x0, machine=0x17ad9b0) at util/synthetic-events.c:1936
>   #3  machine__synthesize_threads (machine=0x17ad9b0, target=0x8, threads=0x8, needs_mmap=<optimized out>, data_mmap=<optimized out>, nr_threads_synthesize=0) at util/synthetic-events.c:1947
>   #4  0x000000000040165d in record__synthesize (tail=<optimized out>, rec=0xbe2520 <record>) at builtin-record.c:2010
>   #5  0x0000000000403989 in __cmd_record (argc=<optimized out>, argv=<optimized out>, rec=0xbe2520 <record>) at builtin-record.c:2810
>   #6  0x00000000004196ba in record__init_thread_user_masks (rec=0xbe2520 <record>, cpus=0x17a65f0) at builtin-record.c:3837
>   #7  record__init_thread_masks (rec=0xbe2520 <record>) at builtin-record.c:3938
>   #8  cmd_record (argc=1, argv=0x7ffdd692dc60) at builtin-record.c:4241
>   #9  0x00000000004b701d in pager_command_config (var=0x0, value=0x15 <error: Cannot access memory at address 0x15>, data=0x1de0) at perf.c:117
>   #10 0x00000000004b732b in get_leaf_frame_caller_aarch64 (sample=0xfffffffb, thread=0x0, usr_idx=<optimized out>) at util/arm64-frame-pointer-unwind-support.c:56
>   #11 0x0000000000406331 in execv_dashed_external (argv=0x7ffdd692d9e8) at perf.c:410
>   #12 run_argv (argcp=<synthetic pointer>, argv=<synthetic pointer>) at perf.c:431
>   #13 main (argc=<optimized out>, argv=0x7ffdd692d9e8) at perf.c:562

I'm not sure this callstack is correct.

>
> The reason is that record__bytes_written accesses the freed memory rec->thread_data,
> The process is as follows:
>   __cmd_record
>     -> record__free_thread_data
>       -> zfree(&rec->thread_data)         // free rec->thread_data
>     -> record__synthesize
>       -> perf_event__synthesize_id_index
>         -> process_synthesized_event
>           -> record__write
>             -> record__bytes_written     // access rec->thread_data
>
> In the overwrite scenario, to synthesize non-sample events,
> we do not need to check perf size limit.

Hmm.. I think we should prevent this kind of access after
record__free_thread_data().  We may set nr_threads to 0
and save the bytes_written for threads separately.

Thanks,
Namhyung


>
> Fixes: 6d57581659f7 ("perf record: Add support for limit perf output file size")
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> ---
>  tools/perf/builtin-record.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 29dcd454b8e2..c5f169150d63 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -260,7 +260,7 @@ static int record__write(struct record *rec, struct mmap *map __maybe_unused,
>         else
>                 rec->bytes_written += size;
>
> -       if (record__output_max_size_exceeded(rec) && !done) {
> +       if (!rec->opts.tail_synthesize && record__output_max_size_exceeded(rec) && !done) {
>                 fprintf(stderr, "[ perf record: perf size limit reached (%" PRIu64 " KB),"
>                                 " stopping session ]\n",
>                                 record__bytes_written(rec) >> 10);
> --
> 2.17.1
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F080664C55
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 20:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238723AbjAJTW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 14:22:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239824AbjAJTWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 14:22:36 -0500
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FBA532A8;
        Tue, 10 Jan 2023 11:22:07 -0800 (PST)
Received: by mail-il1-f181.google.com with SMTP id o8so6907578ilo.1;
        Tue, 10 Jan 2023 11:22:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5/BwFuyLCE0YC1VrRpwJaeR7r7nd3662buUSc8fCkUI=;
        b=5VP5i27Uvdn9Lh3+qRCD+l4Igt+dpFynedHAR30bS3l+9Tu/Z9imYjsKS81nfFiHoq
         orAAZefVx7WIPZ8sL3SH45JObW41zBClbe08k19sy6XxZxuCkiEFa4wi+xY95vpIn9UT
         d1R5qk9EqtV0mIO3QmSg57ZjxbkZmqlHleWU6qpNJ1dYHibjbZjITRKvp9GSAonj8vNP
         SdpndErkJAgXSfaI+h3Ow2Xu97omhd7+FkPaxCCM1Jrl8R+age8wK5wwDcE+m4BnxV7u
         7JGZizUttDXLQUQasaMqGYmI/AaNfEtAv5Az2ylqdLb/LadtD4Leb/6mdubb89S+rx5c
         NEMQ==
X-Gm-Message-State: AFqh2kp35TsvyTDU2V0rhyLDz8sgS+L6p5FuYRVegFlhcYxNNIRc5gCZ
        asWH+rMxvfTDWdjrqlWxgB1UNjN+gk2ADc8ZcxM=
X-Google-Smtp-Source: AMrXdXsr7ZyRaSv3Qvyf8BTVSfrRv/hiuZCYOq0HzBRir5P+aNyn6502oWYzIRYKx7YcN572l8lpXKRoJiecVTnX9Ls=
X-Received: by 2002:a92:ce03:0:b0:30a:d251:a313 with SMTP id
 b3-20020a92ce03000000b0030ad251a313mr7822836ilo.83.1673378526489; Tue, 10 Jan
 2023 11:22:06 -0800 (PST)
MIME-Version: 1.0
References: <20221229124728.66515-1-yangjihong1@huawei.com>
 <Y7MEWK/z19QCaNoi@kernel.org> <CAM9d7cjcWKBephb5p9ZPU2+wDAz04DYQJoKczORioD=es10hPw@mail.gmail.com>
 <c65f89ef-173c-b828-f3b2-266387903149@huawei.com> <CAM9d7chN9ecR7EgA1eN1QQXypZDwCFC-ym6BTQ0d1_XjuruLFw@mail.gmail.com>
 <a08af34e-acf2-d370-06bb-ea43d467f89d@huawei.com>
In-Reply-To: <a08af34e-acf2-d370-06bb-ea43d467f89d@huawei.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 10 Jan 2023 11:21:54 -0800
Message-ID: <CAM9d7ci_TRrqBQVQNW8=GwakUr7SsZpYxaaty-S4bxF8zJWyqw@mail.gmail.com>
Subject: Re: [PATCH v2] perf record: Fix coredump with --overwrite and --max-size
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        jiwei.sun@windriver.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Sun, Jan 8, 2023 at 6:47 PM Yang Jihong <yangjihong1@huawei.com> wrote:
>
> Hello,
>
> On 2023/1/7 5:12, Namhyung Kim wrote:
> > Hello,
> >
> > On Wed, Jan 4, 2023 at 8:09 PM Yang Jihong <yangjihong1@huawei.com> wrote:
> >>
> >> Hello,
> >>
> >> On 2023/1/4 0:50, Namhyung Kim wrote:
> >>> On Mon, Jan 2, 2023 at 8:20 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >>>>
> >>>> Em Thu, Dec 29, 2022 at 12:47:28PM +0000, Yang Jihong escreveu:
> >>>>> When --overwrite and --max-size options of perf record are used together,
> >>>>> a segmentation fault occurs. The following is an example:
> >>>>>
> >>>>>    # perf record -e sched:sched* --overwrite --max-size 1M -a -- sleep 1
> >>>>>     [ perf record: Woken up 1 times to write data ]
> >>>>>     perf: Segmentation fault
> >>>>>     Obtained 1 stack frames.
> >>>>>     [0xc4c67f]
> >>>>>     Segmentation fault (core dumped)
> >>>>>
> >>>>> backtrace of the core file is as follows:
> >>>>>
> >>>>>     #0  0x0000000000417990 in process_locked_synthesized_event (tool=0x0, event=0x15, sample=0x1de0, machine=0xf8) at builtin-record.c:630
> >>>>>     #1  0x000000000057ee53 in perf_event__synthesize_threads (nr_threads_synthesize=21, mmap_data=<optimized out>, needs_mmap=<optimized out>, machine=0x17ad9b0, process=<optimized out>, tool=0x0) at util/synthetic-events.c:1950
> >>>>>     #2  __machine__synthesize_threads (nr_threads_synthesize=0, data_mmap=<optimized out>, needs_mmap=<optimized out>, process=<optimized out>, threads=0x8, target=0x8, tool=0x0, machine=0x17ad9b0) at util/synthetic-events.c:1936
> >>>>>     #3  machine__synthesize_threads (machine=0x17ad9b0, target=0x8, threads=0x8, needs_mmap=<optimized out>, data_mmap=<optimized out>, nr_threads_synthesize=0) at util/synthetic-events.c:1947
> >>>>>     #4  0x000000000040165d in record__synthesize (tail=<optimized out>, rec=0xbe2520 <record>) at builtin-record.c:2010
> >>>>>     #5  0x0000000000403989 in __cmd_record (argc=<optimized out>, argv=<optimized out>, rec=0xbe2520 <record>) at builtin-record.c:2810
> >>>>>     #6  0x00000000004196ba in record__init_thread_user_masks (rec=0xbe2520 <record>, cpus=0x17a65f0) at builtin-record.c:3837
> >>>>>     #7  record__init_thread_masks (rec=0xbe2520 <record>) at builtin-record.c:3938
> >>>>>     #8  cmd_record (argc=1, argv=0x7ffdd692dc60) at builtin-record.c:4241
> >>>>>     #9  0x00000000004b701d in pager_command_config (var=0x0, value=0x15 <error: Cannot access memory at address 0x15>, data=0x1de0) at perf.c:117
> >>>>>     #10 0x00000000004b732b in get_leaf_frame_caller_aarch64 (sample=0xfffffffb, thread=0x0, usr_idx=<optimized out>) at util/arm64-frame-pointer-unwind-support.c:56
> >>>>>     #11 0x0000000000406331 in execv_dashed_external (argv=0x7ffdd692d9e8) at perf.c:410
> >>>>>     #12 run_argv (argcp=<synthetic pointer>, argv=<synthetic pointer>) at perf.c:431
> >>>>>     #13 main (argc=<optimized out>, argv=0x7ffdd692d9e8) at perf.c:562
> >>>>>
> >>>>> The reason is that record__bytes_written accesses the freed memory rec->thread_data,
> >>>>> The process is as follows:
> >>>>>     __cmd_record
> >>>>>       -> record__free_thread_data
> >>>>>         -> zfree(&rec->thread_data)         // free rec->thread_data
> >>>>>       -> record__synthesize
> >>>>>         -> perf_event__synthesize_id_index
> >>>>>           -> process_synthesized_event
> >>>>>             -> record__write
> >>>>>               -> record__bytes_written     // access rec->thread_data
> >>>>>
> >>>>> we only need to check the value of done first.
> >>>>> Also add variable check in record__bytes_written for code hardening,
> >>>>> and save bytes_written separately to reduce one calculation.
> >>>>>
> >>>>> Fixes: 6d57581659f7 ("perf record: Add support for limit perf output file size")
> >>>>> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> >>>>> ---
> >>>>>
> >>>>> Changes since v1:
> >>>>>    - Add variable check in record__bytes_written for code hardening.
> >>>>>    - Save bytes_written separately to reduce one calculation.
> >>>>>    - Remove rec->opts.tail_synthesize check.
> >>>>
> >>>> Namhyung, are you ok with this now?
> >>>>
> >>>> - Arnaldo
> >>>>
> >>>>>    tools/perf/builtin-record.c | 26 +++++++++++++++++---------
> >>>>>    1 file changed, 17 insertions(+), 9 deletions(-)
> >>>>>
> >>>>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> >>>>> index 29dcd454b8e2..acba9e43e519 100644
> >>>>> --- a/tools/perf/builtin-record.c
> >>>>> +++ b/tools/perf/builtin-record.c
> >>>>> @@ -230,16 +230,29 @@ static u64 record__bytes_written(struct record *rec)
> >>>>>         u64 bytes_written = rec->bytes_written;
> >>>>>         struct record_thread *thread_data = rec->thread_data;
> >>>>>
> >>>>> +     if (thread_data == NULL)
> >>>>> +             return bytes_written;
> >>>>> +
> >>>
> >>> Then it won't count bytes written by threads, right?
> >>> I think it needs to be saved somewhere.
> >>>
> >> I'm not sure here. Can you explain it more clearly, thanks :)
> >> I can modify it accordingly.
> >>
> >> I think if thread_data == NULL, it is not thread data.
> >> In this case, we just return rec->bytes_written.
> >
> > It can be thread data but freed before tail synthesis, right?
> > In that case, I think it needs to add bytes_written by threads
> > to calculate the correct data size.
> Em... In the __cmd_record function, record__stop_threads is called
> before record__free_thread_data, so if the thread has been freed, there
> will be no thread data.
> I think it's okay to ignore the situation you mentioned above.

Right, the thread data is already freed, but we need the size.

I think it didn't (and won't) update to rec->bytes_written for the data
written by the threads (data.X file) because it's only for the main
'data' file.  So record__bytes_written() will return a smaller number
after the threads are gone.  But I think it should return the total
data size.

Thanks,
Namhyung

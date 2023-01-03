Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1FB165C440
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 17:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238194AbjACQu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 11:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238131AbjACQuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 11:50:15 -0500
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508B111A21;
        Tue,  3 Jan 2023 08:50:14 -0800 (PST)
Received: by mail-io1-f42.google.com with SMTP id g20so16859459iob.2;
        Tue, 03 Jan 2023 08:50:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mWejrGeSRIlJiaReS6MCqU3ykcYuOMfyT/yrgJKRHfE=;
        b=Dcl9Zb+3xWbB9mtmT7KOgQ/DS/jp72LbqqEqGQs48sk0eSOYAzAmUdfxkx0b/t+0Kq
         9wU2MGWMFMyKEsQXSIDU30Dk4ENBMN22/xVbajOVvnl8tI4a+BaKsVpFsj/Abr2khCg7
         E0aI3ERCi2aWBOuxEi1FaPLwVWDFDbKw84laeEFGbGAdgDwfWbKFV0ETTueC62ksyuNP
         u7/n7N8luLhFQ9AzMZ04IZUVQ0eLudOKtvWz5Z4vm9zFLShrwekMOUfTfgAwBB7USCeB
         ui0u4YW62EB+7f5mnvEo1C+TN53iXVVyLpNcpFgK75gOs3uxL8MtynGOo0XtR/3g9Gq6
         k9kA==
X-Gm-Message-State: AFqh2kpUXJLvBhqMuQqnewMOEqPs05b6G4SZhz+4w2vh9I9ibc0RTBR9
        HIS4NPX+GOcvlVSx+Zr/a9DMpaykeCsQ2F+FS0U=
X-Google-Smtp-Source: AMrXdXsGRcban7+9+RlDswqCmNvApAK7PNpjc5gdFAfrPGp9WyWu6BrHHiaZnzzObalaZDB23HINJV45kkPijVha4Gg=
X-Received: by 2002:a02:c994:0:b0:372:1520:a22a with SMTP id
 b20-20020a02c994000000b003721520a22amr2728983jap.230.1672764613530; Tue, 03
 Jan 2023 08:50:13 -0800 (PST)
MIME-Version: 1.0
References: <20221229124728.66515-1-yangjihong1@huawei.com> <Y7MEWK/z19QCaNoi@kernel.org>
In-Reply-To: <Y7MEWK/z19QCaNoi@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 3 Jan 2023 08:50:02 -0800
Message-ID: <CAM9d7cjcWKBephb5p9ZPU2+wDAz04DYQJoKczORioD=es10hPw@mail.gmail.com>
Subject: Re: [PATCH v2] perf record: Fix coredump with --overwrite and --max-size
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Yang Jihong <yangjihong1@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        jiwei.sun@windriver.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Mon, Jan 2, 2023 at 8:20 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> Em Thu, Dec 29, 2022 at 12:47:28PM +0000, Yang Jihong escreveu:
> > When --overwrite and --max-size options of perf record are used together,
> > a segmentation fault occurs. The following is an example:
> >
> >  # perf record -e sched:sched* --overwrite --max-size 1M -a -- sleep 1
> >   [ perf record: Woken up 1 times to write data ]
> >   perf: Segmentation fault
> >   Obtained 1 stack frames.
> >   [0xc4c67f]
> >   Segmentation fault (core dumped)
> >
> > backtrace of the core file is as follows:
> >
> >   #0  0x0000000000417990 in process_locked_synthesized_event (tool=0x0, event=0x15, sample=0x1de0, machine=0xf8) at builtin-record.c:630
> >   #1  0x000000000057ee53 in perf_event__synthesize_threads (nr_threads_synthesize=21, mmap_data=<optimized out>, needs_mmap=<optimized out>, machine=0x17ad9b0, process=<optimized out>, tool=0x0) at util/synthetic-events.c:1950
> >   #2  __machine__synthesize_threads (nr_threads_synthesize=0, data_mmap=<optimized out>, needs_mmap=<optimized out>, process=<optimized out>, threads=0x8, target=0x8, tool=0x0, machine=0x17ad9b0) at util/synthetic-events.c:1936
> >   #3  machine__synthesize_threads (machine=0x17ad9b0, target=0x8, threads=0x8, needs_mmap=<optimized out>, data_mmap=<optimized out>, nr_threads_synthesize=0) at util/synthetic-events.c:1947
> >   #4  0x000000000040165d in record__synthesize (tail=<optimized out>, rec=0xbe2520 <record>) at builtin-record.c:2010
> >   #5  0x0000000000403989 in __cmd_record (argc=<optimized out>, argv=<optimized out>, rec=0xbe2520 <record>) at builtin-record.c:2810
> >   #6  0x00000000004196ba in record__init_thread_user_masks (rec=0xbe2520 <record>, cpus=0x17a65f0) at builtin-record.c:3837
> >   #7  record__init_thread_masks (rec=0xbe2520 <record>) at builtin-record.c:3938
> >   #8  cmd_record (argc=1, argv=0x7ffdd692dc60) at builtin-record.c:4241
> >   #9  0x00000000004b701d in pager_command_config (var=0x0, value=0x15 <error: Cannot access memory at address 0x15>, data=0x1de0) at perf.c:117
> >   #10 0x00000000004b732b in get_leaf_frame_caller_aarch64 (sample=0xfffffffb, thread=0x0, usr_idx=<optimized out>) at util/arm64-frame-pointer-unwind-support.c:56
> >   #11 0x0000000000406331 in execv_dashed_external (argv=0x7ffdd692d9e8) at perf.c:410
> >   #12 run_argv (argcp=<synthetic pointer>, argv=<synthetic pointer>) at perf.c:431
> >   #13 main (argc=<optimized out>, argv=0x7ffdd692d9e8) at perf.c:562
> >
> > The reason is that record__bytes_written accesses the freed memory rec->thread_data,
> > The process is as follows:
> >   __cmd_record
> >     -> record__free_thread_data
> >       -> zfree(&rec->thread_data)         // free rec->thread_data
> >     -> record__synthesize
> >       -> perf_event__synthesize_id_index
> >         -> process_synthesized_event
> >           -> record__write
> >             -> record__bytes_written     // access rec->thread_data
> >
> > we only need to check the value of done first.
> > Also add variable check in record__bytes_written for code hardening,
> > and save bytes_written separately to reduce one calculation.
> >
> > Fixes: 6d57581659f7 ("perf record: Add support for limit perf output file size")
> > Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> > ---
> >
> > Changes since v1:
> >  - Add variable check in record__bytes_written for code hardening.
> >  - Save bytes_written separately to reduce one calculation.
> >  - Remove rec->opts.tail_synthesize check.
>
> Namhyung, are you ok with this now?
>
> - Arnaldo
>
> >  tools/perf/builtin-record.c | 26 +++++++++++++++++---------
> >  1 file changed, 17 insertions(+), 9 deletions(-)
> >
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index 29dcd454b8e2..acba9e43e519 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -230,16 +230,29 @@ static u64 record__bytes_written(struct record *rec)
> >       u64 bytes_written = rec->bytes_written;
> >       struct record_thread *thread_data = rec->thread_data;
> >
> > +     if (thread_data == NULL)
> > +             return bytes_written;
> > +

Then it won't count bytes written by threads, right?
I think it needs to be saved somewhere.

Thanks,
Namhyung


> >       for (t = 0; t < rec->nr_threads; t++)
> >               bytes_written += thread_data[t].bytes_written;
> >
> >       return bytes_written;
> >  }
> >
> > -static bool record__output_max_size_exceeded(struct record *rec)
> > +static void record__check_output_max_size_exceeded(struct record *rec)
> >  {
> > -     return rec->output_max_size &&
> > -            (record__bytes_written(rec) >= rec->output_max_size);
> > +     u64 bytes_written;
> > +
> > +     if (rec->output_max_size == 0 || done)
> > +             return;
> > +
> > +     bytes_written = record__bytes_written(rec);
> > +     if (bytes_written >= rec->output_max_size) {
> > +             fprintf(stderr, "[ perf record: perf size limit reached (%" PRIu64 " KB),"
> > +                     " stopping session ]\n", bytes_written >> 10);
> > +
> > +             done = 1;
> > +     }
> >  }
> >
> >  static int record__write(struct record *rec, struct mmap *map __maybe_unused,
> > @@ -260,12 +273,7 @@ static int record__write(struct record *rec, struct mmap *map __maybe_unused,
> >       else
> >               rec->bytes_written += size;
> >
> > -     if (record__output_max_size_exceeded(rec) && !done) {
> > -             fprintf(stderr, "[ perf record: perf size limit reached (%" PRIu64 " KB),"
> > -                             " stopping session ]\n",
> > -                             record__bytes_written(rec) >> 10);
> > -             done = 1;
> > -     }
> > +     record__check_output_max_size_exceeded(rec);
> >
> >       if (switch_output_size(rec))
> >               trigger_hit(&switch_output_trigger);
> > --
> > 2.30.GIT
>
> --
>
> - Arnaldo

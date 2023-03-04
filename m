Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480456AA77A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 03:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjCDCAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 21:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCDCAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 21:00:45 -0500
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A451717CDF;
        Fri,  3 Mar 2023 18:00:43 -0800 (PST)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-536bbe5f888so75227877b3.8;
        Fri, 03 Mar 2023 18:00:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677895243;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5mPNNhACcaePShslSruZSyQWxcL1c2PuVcOte264Rko=;
        b=fmpv4tjo0383vu7NbicTh/2vr7GfQNC/IFt3HcCFl2jSPL4/0kHWyquAWcMhEG5RY5
         PBJkvM57JlRB24CDwqpKm+v/bxz9nWybReSniJgd0oYAD5aFyUV9CSosG6pXHEzkHu04
         be6OM8ScWdn//RyLta0DYAmr4YHXB/Wyl8IddqbmZ07C3FEPdYFBMMGYaVZlkMRB+2Ts
         TsB/f5wjN83K4dzSfthf/cCEXdPr0tEYwHXDHTm66MlmIFKGU/0i1Z5Q3/6sWhffC1RD
         XtJabpMjJpCBV9lUIxcqQUOihes8BLcrAusElls/VVwxvbl+z3eKImeCF2kSaQyRVfqB
         S08Q==
X-Gm-Message-State: AO0yUKUsDdxUaMhfmukCSANXzLEkgum3EZDgmGVgmZaqdjfciOjIXljy
        L5pTmgueFwDxwCWuLWs8Nc8NIYApcBlsWgBR2Yo=
X-Google-Smtp-Source: AK7set8TKS2zI0waWBj2l+bnzBQVl0I9oGTUaJhcIMdYpAt27V3gshPDO43VSH8Ley//23BfVFr6Ig0S6766v1+C6xM=
X-Received: by 2002:a81:ae47:0:b0:533:9ffb:cb13 with SMTP id
 g7-20020a81ae47000000b005339ffbcb13mr2153446ywk.3.1677895242776; Fri, 03 Mar
 2023 18:00:42 -0800 (PST)
MIME-Version: 1.0
References: <a60e9257-0874-223c-0cd8-7ab284cd0a1f@huawei.com>
In-Reply-To: <a60e9257-0874-223c-0cd8-7ab284cd0a1f@huawei.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 3 Mar 2023 18:00:30 -0800
Message-ID: <CAM9d7chC4dkKXCK=sg-C8JB-ouqfHmWJqaQMfiP-4Uuk7iDjvA@mail.gmail.com>
Subject: Re: [PATCH] perf top: Fix rare segfault in thread__comm_len()
To:     "liuwenyu (D)" <liuwenyu7@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, irogers@google.com, brauner@kernel.org,
        adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, linfeilong@huawei.com,
        "hewenliang (C)" <hewenliang4@huawei.com>, yeyunfeng@huawei.com
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

Hello,

On Fri, Mar 3, 2023 at 2:02 AM liuwenyu (D) <liuwenyu7@huawei.com> wrote:
>
> In thread__comm_len(),strlen() is called outside of the
> thread->comm_lock critical section,which may cause a UAF
> problems if comm__free() is called by the process_thread
> concurrently.
>
> backtrace of the core file is as follows:
>
>      (gdb) bt
>      #0  __strlen_evex () at ../sysdeps/x86_64/multiarch/strlen-evex.S:77
>      #1  0x000055ad15d31de5 in thread__comm_len (thread=0x7f627d20e300)
> at util/thread.c:320
>      #2  0x000055ad15d4fade in hists__calc_col_len (h=0x7f627d295940,
> hists=0x55ad1772bfe0)
>          at util/hist.c:103
>      #3  hists__calc_col_len (hists=0x55ad1772bfe0, h=0x7f627d295940) at
> util/hist.c:79
>      #4  0x000055ad15d52c8c in output_resort
> (hists=hists@entry=0x55ad1772bfe0, prog=0x0,
>          use_callchain=false, cb=cb@entry=0x0, cb_arg=0x0) at
> util/hist.c:1926
>      #5  0x000055ad15d530a4 in evsel__output_resort_cb
> (evsel=evsel@entry=0x55ad1772bde0,
>          prog=prog@entry=0x0, cb=cb@entry=0x0, cb_arg=cb_arg@entry=0x0)
> at util/hist.c:1945
>      #6  0x000055ad15d53110 in evsel__output_resort
> (evsel=evsel@entry=0x55ad1772bde0,
>          prog=prog@entry=0x0) at util/hist.c:1950
>      #7  0x000055ad15c6ae9a in perf_top__resort_hists
> (t=t@entry=0x7ffcd9cbf4f0) at builtin-top.c:311
>      #8  0x000055ad15c6cc6d in perf_top__print_sym_table
> (top=0x7ffcd9cbf4f0) at builtin-top.c:346
>      #9  display_thread (arg=0x7ffcd9cbf4f0) at builtin-top.c:700
>      #10 0x00007f6282fab4fa in start_thread (arg=<optimized out>) at
> pthread_create.c:443
>      #11 0x00007f628302e200 in clone3 () at
> ../sysdeps/unix/sysv/linux/x86_64/clone3.S:81
>
> The reason is that strlen() get a pointer to a memory that has been freed.
>
> The string pointer is stored in the structure comm_str, which corresponds
> to a rb_tree node,when the node is erased, the memory of the string is
> also freed.
>
> In thread__comm_len(),it gets the pointer within the thread->comm_lock
> critical section,
> but passed to strlen() outside of the thread->comm_lock critical
> section, and the perf
> process_thread may called comm__free() concurrently, cause this segfault
> problem.
>
> The process is as follows:
>
> display_thread                                  process_thread
> --------------                                  --------------
>
> thread__comm_len
>    -> thread__comm_str
>         # held the comm read lock
>      -> __thread__comm_str(thread)
>         # release the comm read lock
>                                                  thread__delete
>                                                       # held the comm
> write lock
>                                                    -> comm__free
>                                                      ->
> comm_str__put(comm->comm_str)
>                                                        -> zfree(&cs->str)
>                                                       # release the comm
> write lock
>        # The memory of the string pointed
>          to by comm has been free.
>      -> thread->comm_len = strlen(comm);
>
> This patch expand the critical section range of thread->comm_lock in
> thread__comm_len(),
> to make strlen() called safe.
>
> Signed-off-by: Wenyu Liu  <liuwenyu7@huawei.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>   tools/perf/util/thread.c | 25 +++++++++++++++++++------
>   1 file changed, 19 insertions(+), 6 deletions(-)
>
> diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
> index e3e5427e1c3c..a2490a20eb56 100644
> --- a/tools/perf/util/thread.c
> +++ b/tools/perf/util/thread.c
> @@ -311,17 +311,30 @@ const char *thread__comm_str(struct thread *thread)
>       return str;
>   }
>
> +static int __thread__comm_len(struct thread *thread, const char *comm)
> +{
> +    if (!comm)
> +        return 0;
> +    thread->comm_len = strlen(comm);
> +
> +    return thread->comm_len;
> +}
> +
>   /* CHECKME: it should probably better return the max comm len from its
> comm list */
>   int thread__comm_len(struct thread *thread)
>   {
> -    if (!thread->comm_len) {
> -        const char *comm = thread__comm_str(thread);
> -        if (!comm)
> -            return 0;
> -        thread->comm_len = strlen(comm);
> +    int comm_len = thread->comm_len;
> +
> +    if (!comm_len) {
> +        const char *comm;
> +
> +        down_read(&thread->comm_lock);
> +        comm = __thread__comm_str(thread);
> +        comm_len = __thread__comm_len(thread, comm);
> +        up_read(&thread->comm_lock);
>       }
>
> -    return thread->comm_len;
> +    return comm_len;
>   }
>
>   size_t thread__fprintf(struct thread *thread, FILE *fp)
> --
> 2.36.1
>

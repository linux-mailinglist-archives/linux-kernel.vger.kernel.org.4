Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E9C6099DE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 07:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiJXFdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 01:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbiJXFdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 01:33:45 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B6B7B7AD
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 22:33:44 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 186-20020a1c02c3000000b003c6c154d528so9216305wmc.4
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 22:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FPSIWsFJNQhmUPJF7n8WqvsLFtclPPR/mNLlWiKjkNw=;
        b=p0RUQqe4QJW3SY3M7bsWCZ2VYexAIelrq8fVMVGUOoyFJXI3ly10A6/O7biughp/fe
         vacChmI8FWzktztBzdgR/WH9HKKiSjhOrPtt822hKWTJGspuXgxcX0iUKO0gwQkz7kOW
         4QFrnHDHYZOyjHetGX1ApNuuM/O8XTbiljjoCOfXWk+EdYtKQBr1BuJG+8S004e39n+a
         ocvqnEQepvTRrMpQHnga24NqsEEx/HRVl29/5lAJJMmo+d47OrHrmTTIT8gTOLzbLpAh
         LIfhn6aYl2MZFPHjJoX/M7yoXjxB4qYCNcXJepJILP0mbx0c5SSIPj0T73coY3JeZjuz
         tu4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FPSIWsFJNQhmUPJF7n8WqvsLFtclPPR/mNLlWiKjkNw=;
        b=FPIW0K2aFvyBB+hJNnsU+8bNpppX+YQIhtmdVtAAn6y77WgZcdRBKjp5/1w7ug3wXV
         7dQa5SOdD6C8efes6sPmlPsj5hBo39F/C4PzPlTpv/n+cCsbFlDf+1EZsWfM932RLA5N
         NExR9zhr0IU4ujEz7SZNvsGFIx6w/pt3in4pahDGQr92oEwhJsr33kOyCDiHO9Q/4cbl
         6o63ou6fH9pWksps/Y1R7ZNGXbO19lpXFOfBqjym+tlCEN/5ySnjBP/giyipAUg/ELwM
         LITrYMJBJ6/8tnHjNfb35n5ZhyQkoaXBN4DYA7Q9SJhLQGCC6jxtRHtNZSswG2ck5pJK
         gV7g==
X-Gm-Message-State: ACrzQf0ELIZ60lKpw6Ep0qikUZx9BfjTGb51rai2VmpkoFc1X8eX40iK
        VwkymX1QfpQ8X+Ubr1QEqZcFMqxD1cYuRannzgdRQw==
X-Google-Smtp-Source: AMsMyM7QBYAhwcst5sQ4Z8+CPZyOt6pA2BQXM2GGDKA3EbQcaB/mXjof/wucorRyR/CdPbe4Zit0iAGCjkRQV11/2h8=
X-Received: by 2002:a05:600c:3789:b0:3c6:beed:fecf with SMTP id
 o9-20020a05600c378900b003c6beedfecfmr20071015wmr.174.1666589622593; Sun, 23
 Oct 2022 22:33:42 -0700 (PDT)
MIME-Version: 1.0
References: <20221024011024.462518-1-irogers@google.com> <Y1X+7FCemionnepj@leoy-huanghe.lan>
In-Reply-To: <Y1X+7FCemionnepj@leoy-huanghe.lan>
From:   Ian Rogers <irogers@google.com>
Date:   Sun, 23 Oct 2022 22:33:30 -0700
Message-ID: <CAP-5=fWUrwQ187O7d0incvRFQ7RT+1viG30k+F1ZEEU3BEFeFA@mail.gmail.com>
Subject: Re: [PATCH v1] perf record: Fix event fd races
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Greg Thelen <gthelen@google.com>,
        Anand K Mistry <amistry@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 23, 2022 at 7:56 PM Leo Yan <leo.yan@linaro.org> wrote:
>
> Hi Ian,
>
> On Sun, Oct 23, 2022 at 06:10:24PM -0700, Ian Rogers wrote:
> > The write call may set errno which is problematic if occurring in a
> > function also setting errno. Save and restore errno around the write
> > call.
> >
> > done_fd may be used after close, clear it as part of the close and
> > check its validity in the signal handler.
> >
> > Suggested-by: Greg Thelen <gthelen@google.com>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/builtin-record.c | 41 ++++++++++++++++++++++---------------
> >  1 file changed, 25 insertions(+), 16 deletions(-)
> >
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index 52d254b1530c..e128b855ddde 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -649,7 +649,7 @@ static int record__pushfn(struct mmap *map, void *to, void *bf, size_t size)
> >  static volatile int signr = -1;
> >  static volatile int child_finished;
> >  #ifdef HAVE_EVENTFD_SUPPORT
> > -static int done_fd = -1;
> > +static volatile int done_fd = -1;
>
> Here is a bit suspecious for adding volatile qualifier.  See the
> document: process/volatile-considered-harmful.rst.
>
> I know the document is mainly for kernel programming, but seems to me
> it's also valid for C programming in userspace.
>
> I not sure what's the purpose for adding volatile for done_fd, if we
> really have concern for reading any stale value for done_fd, should we
> use WRITE_ONCE/READ_ONCE?

We could just switch to C11 and stdatomic. The volatile is consistent
with the code above and more consistent with the expectation of
writing to a variable that is read in a signal handler.

Thanks,
Ian

> The rest changes look good to me.
>
> Thanks,
> Leo
>
> >  #endif
> >
> >  static void sig_handler(int sig)
> > @@ -661,19 +661,24 @@ static void sig_handler(int sig)
> >
> >       done = 1;
> >  #ifdef HAVE_EVENTFD_SUPPORT
> > -{
> > -     u64 tmp = 1;
> > -     /*
> > -      * It is possible for this signal handler to run after done is checked
> > -      * in the main loop, but before the perf counter fds are polled. If this
> > -      * happens, the poll() will continue to wait even though done is set,
> > -      * and will only break out if either another signal is received, or the
> > -      * counters are ready for read. To ensure the poll() doesn't sleep when
> > -      * done is set, use an eventfd (done_fd) to wake up the poll().
> > -      */
> > -     if (write(done_fd, &tmp, sizeof(tmp)) < 0)
> > -             pr_err("failed to signal wakeup fd, error: %m\n");
> > -}
> > +     if (done_fd >= 0) {
> > +             u64 tmp = 1;
> > +             int orig_errno = errno;
> > +
> > +             /*
> > +              * It is possible for this signal handler to run after done is
> > +              * checked in the main loop, but before the perf counter fds are
> > +              * polled. If this happens, the poll() will continue to wait
> > +              * even though done is set, and will only break out if either
> > +              * another signal is received, or the counters are ready for
> > +              * read. To ensure the poll() doesn't sleep when done is set,
> > +              * use an eventfd (done_fd) to wake up the poll().
> > +              */
> > +             if (write(done_fd, &tmp, sizeof(tmp)) < 0)
> > +                     pr_err("failed to signal wakeup fd, error: %m\n");
> > +
> > +             errno = orig_errno;
> > +     }
> >  #endif // HAVE_EVENTFD_SUPPORT
> >  }
> >
> > @@ -2834,8 +2839,12 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
> >
> >  out_delete_session:
> >  #ifdef HAVE_EVENTFD_SUPPORT
> > -     if (done_fd >= 0)
> > -             close(done_fd);
> > +     if (done_fd >= 0) {
> > +             fd = done_fd;
> > +             done_fd = -1;
> > +
> > +             close(fd);
> > +     }
> >  #endif
> >       zstd_fini(&session->zstd_data);
> >       perf_session__delete(session);
> > --
> > 2.38.0.135.g90850a2211-goog
> >

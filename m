Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66616CA85C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 16:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbjC0O7G convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 27 Mar 2023 10:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233125AbjC0O7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 10:59:03 -0400
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B877555BA;
        Mon, 27 Mar 2023 07:58:56 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id n10-20020a05600c4f8a00b003ee93d2c914so7245868wmq.2;
        Mon, 27 Mar 2023 07:58:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679929135; x=1682521135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/w0DmVkKkN7hOPz99CWLwy97K2FhihScRkl+vR5X5lo=;
        b=HDoxTVW39eaw+88ur6zRx51wHS7rb1/hwGtYAGzTQ84JWhTeLTng/pham0NoT9Txgm
         qWaB887MGwnUG/Gs63769xfACghN9J+wknhvsF1fbQ843hb+IGAT7ovaa36zIbo4oOjl
         xVPyprmB7Of8MCC04Pbx/Y7mGzY6qbxQZ6DrgWwiXWHLRdDujRQensYndfB9K9fsSw5l
         D44l4TKs5pKMaRmpfS1wOo40DU9gQOsgsQNQDm7fvPtgJAMhG5vvjjOt5W2PEyunQFkd
         MX695CCBTYHaqcTBphJaQF7/punUc1Gpr8e9s3Tg0VbBqzDx29W+9JWGG/3ql5lIxqdp
         IZaA==
X-Gm-Message-State: AO0yUKXjqaw9QHN7C0tOklGdR/rgOKUwkQ+7j1OGep9I8b6cj5/1o7yH
        B9aZdT7SZz4t6F0FCbAEhAbzI+08jcv/R1a1bqM=
X-Google-Smtp-Source: AK7set9kUIWF+oyAm9IvJDhDYyZYaMGIf8Xs+M0sh34kIaS6sHmLwXDUQfx4VVWUYtMfW1sRwDU1Dnd7rp/CNlc/SDg=
X-Received: by 2002:a05:600c:241:b0:3ed:31cf:fe6e with SMTP id
 1-20020a05600c024100b003ed31cffe6emr8790299wmj.41.1679929135009; Mon, 27 Mar
 2023 07:58:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230324032702.109964-1-yangjihong1@huawei.com>
 <CAM9d7ciGy2Mycm6etHDrt6tu331i-7DphHgBzde0_1=w67mvHg@mail.gmail.com> <ZCF/Oa+dK4Wc/7r7@kernel.org>
In-Reply-To: <ZCF/Oa+dK4Wc/7r7@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 27 Mar 2023 07:58:43 -0700
Message-ID: <CAM9d7cgHAkWQ+5yo9WuociTM_p8vghPPDT+Gtm4HAt_LqrzzTQ@mail.gmail.com>
Subject: Re: [PATCH] perf ftrace: Make system wide the default target for
 latency subcommand
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Yang Jihong <yangjihong1@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 4:34 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Fri, Mar 24, 2023 at 06:39:25PM -0700, Namhyung Kim escreveu:
> > Hello,
> >
> > On Thu, Mar 23, 2023 at 8:29 PM Yang Jihong <yangjihong1@huawei.com> wrote:
> > >
> > > If no target is specified for 'latency' subcommand, the execution fails
> > > because - 1 (invalid value) is written to set_ftrace_pid tracefs file.
> > > Make system wide the default target, which is the same as the default
> > > behavior of 'trace' subcommand.
> >
> > I followed the convention to use -a for system-wide profiling.
> > Not sure if it's ok to make it default, but I don't object. :)
>
> I'll make that an Acked-by, ok?

Sure.

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> > >
> > > Before the fix:
> > >
> > >   # perf ftrace latency -T schedule
> > >   failed to set ftrace pid
> > >
> > > After the fix:
> > >
> > >   # perf ftrace latency -T schedule
> > >   ^C#   DURATION     |      COUNT | GRAPH                                          |
> > >        0 - 1    us |          0 |                                                |
> > >        1 - 2    us |          0 |                                                |
> > >        2 - 4    us |          0 |                                                |
> > >        4 - 8    us |       2828 | ####                                           |
> > >        8 - 16   us |      23953 | ########################################       |
> > >       16 - 32   us |        408 |                                                |
> > >       32 - 64   us |        318 |                                                |
> > >       64 - 128  us |          4 |                                                |
> > >      128 - 256  us |          3 |                                                |
> > >      256 - 512  us |          0 |                                                |
> > >      512 - 1024 us |          1 |                                                |
> > >        1 - 2    ms |          4 |                                                |
> > >        2 - 4    ms |          0 |                                                |
> > >        4 - 8    ms |          0 |                                                |
> > >        8 - 16   ms |          0 |                                                |
> > >       16 - 32   ms |          0 |                                                |
> > >       32 - 64   ms |          0 |                                                |
> > >       64 - 128  ms |          0 |                                                |
> > >      128 - 256  ms |          4 |                                                |
> > >      256 - 512  ms |          2 |                                                |
> > >      512 - 1024 ms |          0 |                                                |
> > >        1 - ...   s |          0 |                                                |
> > >
> > > Fixes: 53be50282269 ("perf ftrace: Add 'latency' subcommand")
> > > Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> > > ---
> > >  tools/perf/builtin-ftrace.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> > > index d7fe00f66b83..fb1b66ef2e16 100644
> > > --- a/tools/perf/builtin-ftrace.c
> > > +++ b/tools/perf/builtin-ftrace.c
> > > @@ -1228,10 +1228,12 @@ int cmd_ftrace(int argc, const char **argv)
> > >                 goto out_delete_filters;
> > >         }
> > >
> > > +       /* Make system wide (-a) the default target. */
> > > +       if (!argc && target__none(&ftrace.target))
> > > +               ftrace.target.system_wide = true;
> > > +
> > >         switch (subcmd) {
> > >         case PERF_FTRACE_TRACE:
> > > -               if (!argc && target__none(&ftrace.target))
> > > -                       ftrace.target.system_wide = true;
> > >                 cmd_func = __cmd_ftrace;
> > >                 break;
> > >         case PERF_FTRACE_LATENCY:
> > > --
> > > 2.30.GIT
> > >
>
> --
>
> - Arnaldo

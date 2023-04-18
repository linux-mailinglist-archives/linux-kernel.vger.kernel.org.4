Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287526E68B0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 17:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbjDRPwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 11:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbjDRPws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 11:52:48 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C265C678
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 08:52:17 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f04275b2bdso56965e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 08:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681833127; x=1684425127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a8AJaTAL1L9nuKjca6IxxV5WvVoR66rW4VK9cQe2Its=;
        b=tTcxcgjXlPWgzp12LZaqONOFzAR3OnpA3nO76yp8jFzJbuUPTK1q2eltwV+GHv5njp
         KXbQKIVukbWVhlHPwNqFX3EpwW8Tck5Jw2F3sR3tcJp/dxBi5hffPf3hzyAUDNwJbv5a
         bGTmLxVmrDQTO+SH4kA6abnLsm2AqrSzesC1K6DqG9cWa33EKt2cCePnIMEd7q2tf2qL
         BjBiC4N4095m6+jS5w/Cfp60CN2bLsALrREmHoCvn3n9BciNxeVxk3my1D4+NZG0U0uP
         OzooP8ZfIAEM0jqIHqKKBCcamDbtMWs2q3/+3PAWSmlKbv/dJUXNiYd3YDToa9v1wvm6
         02xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681833127; x=1684425127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a8AJaTAL1L9nuKjca6IxxV5WvVoR66rW4VK9cQe2Its=;
        b=l0vzbqpecVpWY1q54yD7dtby7H26vhpkeRtOgSZ5cE6PkK13jqq6inB65AMIz2Wsxv
         TRNGG5Ulrt2kmERyfl24jtiNRkrcNGkjqg6MGvzvf/qkWNxwS2YKb97Xn9z7KjhCULSF
         bMYiCeH5uzNy+UjEJ4roB081zJ0TP8DR4l7sfBuN2X0L8txOwUY+WSBfAnoXwhU3J5Yu
         OZviPR8GTyiw1dsJLYCCKcb/bvOZNB3paOjYmGHGPsli018GKnmoh2gFVU+8W3Qqycv5
         BxUJUVMT/wKI9kG+0SlqwJeM9RJlqeLD9NQN8mtYyX1DakK2UXhbVRKDKUx5mS0F8Xw2
         UXXg==
X-Gm-Message-State: AAQBX9cZQ4Bz3/v9yMO81ifSt+YgREEcl9DLHmDJADHhbt07/sE23StH
        gZPmZ1WVRhA8ARJlu0kmTQKXsVlX1FvwyCNT9KUQcg==
X-Google-Smtp-Source: AKy350ZpV2IOebxfwF+HpsSE5r6eITnamp/nMwc0jszxYZEFirHdz3lgJ7MEkiCa9WdNhzir5KAOB4hulRMOuRJfOes=
X-Received: by 2002:a05:600c:19cc:b0:3f1:758c:dd23 with SMTP id
 u12-20020a05600c19cc00b003f1758cdd23mr170026wmq.7.1681833127265; Tue, 18 Apr
 2023 08:52:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230414082300.34798-1-adrian.hunter@intel.com>
 <20230417110221.GH83892@hirez.programming.kicks-ass.net> <89733d35-0b71-615f-4fb8-55183585c67a@intel.com>
 <d7d6cbc8-1f5f-d0f4-6656-f0cc8ab3a118@intel.com>
In-Reply-To: <d7d6cbc8-1f5f-d0f4-6656-f0cc8ab3a118@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 18 Apr 2023 08:51:52 -0700
Message-ID: <CAP-5=fWjyvsFuQhPNQyoa1ExTo4yggKRrmaksuatwU29v0uNXA@mail.gmail.com>
Subject: Re: [PATCH RFC 0/5] perf: Add ioctl to emit sideband events
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 6:36=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 18/04/23 09:18, Adrian Hunter wrote:
> > On 17/04/23 14:02, Peter Zijlstra wrote:
> >> On Fri, Apr 14, 2023 at 11:22:55AM +0300, Adrian Hunter wrote:
> >>> Hi
> >>>
> >>> Here is a stab at adding an ioctl for sideband events.
> >>>
> >>> This is to overcome races when reading the same information
> >>> from /proc.
> >>
> >> What races? Are you talking about reading old state in /proc the kerne=
l
> >> delivering a sideband event for the new state, and then you writing th=
e
> >> old state out?
> >>
> >> Surely that's something perf tool can fix without kernel changes?
> >
> > Yes, and it was a bit of a brain fart not to realise that.
> >
> > There may still be corner cases, where different kinds of events are
> > interdependent, perhaps NAMESPACES events vs MMAP events could
> > have ordering issues.
> >
> > Putting that aside, the ioctl may be quicker than reading from
> > /proc.  I could get some numbers and see what people think.
> >
>
> Here's a result with a quick hack to use the ioctl but without
> handling the buffer becoming full (hence the -m4M)
>
> # ps -e | wc -l
> 1171
> # perf.old stat -- perf.old record -o old.data --namespaces -a true
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 1.095 MB old.data (100 samples) ]
>
>  Performance counter stats for 'perf.old record -o old.data --namespaces =
-a true':
>
>             498.15 msec task-clock                       #    0.987 CPUs =
utilized
>                126      context-switches                 #  252.935 /sec
>                 64      cpu-migrations                   #  128.475 /sec
>               4396      page-faults                      #    8.825 K/sec
>         1927096347      cycles                           #    3.868 GHz
>         4563059399      instructions                     #    2.37  insn =
per cycle
>          914232559      branches                         #    1.835 G/sec
>            6618052      branch-misses                    #    0.72% of al=
l branches
>         9633787105      slots                            #   19.339 G/sec
>         4394300990      topdown-retiring                 #     38.8% Reti=
ring
>         3693815286      topdown-bad-spec                 #     32.6% Bad =
Speculation
>         1692356927      topdown-fe-bound                 #     14.9% Fron=
tend Bound
>         1544151518      topdown-be-bound                 #     13.6% Back=
end Bound
>
>        0.504636742 seconds time elapsed
>
>        0.158237000 seconds user
>        0.340625000 seconds sys
>
> # perf.old stat -- perf.new record -o new.data -m4M --namespaces -a true
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 1.095 MB new.data (103 samples) ]
>
>  Performance counter stats for 'perf.new record -o new.data -m4M --namesp=
aces -a true':
>
>             386.61 msec task-clock                       #    0.988 CPUs =
utilized
>                100      context-switches                 #  258.658 /sec
>                 65      cpu-migrations                   #  168.128 /sec
>               4935      page-faults                      #   12.765 K/sec
>         1495905137      cycles                           #    3.869 GHz
>         3647660473      instructions                     #    2.44  insn =
per cycle
>          735822370      branches                         #    1.903 G/sec
>            5765668      branch-misses                    #    0.78% of al=
l branches
>         7477722620      slots                            #   19.342 G/sec
>         3415835954      topdown-retiring                 #     39.5% Reti=
ring
>         2748625759      topdown-bad-spec                 #     31.8% Bad =
Speculation
>         1221594670      topdown-fe-bound                 #     14.1% Fron=
tend Bound
>         1256150733      topdown-be-bound                 #     14.5% Back=
end Bound
>
>        0.391472763 seconds time elapsed
>
>        0.141207000 seconds user
>        0.246277000 seconds sys
>
> # ls -lh old.data
> -rw------- 1 root root 1.2M Apr 18 13:19 old.data
> # ls -lh new.data
> -rw------- 1 root root 1.2M Apr 18 13:19 new.data
> #

Cool, so the headline is a ~20% or 1billion instruction reduction in
perf startup overhead?

Thanks,
Ian

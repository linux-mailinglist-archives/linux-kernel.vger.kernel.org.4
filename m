Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7856A47D5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 18:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjB0RXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 12:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjB0RXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 12:23:04 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F10235B1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:22:53 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-536bf92b55cso194790807b3.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kTYModbuR59uTG8zS+hNzwQJ/9GBqPBIvenxOax1Cso=;
        b=BRbX7YidX86oPGQqKm8PfNLIDtGD5UMOuVUS6ca2zJd/iJo9olk+uOd3gMOLdYJ1n+
         uv4dAYbAKZ6OvWilSgdGG9qqbk4t9v7yKyC4gq4xIKFaBF8urvkclYPhGSSQRskBb/Sm
         srRvcLEWJDF34310EiPMnEEhsepBlNF8fGdo7RpnLSxlNxbKlwOEHxj4lD743FqmSeBS
         U5qu9Em33YrENcu1ujFHNSqcTtD88Kh9QmD0gIZm/PVez+Y96kqLFxl9mRtV94FAzyIO
         5DA7YEJptKOIfvIK28FNlMfn6NjxJW09FPV6Ouuznf6X3evlJxOWLuefpgmVhT8ddWIH
         LcNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kTYModbuR59uTG8zS+hNzwQJ/9GBqPBIvenxOax1Cso=;
        b=zH47mOokB21qH9YKsP+0FjRs6ByM2nT9PjxetAFkJE0HqZe4HnHyn4bZIWUcJ3O+WQ
         b1q7uM93cZYDLHmjq+ubEzexEGVaBIKZ0kFdBqwi8NcfVTLreQiTMyb1n1t5G8sS+zTb
         xHczPt05uVt9PuKWUtFBA9sn2z+MUGI8ETo7utqmed1HnMPglNts17kDBh1OVe1nCi/H
         Ve+tUCrmzfA9grsGbszDoJOCbGmiry05LKYhJ7eimaORod509QWLHVYKp3M3CuPaXq5D
         G3TSe9jNE2z9wOM5yX6Qv/iq1CpFkIw/XWXGRLVHJ4M0JA1Qdt4POuHb0Hkchz1GRaiJ
         hw8A==
X-Gm-Message-State: AO0yUKUiUlIXGeDxd3sAPxwUc2hq8XiGNEUynsSdY2gKQBu854/hvVQ/
        ZYXM/bBpi+Yb+p2JAQKc5JbY3t5vME5yOxd4NQZXSA==
X-Google-Smtp-Source: AK7set8fe0yfu+y/XLo8ATPIQLkQ8N9RTHMEBSne/gxsKyen3VnvkrfyF/SuP2kGzz2URTq5dmSg95f/8tSKHp0rjKQ=
X-Received: by 2002:a81:b649:0:b0:530:bbd3:798b with SMTP id
 h9-20020a81b649000000b00530bbd3798bmr10565486ywk.0.1677518572008; Mon, 27 Feb
 2023 09:22:52 -0800 (PST)
MIME-Version: 1.0
References: <20230216051750.3125598-1-surenb@google.com> <20230224092134.30603-1-michalechner92@googlemail.com>
 <20230227165032.taj24j4leu7dlbqc@offworld>
In-Reply-To: <20230227165032.taj24j4leu7dlbqc@offworld>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 27 Feb 2023 09:22:40 -0800
Message-ID: <CAJuCfpH4QuX_BmZor5Gy9M9frwz0e3WP597b4q-W3xYHOqUB8A@mail.gmail.com>
Subject: Re: [PATCH v3 00/35] Per-VMA locks
To:     freak07 <michalechner92@googlemail.com>, surenb@google.com,
        akpm@linux-foundation.org, arjunroy@google.com,
        axelrasmussen@google.com, bigeasy@linutronix.de,
        chriscli@google.com, david@redhat.com, dhowells@redhat.com,
        edumazet@google.com, gthelen@google.com, gurua@google.com,
        hannes@cmpxchg.org, hughd@google.com, jannh@google.com,
        jglisse@google.com, joelaf@google.com, kent.overstreet@linux.dev,
        kernel-team@android.com, ldufour@linux.ibm.com,
        leewalsh@google.com, liam.howlett@oracle.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        lstoakes@gmail.com, luto@kernel.org, mgorman@techsingularity.net,
        mhocko@suse.com, michel@lespinasse.org, minchan@google.com,
        mingo@redhat.com, paulmck@kernel.org, peterjung1337@gmail.com,
        peterx@redhat.com, peterz@infradead.org, posk@google.com,
        punit.agrawal@bytedance.com, rientjes@google.com, rppt@kernel.org,
        shakeelb@google.com, soheil@google.com, songliubraving@fb.com,
        tatashin@google.com, vbabka@suse.cz, will@kernel.org,
        willy@infradead.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Feb 27, 2023 at 9:19 AM Davidlohr Bueso <dave@stgolabs.net> wrote:
>
> On Fri, 24 Feb 2023, freak07 wrote:
>
> >Here are some measurements from a Pixel 7 Pro that=C2=B4s running a kern=
el either with the Per-VMA locks patchset or without.
> >If there=C2=B4s interest I can provide results of other specific apps as=
 well.
> >
> >Results are from consecutive cold app launches issued with "am start" co=
mmand spawning the main activity of Slack Android app.
> >
> >https://docs.google.com/spreadsheets/d/1ktujfcyDmIJoQMWsoizGIE-0A_jMS9VM=
w_seehUY9s0/edit?usp=3Dsharing
> >
> >There=C2=B4s quite a noticeable improvement, as can be seen in the graph=
. The results were reproducible.
>
> Thanks for sharing. I am not surprised - after all, per-vma locks narrow =
some of the performance gaps
> between vanilla and speculative pfs, with less complexity (albeit this is=
 now a 35 patch series :).

Yes, depending on the specific app we would expect some launch time
improvement (in this case average improvement is 7%). Thanks for
sharing the numbers!
I'll be posting v4 today, which is a 33 patch series now, so a bit better :=
)
Thanks,
Suren.

>
> Thanks,
> Davidlohr
>

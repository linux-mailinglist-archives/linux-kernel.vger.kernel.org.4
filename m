Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C3E61730C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 00:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiKBXwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 19:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKBXv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 19:51:59 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F317C25D0
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 16:51:56 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id l15so344262qtv.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 16:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bEj5DrhVQBA3AG2Fgg3tAE4FJ85nATZr7PoJMTrTFmw=;
        b=XVZjeWRTnzWI4Zj2TkKqRmkYpW7BzhEUrcZ6YPNasojQPFVjudxUWglnvmJ8yCJ4+d
         2ZXTrssYPNv5UJAFmUO25S6z7K0i1Ya2pAkGC252pGdl5BvctyKapjhk2Bms5rYFZBlh
         3+5gE8PU8bDd8Z+gna9auuCgUB5Z8MA+6PppznQvY2ECdfwDqHWGNltkaSIDtRhjwEEr
         d7EifbrNhJFRyGZGwbk38xGXHvN9m6ITjCzPMUz6tnaPFejMFfqsuLM+rzM/QoeXjwKU
         rQDXhhXT6LyMoyhkh9i3IrBnKqxH2Upo3r0Z/e31pXyFy3rQPx5tTMMDzqDDDYMkFpgv
         Ccow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bEj5DrhVQBA3AG2Fgg3tAE4FJ85nATZr7PoJMTrTFmw=;
        b=HzGrpUkzLR+rAqQFVha9vUK6mkXjIUl+DACT2QOL+/BDD+UrpENrW2cSask09cyj9t
         cAfK5Lb/caPhAeapy7cmKduXzqvdUhybMFih4+ovnAXR02gg8kArWhJ55JWQxBjwBOM3
         wEW5zTCj+KJSw9bnCALit0ieX/MptHdRNfJVEc74FWsI/r3l0QC4U3epjCv2MSeC6qOg
         z08THs+ke+NOHri0tRAoivwYkMGh+iyGWppcHILTEZ+pRd/JbIwMWg3ZO9vYGfKlM19Z
         xjONxdE1bZBtfsWVACCbR7hFD2fpXcQh4+O7W85UV2HZ2L6tD3IEKFG2TfhPC95AjwsL
         a8VQ==
X-Gm-Message-State: ACrzQf2StsqE2DNpa7QuTnW4W0JFAKK/d1v2GDwlKM+MsbhN4UdEvY44
        i430mVpB85EhCD/6h03Z26wso9jsh8w=
X-Google-Smtp-Source: AMsMyM4CQn2gvZJbVc8Q9JOQcDyxLbHrLXySSTMRbgogTpVUpN5Tqei6DQV7LdxSW7c7G8jVM6mQtQ==
X-Received: by 2002:ac8:5f51:0:b0:3a5:c72:2334 with SMTP id y17-20020ac85f51000000b003a50c722334mr22788811qta.346.1667433116046;
        Wed, 02 Nov 2022 16:51:56 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id de41-20020a05620a372900b006e99290e83fsm9489024qkb.107.2022.11.02.16.51.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 16:51:55 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-367cd2807f2so1442457b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 16:51:55 -0700 (PDT)
X-Received: by 2002:a0d:cd83:0:b0:35c:67cb:f002 with SMTP id
 p125-20020a0dcd83000000b0035c67cbf002mr25294313ywd.470.1667433115253; Wed, 02
 Nov 2022 16:51:55 -0700 (PDT)
MIME-Version: 1.0
References: <20221030220203.31210-1-axboe@kernel.dk> <CA+FuTSfj5jn8Wui+az2BrcpDFYF5m5ehwLiswwHMPJ2MK+S_Jw@mail.gmail.com>
 <02e5bf45-f877-719b-6bf8-c4ac577187a8@kernel.dk> <CA+FuTSd-HvtPVwRto0EGExm-Pz7dGpxAt+1sTb51P_QBd-N9KQ@mail.gmail.com>
 <88353f13-d1d8-ef69-bcdc-eb2aa17c7731@kernel.dk>
In-Reply-To: <88353f13-d1d8-ef69-bcdc-eb2aa17c7731@kernel.dk>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Wed, 2 Nov 2022 19:51:18 -0400
X-Gmail-Original-Message-ID: <CA+FuTSdEKsN_47RtW6pOWEnrKkewuDBdsv_qAhR1EyXUr3obrg@mail.gmail.com>
Message-ID: <CA+FuTSdEKsN_47RtW6pOWEnrKkewuDBdsv_qAhR1EyXUr3obrg@mail.gmail.com>
Subject: Re: [PATCHSET v3 0/5] Add support for epoll min_wait
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 2, 2022 at 7:42 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 11/2/22 5:09 PM, Willem de Bruijn wrote:
> > On Wed, Nov 2, 2022 at 1:54 PM Jens Axboe <axboe@kernel.dk> wrote:
> >>
> >> On 11/2/22 11:46 AM, Willem de Bruijn wrote:
> >>> On Sun, Oct 30, 2022 at 6:02 PM Jens Axboe <axboe@kernel.dk> wrote:
> >>>>
> >>>> Hi,
> >>>>
> >>>> tldr - we saw a 6-7% CPU reduction with this patch. See patch 6 for
> >>>> full numbers.
> >>>>
> >>>> This adds support for EPOLL_CTL_MIN_WAIT, which allows setting a minimum
> >>>> time that epoll_wait() should wait for events on a given epoll context.
> >>>> Some justification and numbers are in patch 6, patches 1-5 are really
> >>>> just prep patches or cleanups.
> >>>>
> >>>> Sending this out to get some input on the API, basically. This is
> >>>> obviously a per-context type of operation in this patchset, which isn't
> >>>> necessarily ideal for any use case. Questions to be debated:
> >>>>
> >>>> 1) Would we want this to be available through epoll_wait() directly?
> >>>>    That would allow this to be done on a per-epoll_wait() basis, rather
> >>>>    than be tied to the specific context.
> >>>>
> >>>> 2) If the answer to #1 is yes, would we still want EPOLL_CTL_MIN_WAIT?
> >>>>
> >>>> I think there are pros and cons to both, and perhaps the answer to both is
> >>>> "yes". There are some benefits to doing this at epoll setup time, for
> >>>> example - it nicely isolates it to that part rather than needing to be
> >>>> done dynamically everytime epoll_wait() is called. This also helps the
> >>>> application code, as it can turn off any busy'ness tracking based on if
> >>>> the setup accepted EPOLL_CTL_MIN_WAIT or not.
> >>>>
> >>>> Anyway, tossing this out there as it yielded quite good results in some
> >>>> initial testing, we're running more of it. Sending out a v3 now since
> >>>> someone reported that nonblock issue which is annoying. Hoping to get some
> >>>> more discussion this time around, or at least some...
> >>>
> >>> My main question is whether the cycle gains justify the code
> >>> complexity and runtime cost in all other epoll paths.
> >>>
> >>> Syscall overhead is quite dependent on architecture and things like KPTI.
> >>
> >> Definitely interested in experiences from other folks, but what other
> >> runtime costs do you see compared to the baseline?
> >
> > Nothing specific. Possible cost from added branches and moving local
> > variables into structs with possibly cold cachelines.
> >
> >>> Indeed, I was also wondering whether an extra timeout arg to
> >>> epoll_wait would give the same feature with less side effects. Then no
> >>> need for that new ctrl API.
> >>
> >> That was my main question in this posting - what's the best api? The
> >> current one, epoll_wait() addition, or both? The nice thing about the
> >> current one is that it's easy to integrate into existing use cases, as
> >> the decision to do batching on the userspace side or by utilizing this
> >> feature can be kept in the setup path. If you do epoll_wait() and get
> >> -1/EINVAL or false success on older kernels, then that's either a loss
> >> because of thinking it worked, or a fast path need to check for this
> >> specifically every time you call epoll_wait() rather than just at
> >> init/setup time.
> >>
> >> But this is very much the question I already posed and wanted to
> >> discuss...
> >
> > I see the value in being able to detect whether the feature is present.
> >
> > But a pure epoll_wait implementation seems a lot simpler to me, and
> > more elegant: timeout is an argument to epoll_wait already.
> >
> > A new epoll_wait variant would have to be a new system call, so it
> > would be easy to infer support for the feature.
>
> Right, but it'd still mean that you'd need to check this in the fast
> path in the app vs being able to do it at init time.

A process could call the new syscall with timeout 0 at init time to
learn whether the feature is supported.

> Might there be
> merit to doing both? From the conversion that we tried, the CTL variant
> definitely made things easier to port. The new syscall would make enable
> per-call delays however. There might be some merit to that, though I do
> think that max_events + min_time is how you'd control batching anything
> and that's suitably set in the context itself for most use cases.

I'm surprised a CTL variant is easier to port. An epoll_pwait3 with an
extra argument only needs to pass that argument to do_epoll_wait.

FWIW, when adding nsec resolution I initially opted for an init-based
approach, passing a new flag to epoll_create1. Feedback then was that
it was odd to have one syscall affect the behavior of another. The
final version just added a new epoll_pwait2 with timespec.

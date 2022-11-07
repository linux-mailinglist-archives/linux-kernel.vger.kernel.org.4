Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256A461F443
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 14:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbiKGN0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 08:26:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbiKGNZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 08:25:58 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F65C1C927
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 05:25:57 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id x15so8068309qvp.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 05:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eJNmkTVGuEN8Z4KDgftkyeqz6lbn5zaHdj9DAo/2scU=;
        b=RzSePtA+1KqdSsq8crudtZQKzWstuJdxe83ms3LYIQt9XN/VF3LQpTAkRdJF14NLzp
         BPe/k3ON+F7JWOjXAwSWDuWkXXj0EiLlpbuwdYoScLgCXyYc7NRJ8yfK88v14uXHwoSQ
         SzT7HsLWiYZkGxAEA2Fy+32tgHcmEN2xkOeipBMnCyWjRx8cwv/VWQCywgGhHlFiBe6s
         kb+HgBTwEJHA0i3OxZfK5oFTXzce72qkt+siIBcYx8zX8bk0Qj2fse7bmVgdb9nF/MvR
         Yh/VNqKXepeOIx7IoTK8N5C406lartwm161g3j1SXzkl1LKpTEWXYDkiVNCN9XE0A2wo
         RJHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eJNmkTVGuEN8Z4KDgftkyeqz6lbn5zaHdj9DAo/2scU=;
        b=H3nERCExZ0c3HdaqNS3Pw4TkVNhso8bzKmBAC5tg14vbZxSytKh+La5SxUlU8UiCgy
         NkQL+24hrtj7NznMu8YkczpKP1eFZKs4kNg+Yo1hjGX/rQJPLqWCPCm0OecAaxOUXeTE
         UROsPofRMzv4IWI8aRERKJsebgInq5Yc/wbWmL07fTZ/SvmEMCpwhVYtcaPksJIyCYkB
         PSnFC3aeWXrV8lnmq3Wdt5aC2FEpNB8IloELwd9nuSaENalwTNa6+bVN1322ZSHsT/pK
         /o1GSp70BL2KEcMr6AXwYOjGXfzFE4D7ALiMPDljrQH54y5wR53fnjEEg/xniJMH3+6Q
         nTbQ==
X-Gm-Message-State: ACrzQf3JVFQGGOQ4HKW6o4vc96to9gkxzT9PTSeQTHDlBsi4++OFVCu1
        mPZmar1/ADJSl/JqZxXzTqMct3CtKyU=
X-Google-Smtp-Source: AMsMyM6hTj8sjhT9fFY7oFTeamvIPkbtrw5gC8050JnsLhXD5zb11aqP9H1FbWdh8jh7d9zWyyxdxw==
X-Received: by 2002:ad4:5c4e:0:b0:4bb:9fea:f52e with SMTP id a14-20020ad45c4e000000b004bb9feaf52emr44942138qva.51.1667827556286;
        Mon, 07 Nov 2022 05:25:56 -0800 (PST)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id cj25-20020a05622a259900b003a4c3c4d2d4sm6044866qtb.49.2022.11.07.05.25.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 05:25:55 -0800 (PST)
Received: by mail-yb1-f180.google.com with SMTP id z192so13627749yba.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 05:25:55 -0800 (PST)
X-Received: by 2002:a05:6902:1001:b0:6be:820d:a0de with SMTP id
 w1-20020a056902100100b006be820da0demr49694453ybt.240.1667827555181; Mon, 07
 Nov 2022 05:25:55 -0800 (PST)
MIME-Version: 1.0
References: <20221030220203.31210-1-axboe@kernel.dk> <CA+FuTSfj5jn8Wui+az2BrcpDFYF5m5ehwLiswwHMPJ2MK+S_Jw@mail.gmail.com>
 <02e5bf45-f877-719b-6bf8-c4ac577187a8@kernel.dk> <CA+FuTSd-HvtPVwRto0EGExm-Pz7dGpxAt+1sTb51P_QBd-N9KQ@mail.gmail.com>
 <88353f13-d1d8-ef69-bcdc-eb2aa17c7731@kernel.dk> <CA+FuTSdEKsN_47RtW6pOWEnrKkewuDBdsv_qAhR1EyXUr3obrg@mail.gmail.com>
 <46cb04ca-467c-2e33-f221-3e2a2eaabbda@kernel.dk> <fe28e9fa-b57b-8da6-383c-588f6e84f04f@kernel.dk>
 <CA+FuTSfEqmx_rHPLaSp+o+tYzqCvF6oSjSOse0KoFvXj9xK9Cw@mail.gmail.com> <e3c55fda-043e-9cc7-3248-63574b374c13@kernel.dk>
In-Reply-To: <e3c55fda-043e-9cc7-3248-63574b374c13@kernel.dk>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 7 Nov 2022 08:25:18 -0500
X-Gmail-Original-Message-ID: <CA+FuTSf9RVua+qUdOAQBGuwOrNysu3min5fDtWyKb3aRgth4vQ@mail.gmail.com>
Message-ID: <CA+FuTSf9RVua+qUdOAQBGuwOrNysu3min5fDtWyKb3aRgth4vQ@mail.gmail.com>
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

On Sat, Nov 5, 2022 at 2:46 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 11/5/22 12:05 PM, Willem de Bruijn wrote:
> > On Sat, Nov 5, 2022 at 1:39 PM Jens Axboe <axboe@kernel.dk> wrote:
> >>
> >>>> FWIW, when adding nsec resolution I initially opted for an init-based
> >>>> approach, passing a new flag to epoll_create1. Feedback then was that
> >>>> it was odd to have one syscall affect the behavior of another. The
> >>>> final version just added a new epoll_pwait2 with timespec.
> >>>
> >>> I'm fine with just doing a pure syscall variant too, it was my original
> >>> plan. Only changed it to allow for easier experimentation and adoption,
> >>> and based on the fact that most use cases would likely use a fixed value
> >>> per context anyway.
> >>>
> >>> I think it'd be a shame to drop the ctl, unless there's strong arguments
> >>> against it. I'm quite happy to add a syscall variant too, that's not a
> >>> big deal and would be a minor addition. Patch 6 should probably cut out
> >>> the ctl addition and leave that for a patch 7, and then a patch 8 for
> >>> adding a syscall.
> >> I split the ctl patch out from the core change, and then took a look at
> >> doing a syscall variant too. But there are a few complications there...
> >> It would seem to make the most sense to build this on top of the newest
> >> epoll wait syscall, epoll_pwait2(). But we're already at the max number
> >> of arguments there...
> >>
> >> Arguably pwait2 should've been converted to use some kind of versioned
> >> struct instead. I'm going to take a stab at pwait3 with that kind of
> >> interface.
> >
> > Don't convert to a syscall approach based solely on my feedback. It
> > would be good to hear from others.
>
> It's not just based on your feedback, if you read the original cover
> letter, then that is the question that is posed in terms of API - ctl to
> modify it, new syscall, or both? So figured I should at least try and
> see what the syscall would look like.
>
> > At a high level, I'm somewhat uncomfortable merging two syscalls for
> > behavior that already works, just to save half the syscall overhead.
> > There is no shortage of calls that may make some sense for a workload
> > to merge. Is the quoted 6-7% cpu cycle reduction due to saving one
> > SYSENTER/SYSEXIT (as the high resolution timer wake-up will be the
> > same), or am I missing something more fundamental?
>
> No, it's not really related to saving a single syscall, and you'd
> potentially save more than just one as well. If we look at the two
> extremes of applications, one will be low load and you're handling
> probably just 1 event per loop. Not really interesting. At the other
> end, you're fully loaded, and by the time you check for events, you have
> 'maxevents' (or close to) available. That obviously reduces system
> calls, but more importantly, it also allows the application to get some
> batching effects from processing these events.
>
> In the medium range, there's enough processing to react pretty quickly
> to events coming in, and you then end up doing just 1 event (or close to
> that). To overcome that, we have some applications that detect this
> medium range and do an artificial sleep before calling epoll_wait().
> That was a nice effiency win for them. But we can do this a lot more
> efficiently in the kernel. That was the idea behind this, and the
> initial results from TAO (which does that sleep hack) proved it to be
> more than worthwhile. Syscall reduction is one thing, improved batching
> another, and just as importanly is sleep+wakeup reductions.

Thanks for the context.

So this is akin to interrupt moderation in network interfaces. Would
it make sense to wait for timeout or nr of events, whichever comes
first, similar to rx_usecs/rx_frames. Instead of an unconditional
sleep at the start.

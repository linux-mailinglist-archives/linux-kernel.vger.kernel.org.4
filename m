Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558716A8B0B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 22:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjCBVQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 16:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCBVP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 16:15:59 -0500
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD1B2BEF6
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 13:15:58 -0800 (PST)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-536af432ee5so7053307b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 13:15:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677791758;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eVpveqav39xHluf+wjGnRtJx3spTO96lIDpkUW7nSVw=;
        b=xBLKuh7p4rfeRr1hJpT9ZP1BAneM71mAg5865L4dpgriIYX9E9EFVstGBP2PPh/gZD
         stC5+e64V+62nDXtWD/PXR1PgGk1eJ2Vo+eIF9w81J5qKEovrz86hk+Le2dFkuvrRM35
         4rgAGRefJvtWJZuYd1ERj0DyXagV2xqRVzFfqLQBgPysQq0+5Loh+gHtV9t4J23k9WRi
         7B9z/1LPB4CwwE5f0Ogj6YbGRg0BtVHD82CYifYOfsI2cvmZcyprEAKAukhYIxT0U8lf
         GgTaDO4m11UIOPSyR820t+CobLGp+e29xH1otCc6OL6Ao3BL0hlKtguT1snysn6z8F5f
         EIDg==
X-Gm-Message-State: AO0yUKWz+guteW8u51WUgGDIdc1a2tKaWjf71n0/CWYgDOoBzj2OBb26
        Ppzas5otxLuLoySRxkpO61qW5ov9Ve9Ap6IG990=
X-Google-Smtp-Source: AK7set+CQ6jI8lY1b7hKdCF6npSVRkwWGg8RBevqoZTgOF2umxfiVgWHhlT7z/gFAOKKeWti2LsuWw+SWMfG9KLq+B0=
X-Received: by 2002:a81:ae0e:0:b0:534:7429:2eb4 with SMTP id
 m14-20020a81ae0e000000b0053474292eb4mr7144251ywh.3.1677791758074; Thu, 02 Mar
 2023 13:15:58 -0800 (PST)
MIME-Version: 1.0
References: <20230228192145.2120675-1-song@kernel.org> <CAM9d7chLaXDU4mMkD1U6YuOGZXcu7PFWGOuEkFKSkbrCLS+zWg@mail.gmail.com>
 <BBB1A458-25CA-4C0F-AF04-18534D092142@fb.com>
In-Reply-To: <BBB1A458-25CA-4C0F-AF04-18534D092142@fb.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 2 Mar 2023 13:15:46 -0800
Message-ID: <CAM9d7chCcz=o+XX_ruZ3+zfp2Z2sPDG43dpTZH_mf6zXYjTJ7w@mail.gmail.com>
Subject: Re: [PATCH] perf: fix perf_event_context->time
To:     Song Liu <songliubraving@meta.com>
Cc:     Song Liu <song@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 1, 2023 at 3:16 PM Song Liu <songliubraving@meta.com> wrote:
>
>
>
> > On Mar 1, 2023, at 2:29 PM, Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hi Song,
> >
> > On Tue, Feb 28, 2023 at 11:22 AM Song Liu <song@kernel.org> wrote:
> >>
> >> Time readers rely on perf_event_context->[time|timestamp|timeoffset] to get
> >> accurate time_enabled and time_running for an event. The difference between
> >> ctx->timestamp and ctx->time is the among of time when the context is not
> >> enabled. For cpuctx.ctx, time and timestamp should stay the same, however,
> >
> > I'm not sure if it's correct.  The timestamp can go when the context is disabled
> > for example, in ctx_resched() even if the NMI watchdog is enabled, right?
>
> I think we do not disable EVENT_TIME for per cpu ctx?

I can see ctx_sched_out(ctx, EVENT_TIME) in some places.
Also it'd reset EVENT_TIME if both _PINNED and _FLEXIBLE is
cleared.

Thanks,
Namhyung

>
> >
> >> it is not the case at the moment. To show this with drgn [1]:
> >>
> >>    drgn 0.0.22 (using Python 3.8.6, elfutils 0.185, with libkdumpfile)
> >>    For help, type help(drgn).
> >>    ...
> >>>>> ctx = per_cpu_ptr(prog['pmu'].pmu_cpu_context, 0).ctx
> >>>>> ctx.timestamp * 1.0 / ctx.time
> >>    (double)1.0385869134111765
> >>>>>
> >>
> >> ctx->timestamp is about 4% larger than ctx.time. This issue causes time
> >> read by perf_event_read_local() goes back in some cases.
> >
> > I don't think the difference between the ctx.time and the timestamp
> > itself is a problem.  I think the problem is it CAN update the timestamp
> > (and the timeoffset) while the context is enabled.  Then depending on
> > the timing, event times can return smaller values than before.
>
> For per cpu ctx, I think timeoffset should stay the same (may not be zero
> though).
>
> Thanks,
> Song
>
>

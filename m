Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4DB69D12C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 17:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbjBTQPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 11:15:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbjBTQO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 11:14:59 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2491CF4E;
        Mon, 20 Feb 2023 08:14:58 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id be35so1549244oib.4;
        Mon, 20 Feb 2023 08:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yucdNwlCfsGGEjZdnJPvfOZKmj3CAADyiPAf5hjswZg=;
        b=ZxnDUIK9eHPfiknVqJN5rt64dYRWzqsyM6ai87lOd3rGkYut+gJ/n+6Q60l5pl9X0m
         aA2xVnQMpHNtR7PQ8ZuDMhsvhBxEIA6RVe5PFIYbQHMt5hbHT4I1ZGY3ojxcWR/DON9r
         GtImPbcTfYDxbU1M08ylmtdGi/pU3DvNMyn9R6NvYbuui4FinXluI/67qPQjjefFcY4y
         btiSdrQHL2kv3JuRmJtxS7dpCBcfjo2n+2xcY02Nsbm6CRH6XFbnVzpgWu9oQybHP09j
         SAXeRZCUoim+iykMYQIdC3P3AY5/YPuVOE1HcjfjBHkoZWXNDqneQskNWo5Z0xJsKYRa
         TNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yucdNwlCfsGGEjZdnJPvfOZKmj3CAADyiPAf5hjswZg=;
        b=jhmIQZCbBuG75pC11699wYoLwQQ4xgY8NSaNaQrcUIUH5zl5gVDOjmOzZeEDioFPP8
         ob9U4KAXAKR9tqId9MIWQhLONj6swxerECQOvvhAOtLg20EvtwuYjzrYgA5j3mpfBd1Q
         AiL4ikbvnuIGG2jLhTQdoHToWJZU5v0k9ZSGG/g8hhqf1OLzDK0Rz5hoZpBgQjFlZCEu
         aQ0OhlJC6J6lfyT2Uf7aV5C+/1upJOcyyDkLtAwQJO+rcwngCgmxtudXMNCB4snKFFbN
         SqLUb65rdJnkL1J6ajhlWNU+C9dV4/relw4P8k0vbZ2owEE2Q/Jtp1MNqqT0oHOaceP1
         1tLg==
X-Gm-Message-State: AO0yUKXoGIijwT2vrrxbxsInwUiV1flpThxrPlpmviNKg7DWjBDbPp2t
        EEIx6e6TWXi9OF30T5Rckp2C59jzq+6TJ5vbxtvQVgmk
X-Google-Smtp-Source: AK7set+n1QvPydxi+hQlZFC/9h20UVfLJWhf+ldIyg34MhCT3B1Lw/a7cCOBNd9D7mP6aZ3TpheYxEk8RFxISNtjFbE=
X-Received: by 2002:a05:6808:ec7:b0:364:c0a5:1fcf with SMTP id
 q7-20020a0568080ec700b00364c0a51fcfmr1104755oiv.58.1676909697815; Mon, 20 Feb
 2023 08:14:57 -0800 (PST)
MIME-Version: 1.0
References: <20230218211608.1630586-1-robdclark@gmail.com> <20230218211608.1630586-7-robdclark@gmail.com>
 <20230220105345.70e46fa5@eldfell>
In-Reply-To: <20230220105345.70e46fa5@eldfell>
From:   Rob Clark <robdclark@gmail.com>
Date:   Mon, 20 Feb 2023 08:14:47 -0800
Message-ID: <CAF6AEGv9fLQCD65ytRTGp=EkNB1QoZYH5ArphgGQALV9J08Cmw@mail.gmail.com>
Subject: Re: [PATCH v4 06/14] dma-buf/sync_file: Support (E)POLLPRI
To:     Pekka Paalanen <ppaalanen@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Simon Ser <contact@emersion.fr>,
        Rob Clark <robdclark@chromium.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "open list:SYNC FILE FRAMEWORK" <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        open list <linux-kernel@vger.kernel.org>
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

On Mon, Feb 20, 2023 at 12:53 AM Pekka Paalanen <ppaalanen@gmail.com> wrote:
>
> On Sat, 18 Feb 2023 13:15:49 -0800
> Rob Clark <robdclark@gmail.com> wrote:
>
> > From: Rob Clark <robdclark@chromium.org>
> >
> > Allow userspace to use the EPOLLPRI/POLLPRI flag to indicate an urgent
> > wait (as opposed to a "housekeeping" wait to know when to cleanup after
> > some work has completed).  Usermode components of GPU driver stacks
> > often poll() on fence fd's to know when it is safe to do things like
> > free or reuse a buffer, but they can also poll() on a fence fd when
> > waiting to read back results from the GPU.  The EPOLLPRI/POLLPRI flag
> > lets the kernel differentiate these two cases.
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
>
> Hi,
>
> where would the UAPI documentation of this go?
> It seems to be missing.

Good question, I am not sure.  The poll() man page has a description,
but my usage doesn't fit that _exactly_ (but OTOH the description is a
bit vague).

> If a Wayland compositor is polling application fences to know which
> client buffer to use in its rendering, should the compositor poll with
> PRI or not? If a compositor polls with PRI, then all fences from all
> applications would always be PRI. Would that be harmful somehow or
> would it be beneficial?

I think a compositor would rather use the deadline ioctl and then poll
without PRI.  Otherwise you are giving an urgency signal to the fence
signaller which might not necessarily be needed.

The places where I expect PRI to be useful is more in mesa (things
like glFinish(), readpix, and other similar sorts of blocking APIs)

BR,
-R

>
>
> Thanks,
> pq
>
> > ---
> >  drivers/dma-buf/sync_file.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/dma-buf/sync_file.c b/drivers/dma-buf/sync_file.c
> > index fb6ca1032885..c30b2085ee0a 100644
> > --- a/drivers/dma-buf/sync_file.c
> > +++ b/drivers/dma-buf/sync_file.c
> > @@ -192,6 +192,14 @@ static __poll_t sync_file_poll(struct file *file, poll_table *wait)
> >  {
> >       struct sync_file *sync_file = file->private_data;
> >
> > +     /*
> > +      * The POLLPRI/EPOLLPRI flag can be used to signal that
> > +      * userspace wants the fence to signal ASAP, express this
> > +      * as an immediate deadline.
> > +      */
> > +     if (poll_requested_events(wait) & EPOLLPRI)
> > +             dma_fence_set_deadline(sync_file->fence, ktime_get());
> > +
> >       poll_wait(file, &sync_file->wq, wait);
> >
> >       if (list_empty(&sync_file->cb.node) &&
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA716A0FC2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 19:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjBWSwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 13:52:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBWSwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 13:52:03 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A125ED;
        Thu, 23 Feb 2023 10:52:00 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id bl7so13817602oib.0;
        Thu, 23 Feb 2023 10:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9etLRVSdOXaCscwmv+H7k7gnP7xVJUcjkddH6jLBVsc=;
        b=lApunCCDvEH6I8seeTQWVdZ9Rl8Q3moAjjItt8N6ft0ZoY70iHtjuSJdHugMxX07r1
         ZtN3GKSVJ6bGdeUS2EWN3DOTkVdp65ta/gpjbkPAVViT37G9Po3tAlvjabbXl0jXA/4t
         TxHjG4Vt+3Bl+ud85wIvvNKQzKcMczMIlpIDMgeRO5xQpSqkMyhj0OO0F+R8HPKdVZlp
         Bh3SZk0qNo7WV2lwvQcmGEZXAwkV9ADO7wWlgznwn0YlZ5+DaPfXsLsLJMYBVirNrcpY
         L9kQ6IoEXtYM0e81IJqNHDgCa9E0j8yJaPuQwN/E5oPbXKA6/RQlDkPWxVNXZnoLiYk6
         fLYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9etLRVSdOXaCscwmv+H7k7gnP7xVJUcjkddH6jLBVsc=;
        b=Bv4X3BePZmB3An257A2w59s1iyoGl06OifL9WXLDJ5oNRbZcgICEYQj+OH3fTx1l4f
         X50ln9+1G3gR/rI3M2ekcZ8R5QZISdstakWq75tb47h82ctpSR2pM4rfFjiZETUeL7um
         F7g81boaTdtL0YCJglwHo2EFhJsF8cdBfloqpOFMFE+CEQQvK7fiNLXIJ/01e/b+IlJN
         mjVPW2FG0LdyVfvKuG8VWRPgf9IPExuVMfv1+aZq316xSSr7c6iGOPwQTNlby4AzBxs+
         yg50mPEF603pG0+SaIWnWRLfyeBVzV+ftPYDNvO++jIMTpUhMfsbKEds6L/yUDLwNImJ
         jHaQ==
X-Gm-Message-State: AO0yUKXfYEsmwYjbFlFFg8vYdunc7VIV0tWRRzuGxTGgOQnKdldKzzEb
        RdWPx56odzS22ailsG3Yo/GS3UmdyUNytAYPtro=
X-Google-Smtp-Source: AK7set/2kHcAeaPabhjfKagmHPvKDBzXht3PAv66qqwhYDd8r2Wthl7b7KZTXESDtH12eZQLfwEOP6txv1t+qNTMPqE=
X-Received: by 2002:a05:6808:610:b0:37a:fd14:1246 with SMTP id
 y16-20020a056808061000b0037afd141246mr278284oih.3.1677178319578; Thu, 23 Feb
 2023 10:51:59 -0800 (PST)
MIME-Version: 1.0
References: <20230218211608.1630586-1-robdclark@gmail.com> <20230218211608.1630586-7-robdclark@gmail.com>
 <20230220105345.70e46fa5@eldfell> <CAF6AEGv9fLQCD65ytRTGp=EkNB1QoZYH5ArphgGQALV9J08Cmw@mail.gmail.com>
 <cdd5f892-49b9-1e22-4dc1-95a8a733c453@amd.com> <CAF6AEGuMn3FywPkEtfJ7oZ16A0Bk2aiaRvj4si4od1d3wzXkPw@mail.gmail.com>
 <20230222114900.1b6baf95@eldfell> <CAF6AEGs1_75gg+LCBj6=PH8Jn60PXiE+Kx_2636nP-+pajN8Hg@mail.gmail.com>
 <20230223113814.3010cedc@eldfell>
In-Reply-To: <20230223113814.3010cedc@eldfell>
From:   Rob Clark <robdclark@gmail.com>
Date:   Thu, 23 Feb 2023 10:51:48 -0800
Message-ID: <CAF6AEGuE89kuKTjjzwW1xMppcVw-M4-hcrtifed-mvsCA=cshQ@mail.gmail.com>
Subject: Re: [PATCH v4 06/14] dma-buf/sync_file: Support (E)POLLPRI
To:     Pekka Paalanen <ppaalanen@gmail.com>
Cc:     Luben Tuikov <luben.tuikov@amd.com>,
        Rob Clark <robdclark@chromium.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        freedreno@lists.freedesktop.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "open list:SYNC FILE FRAMEWORK" <linux-media@vger.kernel.org>
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

On Thu, Feb 23, 2023 at 1:38 AM Pekka Paalanen <ppaalanen@gmail.com> wrote:
>
> On Wed, 22 Feb 2023 07:37:26 -0800
> Rob Clark <robdclark@gmail.com> wrote:
>
> > On Wed, Feb 22, 2023 at 1:49 AM Pekka Paalanen <ppaalanen@gmail.com> wrote:
> > >
> > > On Tue, 21 Feb 2023 09:53:56 -0800
> > > Rob Clark <robdclark@gmail.com> wrote:
> > >
> > > > On Tue, Feb 21, 2023 at 8:48 AM Luben Tuikov <luben.tuikov@amd.com> wrote:
> > > > >
> > > > > On 2023-02-20 11:14, Rob Clark wrote:
> > > > > > On Mon, Feb 20, 2023 at 12:53 AM Pekka Paalanen <ppaalanen@gmail.com> wrote:
> > > > > >>
> > > > > >> On Sat, 18 Feb 2023 13:15:49 -0800
> > > > > >> Rob Clark <robdclark@gmail.com> wrote:
> > > > > >>
> > > > > >>> From: Rob Clark <robdclark@chromium.org>
> > > > > >>>
> > > > > >>> Allow userspace to use the EPOLLPRI/POLLPRI flag to indicate an urgent
> > > > > >>> wait (as opposed to a "housekeeping" wait to know when to cleanup after
> > > > > >>> some work has completed).  Usermode components of GPU driver stacks
> > > > > >>> often poll() on fence fd's to know when it is safe to do things like
> > > > > >>> free or reuse a buffer, but they can also poll() on a fence fd when
> > > > > >>> waiting to read back results from the GPU.  The EPOLLPRI/POLLPRI flag
> > > > > >>> lets the kernel differentiate these two cases.
> > > > > >>>
> > > > > >>> Signed-off-by: Rob Clark <robdclark@chromium.org>
> > > > > >>
> > > > > >> Hi,
> > > > > >>
> > > > > >> where would the UAPI documentation of this go?
> > > > > >> It seems to be missing.
> > > > > >
> > > > > > Good question, I am not sure.  The poll() man page has a description,
> > > > > > but my usage doesn't fit that _exactly_ (but OTOH the description is a
> > > > > > bit vague).
> > > > > >
> > > > > >> If a Wayland compositor is polling application fences to know which
> > > > > >> client buffer to use in its rendering, should the compositor poll with
> > > > > >> PRI or not? If a compositor polls with PRI, then all fences from all
> > > > > >> applications would always be PRI. Would that be harmful somehow or
> > > > > >> would it be beneficial?
> > > > > >
> > > > > > I think a compositor would rather use the deadline ioctl and then poll
> > > > > > without PRI.  Otherwise you are giving an urgency signal to the fence
> > > > > > signaller which might not necessarily be needed.
> > > > > >
> > > > > > The places where I expect PRI to be useful is more in mesa (things
> > > > > > like glFinish(), readpix, and other similar sorts of blocking APIs)
> > > > > Hi,
> > > > >
> > > > > Hmm, but then user-space could do the opposite, namely, submit work as usual--never
> > > > > using the SET_DEADLINE ioctl, and then at the end, poll using (E)POLLPRI. That seems
> > > > > like a possible usage pattern, unintended--maybe, but possible. Do we want to discourage
> > > > > this? Wouldn't SET_DEADLINE be enough? I mean, one can call SET_DEADLINE with the current
> > > > > time, and then wouldn't that be equivalent to (E)POLLPRI?
> > > >
> > > > Yeah, (E)POLLPRI isn't strictly needed if we have SET_DEADLINE.  It is
> > > > slightly more convenient if you want an immediate deadline (single
> > > > syscall instead of two), but not strictly needed.  OTOH it piggy-backs
> > > > on existing UABI.
> > >
> > > In that case, I would be conservative, and not add the POLLPRI
> > > semantics. An UAPI addition that is not strictly needed and somewhat
> > > unclear if it violates any design principles is best not done, until it
> > > is proven to be beneficial.
> > >
> > > Besides, a Wayland compositor does not necessary need to add the fd
> > > to its main event loop for poll. It could just SET_DEADLINE, and then
> > > when it renders simply check if the fence passed or not already. Not
> > > polling means the compositor does not need to wake up at the moment the
> > > fence signals to just record a flag.
> >
> > poll(POLLPRI) isn't intended for wayland.. but is a thing I want in
> > mesa for fence waits.  I _could_ use SET_DEADLINE but it is two
> > syscalls and correspondingly more code ;-)
>
> But is it actually beneficial? "More code" seems quite irrelevant.
>
> Would there be a hundred or more of those per frame? Or would it be
> always limited to one or two? Or totally depend on what the application
> is doing? Is it a significant impact?

In general, any time the CPU is waiting on the GPU, you have already
lost.  So I don't think the extra syscall is too much of a problem.
Just less convenient.

> > > On another matter, if the application uses SET_DEADLINE with one
> > > timestamp, and the compositor uses SET_DEADLINE on the same thing with
> > > another timestamp, what should happen?
> >
> > The expectation is that many deadline hints can be set on a fence.
> > The fence signaller should track the soonest deadline.
>
> You need to document that as UAPI, since it is observable to userspace.
> It would be bad if drivers or subsystems would differ in behaviour.
>

It is in the end a hint.  It is about giving the driver more
information so that it can make better choices.  But the driver is
even free to ignore it.  So maybe "expectation" is too strong of a
word.  Rather, any other behavior doesn't really make sense.  But it
could end up being dictated by how the hw and/or fw works.

BR,
-R

>
> Thanks,
> pq

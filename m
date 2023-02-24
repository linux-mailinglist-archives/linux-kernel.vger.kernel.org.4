Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA6F6A2023
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 17:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjBXQ7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 11:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjBXQ73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 11:59:29 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE6636699
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 08:59:27 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id a1so63169iln.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 08:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cgb2Pi/t2+xLmkEYHOFf3TZk2XgRIBjhzG/Zzuc83GQ=;
        b=Lcofwkl6IObDV6pgHqsiHmpthopPqDn70FpulBH/lBCxg80REwmK4gyivYBg+BGWE3
         4KUkXVqScsKkjpS6oys7y7lvqIzCsP0bNHrC5alM3eM1A2ee2m6gOKy2TN7gedKhZPBi
         DMIhEp7lTLj9jJUTSe6rcdvQ7zSc6nZglsPSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cgb2Pi/t2+xLmkEYHOFf3TZk2XgRIBjhzG/Zzuc83GQ=;
        b=Ss+vHL9qiYNtTE0ma9PfR+guTK/nGAuA39ZEdO6+oKWCIinMKXty4IgR6CHrxUNWHk
         Vk4pXGIhnP5spsO6kQuwL60hkfeBweWQLoJFjlvR1jauZ/h3oMsxCPNd7MHLiXCgLMoE
         7iBSu2O9dMCdvJe9ULPdFpjMUgB6ikhUC3FpR/RtNvgiiawYRb1SJefkvc9KKaJsKQo9
         5LuryKjhYyeZidqIYo06QfVygmf+gHIYENhoqYPAHGKi6Ysiwj54h7YsxJxM2bWoQCkt
         ypeV5/fQ94gyRmkKRSh14NsFcSr7H/sFYrW1i++hWRyS3i2jwH6EUHGQ9729IPg50DYv
         l/pA==
X-Gm-Message-State: AO0yUKUOzTA1qQ/WPiQiNnrazc4gLaoRNOr2AFHb4MjTfLxjWc7/Ivpl
        kKI7TGgeK3KmG/wCmYvR2GLY9pzxwSUQj/bEh6xr+Q==
X-Google-Smtp-Source: AK7set89tPfCiQx1TeTpVE7VEuTTfs2VElYgre0wHA0ER1lxWwV1AVI1CfcLHKiR5eO8MhdmPewkq9q07Mnx5aY4d7U=
X-Received: by 2002:a05:6e02:1a2e:b0:313:af46:81ba with SMTP id
 g14-20020a056e021a2e00b00313af4681bamr5118495ile.3.1677257967132; Fri, 24 Feb
 2023 08:59:27 -0800 (PST)
MIME-Version: 1.0
References: <20230218211608.1630586-1-robdclark@gmail.com> <20230218211608.1630586-7-robdclark@gmail.com>
 <20230220105345.70e46fa5@eldfell> <CAF6AEGv9fLQCD65ytRTGp=EkNB1QoZYH5ArphgGQALV9J08Cmw@mail.gmail.com>
 <cdd5f892-49b9-1e22-4dc1-95a8a733c453@amd.com> <CAF6AEGuMn3FywPkEtfJ7oZ16A0Bk2aiaRvj4si4od1d3wzXkPw@mail.gmail.com>
 <20230222114900.1b6baf95@eldfell> <CAF6AEGs1_75gg+LCBj6=PH8Jn60PXiE+Kx_2636nP-+pajN8Hg@mail.gmail.com>
 <20230223113814.3010cedc@eldfell> <CAF6AEGuE89kuKTjjzwW1xMppcVw-M4-hcrtifed-mvsCA=cshQ@mail.gmail.com>
 <20230224112630.313d7b76@eldfell> <a47e2686-1e35-39a3-0f0c-6c3b9522f8ff@linux.intel.com>
 <20230224122403.6a088da1@eldfell>
In-Reply-To: <20230224122403.6a088da1@eldfell>
From:   Rob Clark <robdclark@chromium.org>
Date:   Fri, 24 Feb 2023 08:59:16 -0800
Message-ID: <CAJs_Fx76a9m02p4XwZpjjpyQ35d621669fL9XPB4T-nwThr7tA@mail.gmail.com>
Subject: Re: [PATCH v4 06/14] dma-buf/sync_file: Support (E)POLLPRI
To:     Pekka Paalanen <ppaalanen@gmail.com>
Cc:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Rob Clark <robdclark@gmail.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Luben Tuikov <luben.tuikov@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        freedreno@lists.freedesktop.org,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "open list:SYNC FILE FRAMEWORK" <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 2:24 AM Pekka Paalanen <ppaalanen@gmail.com> wrote:
>
> On Fri, 24 Feb 2023 09:41:46 +0000
> Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com> wrote:
>
> > On 24/02/2023 09:26, Pekka Paalanen wrote:
> > > On Thu, 23 Feb 2023 10:51:48 -0800
> > > Rob Clark <robdclark@gmail.com> wrote:
> > >
> > >> On Thu, Feb 23, 2023 at 1:38 AM Pekka Paalanen <ppaalanen@gmail.com> wrote:
> > >>>
> > >>> On Wed, 22 Feb 2023 07:37:26 -0800
> > >>> Rob Clark <robdclark@gmail.com> wrote:
> > >>>
> > >>>> On Wed, Feb 22, 2023 at 1:49 AM Pekka Paalanen <ppaalanen@gmail.com> wrote:
> > >
> > > ...
> > >
> > >>>>> On another matter, if the application uses SET_DEADLINE with one
> > >>>>> timestamp, and the compositor uses SET_DEADLINE on the same thing with
> > >>>>> another timestamp, what should happen?
> > >>>>
> > >>>> The expectation is that many deadline hints can be set on a fence.
> > >>>> The fence signaller should track the soonest deadline.
> > >>>
> > >>> You need to document that as UAPI, since it is observable to userspace.
> > >>> It would be bad if drivers or subsystems would differ in behaviour.
> > >>>
> > >>
> > >> It is in the end a hint.  It is about giving the driver more
> > >> information so that it can make better choices.  But the driver is
> > >> even free to ignore it.  So maybe "expectation" is too strong of a
> > >> word.  Rather, any other behavior doesn't really make sense.  But it
> > >> could end up being dictated by how the hw and/or fw works.
> > >
> > > It will stop being a hint once it has been implemented and used in the
> > > wild long enough. The kernel userspace regression rules make sure of
> > > that.
> >
> > Yeah, tricky and maybe a gray area in this case. I think we eluded
> > elsewhere in the thread that renaming the thing might be an option.
> >
> > So maybe instead of deadline, which is a very strong word, use something
> > along the lines of "present time hint", or "signalled time hint"? Maybe
> > reads clumsy. Just throwing some ideas for a start.
>
> You can try, but I fear that if it ever changes behaviour and
> someone notices that, it's labelled as a kernel regression. I don't
> think documentation has ever been the authoritative definition of UABI
> in Linux, it just guides drivers and userspace towards a common
> understanding and common usage patterns.
>
> So even if the UABI contract is not documented (ugh), you need to be
> prepared to set the UABI contract through kernel implementation.
>
> If you do not document the UABI contract, then different drivers are
> likely to implement it differently, leading to differing behaviour.
> Also userspace will invent wild ways to abuse the UABI if there is no
> documentation guiding it on proper use. If userspace or end users
> observe different behaviour, that's bad even if it's not a regression.
>
> I don't like the situation either, but it is what it is. UABI stability
> trumps everything regardless of whether it was documented or not.
>
> I bet userspace is going to use this as a "make it faster, make it
> hotter" button. I would not be surprised if someone wrote a LD_PRELOAD
> library that stamps any and all fences with an expired deadline to
> just squeeze out a little more through some weird side-effect.

Ok, maybe we can rename the SET_DEADLINE ioctl to SPACEBAR_HEATER ;-)

BR,
-R

> Well, that's hopefully overboard in scaring, but in the end, I would
> like to see UABI documented so I can have a feeling of what it is for
> and how it was intended to be used. That's all.
>
>
> Thanks,
> pq

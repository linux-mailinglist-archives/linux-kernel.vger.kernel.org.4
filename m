Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2A66D934C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 11:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236246AbjDFJwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 05:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237054AbjDFJvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 05:51:09 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07648688
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 02:49:39 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-930bc91df7bso128379966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 02:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1680774538;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aDwrP3AJyNgCVfwTeR5DD8c7qrP0LtIWfiov4Z3AarM=;
        b=cstLYe7M4RoxLG29+q0M6d7Lm5hfQEeU3UG61zxe8QVyXdYljKPBzpCJHnzcKEABSa
         0OGVHekcbqLxOesJvFlIiwjJUmbcLSzV5nbaivV08Rpxv/E7QBYqBKdIP/LorG1wgfHc
         udnXrNomIhQJLByUElhfl7ovERpDrSY54m02E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680774538;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aDwrP3AJyNgCVfwTeR5DD8c7qrP0LtIWfiov4Z3AarM=;
        b=WrcejG6nByXCzz0AZ5HURuUAqEpjf0b5otrzo3iBCs6FCcH0IB9HJznSx5JawjXFOv
         ji2PAAB15KllkN7G6D7biQ8L5NLyojXbE7+bbBSfkfJEscwhs7Gi8JUrCo5KZmz04hCT
         LT/b/HTsxiWVYpFSUWAbkbDwFBWTjnHtv/08r9acUaVu14OJSQmxHsj5ONgYyAgm510C
         FmYscujS8wiMjpoBXENeQ7ITJm5d/0JKiwsZ9tUBadUlAjNlI4AbnV1nId+fO7XtcnAE
         22kg4na3byfRXEKnDUQhrz38eVa15fB0AKgsWV//AUJaxg73kk0P06+Lp0JsKEFngHco
         Wg4Q==
X-Gm-Message-State: AAQBX9eAeEdWs7EpM2/lTTGYsJVs4AazDFEK0wrv9J0YnAdeCZhyAxaH
        2mL4Se2XcA/LIwPlpx3qmcQAzQ==
X-Google-Smtp-Source: AKy350Z0g0Bo4tFTGxtpF07AEU8bHqYdbH9guA26p5+I5RST2ZBfr8PxxEqR2cMj6wyMxRMTmvQ+Hg==
X-Received: by 2002:a17:906:2216:b0:947:bff2:1c2d with SMTP id s22-20020a170906221600b00947bff21c2dmr5909987ejs.3.1680774538287;
        Thu, 06 Apr 2023 02:48:58 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id qb19-20020a1709077e9300b00948da767832sm581534ejc.152.2023.04.06.02.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 02:48:57 -0700 (PDT)
Date:   Thu, 6 Apr 2023 11:48:55 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Asahi Lina <lina@asahilina.net>
Cc:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, asahi@lists.linux.dev
Subject: Re: [PATCH] drm/scheduler: Fix UAF in
 drm_sched_fence_get_timeline_name
Message-ID: <ZC6Vh2gG91zXUKJW@phenom.ffwll.local>
Mail-Followup-To: Asahi Lina <lina@asahilina.net>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        David Airlie <airlied@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, asahi@lists.linux.dev
References: <20230406-scheduler-uaf-1-v1-1-8e5662269d25@asahilina.net>
 <6b3433ee-0712-f789-51ee-3047ead9bb79@amd.com>
 <cfbaceae-6d40-a8b3-e449-6473be234d2d@asahilina.net>
 <180bd178-e3c0-85e3-785e-fc8a216cf65e@amd.com>
 <df226249-734e-cb9e-8bc0-1eff625277e0@asahilina.net>
 <4ea53272-6324-96e6-ab29-82bccb624683@asahilina.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4ea53272-6324-96e6-ab29-82bccb624683@asahilina.net>
X-Operating-System: Linux phenom 6.1.0-7-amd64 
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 06:27:27PM +0900, Asahi Lina wrote:
> On 06/04/2023 18.15, Asahi Lina wrote:
> > On 06/04/2023 18.06, Christian König wrote:
> > > Am 06.04.23 um 10:49 schrieb Asahi Lina:
> > > > On 06/04/2023 17.29, Christian König wrote:
> > > > > Am 05.04.23 um 18:34 schrieb Asahi Lina:
> > > > > > A signaled scheduler fence can outlive its scheduler, since fences are
> > > > > > independently reference counted.
> > > > > 
> > > > > Well that is actually not correct. Schedulers are supposed to stay
> > > > > around until the hw they have been driving is no longer present.
> > > > 
> > > > But the fences can outlive that. You can GPU render into an imported
> > > > buffer, which attaches a fence to it. Then the GPU goes away but the
> > > > fence is still attached to the buffer. Then you oops when you cat that
> > > > debugfs file...
> > > 
> > > No, exactly that's the point you wouldn't ops.
> > > 
> > > > 
> > > > My use case does this way more often (since schedulers are tied to
> > > > UAPI objects), which is how I found this, but as far as I can tell
> > > > this is already broken for all drivers on unplug/unbind/anything else
> > > > that would destroy the schedulers with fences potentially referenced
> > > > on separate scanout devices or at any other DMA-BUF consumer.
> > > 
> > > Even if a GPU is hot plugged the data structures for it should only go
> > > away with the last reference, since the scheduler fence is referencing
> > > the hw fence and the hw fence in turn is referencing the driver this
> > > shouldn't happen.
> > 
> > So those fences can potentially keep half the driver data structures
> > alive just for existing in a signaled state? That doesn't seem sensible
> > (and it definitely doesn't work for our use case where schedulers can be
> > created and destroyed freely, it could lead to way too much junk
> > sticking around in memory).

This is why the split betwen the hw fence and the public sched fence.
Because once the hw fence stuff is sorted it should all be able to go
away, without the public fence keeping everything alive.

> > > > > E.g. the reference was scheduler_fence->hw_fence->driver->scheduler.
> > > > 
> > > > It's up to drivers not to mess that up, since the HW fence has the
> > > > same requirements that it can outlive other driver objects, just like
> > > > any other fence. That's not something the scheduler has to be
> > > > concerned with, it's a driver correctness issue.
> > > > 
> > > > Of course, in C you have to get it right yourself, while with correct
> > > > Rust abstractions will cause your code to fail to compile if you do it
> > > > wrong ^^
> > > > 
> > > > In my particular case, the hw_fence is a very dumb object that has no
> > > > references to anything, only an ID and a pending op count. Jobs hold
> > > > references to it and decrement it until it signals, not the other way
> > > > around. So that object can live forever regardless of whether the rest
> > > > of the device is gone.
> > > 
> > > That is then certainly a bug. This won't work that way, and the timelime
> > > name is just the tip of the iceberg here.
> > > 
> > > The fence reference count needs to keep both the scheduler and driver
> > > alive. Otherwise you could for example unload the module and immediately
> > > ops because your fence_ops go away.
> > 
> > Yes, I realized the module issue after writing the email. But that's the
> > *only* thing it needs to hold a reference to! Which is much more
> > sensible than keeping a huge chunk of UAPI-adjacent data structures
> > alive for a signaled fence that for all we know might stick around
> > forever attached to some buffer.
> > 
> > > > > Your use case is now completely different to that and this won't work
> > > > > any more.
> > > > > 
> > > > > This here might just be the first case where that breaks.
> > > > 
> > > > This bug already exists, it's just a lot rarer for existing use
> > > > cases... but either way Xe is doing the same thing I am, so I'm not
> > > > the only one here either.
> > > 
> > > No it doesn't. You just have implemented the references differently than
> > > they are supposed to be.
> > > 
> > > Fixing this one occasion here would mitigate that immediate ops, but
> > > doesn't fix the fundamental problem.
> > 
> > Honestly, at this point I'm starting to doubt whether we want to use
> > drm_scheduler at all, because it clearly wasn't designed for our use
> > case and every time I try to fix something your answer has been "you're
> > using it wrong", and at the same time the practically nonexistent
> > documentation makes it impossible to know how it was actually designed
> > to be used.
> 
> Also, requiring that the hw_fence keep the scheduler alive (which is
> documented nowhere) is a completely ridiculous lifetime requirement and
> layering violation across multiple subsystems. I have no idea how I'd make
> Rust abstractions uphold that requirement safely without doing something
> silly like having abstraction-specific hw_fence wrappers, and then you run
> into deadlocks due to the scheduler potentially being dropped from the
> job_done callback when the fence reference is dropped and just... no,
> please. This is terrible. If you don't want me to fix it we'll have to find
> another way because I can't work with this.

So generally the hw fence keeps the underlying gpu ctx alive, and the gpu
context keeps the gpu vm alive. Pretty much has to, or your gpu starts
executing stuff that's freed.

Now for fw scheduler gpu ctx isn't just drm_sched_entity, but also
drm_scheduler. Plus whatever driver stuff you have lying around for a ctx.
Plus ofc a reference to the vm, which might in turn keep a ton of gem_bo
alive.

Still I'm not seeing where the fundamental issue is in this refcount
scheme, or where it's silly? Mapping this all to Rust correctly is a
challenge for sure, and also untangling the assumption that drm_scheduler
is suddenly a lot more dynamic object (see my other reply), but
fundamentally calling this all silly and terrible I don't understand ...
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

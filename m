Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8790F70F469
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 12:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbjEXKkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 06:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbjEXKkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 06:40:40 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECE31A8
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 03:40:29 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-50a20bfe366so273354a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 03:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1684924828; x=1687516828;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vSBx3Jy1mTVvH1DDifa+BTFAVrVdzMfrjrerJocMzTc=;
        b=MsncBU0Xz5NtTD5S78mXMEeC4K94W2pwnNzWeSZrGQG5dJS82huGUy3CeFMYH9IiDt
         uJrbvxQOo8WvI+Zx2GRQ6Z3AbzchyrDuGEXD5OdYlnDK9XhsxexvCXh09C24BvmE40dX
         9mvid7TkCoJwkRNQPQd8tZNSIFdp98fDgbtnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684924828; x=1687516828;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vSBx3Jy1mTVvH1DDifa+BTFAVrVdzMfrjrerJocMzTc=;
        b=jRC/wPKegHxTlOxh9YlaY7fTDsAAkiK6YpdGqA9gAlDVsZmhl34Lb4UNZ/6hFvIs+h
         035tK1vPJNcMuJekhzYpsCnVVkZjj4VccaVDQBrf8A2IQoCp1+v6nzaRnrJd3jhLcIGo
         ZD6W5ejIgDMl95GJvQlNs9HBMte4GjTMVRKAH2nqkH7QlQ8+8yoec3DeT9xaqpY0pJJ9
         zHtwfKg9ZvHGfged5Of7FFog/kKqq2n/c72WObI86h0IXClETzEyVaW1dGeG+JiIagom
         AU5ZSmWoaxm5U1+COAD7hG9NpzgC7oESoa2r7WsuRTl199ORhZJdYkgGi+PmmqH23qMC
         eyiA==
X-Gm-Message-State: AC+VfDyO31Vq7Wf1n4IyGUThdEmqvsynUN8LwXom3ciSV/LN8F16w2P7
        im6V7GXotLOQ7agrC9/X2aV31A==
X-Google-Smtp-Source: ACHHUZ4KUw5NB3BOPHGF+oh7fuHhF9gCQe2opcFl/h4sFdwHa3h9ymnCb0ViPZg5quW6K3zoFzNnhA==
X-Received: by 2002:a17:906:72ce:b0:96f:56ab:c69b with SMTP id m14-20020a17090672ce00b0096f56abc69bmr1766954ejl.3.1684924827732;
        Wed, 24 May 2023 03:40:27 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id c25-20020a170906155900b0094f282fc29asm5554047ejd.207.2023.05.24.03.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 03:40:27 -0700 (PDT)
Date:   Wed, 24 May 2023 12:40:25 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Alexandre Bailon <abailon@baylibre.com>, airlied@gmail.com,
        daniel@ffwll.ch, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de,
        devicetree@vger.kernel.org, conor+dt@kernel.org, bero@baylibre.com,
        jstephan@baylibre.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, christian.koenig@amd.com,
        linaro-mm-sig@lists.linaro.org, robh+dt@kernel.org,
        linux-mediatek@lists.infradead.org, nbelin@baylibre.com,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        linux-media@vger.kernel.org, sumit.semwal@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        angelogioacchino.delregno@collabora.com
Subject: Re: [PATCH 0/7] Add a DRM driver to support AI Processing Unit (APU)
Message-ID: <ZG3pmSnUSc9oCtev@phenom.ffwll.local>
Mail-Followup-To: Oded Gabbay <ogabbay@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Alexandre Bailon <abailon@baylibre.com>, airlied@gmail.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, devicetree@vger.kernel.org,
        conor+dt@kernel.org, bero@baylibre.com, jstephan@baylibre.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        christian.koenig@amd.com, linaro-mm-sig@lists.linaro.org,
        robh+dt@kernel.org, linux-mediatek@lists.infradead.org,
        nbelin@baylibre.com, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, linux-media@vger.kernel.org,
        sumit.semwal@linaro.org, linux-arm-kernel@lists.infradead.org,
        angelogioacchino.delregno@collabora.com
References: <20230517145237.295461-1-abailon@baylibre.com>
 <d0807fe4-dba2-8244-f655-d04e80973572@quicinc.com>
 <7ha5xud3m7.fsf@baylibre.com>
 <CAFCwf10hNjGtEYDi24LREnMLRGT7mRECvqQMdZWv=-uA7YELYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFCwf10hNjGtEYDi24LREnMLRGT7mRECvqQMdZWv=-uA7YELYg@mail.gmail.com>
X-Operating-System: Linux phenom 6.1.0-7-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 01:27:00PM +0300, Oded Gabbay wrote:
> On Wed, May 24, 2023 at 2:34 AM Kevin Hilman <khilman@baylibre.com> wrote:
> >
> > Jeffrey Hugo <quic_jhugo@quicinc.com> writes:
> >
> > > On 5/17/2023 8:52 AM, Alexandre Bailon wrote:
> > >> This adds a DRM driver that implements communication between the CPU and an
> > >> APU. The driver target embedded device that usually run inference using some
> > >> prebuilt models. The goal is to provide common infrastructure that could be
> > >> re-used to support many accelerators. Both kernel, userspace and firmware tries
> > >> to use standard and existing to leverage the development and maintenance effort.
> > >> The series implements two platform drivers, one for simulation and another one for
> > >> the mt8183 (compatible with mt8365).
> > >
> > > This looks like the 3 existing Accel drivers.  Why is this in DRM?
> >
> > Yes, this belongs in accel.  I think Alex had some issues around the
> > infra in accel with device nodes not appearing/opening properly, but
> > I'll let him comment there.  But either way, the right approach should
> > be to fix any issues in accel and move it there.
> >
> > [...]
> >
> > >>   .../devicetree/bindings/gpu/mtk,apu-drm.yaml  |  38 ++
> > >>   drivers/gpu/drm/Kconfig                       |   2 +
> > >>   drivers/gpu/drm/Makefile                      |   1 +
> > >>   drivers/gpu/drm/apu/Kconfig                   |  22 +
> > >>   drivers/gpu/drm/apu/Makefile                  |  10 +
> > >>   drivers/gpu/drm/apu/apu_drv.c                 | 282 +++++++++
> > >>   drivers/gpu/drm/apu/apu_gem.c                 | 230 +++++++
> > >>   drivers/gpu/drm/apu/apu_internal.h            | 205 ++++++
> > >>   drivers/gpu/drm/apu/apu_sched.c               | 592 ++++++++++++++++++
> > >>   drivers/gpu/drm/apu/simu_apu.c                | 313 +++++++++
> > >>   include/uapi/drm/apu_drm.h                    |  81 +++
> > >
> > > "apu" seems too generic.  We already have 3 "AI processing units" over
> > > in drivers/accel already...
> >
> > Indeed, it is generic, but that's kind of the point for this driver
> > since it's targetted at generalizing the interface with "AI processing
> > units" on a growing number of embedded SoCs (ARM, RISC-V, etc.)  In
> > addition, the generic naming is intentional because the goal is bigger
> > than the kernel and is working towards a generic, shared "libAPU"
> > userspace[1], but also common firmware for DSP-style inference engines
> > (e.g. analgous Sound Open Firmware for audio DSPs.)
> >
> > As usual, the various SoC vendors use different names (APU, NPU, NN
> > unit, etc.)  but we'd like a generic name for the class of devices
> > targetted by this driver.  And unfortunately, it looks like the equally
> > generic "Versatile processing unit" is already taken Intel's
> > drivers/accel/ivpu. :)
> >
> > Maybe since this is more about generalizing the interface between the
> > CPU running linux and the APU, what about the name apu_if?  But I guess
> > that applies to the other 3 drivers in drivers/accell also.  Hmmm...
> >
> > Naming things is hard[2], so we're definitly open to other ideas.  Any
> > suggestions?
> Maybe model it according to the tiny driver in drm display ? You can
> then call it tiny_apu :-)
> Disclosure: It was Daniel's suggestion, he can chime in with more
> details on the tiny driver concept.

Yeah so maybe a bit more detail on my thoughts:

First this smells like a need bypass of the entire "we want open userspace
for accel drivers" rule. The rule isn't quite a strict as for drm gpu
drivers (not sure we ended up documenting exactly what, but iirc the
consensus was that for build-time only dependencies we're ok with
downstream compilers), but it's still there.

And at least from a quick look apu.ko and libapu just look like a generic
accel interface, and that's not enough.

For the big training engines it's more or less "enough to run pytorch, but
it can be really slow", not sure what the right standard for these
inference-only drivers should be.

So that's the first reason why I don't like this.

The other is that I think if we do end up with a pile of tiny accel
drivers, we should probably look into something like simmpledrm for the
tiny display drivers. Probably still IP specific ioctls (at least most) so
that IP specific job knows and all that are easy, but then just pass to a
framework that simplifies a drm gem driver to "write ptes" and "run job"
callback, maybe with an optional "create/destroy vm/ctx" for hw which can
do that.

So maybe we end up with a drivers/accel/tiny and a bunch more helpers
around the existing gem ones. The rule we have for drm/tiny is "1 file,
less than 1kloc", and there's a bunch of them. I do think we can achieve
the same for tiny accel inference engines (but it's still a bit a road).
Maybe tiny accel is more like "less than 5kloc" since you need a bit more
glue for the driver specific ioctl stuff - maybe that's only needed for
the submit ioctl, maybe also for buffer map/unmap and creation.

Also note that there's an entire pile of in-flight work for adding new
helpers to the gem world to make this all easier. Once we have gpuva and
exec helpers there not much glue left to tie it all together with the
scheduler.

But the real crux is that an accel inference driver really needs to have
enough userspace to do an actual inference job with some
android/cros/whatever framework for inference (there's just too many).
-Daniel

> Oded
> 
> >
> > Kevin
> >
> > [1] https://gitlab.baylibre.com/baylibre/libapu/libapu
> >
> > [2]
> > "There are 2 hard problems in computer science: cache invalidation,
> >  naming things and off-by-1 errors."
> >  -- https://twitter.com/secretGeek/status/7269997868
> >

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F355743EA7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 17:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbjF3PWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 11:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbjF3PWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 11:22:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023C41BD0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 08:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688138521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A0/KJd9Ao12HpM7EhiEG+rTUpa+ZcmTLO37mgBG070Y=;
        b=bSrI/muWMfBC/nuy6tezm7EbKQSSvF1gxNuuZlNkGQqOGRhnnrRyo6O9GdrKf8x3yaTbDI
        fMBdxTSohVSZUSXXJ28vztIpWwC5IQpdQ4Fs2Y9gqmwxoa+OMiXIuTzLvrHcZ+BIdHpd3+
        hS3XAeXAgxECbm4OiUN0PJ/DvQtl/KM=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-gvmIXQFFNDGjJqCttC12gg-1; Fri, 30 Jun 2023 11:21:59 -0400
X-MC-Unique: gvmIXQFFNDGjJqCttC12gg-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4fb76659cacso2249611e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 08:21:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688138518; x=1690730518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A0/KJd9Ao12HpM7EhiEG+rTUpa+ZcmTLO37mgBG070Y=;
        b=IxYEKW8y1+3Rka+++CKgBM6C9oR2XCZsGs2KY2+FhaYS+vVgarqHW5yE379Goil+AC
         hEv2e1j5YelzDLqrszWkMtbX6xJgAH8mchppDYmEoB1bDjoaVThODldASspwvYnEZyBh
         DM4J0/fgHykuGPUKfUtHud0jo4x3DqSK16ay9dADkN97+x8nRoc8UuQiXaL2XxAl/S4H
         sj8Q/MKm2RmeoNhDPnPGIhJdEq0G3PWlzmTJhA0gB8Os+dXduB4nyjByVLUAbqlJ4PPS
         lLfQjC95agOwhnoPiiMjUdcuOHrwfBeKPQFR3DCoeitkkdSTsAGy3mEYNQaR9w5RLha2
         CWhg==
X-Gm-Message-State: ABy/qLaZHljcOnym3UsnqMVvYMEoSktlkPYYdu3T2i8juR6my8jsj/BS
        0YtmoKfyjZpMvzecEJ7hLIJPvcpdypj+mA38xxM88qlFiXX3mHi2SCYDyxRbAvH7ehoR7d9EbPG
        TGFN3qGFCkgiq5hb/T1pAiPN8vii8Q7r+f0QdRZKT
X-Received: by 2002:a05:6512:3192:b0:4f9:56aa:26c2 with SMTP id i18-20020a056512319200b004f956aa26c2mr2667474lfe.57.1688138518318;
        Fri, 30 Jun 2023 08:21:58 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFlISImJgeb+KOFXyH5xVPuwtFZ9105/CxI2wUwJVq6cP/HF7H6eStKguYKWYp1+faMrvgmLps7tpKo4XiRdwk=
X-Received: by 2002:a05:6512:3192:b0:4f9:56aa:26c2 with SMTP id
 i18-20020a056512319200b004f956aa26c2mr2667452lfe.57.1688138517933; Fri, 30
 Jun 2023 08:21:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230627132323.115440-1-andrealmeid@igalia.com>
 <CA+hFU4z1pc=KUVVqyqfXEceUqMXQgh-qUnuB=1nkPELghvQO7w@mail.gmail.com> <CADnq5_MNVdtdcWKSz6dgmsjg+kEu8p5FVE+fkw_5BaXeG3QGow@mail.gmail.com>
In-Reply-To: <CADnq5_MNVdtdcWKSz6dgmsjg+kEu8p5FVE+fkw_5BaXeG3QGow@mail.gmail.com>
From:   Sebastian Wick <sebastian.wick@redhat.com>
Date:   Fri, 30 Jun 2023 17:21:47 +0200
Message-ID: <CA+hFU4yg3DDEE=6J4yiS4z-KDDH6apkMQwa2q6rXd_vQZGjn3A@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] drm/doc: Document DRM device reset expectations
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
        pierre-eric.pelloux-prayer@amd.com,
        Samuel Pitoiset <samuel.pitoiset@gmail.com>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
        =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        Pekka Paalanen <ppaalanen@gmail.com>,
        =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
        dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
        alexander.deucher@amd.com, christian.koenig@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 4:59=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> On Fri, Jun 30, 2023 at 10:49=E2=80=AFAM Sebastian Wick
> <sebastian.wick@redhat.com> wrote:
> >
> > On Tue, Jun 27, 2023 at 3:23=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid=
@igalia.com> wrote:
> > >
> > > Create a section that specifies how to deal with DRM device resets fo=
r
> > > kernel and userspace drivers.
> > >
> > > Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>
> > > Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> > > ---
> > >
> > > v4: https://lore.kernel.org/lkml/20230626183347.55118-1-andrealmeid@i=
galia.com/
> > >
> > > Changes:
> > >  - Grammar fixes (Randy)
> > >
> > >  Documentation/gpu/drm-uapi.rst | 68 ++++++++++++++++++++++++++++++++=
++
> > >  1 file changed, 68 insertions(+)
> > >
> > > diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-u=
api.rst
> > > index 65fb3036a580..3cbffa25ed93 100644
> > > --- a/Documentation/gpu/drm-uapi.rst
> > > +++ b/Documentation/gpu/drm-uapi.rst
> > > @@ -285,6 +285,74 @@ for GPU1 and GPU2 from different vendors, and a =
third handler for
> > >  mmapped regular files. Threads cause additional pain with signal
> > >  handling as well.
> > >
> > > +Device reset
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +
> > > +The GPU stack is really complex and is prone to errors, from hardwar=
e bugs,
> > > +faulty applications and everything in between the many layers. Some =
errors
> > > +require resetting the device in order to make the device usable agai=
n. This
> > > +sections describes the expectations for DRM and usermode drivers whe=
n a
> > > +device resets and how to propagate the reset status.
> > > +
> > > +Kernel Mode Driver
> > > +------------------
> > > +
> > > +The KMD is responsible for checking if the device needs a reset, and=
 to perform
> > > +it as needed. Usually a hang is detected when a job gets stuck execu=
ting. KMD
> > > +should keep track of resets, because userspace can query any time ab=
out the
> > > +reset stats for an specific context. This is needed to propagate to =
the rest of
> > > +the stack that a reset has happened. Currently, this is implemented =
by each
> > > +driver separately, with no common DRM interface.
> > > +
> > > +User Mode Driver
> > > +----------------
> > > +
> > > +The UMD should check before submitting new commands to the KMD if th=
e device has
> > > +been reset, and this can be checked more often if the UMD requires i=
t. After
> > > +detecting a reset, UMD will then proceed to report it to the applica=
tion using
> > > +the appropriate API error code, as explained in the section below ab=
out
> > > +robustness.
> > > +
> > > +Robustness
> > > +----------
> > > +
> > > +The only way to try to keep an application working after a reset is =
if it
> > > +complies with the robustness aspects of the graphical API that it is=
 using.
> > > +
> > > +Graphical APIs provide ways to applications to deal with device rese=
ts. However,
> > > +there is no guarantee that the app will use such features correctly,=
 and the
> > > +UMD can implement policies to close the app if it is a repeating off=
ender,
> > > +likely in a broken loop. This is done to ensure that it does not kee=
p blocking
> > > +the user interface from being correctly displayed. This should be do=
ne even if
> > > +the app is correct but happens to trigger some bug in the hardware/d=
river.
> >
> > I still don't think it's good to let the kernel arbitrarily kill
> > processes that it thinks are not well-behaved based on some heuristics
> > and policy.
> >
> > Can't this be outsourced to user space? Expose the information about
> > processes causing a device and let e.g. systemd deal with coming up
> > with a policy and with killing stuff.
>
> I don't think it's the kernel doing the killing, it would be the UMD.
> E.g., if the app is guilty and doesn't support robustness the UMD can
> just call exit().

Ah, right, completely skipped over the UMD part. That makes more sense.
>
> Alex
>
> >
> > > +
> > > +OpenGL
> > > +~~~~~~
> > > +
> > > +Apps using OpenGL should use the available robust interfaces, like t=
he
> > > +extension ``GL_ARB_robustness`` (or ``GL_EXT_robustness`` for OpenGL=
 ES). This
> > > +interface tells if a reset has happened, and if so, all the context =
state is
> > > +considered lost and the app proceeds by creating new ones. If it is =
possible to
> > > +determine that robustness is not in use, the UMD will terminate the =
app when a
> > > +reset is detected, giving that the contexts are lost and the app won=
't be able
> > > +to figure this out and recreate the contexts.
> > > +
> > > +Vulkan
> > > +~~~~~~
> > > +
> > > +Apps using Vulkan should check for ``VK_ERROR_DEVICE_LOST`` for subm=
issions.
> > > +This error code means, among other things, that a device reset has h=
appened and
> > > +it needs to recreate the contexts to keep going.
> > > +
> > > +Reporting causes of resets
> > > +--------------------------
> > > +
> > > +Apart from propagating the reset through the stack so apps can recov=
er, it's
> > > +really useful for driver developers to learn more about what caused =
the reset in
> > > +first place. DRM devices should make use of devcoredump to store rel=
evant
> > > +information about the reset, so this information can be added to use=
r bug
> > > +reports.
> > > +
> > >  .. _drm_driver_ioctl:
> > >
> > >  IOCTL Support on Device Nodes
> > > --
> > > 2.41.0
> > >
> >
>


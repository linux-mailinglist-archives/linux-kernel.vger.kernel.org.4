Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB6D6ED49C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 20:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbjDXSkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 14:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbjDXSkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 14:40:39 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A689E55A6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 11:40:37 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5052caa1e32so8550165a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 11:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682361636; x=1684953636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wzJOzH+7Z8w3/WGFZ7bEKUxGZRSO1RUpCg2aWmbmuJ4=;
        b=Xlsh1dnvxH4Rhmaqp+YZbzeXQYEPyjVZhfnq3CgiAa9mEJt5/4BFI5hUqu8uxIO7Nl
         eoH9JfIcJXRUY69/yYzDNqDJ4UY+pMTy53BnhFVTnZ9n/mI9DhJoYgPSKQ/O1sOHrb5h
         5y8y8UcHYq3X9v4Bne6h/6OvM763JXLP8wcWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682361636; x=1684953636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wzJOzH+7Z8w3/WGFZ7bEKUxGZRSO1RUpCg2aWmbmuJ4=;
        b=dPutWFaiq6nA0jQroIRi7xipi4mwGxq3dDSf9AkeukV8wZE4f74VsWgOBYrJ7if8M5
         KgM6lu1E4NhTb7wy/LShR83lgKhfSXHuLSWWEySRErp16dvwPINLVK8bPhHskG2goK1h
         Z86dg9PZ/iLDxQ7ApyJl4oLZU5cpjT81rL9+tvU/itsGTQZSHcNbj0dOZsCuwFLsu8io
         +U3xsv3yym1sPaAEKvZ/3m64r+juGps3qo+OiqN8rdk9JasoSAQlzE7E4ZSfIM1NRMCS
         JKaBtk+zxOdQ1Fqd4eNb1W9UqM8/Z0sE7O1AK8mLNWsKXM31jEkSkH99Y3uLiKgVpmrb
         duhw==
X-Gm-Message-State: AAQBX9eV47PoOaHbKCiD6J74mC6R1E30wXW/fnquEjh8MD2kpwvQ9dQQ
        qRPw//oMfl/OlRbvNUbQXax2ZJ5ERh41rgPc9E6p3Q==
X-Google-Smtp-Source: AKy350ZYlPYtzFe/mhDCTCp1e3b952qjha8fs0rPwpSZZZ6jQX4KzDxsm02WQfXVu6M600dtMgDx9A==
X-Received: by 2002:aa7:dc08:0:b0:506:77e6:c9e5 with SMTP id b8-20020aa7dc08000000b0050677e6c9e5mr13750577edu.8.1682361635817;
        Mon, 24 Apr 2023 11:40:35 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id q9-20020aa7da89000000b005069175dcb7sm4980778eds.58.2023.04.24.11.40.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 11:40:34 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-4af3773448fso31394a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 11:40:33 -0700 (PDT)
X-Received: by 2002:a05:6402:354f:b0:502:2af:7b1d with SMTP id
 f15-20020a056402354f00b0050202af7b1dmr11568edd.3.1682361633471; Mon, 24 Apr
 2023 11:40:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230416115237.798604-1-dmitry.osipenko@collabora.com>
 <CAAfnVB=5TVKxUmLhNMLMdgAPx7KoSKTsZQtq7Hv36FcP7bmgLA@mail.gmail.com> <6fef7bd4-6d02-6de8-e5f0-0ec8f57321f2@collabora.com>
In-Reply-To: <6fef7bd4-6d02-6de8-e5f0-0ec8f57321f2@collabora.com>
From:   Gurchetan Singh <gurchetansingh@chromium.org>
Date:   Mon, 24 Apr 2023 11:40:21 -0700
X-Gmail-Original-Message-ID: <CAAfnVBkNrWGOqBZa1xUqrVPSz+0BJYgVvVjguXwN8XJ_KWrpKQ@mail.gmail.com>
Message-ID: <CAAfnVBkNrWGOqBZa1xUqrVPSz+0BJYgVvVjguXwN8XJ_KWrpKQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] Add sync object UAPI support to VirtIO-GPU driver
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
        Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
        Emil Velikov <emil.velikov@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org,
        Dominik Behr <dbehr@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 2:22=E2=80=AFPM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> Hello Gurchetan,
>
> On 4/18/23 02:17, Gurchetan Singh wrote:
> > On Sun, Apr 16, 2023 at 4:53=E2=80=AFAM Dmitry Osipenko <
> > dmitry.osipenko@collabora.com> wrote:
> >
> >> We have multiple Vulkan context types that are awaiting for the additi=
on
> >> of the sync object DRM UAPI support to the VirtIO-GPU kernel driver:
> >>
> >>  1. Venus context
> >>  2. Native contexts (virtio-freedreno, virtio-intel, virtio-amdgpu)
> >>
> >> Mesa core supports DRM sync object UAPI, providing Vulkan drivers with=
 a
> >> generic fencing implementation that we want to utilize.
> >>
> >> This patch adds initial sync objects support. It creates fundament for=
 a
> >> further fencing improvements. Later on we will want to extend the
> >> VirtIO-GPU
> >> fencing API with passing fence IDs to host for waiting, it will be a n=
ew
> >> additional VirtIO-GPU IOCTL and more. Today we have several VirtIO-GPU
> >> context
> >> drivers in works that require VirtIO-GPU to support sync objects UAPI.
> >>
> >> The patch is heavily inspired by the sync object UAPI implementation o=
f the
> >> MSM driver.
> >>
> >
> > The changes seem good, but I would recommend getting a full end-to-end
> > solution (i.e, you've proxied the host fence with these changes and sha=
red
> > with the host compositor) working first.  You'll never know what you'll
> > find after completing this exercise.  Or is that the plan already?
> >
> > Typically, you want to land the uAPI and virtio spec changes last.
> > Mesa/gfxstream/virglrenderer/crosvm all have the ability to test out
> > unstable uAPIs ...
>
> The proxied host fence isn't directly related to sync objects, though I
> prepared code such that it could be extended with a proxied fence later
> on, based on a prototype that was made some time ago.

Proxying the host fence is the novel bit.  If you have code that does
this, you should rebase/send that out (even as an RFC) so it's easier
to see how the pieces fit.

Right now, if you've only tested synchronization objects between the
same virtio-gpu context that skips the guest side wait, I think you
can already do that with the current uAPI (since ideally you'd wait on
the host side and can encode the sync resource in the command stream).

Also, try to come with a simple test (so we can meet requirements here
[a]) that showcases the new feature/capability.  An example would be
the virtio-intel native context sharing a fence with KMS or even
Wayland.

[a] https://dri.freedesktop.org/docs/drm/gpu/drm-uapi.html#open-source-user=
space-requirements

>
> The proxied host fence shouldn't require UAPI changes, but only
> virtio-gpu proto extension. Normally, all in-fences belong to a job's
> context, and thus, waits are skipped by the guest kernel. Hence, fence
> proxying is a separate feature from sync objects, it can be added
> without sync objects.
>
> Sync objects primarily wanted by native context drivers because Mesa
> relies on the sync object UAPI presence. It's one of direct blockers for
> Intel and AMDGPU drivers, both of which has been using this sync object
> UAPI for a few months and now wanting it to land upstream.
>
> --
> Best regards,
> Dmitry
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3E36FB214
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 15:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234324AbjEHN7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 09:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233752AbjEHN7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 09:59:14 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306FD33D7C
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 06:59:13 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-18f4a6d2822so31526713fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 06:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683554352; x=1686146352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HKI5hargzKBJ4u7aTkJl99CJ0qfSrzAu9HhTH/5DBYA=;
        b=BQfgfPoucSO9c0iYSjaKh5WEjsLp6hSV70hZxGF9TjAkJY+7/p6Nl+vDhsx9L1ZWWf
         nXRiiqmxG1ptJIeP60CAb/vG1tzQp3aaKCqoA5quhRNYwDaLA+taA/HrpcFDaebaYYLK
         TFx4iwsiU7MqaR2VgjhUizBLHi10ICQLi9yGOUikTGCFsBk4YIAS/VtILBrEUno6W6OU
         +3/p7jTt0njRB6rhvXCRxTKjQ32yVxonaeG+p6HHcRP7Wy4JhWynRY2lwI48IXn2DWxe
         9dvbCYsVbQB5v0B6igzIKSHgzqADtdDCm8FdUfFYlgPVSXwo9b73EID5SU1986f1yMD5
         xjRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683554352; x=1686146352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HKI5hargzKBJ4u7aTkJl99CJ0qfSrzAu9HhTH/5DBYA=;
        b=fmEiU+kpQOkSeB/kKyyS7afC6eXi5K1N00LqDoL2kuuJAznq/mB9iSXW1igo4T23HU
         SFResSyjln7LQH++TkhOQm/qPoy81DmJPpE1SsXOvaik6w85+PYTqrXQLncC1+dtCQuj
         or350ncP5Ln8Jy+0mf1FWA0T8SRVuvQWjkdQ21A0kF7isLUPL7lv/y0+CFAMzcQwOrFw
         RQcLY8IjQ8vwgnnd5JM59+RfWZSXImh9aM2KND2GOcB0sgJlnc3yFDqSePxmnNOe5wNu
         6Ktbb/kscrxushFBZ4HcfJCtuKdef77YgH51xLnjOpo76Hg0FSDjiY/oGLaFg9IwB1bL
         U5Eg==
X-Gm-Message-State: AC+VfDzPkYYp2OkeB5IpyLz/ODlSI34mD3/dg7EFAFNwTe6g01UTa8+7
        p2dg+u2RMKqrsKnfSTBW8Iico+Sh1PCPMhOveRM=
X-Google-Smtp-Source: ACHHUZ50LkNfTNRkSeGJJPoa/BAX/xul353Ik0wlxeRY6hIxnEX5WoLqEnM6SGjMhC3zTb7ICsPNNWeUaMeA3jfGlNY=
X-Received: by 2002:aca:c0c1:0:b0:387:31fd:1782 with SMTP id
 q184-20020acac0c1000000b0038731fd1782mr6592750oif.28.1683554352400; Mon, 08
 May 2023 06:59:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230416115237.798604-1-dmitry.osipenko@collabora.com>
 <141b928d-6165-f282-b8e6-f140cb09333d@collabora.com> <CAAfnVBnrUotph4TYJVu9Bohqv3m80t90V34TNhh-Tspxwsj-ZQ@mail.gmail.com>
In-Reply-To: <CAAfnVBnrUotph4TYJVu9Bohqv3m80t90V34TNhh-Tspxwsj-ZQ@mail.gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Mon, 8 May 2023 06:59:02 -0700
Message-ID: <CAF6AEGs4fuq4i8UJdO5hvgHTNhzFMKGZ87+w1oyvL0LAqWio6A@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] Add sync object UAPI support to VirtIO-GPU driver
To:     Gurchetan Singh <gurchetansingh@chromium.org>
Cc:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org,
        David Airlie <airlied@redhat.com>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
        Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
        Emil Velikov <emil.velikov@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 3, 2023 at 10:07=E2=80=AFAM Gurchetan Singh
<gurchetansingh@chromium.org> wrote:
>
>
>
> On Mon, May 1, 2023 at 8:38=E2=80=AFAM Dmitry Osipenko <dmitry.osipenko@c=
ollabora.com> wrote:
>>
>> On 4/16/23 14:52, Dmitry Osipenko wrote:
>> > We have multiple Vulkan context types that are awaiting for the additi=
on
>> > of the sync object DRM UAPI support to the VirtIO-GPU kernel driver:
>> >
>> >  1. Venus context
>> >  2. Native contexts (virtio-freedreno, virtio-intel, virtio-amdgpu)
>> >
>> > Mesa core supports DRM sync object UAPI, providing Vulkan drivers with=
 a
>> > generic fencing implementation that we want to utilize.
>> >
>> > This patch adds initial sync objects support. It creates fundament for=
 a
>> > further fencing improvements. Later on we will want to extend the Virt=
IO-GPU
>> > fencing API with passing fence IDs to host for waiting, it will be a n=
ew
>> > additional VirtIO-GPU IOCTL and more. Today we have several VirtIO-GPU=
 context
>> > drivers in works that require VirtIO-GPU to support sync objects UAPI.
>> >
>> > The patch is heavily inspired by the sync object UAPI implementation o=
f the
>> > MSM driver.
>>
>> Gerd, do you have any objections to merging this series?
>>
>> We have AMDGPU [1] and Intel [2] native context WIP drivers depending on
>> the sync object support. It is the only part missing from kernel today
>> that is wanted by the native context drivers. Otherwise, there are few
>> other things in Qemu and virglrenderer left to sort out.
>>
>> [1] https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/21658
>> [2] https://gitlab.freedesktop.org/digetx/mesa/-/commits/native-context-=
iris
>
>
> I'm not saying this change isn't good, just it's probably possible to imp=
lement the native contexts (even up to even VK1.2) without it.  But this pa=
tch series may be the most ergonomic way to do it, given how Mesa is design=
ed.  But you probably want one of Mesa MRs reviewed first before merging (I=
 added a comment on the amdgpu change) and that is a requirement [a].
>
> [a] "The userspace side must be fully reviewed and tested to the standard=
s of that user space project. For e.g. mesa this means piglit testcases and=
 review on the mailing list. This is again to ensure that the new interface=
 actually gets the job done." -- from the requirements
>

tbh, the syncobj support is all drm core, the only driver specifics is
the ioctl parsing.  IMHO existing tests and the two existing consumers
are sufficient.  (Also, considering that additional non-drm
dependencies involved.)

If this was for the core drm syncobj implementation, and not just
driver ioctl parsing and wiring up the core helpers, I would agree
with you.

BR,
-R

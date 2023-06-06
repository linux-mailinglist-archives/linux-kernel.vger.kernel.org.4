Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3212723FDB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 12:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237278AbjFFKnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 06:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237261AbjFFKmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 06:42:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95AD0198B
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 03:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686047944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bpv953l+q5fc9HmqRZAoq0E3Wcwa2EnYD8e+xZL0CXA=;
        b=NM5TCxMcY7c2ENeUO31I4lPg7b8MwMDLKcbuRRZtaogdAVyuz8jAfKmrKoXRL3rMCmfvyS
        eEzc/4QAktr15+LcZomMa/Hkc6hNFGt3VPzGC3hIeGzWo9EfAyjdqkIZTIvbQ0dfY1bsCs
        cMNz4wUCj1RnI3a70Vv2UKeqKyP+MXE=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-r051tIpMNg2wLUWaR8k4CA-1; Tue, 06 Jun 2023 06:39:03 -0400
X-MC-Unique: r051tIpMNg2wLUWaR8k4CA-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b1e52292beso2658711fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 03:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686047942; x=1688639942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bpv953l+q5fc9HmqRZAoq0E3Wcwa2EnYD8e+xZL0CXA=;
        b=DunHt3AmqYpd1+39/ldAvsqkNhzyGU2/Hpj+esSBFwVKW/NO+5maDEblfKL2MJhtww
         6fEbWIvhPYYOW1qehxmyCBp36sm6kuvyRmfySM/jUqqQHZ28VmUl2jHiHzxSgrO8ECGn
         K1dPFCBOZVocyUX8voA30FmNv+UzquviiBO7SGbCDM5Oi+7B4D2iaOcQn0uvffFRyeAW
         7UfV9wDopTvj/Ir41bQAnAmqj2lZekE1S70VkQCNiZXtrbGVno4KbYgti/WqNd+El9YV
         9CF4dpbNWJRCVdDyrHUK37hHiLPGoObHXviqCC9lWv0P12d13vJ4fGNGr4+CVjHX69PE
         MIqQ==
X-Gm-Message-State: AC+VfDyr/nwpL+Bgx36Xo1AT5T8Z8N/J9FNVN4OQS+JblN7Q8+iPy2zK
        bUQVus5C4GHpOT7DLAnz6DD5eMOFl+grf3gHJ1YbsgxxinAs/9ol3v6Uveb5S0oXF39Yd/3Zk4f
        4/7nP1voDTjZ8rvhdWL+8RXB5udgmmrkTKU3b9upB
X-Received: by 2002:a05:651c:3c2:b0:2b1:d8fa:3e59 with SMTP id f2-20020a05651c03c200b002b1d8fa3e59mr804612ljp.4.1686047942045;
        Tue, 06 Jun 2023 03:39:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Zn97oPcc9bAEPtfRK6uwJ9A0EpNgvvjiCSHupJDNIoKQNNQXMCMOfbu3Undc2TovwL4NGYatrgXpJavNHMaQ=
X-Received: by 2002:a05:651c:3c2:b0:2b1:d8fa:3e59 with SMTP id
 f2-20020a05651c03c200b002b1d8fa3e59mr804601ljp.4.1686047941701; Tue, 06 Jun
 2023 03:39:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230526091052.2169044-1-kherbst@redhat.com> <CAKb7Uvha74HOvny25aqnwzvvRLpc7+DNQm6QEAk4oxfTa1urJg@mail.gmail.com>
In-Reply-To: <CAKb7Uvha74HOvny25aqnwzvvRLpc7+DNQm6QEAk4oxfTa1urJg@mail.gmail.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Tue, 6 Jun 2023 12:38:50 +0200
Message-ID: <CACO55ts7gJfJ5ver+qvL5Tp9X+Kzk9ByvmXUD1hLH31NR+3pBg@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH v2] drm/nouveau: bring back blit subchannel for
 pre nv50 GPUs
To:     Ilia Mirkin <imirkin@alum.mit.edu>
Cc:     linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 5:21=E2=80=AFPM Ilia Mirkin <imirkin@alum.mit.edu> =
wrote:
>
> On Fri, May 26, 2023 at 5:11=E2=80=AFAM Karol Herbst <kherbst@redhat.com>=
 wrote:
> >
> > 1ba6113a90a0 removed a lot of the kernel GPU channel, but method 0x128
> > was important as otherwise the GPU spams us with `CACHE_ERROR` messages=
.
> >
> > We use the blit subchannel inside our vblank handling, so we should kee=
p
> > at least this part.
> >
> > v2: Only do it for NV11+ GPUs
> >
> > Closes: https://gitlab.freedesktop.org/drm/nouveau/-/issues/201
> > Fixes: 4a16dd9d18a0 ("drm/nouveau/kms: switch to drm fbdev helpers")
> > Signed-off-by: Karol Herbst <kherbst@redhat.com>
> > ---
> >  drivers/gpu/drm/nouveau/nouveau_chan.c |  1 +
> >  drivers/gpu/drm/nouveau/nouveau_chan.h |  1 +
> >  drivers/gpu/drm/nouveau/nouveau_drm.c  | 20 +++++++++++++++++---
> >  3 files changed, 19 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/nouveau/nouveau_chan.c b/drivers/gpu/drm/n=
ouveau/nouveau_chan.c
> > index e648ecd0c1a0..3dfbc374478e 100644
> > --- a/drivers/gpu/drm/nouveau/nouveau_chan.c
> > +++ b/drivers/gpu/drm/nouveau/nouveau_chan.c
> > @@ -90,6 +90,7 @@ nouveau_channel_del(struct nouveau_channel **pchan)
> >                 if (cli)
> >                         nouveau_svmm_part(chan->vmm->svmm, chan->inst);
> >
> > +               nvif_object_dtor(&chan->blit);
> >                 nvif_object_dtor(&chan->nvsw);
> >                 nvif_object_dtor(&chan->gart);
> >                 nvif_object_dtor(&chan->vram);
> > diff --git a/drivers/gpu/drm/nouveau/nouveau_chan.h b/drivers/gpu/drm/n=
ouveau/nouveau_chan.h
> > index e06a8ffed31a..bad7466bd0d5 100644
> > --- a/drivers/gpu/drm/nouveau/nouveau_chan.h
> > +++ b/drivers/gpu/drm/nouveau/nouveau_chan.h
> > @@ -53,6 +53,7 @@ struct nouveau_channel {
> >         u32 user_put;
> >
> >         struct nvif_object user;
> > +       struct nvif_object blit;
> >
> >         struct nvif_event kill;
> >         atomic_t killed;
> > diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/no=
uveau/nouveau_drm.c
> > index cc7c5b4a05fd..9512f1c2f871 100644
> > --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> > +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
> > @@ -369,15 +369,29 @@ nouveau_accel_gr_init(struct nouveau_drm *drm)
> >                 ret =3D nvif_object_ctor(&drm->channel->user, "drmNvsw"=
,
> >                                        NVDRM_NVSW, nouveau_abi16_swclas=
s(drm),
> >                                        NULL, 0, &drm->channel->nvsw);
> > +
> > +               if (ret =3D=3D 0 && device->info.chipset >=3D 0x11) {
>
> Can you double-check that this is needed on NV15? IIRC there's some
> non-linearity of chipsets here which is why we had (some long time
> ago, not sure if it's still there), a chip class which would simplify
> such checks.
>

yeah, it's fine. The old code before 4a16dd9d18a0 had a
"device->info.chipset >=3D 0x11 ? 0x009f : 0x005f" check when creating
the blit object.

> Cheers,
>
>   -ilia
>


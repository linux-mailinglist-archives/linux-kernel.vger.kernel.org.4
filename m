Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99BE36E482B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 14:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbjDQMrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 08:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjDQMrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 08:47:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F27121
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 05:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681735615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hi++eveNlkrj9xbWlpgBiAgo9b9NAN27QrWvfVpf3Hw=;
        b=H8DSD84gEvtcgMbPCyGfzmjEA68q1eBTaHSy93kFKjoc9KqvvVLzkH7UUk9wF9xxU2zJWV
        jNB7s5w5hXFLQqFAFIOoAtXHH4KsWgyA6TdnHv/KLfjfD8sixn5KcnGTcRLxM7zwvJricH
        D6Mw6qNsRn4qciZqZhPRbqdDS0FUk3c=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-1TyBeILeO5CO6vf0-um3Yw-1; Mon, 17 Apr 2023 08:46:54 -0400
X-MC-Unique: 1TyBeILeO5CO6vf0-um3Yw-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4ec8143e34aso506967e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 05:46:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681735613; x=1684327613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hi++eveNlkrj9xbWlpgBiAgo9b9NAN27QrWvfVpf3Hw=;
        b=gRsRb2SLJfqsxptRI5BL+CUBLrZ3v3Wcz8KjXGPP1nnyIRZX0f+1rz9rabqcxsojse
         4q4QiYuVl40jOiU+7l7LiTnlmJqJ7ju/Iv5PLVoelzC3eNpvXJgbOd1jS48zFNhWsB8e
         /SEORX8h9RS/jvHYl0y1AYdPHr4uJR1lkFcxjkysu+18mZ/uXLOyNYuTckd8DQmy6WE+
         SggEN20WOjTU/aWKnfwsMrHRvckxZWXg39KDlHew/TUDe/QHr3PJsZf5OH8QEJ9zmThR
         F08pRebqAIAY6OJVEeaZP/k8i5o+PAxXcQl/uVN43Rx925kIL2E6EKLUh9seHh86/cnN
         9glA==
X-Gm-Message-State: AAQBX9dz7nYdMbcd5nYJZd0LyDo42BB+YJ2M0StuQUD4JSPv21oN9kPS
        +tjcvRFni+Fzg3vqrQdKTqMqIBuqrpu0kVKuvBvV+yl3n28IzuRvV5/I9Wwv1TdX68HbRuyTJT3
        M9iAwaFfWwadf278MJbJas+pJe0Av8vw9+NpIJQDQ
X-Received: by 2002:ac2:5dea:0:b0:4ec:e32f:3d1f with SMTP id z10-20020ac25dea000000b004ece32f3d1fmr2079781lfq.11.1681735612861;
        Mon, 17 Apr 2023 05:46:52 -0700 (PDT)
X-Google-Smtp-Source: AKy350Z7S18KuRxvZ5c/MFkn9CZgVP4JCWx+2zRnkVfsFNFdFSobcj64LGiM2uWx/5LJwcD36vpVs2SkVyqd5KSxyIk=
X-Received: by 2002:ac2:5dea:0:b0:4ec:e32f:3d1f with SMTP id
 z10-20020ac25dea000000b004ece32f3d1fmr2079772lfq.11.1681735612531; Mon, 17
 Apr 2023 05:46:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230415012137.615305-1-john.ogness@linutronix.de>
 <87edolaomt.fsf@jogness.linutronix.de> <7b17a825-0f76-3e0f-5e56-0e689b7d7866@amd.com>
In-Reply-To: <7b17a825-0f76-3e0f-5e56-0e689b7d7866@amd.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Mon, 17 Apr 2023 14:46:40 +0200
Message-ID: <CACO55tsvgOPgpc5Ssm-md_q4-0U6ON-kHzuu+F-RsnZ79ACYrA@mail.gmail.com>
Subject: Re: [PATCH v3] drm/nouveau: fix incorrect conversion to dma_resv_wait_timeout()
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        Tanmay Bhushan <007047221b@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 7:55=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 15.04.23 um 04:02 schrieb John Ogness:
> > Commit 41d351f29528 ("drm/nouveau: stop using ttm_bo_wait")
> > converted from ttm_bo_wait_ctx() to dma_resv_wait_timeout().
> > However, dma_resv_wait_timeout() returns greater than zero on
> > success as opposed to ttm_bo_wait_ctx(). As a result, relocs
> > will fail and log errors even when it was a success.
> >
> > Change the return code handling to match that of
> > nouveau_gem_ioctl_cpu_prep(), which was already using
> > dma_resv_wait_timeout() correctly.
> >
> > Fixes: 41d351f29528 ("drm/nouveau: stop using ttm_bo_wait")
> > Reported-by: Tanmay Bhushan <007047221b@gmail.com>
> > Link: https://lore.kernel.org/lkml/20230119225351.71657-1-007047221b@gm=
ail.com
> > Signed-off-by: John Ogness <john.ogness@linutronix.de>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>

Reviewed-by: Karol Herbst <kherbst@redhat.com>

will push shortly to drm-misc-fixes

> > ---
> >   I just realized that the nouveau driver style prefers to scope
> >   variables used only in loops.
> >
> >   v3: Define @lret within the for-loop.
> >
> >   drivers/gpu/drm/nouveau/nouveau_gem.c | 18 ++++++++++++------
> >   1 file changed, 12 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c b/drivers/gpu/drm/no=
uveau/nouveau_gem.c
> > index f77e44958037..ab9062e50977 100644
> > --- a/drivers/gpu/drm/nouveau/nouveau_gem.c
> > +++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
> > @@ -645,7 +645,7 @@ nouveau_gem_pushbuf_reloc_apply(struct nouveau_cli =
*cli,
> >                               struct drm_nouveau_gem_pushbuf_reloc *rel=
oc,
> >                               struct drm_nouveau_gem_pushbuf_bo *bo)
> >   {
> > -     long ret =3D 0;
> > +     int ret =3D 0;
> >       unsigned i;
> >
> >       for (i =3D 0; i < req->nr_relocs; i++) {
> > @@ -653,6 +653,7 @@ nouveau_gem_pushbuf_reloc_apply(struct nouveau_cli =
*cli,
> >               struct drm_nouveau_gem_pushbuf_bo *b;
> >               struct nouveau_bo *nvbo;
> >               uint32_t data;
> > +             long lret;
> >
> >               if (unlikely(r->bo_index >=3D req->nr_buffers)) {
> >                       NV_PRINTK(err, cli, "reloc bo index invalid\n");
> > @@ -703,13 +704,18 @@ nouveau_gem_pushbuf_reloc_apply(struct nouveau_cl=
i *cli,
> >                               data |=3D r->vor;
> >               }
> >
> > -             ret =3D dma_resv_wait_timeout(nvbo->bo.base.resv,
> > -                                         DMA_RESV_USAGE_BOOKKEEP,
> > -                                         false, 15 * HZ);
> > -             if (ret =3D=3D 0)
> > +             lret =3D dma_resv_wait_timeout(nvbo->bo.base.resv,
> > +                                          DMA_RESV_USAGE_BOOKKEEP,
> > +                                          false, 15 * HZ);
> > +             if (!lret)
> >                       ret =3D -EBUSY;
> > +             else if (lret > 0)
> > +                     ret =3D 0;
> > +             else
> > +                     ret =3D lret;
> > +
> >               if (ret) {
> > -                     NV_PRINTK(err, cli, "reloc wait_idle failed: %ld\=
n",
> > +                     NV_PRINTK(err, cli, "reloc wait_idle failed: %d\n=
",
> >                                 ret);
> >                       break;
> >               }
> >
> > base-commit: 09a9639e56c01c7a00d6c0ca63f4c7c41abe075d
>


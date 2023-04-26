Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58EEC6EFDB3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 00:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240440AbjDZW47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 18:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbjDZW44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 18:56:56 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F751FCA;
        Wed, 26 Apr 2023 15:56:55 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9594916df23so132036666b.1;
        Wed, 26 Apr 2023 15:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682549814; x=1685141814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBhzFCZdf4Jbh75KGo5B89HqNoWDSV7R2Pmerxt+rW4=;
        b=LpFODiDkSIVixvf9ouvk5M5aDm3WcymrtGE3vm8471N4AcSI9tm1U5ZXWuCPGfW6BY
         qUUC0mHcFet7NxnuEq5UkQFyhgS1S9hahB0X3eo9H7i7FW2j3SIACVCqD0HqnboYZO7E
         zVV4g4oI4ze94vW/qf1jppK3Yn3JcRbC2ijNHaSuuhNFDzwUDbjhF/hd47xdI5v24Dm3
         dmrsytRYsC4y9m3bWzQ28vPnI5V8kN1hZIUV25g9dZTE1+aicbpm0GhbhZdCarg6D/ZI
         MO9LxSUs3zpN/rDqyedRbaYx8UdnDxwz3cDTm4tJjTK4xmAOE13wSHDRNKgCRvSPNWKv
         Be4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682549814; x=1685141814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pBhzFCZdf4Jbh75KGo5B89HqNoWDSV7R2Pmerxt+rW4=;
        b=Jzm7DmPoo2WfsVzOfEemA790BhOa11z733Pc5+lcDsoihBDaUijIyYLiaTHnXiPtSX
         IGCL/Ve+ft1GZqRI4EP4AF1+Fd9Wzo+kSFWEWW0mRDKF2X4ZQ6FEz6lobRpZ8lEyuKqX
         t2D6e7yL3yj5DSVxMxq0zBCjG8PPUD6IsbGu3A3/WObfrmQGGrIGEgr6F3qdODKmE+mM
         8zJjsiRxILI0JgAsLDDIgxfShBgPyXZXzSw+DRT2h1i+lCWtYP6W7trOf12LnmiNVcdI
         HCa5KAebbrsjH5DuuQI5njcihCIyEhN7e6c2p2rgimxK0l+ob1PfrD/rLCEcK8l9ypSN
         0xAQ==
X-Gm-Message-State: AC+VfDx4gjnh3sGK0JbmB5SWPIAzVcgAN2wdjuGZJzHvF7f0CQHe9k1K
        h3pkCK1xsLqZuigCecR4Fm47Mk4iBr/EaOveZPzahnoS
X-Google-Smtp-Source: ACHHUZ4xqgwrReuBkZDAs5+0gPDVQxHaweWWSJ7AxZ4/23kxSn87zsupxtl5omjyhVUXgXjTCaWuePzfE3NXB0sR7kI=
X-Received: by 2002:a17:906:51d4:b0:92f:27c2:13c0 with SMTP id
 v20-20020a17090651d400b0092f27c213c0mr281218ejk.6.1682549813740; Wed, 26 Apr
 2023 15:56:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230426061718.755586-1-olvaffe@gmail.com> <f889f994-d2cd-fedc-8c95-9c8501037809@amd.com>
In-Reply-To: <f889f994-d2cd-fedc-8c95-9c8501037809@amd.com>
From:   Chia-I Wu <olvaffe@gmail.com>
Date:   Wed, 26 Apr 2023 15:56:42 -0700
Message-ID: <CAPaKu7SNWERgdeg7uvSFfJV_PSndbPwy1VCjEyLk3bkXCepq-g@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: add a missing lock for AMDGPU_SCHED
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
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

On Wed, Apr 26, 2023 at 4:05=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 26.04.23 um 08:17 schrieb Chia-I Wu:
> > mgr->ctx_handles should be protected by mgr->lock.
> >
> > v2: improve commit message
> >
> > Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
> > Cc: stable@vger.kernel.org
>
> Please don't manually CC stable@vger.kernel.org while sending patches
> out, let us maintainers push that upstream with the appropriate tag and
> Greg picking it up from there.
>
> A Fixes tag and figuring out to which stable versions this needs to be
> backported are nice to have as well, but Alex and I can take care of
> that as well.
>
> Apart from that the technical side of the patch is Reviewed-by:
> Christian K=C3=B6nig <christian.koenig@amd.com>.
All done.  Thanks for clarifying the process and sorry for getting it
wrong in the first place :(
>
> Regards,
> Christian.
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c | 6 +++++-
> >   1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_sched.c
> > index e9b45089a28a6..863b2a34b2d64 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
> > @@ -38,6 +38,7 @@ static int amdgpu_sched_process_priority_override(str=
uct amdgpu_device *adev,
> >   {
> >       struct fd f =3D fdget(fd);
> >       struct amdgpu_fpriv *fpriv;
> > +     struct amdgpu_ctx_mgr *mgr;
> >       struct amdgpu_ctx *ctx;
> >       uint32_t id;
> >       int r;
> > @@ -51,8 +52,11 @@ static int amdgpu_sched_process_priority_override(st=
ruct amdgpu_device *adev,
> >               return r;
> >       }
> >
> > -     idr_for_each_entry(&fpriv->ctx_mgr.ctx_handles, ctx, id)
> > +     mgr =3D &fpriv->ctx_mgr;
> > +     mutex_lock(&mgr->lock);
> > +     idr_for_each_entry(&mgr->ctx_handles, ctx, id)
> >               amdgpu_ctx_priority_override(ctx, priority);
> > +     mutex_unlock(&mgr->lock);
> >
> >       fdput(f);
> >       return 0;
>

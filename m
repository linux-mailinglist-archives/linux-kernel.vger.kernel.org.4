Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952A76ED0E2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 17:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjDXPBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 11:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbjDXPBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 11:01:48 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01C61B3;
        Mon, 24 Apr 2023 08:01:47 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-541b5cfa9d8so2774223eaf.0;
        Mon, 24 Apr 2023 08:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682348507; x=1684940507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FmLuhgTYqL7Xf1ZepLBDAcM7hZYQ8z1fOMJDQ+E6+Q0=;
        b=mYAIPmZK2HzigLPQnMKqFBzHiCRJzh7PWtt5JMNeP8zkDk0iStFDPcONj7vM6KhEyL
         HCyZZsMG2eE8JfrqiYm+J9IhyJWUR7aXjTnN4HZ810PynVIwAcAFrd6lhQOd9YiKku9E
         GB6WUNx7pr5xOZv5DRXezmkCvghwLh3A2aCQ8cM/rF/b8mWPyuASArcorF3r5Nb9jTmQ
         YS9bijCxrJ0HHv2FslnHzofstv7Oa7DbKr1fqrQ14huqZss3Es3iID0hjCuS+qjBonvK
         NkfPV7rH+J+RdlGt4GuFfPnK5JwHQSEPbsW72audoadCmG6thCBjQ03Zk+IwC9oKZhWL
         UzyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682348507; x=1684940507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FmLuhgTYqL7Xf1ZepLBDAcM7hZYQ8z1fOMJDQ+E6+Q0=;
        b=I8Kj791QqgTsI0v6lBSHVARf/8YhhnmUv+oJhMdstDFElqaR71xF6Rk8riM/Kgltyh
         VuD5PvyM9rccdGFYDAnWXTo6gl+WzA6M4vk2+SO/CzNe874r6df8ljy+dCdtseXPCF6w
         skPrsplx1quBwyta90emdq3iLI9VY0K7IdGUsad0eYfJihUI297FS0DfFAaBv/dEXde9
         Ej4O6EvVA50k0nLbd7PRhgUNAH28nUyKPPxEOJ/LnTJyMCMOJYBVn9C9GYYBva25JPON
         m5V1gDi30UbmI3W655zuF+x2OkJGulEtSEP2hMP0mV2OjuZHPDntewjnqBFieYk05wj6
         Vb7A==
X-Gm-Message-State: AAQBX9cIBHeH6ConLoFLBESL2LV09zwfZLGyFrZ+njv3nTL9U+bj/llz
        dcUBHu/sLp2IpVzVhE9NHsmXhONEtFnKbDKcBcs=
X-Google-Smtp-Source: AKy350bvySqFfk+PN5/1/SUO2+TYGz4oCIBT7UtP95XTbp0gi4oyh+p1bcsbgrNCQzfiJIm7L2v9LQ1nM5oR6v7S8qo=
X-Received: by 2002:a4a:a3c3:0:b0:547:7574:b89a with SMTP id
 t3-20020a4aa3c3000000b005477574b89amr3806308ool.1.1682348507067; Mon, 24 Apr
 2023 08:01:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230424055910.15683-1-sukrut.bellary@linux.com> <ecc972c1-cf7d-cd99-805b-38dbf04adc79@amd.com>
In-Reply-To: <ecc972c1-cf7d-cd99-805b-38dbf04adc79@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 24 Apr 2023 11:01:35 -0400
Message-ID: <CADnq5_OmRnsKkCE2OVcp-6kYww92-DKybg0=hM1tO-GaUAGLEw@mail.gmail.com>
Subject: Re: [PATCH] drm:amd:amdgpu: Fix missing bo unlock in failure path
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Sukrut Bellary <sukrut.bellary@linux.com>, daniel@ffwll.ch,
        airlied@gmail.com, sumit.semwal@linaro.org, Hawking.Zhang@amd.com,
        Julia.Lawall@inria.fr, dri-devel@lists.freedesktop.org,
        Xinhui.Pan@amd.com, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        alexander.deucher@amd.com, linux-media@vger.kernel.org
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

On Mon, Apr 24, 2023 at 3:07=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 24.04.23 um 07:59 schrieb Sukrut Bellary:
> > smatch warning - inconsistent handling of buffer object reserve
> > and unreserve.
> >
> > Signed-off-by: Sukrut Bellary <sukrut.bellary@linux.com>
>
> For now that patch is Reviewed-by: Christian K=C3=B6nig
> <christian.koenig@amd.com>.

Applied.  Thanks.

>
> But for the record mapping/unmapping the MQD like this is a very bad
> idea in the first place.
>
> We could need to shuffle memory around for that during resume and that
> is not something we really want to do.

We should probably just keep the MQDs mapped.  On suspend we need to
save out the MQD state so it can be restored on resume when the MQDs
are in vram.

Alex

>
> Christian.
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v8_0.c
> > index 278416acf060..5de44d7e92de 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> > @@ -4686,8 +4686,10 @@ static int gfx_v8_0_kiq_resume(struct amdgpu_dev=
ice *adev)
> >               return r;
> >
> >       r =3D amdgpu_bo_kmap(ring->mqd_obj, &ring->mqd_ptr);
> > -     if (unlikely(r !=3D 0))
> > +     if (unlikely(r !=3D 0)) {
> > +             amdgpu_bo_unreserve(ring->mqd_obj);
> >               return r;
> > +     }
> >
> >       gfx_v8_0_kiq_init_queue(ring);
> >       amdgpu_bo_kunmap(ring->mqd_obj);
>

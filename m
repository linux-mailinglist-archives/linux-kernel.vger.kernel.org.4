Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9BD2722AE8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbjFEPWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234824AbjFEPWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:22:17 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15F01A8;
        Mon,  5 Jun 2023 08:22:09 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3942c6584f0so3388228b6e.3;
        Mon, 05 Jun 2023 08:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685978529; x=1688570529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ownFhAOJ49PkdCY/ElX6rAxTLNeHPzeq4mznvKgyoCM=;
        b=PmI2vPsng+rdUr3wY1rs4RCuBu6dzmI7/2gJjL9H+RgWI+JJhWKnCseHxLxsGLSYt+
         VI5l2Oyo3052z/uTfpJi3wPv674gduL/0ctQmP1cnvXkIneLoi/k8xqBkCH6+wQ1p/nh
         2z/9JOBkiVHtKHskN+Ph40moVJhs+PEWR5AOhRNN7VV5UkCHv1bxRqjJ9D036msS6Ji/
         evOHJ8N/U1op0XQt6YMHnorGrSSOWBNwZD12hH8JnyJFowUh3ed77YHLxHoDWDaZlXgF
         a1K5icKxJjEptcjjelAProwntmsYZ4Eym7hd+BC4GHy5U4gwuNLv91PyMFtkpCGjL9Ij
         4bGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685978529; x=1688570529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ownFhAOJ49PkdCY/ElX6rAxTLNeHPzeq4mznvKgyoCM=;
        b=Hr4DumO9jKqEjWLh9iGrYdxcd+kBIhTZvO+PtesecVYvOfVyBPLnAOW+nCGQrC+til
         O6+di0XCYm12p6nvtnyXq3u9/ot+w7T88DYeAxszimJIDn2wv6hDmhsXdYzi/qKkaIZP
         j7IQhbfzvDSTm3VXbU4NB3z6WG7LMSAjabFY6ljFoejWceEGM7Voii+gy/R8DkyHmSdg
         jXHfp+xiZZl4W//Q4TXgairqTKPhHgUJ/CvRewXhrChE5OtY1DX7h4w3hjGQzag/CaIo
         QIc6LEh7lYP2FHi2XquUPCXHouSRM8i+N3qrv9szffvZDsm3zcofS70V88D8xhLyWf4b
         y7Bg==
X-Gm-Message-State: AC+VfDx+7qdJCzZHjIcV14PwYS09jBESMzAbOUxlFv4MwvOg9MgzLpZW
        q7ZWUFE64Wb7vKVfv0t/yQQvdMXmhiwAzjae8+8=
X-Google-Smtp-Source: ACHHUZ6UGZNvBqYMQ3/CqE2fGvsTmTRJM2EW2RZ/4t9luyD1O0fKQABDsXBaz/nEdC+C/lqa8j6+9PDMqZEFFXOnXHE=
X-Received: by 2002:a54:4598:0:b0:39a:bc50:db96 with SMTP id
 z24-20020a544598000000b0039abc50db96mr2647242oib.41.1685978529045; Mon, 05
 Jun 2023 08:22:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230603074345.17907-1-lm0963hack@gmail.com> <e337dec6-0b0e-7e53-e38d-ae1791b98418@amd.com>
In-Reply-To: <e337dec6-0b0e-7e53-e38d-ae1791b98418@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 5 Jun 2023 11:21:58 -0400
Message-ID: <CADnq5_N=enSchma5R7d8q9t8SkJ_Z7oFxDFHp3a+ypqenO=DYA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/radeon: fix race condition UAF in radeon_gem_set_domain_ioctl
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Min Li <lm0963hack@gmail.com>, alexander.deucher@amd.com,
        Xinhui.Pan@amd.com, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        dri-devel@lists.freedesktop.org, sumit.semwal@linaro.org,
        linux-media@vger.kernel.org
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

Applied.  Thanks!

On Mon, Jun 5, 2023 at 4:13=E2=80=AFAM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
>
> Am 03.06.23 um 09:43 schrieb Min Li:
> > Userspace can race to free the gobj(robj converted from), robj should n=
ot
> > be accessed again after drm_gem_object_put, otherwith it will result in
> > use-after-free.
> >
> > Signed-off-by: Min Li <lm0963hack@gmail.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> > Changes in v2:
> > - Remove unused robj, avoid compile complain
> >
> >   drivers/gpu/drm/radeon/radeon_gem.c | 4 +---
> >   1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/rade=
on/radeon_gem.c
> > index bdc5af23f005..d3f5ddbc1704 100644
> > --- a/drivers/gpu/drm/radeon/radeon_gem.c
> > +++ b/drivers/gpu/drm/radeon/radeon_gem.c
> > @@ -459,7 +459,6 @@ int radeon_gem_set_domain_ioctl(struct drm_device *=
dev, void *data,
> >       struct radeon_device *rdev =3D dev->dev_private;
> >       struct drm_radeon_gem_set_domain *args =3D data;
> >       struct drm_gem_object *gobj;
> > -     struct radeon_bo *robj;
> >       int r;
> >
> >       /* for now if someone requests domain CPU -
> > @@ -472,13 +471,12 @@ int radeon_gem_set_domain_ioctl(struct drm_device=
 *dev, void *data,
> >               up_read(&rdev->exclusive_lock);
> >               return -ENOENT;
> >       }
> > -     robj =3D gem_to_radeon_bo(gobj);
> >
> >       r =3D radeon_gem_set_domain(gobj, args->read_domains, args->write=
_domain);
> >
> >       drm_gem_object_put(gobj);
> >       up_read(&rdev->exclusive_lock);
> > -     r =3D radeon_gem_handle_lockup(robj->rdev, r);
> > +     r =3D radeon_gem_handle_lockup(rdev, r);
> >       return r;
> >   }
> >
>

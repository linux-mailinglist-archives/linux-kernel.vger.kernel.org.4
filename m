Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A486F1991
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 15:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346295AbjD1Nbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 09:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346198AbjD1Nbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 09:31:46 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29D93A9D;
        Fri, 28 Apr 2023 06:31:44 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-187fc21f6acso3773040fac.2;
        Fri, 28 Apr 2023 06:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682688704; x=1685280704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjkfMeDN5MElQoz8pTsP+XGTEHdi6FRFZYxvJHVi3ac=;
        b=FDeDMqBwExbEym6j6TOk37nY9oI4HncB9PyjAK3xsu85s//1YumEwNM6XHMpBiJaTl
         LIcOQoKJF3duQpQ4fi3MUuNe95JzAdbMC+jaDaenqC9vQQ1PkPeCQDxUORlr4jph7+mF
         aeh4W4qQGGJCNLbzlh8+cRDwOptfjIM4q4M1u5OCET/NL/eBuHsz2HgpROszr0KEGVox
         XSGj4sSLwyz5aSOVxxH6xSfd0oTKHk67mW+/DdbNEIUn2vRkkBoWq+38UrBLH0AHIwhl
         qxH1tfTR+iPiFkm6BnPOWuyjX76DWygTZTpasvFWXmgnhAxOU2daWz5NAHvLmcPA197T
         7mYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682688704; x=1685280704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kjkfMeDN5MElQoz8pTsP+XGTEHdi6FRFZYxvJHVi3ac=;
        b=FIsp3IAgXUNT7YzTr8zbyHHZ5gapV63+XoqvtKQuvWSTo3VVacFtUchfDCOgRfVr/A
         a+9Zb/iXf0FJiQstawi7vs5pZbcGv2o6DlHrKcC02ZrNfGYBmNN9qPDgolxll6dOcqZ1
         Yh7QeZWkSlOLRjFCC/lt0Wa7qy4gkb7KFCe1zdlR48fX31EkJTdNao+SHUEvRdkFgcO8
         ICxOVaLqijyIya4tlxWj92FDhNHAYg6zXjhTkZ0XgG39O+40Eaq0UI76U12iTOnM9waf
         GsXerFeFDRUvCYicCPcUx8qDf5GxerjwxRUE6mLQ7Ds4pBNbe+D60bgITQglv2HtlX6K
         nq4g==
X-Gm-Message-State: AC+VfDwHNkN6KCiJPaO3eZNsPnCFz0oH1uJEx/JLfxGAO8DVSuUeaHII
        3xhEV5QVb7ECi1HJx5vxfJBGQsr+J+xW+LuK4DI=
X-Google-Smtp-Source: ACHHUZ7yvFYc1g1/6ZrWu+yC981EbH+g9hDzh8IJ1jVWuHgi19JnIS7N2v3hh/Wbl3/EX2jYloKqk69fVlW/msgtfZM=
X-Received: by 2002:a05:6870:51d5:b0:18e:ae84:7d87 with SMTP id
 b21-20020a05687051d500b0018eae847d87mr2369255oaj.53.1682688704128; Fri, 28
 Apr 2023 06:31:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230419122233.3440-1-hackyzh002@gmail.com> <CAF6NKda1Jy_wfxaVqWt-o75f1BO-o4JXHY9HS9_JtJ2FHztMmQ@mail.gmail.com>
 <CADnq5_MfynMAPU8c-Lq1X_dcDOdRpjW6i=m-Qo8zsZZ=dO-62w@mail.gmail.com> <CAF6NKdaxK_ZRkKRyWtm9Cj-8fNE9RptW3FjW-V39rmaHaCGHTw@mail.gmail.com>
In-Reply-To: <CAF6NKdaxK_ZRkKRyWtm9Cj-8fNE9RptW3FjW-V39rmaHaCGHTw@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 28 Apr 2023 09:31:33 -0400
Message-ID: <CADnq5_MrRC-htfEn3TbR7pbs4rRZJL=zW-3swuc8VZQyHW0DXw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] drm/amdgpu: Fix integer overflow in amdgpu_cs_pass1
To:     whitehat002 whitehat002 <hackyzh002@gmail.com>
Cc:     alexander.deucher@amd.com, Xinhui.Pan@amd.com,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        sumit.semwal@linaro.org, linaro-mm-sig@lists.linaro.org,
        dri-devel@lists.freedesktop.org, daniel@ffwll.ch,
        airlied@gmail.com, christian.koenig@amd.com,
        linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

these?
https://patchwork.freedesktop.org/series/116699/
https://patchwork.freedesktop.org/series/116695/

On Thu, Apr 27, 2023 at 8:45=E2=80=AFPM whitehat002 whitehat002
<hackyzh002@gmail.com> wrote:
>
> Alex,I have a question, why I don't see it on the
> https://patchwork.freedesktop.org/
>
> Alex Deucher <alexdeucher@gmail.com> =E4=BA=8E2023=E5=B9=B44=E6=9C=8827=
=E6=97=A5=E5=91=A8=E5=9B=9B 20:40=E5=86=99=E9=81=93=EF=BC=9A
> >
> > As per my prior reply, it has been applied.
> >
> > Thanks,
> >
> > Alex
> >
> > On Thu, Apr 27, 2023 at 8:39=E2=80=AFAM whitehat002 whitehat002
> > <hackyzh002@gmail.com> wrote:
> > >
> > > hello
> > > What is the current status of this patch, has it been applied?
> > >
> > >
> > > hackyzh002 <hackyzh002@gmail.com> =E4=BA=8E2023=E5=B9=B44=E6=9C=8819=
=E6=97=A5=E5=91=A8=E4=B8=89 20:23=E5=86=99=E9=81=93=EF=BC=9A
> > > >
> > > > The type of size is unsigned int, if size is 0x40000000, there will
> > > > be an integer overflow, size will be zero after size *=3D sizeof(ui=
nt32_t),
> > > > will cause uninitialized memory to be referenced later.
> > > >
> > > > Signed-off-by: hackyzh002 <hackyzh002@gmail.com>
> > > > ---
> > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_cs.c
> > > > index 08eced097..89bcacc65 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > > > @@ -192,7 +192,7 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_par=
ser *p,
> > > >         uint64_t *chunk_array_user;
> > > >         uint64_t *chunk_array;
> > > >         uint32_t uf_offset =3D 0;
> > > > -       unsigned int size;
> > > > +       size_t size;
> > > >         int ret;
> > > >         int i;
> > > >
> > > > --
> > > > 2.34.1
> > > >

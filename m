Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB07702F51
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 16:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239000AbjEOOLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 10:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjEOOLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 10:11:52 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D03172B;
        Mon, 15 May 2023 07:11:51 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1929818d7faso72026349fac.0;
        Mon, 15 May 2023 07:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684159910; x=1686751910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p6klH7lGRee9p3zL+y3yYDz1Mo74eQ/ZGlGDY1d4SJ8=;
        b=sCHYWoEl/r7hKZSDGDmLfCPpPd7E47QEYW3x8MbOxPeCRhv1CV+HlAaIrfm1LcFcLH
         XEbFz9jw+weu9mFwgrF+7KTA2I4/fV7DYR1jKTSmDCBtwZWWhvAHBwMlVqLNtkiEAffk
         jepHKnu4dhzHZOORfj5zJV/j3IA72JK6Jpwozinq7FL4e0q5Hn3KSeOcBNIoheUf41VD
         M7DJDEcSdn/2wS2Dab0jeAE3qPrZj75rtBob/Ck3LJEd0O3nxnoWvfclX1rCrapByNYw
         pohWHW4WLREO3T/Wn1gGrkoAuDeQw7j33xikmKUewSXLJYM0HVJXo6ZscgG4/OtP5VQB
         wTeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684159910; x=1686751910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p6klH7lGRee9p3zL+y3yYDz1Mo74eQ/ZGlGDY1d4SJ8=;
        b=TfCDaczkdyKEo2NVhjEjM97P9W67VnJYqrB56TBT82ONIt5q5BKQHzFlQcY18f29AC
         KukGYSjBkUdKc2rtusGx0c16wqUvNtf7i199NHQeBaPY5JSArtSVlriSwndXhYO+E/v7
         v30onRRhnLO/G7OMZ8dlXaegQe4cOdc8nY2j6rrBwMMt1uPwAeJ6hLAumocyDA9ULLY2
         9qGiMCiTm51e82KNYg5s3PyWVnwGBOBxItPN6vKxWts+TPWb16ZQnCruJ9MJYKhqWvR6
         VL323ggMlM6TdA19TejkqGn82IYnDFpXOAzqRPFdGA7bfTRNbxja8XSb03yKg/wM2VQ6
         PVFw==
X-Gm-Message-State: AC+VfDwooT0tnLkzDWCrvj2wFdTDTjgblI0A7WWkwdgyjx68TotXIRtH
        HSX1tSk12sOaY9TUQ9+9kAz//wHkdmw4HoUSyic=
X-Google-Smtp-Source: ACHHUZ6hswmGitPnovNcuyXvStM5qdj58yGJkZIf508UaOF0AdET+AUn58DT7NbbSC+sp4hSvEY04p3ZxsueM7TOyMg=
X-Received: by 2002:a05:6870:e6d5:b0:18e:3e05:51e6 with SMTP id
 s21-20020a056870e6d500b0018e3e0551e6mr17667911oak.24.1684159910535; Mon, 15
 May 2023 07:11:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230515013428.38798-1-suhui@nfschina.com> <ebe9d98c-148d-4694-8f97-96bacd0b9f7d@kili.mountain>
In-Reply-To: <ebe9d98c-148d-4694-8f97-96bacd0b9f7d@kili.mountain>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 15 May 2023 10:11:39 -0400
Message-ID: <CADnq5_Nei-XHsD8DQkpUGZwZAik5X-S1R3znOJGD1X2jAxD6_g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: remove unnecessary (void*) conversions
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Su Hui <suhui@nfschina.com>, Xinhui.Pan@amd.com,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        christian.koenig@amd.com
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

On Mon, May 15, 2023 at 3:17=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> On Mon, May 15, 2023 at 09:34:28AM +0800, Su Hui wrote:
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_debugfs.c
> > index f60753f97ac5..c837e0bf2cfc 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > @@ -1470,7 +1470,7 @@ int amdgpu_debugfs_regs_init(struct amdgpu_device=
 *adev)
> >
> >  static int amdgpu_debugfs_test_ib_show(struct seq_file *m, void *unuse=
d)
> >  {
> > -     struct amdgpu_device *adev =3D (struct amdgpu_device *)m->private=
;
> > +     struct amdgpu_device *adev =3D m->private;
> >       struct drm_device *dev =3D adev_to_drm(adev);
> >       int r =3D 0, i;
> >
>
> This declaration block was originally written in reverse Christmas tree
> order:
>
>         long long long variable name;
>         medium length name;
>         short name;
>
> So you probably want to change the order now that the lengths have
> changed.  Same in the other places as well.

I don't think it's possible due to the variable dependencies unless
you separate the declarations and assignments which doesn't seem like
a net win to me.

Alex

>
> regards,
> dan carpenter
>

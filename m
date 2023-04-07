Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C656DB2C5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 20:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjDGSaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 14:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjDGSaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 14:30:08 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37595AD38
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 11:30:07 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-62b0a03138fso250997b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 11:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680892206; x=1683484206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6HFtEQBBSrqrPLBtxkiSj0n1tTAIZHxJ4QeL5qxREtA=;
        b=O1wwHa9VLQNTHqqJ/D+SH5M1jhXYC4VHWJ3i1l2T8RfxHmu1tlSsZjw6xpCFpC/sE5
         2OmAe9WoxEaCC9T6IXmDpBliDHN2t0iizQAbdFWvizz9Rnw2XjrlljslXIkmXDCSXTcG
         Q+ZW0ZQnNgmHUpUmt3jpBZnoLqKfKzfmwiccwXsFzQaS2tuROvBmdFXhUCHdAr6HqQTE
         7Yd/82l3J9kPU8xJQp0EYOi94CrJH1itSa+lU8FuIIfjTU7db4H63Wmr4QTCtAKOhviu
         xt7UCiyU7+nzOuYmgLyqJApOlL3e7l+3d5zqjwteUcj0RsrVKH7GJOp3gBJmrf1EOkJ/
         kqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680892207; x=1683484207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6HFtEQBBSrqrPLBtxkiSj0n1tTAIZHxJ4QeL5qxREtA=;
        b=6VOVMpuoUPSY5SvVomwcaNGDpglJ6tKP//I9dA8cwYBShCVhjzs3mINjvjE9MvaBgk
         JCzyCzRdmgUXckM3LBZNuPiAp8OnuyI15IYzeOXJgCThWlQk2E5c/4zlXVXEpls5GK7K
         gu1C2bFQtdsWWWBBiap6Let80Tk2bPlqnq137UVOcv0oDgZ6m7ZNueYYTpArt2Tsg7wF
         zV387iVn5iUE19Wwf5huLmB6fGXdzrbUgAfHiZd7UHz7AQYiOMwxWUjKmjmS8nC+zQUk
         yE37+8mBURzB3riBH9CHn8U1Q74fb4hs2m8UcKSoHYi8GKM6RpEk5+bKMCTtKSnL04W7
         uLlg==
X-Gm-Message-State: AAQBX9ca4RvQKPpbu51kxZVSP9ffADxH+CrVIaWQQET1oxLRC4eiqdIa
        XXXV043+2jQMF150z/GbOmhlbe5sATlmHOQtHxDvYw==
X-Google-Smtp-Source: AKy350Zn9nhE87iZkJPFl7414s8bVyJul5VukIyzyCsiFEtRHapVK5V9N1ZeYdKb2AlkJUj1xE94rcNxMRPPdz4DjIU=
X-Received: by 2002:a05:6a00:2e23:b0:62a:d87a:a375 with SMTP id
 fc35-20020a056a002e2300b0062ad87aa375mr1663621pfb.4.1680892206429; Fri, 07
 Apr 2023 11:30:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230325134503.1335510-1-trix@redhat.com> <CAKwvOdng_wH8qKnnGN=VpUhLK9q6wyc7sZKO7ORt-3QOKVP_nw@mail.gmail.com>
In-Reply-To: <CAKwvOdng_wH8qKnnGN=VpUhLK9q6wyc7sZKO7ORt-3QOKVP_nw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 7 Apr 2023 11:29:55 -0700
Message-ID: <CAKwvOd=CVq3DTPwUgDgghJBKsUKgL69K7Hne5=gY9V7vwshfAg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: remove unused matching_stream_ptrs variable
To:     Tom Rix <trix@redhat.com>
Cc:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, nathan@kernel.org, Jun.Lei@amd.com,
        wenjing.liu@amd.com, Jimmy.Kizito@amd.com, Cruise.Hung@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 7, 2023 at 10:52=E2=80=AFAM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Jimmy, can you review?
>
> The change LGTM; but I'm not sure if there was something else intended he=
re.

Nevermind, Jimmy's email address bounced.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> On Sat, Mar 25, 2023 at 6:45=E2=80=AFAM Tom Rix <trix@redhat.com> wrote:
> >
> > clang with W=3D1 reports
> > drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_enc_cfg.c:625:6: =
error:
> >   variable 'matching_stream_ptrs' set but not used [-Werror,-Wunused-bu=
t-set-variable]
> >         int matching_stream_ptrs =3D 0;
> >             ^
> > This variable is not used so remove it.
> >
> > Signed-off-by: Tom Rix <trix@redhat.com>
> > ---
> >  drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c b/dr=
ivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
> > index 41198c729d90..30c0644d4418 100644
> > --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
> > +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
> > @@ -622,7 +622,6 @@ bool link_enc_cfg_validate(struct dc *dc, struct dc=
_state *state)
> >         int i, j;
> >         uint8_t valid_count =3D 0;
> >         uint8_t dig_stream_count =3D 0;
> > -       int matching_stream_ptrs =3D 0;
> >         int eng_ids_per_ep_id[MAX_PIPES] =3D {0};
> >         int ep_ids_per_eng_id[MAX_PIPES] =3D {0};
> >         int valid_bitmap =3D 0;
> > @@ -645,9 +644,7 @@ bool link_enc_cfg_validate(struct dc *dc, struct dc=
_state *state)
> >                 struct link_enc_assignment assignment =3D state->res_ct=
x.link_enc_cfg_ctx.link_enc_assignments[i];
> >
> >                 if (assignment.valid) {
> > -                       if (assignment.stream =3D=3D state->streams[i])
> > -                               matching_stream_ptrs++;
> > -                       else
> > +                       if (assignment.stream !=3D state->streams[i])
> >                                 valid_stream_ptrs =3D false;
> >                 }
> >         }
> > --
> > 2.27.0
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



--=20
Thanks,
~Nick Desaulniers

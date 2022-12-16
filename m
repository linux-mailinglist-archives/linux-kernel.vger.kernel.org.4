Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B3864F0E6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 19:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiLPSYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 13:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbiLPSYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 13:24:16 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E24453EF8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 10:24:14 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id c129so2694433oia.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 10:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y8F1yiR6lbpJjInCB9/CxhKV9jlFTUAfAcv8pt/ju+0=;
        b=qgA12b6POC3qq6xA9bJIX5wo/E/B6brjr2Bh9b+hGc8V2CWi1AkhJWk6i/WVgoafX8
         T2NMHHxcAyy395VF/56KYw4uSLq8Vt+dMmjDn8JpfVoqfFC2Yhu4U/I/Qnc+oGwWPglE
         nlOB3IeC4OOWT6vxAI8vCr03Iy3b72UaDeIi7HXXS/DEn9Pkne5QY+Czcz+4o8oEqlt7
         sG1xDz/5Gow72SqK0I0rXByugFqou8XthJxdX7uCxMxlisXzauiS5GDnBzJv4eTu9kbf
         Ck3O/f5Kw+UOwESFvhjy2N/6N87e+sxsIDCW///jB2UK9qaZl24c8DxRHp45s25D3fCc
         jFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y8F1yiR6lbpJjInCB9/CxhKV9jlFTUAfAcv8pt/ju+0=;
        b=sUWwgWUVqcIKScFk1cwwXH6nO1QcUHjA6KKQlZFJVoITUM+KYPJy8kwJGwWgbmicsD
         zJ4ZsSr2KLVWuG812FSG5b5Fczu4JY0g34HmVHjFyY0Er5UyH98V86A9m0OZ6TWqXFdW
         Dno4L1TpPP4yYdXqZGle5NzhD/cqXbITwyCopPOiuLmzAc8mJCUdH2Y8Yr5DDadgNYnx
         72yjWqDCpRse99lzcaNsOJTEmplvDdMKmYuYviQ2AEbWH1i2TKMUfBP/joMq+56EpEul
         en9SxxdCqO3SYiLLo2CnCf1OMCdL5yAEtppaq/ZkjoBivjEL6KMSWYhIfyh6WTPErc9j
         985w==
X-Gm-Message-State: ANoB5pkCX8pFhDrzFav4c//UzFxajqghIHAoLy/Usm16nnQjyR1Jgi/s
        jToCtWHQoE2yoH6AU9Lb2Ia4A7llAmEDYcXNb74=
X-Google-Smtp-Source: AA0mqf4Od9NmlpFxwLGh8Uy2yTkLVvDl4ih1XROITad87wWS01aMbvPO/A7SdL/po2HjTCPhcbbf8bBIC7E6G7UPs9Q=
X-Received: by 2002:a05:6808:1cd:b0:35b:f5f7:3ed0 with SMTP id
 x13-20020a05680801cd00b0035bf5f73ed0mr711993oic.46.1671215053261; Fri, 16 Dec
 2022 10:24:13 -0800 (PST)
MIME-Version: 1.0
References: <20221215163649.386750-1-arnd@kernel.org> <bca79bc1-9e7c-b145-0b0b-0ce725d58821@wanadoo.fr>
In-Reply-To: <bca79bc1-9e7c-b145-0b0b-0ce725d58821@wanadoo.fr>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 16 Dec 2022 13:24:01 -0500
Message-ID: <CADnq5_P29pHvKPgqvpSMqryOOq6N15=+74vzcDhh47an_ibv2g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: avoid large variable on kernel stack
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     arnd@kernel.org, llvm@lists.linux.dev, Jack.Gui@amd.com,
        KevinYang.Wang@amd.com, kenneth.feng@amd.com, Xinhui.Pan@amd.com,
        ndesaulniers@google.com, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, nathan@kernel.org, arnd@arndb.de,
        dri-devel@lists.freedesktop.org, trix@redhat.com,
        alexander.deucher@amd.com, evan.quan@amd.com,
        christian.koenig@amd.com, Hawking.Zhang@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 2:46 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 15/12/2022 =C3=A0 17:36, Arnd Bergmann a =C3=A9crit :
> > From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
> >
> > The activity_monitor_external[] array is too big to fit on the
> > kernel stack, resulting in this warning with clang:
> >
> > drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c:1438:12:=
 error: stack frame size (1040) exceeds limit (1024) in 'smu_v13_0_7_get_po=
wer_profile_mode' [-Werror,-Wframe-larger-than]
> >
> > Use dynamic allocation instead. It should also be possible to
> > have single element here instead of the array, but this seems
> > easier.
> >
> > Fixes: 334682ae8151 ("drm/amd/pm: enable workload type change on smu_v1=
3_0_7")
> > Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
> > ---
> >   .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 21 ++++++++++++++----=
-
> >   1 file changed, 16 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/dri=
vers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> > index c270f94a1b86..7eba854e09ec 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> > @@ -1439,7 +1439,7 @@ static int smu_v13_0_7_get_power_limit(struct smu=
_context *smu,
> >
> >   static int smu_v13_0_7_get_power_profile_mode(struct smu_context *smu=
, char *buf)
> >   {
> > -     DpmActivityMonitorCoeffIntExternal_t activity_monitor_external[PP=
_SMC_POWER_PROFILE_COUNT];
> > +     DpmActivityMonitorCoeffIntExternal_t *activity_monitor_external;
> >       uint32_t i, j, size =3D 0;
> >       int16_t workload_type =3D 0;
> >       int result =3D 0;
> > @@ -1447,6 +1447,12 @@ static int smu_v13_0_7_get_power_profile_mode(st=
ruct smu_context *smu, char *buf
> >       if (!buf)
> >               return -EINVAL;
> >
> > +     activity_monitor_external =3D kcalloc(sizeof(activity_monitor_ext=
ernal),
>
> Hi,
>
> Before, 'activity_monitor_external' was not initialized.
> Maybe kcalloc() is enough?
>
> sizeof(*activity_monitor_external)?
>       ~~~~

I've fixed this up when applying.

Alex

>
> > +                                         PP_SMC_POWER_PROFILE_COUNT,
> > +                                         GFP_KERNEL);
> > +     if (!activity_monitor_external)
> > +             return -ENOMEM;
> > +
> >       size +=3D sysfs_emit_at(buf, size, "                             =
 ");
> >       for (i =3D 0; i <=3D PP_SMC_POWER_PROFILE_WINDOW3D; i++)
>
> Unrelated, but wouldn't it be more straightforward with "<
> PP_SMC_POWER_PROFILE_COUNT"?
>
> >               size +=3D sysfs_emit_at(buf, size, "%-14s%s", amdgpu_pp_p=
rofile_name[i],
> > @@ -1459,15 +1465,17 @@ static int smu_v13_0_7_get_power_profile_mode(s=
truct smu_context *smu, char *buf
> >               workload_type =3D smu_cmn_to_asic_specific_index(smu,
> >                                                              CMN2ASIC_M=
APPING_WORKLOAD,
> >                                                              i);
> > -             if (workload_type < 0)
> > -                     return -EINVAL;
> > +             if (workload_type < 0) {
> > +                     result =3D -EINVAL;
> > +                     goto out;
> > +             }
> >
> >               result =3D smu_cmn_update_table(smu,
> >                                         SMU_TABLE_ACTIVITY_MONITOR_COEF=
F, workload_type,
> >                                         (void *)(&activity_monitor_exte=
rnal[i]), false);
> >               if (result) {
> >                       dev_err(smu->adev->dev, "[%s] Failed to get activ=
ity monitor!", __func__);
> > -                     return result;
> > +                     goto out;
> >               }
> >       }
> >
> > @@ -1495,7 +1503,10 @@ do {                                            =
                                                       \
> >       PRINT_DPM_MONITOR(Fclk_BoosterFreq);
> >   #undef PRINT_DPM_MONITOR
> >
> > -     return size;
> > +     result =3D size;
> > +out:
> > +     kfree(activity_monitor_external);
> > +     return result;
> >   }
> >
> >   static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu=
, long *input, uint32_t size)
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF6D624B03
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 20:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbiKJTxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 14:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbiKJTxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 14:53:32 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D58A48777
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 11:53:21 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id j25-20020a056830015900b0066ca2cd96daso1704166otp.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 11:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zpfnjo6fuKJE8yLJQoDwZgOT81sN9KFgm37VuSuSsoI=;
        b=AEc2Ulr7BLL70AOCBMaHt2UsMwr6+9EP3ynlc/2fmvRfgc2VeZfad8L/9JGKr05Mii
         Utn9K6juw2NXoJGFoLdyDFz2JRoVTT2qm4GEmJ1EYHiiieVyEmQ31WMUlkFnvg/aNoof
         SC3QTWN3TrymEXwee/Ip9zkqYXICw+JukrR4lGl4aNqdNpGuCRFOzOvBKTWtOSi1tmLO
         Zz2xh2lFBy3166FYx6N8fwbBfkjpO/DneI8/lwtXM9olCW0za5reusXFxdcTZmG2zzAg
         r9zxULuvLY5Pt4MJGMnPxlxryrszCpq7vIQTFsnCLbkCLf6XnpUIM5WFlxrP2o5QRSLU
         UIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zpfnjo6fuKJE8yLJQoDwZgOT81sN9KFgm37VuSuSsoI=;
        b=CDmDL/RI0PSBaYAvFwzBAI9uCOCltNuzKUyyxKjMPnyxTk9r0VStibsZ8PR3Hpu2r3
         ceMc3h1gvoV7zlxDi6FeKNA9JRBB1oFjSk/q9u7u4oyEeZHjIrREI1qOcliplY/qwctg
         P0r66wTEw59rkryAPsNVVPqebmkB1J/826KrBwRhJtEHg1KJCBSYCu1AmRgnBz7kKg1O
         09F0as2cWymuckHy1c+E5N3ZVyzXuYw/l1Vxt8RJfgKTwzWW387udEB/JyFtrCYAL4xv
         SSnVO8+AGgi3+0CMs7ZCHFRiE2nkzzqRRSnPf6J1XyJFfyalvKw4saZvmRyHusDkqS4o
         26qg==
X-Gm-Message-State: ACrzQf31euWo89Zoa+9Pemf5CDat1bJsqywECG480zJGIE/9sgoAsUmi
        KoBg8GIM9nBQVkcbK8OEzOK8IBFBeHglRNRUHaE=
X-Google-Smtp-Source: AMsMyM6GTfCbCbTHTtTnna9tPa6LbeHqRl1Ez14DGsKLtXZMNbChl/N6T2J5nDrBsECpJgEcabjTphutuxhgBDTjARY=
X-Received: by 2002:a9d:7f05:0:b0:66c:7982:2d45 with SMTP id
 j5-20020a9d7f05000000b0066c79822d45mr1805642otq.123.1668110000768; Thu, 10
 Nov 2022 11:53:20 -0800 (PST)
MIME-Version: 1.0
References: <20221110143314.708434-1-dongchenchen2@huawei.com> <075b9979-e956-1f01-2a57-0ff0e15d9de6@amd.com>
In-Reply-To: <075b9979-e956-1f01-2a57-0ff0e15d9de6@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 10 Nov 2022 14:53:09 -0500
Message-ID: <CADnq5_PKw4W18kY3jAhxjD6yMQqbt9X8OXwj4rb0opH3YsLBaQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix memory leak in amdgpu_cs_pass1
To:     Luben Tuikov <luben.tuikov@amd.com>
Cc:     Dong Chenchen <dongchenchen2@huawei.com>, airlied@gmail.com,
        daniel@ffwll.ch, Xinhui.Pan@amd.com, yuehaibing@huawei.com,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, alexander.deucher@amd.com,
        christian.koenig@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 1:08 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> Thanks for fixing this.
>
> Please add a Cc tag to stable, and repost.

No need for stable.  This patch just went upstream in 6.1, so I can
include it in my 6.1 fixes pull next week.  Applied.

Thanks!

Alex

>
> Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
>
> Regards,
> Luben
>
> On 2022-11-10 09:33, Dong Chenchen wrote:
> > When p->gang_size equals 0, amdgpu_cs_pass1() will return directly
> > without freeing chunk_array, which will cause a memory leak issue,
> > this patch fixes it.
> >
> > Fixes: 4624459c84d7 ("drm/amdgpu: add gang submit frontend v6")
> > Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > index 1bbd39b3b0fc..0e24d6b80e0b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > @@ -287,8 +287,10 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
> >               }
> >       }
> >
> > -     if (!p->gang_size)
> > -             return -EINVAL;
> > +     if (!p->gang_size) {
> > +             ret = -EINVAL;
> > +             goto free_partial_kdata;
> > +     }
> >
> >       for (i = 0; i < p->gang_size; ++i) {
> >               ret = amdgpu_job_alloc(p->adev, num_ibs[i], &p->jobs[i], vm);
>

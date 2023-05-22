Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8503670C1DF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 17:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234454AbjEVPDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 11:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbjEVPDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 11:03:13 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E8F10D3;
        Mon, 22 May 2023 08:02:39 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-397fe20a2b5so437669b6e.3;
        Mon, 22 May 2023 08:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684767756; x=1687359756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9+Z/yo/990FPPh1vM0WhcUYxVkl6LMnyPg5rFTfhAY=;
        b=oC+ddbUeJBq0b9XNhZ2dJmn6tG665zNZ21gthPPJvPvZJNfEuCpE4hfp7iJu4EM+5K
         7M+hg2Zbnrae9ugnC4AE3qM3JjDAgwYY3mVWUPvKudlsZZa5ng+QVoOzzJZxfzc4seAk
         Gwuv2jDItPCzIbIoFNii0/Iolc8vspBvcukjrgOh32ZBo6B0aXs+cT3aZbqSNg53xUxK
         7fFqCQazjUTzSFH6I2XSGQfAXxDz+3vWDxWKDTYYTsgCZnAX16yU/FsvZGvD7zRoOEhK
         2ffXfbT0JXROF8unVfKSleowQHrNdA4+VcR7Pymo/YlIPVoKrDwByyiodz0yZ5Ho7HAS
         1WiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684767756; x=1687359756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l9+Z/yo/990FPPh1vM0WhcUYxVkl6LMnyPg5rFTfhAY=;
        b=ESoYcCW8xbfOxO/uOcsrJgmfVoyfRuEbTUgj59hRu3vg3hmvenX96UFU5x7YvbwxRc
         DAXDJrpRHiijOyvKONAkm9YyeYodmVhNL5hPGU1xebSE65D1QMhXbX+McgRtYGKyex0V
         l2TdHHYONBqfH/Ad/C7SKxHbPISYhVXA6Jd748flOBtpCM2r6N2NCvrg/ROXbVfVE19h
         J0kAFT+RYFWtduyv9KEaYodu2EIbYIqYt8KtHLhsmdoDZxht/1T1BBtQx2zdlf3lkt65
         AUKfrtBCVp6W0Ahwp/J527+LaHtngjCFbxz3auTykZEG3/sCJC00fJSdjXhAlzGTyMj8
         dPXg==
X-Gm-Message-State: AC+VfDyHQUCr9uqc4UKpQRT6PFGFL0qOO402EoOkVjjb0yZW5CL/tY+t
        4rRmkYcCmvgStd+Kvh3XEb0/voUNZQ3ADmM4d+s=
X-Google-Smtp-Source: ACHHUZ7FhR1W38qAX9keSG9AdoCA3HHMg6j/6hWjxx9ZqXD+09z6pWBBypZbjGdOdHVeiSngkYqWdO5ffL1zVtNEXc0=
X-Received: by 2002:a05:6808:613:b0:396:2bbe:b0c0 with SMTP id
 y19-20020a056808061300b003962bbeb0c0mr5773273oih.18.1684767756342; Mon, 22
 May 2023 08:02:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230522073017.1782984-1-harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20230522073017.1782984-1-harshit.m.mogalapalli@oracle.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 22 May 2023 11:02:25 -0400
Message-ID: <CADnq5_Oqnc1vHNp5QFNA82W4Ja+ua+Xj6Feku06VG6O6bkDztg@mail.gmail.com>
Subject: Re: [PATCH next] drm/amdgpu: Fix unsigned comparison with zero in gmc_v9_0_process_interrupt()
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>, Le Ma <le.ma@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>,
        Mukul Joshi <mukul.joshi@amd.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
        Graham Sider <Graham.Sider@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dan.carpenter@linaro.org,
        kernel-janitors@vger.kernel.org, error27@gmail.com
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

On Mon, May 22, 2023 at 3:30=E2=80=AFAM Harshit Mogalapalli
<harshit.m.mogalapalli@oracle.com> wrote:
>
> Smatch warns:
>         drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c:579:
>         unsigned 'xcc_id' is never less than zero.
>
> gfx_v9_4_3_ih_to_xcc_inst() returns negative numbers as well.
> Fix this by changing type of xcc_id to int.
>
> Fixes: faf96b9b602d ("drm/amdgpu: correct the vmhub index when page fault=
 occurs")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
> This is from static analysis, only compile tested.
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v9_0.c
> index f70e666cecf2..1e8b2aaa48c1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -557,8 +557,8 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_d=
evice *adev,
>         const char *hub_name;
>         u64 addr;
>         uint32_t cam_index =3D 0;
> -       int ret;
> -       uint32_t node_id, xcc_id =3D 0;
> +       int ret, xcc_id =3D 0;
> +       uint32_t node_id;
>
>         node_id =3D entry->node_id;
>
> --
> 2.38.1
>

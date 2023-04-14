Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915EC6E2BCD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 23:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjDNVmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 17:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjDNVmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 17:42:04 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D717012E
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 14:42:03 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-187916b6543so7866393fac.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 14:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681508523; x=1684100523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4dOlaJTaykyeAIOyyfVLZGC5xuxW3rGsW7rppv/Wag=;
        b=ZDq3zZcfXjDTSo07fp7wicclRBZHzadQz9vs5jq4IAyiLTI1NVhqesyUWovSAox5UZ
         iQmLxuF+VF9uU7PZE4HsPPsbAB5iTFH3FzhTjhEdCEN1Gt11srDM3kwIR8rJJSs0Y0zw
         3nGMPcZ0W1KgYG3rFi7G/RG6YaZeOJX1UbrUT1YZSCDa+VXSf4JEX+7lHEgic/WWm0Hd
         X415fTY6j+w17SPMzjnESbV6fEZ9GphSXoeJNSNMN1oI7kJZTX8MalEZdw45V8H6Oans
         oGRF8nA5EkNKZlH9TtpVN97jxrNsKHJdx/gbfusGR9eQZ8tFpY2V6H7NEDFmroDKbrYE
         n6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681508523; x=1684100523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b4dOlaJTaykyeAIOyyfVLZGC5xuxW3rGsW7rppv/Wag=;
        b=SfAQ+t2HkLCTnp0/htwOX1LoZ3+iZAf7/eyKKw/pEyzVZb7Y9BDN/jOlX71JGnz3U3
         NnQ+DIpYqae//40YSRtireHK+9N6cWImAID54e1HiwOKjBA2bo9cIuwk6fptES6GQMLT
         SnScCtKkp5y4fF0F6e2NNM1FFoWvUWLAfa5dkgcYHYjM6aMPz9IpeEOJ1oIziFFtD9F7
         pmhXBEFNu+r/DR9DmSx4FvgSZVS4iQk1QyGrsb27eRHF+dgcGZ3NFe0kwdTvEL9HOzkO
         UngU/qJTsu6kKgGPOjQfoKqeoiju+R6KiWKTuLrb8ZkC0AaQ3M2CEMsSOQDnHm+7Muq4
         poWg==
X-Gm-Message-State: AAQBX9d3xi4z41VAFvvT29PouPKQIUSYpSvhak/sNBs37aK7p0kCIYdf
        wUGSE1XGwTP+tjaBFQxaijQyKfp8xMrjh+5c+20=
X-Google-Smtp-Source: AKy350YetlReLD9YTsp7PoVpQ6ksQbwjAZG4Ya8Udcsx7KSPjxoP1YS+BEeO3W9f7u/w/4FndfFREsvGyGEyF+03as8=
X-Received: by 2002:a05:6870:390d:b0:184:2e38:c7af with SMTP id
 b13-20020a056870390d00b001842e38c7afmr3724017oap.3.1681508523173; Fri, 14 Apr
 2023 14:42:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230414120344.3170942-1-trix@redhat.com>
In-Reply-To: <20230414120344.3170942-1-trix@redhat.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 14 Apr 2023 17:41:51 -0400
Message-ID: <CADnq5_N2j-ASAUS4Y9rmAnPyKzJ47bS4PD6y93041-dCttt8NA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: change pmfw_decoded_link_width, speed
 variables to globals
To:     Tom Rix <trix@redhat.com>
Cc:     evan.quan@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, Hawking.Zhang@amd.com, kenneth.feng@amd.com,
        tim.huang@amd.com, lijo.lazar@amd.com, mario.limonciello@amd.com,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
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

Applied.  Thanks!

Alex

On Fri, Apr 14, 2023 at 8:04=E2=80=AFAM Tom Rix <trix@redhat.com> wrote:
>
> gcc with W=3D1 reports
> In file included from drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v1=
3_0.c:36:
> ./drivers/gpu/drm/amd/amdgpu/../pm/swsmu/inc/smu_v13_0.h:66:18: error:
>   =E2=80=98pmfw_decoded_link_width=E2=80=99 defined but not used [-Werror=
=3Dunused-const-variable=3D]
>    66 | static const int pmfw_decoded_link_width[7] =3D {0, 1, 2, 4, 8, 1=
2, 16};
>       |                  ^~~~~~~~~~~~~~~~~~~~~~~
> ./drivers/gpu/drm/amd/amdgpu/../pm/swsmu/inc/smu_v13_0.h:65:18: error:
>   =E2=80=98pmfw_decoded_link_speed=E2=80=99 defined but not used [-Werror=
=3Dunused-const-variable=3D]
>    65 | static const int pmfw_decoded_link_speed[5] =3D {1, 2, 3, 4, 5};
>       |                  ^~~~~~~~~~~~~~~~~~~~~~~
>
> These variables are defined and used in smu_v13_0_7_ppt.c and smu_v13_0_0=
_ppt.c.
> There should be only one definition.  So define the variables as globals
> in smu_v13_0.c
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h   | 4 ++--
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 3 +++
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/d=
rm/amd/pm/swsmu/inc/smu_v13_0.h
> index 7944ce80e5c3..df3baaab0037 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> @@ -62,8 +62,8 @@
>  #define CTF_OFFSET_HOTSPOT             5
>  #define CTF_OFFSET_MEM                 5
>
> -static const int pmfw_decoded_link_speed[5] =3D {1, 2, 3, 4, 5};
> -static const int pmfw_decoded_link_width[7] =3D {0, 1, 2, 4, 8, 12, 16};
> +extern const int pmfw_decoded_link_speed[5];
> +extern const int pmfw_decoded_link_width[7];
>
>  #define DECODE_GEN_SPEED(gen_speed_idx)                (pmfw_decoded_lin=
k_speed[gen_speed_idx])
>  #define DECODE_LANE_WIDTH(lane_width_idx)      (pmfw_decoded_link_width[=
lane_width_idx])
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index 73175c993da9..393c6a7b9609 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -85,6 +85,9 @@ MODULE_FIRMWARE("amdgpu/smu_13_0_10.bin");
>  static const int link_width[] =3D {0, 1, 2, 4, 8, 12, 16};
>  static const int link_speed[] =3D {25, 50, 80, 160};
>
> +const int pmfw_decoded_link_speed[5] =3D {1, 2, 3, 4, 5};
> +const int pmfw_decoded_link_width[7] =3D {0, 1, 2, 4, 8, 12, 16};
> +
>  int smu_v13_0_init_microcode(struct smu_context *smu)
>  {
>         struct amdgpu_device *adev =3D smu->adev;
> --
> 2.27.0
>

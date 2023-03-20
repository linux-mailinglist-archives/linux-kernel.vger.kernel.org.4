Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9CF96C22BC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 21:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjCTUcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 16:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjCTUcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 16:32:41 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A894485;
        Mon, 20 Mar 2023 13:32:21 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-17aaa51a911so14297305fac.5;
        Mon, 20 Mar 2023 13:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679344341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=12KAyNaeVtkJ5rG4NmiGkp4SVUBOlP5Uo6aQC2/m458=;
        b=GgFEX8IntA0v6Di1a+rTrNjjl6RrkDQaozC8lQ2nu1fNZaNmjR+yunhZ2d7e1zGBpj
         OemS7YHDVpLhsOrGr9k0bGA9riGTykK407sjl86mIHF1dfPohd4xDcFc/eREcLnkyjg5
         IcqVCAFAtiXPfmaPkaDUB60V9udx+KFLFc1jgRT5qGh8PRrRAJlfck7KOULrQ+zbX3E4
         XWzIlNC129US8nw0E/3xU/y2nVxe2KI9uWRn1Mkm3hMnYXMbFFHx0vRCj1u9ctdMWZvZ
         xY5Mi66p8B0wDRHYLaOAZ8uogg+6JvpjfbfE0PZyCRF3T8cnCCCYyNaL6m/nVxHZpt8f
         sgDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679344341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=12KAyNaeVtkJ5rG4NmiGkp4SVUBOlP5Uo6aQC2/m458=;
        b=CFHCh12utmGzp08r0HlmbpLgD8h6TMT9s7NS+/dO1zlO9eeLhGqy/dgm4ajmpRLU9G
         LAEWxbYSEQKmlnVe7JZeXhnuO0tx+vestUDCcjIL/EGCF2E3JM8Laff9/JeT9NxMLt6D
         qwEuf/nz5pc4UE7owYPUNkiFg/Zs97ql6SG4ZkCeQz83y1trWKrMGgPfPB5KedHZ4Xup
         PGg/lH0L8DB2ARZX4KqJjKw+8z+AZK/J1LW1r9EV6fGCzsLLcws8gO0tGYvcgNfIEjqS
         umS/iXj3NG4HwE/Fu2oAoRcM/UXW+06caNuLKh2d7GLPac0s6V5DYTX62Np5Ay9z2Feb
         BU0w==
X-Gm-Message-State: AO0yUKUMuyiiAPzNCeN7Dmzxd92U8hJH05kKWiBSbDkS25buCCrvLU1e
        jI8VH37Y5pr5JP0RBMYX2EAv1c8V9JT/4t+tSmM=
X-Google-Smtp-Source: AK7set+DLFjlPgniOaSyE+Bi3m/ZckWHV551x+C0CntkAwvgXWwf+U3UZOrrp6mZW/7ZzD37hw8KFC+8m3onejMpB6k=
X-Received: by 2002:a05:687c:90:b0:17a:d52e:77de with SMTP id
 yg16-20020a05687c009000b0017ad52e77demr3022932oab.5.1679344341050; Mon, 20
 Mar 2023 13:32:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230320185416.938842-1-robdclark@gmail.com> <434caf75-eed1-ac35-f43c-da8c66cb99bc@somainline.org>
 <5a9e6cdb-f640-f070-6722-18e61c9f1136@linaro.org>
In-Reply-To: <5a9e6cdb-f640-f070-6722-18e61c9f1136@linaro.org>
From:   Rob Clark <robdclark@gmail.com>
Date:   Mon, 20 Mar 2023 13:32:09 -0700
Message-ID: <CAF6AEGv1ALTcvHCPVo_sqt8UHYVcsV_XdP054D+qQr72yQ6-Dg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/msm/a6xx: Some reg64 conversion
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Chia-I Wu <olvaffe@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
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

On Mon, Mar 20, 2023 at 11:57=E2=80=AFAM Konrad Dybcio <konrad.dybcio@linar=
o.org> wrote:
>
>
>
> On 20.03.2023 19:56, Konrad Dybcio wrote:
> >
> >
> > On 20.03.2023 19:54, Rob Clark wrote:
> >> From: Rob Clark <robdclark@chromium.org>
> >>
> >> The next generated header update will drop the _LO/_HI suffix, now tha=
t
> >> the userspace tooling properly understands 64b vs 32b regs (and the _L=
O/
> >> _HI workarounds are getting cleaned up).  So convert to using the 64b
> >> reg helpers in prep.
> >>
> >> Signed-off-by: Rob Clark <robdclark@chromium.org>
> >> ---
> >>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 9 +++------
> >>  1 file changed, 3 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/m=
sm/adreno/a6xx_gpu.c
> >> index 89049094a242..f26e258c6021 100644
> >> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> >> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> >> @@ -1053,12 +1053,9 @@ static int hw_init(struct msm_gpu *gpu)
> >>      gpu_write(gpu, REG_A6XX_RBBM_PERFCTR_GPU_BUSY_MASKED, 0xffffffff)=
;
> >>
> >>      /* Disable L2 bypass in the UCHE */
> >> -    gpu_write(gpu, REG_A6XX_UCHE_WRITE_RANGE_MAX_LO, 0xffffffc0);
> >> -    gpu_write(gpu, REG_A6XX_UCHE_WRITE_RANGE_MAX_HI, 0x0001ffff);
> >> -    gpu_write(gpu, REG_A6XX_UCHE_TRAP_BASE_LO, 0xfffff000);
> >> -    gpu_write(gpu, REG_A6XX_UCHE_TRAP_BASE_HI, 0x0001ffff);
> >> -    gpu_write(gpu, REG_A6XX_UCHE_WRITE_THRU_BASE_LO, 0xfffff000);
> >> -    gpu_write(gpu, REG_A6XX_UCHE_WRITE_THRU_BASE_HI, 0x0001ffff);
> >> +    gpu_write64(gpu, REG_A6XX_UCHE_WRITE_RANGE_MAX_LO, 0x0001ffffffff=
ffc0llu);
> >> +    gpu_write64(gpu, REG_A6XX_UCHE_TRAP_BASE_LO, 0x0001fffffffff000ll=
u);
> >> +    gpu_write64(gpu, REG_A6XX_UCHE_WRITE_THRU_BASE_LO, 0x1fffffffff00=
0llu);
> > Any reason the last write dropped the leading zeroes?
> >
> > Otherwise,
> >
> > Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Bah, thunderfox sent it from the wrong email. It still stands.

No good reason.. I can fix that up when I apply

BR,
-R

> Konrad
> >
> > Konrad
> >>
> >>      if (!adreno_is_a650_family(adreno_gpu)) {
> >>              /* Set the GMEM VA range [0x100000:0x100000 + gpu->gmem -=
 1] */

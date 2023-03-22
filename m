Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7200E6C5823
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 21:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjCVUv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 16:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjCVUvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 16:51:01 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E5912BC4;
        Wed, 22 Mar 2023 13:48:57 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id bj20so5216946oib.3;
        Wed, 22 Mar 2023 13:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679518136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MPANpQo2pbBjv7bN+m6aSZeybQN0T9mXhbFUpa61TPQ=;
        b=fx9hdW6p0dQdtSIlZNZVy26SYG5ERPukARJpRq4EZ12B/ilaMyklpkLz3p7498u1ZP
         zkKaBNEiOwxxqaHEn0DdRQQwxjYO8fSCzYCpT1Q4hn26Ps1v4J55dK2f4sPtW61yf8Eo
         OLliIc20a9ml5L+Z6oQiuhKfLNvBmTpq51k+8V9lL/i64RxIutVo/LOaogcjkgNJYIZX
         kk60XrmYuDM/OimXwdTNdasE8+NlQAAhO9M9VU8QHJGL7nXcaKpXDrcaeHXEatPnDqKQ
         Z1btLvtCIdHOOk4yEmoY67WSIhz22y/Xm49IztnbYrLMkExi9Btd593xkfo+GFFOKTUJ
         9lTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679518136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MPANpQo2pbBjv7bN+m6aSZeybQN0T9mXhbFUpa61TPQ=;
        b=23qK7scEi9kd2mx6M0FM2LPdbpXps+3ufP0jVSss00or8i9CtZmWv5KBLWCdK/R6OY
         xeYi2jpvwdO9BDO17sCMtLfX3QSaziPvzDL/RFQO4uZyJe0YTULz7sw9z30iWAqVhSRJ
         D3JjL5ANtaMEkHXbUp6LT9B0caGsv2aJPKSzvqLWM7sjV5aDCX1cT8bdUxMCXD1fEBFV
         BwcbIAyGi57QxGiMOgVK9kOUnQXotTdEqwWThYXJZZ5E7unUdbRQ3yWJ8w32+uMwzMWU
         mxJHAwnGeTBblNAIZa2Vtdy34LdELl3ik5JVPYPcTSgo+ZZ29rC7LIrMUnfVuniI24yF
         EWgQ==
X-Gm-Message-State: AO0yUKVNouzjFdTiKxHai7iTjgoRTEIkBGJkrUTNrBT6n+9tHjaLn6Ew
        S3j6qrtfUEhWg8dacudmXAL4pcyahAwS2JVakLQ=
X-Google-Smtp-Source: AK7set/ZbUQNbAR4aFIk7VnLqx7B6Seh+3ogULmXSVniL38EBZndSAX2MDpf7tdc0/FahMyfyYS6l4wNzt57YdsP8lY=
X-Received: by 2002:aca:1010:0:b0:384:6d14:c707 with SMTP id
 16-20020aca1010000000b003846d14c707mr1304761oiq.5.1679518136556; Wed, 22 Mar
 2023 13:48:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230306090633.65918-1-geert+renesas@glider.be> <f2ac0d80-fab1-8211-1dfe-cea078929e91@infradead.org>
In-Reply-To: <f2ac0d80-fab1-8211-1dfe-cea078929e91@infradead.org>
From:   Rob Clark <robdclark@gmail.com>
Date:   Wed, 22 Mar 2023 13:48:45 -0700
Message-ID: <CAF6AEGvxOdqeK65fWOqqOvTO4fHS83U4orMG6GdQyx1tcSiK_Q@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dpu: Fix bit-shifting UB in DPU_HW_VER() macro
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Vinod Koul <vkoul@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 8:08=E2=80=AFAM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
>
>
> On 3/6/23 01:06, Geert Uytterhoeven wrote:
> > With gcc-5 and CONFIG_UBSAN_SHIFT=3Dy:
> >
> >     drivers/gpu/drm/msm/msm_mdss.c: In function 'msm_mdss_enable':
> >     drivers/gpu/drm/msm/msm_mdss.c:296:2: error: case label does not re=
duce to an integer constant
> >       case DPU_HW_VER_800:
> >       ^
> >     drivers/gpu/drm/msm/msm_mdss.c:299:2: error: case label does not re=
duce to an integer constant
> >       case DPU_HW_VER_810:
> >       ^
> >     drivers/gpu/drm/msm/msm_mdss.c:300:2: error: case label does not re=
duce to an integer constant
> >       case DPU_HW_VER_900:
> >       ^
> >
> > This happens because for major revisions 8 or greather, the non-sign bi=
t
> > of the major revision number is shifted into bit 31 of a signed integer=
,
> > which is undefined behavior.
> >
> > Fix this by casting the major revision number to unsigned int.
> >
> > Fixes: efcd0107727c4f04 ("drm/msm/dpu: add support for SM8550")
> > Fixes: 4a352c2fc15aec1e ("drm/msm/dpu: Introduce SC8280XP")
> > Fixes: 100d7ef6995d1f86 ("drm/msm/dpu: add support for SM8450")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Reviewed-by: Rob Clark <robdclark@gmail.com>

>
> Thanks.
>
> > ---
> >  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/g=
pu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> > index ddab9caebb18c40d..bbd3cbdd77956c5d 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> > @@ -19,8 +19,9 @@
> >   */
> >  #define MAX_BLOCKS    12
> >
> > -#define DPU_HW_VER(MAJOR, MINOR, STEP) (((MAJOR & 0xF) << 28)    |\
> > -             ((MINOR & 0xFFF) << 16)  |\
> > +#define DPU_HW_VER(MAJOR, MINOR, STEP)                       \
> > +             ((((unsigned int)MAJOR & 0xF) << 28) |  \
> > +             ((MINOR & 0xFFF) << 16) |               \
> >               (STEP & 0xFFFF))
> >
> >  #define DPU_HW_MAJOR(rev)            ((rev) >> 28)
>
> --
> ~Randy

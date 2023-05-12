Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C68701206
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 00:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239560AbjELWFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 18:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238617AbjELWFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 18:05:33 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57D21BD8
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 15:05:31 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-96aae59bbd6so213325866b.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 15:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google; t=1683929130; x=1686521130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pwTZNtrI+YiOy4giDbSjOeuRPc624jlpa4MZRhVR2oc=;
        b=NOUXQkexeahKAlXM0a2wPcqC1kMBChCsFbOiTkWCx0Gtll9MJrvr9cIyD+eQcCnnox
         uPKuJcnqQd6I6gzjOh0ZJrSOlPMmN8rkhYwdMsq50zSnrPRtTLzfqoZPY5g3XNxVRHUK
         0M2kiFNZGTh6PHpeY75y/23/w7Ct6mRH0CwvnQie7spUJ6u5jXTRBJtk4m/8Z0NM8xxR
         kvDGVvE3Vl7+XFT/o8lYadhEquOLrGLxfIDEf7vfEuN8epxZhW7JaeLvm2U92ebPyv9f
         mC4oYEAJN2Q/nqynAaiXOvPXQv2nFXqxPEQPW5l+mhOX9lSjmHB50Hb2zLpxjHhykJpf
         IJAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683929130; x=1686521130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pwTZNtrI+YiOy4giDbSjOeuRPc624jlpa4MZRhVR2oc=;
        b=IQt3ofIeqpg9d1qwbtjQWY4tYEsIRWSwDdpgpSZ44MOmR2gsN82e/e/KlwXzJj5xIv
         zhDzkd3tHC1D5sBcuMT/q7PxHA7SQJtug0uF/yPEY12j32k94KlU7U51IIzz/sLNADIi
         yihvKnTYlFSPn2b03Ns0TgNz3ScUUv6v/mFb3uhs8+tTk6uz5sqLroEB155TQdOEy32w
         5i2KR5/FDUkKjQgqZ2meZEG5AxA2hMdb4WFiS9GH9ItNZ2OKnNYoOtKRdMN3jj5RxkWt
         HYr7T72/rOV1EIywlC1X1eWbk5sGiayf0kPzFrbP7AEuf/75yeK0lYQPkXeY6r7cu9zW
         On/w==
X-Gm-Message-State: AC+VfDzn2hNII+xgN3yLRHsGOvPJUVfbcPh10FkRwInE+x/HAajdPGQ4
        YDMw1gQEeIv19394u1BDSHaDrAqWL1yI9ttWSEg2CA==
X-Google-Smtp-Source: ACHHUZ5NKq9oF9FL0FPu6VyHTVb2WVLbsDQOCmD+nOw/jRTP+v3RbaCiuS0+0vcmd8oPyoCaAcpWKWEf4Sj9BgIELO4=
X-Received: by 2002:a17:907:84a:b0:94e:bc04:c6f6 with SMTP id
 ww10-20020a170907084a00b0094ebc04c6f6mr22229644ejb.9.1683929130319; Fri, 12
 May 2023 15:05:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230512165524.3367443-1-quic_bjorande@quicinc.com>
In-Reply-To: <20230512165524.3367443-1-quic_bjorande@quicinc.com>
From:   Steev Klimaszewski <steev@kali.org>
Date:   Fri, 12 May 2023 17:05:19 -0500
Message-ID: <CAKXuJqj9XA5KO=S47H0Qz3ZwT=uEV95a26BheZ7k41GEJW7PYw@mail.gmail.com>
Subject: Re: [PATCH] leds: qcom-lpg: Fix PWM period limits
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Anjelique Melendez <quic_amelende@quicinc.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Luca Weiss <luca@z3ntu.xyz>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 11:55=E2=80=AFAM Bjorn Andersson
<quic_bjorande@quicinc.com> wrote:
>
> The introduction of high resolution PWM support moved the parenthesis of
> the divisions in the calculation of min and max period. The result in
> both divisions is in most cases truncation to 0, which limits the period
> to the range of [0, 0].
>
> Both numerators (and denominators) are within 64 bits, so the whole
> expression can be put directly into the div64_u64, instead of doing it
> partially.
>
> Fixes: b00d2ed37617 ("leds: rgb: leds-qcom-lpg: Add support for high reso=
lution PWM")
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>
> This fixes the regression in v6.4-rc1.
>
>  drivers/leds/rgb/leds-qcom-lpg.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qco=
m-lpg.c
> index c9cea797a697..7287fadc00df 100644
> --- a/drivers/leds/rgb/leds-qcom-lpg.c
> +++ b/drivers/leds/rgb/leds-qcom-lpg.c
> @@ -312,14 +312,14 @@ static int lpg_calc_freq(struct lpg_channel *chan, =
uint64_t period)
>                 max_res =3D LPG_RESOLUTION_9BIT;
>         }
>
> -       min_period =3D (u64)NSEC_PER_SEC *
> -                       div64_u64((1 << pwm_resolution_arr[0]), clk_rate_=
arr[clk_len - 1]);
> +       min_period =3D div64_u64((u64)NSEC_PER_SEC * (1 << pwm_resolution=
_arr[0]),
> +                              clk_rate_arr[clk_len - 1]);
>         if (period <=3D min_period)
>                 return -EINVAL;
>
>         /* Limit period to largest possible value, to avoid overflows */
> -       max_period =3D (u64)NSEC_PER_SEC * max_res * LPG_MAX_PREDIV *
> -                       div64_u64((1 << LPG_MAX_M), 1024);
> +       max_period =3D div64_u64((u64)NSEC_PER_SEC * max_res * LPG_MAX_PR=
EDIV * (1 << LPG_MAX_M),
> +                              1024);
>         if (period > max_period)
>                 period =3D max_period;
>
> --
> 2.25.1
>
Thank you!
Without this fix, the display never activates on the Thinkpad X13s
Tested on the Lenovo Thinkpad X13s
Tested-by: Steev Klimaszewski <steev@kali.org>

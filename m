Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B14D6B7951
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 14:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjCMNqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 09:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjCMNqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 09:46:05 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E3E6423D;
        Mon, 13 Mar 2023 06:45:59 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id bd34so7642452pfb.3;
        Mon, 13 Mar 2023 06:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678715159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9wLaFePw5uizR8ACmMIJJlsaFTkZCvBfOgjm8YIL3M8=;
        b=eFS47Ssmt7X0FwhY4ytr+0HcNC+s4l132+lewLE6h3FqNYvWsLX1ZooOfoWgjHKpzY
         fUntVw+nFnXpH5JLd9XMpKqGOf9rXfOH6JcZK7qWE/G0nLJEjetc3Z8bgE6mTkrnhD+t
         wtvraxMxzmOETvmkyOak3onEodjxFzl1kEr5gJjkCToq9k/U9ok5+HPTrE3QKnUsEDYA
         avSydApo7/weB5xinrrvgJR0e8C6xPsUJqrP3o4Yx8vK165b9Ko8vKNWJK0jDcYQLhug
         YdsQIgZ/8hLBFDvH954hkEJSjznS94mXEr9qd3t1Yy+imZ8FpAaFjnsepAPHDT79S5YJ
         eidw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678715159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9wLaFePw5uizR8ACmMIJJlsaFTkZCvBfOgjm8YIL3M8=;
        b=PjKJOhlCnGWK0d2gt4E3WrUhPi66Do4RbQsDrWIZYnCmkIpy+ZzkzSlo2JyYjgAPEZ
         +gUlP1nUYCniWkqNoXByiQYUsBAc5rKWcZ4NHUqOLNttRdneA766bK/N3f2M6EEQz/6B
         kgf88BEzhn2MBow3Zct49J3NyhgnCLsqVQl1LJtyhXcnsQAClisH4pEdzSyb+7Aph50w
         7/3ssDBxg2EHTnMUzuH48NRWzVdcKTbP556dek6qfEuz9lqPSIuLVZIwbsuAoLb6mK9a
         6hQwwOpJK30BWt2R4HOjraMPxkc9TBacpSmm2UHke+QDi9sDHwvw4/2eCKD3IrfYWNHz
         YCnA==
X-Gm-Message-State: AO0yUKWg2Z9IlhwyW9dKlLYXHD4iZltCc4EX61qh7MwMQT8b7zCTCSZD
        raQETuB+1WKJOdn2liEjN0LRCk16HN+orrCBuCs=
X-Google-Smtp-Source: AK7set/4ZrSgWUOtk8zrsPfXTKInpjR2EbM8Tull01+AqwU7TJ0HaK9Kxl7M3/EdWIkALOWLpSBkDTzHhVDkaRDwG/M=
X-Received: by 2002:a63:f0a:0:b0:502:f5c8:a00c with SMTP id
 e10-20020a630f0a000000b00502f5c8a00cmr11041793pgl.9.1678715158757; Mon, 13
 Mar 2023 06:45:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230307153542.1178065-1-zyytlz.wz@163.com> <7f9796d2-1885-a6f2-b9e3-d6ea58524033@xs4all.nl>
In-Reply-To: <7f9796d2-1885-a6f2-b9e3-d6ea58524033@xs4all.nl>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Mon, 13 Mar 2023 21:45:45 +0800
Message-ID: <CAJedcCwnvNK8Gbcxz2V5+ebRJFrEYjpoJsKTKZ7DOSETr_7LEQ@mail.gmail.com>
Subject: Re: [PATCH] media: hantro: fix use after free bug in hantro_release
 due to race condition
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Zheng Wang <zyytlz.wz@163.com>, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, 1395428693sheep@gmail.com,
        alex000young@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Verkuil <hverkuil@xs4all.nl> =E4=BA=8E2023=E5=B9=B43=E6=9C=8813=E6=97=
=A5=E5=91=A8=E4=B8=80 21:17=E5=86=99=E9=81=93=EF=BC=9A
>
> On 07/03/2023 16:35, Zheng Wang wrote:
> > In hantro_probe, vpu->watchdog_work is bound with
> > hantro_watchdog. Then hantro_end_prepare_run may
> > be called to start the work.
> >
> > If we close the file or remove the module which will
> > call hantro_release and hantro_remove to make cleanup,
> > there may be a unfinished work. The possible sequence
> > is as follows, which will cause a typical UAF bug.
> >
> > The same thing will happen in hantro_release, and use
> > ctx after freeing it.
> >
> > Fix it by canceling the work before cleanup in hantro_release.
> >
> > CPU0                  CPU1
> >
> >                     |hantro_watchdog
> > hantro_remove     |
> >   v4l2_m2m_release  |
> >     kfree(m2m_dev); |
> >                     |
> >                     | v4l2_m2m_get_curr_priv
> >                     |   m2m_dev->curr_ctx //use
> >
> > Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> > ---
> >  drivers/media/platform/verisilicon/hantro_drv.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/=
media/platform/verisilicon/hantro_drv.c
> > index b0aeedae7b65..cf00ccaa7829 100644
> > --- a/drivers/media/platform/verisilicon/hantro_drv.c
> > +++ b/drivers/media/platform/verisilicon/hantro_drv.c
> > @@ -601,6 +601,7 @@ static int hantro_release(struct file *filp)
> >        * No need for extra locking because this was the last reference
> >        * to this file.
> >        */
> > +     cancel_delayed_work(&vpu->watchdog_work);
> >       v4l2_m2m_ctx_release(ctx->fh.m2m_ctx);
> >       v4l2_fh_del(&ctx->fh);
> >       v4l2_fh_exit(&ctx->fh);
>
> drivers/media/platform/verisilicon/hantro_drv.c: In function =E2=80=98han=
tro_release=E2=80=99:
> drivers/media/platform/verisilicon/hantro_drv.c:604:30: error: =E2=80=98v=
pu=E2=80=99 undeclared (first use in this function); did you mean =E2=80=98=
fpu=E2=80=99?
>   604 |         cancel_delayed_work(&vpu->watchdog_work);
>       |                              ^~~
>       |                              fpu
> drivers/media/platform/verisilicon/hantro_drv.c:604:30: note: each undecl=
ared identifier is reported only once for each function it appears in
>
> You clearly didn't compile this patch!
>
Sorry for my mistake. I was hurried to report the issue and discuss
with developer to confirm it . I'll complete it and test it locally.

Best regards,
Zheng

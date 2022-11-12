Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E86626B16
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 19:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235031AbiKLSoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 13:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiKLSoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 13:44:15 -0500
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3483A262F;
        Sat, 12 Nov 2022 10:44:14 -0800 (PST)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-13ba86b5ac0so8658610fac.1;
        Sat, 12 Nov 2022 10:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RW2ierpmO9Ob9gBGCgFgoR5MnOmGKRHEK26wUjbjR4A=;
        b=GCOaqdr4YOF0FX/9QEEFwpEW0tOXrQcDyze2xaDGpwIzqDuQbOC/dX+y+Yc8zz1Xmw
         hb2z3xqDXKT2Sg2chXVIo8rgQLtWi/5iGHeUydXd8DWV/IY/eaIACoM3kF7gppmR944z
         Nq3glLGU1AffkDUlsOgg4B5YtDqNtesEhGQXvUlzfj3BH7ptOujETRIFXeMxN/uuRVn/
         tUil3PE7NlXPqXwHUOHEzCgeakanqIPT0hr7NYguCypMMRnzawy/NDadT5yBNBcfzW8R
         wHjRDt0k87kdZs1sOaaak8tzxu9+pZ4Ax4UiDTjzZBr+/d4G/gUK6ZX6zEpNexpfWh6Y
         7yNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RW2ierpmO9Ob9gBGCgFgoR5MnOmGKRHEK26wUjbjR4A=;
        b=r12qmHg1LZ81/RQNiUCC5Kd191fawLfiKdiZtTMUUrRBlTjDD+ex916hGZ7haAn9Eo
         9jTPWcCJeGQSXwD6/whqGEKHS0f5RxD3SJ+epUmK+iV+9d9ayEVAMppU2J72itVFu5sa
         JPNhK9fKiM+xGTaUTSEwG8ZxS7hrPDftqFFrVrrM2LCnYY9U4n9OIoWl3O+UZEcqk/ZK
         JMrlpj5qjH8B0gEAmAK8AJnCzh1z+9OWCaZc2G2KF+cjqggx19W+NAqQ4PNWknZx+Nyk
         zK3hXVUuFboRMtCHnwL2yAQncwi44HniQ4+MU7yTRv6PWhpSHLVJa3C6sGWKMliyerW/
         X0yA==
X-Gm-Message-State: ANoB5plciG+KuJFBMKrQDqlKoacQx5c6cK5VjmHaJof+D8q1AbmY2Zcq
        FZb4mDDd6Lxn6Qc7JCOCCA5w4SQdMrnS1MpVh+z7PIHgTy4=
X-Google-Smtp-Source: AA0mqf4kaFqXtJ+RO4j7D+L1kwF4/PLgS1JnevXdJ1cEwhQKGJm/s6jrSY7XjKorOAs03anRZVUAIivVVjk+JpiIeBY=
X-Received: by 2002:a05:6870:1f15:b0:131:f559:461b with SMTP id
 pd21-20020a0568701f1500b00131f559461bmr3779869oab.38.1668278653159; Sat, 12
 Nov 2022 10:44:13 -0800 (PST)
MIME-Version: 1.0
References: <20221111194957.4046771-1-joel@joelfernandes.org> <B336E259-FB18-4E16-8BC7-2117614ABE4D@joelfernandes.org>
In-Reply-To: <B336E259-FB18-4E16-8BC7-2117614ABE4D@joelfernandes.org>
From:   Rob Clark <robdclark@gmail.com>
Date:   Sat, 12 Nov 2022 10:44:33 -0800
Message-ID: <CAF6AEGvsmXZkw2epEE3y8hksQea0xW8TAhgitiGJY66PiQPaPA@mail.gmail.com>
Subject: Re: [PATCH 1/2] adreno: Shutdown the GPU properly
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Ross Zwisler <zwisler@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        dri-devel@lists.freedesktop.org, Emma Anholt <emma@anholt.net>,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Sean Paul <sean@poorly.run>,
        Vladimir Lypak <vladimir.lypak@gmail.com>
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

On Fri, Nov 11, 2022 at 1:08 PM Joel Fernandes <joel@joelfernandes.org> wro=
te:
>
>
>
> > On Nov 11, 2022, at 2:50 PM, Joel Fernandes (Google) <joel@joelfernande=
s.org> wrote:
> >
> > =EF=BB=BFDuring kexec on ARM device, we notice that device_shutdown() o=
nly calls
> > pm_runtime_force_suspend() while shutting down the GPU. This means the =
GPU
> > kthread is still running and further, there maybe active submits.
> >
> > This causes all kinds of issues during a kexec reboot:
> >
> > Warning from shutdown path:
> >
> > [  292.509662] WARNING: CPU: 0 PID: 6304 at [...] adreno_runtime_suspen=
d+0x3c/0x44
> > [  292.509863] Hardware name: Google Lazor (rev3 - 8) with LTE (DT)
> > [  292.509872] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BT=
YPE=3D--)
> > [  292.509881] pc : adreno_runtime_suspend+0x3c/0x44
> > [  292.509891] lr : pm_generic_runtime_suspend+0x30/0x44
> > [  292.509905] sp : ffffffc014473bf0
> > [...]
> > [  292.510043] Call trace:
> > [  292.510051]  adreno_runtime_suspend+0x3c/0x44
> > [  292.510061]  pm_generic_runtime_suspend+0x30/0x44
> > [  292.510071]  pm_runtime_force_suspend+0x54/0xc8
> > [  292.510081]  adreno_shutdown+0x1c/0x28
> > [  292.510090]  platform_shutdown+0x2c/0x38
> > [  292.510104]  device_shutdown+0x158/0x210
> > [  292.510119]  kernel_restart_prepare+0x40/0x4c
> >
> > And here from GPU kthread, an SError OOPs:
> >
> > [  192.648789]  el1h_64_error+0x7c/0x80
> > [  192.648812]  el1_interrupt+0x20/0x58
> > [  192.648833]  el1h_64_irq_handler+0x18/0x24
> > [  192.648854]  el1h_64_irq+0x7c/0x80
> > [  192.648873]  local_daif_inherit+0x10/0x18
> > [  192.648900]  el1h_64_sync_handler+0x48/0xb4
> > [  192.648921]  el1h_64_sync+0x7c/0x80
> > [  192.648941]  a6xx_gmu_set_oob+0xbc/0x1fc
> > [  192.648968]  a6xx_hw_init+0x44/0xe38
> > [  192.648991]  msm_gpu_hw_init+0x48/0x80
> > [  192.649013]  msm_gpu_submit+0x5c/0x1a8
> > [  192.649034]  msm_job_run+0xb0/0x11c
> > [  192.649058]  drm_sched_main+0x170/0x434
> > [  192.649086]  kthread+0x134/0x300
> > [  192.649114]  ret_from_fork+0x10/0x20
> >
> > Fix by calling adreno_system_suspend() in the device_shutdown() path.
> >
> > Cc: Rob Clark <robdclark@chromium.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Ricardo Ribalda <ribalda@chromium.org>
> > Cc: Ross Zwisler <zwisler@kernel.org>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> > drivers/gpu/drm/msm/adreno/adreno_device.c | 5 ++++-
> > 1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/d=
rm/msm/adreno/adreno_device.c
> > index 24b489b6129a..f0cff62812c3 100644
> > --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> > +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> > @@ -607,9 +607,12 @@ static int adreno_remove(struct platform_device *p=
dev)
> >    return 0;
> > }
> >
> > +static int adreno_system_suspend(struct device *dev);
> > static void adreno_shutdown(struct platform_device *pdev)
> > {
> > -    pm_runtime_force_suspend(&pdev->dev);
> > +    struct msm_gpu *gpu =3D dev_to_gpu(&pdev->dev);
> > +
>
> This local variable definition should go to patch 2/2. Will fix in v2.
>
> Thanks,
>
>  - Joel
>
>
> > +    WARN_ON_ONCE(adreno_system_suspend(&pdev->dev));

I think maybe adreno_unbind() needs the same treatment?  Any path
where we yank out the power cord without ensuring the scheduler is
parked means we'd be racing with jobs in the scheduler queue.  Ie.
userspace could queue a job before it is frozen, but the drm/scheduler
kthread hasn't yet called the msm_job_run() callback (which does
various touching of the now powered off hw).  So I think we need to
ensure that the scheduler is parked in all paths that call
pm_runtime_force_suspend() (as that bypasses the runpm reference that
would otherwise unsure the hw is powered before msm_job_run pokes at
registers)

BR,
-R

> > }
> >
> > static const struct of_device_id dt_match[] =3D {
> > --
> > 2.38.1.493.g58b659f92b-goog
> >

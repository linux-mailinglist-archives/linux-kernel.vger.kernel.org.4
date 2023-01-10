Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE20B6644FE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 16:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238912AbjAJPe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 10:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbjAJPes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 10:34:48 -0500
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111F114D38;
        Tue, 10 Jan 2023 07:34:47 -0800 (PST)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1322d768ba7so12490429fac.5;
        Tue, 10 Jan 2023 07:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aALJ1+6b5A4lyvQQ5kPDXbutVahUhVTXhBlHzFelYpk=;
        b=i6n470Ce+W8oxpPwNBChX5RaFXJ3U23JN6QGshiLXPAPCLB3Vl7bRDfWfXEGqT8Vhn
         oG4B5kAhBbdnfMjH8a5QJB9H/4UUQ2f9dZuV8msyDrodGKrifhB64Df0ZuFKKrPIiEq1
         OCE+K0XbyQyPzg2bAsjB6v4j567tKH6yOWOogo8W975GwHjBuBSXSam22iLhScIjOqlC
         Dv8iP4kFVnJ6x3wdBPZesdbf7Atc2MGJuSMNBM9y+gUTwAYvxF/q3SfzKO2qSWBmmR+D
         Q9weB6DalU7I8RZ5BbMAvFekdRBevNNzIa0BQDlAW3SOsnv+pA1Ylb4jTWAISmqwg/W2
         /Q9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aALJ1+6b5A4lyvQQ5kPDXbutVahUhVTXhBlHzFelYpk=;
        b=4Ga+Z1gjuJLWbXecdpdNvxiA0yGkZJ+V/3li3v5YM+vlkc7AbJnLoQfBmO89Ri6Ehx
         LRntj5jc0Pr87i/nsSglgzawxzKeNF8FbKNBCLOK9Zx/CwH/Pn7uxBi6rohIghUy+S0j
         ihxL3zUS6jcenBhPkjtjY+5z1rwnz/4eLi3M21MVRNeKe7FqY32EL+jdkIfwjzQXBo7V
         zFt9/qVUICh+HcbEdDzeyDCg/mmhkytSTDsyG5DO2goleHPRFztLnqbTJDyCvIGCJ9T1
         anmiJ+VAycTxZMfZAZ9R/6ovld2qzOGOJWcEhKDUTibZED5iyd2ZbyHeTMdv2RKQNESx
         a+8A==
X-Gm-Message-State: AFqh2kotkSVXTHBIzubGq08M26aCvhFvuWZ9wj6QHBRAP9ZeuQ/QHfQO
        WJGVMSXnbIZDjLhy/nN0HpHTia8ZtQs1dFTNgJk=
X-Google-Smtp-Source: AMrXdXvn1xRON1Kd8a0qV7Mrhm6vYwZcsKzzIkhhNKV5lkac3FN/6IpCOpNBj8E7gJ1EQBg4vrMMdWCHfSH7GIiy1oo=
X-Received: by 2002:a05:6870:cb98:b0:15b:96b8:e2be with SMTP id
 ov24-20020a056870cb9800b0015b96b8e2bemr326656oab.38.1673364886323; Tue, 10
 Jan 2023 07:34:46 -0800 (PST)
MIME-Version: 1.0
References: <20230109222547.1368644-1-joel@joelfernandes.org>
In-Reply-To: <20230109222547.1368644-1-joel@joelfernandes.org>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 10 Jan 2023 07:34:41 -0800
Message-ID: <CAF6AEGsH21bb6ihE41UR-jODL0C8fVVg9=ODj-Ksd7CnZaYzDw@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] adreno: Shutdown the GPU properly
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Ross Zwisler <zwisler@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, Sean Paul <sean@poorly.run>
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

On Mon, Jan 9, 2023 at 2:25 PM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> During kexec on ARM device, we notice that device_shutdown() only calls
> pm_runtime_force_suspend() while shutting down the GPU. This means the GPU
> kthread is still running and further, there maybe active submits.
>
> This causes all kinds of issues during a kexec reboot:
>
> Warning from shutdown path:
>
> [  292.509662] WARNING: CPU: 0 PID: 6304 at [...] adreno_runtime_suspend+0x3c/0x44
> [  292.509863] Hardware name: Google Lazor (rev3 - 8) with LTE (DT)
> [  292.509872] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [  292.509881] pc : adreno_runtime_suspend+0x3c/0x44
> [  292.509891] lr : pm_generic_runtime_suspend+0x30/0x44
> [  292.509905] sp : ffffffc014473bf0
> [...]
> [  292.510043] Call trace:
> [  292.510051]  adreno_runtime_suspend+0x3c/0x44
> [  292.510061]  pm_generic_runtime_suspend+0x30/0x44
> [  292.510071]  pm_runtime_force_suspend+0x54/0xc8
> [  292.510081]  adreno_shutdown+0x1c/0x28
> [  292.510090]  platform_shutdown+0x2c/0x38
> [  292.510104]  device_shutdown+0x158/0x210
> [  292.510119]  kernel_restart_prepare+0x40/0x4c
>
> And here from GPU kthread, an SError OOPs:
>
> [  192.648789]  el1h_64_error+0x7c/0x80
> [  192.648812]  el1_interrupt+0x20/0x58
> [  192.648833]  el1h_64_irq_handler+0x18/0x24
> [  192.648854]  el1h_64_irq+0x7c/0x80
> [  192.648873]  local_daif_inherit+0x10/0x18
> [  192.648900]  el1h_64_sync_handler+0x48/0xb4
> [  192.648921]  el1h_64_sync+0x7c/0x80
> [  192.648941]  a6xx_gmu_set_oob+0xbc/0x1fc
> [  192.648968]  a6xx_hw_init+0x44/0xe38
> [  192.648991]  msm_gpu_hw_init+0x48/0x80
> [  192.649013]  msm_gpu_submit+0x5c/0x1a8
> [  192.649034]  msm_job_run+0xb0/0x11c
> [  192.649058]  drm_sched_main+0x170/0x434
> [  192.649086]  kthread+0x134/0x300
> [  192.649114]  ret_from_fork+0x10/0x20
>
> Fix by calling adreno_system_suspend() in the device_shutdown() path.
>
> [ Applied Rob Clark feedback on fixing adreno_unbind() similarly, also
>   tested as above. ]
>
> Cc: Rob Clark <robdclark@chromium.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ricardo Ribalda <ribalda@chromium.org>
> Cc: Ross Zwisler <zwisler@kernel.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Reviewed-by: Rob Clark <robdclark@gmail.com>

> ---
>  drivers/gpu/drm/msm/adreno/adreno_device.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
> index 628806423f7d..36f062c7582f 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> @@ -551,13 +551,14 @@ static int adreno_bind(struct device *dev, struct device *master, void *data)
>         return 0;
>  }
>
> +static int adreno_system_suspend(struct device *dev);
>  static void adreno_unbind(struct device *dev, struct device *master,
>                 void *data)
>  {
>         struct msm_drm_private *priv = dev_get_drvdata(master);
>         struct msm_gpu *gpu = dev_to_gpu(dev);
>
> -       pm_runtime_force_suspend(dev);
> +       WARN_ON_ONCE(adreno_system_suspend(dev));
>         gpu->funcs->destroy(gpu);
>
>         priv->gpu_pdev = NULL;
> @@ -609,7 +610,7 @@ static int adreno_remove(struct platform_device *pdev)
>
>  static void adreno_shutdown(struct platform_device *pdev)
>  {
> -       pm_runtime_force_suspend(&pdev->dev);
> +       WARN_ON_ONCE(adreno_system_suspend(&pdev->dev));
>  }
>
>  static const struct of_device_id dt_match[] = {
> --
> 2.39.0.314.g84b9a713c41-goog
>

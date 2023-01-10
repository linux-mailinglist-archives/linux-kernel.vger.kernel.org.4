Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEED663D47
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 10:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238274AbjAJJvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 04:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238257AbjAJJuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 04:50:52 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698EB17410
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 01:50:49 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id jn22so12589408plb.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 01:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LFUKQhnlWh+vQvC+BcQrfAAE16ClcsD92Eyht+PMCKI=;
        b=KXfAacA0vhhS3Q50pk9pO89njWnuTfVxUvLVzwZB6HGeMu64LHO+N4lhISy7kif8se
         OwopF8BfSl0ApmJp3wU8pDcULITz0yzez4EbyOiw7ggyIkdUDbYzv61/LQ11ZQWCBnt0
         ZrWrmUr9UENSkhXNwAzbNazZB02ERvf34phUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LFUKQhnlWh+vQvC+BcQrfAAE16ClcsD92Eyht+PMCKI=;
        b=aizpayZJ7CQ3ANFrmejbpYyz7k0G3t/oRJIm7SvqH9U8LF2k5eWkjq+GdSDu0UURO5
         Xovt+deoHRFiUO9rXqZqdLNVsEAV4X110ZWAxNARTSKvjHsFkFgf+hWF0QTrRRIw1wbc
         IESggCn3ld/ahLVJ5P90i925PpoAxzaU5ruXjimYuUbe8lEIUtXG3Em8D2ufikPJfzY5
         YhqjTUe5/L5IEo4vaRA7jUYHuLzvjH80xB5S469rF01T3PLkAPTNP1uTslf3Dd/JEzmM
         VoQetLI91PJCYhix+ykIYrCb6IbjkF5Vv/Qs/enpogbtdNy4nj9IoVvXZdZIwapy5Z5n
         /Uow==
X-Gm-Message-State: AFqh2kq0mJgwcOIZleCbFGoP+yA1O/K+wO8fI3XEebQ+N39enA7DBcnt
        zMvIG+EKKdwDR0SsEeCxSeIlyeHnfiGCqpfcyN8=
X-Google-Smtp-Source: AMrXdXuoKbKI8DQSGfRNw7RBNk5dbj9K2a8/ks1M0Lj7ypErgYpTBFLzLfVaqoxESdp8dU0HUBf5MQ==
X-Received: by 2002:a17:902:9a87:b0:193:37c1:9b0d with SMTP id w7-20020a1709029a8700b0019337c19b0dmr4354765plp.55.1673344248756;
        Tue, 10 Jan 2023 01:50:48 -0800 (PST)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com. [209.85.216.42])
        by smtp.gmail.com with ESMTPSA id d8-20020a170902cec800b00172b87d9770sm7719470plg.81.2023.01.10.01.50.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 01:50:46 -0800 (PST)
Received: by mail-pj1-f42.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so15862007pjj.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 01:50:46 -0800 (PST)
X-Received: by 2002:a17:902:a984:b0:189:d081:1ebb with SMTP id
 bh4-20020a170902a98400b00189d0811ebbmr3482923plb.130.1673344245710; Tue, 10
 Jan 2023 01:50:45 -0800 (PST)
MIME-Version: 1.0
References: <20230109222547.1368644-1-joel@joelfernandes.org>
In-Reply-To: <20230109222547.1368644-1-joel@joelfernandes.org>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 10 Jan 2023 10:50:34 +0100
X-Gmail-Original-Message-ID: <CANiDSCtnu=1+dKgKVBOZoQiDNPidDC=Ocrmy=k7HFPdKQgfaBA@mail.gmail.com>
Message-ID: <CANiDSCtnu=1+dKgKVBOZoQiDNPidDC=Ocrmy=k7HFPdKQgfaBA@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] adreno: Shutdown the GPU properly
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
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
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jan 2023 at 23:25, Joel Fernandes (Google)
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
Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
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


-- 
Ricardo Ribalda

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2EE626B10
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 19:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbiKLSfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 13:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbiKLSfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 13:35:18 -0500
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B3314D1D;
        Sat, 12 Nov 2022 10:35:16 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-13b103a3e5dso8643344fac.2;
        Sat, 12 Nov 2022 10:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d5vdxZQMmvxIfDHl2Grcp/dYFfXeskzhKegPBwxMsEw=;
        b=WMYyJ01JIiVrA6qoU+cmAwDHQAzjTgPP+e5TNAlNwYPH25EIT+qq2Iq3YJCqa4HR7h
         P+US4EuKC2Lc6+qoANk5YEraAO8vCV3pLOW/BywFENBTlApvpo3+6tfPAFe4hw9fPd2f
         JP3ccP3sjqR0MVb9Ki8sGLHghN7OEAja1/Kvm6r3r+xCe83pfB8otrgZLSE2YkmER8O4
         SfGSpNMC7isjUsZ4xaYNqAGMG3SiH34bXIIHOs4dD59833XVSOP2VZBwgDQ7eDTCHV8M
         T+cLj7F/KVAkZrzq+RSIsYZWryhSwuZTjZoS5wWxCzm7tXRD+CljIsoQnLN1M5mujcjE
         v35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d5vdxZQMmvxIfDHl2Grcp/dYFfXeskzhKegPBwxMsEw=;
        b=NfTHRv/0hD2sNDU+u3hRHGBxb7J+31ilOjAP7KFnBsoxwjhI0wqYk2fkf3L1LNOfef
         n2nIYK8F1d13HqaBAMFG8qZAUf8SpDzpcbgB4IOR55Ul8GIXl6GX9bGGLy1SuTlQBFlv
         UopnE7IYb30BmrALOUYQyRofFwe6bpUfgVE+Tvg0JGYmxnd2Hc702vMvI5NxpAc15Vk5
         5yFi9fTlUR1Lfn8za3uFxfA91rpCp10F2Yt6aEEJEGn8y66g+7uTXbCN4qmZSIVwykTN
         n4JFVCHsVK099Fmynvc1XXdTri6mYrQTy4YMPe3cU9spkmtPh8rRHmnjdV7ziXms884Z
         HHYw==
X-Gm-Message-State: ANoB5pkyv90fnl8clyW0AIg8q64NQHtqPa474/ifOB64xXcOG8LIvpqz
        CsGTCCaShpqs9jkL6mMfu1kCnTXwPpeBnZYDN4J/h887H4c=
X-Google-Smtp-Source: AA0mqf7kihvVpfJP9izkq0AMhaawtXqOsBkR4pGYQuWbsKt9hYS3NZYPeJiSXwblnXAMOMYFSCeQDMndtqzlyWGwVdM=
X-Received: by 2002:a05:6870:b87:b0:13d:51fe:3404 with SMTP id
 lg7-20020a0568700b8700b0013d51fe3404mr3682552oab.183.1668278115223; Sat, 12
 Nov 2022 10:35:15 -0800 (PST)
MIME-Version: 1.0
References: <20221111194957.4046771-1-joel@joelfernandes.org>
 <20221111194957.4046771-2-joel@joelfernandes.org> <899db0f8-7b8a-ed8f-30b8-4f630da1298d@quicinc.com>
In-Reply-To: <899db0f8-7b8a-ed8f-30b8-4f630da1298d@quicinc.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Sat, 12 Nov 2022 10:35:35 -0800
Message-ID: <CAF6AEGtEswqCRXkrd+tWKb_1N1UXgQ=EVMTZAgxxpNcD2vYGHQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] adreno: Detect shutdown during get_param()
To:     Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Ross Zwisler <zwisler@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        dri-devel@lists.freedesktop.org, Emma Anholt <emma@anholt.net>,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Sean Paul <sean@poorly.run>,
        Vladimir Lypak <vladimir.lypak@gmail.com>
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

On Fri, Nov 11, 2022 at 1:28 PM Akhil P Oommen <quic_akhilpo@quicinc.com> wrote:
>
> On 11/12/2022 1:19 AM, Joel Fernandes (Google) wrote:
> > Even though the GPU is shut down, during kexec reboot we can have userspace
> > still running. This is especially true if KEXEC_JUMP is not enabled, because we
> > do not freeze userspace in this case.
> >
> > To prevent crashes, track that the GPU is shutdown and prevent get_param() from
> > accessing GPU resources if we find it shutdown.
> >
> > This fixes the following crash during kexec reboot on an ARM64 device with adreno GPU:
> >
> > [  292.534314] Kernel panic - not syncing: Asynchronous SError Interrupt
> > [  292.534323] Hardware name: Google Lazor (rev3 - 8) with LTE (DT)
> > [  292.534326] Call trace:
> > [  292.534328]  dump_backtrace+0x0/0x1d4
> > [  292.534337]  show_stack+0x20/0x2c
> > [  292.534342]  dump_stack_lvl+0x60/0x78
> > [  292.534347]  dump_stack+0x18/0x38
> > [  292.534352]  panic+0x148/0x3b0
> > [  292.534357]  nmi_panic+0x80/0x94
> > [  292.534364]  arm64_serror_panic+0x70/0x7c
> > [  292.534369]  do_serror+0x0/0x7c
> > [  292.534372]  do_serror+0x54/0x7c
> > [  292.534377]  el1h_64_error_handler+0x34/0x4c
> > [  292.534381]  el1h_64_error+0x7c/0x80
> > [  292.534386]  el1_interrupt+0x20/0x58
> > [  292.534389]  el1h_64_irq_handler+0x18/0x24
> > [  292.534395]  el1h_64_irq+0x7c/0x80
> > [  292.534399]  local_daif_inherit+0x10/0x18
> > [  292.534405]  el1h_64_sync_handler+0x48/0xb4
> > [  292.534410]  el1h_64_sync+0x7c/0x80
> > [  292.534414]  a6xx_gmu_set_oob+0xbc/0x1fc
> > [  292.534422]  a6xx_get_timestamp+0x40/0xb4
> > [  292.534426]  adreno_get_param+0x12c/0x1e0
> > [  292.534433]  msm_ioctl_get_param+0x64/0x70
> > [  292.534440]  drm_ioctl_kernel+0xe8/0x158
> > [  292.534448]  drm_ioctl+0x208/0x320
> > [  292.534453]  __arm64_sys_ioctl+0x98/0xd0
> > [  292.534461]  invoke_syscall+0x4c/0x118
> > [  292.534467]  el0_svc_common+0x98/0x104
> > [  292.534473]  do_el0_svc+0x30/0x80
> > [  292.534478]  el0_svc+0x20/0x50
> > [  292.534481]  el0t_64_sync_handler+0x78/0x108
> > [  292.534485]  el0t_64_sync+0x1a4/0x1a8
> > [  292.534632] Kernel Offset: 0x1a5f800000 from 0xffffffc008000000
> > [  292.534635] PHYS_OFFSET: 0x80000000
> > [  292.534638] CPU features: 0x40018541,a3300e42
> > [  292.534644] Memory Limit: none
> >
> > Cc: Rob Clark <robdclark@chromium.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Ricardo Ribalda <ribalda@chromium.org>
> > Cc: Ross Zwisler <zwisler@kernel.org>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >   drivers/gpu/drm/msm/adreno/adreno_device.c | 1 +
> >   drivers/gpu/drm/msm/adreno/adreno_gpu.c    | 2 +-
> >   drivers/gpu/drm/msm/msm_gpu.h              | 3 +++
> >   3 files changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
> > index f0cff62812c3..03d912dc0130 100644
> > --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> > +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> > @@ -612,6 +612,7 @@ static void adreno_shutdown(struct platform_device *pdev)
> >   {
> >       struct msm_gpu *gpu = dev_to_gpu(&pdev->dev);
> >
> > +     gpu->is_shutdown = true;
> >       WARN_ON_ONCE(adreno_system_suspend(&pdev->dev));
> >   }
> >
> > diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> > index 382fb7f9e497..6903c6892469 100644
> > --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> > +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> > @@ -251,7 +251,7 @@ int adreno_get_param(struct msm_gpu *gpu, struct msm_file_private *ctx,
> >       struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
> >
> >       /* No pointer params yet */
> > -     if (*len != 0)
> > +     if (*len != 0 || gpu->is_shutdown)
> >               return -EINVAL;
> This will race with shutdown. Probably, propagating back the return
> value of pm_runtime_get() in every possible ioctl call path is the right
> thing to do.
>
> I have never thought about this scenario. Do you know why userspace is
> not freezed before kexec?

So userspace not being frozen seems like the root issue, and is likely
to cause all sorts of other whack-a-mole problems.  I guess I'd like
to know if this is the expected behavior?

If so, we should probably look at
drm_dev_is_unplugged()/drm_dev_unplug()/etc rather than trying to NIH
that mechanism.  We would need to sprinkle drm_dev_is_unplugged()
checks more widely, and also ensure that the scheduler kthread(s) gets
parked.  But it would be nice to know first if we are just trying to
paper over a kexec bug.

BR,
-R

>
> -Akhil.
> >
> >       switch (param) {
> > diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
> > index ff911e7305ce..f18b0a91442b 100644
> > --- a/drivers/gpu/drm/msm/msm_gpu.h
> > +++ b/drivers/gpu/drm/msm/msm_gpu.h
> > @@ -214,6 +214,9 @@ struct msm_gpu {
> >       /* does gpu need hw_init? */
> >       bool needs_hw_init;
> >
> > +     /* is the GPU shutdown? */
> > +     bool is_shutdown;
> > +
> >       /**
> >        * global_faults: number of GPU hangs not attributed to a particular
> >        * address space
>

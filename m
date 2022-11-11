Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42EC626365
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 22:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234246AbiKKVJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 16:09:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbiKKVJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 16:09:01 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1062FE023
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 13:09:00 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id z1so3709727qkl.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 13:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bROYZrzq8ksP4Ro+JNVkWP32z7zm0wBccnD8PyVknkk=;
        b=nnNe6gIiX2oaJmMb0Zf+A6eMK1xh+WidduaPO1APzWsmzR/WCGTZvKoC2MFvWTC5yQ
         lzF5sfanzcorSiYUaKg0niNGR66cSg8vwCgaur30DRHNRQy0pmAfjBA9867XTLqgo2P0
         +S70VUtDTDMX7CutNc/jmMmE8OXtIhYKQvuV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bROYZrzq8ksP4Ro+JNVkWP32z7zm0wBccnD8PyVknkk=;
        b=xOf4CxofQdUV+Mf64pgCQD73PToNo9WZBoxxJP1PPEkxHIbW2HQf0KUux7BJZmO6Rn
         fcB39hHVPI67sl1ukFXi7+luUQpFv6RTHBiUDfE5IZAqbq07WnHeYzhQeI6yADwbJc6q
         Z5/4JX4jG2yy959EoejaRmDk/PxAWQ0FM+z/6+3gnYX5bspKPTeJUcc7qOiNc8h6W3As
         chY6psiFh1COEq49xD51MfY8BVkj4hwoWqGdye6jsLs419zctc4KpGj6HF/pd8+sfRLM
         VRx1BZfkljkUeihH6EH+IswF8lTFSFDUXQIycaz3J4xJ+zPOGhhE7goO40oe7zJuLrjZ
         uB2A==
X-Gm-Message-State: ANoB5pmq/nq2WnYuy9F6TjW2kIwJu+X6xgBYugrNFs9NLYrGCgWk3xeg
        4bGd9D045tyOk3Ck1UPZkRmQlEOWfRiryQ==
X-Google-Smtp-Source: AA0mqf64fIUX0YyuVZ6OqIhrI44mQQVYhld8dPGWlO9tJrLDTHPJl6XGChWD9oWvVJnXwRNZtzEcJw==
X-Received: by 2002:a37:8004:0:b0:6fa:26d8:77d with SMTP id b4-20020a378004000000b006fa26d8077dmr2806945qkd.354.1668200939133;
        Fri, 11 Nov 2022 13:08:59 -0800 (PST)
Received: from smtpclient.apple (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id x28-20020a05620a01fc00b006ed30a8fb21sm1948568qkn.76.2022.11.11.13.08.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 13:08:57 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/2] adreno: Shutdown the GPU properly
Date:   Fri, 11 Nov 2022 16:08:56 -0500
Message-Id: <B336E259-FB18-4E16-8BC7-2117614ABE4D@joelfernandes.org>
References: <20221111194957.4046771-1-joel@joelfernandes.org>
Cc:     Rob Clark <robdclark@chromium.org>,
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
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Vladimir Lypak <vladimir.lypak@gmail.com>
In-Reply-To: <20221111194957.4046771-1-joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
X-Mailer: iPhone Mail (19G82)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 11, 2022, at 2:50 PM, Joel Fernandes (Google) <joel@joelfernandes.o=
rg> wrote:
>=20
> =EF=BB=BFDuring kexec on ARM device, we notice that device_shutdown() only=
 calls
> pm_runtime_force_suspend() while shutting down the GPU. This means the GPU=

> kthread is still running and further, there maybe active submits.
>=20
> This causes all kinds of issues during a kexec reboot:
>=20
> Warning from shutdown path:
>=20
> [  292.509662] WARNING: CPU: 0 PID: 6304 at [...] adreno_runtime_suspend+0=
x3c/0x44
> [  292.509863] Hardware name: Google Lazor (rev3 - 8) with LTE (DT)
> [  292.509872] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
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
>=20
> And here from GPU kthread, an SError OOPs:
>=20
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
>=20
> Fix by calling adreno_system_suspend() in the device_shutdown() path.
>=20
> Cc: Rob Clark <robdclark@chromium.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ricardo Ribalda <ribalda@chromium.org>
> Cc: Ross Zwisler <zwisler@kernel.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
> drivers/gpu/drm/msm/adreno/adreno_device.c | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/=
msm/adreno/adreno_device.c
> index 24b489b6129a..f0cff62812c3 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> @@ -607,9 +607,12 @@ static int adreno_remove(struct platform_device *pdev=
)
>    return 0;
> }
>=20
> +static int adreno_system_suspend(struct device *dev);
> static void adreno_shutdown(struct platform_device *pdev)
> {
> -    pm_runtime_force_suspend(&pdev->dev);
> +    struct msm_gpu *gpu =3D dev_to_gpu(&pdev->dev);
> +

This local variable definition should go to patch 2/2. Will fix in v2.

Thanks,

 - Joel


> +    WARN_ON_ONCE(adreno_system_suspend(&pdev->dev));
> }
>=20
> static const struct of_device_id dt_match[] =3D {
> --=20
> 2.38.1.493.g58b659f92b-goog
>=20

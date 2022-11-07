Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3CF620026
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 22:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbiKGVDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 16:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233189AbiKGVDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 16:03:45 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCAC12A93
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 13:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1667855015; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tDDMWehjStUKzxDj8AQ3yj4jAUcHg/wL+FdI4UGEYak=;
        b=tF2tE0ECl5xddLeriyqewGoNdsb1ah7nWOtlBzty7Z9VFPnvW1mRRdA9YkjqCfm2gPN1p0
        39DWKJmDNuNEFEAjoee2BKdESSLjZmsap5+07ciQXRhKF1yvqkxRFKFd6T98WME1ZNL0+j
        zsafOP+xHMGkY6KpeUiOLfw0tbosStc=
Date:   Mon, 07 Nov 2022 21:03:22 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 12/26] drm: etnaviv: Remove #ifdef guards for PM related
 functions
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        etnaviv@lists.freedesktop.org
Message-Id: <M5XZKR.3DW6QGFX6KVP1@crapouillou.net>
In-Reply-To: <d63e2214c464b029a15967d81968c27a5a4a88d4.camel@pengutronix.de>
References: <20221107175106.360578-1-paul@crapouillou.net>
        <20221107175256.360839-1-paul@crapouillou.net>
        <20221107175256.360839-2-paul@crapouillou.net>
        <d63e2214c464b029a15967d81968c27a5a4a88d4.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lucas,

Le lun. 7 nov. 2022 =E0 19:07:32 +0100, Lucas Stach=20
<l.stach@pengutronix.de> a =E9crit :
> Am Montag, dem 07.11.2022 um 17:52 +0000 schrieb Paul Cercueil:
>>  Use the RUNTIME_PM_OPS() and pm_ptr() macros to handle the
>>  .runtime_suspend/.runtime_resume callbacks.
>>=20
>>  These macros allow the suspend and resume functions to be=20
>> automatically
>>  dropped by the compiler when CONFIG_PM is disabled, without having
>>  to use #ifdef guards.
>>=20
>>  This has the advantage of always compiling these functions in,
>>  independently of any Kconfig option. Thanks to that, bugs and other
>>  regressions are subsequently easier to catch.
>>=20
>>  Some #ifdef CONFIG_PM guards were protecting simple statements, and=20
>> were
>>  also converted to "if (IS_ENABLED(CONFIG_PM))".
>>=20
> Reasoning and the change itself look good.

That's an ack? :)

>>  Note that this driver should probably use the
>>  DEFINE_RUNTIME_DEV_PM_OPS() macro instead, which will provide
>>  .suspend/.resume callbacks, pointing to pm_runtime_force_suspend()=20
>> and
>>  pm_runtime_force_resume() respectively; unless those callbacks=20
>> really
>>  aren't needed.
>=20
> This however isn't true, specifically this driver can _not_ use
> pm_runtime_force_suspend, as the GPU can't be forced into suspend by
> calling the rpm callback. A real suspend implementation would first
> need to make sure the GPU finished working on the current queued jobs,
> only then it would be able to power it down via the rpm suspend
> callback.

Understood. I'll remove this paragraph if I have to V2.

Cheers,
-Paul

>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>  Cc: Lucas Stach <l.stach@pengutronix.de>
>>  Cc: Russell King <linux+etnaviv@armlinux.org.uk>
>>  Cc: Christian Gmeiner <christian.gmeiner@gmail.com>
>>  Cc: etnaviv@lists.freedesktop.org
>>  ---
>>   drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 30=20
>> +++++++++++----------------
>>   1 file changed, 12 insertions(+), 18 deletions(-)
>>=20
>>  diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c=20
>> b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
>>  index 37018bc55810..e9a5444ec1c7 100644
>>  --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
>>  +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
>>  @@ -1605,7 +1605,6 @@ static int etnaviv_gpu_hw_suspend(struct=20
>> etnaviv_gpu *gpu)
>>   	return etnaviv_gpu_clk_disable(gpu);
>>   }
>>=20
>>  -#ifdef CONFIG_PM
>>   static int etnaviv_gpu_hw_resume(struct etnaviv_gpu *gpu)
>>   {
>>   	int ret;
>>  @@ -1621,7 +1620,6 @@ static int etnaviv_gpu_hw_resume(struct=20
>> etnaviv_gpu *gpu)
>>=20
>>   	return 0;
>>   }
>>  -#endif
>>=20
>>   static int
>>   etnaviv_gpu_cooling_get_max_state(struct thermal_cooling_device=20
>> *cdev,
>>  @@ -1689,11 +1687,10 @@ static int etnaviv_gpu_bind(struct device=20
>> *dev, struct device *master,
>>   	if (ret)
>>   		goto out_workqueue;
>>=20
>>  -#ifdef CONFIG_PM
>>  -	ret =3D pm_runtime_get_sync(gpu->dev);
>>  -#else
>>  -	ret =3D etnaviv_gpu_clk_enable(gpu);
>>  -#endif
>>  +	if (IS_ENABLED(CONFIG_PM))
>>  +		ret =3D pm_runtime_get_sync(gpu->dev);
>>  +	else
>>  +		ret =3D etnaviv_gpu_clk_enable(gpu);
>>   	if (ret < 0)
>>   		goto out_sched;
>>=20
>>  @@ -1737,12 +1734,12 @@ static void etnaviv_gpu_unbind(struct=20
>> device *dev, struct device *master,
>>=20
>>   	etnaviv_sched_fini(gpu);
>>=20
>>  -#ifdef CONFIG_PM
>>  -	pm_runtime_get_sync(gpu->dev);
>>  -	pm_runtime_put_sync_suspend(gpu->dev);
>>  -#else
>>  -	etnaviv_gpu_hw_suspend(gpu);
>>  -#endif
>>  +	if (IS_ENABLED(CONFIG_PM)) {
>>  +		pm_runtime_get_sync(gpu->dev);
>>  +		pm_runtime_put_sync_suspend(gpu->dev);
>>  +	} else {
>>  +		etnaviv_gpu_hw_suspend(gpu);
>>  +	}
>>=20
>>   	if (gpu->mmu_context)
>>   		etnaviv_iommu_context_put(gpu->mmu_context);
>>  @@ -1856,7 +1853,6 @@ static int etnaviv_gpu_platform_remove(struct=20
>> platform_device *pdev)
>>   	return 0;
>>   }
>>=20
>>  -#ifdef CONFIG_PM
>>   static int etnaviv_gpu_rpm_suspend(struct device *dev)
>>   {
>>   	struct etnaviv_gpu *gpu =3D dev_get_drvdata(dev);
>>  @@ -1899,18 +1895,16 @@ static int etnaviv_gpu_rpm_resume(struct=20
>> device *dev)
>>=20
>>   	return 0;
>>   }
>>  -#endif
>>=20
>>   static const struct dev_pm_ops etnaviv_gpu_pm_ops =3D {
>>  -	SET_RUNTIME_PM_OPS(etnaviv_gpu_rpm_suspend,=20
>> etnaviv_gpu_rpm_resume,
>>  -			   NULL)
>>  +	RUNTIME_PM_OPS(etnaviv_gpu_rpm_suspend, etnaviv_gpu_rpm_resume,=20
>> NULL)
>>   };
>>=20
>>   struct platform_driver etnaviv_gpu_driver =3D {
>>   	.driver =3D {
>>   		.name =3D "etnaviv-gpu",
>>   		.owner =3D THIS_MODULE,
>>  -		.pm =3D &etnaviv_gpu_pm_ops,
>>  +		.pm =3D pm_ptr(&etnaviv_gpu_pm_ops),
>>   		.of_match_table =3D etnaviv_gpu_match,
>>   	},
>>   	.probe =3D etnaviv_gpu_platform_probe,
>=20
>=20



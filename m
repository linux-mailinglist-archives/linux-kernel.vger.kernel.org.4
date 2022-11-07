Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEF161FED6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 20:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbiKGToa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 14:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbiKGTo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 14:44:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D21BFC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 11:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667850208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T+MYGNwBR+Rwvao8mlrqDH2JgeLYoIf95UPfWCfEU38=;
        b=CecgA0lpD7yyA/GY5HFqa0Uc5bFPWMB85FepJvjO53iWsEggQQw+swVI6RRhnTzxaDIoND
        rgG5j6UCBf+vZjVB0DBtzbvZNghaWWN3Szfx8pfTzkgsrerbjtqd+dWm3IBvjjJlNDYnoF
        8uw16eAxDfYf5BReRZigcDbu1MVeyiM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-59-d2R_v86yO6-GuKWsBiSgkw-1; Mon, 07 Nov 2022 14:43:26 -0500
X-MC-Unique: d2R_v86yO6-GuKWsBiSgkw-1
Received: by mail-ej1-f72.google.com with SMTP id hb35-20020a170907162300b007ae6746f240so1944162ejc.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 11:43:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T+MYGNwBR+Rwvao8mlrqDH2JgeLYoIf95UPfWCfEU38=;
        b=O+Sngh//uxKPfhPltokKH8+SIl4GNDMktw06OTC2Y+olcbsgxCk5e+Qe0Bhqiw5/Qk
         Bp64MG4vLLF51SRtZz8Cxs+pfaGFOKMWm0YkWPHhzIkvzA9GaEl+PyHhl/sfjDmj8FRK
         BaFX0STx4YHfSZAWVaCVUWhRNtrVt9UDUno2/rDZeE5yy0I2+P2QUIptfoHnxWm0L6r9
         OV3cGAV8zOCRZCRknJLSUQczr9ljpGQD2RDUDSGA4tg+tQAEeF8/I5NiMtHvAy2blath
         BstGcVBY1p5U0+DQIF9vklE8QbwbktONZLy/TmSvQeM73R7viEb9GNpa64x2lgmAcRo8
         7HeQ==
X-Gm-Message-State: ACrzQf12WofG3m/uOwzFla6EqCCr+FCE/UQZKAnM08pnMiXt0Z14a4gr
        Kvs7wtVemxag0M13LukSCCfrnuIUXldJC2AZGzjEUkUzbONEN96Lc5V86MSEGQ7PkZpOSZg185L
        CNr1LvQkjtQtzSVnIdLlOKSG/
X-Received: by 2002:a17:907:843:b0:73a:5b0e:8352 with SMTP id ww3-20020a170907084300b0073a5b0e8352mr50156240ejb.438.1667850205647;
        Mon, 07 Nov 2022 11:43:25 -0800 (PST)
X-Google-Smtp-Source: AMsMyM5XGEYvVOH24leZFvJk1jRnNxFGb8iDc1hjDsapTa1/D/RlUw0BoWIqz6C4vc7/k6hNl7gtEA==
X-Received: by 2002:a17:907:843:b0:73a:5b0e:8352 with SMTP id ww3-20020a170907084300b0073a5b0e8352mr50156220ejb.438.1667850205421;
        Mon, 07 Nov 2022 11:43:25 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id et19-20020a170907295300b0077205dd15basm3807232ejc.66.2022.11.07.11.43.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 11:43:24 -0800 (PST)
Message-ID: <d2dd6f25-222e-322b-8af9-25d844224c75@redhat.com>
Date:   Mon, 7 Nov 2022 20:43:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 22/26] drm: vboxvideo: Remove #ifdef guards for PM related
 functions
To:     Paul Cercueil <paul@crapouillou.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20221107175106.360578-1-paul@crapouillou.net>
 <20221107175256.360839-1-paul@crapouillou.net>
 <20221107175256.360839-12-paul@crapouillou.net>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221107175256.360839-12-paul@crapouillou.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/7/22 18:52, Paul Cercueil wrote:
> Use the pm_sleep_ptr() macro to handle the .suspend / .resume callbacks.
> 
> This macro allows the suspend and resume functions to be automatically
> dropped by the compiler when CONFIG_SUSPEND is disabled, without having
> to use #ifdef guards.
> 
> This has the advantage of always compiling these functions in,
> independently of any Kconfig option. Thanks to that, bugs and other
> regressions are subsequently easier to catch.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> Cc: Hans de Goede <hdegoede@redhat.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/gpu/drm/vboxvideo/vbox_drv.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vboxvideo/vbox_drv.c b/drivers/gpu/drm/vboxvideo/vbox_drv.c
> index f4f2bd79a7cb..79318441ed7e 100644
> --- a/drivers/gpu/drm/vboxvideo/vbox_drv.c
> +++ b/drivers/gpu/drm/vboxvideo/vbox_drv.c
> @@ -102,7 +102,6 @@ static void vbox_pci_remove(struct pci_dev *pdev)
>  	vbox_hw_fini(vbox);
>  }
>  
> -#ifdef CONFIG_PM_SLEEP
>  static int vbox_pm_suspend(struct device *dev)
>  {
>  	struct vbox_private *vbox = dev_get_drvdata(dev);
> @@ -160,16 +159,13 @@ static const struct dev_pm_ops vbox_pm_ops = {
>  	.poweroff = vbox_pm_poweroff,
>  	.restore = vbox_pm_resume,
>  };
> -#endif
>  
>  static struct pci_driver vbox_pci_driver = {
>  	.name = DRIVER_NAME,
>  	.id_table = pciidlist,
>  	.probe = vbox_pci_probe,
>  	.remove = vbox_pci_remove,
> -#ifdef CONFIG_PM_SLEEP
> -	.driver.pm = &vbox_pm_ops,
> -#endif
> +	.driver.pm = pm_sleep_ptr(&vbox_pm_ops),
>  };
>  
>  DEFINE_DRM_GEM_FOPS(vbox_fops);


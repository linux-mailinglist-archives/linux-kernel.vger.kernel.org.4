Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE8F6A58BC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 12:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjB1L7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 06:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjB1L73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 06:59:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1147E2364A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 03:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677585520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=igXe/9x6jKu5rbYdkW8/4YE+XBhlQH3c260qTWOAdLI=;
        b=VxoUsGbBq4jE2+fAKyxsV7qvv4tKbrLTq4ixtrZYm/Le8sCHxrv+PcLBFf9b3rByo5Ha6W
        DJwc7pkSGLPHiEl9kstWLDaCohTxoeHuYG4uByJzp8n5dCPygM5qN3LzxvQpukV34ssfLV
        xwJZkzlxw8UzpRs1qRvV0j8wrWUTvz8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-526-JaqTbu6PO3C_1mD4_w47Yw-1; Tue, 28 Feb 2023 06:58:38 -0500
X-MC-Unique: JaqTbu6PO3C_1mD4_w47Yw-1
Received: by mail-wm1-f69.google.com with SMTP id t1-20020a7bc3c1000000b003dfe223de49so6790486wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 03:58:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677585518;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=igXe/9x6jKu5rbYdkW8/4YE+XBhlQH3c260qTWOAdLI=;
        b=mvO9VsVXEm1n40o/zwMtO0jGiqV+AK2sHJH0yfeKw84lrqXgjHKdPlGl8yyTIJQsYe
         1rjHzL9r2dUy/3b1HZsdsr4v4ITGunMCWb+jXQ2pZ+ViKPOzASwUoGeahRtt2ocDb7Tk
         CIKe7aX4hnCsY7mD+KdG0SzwdIYTNmDwX/HQJAaHTEIGz5wr3CzOXBWGMj0C4yzF8xRX
         6RRCE0DPq0nQ7nFiU6xcPma6EyERFEqD8LSRJ6lILG6Vgp4z8RgLaFDIZBMR/Y4lO9ot
         Dsqs8sOqLdAM8UAM5veP7lHpLRlRptkcm026OaBu9FPnEsBqLO79u1zZohK+43OemSha
         hPRA==
X-Gm-Message-State: AO0yUKWXsJNNNgA6T5AjerqxHOf7TDUikRVHuzOy5jEOjOguBSoy+/YD
        fb1h7j4IjJK3XQQAi7UNfws0Iq1+zEGgc81WEThvhsZmCudLgWgxQfNm19ExsMsIz1MwnU3sRc/
        OGcLmWiNrzudaqOgJRdQsi30v
X-Received: by 2002:a05:600c:30d3:b0:3eb:376e:2b9c with SMTP id h19-20020a05600c30d300b003eb376e2b9cmr1757792wmn.36.1677585517831;
        Tue, 28 Feb 2023 03:58:37 -0800 (PST)
X-Google-Smtp-Source: AK7set9vfqp+w/Fq0Ru6ZcWshr4cD9JM+oi0fjZfEmOzrz/RJhaLD8ynMHaAjx0sjRa2QEfWdI63KA==
X-Received: by 2002:a05:600c:30d3:b0:3eb:376e:2b9c with SMTP id h19-20020a05600c30d300b003eb376e2b9cmr1757776wmn.36.1677585517487;
        Tue, 28 Feb 2023 03:58:37 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i2-20020adfdec2000000b002c71dd1109fsm9582519wrn.47.2023.02.28.03.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 03:58:37 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Rob Clark <robdclark@gmail.com>
Cc:     Rob Clark <robdclark@chromium.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Ryan Neph <ryanneph@chromium.org>,
        David Airlie <airlied@redhat.com>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH] drm/virtio: Add option to disable KMS support
In-Reply-To: <9631930e-3826-ded7-1a45-1d0a285c5195@suse.de>
References: <20230224180225.2477641-1-robdclark@gmail.com>
 <20230227063821.dg2gbjjwcekbxyzw@sirius.home.kraxel.org>
 <CAF6AEGsv1G7CPSkCPe3iHGB9JEO4iy+bTbkFLoitmx64U78RJw@mail.gmail.com>
 <20230228062809.ccyzgnvizh6jidn4@sirius.home.kraxel.org>
 <87a60yywo0.fsf@minerva.mail-host-address-is-not-set>
 <9631930e-3826-ded7-1a45-1d0a285c5195@suse.de>
Date:   Tue, 28 Feb 2023 12:58:36 +0100
Message-ID: <87pm9uxaqb.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Hi
>
> Am 28.02.23 um 10:19 schrieb Javier Martinez Canillas:
>> Gerd Hoffmann <kraxel@redhat.com> writes:
> [...]
>>>
>>> I think it is a bad idea to make that a compile time option, I'd suggest
>>> a runtime switch instead, for example a module parameter to ask the
>>> driver to ignore any scanouts.
>>>
>> 
>> I don't think there's a need for a new module parameter, there's already
>> the virtio-gpu 'modeset' module parameter to enable/disable modsetting
>> and the global 'nomodeset' kernel cmdline parameter to do it for all DRM
>> drivers.
>> 
>> Currently, many drivers just fail to probe when 'nomodeset' is present,
>> but others only disable modsetting but keep the rendering part. In fact,
>> most DRM only drivers just ignore the 'nomodeset' parameter.
>
> Do you have a list of these drivers? Maybe we need to adjust semantics 
> slightly. Please see my comment below.
>

AFAIK i915 and nouveau do this. But also on the rpi4 only the vc4 display
driver is disabled but the v3d driver used for rendering is not disabled.

So the 'nomodeset' semantics are not consistent across all DRM drivers.

[...]

>> -	if (virtio_gpu_modeset == 0)
>> -		return -EINVAL;
>> +	if ((drm_firmware_drivers_only() && virtio_gpu_modeset == -1) ||
>> +	    (virtio_gpu_modeset == 0))
>> +		driver.driver_features &= ~(DRIVER_MODESET | DRIVER_ATOMIC);
>
> The kernel-wide option 'nomodeset' affects system behavior. It's a 
> misnomer, as it actually means 'don't replace the firmware-provided 
> framebuffer.' So if you just set these flags here, virtio-gpu would 
> later remove the firmware driver via aperture helpers. Therefore, if 
> drm_formware_drivers_only() returns true, we should fail probing with 
> -ENODEV.
>

Right. Or the DRM aperture helper shouldn't attempt to remove the firmware
provided framebuffer if the DRM driver doesn't have the DRIVER_MODESET set.

> But we could try to repurpose the module's 'modeset' option. It's 
> already obsoleted by nomodeset anyway.  I'd try to make modeset it a 
> boolean that controls modesetting vs render-only. It will then be about 
> the driver's feature set, rather than system behavior.
>

Yes, that could work too. Dmitry mentioned that Rob wanted the compile-time
option to reduce the attack surface area. I don't have a strong opinion on
this, but just wanted to point out that there wasn't a need for a new param
and that the existing module's 'modeset' could be repurposed for this case.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


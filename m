Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6665638744
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 11:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiKYKUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 05:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiKYKUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 05:20:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03AA3FBA4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 02:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669371585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bY19rPV8ppg6ZUdn2yxRqF47aTG2fFJ0ZNtqig4Q8uo=;
        b=GKZEQYHwBtT0I7Nt6YqDVZvUfrtodsXenJ/vU/TfAbqidrwC4g67w4lmVgjR7yuWCki6u3
        +8S76Q30NhzHJJY1ATn2rvomdpHSDZHRa/u9O+W0QkJUDi0ED8CLYlGJBryEYVMJGLpWRx
        1OJjhVFps4TCNROx16mGo4SA1WkPOWY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-587-y1rxzPk3MrSSrEP-z18TUA-1; Fri, 25 Nov 2022 05:19:43 -0500
X-MC-Unique: y1rxzPk3MrSSrEP-z18TUA-1
Received: by mail-wm1-f70.google.com with SMTP id v188-20020a1cacc5000000b003cf76c4ae66so3981017wme.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 02:19:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bY19rPV8ppg6ZUdn2yxRqF47aTG2fFJ0ZNtqig4Q8uo=;
        b=iPjg73L17Dnnx2TrL9f4NERL3aJkw0MPt9+HM1hR/u62r93QVx8/MFAfAT11Az4YDT
         WGSWocdhl64KWVK5AdZRf2LHRJ6qYhBl03pC4tapcXtfk+zzgpIlaEvAUJgqzmOxuNUb
         YtIpZeY8Jc/U2AkT0qHCrpfi4LmBszl+zx7Zu1sCNj1R8Ap3qoA2vdlJ+pP0GV9IiOKL
         02Iznu/HEv8EL4nbICG93yeHxCH5IiySnYff0HE26+r3GXZmVNdvZIloASDv208qTK6m
         LqU3IkOrLG96CvnjUlHRqpBZq6DZgELwHEY0O3beYdgzAAbI3b5FWzGY+sCTeW+xb5Uv
         U5Ew==
X-Gm-Message-State: ANoB5pmfvVd5ScZsQI5za0y/2fTgyQzIM7jmt483ifReiIONyPkpxrWi
        dUvxoDVlWHCaim7OsHrQt18EMo81With+q1zfqixDVkjaJRicUcWrCZTMYrU4oOirq9c/VypH0U
        cLeVHf/irvLxhYc5z7LMUGaC9
X-Received: by 2002:adf:f189:0:b0:241:bc9e:a238 with SMTP id h9-20020adff189000000b00241bc9ea238mr12437037wro.558.1669371581918;
        Fri, 25 Nov 2022 02:19:41 -0800 (PST)
X-Google-Smtp-Source: AA0mqf733o27EIhWoSlUjNsa9tcFhysJWN14yjguQxBT++y7CLSBTY7xXokXb5BEj/8z8JRbucHxIA==
X-Received: by 2002:adf:f189:0:b0:241:bc9e:a238 with SMTP id h9-20020adff189000000b00241bc9ea238mr12437025wro.558.1669371581684;
        Fri, 25 Nov 2022 02:19:41 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id u10-20020a05600c19ca00b003c5571c27a1sm6216386wmq.32.2022.11.25.02.19.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 02:19:41 -0800 (PST)
Message-ID: <68ad39a2-e47c-ffcb-34ad-ea680beac59c@redhat.com>
Date:   Fri, 25 Nov 2022 11:19:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 05/24] drm/tests: helpers: Make sure the device is bound
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>,
        Maxime Ripard <mripard@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     David Gow <davidgow@google.com>, linaro-mm-sig@lists.linaro.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org,
        =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>,
        linux-media@vger.kernel.org, kunit-dev@googlegroups.com,
        dri-devel@lists.freedesktop.org,
        Brendan Higgins <brendan.higgins@linux.dev>,
        linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>
References: <20221123-rpi-kunit-tests-v1-0-051a0bb60a16@cerno.tech>
 <20221123-rpi-kunit-tests-v1-5-051a0bb60a16@cerno.tech>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221123-rpi-kunit-tests-v1-5-051a0bb60a16@cerno.tech>
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

On 11/23/22 16:25, Maxime Ripard wrote:
> The device managed resources are freed when the device is detached, so
> it has to be bound in the first place.
> 
> Let's create a fake driver that we will bind to our fake device to
> benefit from the device managed cleanups in our tests.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  drivers/gpu/drm/tests/drm_kunit_helpers.c | 60 +++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>

If I understood the platform core code correctly, the probe is always sync in
the case of platform drivers. Unless .probe_type = PROBE_PREFER_ASYNCHRONOUS is
set or a module is loaded using with the "async_probe=1" parameter. So I believe
the wait queue won't be needed. The only DRM driver that forces an async probe is
drivers/gpu/drm/hyperv/hyperv_drm_drv.c AFAICT.

So I would drop this patch from the set for now.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


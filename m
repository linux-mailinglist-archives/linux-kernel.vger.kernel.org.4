Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2A2630E52
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 12:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbiKSLOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 06:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbiKSLOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 06:14:21 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D2B8480E
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 03:14:18 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id t4so5361919wmj.5
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 03:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kps69tN39yVhwjocvOXjKavoHJUhr9tWlGOqxcC1CAY=;
        b=joT9MuK36Ii2EIAjhQ2T1REDguQ+CgbYsPaVu+t03L5XPLGRJwKzeoYN5ssRxaEgug
         abrCrVpNcfw7M6lFOX1ojViMXnEoUD4VDi1Scx4uuBjOPPXxo3I7qwNA4Ne0+Wbo0rXP
         toKhxSZOPPQjf86/VfgjvTgoyddw5V3c4rNOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kps69tN39yVhwjocvOXjKavoHJUhr9tWlGOqxcC1CAY=;
        b=fUP2zHObJzsS+bCaW8cdvRHMtPEXyk9oZJGvbPsStdpGv95bv5EFZPRNSk6ta0U2Gb
         UekuaWH4faSD6k3u3ppltH6XwUWchTSEkDfM+Z5dF3QOOxKCiGogDFYt15v6VaV3bpUd
         k9LaPI7bNXt+CK33BL5EFT1D4aaFLpJ3axWJH2aNk5i5XMQJ2GBleIZRli8OKyYqeNsK
         598tcVWZDKdX/NUcmnxKGBVyr39XM4OO719rQETvYyTcxHHb6uNnyCKyREs9iltSfmiY
         k0zI16ncg4vKCHOBhNKfezyFpmWjQt09uW18vHkuogFG+O+wjr9jz0y5QCNruYguarO2
         Vb4w==
X-Gm-Message-State: ANoB5pl1ld/aAMPQ5rbZhsiaABRL2Eepx4FxUAIUiWCC4my08i0RA7es
        K/7i9dHdgL+WAJQsWopOdHQ6jw==
X-Google-Smtp-Source: AA0mqf5/ifF1Hgs6JeepAv+yFXx97mumrYlayztMX4KYgk5Rpno/TyG3Av7ysPPmbt6V4yTPkEFuWA==
X-Received: by 2002:a05:600c:4fd0:b0:3cf:70a0:f689 with SMTP id o16-20020a05600c4fd000b003cf70a0f689mr11186239wmq.161.1668856456940;
        Sat, 19 Nov 2022 03:14:16 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id l24-20020a05600c1d1800b003cf878c4468sm13442619wms.5.2022.11.19.03.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 03:14:16 -0800 (PST)
Date:   Sat, 19 Nov 2022 12:14:14 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Javier Martinez Canillas <javierm@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: DRM-managed resources / devm_drm_dev_alloc leaking resources
Message-ID: <Y3i6hi71mh18miHs@phenom.ffwll.local>
Mail-Followup-To: Maxime Ripard <maxime@cerno.tech>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Javier Martinez Canillas <javierm@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@intel.com>
References: <20221117165311.vovrc7usy4efiytl@houat>
 <20221118161558.ym7sif4tkr5srk2b@houat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118161558.ym7sif4tkr5srk2b@houat>
X-Operating-System: Linux phenom 5.19.0-2-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 05:15:58PM +0100, Maxime Ripard wrote:
> Hi,
> 
> Javier and I looked into it some more today, and I think we have a
> better idea of what is going on.
> 
> On Thu, Nov 17, 2022 at 05:53:11PM +0100, Maxime Ripard wrote:
> > After trying to get more kunit tests for KMS, I found out that the
> > recent kunit helpers we merged to create a DRM device [1] are broken and
> > won't free their device-managed and DRM-managed resources.
> > 
> > With some help from Thomas, we've dug into this and it turns out that if
> > we allocate a device with root_device_register, initialise our drm
> > device with devm_drm_dev_alloc(), register it using drm_dev_register(),
> > unregister it using drm_dev_unregister/drm_dev_unplug and then remove
> > the parent device, neither the device managed nor the DRM managed
> > actions are run.
> > 
> > root_device_register initializes the device by eventually calling
> > device_initialize() which sets the initial reference count of the root
> > device to 1 [2]. devm_drm_dev_alloc() then comes in, drm_dev_init() will
> > increase the root device refcount [3] and initialize our DRM device to 1
> > [4]. drm_dev_register(), through drm_minor_register() and device_add(),
> > will increase the root device refcount [5].
> > 
> > When unrolling things, drm_dev_unregister(), through
> > drm_minor_unregister() and device_del(), will give up its reference [6].
> > root_device_unregister(), through device_unregister(), will also give up
> > its own [7].
> > 
> > So we end up with this for the reference counts:
> > 
> > +------------------------+-------------+------------+
> > |         funcs          | root device | DRM device |
> > +------------------------+-------------+------------+
> > | root_device_register   |           1 | N/A        |
> > | devm_drm_dev_alloc     |           2 | 1          |
> > | drm_dev_register       |           3 | 1          |
> > | drm_dev_unregister     |           2 | 1          |
> > | root_device_unregister |           1 | 1          |
> > +------------------------+-------------+------------+
> > 
> > If we go back to the list of reference taken, the root device reference
> > and the initial drm_device reference, both taken by devm_drm_dev_alloc()
> > through drm_dev_init(), haven't been put back.
> > 
> > If we look at the drm_dev_init code(), we can see that it sets up a
> > DRM-managed action [8] that will put back the device reference [9]. The
> > DRM-managed code is executed by the drm_managed_cleanup() function, that
> > is executed as part of a release hook [10] executed once we give up the
> > final reference to the DRM device [11].
> > 
> > If we go back a little, the final reference to the DRM device is
> > actually the initial one setup by devm_drm_dev_alloc(). This function
> > has superseded drm_dev_alloc(), with the documentation that we do need a
> > final drm_dev_put() to put back our final reference [12].
> > 
> > devm_drm_dev_alloc() is a more convenient variant that has been
> > introduced explicitly to not require that drm_dev_put(), and states it
> > as such in the documentation [13]. It does so by adding a device-managed
> > action that will call drm_dev_put() [14].
> > 
> > Device-managed actions are ran as part devres_release_all() that is
> > called by device_release() [15], itself being run when the last
> > reference on the device is put back [16][17][18].
> > 
> > So if we sum things up, the DRM device will only give its last root
> > device reference when the last DRM device reference will be put back,
> > and the last DRM device reference will be put back when the last device
> > reference will be put back, which sounds very circular to me, with both
> > ending up in a deadlock scenario.
> > 
> > I've added two kunit tests that demonstrate the issue: we register a
> > device, allocate and register a DRM device, register a DRM-managed
> > action, remove the DRM device and the parent device, and wait for the
> > action to execute. drm_register_unregister_with_devm_test() uses the
> > broken(?) devm_drm_dev_alloc and is failing.
> > drm_register_unregister_test uses the deprecated drm_dev_alloc() that
> > requires an explicit call to drm_dev_put() which works fine.
> > 
> > It's also worth noting that Thomas tested with simpledrm and it seems to
> > work fine.
> 
> Indeed, the transition from simpledrm to a full-blown DRM driver handles
> this properly. It's using a platform_device_unregister() [1] and
> eventually device_del() [2][3]. That part is handled just like
> root_device_unregister() [4][5]. Basically, both will call device_del(),
> and then device_put(), so device_del() is called while holding a
> reference.
> 
> As we've seen before, at this point the DRM driver still holds a
> reference to the device as well.
> 
> device_del() will call bus_remove_device() [6], which will be skipped
> for the root device since it doesn't have a bus [7].
> 
> It will then call device_release_driver() [8], which is basically forwarded
> to __device_release_driver() [9][10], that will call device_unbind_cleanup() [11].
> 
> device_unbind_cleanup() calls devres_release_all() directly [12], that
> runs all the device-managed actions [13]. And it does so WHILE THERE'S
> STILL A REFCOUNT OF 2!
> 
> I would expect the call to devres_release_all to happen only in
> device_release, once all the device reference have been put back. Not 4
> functions in as a side effect, and while there's still some active
> references.

So maybe I'm missing something, but devm is tied to the device's
existence, not to the lifetime of the struct device.

Or well, it's complicated, there's actually two cleanups, once when doing
the hotunplug/unregister, and once when the final struct device cleanup
happens. This is why devm_drm_dev_alloc absolutely must be in the former
cleanup group, otherwise you have the loop you've described.

With usual device model this should all Just Work, if you hand roll your
struct device it gets more complicated. I've reworked how this works for
vgem/vkms a while ago in an attempt to make them look more like real
devices/drivers, but it's a bit nasty.

But yeah if you don't have that unregister step, then you have a loop and
the drm managed stuff never gets freed. That is by design, because the
full lifetime dependencies are

"hw device" (devm-managed) -> "drm device" (drmm-managed) -> "struct
device sw pieces" (kref, nothing else should be attached here really)

Cheers,
Daniel

> 
> > Using a platform_device instead of the root_device doesn't
> > change anything to the outcome in my tests, so there might be a more
> > subtle behaviour involved.
> 
> This one has the same symptom but a different cause. I was just
> registering a platform_device but it wasn't bound to any driver. While
> it's valid to do so according to that comment [13], it doesn't have any
> driver so the check for the driver in device_release_driver() [8], and
> never hits device_unbind_cleanup().
> 
> Thanks again to Thomas and Javier for their help
> Maxime
> 
> 1: https://elixir.bootlin.com/linux/latest/source/drivers/video/aperture.c#L199
> 2: https://elixir.bootlin.com/linux/latest/source/drivers/base/platform.c#L793
> 3: https://elixir.bootlin.com/linux/latest/source/drivers/base/platform.c#L751
> 4: https://elixir.bootlin.com/linux/latest/source/drivers/base/core.c#L4153
> 5: https://elixir.bootlin.com/linux/latest/source/drivers/base/core.c#L3733
> 6: https://elixir.bootlin.com/linux/latest/source/drivers/base/core.c#L3704
> 7: https://elixir.bootlin.com/linux/latest/source/drivers/base/bus.c#L511
> 8: https://elixir.bootlin.com/linux/latest/source/drivers/base/bus.c#L529
> 9: https://elixir.bootlin.com/linux/latest/source/drivers/base/dd.c#L1298
> 10: https://elixir.bootlin.com/linux/latest/source/drivers/base/dd.c#L1275
> 11: https://elixir.bootlin.com/linux/latest/source/drivers/base/dd.c#L1255
> 12: https://elixir.bootlin.com/linux/latest/source/drivers/base/dd.c#L530
> 13: https://elixir.bootlin.com/linux/latest/source/drivers/base/core.c#L2312



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

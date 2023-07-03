Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5448E7458BD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 11:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjGCJsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 05:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjGCJsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:48:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD5812C
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 02:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688377631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jQYvI6ljDyvAPteF7vHttZ7BlwUysjnknTWk4YxwxHU=;
        b=OXGnk2OFv2M4zfq5ULC+GXQrG7SFR98Ph0d1dv7Y0ivFYktJLl0TCcmAZU/+kiupPg7A8L
        uDe1Ddybkw/Mw4pVNr5U1tjIT0VqiFbsSXBbi6mXKFkT/yb/0uKNwC9OOv1rMPKzrkVRfT
        6UFgd8q4f/yzD4fntY7vIXGdh23QusQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-EKcbYDlwOFybgvkHILiBCA-1; Mon, 03 Jul 2023 05:47:10 -0400
X-MC-Unique: EKcbYDlwOFybgvkHILiBCA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-31421c900b7so1839314f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 02:47:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688377629; x=1690969629;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jQYvI6ljDyvAPteF7vHttZ7BlwUysjnknTWk4YxwxHU=;
        b=E6d//wwJGv1IkEKoO31RrZnwp+vCUDuKJgr1pNclQOO87K2c2YVlQeqy7aAvjeKKWV
         9q9IH3+UP2Qtd9IRoUYsju1QsFvXGBULKfQI/MvECeCLmo2niXw1hyb8C1Vf7VY5rSqd
         9CcajbyFglAsz+AOFn7l+JIHnIbIQs7nknGRjc38Pv9cAxrq5dhEf1EdA3mMNpiUk5lt
         R2ZMmpb+w+rF0xw8Ijp7hWVxSqhn91Nqih6nl7nEJuvVMAGIFcL4D7fZbHqrAAABKHkR
         Xca6c2HngrBuFkc0r0p81nu4uFF8WUfoj41/rOihhpZew56x2ChQ6Wl1UMuMl0aw0b/b
         iSvA==
X-Gm-Message-State: ABy/qLYsRqAHH7PSCZ9urDgGW4FeRWUz/sgFwKlXoWjgUQ/Q2Y1bRiEE
        HM7OYAXPv2yAHol2d2+ArqaAxkgLAVEP/8BOrqyylcRgL60ljLPfu45rYI3t96yV0y++S4tKvCe
        5xu/E8mOGZzSHsyhLNSPYayUi
X-Received: by 2002:a5d:4534:0:b0:314:2c7a:d100 with SMTP id j20-20020a5d4534000000b003142c7ad100mr5055541wra.42.1688377629044;
        Mon, 03 Jul 2023 02:47:09 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGG0GHYwylwnn0jpLdeMbAvNq2FJCyP9ZUsj6QJxVdOBpddConGhzUf2Sdb3/sXjz+tUMYmuA==
X-Received: by 2002:a5d:4534:0:b0:314:2c7a:d100 with SMTP id j20-20020a5d4534000000b003142c7ad100mr5055530wra.42.1688377628771;
        Mon, 03 Jul 2023 02:47:08 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m1-20020adffe41000000b003143853590csm1617613wrs.104.2023.07.03.02.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 02:47:08 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 1/3] drm: Improve Kconfig symbol prompt and help texts
In-Reply-To: <96d91373-f955-2209-5cd7-7e1ecacf73f9@suse.de>
References: <20230702191529.768248-1-javierm@redhat.com>
 <20230702191529.768248-2-javierm@redhat.com>
 <96d91373-f955-2209-5cd7-7e1ecacf73f9@suse.de>
Date:   Mon, 03 Jul 2023 11:47:07 +0200
Message-ID: <87lefxz5r8.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Hi Javier
>
> Am 02.07.23 um 21:15 schrieb Javier Martinez Canillas:

[...]

>> -	  Kernel-level support for the Direct Rendering Infrastructure (DRI)
>> -	  introduced in XFree86 4.0. If you say Y here, you need to select
>> -	  the module that's right for your graphics card from the list below.
>> -	  These modules provide support for synchronization, security, and
>> -	  DMA transfers. Please see <http://dri.sourceforge.net/> for more
>> -	  details.  You should also select and configure AGP
>> -	  (/dev/agpgart) support if it is available for your platform.
>> +	  Kernel-level support for the Direct Rendering Infrastructure (DRI),
>> +	  that is composed of the Direct Rendering Manager (DRM) and Kernel
>> +	  Mode Settings (KMS) subsystems.
>
> It's slightly off, as KMS is part of DRM. I'd just drop any mention of KMS.
>
> But TBH instead of these small fixes, we should first discuss how we

Right, I'll just drop this patch and we can cleanup the text later.

> organize the menu structures. For example, the DRM drivers are all 
> listed in the graphics menu. They might as well go into a DRM menu.
>
> The framebuffer will be split into drivers and 'core'. The core options 
> (FB_DEVICE, FIRMWARE_EDID, FB_*_ENDIAN) probably deserve a separate menu.
>

Yes, that is what we agreed with Arnd and Geert. To add a new Kconfig in
drivers/video/fbdev/core/Kconfig and drivers/video/fbdev/Kconfig source it.

> And there's the framebuffer console, which has its own menu. We need to 
> show it even if only DRM is supported. Plus the other consoles.
>
> I'm not sure what drivers/auxdisplay is, it might fit here as well.
>

That seems to be for simple character-based displays. And agree that could
be in framebuffer console as well. So we should improve the menu structure
before attempting to complicate with more options like adding the FB_CORE.

> It would be nice to rethink the overall menu.
>
> Best regards
> Thomas
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


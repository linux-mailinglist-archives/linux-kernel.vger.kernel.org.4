Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF67E6B3E55
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 12:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjCJLrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 06:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCJLrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 06:47:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181F91111E2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 03:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678448792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=drSrYgcBUUgWnWmYCUtrRpfKjp0+Me1c7+7zXqYrcnk=;
        b=MYldL90f/EAEW9x7hL+KrA6S2ISY+qUoQwrHxEXQ4gTJLkdpvDa4IYHrVpq23EBnao/n/t
        yvuvGf6wSJmFU6JcSaQiY8Rn0KBCh+lVpQAuvydhjJkjCR6R20wvncD61TiIHoufA6Fqxu
        OcRZJJI9+LSy7IxaSxWP7Y5Nkwx8/rI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-AxVRin2bPkyj2UIkPpiClQ-1; Fri, 10 Mar 2023 06:46:31 -0500
X-MC-Unique: AxVRin2bPkyj2UIkPpiClQ-1
Received: by mail-wm1-f69.google.com with SMTP id x18-20020a1c7c12000000b003e1e7d3cf9fso3749181wmc.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 03:46:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678448789;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=drSrYgcBUUgWnWmYCUtrRpfKjp0+Me1c7+7zXqYrcnk=;
        b=xevojrboHIz0wbw4gei7w5e33V0bVRr3UOri1CMtWOJ8Pcvfs6Pj5/So5lEgZ4UXns
         iVCtpww6WDXqKn1CTND57A1XVY7vMce9k3iJ2mG1e997eGhYev8OJoxLqAHAi/lQWW85
         InVCDaBCxv77Oksi2xyojWtyF9IwVEhC8XtrP4ZhO9CMCkbnrSTaEwCvUtv3mBAmhvJb
         KAITpuAYJ858wKFBK2bzECqcgUKa9dGcc1Cr4q/nGXRurxbtQSkjgCssP8hNE0Fsqwet
         LjwpwIsc8V1Ny67uDLvlZ8+bz1UkdLJ1WZoY4sE062p2qLJNi9afm/84F9sa715dIgue
         pjow==
X-Gm-Message-State: AO0yUKUZo+0gckf9V3V27ZXVhwF23D6ql4Y75KlNW60QEaIIJfAcOA0w
        tzqnPVFTtbJavm+RDm8RzoecuohMd0NKtMx6E9VZKZq3S2OcDqowx5nbCJPG8Uh9r6nmiAhlBP9
        tYCQfavKS9DeCLtfiYwPQaoRMGbM0svRhuePlauKlEgWxnvX57pLdBpwlxCZyYTUFyz3jeO2Jds
        ZawGDwpZAgXZg=
X-Received: by 2002:a05:600c:1d97:b0:3ea:f132:63d8 with SMTP id p23-20020a05600c1d9700b003eaf13263d8mr2275226wms.5.1678448789367;
        Fri, 10 Mar 2023 03:46:29 -0800 (PST)
X-Google-Smtp-Source: AK7set95RqeyUjLpfSJSMVbnJpHJXacJuVI6Mhcpdv2FAdeyuuMUCcplTBJqcn5CMAxsXTKPTAWs5Q==
X-Received: by 2002:a05:600c:1d97:b0:3ea:f132:63d8 with SMTP id p23-20020a05600c1d9700b003eaf13263d8mr2275205wms.5.1678448789020;
        Fri, 10 Mar 2023 03:46:29 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id c3-20020a7bc843000000b003eb596cbc54sm1982288wml.0.2023.03.10.03.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 03:46:28 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Arthur Grillo <arthurgrillo@riseup.net>,
        =?utf-8?Q?Ma=C3=ADra?= Canal <mairacanal@riseup.net>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        David Gow <davidgow@google.com>,
        =?utf-8?Q?Jos=C3=A9?= =?utf-8?Q?_Exp=C3=B3sito?= 
        <jose.exposito89@gmail.com>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2] drm/format-helper: Make conversion_buf_size()
 support sub-byte pixel fmts
In-Reply-To: <20230307215039.346863-1-javierm@redhat.com>
References: <20230307215039.346863-1-javierm@redhat.com>
Date:   Fri, 10 Mar 2023 12:46:27 +0100
Message-ID: <87wn3okewc.fsf@minerva.mail-host-address-is-not-set>
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

Javier Martinez Canillas <javierm@redhat.com> writes:

> There are DRM fourcc formats that have pixels smaller than a byte, but the
> conversion_buf_size() function assumes that pixels are a multiple of bytes
> and use the struct drm_format_info .cpp field to calculate the dst_pitch.
>
> Instead, calculate it by using the bits per pixel (bpp) and divide it by 8
> to account for formats that have sub-byte pixels.
>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---

Pushed to drm-misc (drm-misc-next). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


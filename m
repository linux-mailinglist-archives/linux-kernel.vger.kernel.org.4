Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B772D666CD8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 09:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239874AbjALIrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 03:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239863AbjALIqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 03:46:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE3B50166
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 00:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673513092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5a4BjVGA5+VS7280a0HZ27tLyRrI18llQE1bUBA8/1A=;
        b=bCDjP4TuLwevCisJZnRvUb+PrwplMSH8SggBLHBcsI965ODOsYWfSSxSqJEWJKX73DNJsG
        cIXw7vIxOpa0e2K0EQBtUAtoCx1EwzZWD97yS9m7vZyoXQGTqSLJtDYIvlZ14aoXQSqwOT
        hvyisK5YXBujXVT+nhyxXx3XjL3RbiY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-79-s2tIxQU8P6-3fU6kmstuZA-1; Thu, 12 Jan 2023 03:44:50 -0500
X-MC-Unique: s2tIxQU8P6-3fU6kmstuZA-1
Received: by mail-wm1-f71.google.com with SMTP id l17-20020a05600c1d1100b003d9a145366cso8958685wms.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 00:44:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5a4BjVGA5+VS7280a0HZ27tLyRrI18llQE1bUBA8/1A=;
        b=PCbYn2MMCG4tt8fczY+XLfT8p+CvsLxXPtLPYxHcquYJqM+ezih0h4IXRl6zvMa5+8
         hQzlykgTyz66A2jJ/BclQ3AaXmBC65/VNNACG6O9IuDhlHLeW9bufd6C4GyrYfQMAH30
         fvAoglu61Qer0q+05y6oPVnsgHCrAPGvqILo2i8+PXklM5ApBHdJUCEGeRGfeXIoR4nd
         l0ENrfXYXbyANQZEJz3PDYCYEG+D2wfp8isFNFvg5LrLkRtw4U/JQkECKZGKFdlnFZ87
         IKLwX/FNCU4H3R1/U6BCdyLRA+DypzoMA7/cZGgsecOYIAEBoH0l8TwVMLkq/ufYQrlS
         hutg==
X-Gm-Message-State: AFqh2kqmjsepOS3vRiPCxcdG9+XtT5Bh1xaHPKKL2YNpDG+kZ+1ItHpE
        ar8B4SyaIoOi/ObQbGHBDunoKZYUOS/54gSa/iC3wAFtULF83aCXugX2gdDoUVsMOeD/5f4Fkz5
        3MZB5ZFEqFWXHvfGu6aY0uo4Z
X-Received: by 2002:a05:6000:705:b0:267:e918:d1e6 with SMTP id bs5-20020a056000070500b00267e918d1e6mr47978588wrb.51.1673513089194;
        Thu, 12 Jan 2023 00:44:49 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsBcz+NOewCErJTagdikvQUga/n6zRME4ChBTvTDSkbfqsCpMEvFJRtoH3xbPIha9jKtsWTZw==
X-Received: by 2002:a05:6000:705:b0:267:e918:d1e6 with SMTP id bs5-20020a056000070500b00267e918d1e6mr47978578wrb.51.1673513088989;
        Thu, 12 Jan 2023 00:44:48 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id k9-20020a5d66c9000000b002bdd7ce63b2sm526804wrw.38.2023.01.12.00.44.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 00:44:48 -0800 (PST)
Message-ID: <733eb41e-a296-47bb-ce06-18dff755723c@redhat.com>
Date:   Thu, 12 Jan 2023 09:44:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 11/11] video/aperture: Only remove sysfb on the default
 vga pci device
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Aaron Plattner <aplattner@nvidia.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Helge Deller <deller@gmx.de>, Sam Ravnborg <sam@ravnborg.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        stable@vger.kernel.org
References: <20230111154112.90575-1-daniel.vetter@ffwll.ch>
 <20230111154112.90575-11-daniel.vetter@ffwll.ch>
 <fb72e067-3f5f-1bac-dc9b-3abd9d7739a2@redhat.com>
 <ad725823-f4ef-904f-c04c-90a6aad43323@nvidia.com>
 <7b00e592-345f-4dd5-3452-7f6f70fc608a@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <7b00e592-345f-4dd5-3452-7f6f70fc608a@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/23 08:55, Thomas Zimmermann wrote:

[...]

>> Thanks Daniel and Javier!
>>
>> I wasn't able to reproduce the original problem on my hybrid laptop 
>> since it refuses to boot with the console on an external display, but I 
>> was able to reproduce it by switching the configuration around: booting 
>> with i915.modeset=0 and with an experimental version of nvidia-drm that 
>> registers a framebuffer console. I verified that loading nvidia-drm 
> 
> Thank you for testing.
> 
> One thing I'd like to note is that using DRM's fbdev emulation is the 
> correct way to support a console. Nvidia-drm's current approach of 
> utilizing efifb is fragile and requires workarounds from distributions 
> (at least here at SUSE). Steps towards fbdev emulation are much appreciated.
>
 
I was meaning to mention the same. Fedora also is carrying a workaround just
for the Nvidia proprietary driver since all other drivers provide a emulated
fbdev device.

So getting this finally fixed will be indeed highly appreciated.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


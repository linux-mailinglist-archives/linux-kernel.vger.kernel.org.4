Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C031E679511
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 11:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbjAXKU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 05:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbjAXKU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 05:20:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80D42ED4E
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 02:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674555584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kFBSJTYS4mqW+/Iyf7kFDqa/R8NrKMamooZaSYF4kgQ=;
        b=TO6YKX6Xe38iHlB2pIsv/THDMSlrEMbc16KSi4fsrjLWdigvmmrjG2JaF6CEHn30YCDNwP
        IvIaxoWCYO/HbweSbmX1o6diqhEmfLxNFP7BMlz1Jo3/cFXQCfpCBDMgRQko2j/w4KQDs0
        2O5/wo0ZzoDxglH6TDo+PuTznM6GQn0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-465-CtyHa2lyP-yRDEKlYmt1lQ-1; Tue, 24 Jan 2023 05:19:43 -0500
X-MC-Unique: CtyHa2lyP-yRDEKlYmt1lQ-1
Received: by mail-wr1-f69.google.com with SMTP id l18-20020adfa392000000b002bbd5c680a3so2518498wrb.14
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 02:19:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kFBSJTYS4mqW+/Iyf7kFDqa/R8NrKMamooZaSYF4kgQ=;
        b=ChKkOLfVP4t/lujhkmUdMYcJHTwTuCCc8IpPQ1bytUoxElLTsxr6aEB/Oq2cBcvoQl
         MDc1qoneg3sHEf2y1MdDehjwyrkj+0RhE1E5awCIT+qBVLnsa7dxzgRI53lzFZtrAXOI
         TC+2l406D/PDLExuQgiAlyey7BCeFE2xgson6CmIpUsw4Tx6MGFOxuaR5gYHq5Y7p4Yd
         z8ALgnWBh9k0xfmsZSZ8gp4n6dOMDvy19w/WmcMg6GWreMxwwJ1wqTT76R2F3LkBMlGz
         GVjVGENEipVEoWv+OwgjfpjvSwmCYeeF4kX3OM4guJNb1KDuRmoVnWun3CBWHVv67oLV
         Osbg==
X-Gm-Message-State: AFqh2krJwIjemtuXPD/pUE1BUV2UaJp0jG+HQjELn1u62e/hKNj2NDx0
        xbruh9coIaPU2rXPWzAdIXVS/TFHkcXtw55mJ+gn5VXDbMs+WfjYYiEKStLISV6rK57z/pGETRf
        Qo9gbb9vWcuf2F7n6FmhcF0ePn1LxoFdliXrH7tCs4WYJ83bDykNuMHOJ+jN4C3oYlRhRf12VBF
        c=
X-Received: by 2002:a7b:cc07:0:b0:3da:fcb7:39e5 with SMTP id f7-20020a7bcc07000000b003dafcb739e5mr26060901wmh.23.1674555581514;
        Tue, 24 Jan 2023 02:19:41 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtZPN2eXbvlA0Xl1oaGY+fOsSR+lOHUd9zrk8Yqc+wK6G/pQS/HwZZm+h4/Y3cFpXHaao14ug==
X-Received: by 2002:a7b:cc07:0:b0:3da:fcb7:39e5 with SMTP id f7-20020a7bcc07000000b003dafcb739e5mr26060878wmh.23.1674555581208;
        Tue, 24 Jan 2023 02:19:41 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f14-20020a05600c154e00b003daff80f16esm18009383wmg.27.2023.01.24.02.19.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 02:19:40 -0800 (PST)
Message-ID: <83af8935-7709-0a0d-3504-5e9dcba1cacd@redhat.com>
Date:   Tue, 24 Jan 2023 11:19:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 3/3] drm/fb-helper: Use a per-driver FB deferred I/O
 handler
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Maxime Ripard <mripard@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        dri-devel@lists.freedesktop.org
References: <20230121192418.2814955-1-javierm@redhat.com>
 <20230121192418.2814955-4-javierm@redhat.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20230121192418.2814955-4-javierm@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/23 20:24, Javier Martinez Canillas wrote:
> The DRM fbdev emulation layer sets the struct fb_info .fbdefio field to
> a struct fb_deferred_io pointer, that is shared across all drivers that
> use the generic drm_fbdev_generic_setup() helper function.
> 

[...]

> 
> Fixes: d536540f304c ("drm/fb-helper: Add generic fbdev emulation .fb_probe function")
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
> 

Pushed this to drm-misc (drm-misc-fixes). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


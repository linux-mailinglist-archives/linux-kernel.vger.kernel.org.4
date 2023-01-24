Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83346794D6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 11:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233719AbjAXKLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 05:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjAXKLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 05:11:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87E4B75D
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 02:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674555049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/ea3L0Ed5IYjUQaMLhyl4vDM8euWki44OGeAFp5yFf8=;
        b=AUBNTcKg3C/M0XD134iji+Td+0ZWIDHP85gBJIIXMmRYF0Hrc7YuCrWEfBwEr1RPQpSq4l
        lKgpsDAZo8oSdDXJ+5ycmYjmkCVh4WHVS7LKZbpr1WeMcl2/0kbAxV/NyPA1jPdgHJz2BB
        wPgxdnRIGfbgMdZMTMbynQs3vkmSbbM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-628-ogIEAxvxNyWWw183L7LFlw-1; Tue, 24 Jan 2023 05:10:48 -0500
X-MC-Unique: ogIEAxvxNyWWw183L7LFlw-1
Received: by mail-wm1-f72.google.com with SMTP id l19-20020a05600c1d1300b003dc13fc9e42so592939wms.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 02:10:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ea3L0Ed5IYjUQaMLhyl4vDM8euWki44OGeAFp5yFf8=;
        b=CVcWCF5lN2uRVfg7JgAAFkRmfYc7fJG8HMkW67SoiJnIJ+E4+NlBl0vEA6wo1NrGyj
         EXmiyaL/K2hqHqKC6ARsrjL+CI2IaSZYPNdSJvT1T0Ho/umTBgk1co8qDNgJT+i3h25C
         UybesOBmUfWhepm2Q3trALuHdtwKpvqOzvKgdn5RMmr+0EkIOruuGOO+EdyioVWSVbXl
         Gs5NM4JXgzSVBo3QLeIlBq08f44ld5eqf+r+eK1uhi6IpijjSpZITADNxyRYwM/Sh5+p
         hMBg4cMVQh9c6ZGdhyKu2ZRPQX1VqoVX4BfzLVBLuGLnugO2iDMFMQBkEQH3TmDPmalz
         ExFw==
X-Gm-Message-State: AFqh2kpiXhBXFkk13Ie6poKxXo3U9lzFs4tPPAhQ0Eu+OeM6GldY3ikT
        0ZuTkYQRQzNaoDJKf3AnMN5zj1fl4aLzQRHV1zRasF9CY105ioXutpzljAyFzZoFEZqCZnLwD6N
        s6t6DMQI3jTK5YTOlOtNkVm3ezCaqy9HR44SS0ArVJ4dRrdT/JeVJ+uGmipCpXfbvnl3QyfTEia
        A=
X-Received: by 2002:a7b:c45a:0:b0:3d1:ed41:57c0 with SMTP id l26-20020a7bc45a000000b003d1ed4157c0mr35140101wmi.30.1674555046598;
        Tue, 24 Jan 2023 02:10:46 -0800 (PST)
X-Google-Smtp-Source: AMrXdXv5AioHCNcL30Sjju8XtwLP3T9V6KC2OqPgEYZytb4DQyKsMxqZxY2HiIkelfmcTqUxgcRd0Q==
X-Received: by 2002:a7b:c45a:0:b0:3d1:ed41:57c0 with SMTP id l26-20020a7bc45a000000b003d1ed4157c0mr35140084wmi.30.1674555046385;
        Tue, 24 Jan 2023 02:10:46 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id h13-20020a05600c2cad00b003cfa622a18asm14171373wmc.3.2023.01.24.02.10.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 02:10:46 -0800 (PST)
Message-ID: <9bc96f9d-8e3a-7c71-c9fe-088c9d086f2a@redhat.com>
Date:   Tue, 24 Jan 2023 11:10:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] drm/ssd130x: Silence a `dubious: x & !y` warning
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
References: <20230121190930.2804224-1-javierm@redhat.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20230121190930.2804224-1-javierm@redhat.com>
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

On 1/21/23 20:09, Javier Martinez Canillas wrote:
> The sparse tool complains with the following warning:
> 
> $ make M=drivers/gpu/drm/solomon/ C=2
>   CC [M]  drivers/gpu/drm/solomon/ssd130x.o
>   CHECK   drivers/gpu/drm/solomon/ssd130x.c
> drivers/gpu/drm/solomon/ssd130x.c:363:21: warning: dubious: x & !y
> 
> This seems to be a false positive in my opinion but still we can silence
> the tool while making the code easier to read. Let's also add a comment,
> to explain why the "com_seq" logical not is used rather than its value.
> 
> Reported-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>

Pushed this to drm-misc (drm-misc-next). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


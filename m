Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4555E5FD591
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 09:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiJMHef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 03:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiJMHec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 03:34:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E68911E45A
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 00:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665646470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7+kkmXxqmOAqWpnEkFmH+PPx54SR+ImezPG4mMhIn2E=;
        b=VVXbaHsjXika6IYd0uzKrUnsOX1LqHC5SUCg0RiKbVzs2Ud1HJ3abbYoYPxx3WxrCLWgoB
        Eu0E+uy0IFgYSCFaDxjWpsUFQtIc8ec8tDV4+dW4sceVq4E7xfABGOAa9oCFOB7NqfBVUb
        CJ/6pq7iIq8V4BRFduZOzaIfmat0H+U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-468-Z7wUpwJpMqOpxgCe_XNI7g-1; Thu, 13 Oct 2022 03:34:29 -0400
X-MC-Unique: Z7wUpwJpMqOpxgCe_XNI7g-1
Received: by mail-wr1-f71.google.com with SMTP id e19-20020adfa453000000b0022e3608df56so222113wra.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 00:34:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7+kkmXxqmOAqWpnEkFmH+PPx54SR+ImezPG4mMhIn2E=;
        b=OxHYESKfohzuHMRv7CKMQMUziFRjkGt7/0DvZvFqhPCwQEY0ZTc64pScsqSraiXqlL
         o4z6+GeoKJOmkDvDKjEvBUVmHlzEELnKst3Jzx9WtCZKyF21Xa04ddSfIC7djqBLh7CX
         KWWcXYepfYlzwXlhLO2GkrcxTvyB+StwjpgOUGGU1+7k2VckzBZjdw8Qrrnm/aP+2O22
         Qv6/q3M1cKIz0ON112Kk71t1fxblXW1Fcks0P8Xf6WIKy5q6xksv7+8umC1mysH/xp8N
         zJgBiX80DujxQ/uCpdrEkBJnxaVAuvQuQxb/Ip/kP4gX5eV7lpsxjKpdFOW1tiK5y1Fl
         Slrg==
X-Gm-Message-State: ACrzQf2JRClxfncbIWEVbIajKVq00Cu+YaNu2FOG4Ix5NHb622RQVBN2
        zTAtC1Byh5vl7OAdfeGfC6hCyT/hwApb/nCO3KR7uZquzkUib6TcNVig8r4mczh/bpoK3bA5dgM
        EuRPDwCiu+6lQteA48PNS65ONoKLDOuMq5hNtlyArWn/GfklHodjx5KY9j192wfHMkvJIY8/x2S
        M=
X-Received: by 2002:a7b:c047:0:b0:3b4:adc7:1ecb with SMTP id u7-20020a7bc047000000b003b4adc71ecbmr5333952wmc.144.1665646467829;
        Thu, 13 Oct 2022 00:34:27 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM76Bw6kTXCm8sc8B5hU+9qB/ACfIxlbJt65LXBIFUWuX5g23uiXeaQ5PngFBdE8Z+HpUzxeLA==
X-Received: by 2002:a7b:c047:0:b0:3b4:adc7:1ecb with SMTP id u7-20020a7bc047000000b003b4adc71ecbmr5333929wmc.144.1665646467584;
        Thu, 13 Oct 2022 00:34:27 -0700 (PDT)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id b1-20020a05600c4e0100b003a3170a7af9sm3790192wmq.4.2022.10.13.00.34.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 00:34:27 -0700 (PDT)
Message-ID: <b5e30da4-d958-4227-6e13-07f58ea0ccb8@redhat.com>
Date:   Thu, 13 Oct 2022 09:34:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 0/4] Add a drm_crtc_helper_atomic_check() helper
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org
References: <20221011165136.469750-1-javierm@redhat.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221011165136.469750-1-javierm@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/22 18:51, Javier Martinez Canillas wrote:
> Add a helper function and make drivers that have the same logic in their
> struct drm_crtc_helper_funcs .atomic_check handler to use this instead.
> 
> Patch #1, #2 and #3 are just cleanups for the mgag200, simpledrm and
> ssd130x drivers respectively. Finally patch #4 converts the last two
> drivers to use a helper instead of open coding it the same logic.
> 
> The changes are inspired by a patch from Thomas Zimmermann for the ast
> DRM driver:
> 
> https://patchwork.kernel.org/project/dri-devel/patch/20221010103625.19958-4-tzimmermann@suse.de/
> 
> This is a v2 that addresses issues pointed out also by Thomas in v1:
> 

Pushed this to drm-misc (drm-misc-next). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


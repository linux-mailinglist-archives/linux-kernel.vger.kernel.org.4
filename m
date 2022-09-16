Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21385BB43B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 00:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiIPWCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 18:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiIPWCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 18:02:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABA77A74D
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 15:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663365717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gBWgzFgU3Z8HMeI1bJlxwd6aqGe+i6sH93eJSlpAwmI=;
        b=e/Otp2beQlmOYXtmfNpTvhoq89Qo7u311ymkqXQTSBUJefOXks2DCgbp4il4sTnp3B4Xf8
        1QtcYgwtU2kjm034mAPcP4XMG5X/C/Qx/kgCExuafd9JtYh/KgU8xqFsGc37GUE3rh8Bns
        6dKdyMOIix5pnsjtpMxOq2i5ZwEQT9Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-259-xOqaLTmDN4qgzGiY5zDIPA-1; Fri, 16 Sep 2022 18:01:56 -0400
X-MC-Unique: xOqaLTmDN4qgzGiY5zDIPA-1
Received: by mail-wm1-f71.google.com with SMTP id q16-20020a1cf310000000b003a626026ed1so326525wmq.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 15:01:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=gBWgzFgU3Z8HMeI1bJlxwd6aqGe+i6sH93eJSlpAwmI=;
        b=Mh0d9x9WBgX381IeAFH5gJ05x2ehK69UrQUAuil84YDnaJyFoS1BxmlFQuE5486ciR
         syKEeOAXsNfEcmGR8iBZCme6OkrxkJD3AATXhmjrwYMGZk6Ry6zIhD5lMl7s2BNXTzYR
         fib4QWRn9Bmii6WHAuR3PQ6zW3BjdS+6fwCEuPIUcrZ/73RZZDe2IzGkfARznD70gAZx
         DKIk1xJIUS6sSE4hILqEFi1Bsc/ohQHGelNdBAVfe9++TVfj9obKfCbquTGob9sXXNWN
         Z6fnwB26EsN9UJMfPl0yoaKkFYqre3J6n4xWBwcnygY+bLZebxRW7AX/Xr/HzShbSCUZ
         drGQ==
X-Gm-Message-State: ACrzQf2H49BJa+gf9pfpu7Y/3ty/V0PgZqdmDiXa2Ug4lbluFfvAt37T
        eye6IPQGl4jW3WU/vDhjR2cxUADJ4Hw7v7zH6af5z8VcGhh+9NCROnFM0Bog+BY5zmrV1SJhFJ+
        rPDtctzlI+LIYxnTABN9m0fmrmW/y5idHFFUxXBfIbfcCWOq6XI6yTnMPSKKJkRjeKiCuxD2qgd
        I=
X-Received: by 2002:adf:e310:0:b0:226:d19c:de22 with SMTP id b16-20020adfe310000000b00226d19cde22mr4033775wrj.314.1663365713532;
        Fri, 16 Sep 2022 15:01:53 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM42y1GJjQtjCDbyt3WCVfBYmMlZITlOgwAhJrFqaFC/v09i3hSqlFai21WZKqDUZm5Cz816WA==
X-Received: by 2002:adf:e310:0:b0:226:d19c:de22 with SMTP id b16-20020adfe310000000b00226d19cde22mr4033758wrj.314.1663365713293;
        Fri, 16 Sep 2022 15:01:53 -0700 (PDT)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f17-20020a7bcd11000000b003a4efb794d7sm3495213wmj.36.2022.09.16.15.01.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Sep 2022 15:01:52 -0700 (PDT)
Message-ID: <d29dd847-f5c8-d744-2d18-64f20abc09a1@redhat.com>
Date:   Sat, 17 Sep 2022 00:01:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3] drm/plane-helper: Add a
 drm_plane_helper_atomic_check() helper
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     Harry Wentland <harry.wentland@amd.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org
References: <20220913162307.121503-1-javierm@redhat.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220913162307.121503-1-javierm@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/22 18:23, Javier Martinez Canillas wrote:
> Provides a default plane state check handler for primary planes that are a
> fullscreen scanout buffer and whose state scale and position can't change.
> 
> There are some drivers that duplicate this logic in their helpers, such as
> simpledrm and ssd130x. Factor out this common code into a plane helper and
> make drivers use it.
> 
> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
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


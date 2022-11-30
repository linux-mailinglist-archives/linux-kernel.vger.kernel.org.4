Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95DF863D179
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 10:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbiK3JOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 04:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbiK3JOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 04:14:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EF92F00C
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 01:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669799624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H4kmVPYqwbxGU6PTsZRjCspb80cku12to9pgPPCu54U=;
        b=JT/QT230q1ODZ+cPB2hn0iF1IvgPahTsL+1Uec1xOtBZTeCFx99YGrpUMYC01Rr3FFQTAD
        n3hSGZHZPay0s5GKqexNvBokqtqmZVr2P9hnXBZZp1CHCG0kSqpEPpREaNBJMfSSHvoUTp
        pqaTlGee5mE0hj6Mk4eOCPec3cSaWQs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-15-kdgiqaUePfGnE7I0GCS-Kw-1; Wed, 30 Nov 2022 04:13:42 -0500
X-MC-Unique: kdgiqaUePfGnE7I0GCS-Kw-1
Received: by mail-wm1-f70.google.com with SMTP id ay19-20020a05600c1e1300b003cf758f1617so720422wmb.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 01:13:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H4kmVPYqwbxGU6PTsZRjCspb80cku12to9pgPPCu54U=;
        b=bFhgbinVgE+I3HJ+9oXklE+EILVzzBeJNXh0uFhm1ZSIQ17wjFNx8X55ybUcQvoPmZ
         SMxjc5xigoV/8tRUcnischbTqyn0CVdZjaGh501DaIbmzHEKB2Leux8P/ikoG6ZHvrg/
         lVC8oK4cV1/2TgBsHDQ/yt06YhQOHGdPFV1Gd+i/dckYfB35I7U70skIG6nA7euO7Gxq
         rxDYPOqat5oWgrvJJQS0510IUy/7mcWAULDXS+FO2f0xxEDfimBG+OsIaDbsv8lEAzjv
         PpqyNMpHrKjCu+CC4hOe5S2MLm6KFbECkE9B3/cIFLse+Q45Znyr6a+XPEW51WZQ0HiE
         iDIQ==
X-Gm-Message-State: ANoB5pkUqu1WzU9Xp93wWUcSWAFalb+kltxmwoBCqoLcP1vYD9xKS/lC
        Hn9Y3gRK1Niaje+IwxT2QnuQJjX7XfU+gttPlJbFTN6OCciQkn5MppXmm408YfcvTj8tbHQPccR
        rQMqKvD9Zk81d+6//DE4M13Fo
X-Received: by 2002:a1c:7513:0:b0:3cf:8896:e1c9 with SMTP id o19-20020a1c7513000000b003cf8896e1c9mr46817788wmc.119.1669799621489;
        Wed, 30 Nov 2022 01:13:41 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5vvCv9O/1R9RXSG17BNuO4k/AT1pMos0jlXhZZ5YoVQ/8d1PLV/cKODBBZcjZF5bgcENOdFQ==
X-Received: by 2002:a1c:7513:0:b0:3cf:8896:e1c9 with SMTP id o19-20020a1c7513000000b003cf8896e1c9mr46817770wmc.119.1669799621277;
        Wed, 30 Nov 2022 01:13:41 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id h4-20020a5d5044000000b00241bc4880fesm905866wrt.111.2022.11.30.01.13.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 01:13:40 -0800 (PST)
Message-ID: <a86a67d8-59dc-1af8-4176-b3236ef0f0a1@redhat.com>
Date:   Wed, 30 Nov 2022 10:13:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 08/17] drm/tests: helpers: Allow for a custom device
 struct to be allocated
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     dri-devel@lists.freedesktop.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-media@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        Brendan Higgins <brendan.higgins@linux.dev>,
        =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-kernel@vger.kernel.org, David Gow <davidgow@google.com>
References: <20221123-rpi-kunit-tests-v2-0-efe5ed518b63@cerno.tech>
 <20221123-rpi-kunit-tests-v2-8-efe5ed518b63@cerno.tech>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221123-rpi-kunit-tests-v2-8-efe5ed518b63@cerno.tech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/22 15:53, Maxime Ripard wrote:
> The current helper to allocate a DRM device doesn't allow for any
> subclassing by drivers, which is going to be troublesome as we work on
> getting some kunit testing on atomic modesetting code.
> 
> Let's use a similar pattern to the other allocation helpers by providing
> the structure size and offset as arguments.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

[...]

> -EXPORT_SYMBOL(drm_kunit_helper_alloc_drm_device);
> +EXPORT_SYMBOL(__drm_kunit_helper_alloc_drm_device);
>

I'm not sure if I would add a __ prefix to exported symbols, but I see that
this is a convention in the DRM subsystem so I'm OK with it. 

Another thing that came to mind is if we want to use EXPORT_SYMBOL_GPL()
instead for the DRM KUnit helpers. But that's not related to this series.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>  

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


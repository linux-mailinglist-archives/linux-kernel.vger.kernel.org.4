Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA93D5E78F5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 13:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbiIWLBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 07:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbiIWLBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 07:01:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAA4AF4B6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 04:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663930879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JOiBQeetDdcvSGIfY2fjhmLzANCrF4v13aGxj9JhJvY=;
        b=PGBpLfFqI634DeddRewYt0Pc1ZMDIqjKUV9Jk7+4T/a5s8PvxeNV6lYHmqUmgQCq5Myk6k
        oOL19leHHkzyKsBITxzRUZak1azVTqJ6fRC3197+e0aI+bVTB5pEVsIobxjcm7cUwfAPL3
        fbhwmOvwNJI7fmQkbpKwXdGNsTpWxqU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-137-Q-zWic-SMqudMGHzYIC3Cg-1; Fri, 23 Sep 2022 07:01:18 -0400
X-MC-Unique: Q-zWic-SMqudMGHzYIC3Cg-1
Received: by mail-wm1-f72.google.com with SMTP id i129-20020a1c3b87000000b003b33e6160bdso2548158wma.7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 04:01:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=JOiBQeetDdcvSGIfY2fjhmLzANCrF4v13aGxj9JhJvY=;
        b=vhp5995aflNNcpvfgdrlIia9N46L/iQcakC7cUaeN7LJbgsj4tJejrQ0tLGLDCAOAL
         9nT9j0LHjavAAGHmW7wFGbXNeEhUF8hvzPCbUOUPB8j6qAuqNCTmBRhqPiQY4V4OD4PS
         z8BU9j2zhGf0YyUe5JsnPedDDZPhQcIKAju/0kszCp+S+VvykTY1OmfqMAlsY4oqV3iF
         ycF2LWKQerzINb7bdFG7X83vlwGEqZKnKDKS+DedGv8xB8RhQ8QpXmF7iwgzGiKfxFW/
         q7fVVwxQyYSOcHrP2ZyzpsFfekI4vpqGLKQc8zl0nNolelpBwTigCruejfvx53aTF2ZV
         Lpnw==
X-Gm-Message-State: ACrzQf31dLeQgvVQ8ZtDO5v5luI5Zh50dG+b8igdue6t+7K2MSG/5afr
        WSzdzXyf1weCVugRV9mNBqGRaeikSyYPi+1PwMPdFZYaUn3Z4Qz/cD7sGhpc/f+DoAEPC8PpMRu
        masbZASWTC+PpO0WX49IEwclg
X-Received: by 2002:a05:600c:364a:b0:3b4:b9b3:8bef with SMTP id y10-20020a05600c364a00b003b4b9b38befmr12643122wmq.26.1663930877270;
        Fri, 23 Sep 2022 04:01:17 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4gLa2EBcgyRTL5irtnfD1Rbw8bNumsaMk9N6QECjIoyKaHGe3CCmvJDwZ+J5z85y4gmVnDHA==
X-Received: by 2002:a05:600c:364a:b0:3b4:b9b3:8bef with SMTP id y10-20020a05600c364a00b003b4b9b38befmr12643075wmq.26.1663930876886;
        Fri, 23 Sep 2022 04:01:16 -0700 (PDT)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id c1-20020a5d5281000000b002287d99b455sm7050946wrv.15.2022.09.23.04.01.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 04:01:16 -0700 (PDT)
Message-ID: <4bef4296-b32f-e6c9-c8d0-591e2945e0d4@redhat.com>
Date:   Fri, 23 Sep 2022 13:01:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 13/33] drm/client: Add some tests for
 drm_connector_pick_cmdline_mode()
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Maxime Ripard <mripard@kernel.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Emma Anholt <emma@anholt.net>,
        Karol Herbst <kherbst@redhat.com>,
        Samuel Holland <samuel@sholland.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>, Lyude Paul <lyude@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Dom Cobley <dom@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org
References: <20220728-rpi-analog-tv-properties-v2-0-f733a0ed9f90@cerno.tech>
 <20220728-rpi-analog-tv-properties-v2-13-f733a0ed9f90@cerno.tech>
 <49ea7c7c-7d4c-8348-ea75-e0f376111e4c@suse.de>
 <b3c4ee65-fc56-f54c-3946-b6524fb36f72@redhat.com>
 <93969920-b5ed-ff15-48d4-02e2f9c23505@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <93969920-b5ed-ff15-48d4-02e2f9c23505@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/22 12:30, Thomas Zimmermann wrote:

[...]

>>>> +
>>>> +#ifdef CONFIG_DRM_KUNIT_TEST
>>>> +#include "tests/drm_client_modeset_test.c"
>>>> +#endif
>>>
>>> I strongly dislike this style of including source files in each other.
>>> It's a recipe for all kind of build errors. Can you do something else?
>>>
>>
>> This seems to be the convention used to test static functions and what's
>> documented in the Kunit docs: https://kunit.dev/third_party/kernel/docs/tips.html#testing-static-functions
> 
> That document says "...one option is to conditionally #include the test 
> file...". This doesn't sound like a strong requirement.
>

That's true.

>>
>> I agree with you that's not ideal but I think that consistency with how
>> it is done by other subsystems is also important.
>>   
>>> As the tested function is an internal interface, maybe export a wrapper
>>> if tests are enabled, like this:
>>>
>>> #ifdef CONFIG_DRM_KUNIT_TEST
>>> struct drm_display_mode *
>>> drm_connector_pick_cmdline_mode_kunit(drm_conenctor)
>>> {
>>>     return drm_connector_pick_cmdline_mode(connector)
>>> }
>>> EXPORT_SYMBOL(drm_connector_pick_cmdline_mode_kunit)
>>> #endif
>>>
>>> The wrapper's declaration can be located in the kunit test file.
>>>
>>
>> But that's also not nice since we are artificially exposing these only
>> to allow the static functions to be called from unit tests. And would
>> be a different approach than the one used by all other subsystems...
>>
> 
> There's the problem of interference between the source files when 
> building the code. It's also not the same source code after including 
> the test file. At a minimum, including the tests' source file further 
> includes more files. <kunit/tests.h> also includes quite a few of Linux 
> header files.
> 
> IMHO the current convention (if any) is far from optimal and we should 
> consider breaking it.
>

Yes, I agree with that. But probably we should be explicit about the
wrapper export symbols to access static functions pattern in the KUnit
docs so other subsystems could do the same and it becomes a convention ?
 
> Best regards
> Thomas
> 

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151D95E76E7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 11:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbiIWJ0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 05:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbiIWJ0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 05:26:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A1612DEA8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 02:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663925200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lBmBrugF1Uc8odU/lwXKGYWTxCtAMKSLu086DYvJSJ0=;
        b=FB4gijC0WWZJ1wuJ7D1e5bz9MYNV4RlIggLuxlMYnm3A444VuCMM8eDipzZ3GmGW9XMG2j
        yAZwSbYDgDrNZ8RsMpqIQjc8vPxqIKDA7Jhg/MZf8+q3+3mnsI6eZBl0WLp0l7m5Tlstcj
        tvfyuatS7mq9kPTvJYgd8iFwtdQIer4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-347-yLRAelEUMLCjFzhocEXrNw-1; Fri, 23 Sep 2022 05:26:37 -0400
X-MC-Unique: yLRAelEUMLCjFzhocEXrNw-1
Received: by mail-wr1-f70.google.com with SMTP id e18-20020adfa452000000b00228a420c389so3788362wra.16
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 02:26:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=lBmBrugF1Uc8odU/lwXKGYWTxCtAMKSLu086DYvJSJ0=;
        b=VRntFngCjUcCyCtEOb5UJSfOgleiNRqGZgxdOkzeZrka0C8yNHt86KZNlSDvOjEYSP
         a8rHMKSe/YU7u2tGAwkGSCDnbmwGHxuII7SEZKzm0DFDjdygYYTnSLLjGDbh2G9eFHTw
         U5ozRhPx8Xh44UWagyD+w6XSsAEa4BkSi9OonPOH+T5LOdL9/7FIVH+kxVTRNs3mMJ0y
         xuHClCbz10su2oqukFa+Dx67m3pnCBgZO8XMpKoueztcik3F9W3yQdhBNX1UuuMZSQQs
         88YQvRbyEY81EFpVMEbKSyJcvJiplAtmzRunxpg6WC5LRw/4YNrcjD7e2FlQNX1jWtTz
         PYZg==
X-Gm-Message-State: ACrzQf3H9P71unH4ccpczn8jizfVIxuf9174HwsU4aWHlBg4PGDKcLJW
        1J4f5BCiOUjiYGjsOQgAfJadn8KKt+fMi8Yn03Sj86hOQ7xO4sqF3PCnr9ReCUaleCWNFuL5Q0W
        3fJoNi+VkHOWtzNrNxn0ij/BU
X-Received: by 2002:a5d:6485:0:b0:226:ecf9:359c with SMTP id o5-20020a5d6485000000b00226ecf9359cmr4764181wri.17.1663925196552;
        Fri, 23 Sep 2022 02:26:36 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM61+EyXP0DrQbd5lBD5JiT0UCPQrcmRDCgUpYVonrMG8qw0pJ6zzDkEJadTs5GlFRxQTExixQ==
X-Received: by 2002:a5d:6485:0:b0:226:ecf9:359c with SMTP id o5-20020a5d6485000000b00226ecf9359cmr4764139wri.17.1663925196203;
        Fri, 23 Sep 2022 02:26:36 -0700 (PDT)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bj1-20020a0560001e0100b0022b0214cfa6sm8514250wrb.45.2022.09.23.02.26.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 02:26:35 -0700 (PDT)
Message-ID: <b3c4ee65-fc56-f54c-3946-b6524fb36f72@redhat.com>
Date:   Fri, 23 Sep 2022 11:26:34 +0200
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
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <49ea7c7c-7d4c-8348-ea75-e0f376111e4c@suse.de>
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

On 9/23/22 11:15, Thomas Zimmermann wrote:
> Hi
> 
> Am 22.09.22 um 16:25 schrieb Maxime Ripard:
>> drm_connector_pick_cmdline_mode() is in charge of finding a proper
>> drm_display_mode from the definition we got in the video= command line
>> argument.
>>
>> Let's add some unit tests to make sure we're not getting any regressions
>> there.
>>
>> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
>>
>> diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
>> index bbc535cc50dd..d553e793e673 100644
>> --- a/drivers/gpu/drm/drm_client_modeset.c
>> +++ b/drivers/gpu/drm/drm_client_modeset.c
>> @@ -1237,3 +1237,7 @@ int drm_client_modeset_dpms(struct drm_client_dev *client, int mode)
>>   	return ret;
>>   }
>>   EXPORT_SYMBOL(drm_client_modeset_dpms);
>> +
>> +#ifdef CONFIG_DRM_KUNIT_TEST
>> +#include "tests/drm_client_modeset_test.c"
>> +#endif
> 
> I strongly dislike this style of including source files in each other. 
> It's a recipe for all kind of build errors. Can you do something else?
>

This seems to be the convention used to test static functions and what's
documented in the Kunit docs: https://kunit.dev/third_party/kernel/docs/tips.html#testing-static-functions

I agree with you that's not ideal but I think that consistency with how
it is done by other subsystems is also important.
 
> As the tested function is an internal interface, maybe export a wrapper 
> if tests are enabled, like this:
> 
> #ifdef CONFIG_DRM_KUNIT_TEST
> struct drm_display_mode *
> drm_connector_pick_cmdline_mode_kunit(drm_conenctor)
> {
>    return drm_connector_pick_cmdline_mode(connector)
> }
> EXPORT_SYMBOL(drm_connector_pick_cmdline_mode_kunit)
> #endif
> 
> The wrapper's declaration can be located in the kunit test file.
> 

But that's also not nice since we are artificially exposing these only
to allow the static functions to be called from unit tests. And would
be a different approach than the one used by all other subsystems...

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6177604CE1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 18:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbiJSQPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 12:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiJSQPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 12:15:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEF610F880
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 09:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666196096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MbItCuma0jqN4EUeN5bMBZ7U9i6ECoLYFYE+AZJbntk=;
        b=IHorWB7YIXvb1st5R6mCD7+34fHx9/XeqmP+Ly/bJ18L6P+bWJtdtZHkNGzmvxaDZ9NUct
        9hvgIDUb+gUmTs+a9kF8IC4zCiKS8fgosPun3kiPDAQ9t/vGKrcS59vT6aZVAgKkjuJdtY
        g5dsDfDwTU/R6v+BJeGiVni4fmEV0ik=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-32--5u0JL8-PsiGsgJA6UJTnw-1; Wed, 19 Oct 2022 12:14:55 -0400
X-MC-Unique: -5u0JL8-PsiGsgJA6UJTnw-1
Received: by mail-wm1-f72.google.com with SMTP id ay12-20020a05600c1e0c00b003c6e18d9aa8so219613wmb.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 09:14:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MbItCuma0jqN4EUeN5bMBZ7U9i6ECoLYFYE+AZJbntk=;
        b=HNouZ4mUUthj741AlDsW7eNOtHThgKwn6FBbPzc1X92LAu0sZwyDa+JIaNNsUu9T5K
         XpjnK78Iy/DYXK/Sdq0PA8GXYPWToLx8tQvNG3vZm48J4Xi1/PxxhQt7pldv7jnklZRi
         3Fxmzw50Hgby58FbUjlQTNe0J+ho5OiJec/gAJdNcsHd9bRtDsTuElSI9HplVkDfbjJG
         tcOT3cfy1v4+m6Xdj/l06bSC1/K6aEq7KKWF59xtxvdwAIFBLStwA4hUJj0TPcGXH1M3
         /LFuy1aK4gVjOrZf5x5gpM9QLXFbMXPEmMzp+wAAYAmuseZycQ1lDoLn6g2ebFfWcxix
         XOXw==
X-Gm-Message-State: ACrzQf3UkD+JmsguX7FTikJLXEi6b8k7dmsaPhKVBCH1Kx11zFbTHVBn
        dkYsBIlq+9mwqgzPPF9CNjTkV0zhFYGsELIk/F5EixWO0z9BO77GhQopeTr2x07AYCoEPI/BmDX
        NaccdGa0LKGWmPtJ+MuwnCLGI
X-Received: by 2002:a05:600c:198a:b0:3c6:f6b4:68d5 with SMTP id t10-20020a05600c198a00b003c6f6b468d5mr6021761wmq.14.1666196094161;
        Wed, 19 Oct 2022 09:14:54 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6vdbvnH2yoFTpFVq2h0lq5YfLyz+nFvkZbyXTZtXkrDwcfTEWrdFEyZiQJIRLM7SOWVN9KGQ==
X-Received: by 2002:a05:600c:198a:b0:3c6:f6b4:68d5 with SMTP id t10-20020a05600c198a00b003c6f6b468d5mr6021744wmq.14.1666196093896;
        Wed, 19 Oct 2022 09:14:53 -0700 (PDT)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c315100b003b4a68645e9sm318176wmo.34.2022.10.19.09.14.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 09:14:53 -0700 (PDT)
Message-ID: <0a8e925f-4ad7-82ab-dd16-b2c0bf5aba48@redhat.com>
Date:   Wed, 19 Oct 2022 18:14:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] drm: tests: Fix a buffer overflow in format_helper_test
Content-Language: en-US
To:     =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>,
        David Gow <davidgow@google.com>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>, kunit-dev@googlegroups.com
References: <20221019073239.3779180-1-davidgow@google.com>
 <6bb18060-158a-a2e7-3382-5d42813fe247@riseup.net>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <6bb18060-158a-a2e7-3382-5d42813fe247@riseup.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/22 13:36, Maíra Canal wrote:
> [cc Javier]
> 
> Hi David,
> 
> On 10/19/22 04:32, David Gow wrote:
>> The xrgb2101010 format conversion test (unlike for other formats) does
>> an endianness conversion on the results. However, it always converts
>> TEST_BUF_SIZE 32-bit integers, which results in reading from (and
>> writing to) more memory than in present in the result buffer. Instead,
>> use the buffer size, divided by sizeof(u32).
>>
>> The issue could be reproduced with KASAN:
>> ./tools/testing/kunit/kunit.py run --kunitconfig drivers/gpu/drm/tests \
>> 	--kconfig_add CONFIG_KASAN=y --kconfig_add CONFIG_KASAN_VMALLOC=y \
>> 	--kconfig_add CONFIG_KASAN_KUNIT_TEST=y \
>> 	drm_format_helper_test.*xrgb2101010
>>
>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>> Fixes: 453114319699 ("drm/format-helper: Add KUnit tests for drm_fb_xrgb8888_to_xrgb2101010()")
>> Signed-off-by: David Gow <davidgow@google.com>
> 
> Reviewed-by: Maíra Canal <mairacanal@riseup.net>
>

The fix makes sense to me as well,

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

>> ---
>>
>> This is a fix for the issue reported here:
>> https://lore.kernel.org/dri-devel/CA+G9fYsuc9G+RO81E=vHMqxYStsmLURLdOB0NF26kJ1=K8pRZA@mail.gmail.com/
>>
>> Note that it may conflict with the KUNIT_EXPECT_MEMEQ() series here:
>> https://lore.kernel.org/linux-kselftest/20221018190541.189780-1-mairacanal@riseup.net/
> 
> I believe this patch will go to the drm-misc-fixes tree, so I can rebase
> the series (and address the format issues) as this patch hits mainline.
> 

Awesome. I assume you are pushing to drm-misc-fixes then?

Thanks a lot David and Maíra for taking care of this!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


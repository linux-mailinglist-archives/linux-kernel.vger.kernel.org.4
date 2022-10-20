Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69462605940
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 10:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbiJTID0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 04:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiJTIDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 04:03:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABC4B7D2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 01:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666253002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=waCjQCfwppA2aPm9Bjke6nadkkOrugb8P9JFyMBn6xs=;
        b=MIKSh6UReZFaA+2V1xcBr+c14HigJxXrGiOkMSgyUCFhXxfFNlEQB3l0Mbe1B7QPcyQvQ2
        9NEJIcMTR1N0MLbQthXw3K4YOH0yV6TTMBBx9Pt6Aw2kFmtKG2Te38LA5Mmsef+psK3Zda
        cGRG6O7voGlBZWuQWSlbqNr1k8lafEs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-673-6yVVaNfrNn2JBFsFznFH3A-1; Thu, 20 Oct 2022 04:03:21 -0400
X-MC-Unique: 6yVVaNfrNn2JBFsFznFH3A-1
Received: by mail-wm1-f72.google.com with SMTP id h131-20020a1c2189000000b003c56437e529so1301448wmh.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 01:03:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=waCjQCfwppA2aPm9Bjke6nadkkOrugb8P9JFyMBn6xs=;
        b=tDS8gda0K6RzmqKX5TLMHHcUzQgFjluhFY6455LKIwIiHwBvevSam/ZneZOfR8du5A
         bQhp34R/nr+3GiWkUZqcAcTx52Tyz3RSv+5S8wSj+Z//mIuR8jXJwFK4F8gHiEJsWnWG
         1NzFg5CDQSeajj8OGntWWt+MWh6fPaLFoXuNivwMBRg9lzygZOY89iYGN7iXG51wUzPr
         WtOOGG1AZLatqMNmJvWT8dQZt8MjfT6WXESagEN1HVzsUi5X4zGM45OyieBkQmrV8VWK
         5F8Ot/XGiNAQmBvdy3oQi00PyjEWorxq91CbU7uoxJcz9ggp/gBXcgkP0riFttVCbLTH
         wuVg==
X-Gm-Message-State: ACrzQf0NxclXC9s5h7oRsGSoFQVGDy/7wk4AexQ7sguGUOLviyNB0ZEa
        eN6ti8sfHulTQk3w9RXXR5J8HtO/kNCjj5VZT0d6mdr/oRvqKCW0hw1AABrXvZR6HrwLkPaFCOL
        CB7CpLFX1dyRguQ5XXlbGJJCA
X-Received: by 2002:a05:6000:381:b0:232:2e1:48e9 with SMTP id u1-20020a056000038100b0023202e148e9mr7312409wrf.166.1666252995603;
        Thu, 20 Oct 2022 01:03:15 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7ulwDJYH7rDLTb3QU26mPIMsuJ5xkAL8KfoFx5HmES2IzbZ5noKDyuYPrthkmLGZhy0jL98A==
X-Received: by 2002:a05:6000:381:b0:232:2e1:48e9 with SMTP id u1-20020a056000038100b0023202e148e9mr7312386wrf.166.1666252995383;
        Thu, 20 Oct 2022 01:03:15 -0700 (PDT)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id k2-20020a5d6e82000000b0022ccae2fa62sm15714340wrz.22.2022.10.20.01.03.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 01:03:15 -0700 (PDT)
Message-ID: <5639218e-bcc8-55b0-ea30-7bf2b26c92b9@redhat.com>
Date:   Thu, 20 Oct 2022 10:03:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] drm: tests: Fix a buffer overflow in format_helper_test
Content-Language: en-US
To:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        David Gow <davidgow@google.com>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>,
        dri-devel@lists.freedesktop.org, Sam Ravnborg <sam@ravnborg.org>,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Functional Testing <lkft@linaro.org>
References: <20221019073239.3779180-1-davidgow@google.com>
 <20221019172919.GA5336@elementary>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221019172919.GA5336@elementary>
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

On 10/19/22 19:29, José Expósito wrote:

[...]

>>  drivers/gpu/drm/tests/drm_format_helper_test.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/tests/drm_format_helper_test.c b/drivers/gpu/drm/tests/drm_format_helper_test.c
>> index 8d86c250c2ec..2191e57f2297 100644
>> --- a/drivers/gpu/drm/tests/drm_format_helper_test.c
>> +++ b/drivers/gpu/drm/tests/drm_format_helper_test.c
>> @@ -438,7 +438,7 @@ static void drm_test_fb_xrgb8888_to_xrgb2101010(struct kunit *test)
>>  	iosys_map_set_vaddr(&src, xrgb8888);
>>  
>>  	drm_fb_xrgb8888_to_xrgb2101010(&dst, &result->dst_pitch, &src, &fb, &params->clip);
>> -	buf = le32buf_to_cpu(test, buf, TEST_BUF_SIZE);
>> +	buf = le32buf_to_cpu(test, buf, dst_size / sizeof(u32));
>>  	KUNIT_EXPECT_EQ(test, memcmp(buf, result->expected, dst_size), 0);
>>  }
> 
> Thanks a lot for fixing this bug David, I just tested it and
> worked as expected.
>

I've pushed this to drm-misc (drm-misc-fixes) now. Thanks!
 
> Do you think that we should update the other calls to
> le32buf_to_cpu() to follow a similar approach?
>

Feel free to post follow-up patches if you think that other changes are needed.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


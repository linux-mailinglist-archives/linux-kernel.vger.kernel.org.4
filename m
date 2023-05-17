Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA3B7062AE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjEQIX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjEQIXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:23:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FBB3AA3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684311789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VPgFwMHasDb9bvAH4GI6Rm6bz1uRxsTcEFjFfM1iNLQ=;
        b=a90Ni1nWAFO+Z/9s3fhiYX5mqPX+0sjdrqhKno2w6FH58kLTqzzM9TmhXrsl2FZ9t1FaYb
        ep9GYBLJ58omn87GHXYu6Fwx3ZWK85JcO3WTCTpt/Lk2Pvzes+QAjVut+q+USJPd+npMuR
        U9T2k0P6RhXo16vLfTz2CcciGueg0Bg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-tIOK7K1fNKKSdffL_sWMCQ-1; Wed, 17 May 2023 04:23:08 -0400
X-MC-Unique: tIOK7K1fNKKSdffL_sWMCQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3063a78f8a4so173611f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:23:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684311787; x=1686903787;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VPgFwMHasDb9bvAH4GI6Rm6bz1uRxsTcEFjFfM1iNLQ=;
        b=hhJEjioGhIffQPDhUKChiwQfit5EDrkoXATnwb9j3ol3XQ6T/mndzkpw4rPYRZrvs/
         6mztcn3bbY0isy5afGqV2NHbloAowDTHfUlh4kESvq1q5eB2Ru4jI4yiMVW24jcY4SVx
         hBIHy/HQIX66/MDp1pcfPZUfe9g7absFn22X3iiqQumda1rWFku5s72UGf0WNdyRXIMS
         2QJpBgMfTH5MuCIKP8jVeIx19WWKvit9dpMwRCguE7MMSFFmr3/zy5cKAmjUdbtqn3rq
         +i5utfql3HpPxYJscVdf2rxxK8ZYV6gcuaGG+/yi9k3E58BioJtKj3MpOA5XNNfbQ//C
         I0rw==
X-Gm-Message-State: AC+VfDz06yTnZ9FUN/seEDApDafod1wWVo47zKfVpczlfx/tuX2tWkl3
        FkgvnSXa6dxsPlvn7HYD8fWmZt5d33MGdEo0l4kcwTY6bA+vjaRK6WmDH9lIjtKhaLga5P+gfAs
        MgyNncEL0r17bg+heRDmev8gIlIxTmCWQ
X-Received: by 2002:a5d:51c4:0:b0:306:37ec:656c with SMTP id n4-20020a5d51c4000000b0030637ec656cmr28918909wrv.66.1684311786830;
        Wed, 17 May 2023 01:23:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6M2uLU82YgDtnZphHrdIC+Rvaqz4YsdmT6TRA4ZG9SePYW6tS+JLljZ93sqdsd1l3FA7fDOg==
X-Received: by 2002:a5d:51c4:0:b0:306:37ec:656c with SMTP id n4-20020a5d51c4000000b0030637ec656cmr28918891wrv.66.1684311786493;
        Wed, 17 May 2023 01:23:06 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id z3-20020a5d6543000000b002fda1b12a0bsm1962102wrv.2.2023.05.17.01.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 01:23:06 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Dana Elfassy <delfassy@redhat.com>, eballetb@redhat.com,
        dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Dana Elfassy <dangel101@gmail.com>
Subject: Re: [PATCH] Input: tests: add test to cover all input_grab_device()
 function
In-Reply-To: <20230516162412.461066-1-dangel101@gmail.com>
References: <20230516162412.461066-1-dangel101@gmail.com>
Date:   Wed, 17 May 2023 10:23:05 +0200
Message-ID: <87a5y39xjq.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dana Elfassy <delfassy@redhat.com> writes:

Hello Dana,

Is great to see more input Kunit tests being added, thanks!

> Currently input_grab_device() isn't covered by any tests
> Thus, adding a test to cover the cases:
> 1. The device is grabbed successfully
> 2. Trying to grab a device that is already grabbed by another input
>    handle
>
> Signed-off-by: Dana Elfassy <dangel101@gmail.com>
> ---

I tested this and it worked for me:

$ ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/input/tests/.kunitconfig
...
[09:36:42] Starting KUnit Kernel (1/1)...
[09:36:42] ============================================================
[09:36:43] ================= input_core (4 subtests) ==================
[09:36:43] [PASSED] input_test_polling
[09:36:43] [PASSED] input_test_timestamp
[09:36:43] [PASSED] input_test_match_device_id
[09:36:43] [PASSED] input_test_grab
[09:36:43] =================== [PASSED] input_core ====================
[09:36:43] ============================================================
[09:36:43] Testing complete. Ran 4 tests: passed: 4
[09:36:43] Elapsed time: 129.985s total, 5.005s configuring, 124.864s building, 0.062s running

>  drivers/input/tests/input_test.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/drivers/input/tests/input_test.c b/drivers/input/tests/input_test.c
> index 25bbf51b5c87..cd4db365e9fa 100644
> --- a/drivers/input/tests/input_test.c
> +++ b/drivers/input/tests/input_test.c
> @@ -124,10 +124,38 @@ static void input_test_match_device_id(struct kunit *test)
>  	KUNIT_ASSERT_FALSE(test, input_match_device_id(input_dev, &id));
>  }
>  
> +
> +static void input_test_grab(struct kunit *test)
> +{
> +	struct input_dev *input_dev = test->priv;
> +	struct input_handle test_handle;
> +	struct input_handler handler;
> +	struct input_handle handle;
> +	struct input_device_id id;
> +	int res;
> +
> +	handler.name = "handler";
> +	handler.id_table = &id;
> +
> +	handle.dev = input_get_device(input_dev);
> +	handle.name = dev_name(&input_dev->dev);
> +	handle.handler = &handler;
> +	res = input_grab_device(&handle);
> +	KUNIT_ASSERT_TRUE(test, input_grab_device(&handle));
> +

I think you need to add a input_put_device(input_dev) here ?

Otherwise the reference counter won't be decremented.

> +	test_handle.dev = input_get_device(input_dev);
> +	test_handle.name = dev_name(&input_dev->dev);
> +	test_handle.handler = &handler;
> +

I think you can just reuse the handle variable that was set-up before ?

There's no need to another test_handle variable as far as I can tell.

> +	res = input_grab_device(&test_handle);
> +	KUNIT_ASSERT_EQ(test, res, -EBUSY);

And here add an input_put_device(input_dev) call too.

Other than that the patch looks good to me.

Tested-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


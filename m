Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590C8604439
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbiJSMAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbiJSL7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 07:59:14 -0400
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A58125025
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 04:37:48 -0700 (PDT)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx0.riseup.net (Postfix) with ESMTPS id 4MspbW5lZGz9s5l;
        Wed, 19 Oct 2022 11:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1666179400; bh=XNRu1Rf9naUAJQEIgFaBHnDvkIAFylt64W6tU7GWOPA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AEP6eBMpzpg0qqmPUrGOJnW8tA8W1Lo3kJRd2LZqJFxfVz/kw2wFzqF/Fx1HPcnpf
         Wl5eFKwCkx4xfGCx3GEJG7QgRjoxJiyw25wTd9q0W9mjJjysGpvQ157MKDr8pXbM9s
         R6Tk3PIuF7Qo9bwqEZeFwRxVNc2Cw/3v8c+7IHjs=
X-Riseup-User-ID: 58E92BB22A38AF861FEE21ECADB592288A3AFBBE2166EE8C766289763651D038
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4MspbR1Wrzz5vXG;
        Wed, 19 Oct 2022 11:36:34 +0000 (UTC)
Message-ID: <6bb18060-158a-a2e7-3382-5d42813fe247@riseup.net>
Date:   Wed, 19 Oct 2022 08:36:31 -0300
MIME-Version: 1.0
Subject: Re: [PATCH] drm: tests: Fix a buffer overflow in format_helper_test
To:     David Gow <davidgow@google.com>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>, kunit-dev@googlegroups.com,
        Javier Martinez Canillas <javierm@redhat.com>
References: <20221019073239.3779180-1-davidgow@google.com>
Content-Language: en-US
From:   =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>
In-Reply-To: <20221019073239.3779180-1-davidgow@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[cc Javier]

Hi David,

On 10/19/22 04:32, David Gow wrote:
> The xrgb2101010 format conversion test (unlike for other formats) does
> an endianness conversion on the results. However, it always converts
> TEST_BUF_SIZE 32-bit integers, which results in reading from (and
> writing to) more memory than in present in the result buffer. Instead,
> use the buffer size, divided by sizeof(u32).
> 
> The issue could be reproduced with KASAN:
> ./tools/testing/kunit/kunit.py run --kunitconfig drivers/gpu/drm/tests \
> 	--kconfig_add CONFIG_KASAN=y --kconfig_add CONFIG_KASAN_VMALLOC=y \
> 	--kconfig_add CONFIG_KASAN_KUNIT_TEST=y \
> 	drm_format_helper_test.*xrgb2101010
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Fixes: 453114319699 ("drm/format-helper: Add KUnit tests for drm_fb_xrgb8888_to_xrgb2101010()")
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Maíra Canal <mairacanal@riseup.net>

> ---
> 
> This is a fix for the issue reported here:
> https://lore.kernel.org/dri-devel/CA+G9fYsuc9G+RO81E=vHMqxYStsmLURLdOB0NF26kJ1=K8pRZA@mail.gmail.com/
> 
> Note that it may conflict with the KUNIT_EXPECT_MEMEQ() series here:
> https://lore.kernel.org/linux-kselftest/20221018190541.189780-1-mairacanal@riseup.net/

I believe this patch will go to the drm-misc-fixes tree, so I can rebase
the series (and address the format issues) as this patch hits mainline.

Best Regards,
- Maíra Canal

> 
> Cheers,
> -- David
> 
> ---
>  drivers/gpu/drm/tests/drm_format_helper_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/tests/drm_format_helper_test.c b/drivers/gpu/drm/tests/drm_format_helper_test.c
> index 8d86c250c2ec..2191e57f2297 100644
> --- a/drivers/gpu/drm/tests/drm_format_helper_test.c
> +++ b/drivers/gpu/drm/tests/drm_format_helper_test.c
> @@ -438,7 +438,7 @@ static void drm_test_fb_xrgb8888_to_xrgb2101010(struct kunit *test)
>  	iosys_map_set_vaddr(&src, xrgb8888);
>  
>  	drm_fb_xrgb8888_to_xrgb2101010(&dst, &result->dst_pitch, &src, &fb, &params->clip);
> -	buf = le32buf_to_cpu(test, buf, TEST_BUF_SIZE);
> +	buf = le32buf_to_cpu(test, buf, dst_size / sizeof(u32));
>  	KUNIT_EXPECT_EQ(test, memcmp(buf, result->expected, dst_size), 0);
>  }
>  

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B0C6038A8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 05:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiJSDgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 23:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJSDfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 23:35:54 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC525BC38
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 20:35:53 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id 1so12343313vsx.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 20:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=01MkUrtz06iY1/5W2LF1Z1hSoqZsoYSY8CNKXyHUaX4=;
        b=ZjnFdCr+UJWr8f2qFAFv0uKyT6ulpur4KlqbbdlINtShXHogZHR5adUYqMTEU2mDzW
         QEyA0EnLDXEXiRaa2kK0JzOblrfjEyH9fz05MD0wLhxmljUvFfEJf0LyN5c3fL1sPz8u
         hvquQ97f8SUJOYCpkYOU+fTPFevDqKNwvs8Bqt4wvQ1D9g2xg5TjkRzMkBnKiZwU/IUy
         sCfXxL+VGX2B06gLBUYS0eIbVHdmfw41Hs2/GyKKGp2aC+2rGHF95kIQPiQjILlDTVTc
         nTcioONL7dl+zhPPozusBIUnLjE0bZ2gh4dBgl/S2kd4ppdvvBD3Ptn3VWfAjpBCPgPf
         +9kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=01MkUrtz06iY1/5W2LF1Z1hSoqZsoYSY8CNKXyHUaX4=;
        b=bfYLF/zr4THJhe+ITCJZ7CmaklzvfJOLSrkKj77zbE3enF5PO0AoZ8pfefglSPlpJ+
         KIP5H6D82qb+IqaOmIyQQChgGHxnBcp9+iqrmDdu6qUJJ6dfR6vNVDBit2dzUi0gs7SO
         i1fPSwLe7uHM/lbAPoBEPAwfDDobXXVtB1XKTWI9e6gCMFyT423+voLJz9eT9sBFrtMS
         kOzAig7pEaXCgMKA2som/Z8oYDOW1VCEENDjuF/9ZkWSYArLYfMaUG+JtdO72bUt2aJ8
         tKegv6ncZ9va+j1DdOx+T160PW1eYwLRI7q1VpIfyS/8NIjxsHtmbwWdbK/abMzGDfwQ
         2IQQ==
X-Gm-Message-State: ACrzQf1M0H/tzV3k/iMEVXwoRAxWTJCETJQvoC8iDIuaUUFJrTdP9YYx
        qUipLE6zVsr8ZvU5x3tCgbxjShCyO4ZWZ+HMNFoiXQ==
X-Google-Smtp-Source: AMsMyM42qKx7H2OEDR8qmDbn2PqlzYhTtY+gpImi6zS3XYvpht8BWN2XRLhEYvM+MRB+k0TGucjmAs0rOEPHzHV7WYw=
X-Received: by 2002:a67:d20b:0:b0:3a7:2b99:bab8 with SMTP id
 y11-20020a67d20b000000b003a72b99bab8mr3104458vsi.35.1666150552345; Tue, 18
 Oct 2022 20:35:52 -0700 (PDT)
MIME-Version: 1.0
References: <20221018082559.never.406-kees@kernel.org>
In-Reply-To: <20221018082559.never.406-kees@kernel.org>
From:   David Gow <davidgow@google.com>
Date:   Wed, 19 Oct 2022 11:35:40 +0800
Message-ID: <CABVgOSneaxVgAQH=bN0pxOkN3irtpYVwFhPhNJRoyTcRfEoWhQ@mail.gmail.com>
Subject: Re: [PATCH] kunit/fortify: Validate __alloc_size attribute results
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 4:27 PM Kees Cook <keescook@chromium.org> wrote:
>
> Validate the effect of the __alloc_size attribute on allocators. If the
> compiler doesn't support __builtin_dynamic_object_size(), skip the test.
>
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> To pass this depends on the following patches:
> https://lore.kernel.org/lkml/20221018073430.never.551-kees@kernel.org/
> https://lore.kernel.org/lkml/20221018082232.never.213-kees@kernel.org/
> To not be skipped, either GCC 12 or Clang is needed.
> ---

While this _looks_ good, I can't actually get the tests to pass on my
machine, with the following all having a
__builtin_dynamic_object_size() of -1:
- kmalloc_node(size++, gfp, NUMA_NO_NODE)
- kzalloc(size++, gfp)
- kzalloc_node(size++, gfp, NUMA_NO_NODE)
- kcalloc(1, size++, gfp)
- kcalloc_node(1, size++, gfp, NUMA_NO_NODE)
- kmalloc_array(1, size++, gfp)
- kmalloc_array_node(1, size++, gfp, NUMA_NO_NODE)

I've been using the following command to run the tests:
./tools/testing/kunit/kunit.py run --kconfig_add CONFIG_FORTIFY_SOURCE=y

And I've also tried it on x86_64 and arm64 under qemu, with both gcc
12.2.0 and clang 14.0.6-2, with the same failures.

Is there a dependency somewhere I've missed? (I've tried it on the
ksefltest/kunit branch, with the mentioned dependencies applied, and
also on your for-next/hardening branch, with the missing patches
applied.)

Cheers,
-- David

>  lib/fortify_kunit.c | 92 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 92 insertions(+)
>
> diff --git a/lib/fortify_kunit.c b/lib/fortify_kunit.c
> index 409af07f340a..5076ba11adfd 100644
> --- a/lib/fortify_kunit.c
> +++ b/lib/fortify_kunit.c
> @@ -16,7 +16,10 @@
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>
>  #include <kunit/test.h>
> +#include <linux/device.h>
>  #include <linux/string.h>
> +#include <linux/slab.h>
> +#include <linux/vmalloc.h>
>
>  static const char array_of_10[] = "this is 10";
>  static const char *ptr_of_11 = "this is 11!";
> @@ -60,9 +63,98 @@ static void control_flow_split_test(struct kunit *test)
>         KUNIT_EXPECT_EQ(test, want_minus_one(pick), SIZE_MAX);
>  }
>
> +#define check_alloc(alloc, free)       do {                            \
> +       size_t expected = size;                                         \
> +       void *p = alloc;                                                \
> +       KUNIT_EXPECT_TRUE_MSG(test, p != NULL, #alloc " failed?!\n");   \
> +       KUNIT_EXPECT_EQ_MSG(test, __builtin_dynamic_object_size(p, 1),  \
> +               expected,                                               \
> +               "__alloc_size() not working with " #alloc "\n");        \
> +       free;                                                           \
> +} while (0)
> +
> +static volatile size_t unknown_size = 50;
> +
> +static void alloc_size_test(struct kunit *test)
> +{
> +#if !__has_builtin(__builtin_dynamic_object_size)
> +       kunit_skip(test, "Compiler is missing __builtin_dynamic_object_size() support\n");
> +#else
> +       const char device_name[] = "fortify-test";
> +       struct device *dev;
> +       gfp_t gfp = GFP_KERNEL | __GFP_NOWARN;
> +       size_t size = unknown_size, prev_size;
> +       void *orig;
> +
> +       /* kmalloc()-family */
> +       check_alloc(kmalloc(size++, gfp),                       kfree(p));
> +       check_alloc(kmalloc_node(size++, gfp, NUMA_NO_NODE),    kfree(p));
> +       check_alloc(kzalloc(size++, gfp),                       kfree(p));
> +       check_alloc(kzalloc_node(size++, gfp, NUMA_NO_NODE),    kfree(p));
> +       check_alloc(kcalloc(1, size++, gfp),                    kfree(p));
> +       check_alloc(kcalloc_node(1, size++, gfp, NUMA_NO_NODE), kfree(p));
> +       check_alloc(kmalloc_array(1, size++, gfp),              kfree(p));
> +       check_alloc(kmalloc_array_node(1, size++, gfp, NUMA_NO_NODE), kfree(p));
> +       check_alloc(__kmalloc(size++, gfp),                     kfree(p));
> +       check_alloc(__kmalloc_node(size++, gfp, NUMA_NO_NODE),  kfree(p));
> +
> +       /* kmemdup() */
> +       prev_size = size;
> +       size = 11;
> +       check_alloc(kmemdup("hello there", size, gfp),          kfree(p));
> +       size = prev_size + 1;
> +
> +       /* krealloc()-family */
> +       orig = kmalloc(size++, gfp);
> +       check_alloc(krealloc(orig, size++, gfp),                kfree(p));
> +       orig = kmalloc(size++, gfp);
> +       check_alloc(krealloc_array(orig, 1, size++, gfp),       kfree(p));
> +
> +       /* vmalloc()-family */
> +       check_alloc(vmalloc(size++),                            vfree(p));
> +       check_alloc(vzalloc(size++),                            vfree(p));
> +       check_alloc(__vmalloc(size++, gfp),                     vfree(p));
> +
> +       /* kvalloc()-family */
> +       check_alloc(kvmalloc(size++, gfp),                      kvfree(p));
> +       check_alloc(kvmalloc_node(size++, gfp, NUMA_NO_NODE),   kvfree(p));
> +       check_alloc(kvzalloc(size++, gfp),                      kvfree(p));
> +       check_alloc(kvzalloc_node(size++, gfp, NUMA_NO_NODE),   kvfree(p));
> +       check_alloc(kvcalloc(1, size++, gfp),                   kvfree(p));
> +       check_alloc(kvmalloc_array(1, size++, gfp),             kvfree(p));
> +
> +       /* kvrealloc() */
> +       prev_size = size++;
> +       orig = kvmalloc(prev_size, gfp);
> +       check_alloc(kvrealloc(orig, prev_size, size++, gfp),    kfree(p));
> +
> +       /* Create dummy device for devm_kmalloc()-family tests. */
> +       dev = root_device_register(device_name);
> +       KUNIT_ASSERT_FALSE_MSG(test, IS_ERR(dev),
> +                              "Cannot register test device\n");
> +
> +       /* devm_kmalloc()-family */
> +       check_alloc(devm_kmalloc(dev, size++, gfp),             devm_kfree(dev, p));
> +       check_alloc(devm_kzalloc(dev, size++, gfp),             devm_kfree(dev, p));
> +
> +       /* devm_kmemdup() */
> +       prev_size = size;
> +       size = 4;
> +       check_alloc(devm_kmemdup(dev, "Ohai", size, gfp),       devm_kfree(dev, p));
> +       size = prev_size + 1;
> +
> +       /* devm_kremalloc() */
> +       orig = devm_kmalloc(dev, size++, gfp);
> +       check_alloc(devm_krealloc(dev, orig, size++, gfp),      devm_kfree(dev, p));
> +
> +       device_unregister(dev);
> +#endif
> +}
> +
>  static struct kunit_case fortify_test_cases[] = {
>         KUNIT_CASE(known_sizes_test),
>         KUNIT_CASE(control_flow_split_test),
> +       KUNIT_CASE(alloc_size_test),
>         {}
>  };
>
> --
> 2.34.1
>

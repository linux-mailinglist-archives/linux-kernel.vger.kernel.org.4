Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E88C6039C8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 08:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiJSGaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 02:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiJSGaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 02:30:01 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E93E371AC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 23:29:57 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id f4so6641194uav.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 23:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WO7BsK5DpnSO6Nm64A8lJ13hOjutvEHo3IbSt82zwn0=;
        b=tGHkSey3h0Jb5vKl8QhAURPHbmfN0cT9oKbxT09ZRoggnfPU9gaM4iREOSDl+plFn1
         Jy5btsxvZHzaw/glJ7X4tSSYEsf+/zRvw76S04N5IBwtpuwhY97+mLLHcQSTu/JLJTA+
         Pc//9ugQLUAW0XvXy/u4f81p0JwZe6vMMP6GZWTTmg2CdyPDUIzHlGEn+qdFfJffcrei
         xHTq3dUkZs6oJvb6jJlvECtAf2krQM4uvD3RNSosCJjcbxJeekHJQMh0nWttUnQ0n50b
         GQAWIrn5x2bwHIJ1zPKqEhGc0mIYeY1BlmpX+MUXZgDfYN2SXGSkdT8ghSEsEVpKFmNO
         d6rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WO7BsK5DpnSO6Nm64A8lJ13hOjutvEHo3IbSt82zwn0=;
        b=J+RYzZzXzX4vunbQacPW/T4z0mzWZPsS/vrKx3vuTzMPraPwHcyq57B7mZ2wo2uUNR
         zyFBn++axIqtwFfVxezga3TpmKW7spz9BQSzFuthTxDTtM7Jc1mZIzZgCkm/cCYBh/e0
         qB7VtPpoSe1fOzlMJqL2SZFf4YurY/agqu/oSikJd2rPAxo8yY1TpM0NmWkRSI9p+0qU
         CMhXiNWqAL3R5U2mC/HtljDxWCiQfLNCqfpZ4DDh7TMGv4BvlSPKqodGMdXvgK87/Oyn
         xomax8s0Qwilto1P0QX0kUpsq2DRv1uxeMmP16vyYToAzdA3O80vZPppgWxY51KMHUle
         +1Mg==
X-Gm-Message-State: ACrzQf3cf8bL9B3lfVEjCgisON7G7n+COD8gEefWoz7LbSuekU7zcE7p
        Nv7km7YaYCuK/wIjniQRLStrFh0pCxji21KtKVsIRg==
X-Google-Smtp-Source: AMsMyM57OjNPrBzasL7MvBgHPVlgDs7vzVuYRSl/mLXTqX46aCt3RAsB53y6ehEESCc5sckcA4XquEE3Wz88cyvcgGc=
X-Received: by 2002:ab0:5a98:0:b0:3e6:5e47:3702 with SMTP id
 w24-20020ab05a98000000b003e65e473702mr3503114uae.104.1666160996231; Tue, 18
 Oct 2022 23:29:56 -0700 (PDT)
MIME-Version: 1.0
References: <20221018082559.never.406-kees@kernel.org> <CABVgOSneaxVgAQH=bN0pxOkN3irtpYVwFhPhNJRoyTcRfEoWhQ@mail.gmail.com>
 <202210182237.C65BCCE2@keescook>
In-Reply-To: <202210182237.C65BCCE2@keescook>
From:   David Gow <davidgow@google.com>
Date:   Wed, 19 Oct 2022 14:29:44 +0800
Message-ID: <CABVgOSn359J8W4DFBO4n8SW=L=-PaVKi9G4R9u67jSBs1zGoGQ@mail.gmail.com>
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

On Wed, Oct 19, 2022 at 1:45 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Oct 19, 2022 at 11:35:40AM +0800, David Gow wrote:
> > On Tue, Oct 18, 2022 at 4:27 PM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > Validate the effect of the __alloc_size attribute on allocators. If the
> > > compiler doesn't support __builtin_dynamic_object_size(), skip the test.
> > >
> > > Cc: linux-hardening@vger.kernel.org
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > ---
> > > To pass this depends on the following patches:
> > > https://lore.kernel.org/lkml/20221018073430.never.551-kees@kernel.org/
> > > https://lore.kernel.org/lkml/20221018082232.never.213-kees@kernel.org/
> > > To not be skipped, either GCC 12 or Clang is needed.
> > > ---
> >
> > While this _looks_ good, I can't actually get the tests to pass on my
> > machine, with the following all having a
> > __builtin_dynamic_object_size() of -1:
> > - kmalloc_node(size++, gfp, NUMA_NO_NODE)
> > - kzalloc(size++, gfp)
> > - kzalloc_node(size++, gfp, NUMA_NO_NODE)
> > - kcalloc(1, size++, gfp)
> > - kcalloc_node(1, size++, gfp, NUMA_NO_NODE)
> > - kmalloc_array(1, size++, gfp)
> > - kmalloc_array_node(1, size++, gfp, NUMA_NO_NODE)
> >
> > I've been using the following command to run the tests:
> > ./tools/testing/kunit/kunit.py run --kconfig_add CONFIG_FORTIFY_SOURCE=y
> >
> > And I've also tried it on x86_64 and arm64 under qemu, with both gcc
> > 12.2.0 and clang 14.0.6-2, with the same failures.
> >
> > Is there a dependency somewhere I've missed? (I've tried it on the
> > ksefltest/kunit branch, with the mentioned dependencies applied, and
> > also on your for-next/hardening branch, with the missing patches
> > applied.)
>
> I would expect this to pass with v6.1-rc1 when used with the above two
> patches added, but it seems those _did_ pass, but not the k*alloc()
> helpers for you? That is curious. Here's my testing:
>
> $ ./tools/testing/kunit/kunit.py run --arch x86_64 \
>         --kconfig_add CONFIG_FORTIFY_SOURCE=y --make_options LLVM=1 fortify
> ...
> [22:43:32] =================== fortify (3 subtests) ===================
> [22:43:32] [PASSED] known_sizes_test
> [22:43:32] [PASSED] control_flow_split_test
> [22:43:32] [PASSED] alloc_size_test
> [22:43:32] ===================== [PASSED] fortify =====================
> [22:43:32] ============================================================
> [22:43:32] Testing complete. Ran 3 tests: passed: 3
> [22:43:32] Elapsed time: 33.210s total, 3.369s configuring, 28.367s
> building, 0.799s running
>
> $ clang --version
> ClangBuiltLinux clang version 16.0.0 (https://github.com/llvm/llvm-project.git 3291eac12340f465084f347720d99352241f621c)
>
>

Running the exact same command here gives the following output (spam incoming):
[13:55:34] Configuring KUnit Kernel ...
[13:55:34] Building KUnit Kernel ...
Populating config with:
$ make ARCH=x86_64 O=.kunit olddefconfig LLVM=1
Building with:
$ make ARCH=x86_64 O=.kunit --jobs=48 LLVM=1
[13:55:43] Starting KUnit Kernel (1/1)...
[13:55:43] ============================================================
Running tests with:
$ qemu-system-x86_64 -nodefaults -m 1024 -kernel
.kunit/arch/x86/boot/bzImage -append 'kunit.filter_glob=fortify
kunit.enable=1 console=ttyS0 kunit_shutdown=reboot' -no-reboot
-nographic -serial stdio
[13:55:44] =================== fortify (3 subtests) ===================
[13:55:44] [PASSED] known_sizes_test
[13:55:44] [PASSED] control_flow_split_test
[13:55:44] # alloc_size_test: EXPECTATION FAILED at lib/fortify_kunit.c:91
[13:55:44] Expected __builtin_dynamic_object_size(p, 1) == expected, but
[13:55:44] __builtin_dynamic_object_size(p, 1) == -1
[13:55:44] expected == 51
[13:55:44] __alloc_size() not working with kmalloc_node(size++, gfp,
NUMA_NO_NODE)
[13:55:44] # alloc_size_test: EXPECTATION FAILED at lib/fortify_kunit.c:92
[13:55:44] Expected __builtin_dynamic_object_size(p, 1) == expected, but
[13:55:44] __builtin_dynamic_object_size(p, 1) == -1
[13:55:44] expected == 52
[13:55:44] __alloc_size() not working with kzalloc(size++, gfp)
[13:55:44] # alloc_size_test: EXPECTATION FAILED at lib/fortify_kunit.c:93
[13:55:44] Expected __builtin_dynamic_object_size(p, 1) == expected, but
[13:55:44] __builtin_dynamic_object_size(p, 1) == -1
[13:55:44] expected == 53
[13:55:44] __alloc_size() not working with kzalloc_node(size++, gfp,
NUMA_NO_NODE)
[13:55:44] # alloc_size_test: EXPECTATION FAILED at lib/fortify_kunit.c:94
[13:55:44] Expected __builtin_dynamic_object_size(p, 1) == expected, but
[13:55:44] __builtin_dynamic_object_size(p, 1) == -1
[13:55:44] expected == 54
[13:55:44] __alloc_size() not working with kcalloc(1, size++, gfp)
[13:55:44] # alloc_size_test: EXPECTATION FAILED at lib/fortify_kunit.c:95
[13:55:44] Expected __builtin_dynamic_object_size(p, 1) == expected, but
[13:55:44] __builtin_dynamic_object_size(p, 1) == -1
[13:55:44] expected == 55
[13:55:44] __alloc_size() not working with kcalloc_node(1, size++,
gfp, NUMA_NO_NODE)
[13:55:44] # alloc_size_test: EXPECTATION FAILED at lib/fortify_kunit.c:96
[13:55:44] Expected __builtin_dynamic_object_size(p, 1) == expected, but
[13:55:44] __builtin_dynamic_object_size(p, 1) == -1
[13:55:44] expected == 56
[13:55:44] __alloc_size() not working with kmalloc_array(1, size++, gfp)
[13:55:44] # alloc_size_test: EXPECTATION FAILED at lib/fortify_kunit.c:97
[13:55:44] Expected __builtin_dynamic_object_size(p, 1) == expected, but
[13:55:44] __builtin_dynamic_object_size(p, 1) == -1
[13:55:44] expected == 57
[13:55:44] __alloc_size() not working with kmalloc_array_node(1,
size++, gfp, NUMA_NO_NODE)
[13:55:44] not ok 3 - alloc_size_test
[13:55:44] [FAILED] alloc_size_test
[13:55:44] # Subtest: fortify
[13:55:44] 1..3
[13:55:44] # fortify: pass:2 fail:1 skip:0 total:3
[13:55:44] # Totals: pass:2 fail:1 skip:0 total:3
[13:55:44] not ok 1 - fortify
[13:55:44] ===================== [FAILED] fortify =====================
[13:55:44] ============================================================
[13:55:44] Testing complete. Ran 3 tests: passed: 2, failed: 1
[13:55:45] Elapsed time: 10.424s total, 0.002s configuring, 8.950s
building, 0.835s running

With:
clang --version
Debian clang version 14.0.6-2
Target: x86_64-pc-linux-gnu
Thread model: posix
InstalledDir: /usr/bin

Same thing with gcc:
gcc (Debian 12.2.0-1) 12.2.0
Copyright (C) 2022 Free Software Foundation, Inc.

I can also reproduce it on a different machine, running openSUSE
Tumbleweed's gcc 12.2 and clang 15.0.2.

It also fails the same way with just the mentioned patches, applied to
torvalds/master at aae803b02f92.

Do you have a specific working tree somewhere public I should try?

-- David

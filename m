Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105C5603958
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 07:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiJSFpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 01:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiJSFpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 01:45:09 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB463341F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 22:45:07 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id q1so15276509pgl.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 22:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eBemMK28cvcD3s5ZlzCkBENL3GdANdLYhobZl+nNUlM=;
        b=VEDFz2MLnoXsifTdRJ5R7VfKV0TZy+j/+7J4xMjNesr1PuVM/4wkgzC2IjIA8NZk30
         xeQygQc+vW+joMykQ7PaS/YMFGFU5+QGHOu/aj9hkniNuJu8jj06VbyhekK25PEKkNgE
         altBFZzxeN0YiAdUYffY7YO3zUiXvAWebFMfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eBemMK28cvcD3s5ZlzCkBENL3GdANdLYhobZl+nNUlM=;
        b=xCZaYhJpbAWZipO6nbm54+4DlxwHZFkup1JOSpN5ennDrt0IgGUwBfT6MmHF5YRHNV
         muTpn9XSRPuNjxT35605UU5SGpneQCkeNwqJ9iEOQ9oseI+0lkBmDyaB6wi/DpRMH4OO
         v/zjnqPKigNnDQY8kyfv5iD40qtlHkV46AkX/sZIDRO7Ip7+MZil1iRFFcTTLp7bIodl
         G3DCpqXggExItpaW6kKxhvdNvrmkpdpk3GXaAZSLg+HmVEnTlDaZl4UBYgtpwie36gK0
         nF58kNfUxLku0/gCRWaULtCit3qchx0EHNpCRxSh5Vp3K7kIs8haYXmIpNAZMua1Nk5C
         MIQQ==
X-Gm-Message-State: ACrzQf09FJVF9KJWi5L4zZyokI6wUgMLv7F+2XmHKZB/rPl1YVX1BpV2
        bXREoRLu1/uvKI9R3I7Dhz35opEqJRs+Mg==
X-Google-Smtp-Source: AMsMyM7uTjzuX2b7YASj7sFnDMO/JJs2z6QPcU2FjLf/CRgRxUZjZYaL88rKVNPcO0UKLqaRtP4mxA==
X-Received: by 2002:a63:83c7:0:b0:46b:2a7b:a65 with SMTP id h190-20020a6383c7000000b0046b2a7b0a65mr5759216pge.169.1666158307502;
        Tue, 18 Oct 2022 22:45:07 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d10-20020a17090a7bca00b00205fafa6768sm12639526pjl.6.2022.10.18.22.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 22:45:06 -0700 (PDT)
Date:   Tue, 18 Oct 2022 22:45:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Gow <davidgow@google.com>
Cc:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kunit/fortify: Validate __alloc_size attribute results
Message-ID: <202210182237.C65BCCE2@keescook>
References: <20221018082559.never.406-kees@kernel.org>
 <CABVgOSneaxVgAQH=bN0pxOkN3irtpYVwFhPhNJRoyTcRfEoWhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVgOSneaxVgAQH=bN0pxOkN3irtpYVwFhPhNJRoyTcRfEoWhQ@mail.gmail.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 11:35:40AM +0800, David Gow wrote:
> On Tue, Oct 18, 2022 at 4:27 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > Validate the effect of the __alloc_size attribute on allocators. If the
> > compiler doesn't support __builtin_dynamic_object_size(), skip the test.
> >
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > To pass this depends on the following patches:
> > https://lore.kernel.org/lkml/20221018073430.never.551-kees@kernel.org/
> > https://lore.kernel.org/lkml/20221018082232.never.213-kees@kernel.org/
> > To not be skipped, either GCC 12 or Clang is needed.
> > ---
> 
> While this _looks_ good, I can't actually get the tests to pass on my
> machine, with the following all having a
> __builtin_dynamic_object_size() of -1:
> - kmalloc_node(size++, gfp, NUMA_NO_NODE)
> - kzalloc(size++, gfp)
> - kzalloc_node(size++, gfp, NUMA_NO_NODE)
> - kcalloc(1, size++, gfp)
> - kcalloc_node(1, size++, gfp, NUMA_NO_NODE)
> - kmalloc_array(1, size++, gfp)
> - kmalloc_array_node(1, size++, gfp, NUMA_NO_NODE)
> 
> I've been using the following command to run the tests:
> ./tools/testing/kunit/kunit.py run --kconfig_add CONFIG_FORTIFY_SOURCE=y
> 
> And I've also tried it on x86_64 and arm64 under qemu, with both gcc
> 12.2.0 and clang 14.0.6-2, with the same failures.
> 
> Is there a dependency somewhere I've missed? (I've tried it on the
> ksefltest/kunit branch, with the mentioned dependencies applied, and
> also on your for-next/hardening branch, with the missing patches
> applied.)

I would expect this to pass with v6.1-rc1 when used with the above two
patches added, but it seems those _did_ pass, but not the k*alloc()
helpers for you? That is curious. Here's my testing:

$ ./tools/testing/kunit/kunit.py run --arch x86_64 \
	--kconfig_add CONFIG_FORTIFY_SOURCE=y --make_options LLVM=1 fortify
...
[22:43:32] =================== fortify (3 subtests) ===================
[22:43:32] [PASSED] known_sizes_test
[22:43:32] [PASSED] control_flow_split_test
[22:43:32] [PASSED] alloc_size_test
[22:43:32] ===================== [PASSED] fortify =====================
[22:43:32] ============================================================
[22:43:32] Testing complete. Ran 3 tests: passed: 3
[22:43:32] Elapsed time: 33.210s total, 3.369s configuring, 28.367s
building, 0.799s running

$ clang --version
ClangBuiltLinux clang version 16.0.0 (https://github.com/llvm/llvm-project.git 3291eac12340f465084f347720d99352241f621c)


-- 
Kees Cook

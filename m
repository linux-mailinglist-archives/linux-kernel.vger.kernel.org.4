Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2B76038CB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 06:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiJSEGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 00:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiJSEGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 00:06:01 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3667576447
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 21:06:00 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id i16so6522781uak.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 21:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rt/UcBSCq3ctx1DKdxEOe9zXd6vUi6e+DDOW65PuwO4=;
        b=RKe187DKCSoCTURbr9ZAU0yWdaK9ahuEJWINssob59FtsoOG+hMisVufWysSTUF2ao
         22JQPrz0XvwsEz7xmdXKqpHpp8PG3Fd2ZDl4zFE6v4VZojqqADhaperM0Qua9qpIs9e4
         038jg+zd6IyH3g6hZmKeR4A2ZAuD8qwX1NAFzvVgaX5287/5SjLnkjmZ7UaXR5F9qe7k
         8Ze4JscErl62Z0ZW5Yep3GI/r7XLub/cgMvKMDoNXTDBKur0RQbuVnihbZqSTcy4QCIR
         xkPNMH4faws2wX8FOdDcLSjQ3n1vKJ9fWI4pR3htOGy0Asm3FiYO5U8K64vkbAGxRJkO
         lTDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rt/UcBSCq3ctx1DKdxEOe9zXd6vUi6e+DDOW65PuwO4=;
        b=hMWGjTbWcF8s84UQoqBdYNJmWfPUm5sSdC3CLczoVh6mLRK+EYLrItOLWteAQJyZyJ
         IsjS6YGNAzvTRt5XMmwlU1IB7o9XukPxdSRCW+02mApQ3LvoOJixEUO6gLJdm918JB6r
         gZpt7R8tAvIyBPYJ/AyGFMncJcw2gLGbpA21GqBeI0MFP5bNjRkGz0jdt9jACMPT5cZh
         OMOGzCqESxaq/0HQCeOOC83BzFTsYgvuUt5jEyTaKbBiHpduBQoHri2XDZvO7M2bG6iN
         SV5Rz9Si7dRCTr35PYnzvS7uM3u0pBMlWdt94eItBvBCUZIeP3iKt/XP9QX5aRYcNF+j
         47Uw==
X-Gm-Message-State: ACrzQf0q5+7kam5DGVm51ZaR4zorn/jvV1FdRldIbP0pLcfZTcRG674r
        3DRlH3wBF2nBi54nh72dAFrd1PWHeEb+sG/uRMC1fvWO128=
X-Google-Smtp-Source: AMsMyM42bURtQBgKrnpb7sjx/vFddcQMeV8rl3jwrihWTbA8d8xRUQa6Dvo4aXngxEtzihHgTWasga503vRyGkalxRA=
X-Received: by 2002:ab0:132b:0:b0:3e4:ac2d:9e0f with SMTP id
 g40-20020ab0132b000000b003e4ac2d9e0fmr3458525uae.107.1666152359194; Tue, 18
 Oct 2022 21:05:59 -0700 (PDT)
MIME-Version: 1.0
References: <20221018100510.never.479-kees@kernel.org>
In-Reply-To: <20221018100510.never.479-kees@kernel.org>
From:   David Gow <davidgow@google.com>
Date:   Wed, 19 Oct 2022 12:05:46 +0800
Message-ID: <CABVgOSmT7y7uNqLb+uyJpsHy4sezFdm_UWrFZvGQ90d+xYbcVw@mail.gmail.com>
Subject: Re: [PATCH] siphash: Convert selftest to KUnit
To:     Kees Cook <keescook@chromium.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
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

On Tue, Oct 18, 2022 at 6:05 PM Kees Cook <keescook@chromium.org> wrote:
>
> Convert the siphash self-test to KUnit so it will be included in "all
> KUnit tests" coverage, and can be run individually still:
>
> $ ./tools/testing/kunit/kunit.py run siphash
> ...
> [02:58:45] Starting KUnit Kernel (1/1)...
> [02:58:45] ============================================================
> [02:58:45] =================== siphash (1 subtest) ====================
> [02:58:45] [PASSED] siphash_test
> [02:58:45] ===================== [PASSED] siphash =====================
> [02:58:45] ============================================================
> [02:58:45] Testing complete. Ran 1 tests: passed: 1
> [02:58:45] Elapsed time: 21.421s total, 4.306s configuring, 16.947s building, 0.148s running
>
> Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
> Cc: David Gow <davidgow@google.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---

Works fine here, and looks good from a KUnit point-of-view.

Tested-by: David Gow <davidgow@google.com>

Cheers,
-- David

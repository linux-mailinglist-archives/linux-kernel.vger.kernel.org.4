Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB64563AAD9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 15:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbiK1O2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 09:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbiK1O2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 09:28:22 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9CE65F5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 06:28:21 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id b73so13501547yba.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 06:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Cl7V40RlzSUp5Y9iM+8a/KVinWUxUFpdf5Vw6vhUvR0=;
        b=fkFQ1PqrNgg4caVJLvKn1JTh+eT+3DXoAtRh3bMesPqQeUPHA+DqDVBX4UTDmdqnwW
         DJvvNudQT60SbAIYAo5UyNtx5nswe9KewWOnt5CvyzhHmaM7SAHwy84hlLaQv6qrMTug
         ct4i4LqWb32TanRVKjF9L13oRIu31H1osvj44Tc8uUU4xGYNGEwAvMiq6PKz0T0tXiDn
         0PcFqRAA/LLl/WXBdwGsi/HejjC79gwVVqKS7TDfYdBePFBWTgPM+Uc19pQBDY+Q+otp
         fNoKVafjzN33jIv6h+IHSRwFpxUg59wGzxLuoTttpJxCaDtIot5IdYwkzhOSrdGIIcdS
         EtZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cl7V40RlzSUp5Y9iM+8a/KVinWUxUFpdf5Vw6vhUvR0=;
        b=DTqxwkd9PzhBfLhKt5Imp8dgsz2CrAUdWrIemCw6WThTv0S3r57YN/NWZ0/zw9gPHO
         s0h6gp+7BH2EkTmrpUpK16YesLnrU3UH6SfHS76QGe4d3sFCGaQnzqNYgeTiRjGADFRN
         m4HBGyIwijdlF0baJzVs8F29CmDM1xxBLd7ShZH0WOKlG4hYpf7tAuqkgi6/AU6zkLtY
         +RjRKL+VIl0uRAqqus0aYjLz/zoAbwwZLdS5lsI7kcPvKeW8Mo3DUh9h2JKRUux+3pE1
         kJ7fO2+JcVBj6Rvhbk1y/ujAptbFFmVZ+5aFMOGC5vX8GnKToiA9oIIWfS2v/SYN+jB7
         Y7TA==
X-Gm-Message-State: ANoB5pk6LGwRpkAQhpbnXz23EZOf40bU80QSZ8T16+mt8Kd9Q6HfW97D
        z4MmW7y1tmamRWJd+obssl/Wi3FBqxtejNQkDuV251aIyME=
X-Google-Smtp-Source: AA0mqf5fQHl6p+5H2oPJt4u1hD7f4tZGwYDlyLEfPJTbNiVce0PdFy1B77GKX6iU2bemScurAol39HO6HAnGig0y/es=
X-Received: by 2002:a25:3851:0:b0:6f0:6175:2cc7 with SMTP id
 f78-20020a253851000000b006f061752cc7mr23810478yba.93.1669645700811; Mon, 28
 Nov 2022 06:28:20 -0800 (PST)
MIME-Version: 1.0
References: <20221128104358.2660634-1-anders.roxell@linaro.org>
In-Reply-To: <20221128104358.2660634-1-anders.roxell@linaro.org>
From:   Marco Elver <elver@google.com>
Date:   Mon, 28 Nov 2022 15:27:44 +0100
Message-ID: <CANpmjNP8-jDPXJVy68zhkspEac8vutfpTAc1nytnyExSpsT-jA@mail.gmail.com>
Subject: Re: [PATCH 1/2] kernel: kcsan: kcsan_test: build without structleak plugin
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, keescook@chromium.org,
        davidgow@google.com, Jason@zx2c4.com, Arnd Bergmann <arnd@arndb.de>
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

On Mon, 28 Nov 2022 at 11:44, Anders Roxell <anders.roxell@linaro.org> wrote:
>
> Building kcsan_test with strucleak plugin enabled makes the stack frame
> size to grow.
>
> kernel/kcsan/kcsan_test.c:704:1: error: the frame size of 3296 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
>
> Turn off the structleak plugin checks for kcsan_test.
>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Acked-by: Marco Elver <elver@google.com>

> ---
>  kernel/kcsan/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/kcsan/Makefile b/kernel/kcsan/Makefile
> index 4f35d1bced6a..8cf70f068d92 100644
> --- a/kernel/kcsan/Makefile
> +++ b/kernel/kcsan/Makefile
> @@ -17,4 +17,5 @@ KCSAN_INSTRUMENT_BARRIERS_selftest.o := y
>  obj-$(CONFIG_KCSAN_SELFTEST) += selftest.o
>
>  CFLAGS_kcsan_test.o := $(CFLAGS_KCSAN) -g -fno-omit-frame-pointer
> +CFLAGS_kcsan_test.o += $(DISABLE_STRUCTLEAK_PLUGIN)
>  obj-$(CONFIG_KCSAN_KUNIT_TEST) += kcsan_test.o
> --
> 2.35.1
>

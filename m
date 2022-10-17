Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90BAD60061E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 07:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiJQFI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 01:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiJQFIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 01:08:23 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE0E5053E
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 22:08:22 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id f205so860029yba.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 22:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4lxf09phcZd+RbWiYGHV8D3u6UgUuk1peMBn11MBenQ=;
        b=oVZBgyJ+PorijKDt4bJ4VrQmeELldaNsoCTx1XM+ti3Cx77ANDFqorHQeiBo88LCdX
         W730yRaxJakN04Mujv1A4OhUoVTMD9rzbdyZOwwiV1bPim+zGqkAAXJ82gEgKrl6C8u1
         F+JJUCT9hIrel2Q70gfyr5iQw51H2BXTHDgIwytfmAgCWP6r8upijwGrvV1aoZUUqJY0
         aq53+vVxp5bO2ZfwpHUxkXFIEsMMG/sjkUppSZmMSOKfE0X6UjCLrsWHv+ZIh6JYZQa/
         9YTG3zPcSfLr6dDYZlw8mR5N/AT+BKuYu6vZIVTp8ZAQnUv06uXmbd/hjpeTrMn7T1a6
         o8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4lxf09phcZd+RbWiYGHV8D3u6UgUuk1peMBn11MBenQ=;
        b=EfRyU0hi+/z9A85ZWIjhUYV0jxdXdgnhNl9G1PJmDMg4fyF/GzyImO9C8H/MFIffqt
         FM3jYkLmyCFxVsMepD2iHsbJMiOtqsRLb6GVmlfcqiww/ewviiSqMvfUM3HOinAjMUkh
         jvBmMCCHSqBXV01r2OzWck1AwvmQottGYcWYdQsaaqK9jos/krmEVATXE11WbyJSUyKz
         g5z0CMqUFgppGIayt3JF9VQ8PyU/lxjBIdK7Ndc+Hj7ICh76oF4zDiy4+EbKLrO9KN4+
         LorNzB06TAXRRSvQd2TuyeDZtiUWb4x6jAPYAMqXsFC5zL0WEK1mPxYExgRvMBFw6Mch
         CneQ==
X-Gm-Message-State: ACrzQf2Sy++WSKq9hDmcAv66+zDh5hIE5uRu4t5OhUc4uxIBBhpbCWfU
        emCVJO8sjywVSjKn9TwKQp5gW+tEHaIgerTPnlHDEg==
X-Google-Smtp-Source: AMsMyM6pAkODl35D3tw2JOcV2Lk19OOcqtWq+g9bvrkWKofkhyNmfg/Ni/Y292qe1PgAubjMSRr7ajRZaBPARWtm9hw=
X-Received: by 2002:a25:3f06:0:b0:6bf:8d1:191d with SMTP id
 m6-20020a253f06000000b006bf08d1191dmr7867634yba.16.1665983301659; Sun, 16 Oct
 2022 22:08:21 -0700 (PDT)
MIME-Version: 1.0
References: <20221017044345.15496-1-Jason@zx2c4.com>
In-Reply-To: <20221017044345.15496-1-Jason@zx2c4.com>
From:   Marco Elver <elver@google.com>
Date:   Sun, 16 Oct 2022 22:07:45 -0700
Message-ID: <CANpmjNM7Sca3YJQ7RK14e_pzB5Wq3_-VokLum6MpqKXq7ixzSQ@mail.gmail.com>
Subject: Re: [PATCH] kcsan: remove rng selftest
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
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

On Sun, 16 Oct 2022 at 21:43, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> The first test of the kcsan selftest appears to test if get_random_u32()
> returns two zeros in a row, and requires that it doesn't. This seems
> like a bogus critera. Remove it.
>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Acked-by: Marco Elver <elver@google.com>

Looks pretty redundant at this point (I think some early version had
it because somehow I managed to run the test too early and wanted to
avoid that accidentally happening again).

> ---
>  kernel/kcsan/selftest.c | 8 --------
>  1 file changed, 8 deletions(-)
>
> diff --git a/kernel/kcsan/selftest.c b/kernel/kcsan/selftest.c
> index 00cdf8fa5693..1740ce389e7f 100644
> --- a/kernel/kcsan/selftest.c
> +++ b/kernel/kcsan/selftest.c
> @@ -22,13 +22,6 @@
>
>  #define ITERS_PER_TEST 2000
>
> -/* Test requirements. */
> -static bool __init test_requires(void)
> -{
> -       /* random should be initialized for the below tests */
> -       return get_random_u32() + get_random_u32() != 0;
> -}
> -
>  /*
>   * Test watchpoint encode and decode: check that encoding some access's info,
>   * and then subsequent decode preserves the access's info.
> @@ -259,7 +252,6 @@ static int __init kcsan_selftest(void)
>                         pr_err("selftest: " #do_test " failed");               \
>         } while (0)
>
> -       RUN_TEST(test_requires);
>         RUN_TEST(test_encode_decode);
>         RUN_TEST(test_matching_access);
>         RUN_TEST(test_barrier);
> --
> 2.37.3
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1155BED5C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 21:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbiITTKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 15:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiITTKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 15:10:21 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F562A273
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 12:10:20 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id n8so2794912wmr.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 12:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=vhcZzgEgF161dV3JAs/7wiPgpLh5ucK8PQ1AhMND7Wk=;
        b=rY1HK3uJjfj2GdveigAJaHAIvNjngvON3srR39Y7URQ5VrSPuVK2+OL+P1leo7oifp
         8mH6IEmU5/pSmHl3+nIG5/NKAbpvbMEKvahuQd7kzY8kOJFuZXzydRIUbp01/FXOXmTO
         v09Ja0htbn82UV8KqclijMQgPcAcOpgzEldfL1tFIhnjXR8TKuROgz/ylILhEOi9m4dU
         6jyrbSOR0xR+JdlkjhSqouRZQUHs18haHauvkJbxDZPTu52OPy2+KcmgA9AcMRvOTo13
         guJqDVErDp+7aWIsht+9yYFtlir2/WGbzfB6GHiJc7tY3ztIEyoQ1mc6mCLkp5cPf+DW
         nKkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=vhcZzgEgF161dV3JAs/7wiPgpLh5ucK8PQ1AhMND7Wk=;
        b=IjCfonBCwvqpZuz11HEj8Zk0RupKs3IRh5FpxY5J2Tb5yX9unC04dmk8Lq4XLRwrE4
         h7hkN3RdjOinVcTEbD5xenRhozq/t6JkHCvy56xZNZZyf+PW4sOahHkdFEq8Td0CB4IP
         Uzz72MHkk1Zjhv3ENZkInm4WLS8yztNxkUsjJ81LRWrLkh1W6VjnQMJFQsgfaBrLzdB/
         vrZbjFNAkEDP8hvl28gRpjDSkNBgMvO7YbeELIgMxn9cjYDDGqycRsV4mO63KvGmuP6R
         zF7Noc2efW5lfyVr9lgiChn2nqrHcRAHE0d+uvGuLxOFA4ALWrdULZClLYw1UElWLn+j
         x4qQ==
X-Gm-Message-State: ACrzQf3oRzBGPMYTMxCJtIf/He+pVcwVmKqsJiCTwu0qDFZFW/SioWGV
        qGqkwPb5msCU2V61QcjK+ClmRpv8HDf6MvGBsit9Yg==
X-Google-Smtp-Source: AMsMyM5YLrNDLjj0aYNlMedK7bBKZqr8J7Gn+pvWfSVryamv7O2e1K7CVasBgn1HC6XCXWrFAL4K1mPXOWGK107wSBs=
X-Received: by 2002:a05:600c:1d11:b0:3b4:7644:b788 with SMTP id
 l17-20020a05600c1d1100b003b47644b788mr3742800wms.114.1663701019260; Tue, 20
 Sep 2022 12:10:19 -0700 (PDT)
MIME-Version: 1.0
References: <576182d194e27531e8090bad809e4136953895f4.1663700262.git.andreyknvl@google.com>
In-Reply-To: <576182d194e27531e8090bad809e4136953895f4.1663700262.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 20 Sep 2022 21:09:42 +0200
Message-ID: <CANpmjNN0jyK0svOOHSFPAfFV9CAEUVUb+y_748Fww-sgf=3pdg@mail.gmail.com>
Subject: Re: [PATCH mm] kasan: initialize read-write lock in stack ring
To:     andrey.konovalov@linux.dev
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        Yu Zhao <yuzhao@google.com>, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
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

On Tue, 20 Sept 2022 at 20:58, <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Use __RW_LOCK_UNLOCKED to initialize stack_ring.lock.
>
> Reported-by: Yu Zhao <yuzhao@google.com>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>
> ---
>
> Andrew, could you please fold this patch into:
> "kasan: implement stack ring for tag-based modes".
> ---
>  mm/kasan/tags.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
> index 9d867cae1b7b..67a222586846 100644
> --- a/mm/kasan/tags.c
> +++ b/mm/kasan/tags.c
> @@ -36,7 +36,9 @@ DEFINE_STATIC_KEY_TRUE(kasan_flag_stacktrace);
>  /* Non-zero, as initial pointer values are 0. */
>  #define STACK_RING_BUSY_PTR ((void *)1)
>
> -struct kasan_stack_ring stack_ring;
> +struct kasan_stack_ring stack_ring = {
> +       .lock = __RW_LOCK_UNLOCKED(stack_ring.lock)
> +};

Reviewed-by: Marco Elver <elver@google.com>

>  /* kasan.stacktrace=off/on */
>  static int __init early_kasan_flag_stacktrace(char *arg)
> --
> 2.25.1
>

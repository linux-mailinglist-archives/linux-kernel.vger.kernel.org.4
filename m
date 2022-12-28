Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18346586EE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 22:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbiL1VMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 16:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiL1VMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 16:12:41 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4354613E9C
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 13:12:39 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-43ea87d0797so236934167b3.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 13:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+7ooGxz+slyS/E6q6mPR6pfactn5WEBlXeWzI+mnkNI=;
        b=ih97jiTj5/uvAHQi1SWZaUjBeXFNFLtW/L9Hr9vhA+WQfOHxMAnExk4bbjcsVNabCW
         HeKqmkdzPhmyWoS62nY4lwgh34goModIcMoZkgAZiGkLRDyhzt7SraAkeIQw+9Uhz9DP
         EYyMcKiIJK6/1LXp6AjX7BYgPhR1JpZKb2VHVhZsFFZyRg7Nwo4nbGAmGaGwMzYQgXed
         sjni7INdx2icrIAEAXbjjHBkN0iNa6FlazuUYl5LHmRvzbiRo0Hwz9lWy07HYNYn0iSz
         JkaJIeebofKuXyxQfxtDyuXOfPFUotcXWOKX9YkMv4n3U0JmuhwbQQT86uC4hMjbTXo8
         8DZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+7ooGxz+slyS/E6q6mPR6pfactn5WEBlXeWzI+mnkNI=;
        b=sHcX26Ij3izBJ1GrXoON8vLuAxGTAnRvVnK8qTudZUVbQyop/dYnQhS2SyFWRfPhyg
         j3qGemZWVpc1UTKuWXGIXXiX7GiQbuh+Nm0TrfqNJcMY1zMNV4g2LVGp02cDa8TsY0/b
         sOdbypZiEgtgY8OJUG/QhEVgClCZaL6y/5Izijexqt3sIgx5PBwLKXmjWaOQc7+gHIkz
         Lgmxrbys6Duex1b6yQiFHgsYxUSoLcB57h804uIzyMcmPmrIecNMZZc8YzsQbWkYb7gk
         oo27LeBuzBU9Ss7qgD0h9onyLyWR/HNNpsgRwYRlw0lqkhHsKBPttbZ6Hsk4TmzWUJ5V
         1tFg==
X-Gm-Message-State: AFqh2kofomo8uLBdNiChiZ7bSVaS5ri4AMETLiQs9NysNXeAUIHhIuAe
        ujuBgp6CwI5Uib6mKtjguET2WQ4CHRXA+VXWhRd9Yh90XX11LKpt
X-Google-Smtp-Source: AMrXdXsJbuyjVhn8JGXsjh7X1fYP2OqQbbsy1d4w6OwpnN9wrEjQnavmbjW6sV+0agNTau2XV3MZkafhwdaidHprrcI=
X-Received: by 2002:a0d:d5cf:0:b0:3dd:b7d7:ae7e with SMTP id
 x198-20020a0dd5cf000000b003ddb7d7ae7emr2597695ywd.11.1672261958348; Wed, 28
 Dec 2022 13:12:38 -0800 (PST)
MIME-Version: 1.0
References: <20221223074238.4092772-1-jcmvbkbc@gmail.com>
In-Reply-To: <20221223074238.4092772-1-jcmvbkbc@gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 28 Dec 2022 22:12:01 +0100
Message-ID: <CANpmjNOs6vyX+y0XuNaz5J=8p1yKxfsWcNGL=vA1Dzjua=fsYg@mail.gmail.com>
Subject: Re: [PATCH] kcsan: test: don't put the expect array on the stack
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org
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

On Fri, 23 Dec 2022 at 08:42, Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> Size of the 'expect' array in the __report_matches is 1536 bytes, which
> is exactly the default frame size warning limit of the xtensa
> architecture.
> As a result allmodconfig xtensa kernel builds with the gcc that does not
> support the compiler plugins (which otherwise would push the said
> warning limit to 2K) fail with the following message:
>
>   kernel/kcsan/kcsan_test.c:257:1: error: the frame size of 1680 bytes
>     is larger than 1536 bytes
>
> Fix it by dynamically alocating the 'expect' array.
>
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  kernel/kcsan/kcsan_test.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
> index dcec1b743c69..af62ec51bd5f 100644
> --- a/kernel/kcsan/kcsan_test.c
> +++ b/kernel/kcsan/kcsan_test.c
> @@ -159,7 +159,7 @@ static bool __report_matches(const struct expect_report *r)
>         const bool is_assert = (r->access[0].type | r->access[1].type) & KCSAN_ACCESS_ASSERT;
>         bool ret = false;
>         unsigned long flags;
> -       typeof(observed.lines) expect;
> +       typeof(*observed.lines) *expect;
>         const char *end;
>         char *cur;
>         int i;
> @@ -168,6 +168,10 @@ static bool __report_matches(const struct expect_report *r)
>         if (!report_available())
>                 return false;
>
> +       expect = kmalloc(sizeof(observed.lines), GFP_KERNEL);
> +       if (!expect)

WARN_ON(), because this may either spuriously fail or pass a test
case, and we'd want to know about that.

Thanks,
-- Marco

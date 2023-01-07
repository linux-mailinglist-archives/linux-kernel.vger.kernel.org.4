Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731126612AC
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 00:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjAGX65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 18:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjAGX6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 18:58:50 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874D31A21A
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 15:58:49 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-4c15c4fc8ccso69234367b3.4
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 15:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LASr4G5hxiyIVkS42J/7KQN5U5E2hhaLbz6J/xvH/2E=;
        b=ZZUxnGGyIdZf514X/wSMh4xFDXIon/TWXIlgZ0R2hqbJKUrJNjY4wLSu1ReOSF3IGn
         Yw4q+Iek2uNeSwXjZKsih/ll0arQX3vHmae87pYmhfmlIr+C+ITIXZ3Ptm3rV+5ZUhci
         na7If2Dzv4Y3XujFR5fJxHa+zr7rCx5lgRfzqjfwy0UhLLGhe766pk1w23ReOY58OvC2
         HqGdjsllVvxa2SNknaF0tGY/TPcviQcFTKjAT83M4IquFAkpX4XCCg0bXEOjej3SQxgY
         F2ZEIDogADGv1tJnym8a7DsBtV5UHdABzHZvaCjI/wml8mW1hBYa+K3+ywUQJJpuTLlz
         HOOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LASr4G5hxiyIVkS42J/7KQN5U5E2hhaLbz6J/xvH/2E=;
        b=Hzq3c2ql3TYtSijLu6Q+yCJp8FyJtR6gVxDt0kEA1R2OItQqAuA3z3am5zob/FGESD
         jbU8mfv+YCHdq5pPtFqUaYO9q50gaQnK3GaBqaThQ8D223JBYuxj2sWDj8KO2+MkVvNG
         X7UTQwuCJVB3MOPjl7XYtdSS+4QefbMKI+KM7zMamIqFSrzm5l0gqtAMznAMnhbvT+41
         VKQkhIHfJme8KCUMUFYFAYZVyXVas3KRAsFHvtpcAx1ZNUxwnnZeXmW28n+tp1d+muSw
         BUoVB9oNUv1xd0yuKIXxpHZ5Zyb3bsBIwGPcY62sp7Zq2fWatxRZquw9RrytJ3Ql3O++
         jKaQ==
X-Gm-Message-State: AFqh2kp3PKblux3WIh9WyIfUZOO2W11mQkl2Q/CsSqH41ib2pgHRQGA1
        6O6OOLKjan4Lw7H+YQPdMz1ZANjamyG8CP5FAL1DGhT43QYOYg==
X-Google-Smtp-Source: AMrXdXsVVgiXpJxiyg4qpmZSmee3Udce/r+t9JdGI5jOiQNEqKcQT77BaK0FyjA0gDy/zd7fX2yRvnvMyct9Xp9Iq6g=
X-Received: by 2002:a81:484c:0:b0:36a:de9d:825e with SMTP id
 v73-20020a81484c000000b0036ade9d825emr898057ywa.477.1673135928778; Sat, 07
 Jan 2023 15:58:48 -0800 (PST)
MIME-Version: 1.0
References: <20230105215706.never.027-kees@kernel.org>
In-Reply-To: <20230105215706.never.027-kees@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 8 Jan 2023 00:58:37 +0100
Message-ID: <CACRpkdYfsY7K8GksccDunCfKHbq_Df8ddrYGRg2gmeu6CVCF5w@mail.gmail.com>
Subject: Re: [PATCH] ARM: ixp4xx: Replace 0-length arrays with flexible arrays
To:     Kees Cook <keescook@chromium.org>
Cc:     Krzysztof Halasa <khalasa@piap.pl>, Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 5, 2023 at 10:57 PM Kees Cook <keescook@chromium.org> wrote:

> Zero-length arrays are deprecated[1]. Replace npe_load_firmware's
> union of 0-length arrays with flexible arrays. Detected with GCC 13,
> using -fstrict-flex-arrays=3:
>
> drivers/soc/ixp4xx/ixp4xx-npe.c: In function 'npe_load_firmware':
> drivers/soc/ixp4xx/ixp4xx-npe.c:570:60: warning: array subscript i is outside array bounds of 'u32[0]' {aka 'unsigned int[]'} [-Warray-bounds=]
>   570 |                         image->data[i] = swab32(image->data[i]);
> include/uapi/linux/swab.h:115:54: note: in definition of macro '__swab32'
>   115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
>       |                                                      ^
> drivers/soc/ixp4xx/ixp4xx-npe.c:570:42: note: in expansion of macro 'swab32'
>   570 |                         image->data[i] = swab32(image->data[i]);
>       |                                          ^~~~~~
> drivers/soc/ixp4xx/ixp4xx-npe.c:522:29: note: while referencing 'data'
>   522 |                         u32 data[0];
>       |                             ^~~~
>
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays
>
> Cc: Krzysztof Halasa <khalasa@piap.pl>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Looks good to me:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Do you need me to funnel this to the SoC tree or do you have
some quickpath for fixes like this?

Yours,
Linus Walleij

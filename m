Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054E55B31EB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 10:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbiIIIjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 04:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbiIIIjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 04:39:03 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809F812FBBB
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 01:38:58 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id bt10so1537321lfb.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 01:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=BZdXdwTdKGe0baQEwZY8VKfE+Zui9u+0KrTmD1YE7Hc=;
        b=ta7vUt+h77XK1nbaY+2lNhiO3rTKLgScRasuIurPBQmFUDsNBKMtBpHOVMJ51ZJAQv
         WFjDrA1m79Tg9yk7WW8ICYI531G0nPm7Ny17zWs0NXcLWh8uVg9eVVEK7WxsruIWYGO4
         H7pu+8sOp7KqlJG3nW83gMdCt3exqVE+nLChtw+pMCCV4+nR4PHKeTDKr9HWoqJ2FniA
         pH09KU/Dm0kvXxFL8vBmSTROyllKS4Ud0VwpzBvREHb53P0HtvuCsexxdIm8nc2wE0G4
         5mK7uDvL66SzYpO3P5aT66pY7EP0HskmVY9qcNJdA5qh4Wyk09LNjU6AlexmzTMuWC5C
         TUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=BZdXdwTdKGe0baQEwZY8VKfE+Zui9u+0KrTmD1YE7Hc=;
        b=xXVV41RbdoiY8JpyMR003DMUrS5QqtqGVvWibZ5JefIYBY5DxvACT3DfnwaZokp+em
         CZuqdRKReCIQI1XWgzgfFnkk8KaSnsKcVq6wXFypNmqCL/Nnr0Cxn4ilTUQ6ldEWCPY2
         CJDJxvfSz3EwdKIjEzkenROVwsRhbOWh0eYLl3cSdSTHS77EcdjNA8RbXcKa/5D14azN
         hnhhqqMlfBv73uwNW2zPOUGiJ3MmOTz/X2/2I+9lJ2GHW7mKOeOHOt2IQjwSN8BF8XhO
         8MDhHWakK1ZqB61Z4tjMY5IYH0T7UF4ienfI6mPV4qU/uQee1JkhWZQLzm0YwbjzSSct
         2mgw==
X-Gm-Message-State: ACgBeo2X4CVWlawtlriRw9JZGub9bHZExRe7Ez5IF0u9bYQjDN/oUB3O
        BNxWRRM5cfa1Pc3arkdFB6oryqzdHYIwkTz0vgWZwg==
X-Google-Smtp-Source: AA6agR4e9oWULjRziRq6BJvzm03afAE7CthF2BBKMgyNC0AoRlZQbNF5PpM8IXTvogSdIcHPvp6WSzcAKJtRkBHidYw=
X-Received: by 2002:a05:6512:118b:b0:492:e3c4:a164 with SMTP id
 g11-20020a056512118b00b00492e3c4a164mr4400289lfr.598.1662712735864; Fri, 09
 Sep 2022 01:38:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220909073840.45349-1-elver@google.com> <20220909073840.45349-3-elver@google.com>
In-Reply-To: <20220909073840.45349-3-elver@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 9 Sep 2022 10:38:44 +0200
Message-ID: <CACT4Y+ZJXS0Hcj4D-O+KfXT0SJ9pUhEx=zDqhwgOa9Pz2te0KQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] objtool, kcsan: Add volatile read/write
 instrumentation to whitelist
To:     Marco Elver <elver@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Boqun Feng <boqun.feng@gmail.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Sept 2022 at 09:38, Marco Elver <elver@google.com> wrote:
>
> Adds KCSAN's volatile instrumentation to objtool's uaccess whitelist.
>
> Recent kernel change have shown that this was missing from the uaccess
> whitelist (since the first upstreamed version of KCSAN):
>
>   mm/gup.o: warning: objtool: fault_in_readable+0x101: call to __tsan_volatile_write1() with UACCESS enabled
>
> Fixes: 75d75b7a4d54 ("kcsan: Support distinguishing volatile accesses")
> Signed-off-by: Marco Elver <elver@google.com>

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

> ---
> v2:
> * Fix commit message.
> ---
>  tools/objtool/check.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index e55fdf952a3a..67afdce3421f 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -999,6 +999,16 @@ static const char *uaccess_safe_builtin[] = {
>         "__tsan_read_write4",
>         "__tsan_read_write8",
>         "__tsan_read_write16",
> +       "__tsan_volatile_read1",
> +       "__tsan_volatile_read2",
> +       "__tsan_volatile_read4",
> +       "__tsan_volatile_read8",
> +       "__tsan_volatile_read16",
> +       "__tsan_volatile_write1",
> +       "__tsan_volatile_write2",
> +       "__tsan_volatile_write4",
> +       "__tsan_volatile_write8",
> +       "__tsan_volatile_write16",
>         "__tsan_atomic8_load",
>         "__tsan_atomic16_load",
>         "__tsan_atomic32_load",
> --
> 2.37.2.789.g6183377224-goog
>

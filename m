Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0671F6633D3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 23:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237848AbjAIWSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 17:18:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237747AbjAIWSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 17:18:21 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59801117A
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 14:18:19 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id s127so10357496vsb.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 14:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pl029Q32XTUa9+DoXm3FckvdLWahmSbCwZf90c1dI14=;
        b=frDcINOM35hsJgGEOr7ShnaDpJs1KgkQRualr+R2IFX+ETnqBwX15zai7mm5jjMLce
         F1KktQPM/lYflu8TlaI/z2+S42adI4zJUgIcrTROoIynlIMBk0O1opv5VOhqfB4uBMat
         c3ZIicP92BmJqGelC4INeyy7UlrG/yqdCP0gY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pl029Q32XTUa9+DoXm3FckvdLWahmSbCwZf90c1dI14=;
        b=OxUCRWPffE1xEkn6ZHZ9O99mCjmE7iXmfU5M5/A/C/inCkjhww2zqBJzEd3Z86Gy/3
         Ggl17CqoGP28diVeq8x0uxKi9OURJtmU9HF5cI6D3GJ//C7Kd3uMqnvjsxFTcTOYZv1O
         vYOKyrl7uydsiOoFhLdujkebFkW7I3dSYhnr064r1GZu9SFqKpORqm3Utzcwwh830oI9
         ebWu1Sk6NkrGPolmu00bQzRC7z8Qs+dks6+YQtWwxcSsL9qOZKXfFtE+B97V6MVQpbAu
         OD9LmKASDX5z/+uZdOeTepmJOpgH+yQIpxDgZ268H1bo+NaVR4Sb+hU8EvWxJRaVavai
         /2Hw==
X-Gm-Message-State: AFqh2kppdnGg3TomTPsmRMHQdMQYq0Rto0TAJ09D9GDJkK6ovMGV30ws
        /EEkkVW0lsubYfXNuSyUYBIrqaUibmNJx06sK80=
X-Google-Smtp-Source: AMrXdXsMC+quVqdRFeoU52X79l1KW+bFKqh3p26PkD9zlWS5vBwhu+FHDrIJoGcfx69elQkVFer9HQ==
X-Received: by 2002:a05:6102:5128:b0:3b0:cf9c:caa with SMTP id bm40-20020a056102512800b003b0cf9c0caamr40676102vsb.35.1673302698409;
        Mon, 09 Jan 2023 14:18:18 -0800 (PST)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com. [209.85.219.47])
        by smtp.gmail.com with ESMTPSA id bm16-20020a05620a199000b006e16dcf99c8sm6070415qkb.71.2023.01.09.14.18.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 14:18:18 -0800 (PST)
Received: by mail-qv1-f47.google.com with SMTP id j9so7354868qvt.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 14:18:18 -0800 (PST)
X-Received: by 2002:ad4:4150:0:b0:531:7593:f551 with SMTP id
 z16-20020ad44150000000b005317593f551mr1343053qvp.89.1673302697892; Mon, 09
 Jan 2023 14:18:17 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjwrqFcC9-KkfboqATYwLfJHi_8Z5mTrJh=nf8KT_SjUA@mail.gmail.com>
 <20230109174742.GA1191249@roeck-us.net>
In-Reply-To: <20230109174742.GA1191249@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 9 Jan 2023 16:18:02 -0600
X-Gmail-Original-Message-ID: <CAHk-=whC+YpdympyegB0Wr_0_6=LYggdabkMExRus2DtAdsv-Q@mail.gmail.com>
Message-ID: <CAHk-=whC+YpdympyegB0Wr_0_6=LYggdabkMExRus2DtAdsv-Q@mail.gmail.com>
Subject: Re: Linux 6.2-rc3
To:     Guenter Roeck <linux@roeck-us.net>, Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <kees@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 9, 2023 at 11:47 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> fs/f2fs/inline.c: In function 'f2fs_move_inline_dirents':
> include/linux/fortify-string.h:59:33: error: '__builtin_memset' pointer overflow between offset [28, 898293814] and size [-898293787, -1] [-Werror=array-bounds]

Ok, I guess we'll have to disable this gcc warning for this version
again. I don't think anybody figured out why it happens. We had
several people look at it (Kees, Vlastimil, Jaegeuk) and I think
everybody ended up going "tis looks like a compiler thing".

Does anybody remember - what was the compiler version again and what
do we need to disable?

> kernel/kcsan/kcsan_test.c: In function '__report_matches':
> kernel/kcsan/kcsan_test.c:257:1: error: the frame size of 1680 bytes is larger than 1536 bytes
>
> Context: CONFIG_SLUB_TINY is enabled with allmodconfig builds.
> This enables some previously disabled configurations and disables
> some previously enabled configurations.

I do think that the test code should be a lot more careful about
random things on stack.

We've had this before with the EXPECT() macros generating *much* too
much stack space, and it's not ok for test code to violate kernel
coding standards even if it might be a "odd config that isn't
realistic".

That function does some odd things, including

        typeof(observed.lines) expect;

WHAT IS THAT TYPE? It turns out that we have

  static struct {
        spinlock_t lock;
        int nlines;
        char lines[3][512];
  } observed = {

so it's basically a 1.5kB byte array.

And then des

                char tmp[2][64];

to add some more pressure. So yeah, can't blame the compiler being
stupid, this is just bad code.

This is all very much a "this needs to be fixed, or the test just
needs to be removed, because that's not acceptable".

None of this is new, but clearly it was hidden by config issues
before. Added the guilty parties.

> In file included from <command-line>:
> In function 'follow_pmd_mask',
>     inlined from 'follow_pud_mask' at mm/gup.c:735:9,
>     inlined from 'follow_p4d_mask' at mm/gup.c:752:9,
>     inlined from 'follow_page_mask' at mm/gup.c:809:9:
> include/linux/compiler_types.h:358:45: error: call to '__compiletime_assert_263' declared with attribute error: Unsupported access size for {READ,WRITE}_ONCE().
>   358 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>
> Bisect points to commit 0862ff059c9e ("sh/mm: Make pmd_t similar to pte_t").
> This commit introduces
>
> -typedef struct { unsigned long long pmd; } pmd_t;
> +typedef struct {
> +       struct {
> +               unsigned long pmd_low;
> +               unsigned long pmd_high;
> +       };
> +       unsigned long long pmd;
> +} pmd_t;
>
> That should probably be "typedef union", not "typedef struct".

Ok, PeterZ has been off due to the holidays, but seems back. I agree,
that outer 'struct' should obviously be 'union', but let's make the
guilty party (ie Peter) fix it up.

             Linus

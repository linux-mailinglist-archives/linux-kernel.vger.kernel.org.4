Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A933565AD90
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 08:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjABHAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 02:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjABHAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 02:00:06 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314211090
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 23:00:05 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-48641a481dfso214270717b3.11
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jan 2023 23:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0FTLkrtp1Ew2BFHSG03YNcRgOUsktg1BSIJrviOVnRQ=;
        b=gjtpkUXMhKxPNBSMXZsq0IHD3Hfl6Ny1d4qJ309rt2DE2XLap1YLi+oT/VYfrjfVuL
         uBCzj60USp9kTJvG6k3JVA6eDYczRZQ+zdDhold1sKbA2GyfHEo1amdRyUcwU0/AeXyQ
         51x02wKEOR3KK6bODzoY4PEGmmhvlxGaAqd0PpIFmw8QZJkwvdLvKubW4/ot1sEP7ztq
         Lu/O/+WF7dZKmxJ3XFmqf0JGE9e4ODvcepNmSgP41A76QvR6QJWhrnRfnbQP8xIPqJ5y
         qg5BXjp9POpIpOGt4IOpO5c88CSmhKWUZWRmBBNfvp2PhSfIj4enOyoT+nC4KTB5Z2Rb
         feLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0FTLkrtp1Ew2BFHSG03YNcRgOUsktg1BSIJrviOVnRQ=;
        b=2PitpUBKyY9cbFcSSLkRoeArIgsh8yBD6ly8eLyKr+zc4i3NOEf7TB2pLRepdsTVlM
         iTb2CHHDlZhtk/3rClA+4kLGjZIwZrgiteG0Ur+AeQwrHgpKJr/id2pvp6z58wNrMuCF
         J6RcWYbgWRKOcI90CBm4pIvvcrBeYlzWHCMD7jLj8mKojxsEZiKrPOSTWw+DVzpXHin3
         fs433shhlVPUWusPizZr4TzbRJ5TbS6F2VSE3BUcJ+Ayvccz5MFA08S6iWZyaJ7cQCok
         jo2GiZs+3SbzR9N5fYU30lIoXDDTmi3InEdbnxdk8aAx8HPJTJE0rlbsHs3lIWcQmGQB
         bzSA==
X-Gm-Message-State: AFqh2kqPs/BD2BerqomWRr33c8t0kF1f++U+0gaXTLTWtAekYIwdb6DA
        0VrxJHpIIWQlIY5VDqyV3u0DbyaqlkftXnOx1bOjTg==
X-Google-Smtp-Source: AMrXdXtdy21luxOTJq/XUKA20VpjtPnZ6+VIELP4V1INV//seT+DeswnV/wYWHekRRYBDM9KdsB/OQK/SU7ONPDZtbo=
X-Received: by 2002:a05:690c:fd3:b0:4a8:330b:2554 with SMTP id
 dg19-20020a05690c0fd300b004a8330b2554mr212247ywb.238.1672642804252; Sun, 01
 Jan 2023 23:00:04 -0800 (PST)
MIME-Version: 1.0
References: <20221231004514.317809-1-jcmvbkbc@gmail.com>
In-Reply-To: <20221231004514.317809-1-jcmvbkbc@gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 2 Jan 2023 08:00:00 +0100
Message-ID: <CANpmjNNPTT+K3CRZN+RnUbHwmtUUzqb0ZDP=M6e8PHP0=qp=Ag@mail.gmail.com>
Subject: Re: [PATCH v2] kcsan: test: don't put the expect array on the stack
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

On Sat, 31 Dec 2022 at 01:45, Max Filippov <jcmvbkbc@gmail.com> wrote:
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

Reviewed-by: Marco Elver <elver@google.com>
Tested-by: Marco Elver <elver@google.com>

Can you take this through the xtensa tree?

> ---
> Changes v1->v2:
> - add WARN_ON in case of kmalloc failure
>
>  kernel/kcsan/kcsan_test.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
> index dcec1b743c69..a60c561724be 100644
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
> +       if (WARN_ON(!expect))
> +               return false;
> +
>         /* Generate expected report contents. */
>
>         /* Title */
> @@ -253,6 +257,7 @@ static bool __report_matches(const struct expect_report *r)
>                 strstr(observed.lines[2], expect[1])));
>  out:
>         spin_unlock_irqrestore(&observed.lock, flags);
> +       kfree(expect);
>         return ret;
>  }
>
> --
> 2.30.2
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20221231004514.317809-1-jcmvbkbc%40gmail.com.

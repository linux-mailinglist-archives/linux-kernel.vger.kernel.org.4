Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1912166A865
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 02:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjANBie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 20:38:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjANBia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 20:38:30 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CC689BE6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 17:38:29 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id cx21-20020a17090afd9500b00228f2ecc6dbso2680801pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 17:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FufgUw2fqlY7QEwBJBytXvOldn4bZyfyqwhzJKALwe4=;
        b=LGjFLFVeQhyilSeBgpCX9oTZDmyJqsHWZniAk5sh+ZIa9/79Tp5cwxJc77KX6rkd6p
         Mf26WNrxRFxQOt8fr5AChIfbhCglt2LnkzNZE7ZwvnArzQT6oIf3Ui9Hju8CcnNCpuAA
         +MPTgpVlmQGpE758bzgDjBlISrvuaDZXpo32k+KuTk/LsDz852zLdtlFRuPbc2dDQToY
         pg7GTuZKGQt0ht9HVPH/lB5yBHnpJdUzCARLYxkEycHH8tNQsAwW8q8ydrVFdUy5adfY
         hetKp2YWriDyhM861MHEG9OZYOPB3mCUjFuDjADJVZ2wjTcvwpn0J56nCJV/rzka6A2I
         qdVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FufgUw2fqlY7QEwBJBytXvOldn4bZyfyqwhzJKALwe4=;
        b=ZdlBUN6i/8k/3QLLZttuENV0h4yRXQFHYW560Sf7GF3urwiARNPWkQrggdNIaIZFmB
         Sp8hotOx8aaFAWlpkUlz1UJkk0ZXl4BxQjDsua04wt9+rP4QA6RCMRit2GaY39C2Ttlg
         RN6MEnSZwFy3jFATbeJm2QPZp99XLs4s/IEo099MJATHqWnFQ5ywtkBnTJEO3MRk8isn
         FTDon6vXqGMGQllgGTL5Uv4vECEQWp1vY9DRxJS9oTDLv/xBtpcdHVRDsewpfCrvt2eT
         q9i1GRSiRB+CNs1LnXyT2w7iLXMhz9C4O8E9rH+4sBDtZ9JuiWnhbO93dJ24gM05ii6T
         rDdQ==
X-Gm-Message-State: AFqh2kojdVIkDBbhh01WfgyjhAQVXfmokLDHMPU7DqtYYTdvyryJkDPs
        1sntdRE+17TLJDUMy/Sd5UAvnwLtx98HaNPe5jDXOg==
X-Google-Smtp-Source: AMrXdXvgVMPaadk3FjzCg9dQFfBrULyf1BBRFZGq3lUy7NI9a2lpX1LWoLxvWNTcTSPuEhjIW7mrcQOny0palWCm1qI=
X-Received: by 2002:a17:903:292:b0:189:9973:fb58 with SMTP id
 j18-20020a170903029200b001899973fb58mr156924plr.59.1673660308451; Fri, 13 Jan
 2023 17:38:28 -0800 (PST)
MIME-Version: 1.0
References: <20230114005408.never.756-kees@kernel.org>
In-Reply-To: <20230114005408.never.756-kees@kernel.org>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 13 Jan 2023 17:38:17 -0800
Message-ID: <CAGS_qxoeKishaVvHk-HCvstWJrZ8gXRrQipGd-sz=ONrPjteZw@mail.gmail.com>
Subject: Re: [PATCH] kunit: memcpy: Split slow memcpy tests into MEMCPY_SLOW_KUNIT_TEST
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        David Gow <davidgow@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-hardening@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Miguel Ojeda <ojeda@kernel.org>,
        Isabella Basso <isabbasso@riseup.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
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

On Fri, Jan 13, 2023 at 4:54 PM Kees Cook <keescook@chromium.org> wrote:
> diff --git a/lib/memcpy_kunit.c b/lib/memcpy_kunit.c
> index 89128551448d..5a545e1b5dbb 100644
> --- a/lib/memcpy_kunit.c
> +++ b/lib/memcpy_kunit.c
> @@ -307,8 +307,12 @@ static void set_random_nonzero(struct kunit *test, u8 *byte)
>         }
>  }
>
> -static void init_large(struct kunit *test)
> +static int init_large(struct kunit *test)
>  {
> +       if (!IS_ENABLED(CONFIG_MEMCPY_SLOW_KUNIT_TEST)) {
> +               kunit_skip(test, "Slow test skipped. Enable with CONFIG_MEMCPY_SLOW_KUNIT_TEST=y");
> +               return -EBUSY;

Note: kunit_skip() here means you don't need explicit returns in the test cases.
kunit_skip() is basically
  kunit_mark_skipped(test, "reason");
  kthread_complete_and_exit(...);

So the diff in this file could be reduced down to just these 2 lines
  if (!IS_ENABLED(...))
      kunit_skip(test, "...")

But I can see the appeal of being more explicit about the control flow.
In that case, you could switch kunit_mark_skipped(), which just sets
the status and doesn't affect control flow at all.

Daniel

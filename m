Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D302F68F3E4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 18:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbjBHQ76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 11:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbjBHQ7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 11:59:50 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D4A1EFD4
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 08:59:43 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id x8so14444091ybt.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 08:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mdP6aBj8Z0tyjtWe/gNi4Xtx2Z1yUcQKnx0+gFKe2qI=;
        b=hdxm4WQn0wrThjAE1baXvx1yk2YQ1rt7KF5JK70eHNkgrWSh9H5Bue0qMnE+/6AuuV
         j/WYiIBBWpvFgQM+UhZRZaVmIf5VMMtUDFlBi3y7IkmCW7htAVutoTiRC9kC524IgkUj
         ZCerP/grZHzflHR6aWvtvMVbaWI/DyIrjkJpXen5WPkCICg3bVd9vCGBRSQ46xrjpib5
         n75kkKD8d7aNxCijrZdHuKJjBELocLyMAiX0PLZwUS6cI/kcJlrO8iISbp4Gh5ujmtUF
         zH6XrrjZ+t/yOJD0LwTlR14h4b7N4NfsnM42iuRvTHlNyB9AWudtYJaP7QOYKX2wgT+D
         GBcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mdP6aBj8Z0tyjtWe/gNi4Xtx2Z1yUcQKnx0+gFKe2qI=;
        b=NmeO4tnjiEdfdTiV06Q+4q7uAyo/1A1Fv7nkd9PMUXxSHWLHV5rRXGjO2RShF9FH1k
         vlyza3bCX0p+hPGOE5D+vls4Q4RYVdPCjUNFMKcY9XVM/jiWlvD9+OdTFlhOzgUlAz8s
         nkik+CdAFieQTTZ8xHDtglBBIgPwheyjaM5dskmKl60BGdvp65btF9LsHzTSKCJiS6Or
         tYcnC9r71moJGC1QhRvQdCFUPU7h3ZkkOfNGZ97YzOEM7vHLh/g2sT0DrTyKVFsA79qN
         CYM72uIbdX4RKFtdrW/hpgwa0q054dcHgwqiIEIj/r+GQGLukBdHo6P06fp6KW61SEx5
         ZJqQ==
X-Gm-Message-State: AO0yUKX9NcwwuUiSvnv1eVgbL+v+RfUvRnPqfwuoGp9+8oMmrouO6mDq
        cECpiFRoFlNeTuhDNzP9+RQ0FST0KNBGbUDKqcTu7w==
X-Google-Smtp-Source: AK7set859Usjta/XDe4YTT6BVJSKNeiGZ7QEBs2OLEz+nymj0Rizfwi8Jz7uwV6iB1Pxn7LiG8RQOI1LMKXKbqisVVM=
X-Received: by 2002:a5b:4cf:0:b0:87d:c01e:2205 with SMTP id
 u15-20020a5b04cf000000b0087dc01e2205mr1295357ybp.179.1675875582673; Wed, 08
 Feb 2023 08:59:42 -0800 (PST)
MIME-Version: 1.0
References: <20230208164011.2287122-1-arnd@kernel.org> <20230208164011.2287122-4-arnd@kernel.org>
In-Reply-To: <20230208164011.2287122-4-arnd@kernel.org>
From:   Marco Elver <elver@google.com>
Date:   Wed, 8 Feb 2023 17:59:05 +0100
Message-ID: <CANpmjNN1nmjavBhj=xMMqAD1VScPySkdZbm2sTpWnKN1ZvmJcQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] objtool: add UACCESS exceptions for __tsan_volatile_read/write
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Miroslav Benes <mbenes@suse.cz>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Sathvika Vasireddy <sv@linux.ibm.com>,
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

On Wed, 8 Feb 2023 at 17:40, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> A lot of the tsan helpers are already excempt from the UACCESS warnings,
> but some more functions were added that need the same thing:
>
> kernel/kcsan/core.o: warning: objtool: __tsan_volatile_read16+0x0: call to __tsan_unaligned_read16() with UACCESS enabled
> kernel/kcsan/core.o: warning: objtool: __tsan_volatile_write16+0x0: call to __tsan_unaligned_write16() with UACCESS enabled
> vmlinux.o: warning: objtool: __tsan_unaligned_volatile_read16+0x4: call to __tsan_unaligned_read16() with UACCESS enabled
> vmlinux.o: warning: objtool: __tsan_unaligned_volatile_write16+0x4: call to __tsan_unaligned_write16() with UACCESS enabled

That's odd - this has never been needed, because all __tsan_unaligned
are aliases for the non-unaligned functions. And all those are in the
uaccess_safe_builtin list already.

So if suddenly the alias name becomes the symbol that objtool sees, we
might need to add all the other functions as well.

Is this a special build with a new compiler?

> Fixes: 75d75b7a4d54 ("kcsan: Support distinguishing volatile accesses")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  tools/objtool/check.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index e8fb3bf7a2e3..d89ef6957021 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -1200,6 +1200,8 @@ static const char *uaccess_safe_builtin[] = {
>         "__tsan_atomic64_compare_exchange_val",
>         "__tsan_atomic_thread_fence",
>         "__tsan_atomic_signal_fence",
> +       "__tsan_unaligned_read16",
> +       "__tsan_unaligned_write16",
>         /* KCOV */
>         "write_comp_data",
>         "check_kcov_mode",
> --
> 2.39.1
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20230208164011.2287122-4-arnd%40kernel.org.

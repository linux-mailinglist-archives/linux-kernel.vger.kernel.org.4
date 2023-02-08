Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F57A68F3EA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 18:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjBHRBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 12:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjBHRBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 12:01:17 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4561C317
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 09:01:16 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-4c24993965eso241721657b3.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 09:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xXdBKFQFjb45PJbE0WfevTYuOvd7Ed4TIGS1v3lQONw=;
        b=IYDBhhuMNLvOxMUNieuhwuuF9uXlY3Q40X9spez9yj/kTGor601E2JU44ZjwWer7ei
         CeWzoNfmFFnK2djRuZgotnT9X//bTMkS1g2gfcj6/jhIrR0Hzt3NeBwrQjz+AGNvZeLv
         YoZsYffzCQi8itKIDcn4dTasqFfs57kAnrU6ikZsgOF7kCIKtFbInx3tElCxew6PfN1y
         1EvjFBk8vCctHzYB3k3xkgfsCoOe4cQ/Wr6d9I50G9aiCWf2oSjDQc9nSiU7uK8aXI4s
         IoaofrnXVS55YOGefRunieUPutdwkmW4EQRElQYvLag/FUXG51SOY/BFn0OcvmYgTSp6
         5vCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xXdBKFQFjb45PJbE0WfevTYuOvd7Ed4TIGS1v3lQONw=;
        b=pGW38h/GbN/yD7hEYTaDIFA5j8/KThKyLDRy6RkFaoEAL4rjf6LoEr1cc96PGuudlE
         smaIP7oPtDJyJeOEEg7tjHjtCpBvaylehAMeglbaU1v9zGSIWInQ+uwi07kXwq0tayQ2
         PtYLTi+nUkdbt72hQCGh2GqE81VtKJI7rDcRXpT6fSZU7FQElanrh0NV1YZtDRSOGhCI
         T7pG2XpIvmgQ1LQ46hd5m5HdoDupOzuNQXuH/AcABF5umI+gZttNCdztxBjGu9AY2/S4
         p6IzshU+hdJoIoX0MzXfgbzxutg0iY2Z0vc/HTr3U+4vbUcqypNK/yEVgxydCPADH38n
         h8ww==
X-Gm-Message-State: AO0yUKXG5minV/TuKfI1NcK6Ak5rhSHisFX2ziEb0V2Sh+F7DFDnR8V0
        qcmtig6+Lp2hkGP4N9FVTnNkBClfDUsTPyssHOqoHOunR4p8F/Nw
X-Google-Smtp-Source: AK7set+cXrZJrfRBDM8O463q/uWZDKhuEYG0A6IIhrhL+2YLEgmuhPgKCxOXMuOmKcmi1rOzXNkSd3J5BIJj/WAfcRE=
X-Received: by 2002:a81:9e07:0:b0:527:b49f:b89 with SMTP id
 m7-20020a819e07000000b00527b49f0b89mr937260ywj.176.1675875675180; Wed, 08 Feb
 2023 09:01:15 -0800 (PST)
MIME-Version: 1.0
References: <20230208164011.2287122-1-arnd@kernel.org> <20230208164011.2287122-2-arnd@kernel.org>
In-Reply-To: <20230208164011.2287122-2-arnd@kernel.org>
From:   Marco Elver <elver@google.com>
Date:   Wed, 8 Feb 2023 18:00:38 +0100
Message-ID: <CANpmjNNYcVJxeuJPFknf=wCaapgYSn0+as4+iseJGpeBZdi4tw@mail.gmail.com>
Subject: Re: [PATCH 2/4] kmsan: disable ftrace in kmsan core code
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org,
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
> objtool warns about some suspicous code inside of kmsan:
>
> vmlinux.o: warning: objtool: __msan_metadata_ptr_for_load_n+0x4: call to __fentry__() with UACCESS enabled
> vmlinux.o: warning: objtool: __msan_metadata_ptr_for_store_n+0x4: call to __fentry__() with UACCESS enabled
> vmlinux.o: warning: objtool: __msan_metadata_ptr_for_load_1+0x4: call to __fentry__() with UACCESS enabled
> vmlinux.o: warning: objtool: __msan_metadata_ptr_for_store_1+0x4: call to __fentry__() with UACCESS enabled
> vmlinux.o: warning: objtool: __msan_metadata_ptr_for_load_2+0x4: call to __fentry__() with UACCESS enabled
> vmlinux.o: warning: objtool: __msan_metadata_ptr_for_store_2+0x4: call to __fentry__() with UACCESS enabled
> vmlinux.o: warning: objtool: __msan_metadata_ptr_for_load_4+0x4: call to __fentry__() with UACCESS enabled
> vmlinux.o: warning: objtool: __msan_metadata_ptr_for_store_4+0x4: call to __fentry__() with UACCESS enabled
> vmlinux.o: warning: objtool: __msan_metadata_ptr_for_load_8+0x4: call to __fentry__() with UACCESS enabled
> vmlinux.o: warning: objtool: __msan_metadata_ptr_for_store_8+0x4: call to __fentry__() with UACCESS enabled
> vmlinux.o: warning: objtool: __msan_instrument_asm_store+0x4: call to __fentry__() with UACCESS enabled
> vmlinux.o: warning: objtool: __msan_chain_origin+0x4: call to __fentry__() with UACCESS enabled
> vmlinux.o: warning: objtool: __msan_poison_alloca+0x4: call to __fentry__() with UACCESS enabled
> vmlinux.o: warning: objtool: __msan_warning+0x4: call to __fentry__() with UACCESS enabled
> vmlinux.o: warning: objtool: __msan_get_context_state+0x4: call to __fentry__() with UACCESS enabled
> vmlinux.o: warning: objtool: kmsan_copy_to_user+0x4: call to __fentry__() with UACCESS enabled
> vmlinux.o: warning: objtool: kmsan_unpoison_memory+0x4: call to __fentry__() with UACCESS enabled
> vmlinux.o: warning: objtool: kmsan_unpoison_entry_regs+0x4: call to __fentry__() with UACCESS enabled
> vmlinux.o: warning: objtool: kmsan_report+0x4: call to __fentry__() with UACCESS enabled
>
> Similar code already exists in kasan, which avoids this by skipping
> ftrace annotations, so do the same thing here.
>
> Fixes: f80be4571b19 ("kmsan: add KMSAN runtime core")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  mm/kmsan/Makefile | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/mm/kmsan/Makefile b/mm/kmsan/Makefile
> index 98eab2856626..389fd767a11f 100644
> --- a/mm/kmsan/Makefile
> +++ b/mm/kmsan/Makefile
> @@ -16,6 +16,14 @@ CC_FLAGS_KMSAN_RUNTIME += -DDISABLE_BRANCH_PROFILING
>
>  CFLAGS_REMOVE.o = $(CC_FLAGS_FTRACE)

That means this CFLAGS_REMOVE.o didn't work, right? Can it be removed?

> +# Disable ftrace to avoid recursion.
> +CFLAGS_REMOVE_core.o = $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_hooks.o = $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_init.o = $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_instrumentation.o = $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_report.o = $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_shadow.o = $(CC_FLAGS_FTRACE)
> +
>  CFLAGS_core.o := $(CC_FLAGS_KMSAN_RUNTIME)
>  CFLAGS_hooks.o := $(CC_FLAGS_KMSAN_RUNTIME)
>  CFLAGS_init.o := $(CC_FLAGS_KMSAN_RUNTIME)
> --
> 2.39.1
>

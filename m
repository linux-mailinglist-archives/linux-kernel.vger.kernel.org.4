Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06FC56978F6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 10:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbjBOJ1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 04:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234022AbjBOJ0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 04:26:54 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDFB222D1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 01:26:22 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id bx25so2029157uab.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 01:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8JZ7cPQMzKcdcwW48N+uKI3jJsqc1Zm4J233qZzbj50=;
        b=R+gC83k8XKNvKxK2e7FZ6xn9BdKpj6o3v/OEHn402y09PtX3uWtWWyLdVYxl8mKeNH
         QfOFvgkE45GxvXRpiobhSx5Tp3A5oPgsIcfTyzTrmErpKGfdKByexf17uXMikb/Bzp4V
         7yMBUGqy1/HxdMRlMQJk8VSqjXDboVdCVux4v0iTFWKn3knTY2YtH8ugxK8scWWSjL/W
         7zyw7Aa7jrUIlhYT90xOkiwBWGqddlVbdD4OdIZaVdMB14TbSWt1W/3uoqIAxwokGDVn
         WB0wvrPHwbRxMHltxHMuaX+lg5BIznJFNt6Q0zACvdSQI8/r+kCVeqltoSNpP5XoQ2hb
         4Oew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8JZ7cPQMzKcdcwW48N+uKI3jJsqc1Zm4J233qZzbj50=;
        b=HHumKNab0aBMoHmvt3AvAYEuavPF62dRFZBua9SwSVXqCEqE1U/RukhBFgzJ6HPulU
         ebmGEGcgLWMYpSOqO6ZgxYfXD6gcyqX55PWkU66Fbdux8CGo7XKCvcvMJlyGaCyJMkPi
         SPNnycciGoaaPf8w7CG/QkmvYtPsb9ucqskdb1BL0zow3RmKxdiu7kTyEoHsO1/qIFnf
         xTreK0MNkWf4ZYKmCCwix7a+c4uy2nrT04WwVPGtrJw6+pjscuJZJXQS/UK+3neM8W8n
         98uAYZRc48gLPPUGCiPFzXJMEuMjHYnFQi9qOuqkNrdZV+bDoZ3JRxBvaExb3YNPj4t5
         RWYA==
X-Gm-Message-State: AO0yUKWZz7OYJXX3+O8Gp9IE1T5gLBs/vLVrlsIyxx94r/mA2l9lv195
        YkYjP9AkFG3zstgsqMRkSF9ecYhJoR4AtfPdkffBPC7EtETIeUJs
X-Google-Smtp-Source: AK7set/RtoRfh2WTkzZlIUEXnVPW9gFOvFMFdmDxa2yP1SYxsLbCmAjCASPTcaSqtVyPJldtkwi2HZjvzOdF11ull9U=
X-Received: by 2002:ab0:7442:0:b0:661:1837:aad7 with SMTP id
 p2-20020ab07442000000b006611837aad7mr174248uaq.45.1676453181317; Wed, 15 Feb
 2023 01:26:21 -0800 (PST)
MIME-Version: 1.0
References: <20230215091503.1490152-1-arnd@kernel.org>
In-Reply-To: <20230215091503.1490152-1-arnd@kernel.org>
From:   Marco Elver <elver@google.com>
Date:   Wed, 15 Feb 2023 10:25:44 +0100
Message-ID: <CANpmjNNz+zuV5LpWj5sqeR1quK4GcumgQjjDbNx2m+jzeg_C7w@mail.gmail.com>
Subject: Re: [PATCH] kcsan: select CONFIG_CONSTRUCTORS
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
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

On Wed, 15 Feb 2023 at 10:15, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Building a kcsan enabled kernel for x86_64 with gcc-11 results in a lot
> of build warnings or errors without CONFIG_CONSTRUCTORS:
>
> x86_64-linux-ld: error: unplaced orphan section `.ctors.65436' from `arch/x86/lib/copy_mc.o'
> x86_64-linux-ld: error: unplaced orphan section `.ctors.65436' from `arch/x86/lib/cpu.o'
> x86_64-linux-ld: error: unplaced orphan section `.ctors.65436' from `arch/x86/lib/csum-partial_64.o'
> x86_64-linux-ld: error: unplaced orphan section `.ctors.65436' from `arch/x86/lib/csum-wrappers_64.o'
> x86_64-linux-ld: error: unplaced orphan section `.ctors.65436' from `arch/x86/lib/insn-eval.o'
> x86_64-linux-ld: error: unplaced orphan section `.ctors.65436' from `arch/x86/lib/insn.o'
> x86_64-linux-ld: error: unplaced orphan section `.ctors.65436' from `arch/x86/lib/misc.o'
>
> The same thing has been reported for mips64. I can't reproduce it for
> any other compiler version, so I don't know if constructors are always
> required here or if this is a gcc-11 specific implementation detail.
>
> I see no harm in always enabling constructors here, and this reliably
> fixes the build warnings for me.
>
> Link: https://lore.kernel.org/lkml/202204181801.r3MMkwJv-lkp@intel.com/T/
> Cc: Kees Cook <keescook@chromium.org>
> See-also: 3e6631485fae ("vmlinux.lds.h: Keep .ctors.* with .ctors")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Marco Elver <elver@google.com>

Looks like KASAN does select CONSTRUCTORS already, so KCSAN should as well.

Do you have a tree to take this through, or should it go through -rcu
as usual for KCSAN patches?

Thanks,
-- Marco

> ---
>  lib/Kconfig.kcsan | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
> index 4dedd61e5192..609ddfc73de5 100644
> --- a/lib/Kconfig.kcsan
> +++ b/lib/Kconfig.kcsan
> @@ -14,6 +14,7 @@ menuconfig KCSAN
>         bool "KCSAN: dynamic data race detector"
>         depends on HAVE_ARCH_KCSAN && HAVE_KCSAN_COMPILER
>         depends on DEBUG_KERNEL && !KASAN
> +       select CONSTRUCTORS
>         select STACKTRACE
>         help
>           The Kernel Concurrency Sanitizer (KCSAN) is a dynamic
> --
> 2.39.1
>

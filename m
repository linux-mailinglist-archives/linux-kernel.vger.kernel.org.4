Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6823B5EB068
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 20:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbiIZSoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 14:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbiIZSnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 14:43:53 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBF3EAD
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 11:42:39 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id s206so7360365pgs.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 11:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=/jJOs5JF7f5yYPOwficF4lSvd23WgsEKpbpbM5Pm4Kw=;
        b=W5iKjXkdq+vjFAuJhfIquPMYOB1QAeC8wZRs/aWH4VdIcZKs4NpaYNHb4u4MM47DZM
         HwYyfkCsoCGKhPd42a0f1/hR30s12dsys71NztHk2fi5Xe6JIraawfigeU73lt7SbYOO
         XpTkKHP9UkUw2gTaiXiGI+InMbnGDa25kJDqUp+qXu7ydbWwwnd7c/fjfemDjAbcJX3p
         5tJM48EW9ije9/KRUw9l5CRo8CpQHSn1FmdP7adpNM97pU983b2+RR4hiyqy+LDQcqcy
         GNcDiOb65jJ9hyT0xh/c7OlHu+/MxeRfrx+DU4zsUwP9clWmrU2Zdbc+3OoeM0b2hcp4
         Ichg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=/jJOs5JF7f5yYPOwficF4lSvd23WgsEKpbpbM5Pm4Kw=;
        b=t2+jmqRVzJ5ug2iA+zHyGsoxuZL5gfOnOqGLNe4HWZHKn7pNo0K5HY5sy6MPIn15Pz
         I7GzpCd3Qfftjvzw2VeH6H085sYxVbs+EEpqH9vUHr10DCurIHc95yyTjRiSPNhOIaIM
         vvSrLylWQ1LMZpNLwSqc3cERu1ZBsPzvbyDSpKBP4CM+Bb5TTr2M1l9L578vzVd5WJwx
         Fj8Pj7PKxKUHisL3BJkLGS4SvHPToQBTrIQBP692N6Ts0eb49UeX2vD+KQc5k5Pr4wHe
         R5quqfMMje1aHx1GCFbPtwC+ST0twBrwVIV9lgSWV9xAqarb4rvgEl27mOT4PkrTXRXi
         lycQ==
X-Gm-Message-State: ACrzQf2cfLJ0C6rN9YTtdVYB7oa+y8Re2zgaIDALtIjyIyWXXZjSL7N9
        ophrWzfYuuRaWzWD1sTj8dpKelnvkfmR7LctUqbOGw==
X-Google-Smtp-Source: AMsMyM6q/VixjsGTQyMlF4X/GU+qUATxeGOMtlYKVrEPK3hg8GJKv2iltmmq5s4T0UDcUhysW5PKwt/cE8rE9qbJ0DM=
X-Received: by 2002:a05:6a02:205:b0:420:8b7e:3ff with SMTP id
 bh5-20020a056a02020500b004208b7e03ffmr20363372pgb.427.1664217758945; Mon, 26
 Sep 2022 11:42:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdkCCyP8W2pHf9ETKMgUtKCgcSwUb6=bMJ_8riwjyknpCw@mail.gmail.com>
 <20220926183725.1112298-1-ndesaulniers@google.com>
In-Reply-To: <20220926183725.1112298-1-ndesaulniers@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 26 Sep 2022 11:42:27 -0700
Message-ID: <CAKwvOdnQ4tb7auWqUoF_Mm-F9hiJotaQnP75ZDd6oPJ_1Z4qXg@mail.gmail.com>
Subject: Re: [PATCH] ARM: kprobes: move __kretprobe_trampoline to out of line assembler
To:     Russell King <rmk+kernel@armlinux.org.uk>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        sparkhuang <huangshaobo6@huawei.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, llvm@lists.linux.dev,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        regressions@lists.linux.dev, lkft-triage@lists.linaro.org,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Logan Chien <loganchien@google.com>
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

On Mon, Sep 26, 2022 at 11:37 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> diff --git a/arch/arm/probes/kprobes/core.c b/arch/arm/probes/kprobes/core.c
> index 1435b508aa36..17d7e0259e63 100644
> --- a/arch/arm/probes/kprobes/core.c
> +++ b/arch/arm/probes/kprobes/core.c
> @@ -375,58 +375,10 @@ int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
>         return NOTIFY_DONE;
>  }
>
> -/*
> - * When a retprobed function returns, trampoline_handler() is called,
> - * calling the kretprobe's handler. We construct a struct pt_regs to
> - * give a view of registers r0-r11, sp, lr, and pc to the user
> - * return-handler. This is not a complete pt_regs structure, but that
> - * should be enough for stacktrace from the return handler with or
> - * without pt_regs.
> - */
> -void __naked __kprobes __kretprobe_trampoline(void)
> -{
> -       __asm__ __volatile__ (
> -               "ldr    lr, =__kretprobe_trampoline     \n\t"
> -#ifdef CONFIG_FRAME_POINTER
> -       /* __kretprobe_trampoline makes a framepointer on pt_regs. */
> -#ifdef CONFIG_CC_IS_CLANG
> -               "stmdb  sp, {sp, lr, pc}        \n\t"
> -               "sub    sp, sp, #12             \n\t"
> -               /* In clang case, pt_regs->ip = lr. */
> -               "stmdb  sp!, {r0 - r11, lr}     \n\t"
> -               /* fp points regs->r11 (fp) */
> -               "add    fp, sp, #44             \n\t"
> -#else /* !CONFIG_CC_IS_CLANG */
> -               /* In gcc case, pt_regs->ip = fp. */
> -               "stmdb  sp, {fp, sp, lr, pc}    \n\t"
> -               "sub    sp, sp, #16             \n\t"
> -               "stmdb  sp!, {r0 - r11}         \n\t"
> -               /* fp points regs->r15 (pc) */
> -               "add    fp, sp, #60             \n\t"
> -#endif /* CONFIG_CC_IS_CLANG */
> -#else /* !CONFIG_FRAME_POINTER */
> -               /* store SP, LR on stack and add EABI unwind hint */
> -               "stmdb  sp, {sp, lr, pc}        \n\t"
> -               ".save  {sp, lr, pc}    \n\t"
> -               "sub    sp, sp, #16             \n\t"
> -               "stmdb  sp!, {r0 - r11}         \n\t"
> -               ".pad   #52                             \n\t"
> -#endif /* CONFIG_FRAME_POINTER */
> -               "mov    r0, sp                  \n\t"
> -               "bl     trampoline_handler      \n\t"
> -               "mov    lr, r0                  \n\t"
> -               "ldmia  sp!, {r0 - r11}         \n\t"
> -               "add    sp, sp, #16             \n\t"
> -#ifdef CONFIG_THUMB2_KERNEL
> -               "bx     lr                      \n\t"
> -#else
> -               "mov    pc, lr                  \n\t"
> -#endif
> -               : : : "memory");
> -}
> +/*void __kretprobe_trampoline(void);*/

^ d'oh, that commented out declaration should have been removed. Will
wait for feedback wrt. usage of UNWIND and Fixes tag to see if a v2 is
necessary, vs what can be modified if/when applied by maintainers.
-- 
Thanks,
~Nick Desaulniers

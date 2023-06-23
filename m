Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBCDA73BE50
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 20:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjFWSNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 14:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjFWSNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 14:13:09 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FD5269F
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 11:13:07 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b466744368so16059791fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 11:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687543985; x=1690135985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+6IEeenRfWf/EqfOmmvm+NugflYscg70f5LhJK7HQ4=;
        b=ec6ZiPGqXtMg2vQQIiLgbW3jAGSyhY5vsuC/5dKlRTG2vrC9/Gox25r1sWJIK2cmAQ
         v0e2RRpex7dbYEBnNRZCquQuexWLEx4SxuLp3zM2FCiZTk+PqDE6hlWY2giBSeC5Npuc
         I6zeU78aaI7kXj5EJAS5Wdj8Agl0FYhA9B2PhEb+qE5ZgtzE7DX9v7VLb3ymbfMDY7HG
         PfZZXaEftRmQ2+FuHOS+Y1jhHAVoKfuM7kyvGarQC3HdDAbhUo84CwAFB7/hh3PosIfl
         YDM/EmvEMt0j6tSi/Swl1DwWFS7mxNH+i8CJ+kpylnJY7mfD9iBP2zvKSbe+45CLUk+L
         ZEhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687543985; x=1690135985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l+6IEeenRfWf/EqfOmmvm+NugflYscg70f5LhJK7HQ4=;
        b=OtKmjyBDsNm7rfxNr3icW9Dfz0uABCcMNrxl8FOS2Rc7DZm/X7Z8alutdiBN4fMZAP
         Jq/uQEni6R8wqOufnulBmL96fP5ihTrLUH/+ivkR57wOC/dCeqrb+Fvu4txfzePek0NK
         q9h7KqPgNJpgyPFP7dma7qiymQGlkI6gOmuVaGoBAa1m5hQ3Erhu9kDWFq9so454Mmuf
         LPB4dLpTJQvaGoTkqbPiAmp2/PLWgUmZD8hPodZ0DCIBbEOsdFPIH/+u66HagVLSHJmr
         /RPYvAnjiLkYT/BcK9JMh55BhysddtkxgFSCbeRAnJvNlDknG7Fh9ADo395keqfUlOG3
         nmHA==
X-Gm-Message-State: AC+VfDzVCnk2TO16anKRToR1dtY7H8sBXtMJa8rtkOOMZRyFj8OXHwHa
        xg7HdhKKVgJGotNe2+LKUSqTH/om2h2bw5NAbB7+Sek=
X-Google-Smtp-Source: ACHHUZ758DGH0m1Xcz+HIdkyBveut7OT8mRqGPdiTWgfRb4vZjYknep8SSLjduruN5BqGZuQhTUU6ND0NP6QTad8Gds=
X-Received: by 2002:a2e:3a19:0:b0:2b4:73bc:da9a with SMTP id
 h25-20020a2e3a19000000b002b473bcda9amr11285161lja.27.1687543984951; Fri, 23
 Jun 2023 11:13:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230622120750.5549-1-brgerst@gmail.com> <20230622120750.5549-3-brgerst@gmail.com>
In-Reply-To: <20230622120750.5549-3-brgerst@gmail.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Fri, 23 Jun 2023 14:12:52 -0400
Message-ID: <CAMzpN2gPf_pOcsaoMKuNONusEjvxhHYonH4zvomnp-LeTxF_Jg@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86: Rewrite ret_from_fork() in C
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        alyssa.milburn@linux.intel.com, keescook@chromium.org,
        jpoimboe@kernel.org, joao@overdrivepizza.com,
        tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 8:08=E2=80=AFAM Brian Gerst <brgerst@gmail.com> wro=
te:
>
> When kCFI is enabled, special handling is needed for the indirect call
> to the kernel thread function.  Rewrite the ret_from_fork() function in
> C so that the compiler can properly handle the indirect call.
>
> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Brian Gerst <brgerst@gmail.com>
> ---
>  arch/x86/entry/entry_32.S        | 30 +++++++--------------------
>  arch/x86/entry/entry_64.S        | 35 +++++++++-----------------------
>  arch/x86/include/asm/switch_to.h |  4 +++-
>  arch/x86/kernel/process.c        | 22 +++++++++++++++++++-
>  4 files changed, 41 insertions(+), 50 deletions(-)
>
> diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
> index 6c1ee76adc11..7932c14199fb 100644
> --- a/arch/x86/entry/entry_32.S
> +++ b/arch/x86/entry/entry_32.S
> @@ -727,37 +727,21 @@ SYM_CODE_END(__switch_to_asm)
>   * edi: kernel thread arg
>   */
>  .pushsection .text, "ax"
> -SYM_CODE_START(ret_from_fork)
> +SYM_CODE_START(ret_from_fork_asm)
>         /* return address for the stack unwinder */
>         pushl   $.Lsyscall_32_done
>         FRAME_BEGIN
>
> -       pushl   %eax
> -       call    schedule_tail
> +       /* prev already in EAX */
> +       movl    %esp, %edx      /* regs */
> +       movl    %ebx, %ecx      /* fn */
> +       pushl   %edi            /* fn_arg */
> +       call    ret_from_fork
>         addl    $4, %esp
>
> -       testl   %ebx, %ebx
> -       jnz     1f              /* kernel threads are uncommon */
> -
> -2:
> -       /* When we fork, we trace the syscall return in the child, too. *=
/
> -       movl    %esp, %eax
> -       call    syscall_exit_to_user_mode
> -
>         FRAME_END
>         RET
> -
> -       /* kernel thread */
> -1:     movl    %edi, %eax
> -       CALL_NOSPEC ebx
> -       /*
> -        * A kernel thread is allowed to return here after successfully
> -        * calling kernel_execve().  Exit to userspace to complete the ex=
ecve()
> -        * syscall.
> -        */
> -       movl    $0, PT_EAX(%esp)
> -       jmp     2b
> -SYM_CODE_END(ret_from_fork)
> +SYM_CODE_END(ret_from_fork_asm)
>  .popsection
>
>  SYM_ENTRY(__begin_SYSENTER_singlestep_region, SYM_L_GLOBAL, SYM_A_NONE)
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index f31e286c2977..5ee32e7e29e8 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -284,36 +284,21 @@ SYM_FUNC_END(__switch_to_asm)
>   * r12: kernel thread arg
>   */
>  .pushsection .text, "ax"
> -       __FUNC_ALIGN
> -SYM_CODE_START_NOALIGN(ret_from_fork)
> +SYM_CODE_START(ret_from_fork_asm)
>         UNWIND_HINT_END_OF_STACK
>         ANNOTATE_NOENDBR // copy_thread
>         CALL_DEPTH_ACCOUNT
> -       movq    %rax, %rdi
> -       call    schedule_tail                   /* rdi: 'prev' task param=
eter */
> -
> -       testq   %rbx, %rbx                      /* from kernel_thread? */
> -       jnz     1f                              /* kernel threads are unc=
ommon */
>
> -2:
> -       UNWIND_HINT_REGS
> -       movq    %rsp, %rdi
> -       call    syscall_exit_to_user_mode       /* returns with IRQs disa=
bled */
> -       jmp     swapgs_restore_regs_and_return_to_usermode
> +       /* return address for the stack unwinder */
> +       pushq   $swapgs_restore_regs_and_return_to_usermode
> +       UNWIND_HINT_FUNC
>
> -1:
> -       /* kernel thread */
> -       UNWIND_HINT_END_OF_STACK
> -       movq    %r12, %rdi
> -       CALL_NOSPEC rbx
> -       /*
> -        * A kernel thread is allowed to return here after successfully
> -        * calling kernel_execve().  Exit to userspace to complete the ex=
ecve()
> -        * syscall.
> -        */
> -       movq    $0, RAX(%rsp)
> -       jmp     2b
> -SYM_CODE_END(ret_from_fork)
> +       movq    %rax, %rdi              /* prev */
> +       movq    %rsp, %rsi              /* regs */

The push above makes this give the wrong address for regs.  New version com=
ing.

Brian Gerst

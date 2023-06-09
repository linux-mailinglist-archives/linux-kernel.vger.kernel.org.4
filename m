Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B8D72A551
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 23:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbjFIVY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 17:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbjFIVYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 17:24:23 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96E63A84
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 14:24:21 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-789de11638fso876713241.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 14:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686345861; x=1688937861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdR22/Dn+oev7vk8t/Tr492RL20kdJqWTXPUPVdb0hc=;
        b=h9Pl7EDgw/Oko95ySXm+jEVrLDh6BI0Mz9RBRez1O17wSPKof+RGRKEuBxXijTHsg9
         KbHURV/X4usXW336ls6rI03yl5Gc2aTSGqpfR9M9Y1x7U5PTAYccFxxjJ5zWkyumLRC8
         v4N0cdigRRSgQ/IPnouF2x/UBBUAwqW+tiQBYnhdMZKFdJq5Us8bO7PPLc7MFSnALLHM
         JC3BOyAjeeVzIn8IhXT7T4u4iBer+G9UyvUmTv9NPNfTHbNuV2QiBz7PB9tEbAWLya/8
         fzCqkdlTl12uaUIc0GRwrtb4URRNgDEHw5cHmE/msKYWYcK+rRt4azPCdoQzZC0cHRvo
         U7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686345861; x=1688937861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sdR22/Dn+oev7vk8t/Tr492RL20kdJqWTXPUPVdb0hc=;
        b=JCOZ9zdTgG+hDhaGu+qvOXYcyqFz1zDfxMWO7Z/80kZMbFGGG3mwQZkZf8j2U/nVxN
         F/PscoIBK7l0BmfIxUOvFthb9dwW/UZp6hEddQ55rlO1vjAJSrjP4cEYyxihScV6IwVY
         iopecP1TuKtj7IjlIpf176ORbYwHnfvoHxWaFDAsMXjsu3mf9bqxeKQsg93jqUfNXKr2
         Lp9txZZuvFLvfepKGNtN2WBaKqhoRgl3oj5ZzPbl48LXvcKGLMDwhiIDbUy+/MJDCXZH
         6hE6lsPvosodf1/vBwAFJzuywZR41kQKPdMQ4rB8gJbZ9kvPVgj2KLw0siwuFrmwAdIM
         lekA==
X-Gm-Message-State: AC+VfDwyK0gRog3gEHTDIJtvG0xvAODsQsaWbNH7/yD9ThV8ZfVy3OvR
        xmIuvUxbLR19pNSw8oF6jTYXtQxIdCUeQWuCPMEK7A==
X-Google-Smtp-Source: ACHHUZ5OXoFL30kGabu8C3ICNTZRa+j1RaV03HiGdItV9KOMMZLD5Lt7ZJOLWtozoUcQeacTby9geMSyvFoSBzASxqk=
X-Received: by 2002:a67:efd4:0:b0:43b:131f:1b50 with SMTP id
 s20-20020a67efd4000000b0043b131f1b50mr2184071vsp.24.1686345860593; Fri, 09
 Jun 2023 14:24:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230608142428.256985-1-masahiroy@kernel.org> <20230608142428.256985-2-masahiroy@kernel.org>
In-Reply-To: <20230608142428.256985-2-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 9 Jun 2023 14:23:02 -0700
Message-ID: <CAKwvOdnvxxPFbJ3bPu9-WqrQD4nS2vd2X-5=mgeruTrgTPm=zw@mail.gmail.com>
Subject: Re: [PATCH v7 01/11] Revert "[PATCH] uml: export symbols added by GCC hardened"
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 8, 2023 at 7:24=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.or=
g> wrote:
>
> This reverts commit cead61a6717a9873426b08d73a34a325e3546f5d.
>
> It exported __stack_smash_handler and __guard, while they may not be
> defined by anyone.
>
> The code *declares* __stack_smash_handler and __guard. It does not
> create weak symbols. When the stack-protector is disabled, they are
> left undefined, but yet exported.
>
> If a loadable module tries to access non-existing symbols, bad things
> (a page fault, NULL pointer dereference, etc.) will happen. So, the
> current code is wrong.
>
> If the code were written as follows, it would *define* them as weak
> symbols so modules would be able to get access to them.
>
>   void (*__stack_smash_handler)(void *) __attribute__((weak));
>   EXPORT_SYMBOL(__stack_smash_handler);
>
>   long __guard __attribute__((weak));
>   EXPORT_SYMBOL(__guard);
>
> In fact, modpost forbids exporting undefined symbols. It shows an error
> message if it detects such a mistake.
>
>   ERROR: modpost: "..." [...] was exported without definition
>
> Unfortunately, it is checked only when the code is built as modular.
> The problem described above has been unnoticed for a long time because
> arch/um/os-Linux/user_syms.c is always built-in.
>
> With a planned change in Kbuild, exporting undefined symbols will always
> result in a build error instead of a run-time error. It is a good thing,
> but we need to fix the breakage in advance.
>
> One fix is to *define* weak symbols as shown above. An alternative is
> to export them conditionally as follows:
>
>   #ifdef CONFIG_STACKPROTECTOR
>   extern void __stack_smash_handler(void *);
>   EXPORT_SYMBOL(__stack_smash_handler);
>
>   external long __guard;
>   EXPORT_SYMBOL(__guard);
>   #endif
>
> This is what other architectures do; EXPORT_SYMBOL(__stack_chk_guard)
> is guarded by #ifdef CONFIG_STACKPROTECTOR.
>
> However, adding the #ifdef guard is not sensible because UML cannot
> enable the stack-protector in the first place! (Please note UML does
> not select HAVE_STACKPROTECTOR in Kconfig.)
>
> So, the code is already broken (and unused) in multiple ways.
>
> Just remove.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
> Changes in v7:
>   - New patch
>
>  arch/um/os-Linux/user_syms.c | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/arch/um/os-Linux/user_syms.c b/arch/um/os-Linux/user_syms.c
> index 9b62a9d352b3..a310ae27b479 100644
> --- a/arch/um/os-Linux/user_syms.c
> +++ b/arch/um/os-Linux/user_syms.c
> @@ -37,13 +37,6 @@ EXPORT_SYMBOL(vsyscall_ehdr);
>  EXPORT_SYMBOL(vsyscall_end);
>  #endif
>
> -/* Export symbols used by GCC for the stack protector. */
> -extern void __stack_smash_handler(void *) __attribute__((weak));
> -EXPORT_SYMBOL(__stack_smash_handler);
> -
> -extern long __guard __attribute__((weak));
> -EXPORT_SYMBOL(__guard);
> -
>  #ifdef _FORTIFY_SOURCE
>  extern int __sprintf_chk(char *str, int flag, size_t len, const char *fo=
rmat);
>  EXPORT_SYMBOL(__sprintf_chk);
> --
> 2.39.2
>


--=20
Thanks,
~Nick Desaulniers

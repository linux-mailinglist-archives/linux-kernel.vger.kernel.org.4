Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B04F74BB72
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 04:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbjGHCkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 22:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjGHCkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 22:40:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985E48E
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 19:40:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC18A61AD8
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 02:40:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BBE7C433C7
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 02:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688784000;
        bh=sY8fPTZmzlxchUCrv0uNB0ezlHl4rk/ktLPIerI7BcI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=quFOQ1uycLdTD7SRlNQ7V38lG1cqmqcfuNOeIVguc2aGc6dSnkvQfmLRsxg5bcOqI
         4vMRzN9onylNTpFKNwSaurFVf7nQXpljT0iPkNvqfKzsB6DLKXhWWnRDhf8i6u1fUw
         I4qqBsq2xASOrUNf+T12tvDceFqdRb4vYeUazU4mrAPK3c+bLH6HD+jPIMPddrOLDp
         HJOP0iGuX0bqNL8AUxgq7ij2csPkKlGAzscR91dw2ffOn8RHo3OWRh3o+MR+3EkR+1
         96RB02DDOSiNviwUFaEDEtPztc2ppQL+CD9el9ska4OSPE5vNn5DhTgw+gyG8uJiX3
         eX4chUy0WUj1w==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-4fb94b1423eso3900822e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 19:40:00 -0700 (PDT)
X-Gm-Message-State: ABy/qLay+kRA1423kd4KKOb/ievTCEYk84IjPYHpb9K0QQUpDDX0u61S
        8gfG0ek6dspWQho6O1iRUXLjExF9/N5eDx82pIk=
X-Google-Smtp-Source: APBJJlFAge7K/MgqzqgAYeNUmlApriNbCjGxTCrG1CKjQjo4GB4VVzxqV0RN5/vZwwtZrfGgsC0oCWt4gc4lY3e5Ybk=
X-Received: by 2002:a19:7b0c:0:b0:4fb:7447:e71a with SMTP id
 w12-20020a197b0c000000b004fb7447e71amr4496882lfc.63.1688783998311; Fri, 07
 Jul 2023 19:39:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230628181926.4102448-1-yhs@fb.com>
In-Reply-To: <20230628181926.4102448-1-yhs@fb.com>
From:   Song Liu <song@kernel.org>
Date:   Sat, 8 Jul 2023 10:39:44 +0800
X-Gmail-Original-Message-ID: <CAPhsuW4LDGOtWVpqRn4zFD8j34Biq+w-LNW6f+Ac+K9kmrgSoQ@mail.gmail.com>
Message-ID: <CAPhsuW4LDGOtWVpqRn4zFD8j34Biq+w-LNW6f+Ac+K9kmrgSoQ@mail.gmail.com>
Subject: Re: [PATCH v2] kallsyms: strip LTO-only suffixes from promoted global functions
To:     Yonghong Song <yhs@fb.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Fangrui Song <maskray@google.com>, kernel-team@fb.com,
        Leizhen <thunder.leizhen@huawei.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 2:19=E2=80=AFAM Yonghong Song <yhs@fb.com> wrote:
>
> Commit 6eb4bd92c1ce ("kallsyms: strip LTO suffixes from static functions"=
)
> stripped all function/variable suffixes started with '.' regardless
> of whether those suffixes are generated at LTO mode or not. In fact,
> as far as I know, in LTO mode, when a static function/variable is
> promoted to the global scope, '.llvm.<...>' suffix is added.
>
> The existing mechanism breaks live patch for a LTO kernel even if
> no <symbol>.llvm.<...> symbols are involved. For example, for the followi=
ng
> kernel symbols:
>   $ grep bpf_verifier_vlog /proc/kallsyms
>   ffffffff81549f60 t bpf_verifier_vlog
>   ffffffff8268b430 d bpf_verifier_vlog._entry
>   ffffffff8282a958 d bpf_verifier_vlog._entry_ptr
>   ffffffff82e12a1f d bpf_verifier_vlog.__already_done
> 'bpf_verifier_vlog' is a static function. '_entry', '_entry_ptr' and
> '__already_done' are static variables used inside 'bpf_verifier_vlog',
> so llvm promotes them to file-level static with prefix 'bpf_verifier_vlog=
.'.
> Note that the func-level to file-level static function promotion also
> happens without LTO.
>
> Given a symbol name 'bpf_verifier_vlog', with LTO kernel, current mechani=
sm will
> return 4 symbols to live patch subsystem which current live patching
> subsystem cannot handle it. With non-LTO kernel, only one symbol
> is returned.
>
> In [1], we have a lengthy discussion, the suggestion is to separate two
> cases:
>   (1). new symbols with suffix which are generated regardless of whether
>        LTO is enabled or not, and
>   (2). new symbols with suffix generated only when LTO is enabled.
>
> The cleanup_symbol_name() should only remove suffixes for case (2).
> Case (1) should not be changed so it can work uniformly with or without L=
TO.
>
> This patch removed LTO-only suffix '.llvm.<...>' so live patching and
> tracing should work the same way for non-LTO kernel.
> The cleanup_symbol_name() in scripts/kallsyms.c is also changed to have t=
he same
> filtering pattern so both kernel and kallsyms tool have the same
> expectation on the order of symbols.
>
>  [1] https://lore.kernel.org/live-patching/20230615170048.2382735-1-song@=
kernel.org/T/#u
>
> Fixes: 6eb4bd92c1ce ("kallsyms: strip LTO suffixes from static functions"=
)
> Reported-by: Song Liu <song@kernel.org>
> Signed-off-by: Yonghong Song <yhs@fb.com>

Acked-by: Song Liu <song@kernel.org>

> ---
>  kernel/kallsyms.c  | 5 ++---
>  scripts/kallsyms.c | 6 +++---
>  2 files changed, 5 insertions(+), 6 deletions(-)
>
> Changelogs:
>   v1 -> v2:
>     . add 'Reported-by: Song Liu <song@kernel.org>'
>     . also fix in scripts/kallsyms.c.
>
> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index 77747391f49b..4874508bb950 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
> @@ -174,11 +174,10 @@ static bool cleanup_symbol_name(char *s)
>          * LLVM appends various suffixes for local functions and variable=
s that
>          * must be promoted to global scope as part of LTO.  This can bre=
ak
>          * hooking of static functions with kprobes. '.' is not a valid
> -        * character in an identifier in C. Suffixes observed:
> +        * character in an identifier in C. Suffixes only in LLVM LTO obs=
erved:
>          * - foo.llvm.[0-9a-f]+
> -        * - foo.[0-9a-f]+
>          */
> -       res =3D strchr(s, '.');
> +       res =3D strstr(s, ".llvm.");
>         if (res) {
>                 *res =3D '\0';
>                 return true;
> diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> index 0d2db41177b2..13af6d0ff845 100644
> --- a/scripts/kallsyms.c
> +++ b/scripts/kallsyms.c
> @@ -346,10 +346,10 @@ static void cleanup_symbol_name(char *s)
>          * ASCII[_]   =3D 5f
>          * ASCII[a-z] =3D 61,7a
>          *
> -        * As above, replacing '.' with '\0' does not affect the main sor=
ting,
> -        * but it helps us with subsorting.
> +        * As above, replacing the first '.' in ".llvm." with '\0' does n=
ot
> +        * affect the main sorting, but it helps us with subsorting.
>          */
> -       p =3D strchr(s, '.');
> +       p =3D strstr(s, ".llvm.");
>         if (p)
>                 *p =3D '\0';
>  }
> --
> 2.34.1
>

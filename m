Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44ED974B981
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 00:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjGGW1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 18:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjGGW1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 18:27:37 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FB1211F
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 15:27:35 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-7659dc74da1so219735485a.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 15:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688768855; x=1691360855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M11brMTtotbFVLzj4X4lTncnHIwCm2Zf8rkXtvsipsQ=;
        b=vC6qWQxkXGfXOLG5MVnh7rjsbsQpPKJlKIIfsHZnJyTf9E5goqA5DN13jqiy7u/qoX
         +pl6G4Ft4je/wY2W6JSrIJSdDan2iGXNbv4U1UABZRQe/TrzD3dHxf3aiZcLB5EENUBN
         Mbnu9hXeoNdXMTOUqZiv1L4jOEf2l5SJ+Eprv51B5XVR2dwlcTOjl8qPhGcOI1twm8MF
         nb2u7YKdlLiKTEuGDSJxcvNj0YkWT4LxpbzkpbZsgzN8mWStoCe4WFBAkdhzAevJKbGh
         rlQfJuL/vlPaJ2ez5sBj9bd9dvZryk1VxpDtVFPwxd5cPUAwwdVEqJj71uucgfQuQ/q6
         g71g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688768855; x=1691360855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M11brMTtotbFVLzj4X4lTncnHIwCm2Zf8rkXtvsipsQ=;
        b=KTbArGPnZQHypRARyJB0x81R3R605RLNU8G13kSLmenmVqrrDL0TyCwm9ZshItKSzt
         MVs1iiKkOcFJLKO3G3uKuQCoUmwA1Ht0kSeiWsskMTzdJ0p909zMvjApz+fy7N6vQEuM
         Hxkdt979L3CRO6b9+78Ogs+Q7NF3r/+qyoQVMnOHpWc3OKxr9Zs25KiQqK0N0KYydXGr
         SiwW1FT/a7SECyw8aO+W/Jhba/mSwJsLcPRMDZejSEzn4ZZt8UTQZmr/gwyQFIy7xvUs
         mP2XJv0HEsKJ3MmUwQN8MWZlrIR6nBVqJ85uCEKz+V18XX8EF8pBFYQNkVq8VrUxZz67
         CWuA==
X-Gm-Message-State: ABy/qLaFxawjo723W7qmCnNoNGCuW6pt6eEqlOS2sDWxATw0P6wwEHl0
        Ylb1BHAqhsrD48pGoRzAEi6luESRfG/w0esIHE0bpw==
X-Google-Smtp-Source: APBJJlH89jF/4fQmPOPYtbkj8S3UrudUI50F/TSq49MlnMtbZRNScnk727WYFAglj3OAFCeaVzlUJdA5SnBQJFc2H1Y=
X-Received: by 2002:a05:620a:2588:b0:767:2f4a:e07a with SMTP id
 x8-20020a05620a258800b007672f4ae07amr6955904qko.68.1688768854702; Fri, 07 Jul
 2023 15:27:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230628181926.4102448-1-yhs@fb.com>
In-Reply-To: <20230628181926.4102448-1-yhs@fb.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 7 Jul 2023 15:27:23 -0700
Message-ID: <CAKwvOdm_Cp9dF1yseTXvOOtFMsOPzCBWhfszAt0k5SXXyFyjtw@mail.gmail.com>
Subject: Re: [PATCH v2] kallsyms: strip LTO-only suffixes from promoted global functions
To:     Yonghong Song <yhs@fb.com>
Cc:     Petr Mladek <pmladek@suse.com>, Song Liu <song@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Fangrui Song <maskray@google.com>, kernel-team@fb.com,
        Leizhen <thunder.leizhen@huawei.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Sami Tolvanen <samitolvanen@google.com>,
        "KE . LI" <like1@oppo.com>,
        Padmanabha Srinivasaiah <treasure4paddy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 11:19=E2=80=AFAM Yonghong Song <yhs@fb.com> wrote:
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

Thanks for the patch and improving live patch with LTO.  Looking back
at the internal report that resulted in
commit 6eb4bd92c1ce ("kallsyms: strip LTO suffixes from static functions")
your version was what I originally had.  I did not leave a comment as
to why I changed it when I sent it 2 years ago, and no longer recall
the reason.


Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

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


--=20
Thanks,
~Nick Desaulniers

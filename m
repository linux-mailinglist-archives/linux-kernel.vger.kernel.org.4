Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A5B60BBB7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 23:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbiJXVLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 17:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbiJXVKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 17:10:36 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1E42CE608
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 12:17:11 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id io19so4321468plb.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 12:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lEIAgIaq7xwDYOXkCfqCwVLGJ7bTE5nHIiB+jrGhv9o=;
        b=N+cAdNyMQXR/tbR8q02b2KsJU34NsOg8AsmZchm09Z2l4h6y4DUccY8EGCAKpFsyo+
         hVUIcNMrL7/tnzDf5cv+joc3p07uIr/yzJbz+OvO17e7SsF6tb9f4yBJcOuBSoLp0ES1
         s5B1qsFCCADwGRqSnL8cxDy82PrJ3kjygJ5mqJ1q4rkm1CSxew9saqIaoal+qYo0pRBR
         aVvUz4wGZQqnUzXObp4x9hDTVuLE6IUQIzjb7EFc+ekpHAaHAGFmTgdGFyAK6CfK6rLf
         3dxwl447zqq1U/1aHH7GQL+/vSEEBAS7gtdGRmuVyzUfhMRuBOxs7t7JZNTQhO2xnzhh
         o9pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lEIAgIaq7xwDYOXkCfqCwVLGJ7bTE5nHIiB+jrGhv9o=;
        b=HczYUBhVTv+LshpJg/6NhqU8dmQQB+rERJklSYcZSxabx5msu1O2N8pfFeUBsOeR2Y
         vQyQQYujV62bdMOrGKbmrFQkd1VH7nmp2e3sIvrtV5nFaUhDbYKrorJMdYYpcCD0YIj3
         65VYuhOzj0+92mNBZNTGU4K61LqaOUmjwGqKe9h6PVxgPzeHeI/vPjtpYhoLH+5F9l47
         LoToEqkUeV32Swa1XCfJkrqewK2pdUyyrvx5FculYb+NdxokY5Sh5gFg6Gk5vA/+f5u3
         22eIV473I6bUGPHAIXX+erb1Q3CggDPSEr2tr6aXbWAZ8bhbpKGhjySsBLKZltpFpLTO
         2D3g==
X-Gm-Message-State: ACrzQf0ZlDbXEFCRKYkXOvP7gTCK5BMdyKANAjlF9SHGQ8ooO8DAcmO+
        MfGyJSYO8h9DVdrQpqmdwpmj81hsNLKKr4V0J3Zxiw==
X-Google-Smtp-Source: AMsMyM7tbBbsSJUv0yupVMnL0+TpbuvReM9TeIGhfkgoLv6T1JBl44WEe3hE4Q6zQu0W3AhFNSVNU/KHSbG8x77l5ik=
X-Received: by 2002:a17:902:b210:b0:17d:c3ca:4a4f with SMTP id
 t16-20020a170902b21000b0017dc3ca4a4fmr33920252plr.33.1666638950116; Mon, 24
 Oct 2022 12:15:50 -0700 (PDT)
MIME-Version: 1.0
References: <20221023195257.175946-1-masahiroy@kernel.org>
In-Reply-To: <20221023195257.175946-1-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 24 Oct 2022 12:15:38 -0700
Message-ID: <CAKwvOd=pimEoN_OvyefPiTTsOdzo+Xda1gJrYg8+jAE5GA0rqA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: fix 'Broken pipe' message for AR=gcc-ar
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>, eng.stk@sapo.pt
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 23, 2022 at 12:53 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Since commit 321648455061 ("kbuild: use obj-y instead extra-y for
> objects placed at the head"), 'make AR=gcc-ar' shows the following
> message:
>
>   /usr/bin/ar terminated with signal 13 [Broken pipe]

Not just AR=gcc-ar, but also AR=llvm-ar:

error: write on a pipe with no reader

Link: https://github.com/ClangBuiltLinux/linux/issues/1651
Reported-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>

Note that due to
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8017ce50641c303b9b5d96f3c10229ecfd770a70
we should send a backport to stable like:
https://github.com/engstk/op8/commit/6f2688e3eb4ec06b276e541640d4f06364b68442

>
> The resulting vmlinux is correct, but it is better to silence this.
>
> 'head -n1' exits after reading the first line, so the pipe is closed.
>
> Use 'sed -n 1p' to eat the stream till the end.
>
> Fixes: 321648455061 ("kbuild: use obj-y instead extra-y for objects placed at the head")
> Reported-by: Jiri Slaby <jirislaby@kernel.org>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index f41ec8c8426b..0e42a7982826 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1218,7 +1218,7 @@ quiet_cmd_ar_vmlinux.a = AR      $@
>        cmd_ar_vmlinux.a = \
>         rm -f $@; \
>         $(AR) cDPrST $@ $(KBUILD_VMLINUX_OBJS); \
> -       $(AR) mPiT $$($(AR) t $@ | head -n1) $@ $$($(AR) t $@ | grep -F --file=$(srctree)/scripts/head-object-list.txt)
> +       $(AR) mPiT $$($(AR) t $@ | sed -n 1p) $@ $$($(AR) t $@ | grep -F --file=$(srctree)/scripts/head-object-list.txt)
>
>  targets += vmlinux.a
>  vmlinux.a: $(KBUILD_VMLINUX_OBJS) scripts/head-object-list.txt autoksyms_recursive FORCE
> --
> 2.34.1
>


-- 
Thanks,
~Nick Desaulniers

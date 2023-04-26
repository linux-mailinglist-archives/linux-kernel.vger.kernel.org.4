Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5056EF4D7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 15:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240873AbjDZNDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 09:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240010AbjDZNDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 09:03:41 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B6440FF;
        Wed, 26 Apr 2023 06:03:38 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id 3f1490d57ef6-b95c3b869dcso25206587276.1;
        Wed, 26 Apr 2023 06:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682514218; x=1685106218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9tn7zb5KrY1tZ1RibX4mXJmyAQDX8JQUvrueQad8GjY=;
        b=KiP4YnyiQR9xXZhaSCRyWzbZXzvrCR7jaygFdawWopk6DSnynzjqUSXo/X8tDPASXC
         msqdDqqT+rYPKfgKPW64MIVm9+RcX+0B0hZTHKb7g28qNrtr2aY0Pv8eU3r0cqVygA37
         PZ1Ssv/xsgasH0v8H+VWfmNl+lolhsU1ELS6B+XVWS6/FfkJQ31Wajvwz/RDJqKS2D0Z
         ZGq8pE+c0CqWZYtCzD/Qv+6ILMR3LOt2OF+qHxAlcHiyC+u4VMSecLpXGGiZox1dFNSu
         3sYrU6uDXHRKWBZXZSlVR+yWLw0yjJFkAePHzUGcfJVUUuMdDTC0MY4ppcbNtLkucmQE
         r5dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682514218; x=1685106218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9tn7zb5KrY1tZ1RibX4mXJmyAQDX8JQUvrueQad8GjY=;
        b=a4vxp1h8P1zVPRnTz65j/iGglihUwP8wGC0gX4V6UBYiFrZO18vKbhNzGssAEek+HV
         JjFyKD6bSISfVUpUDist6mDHwIAV6VMuA0dwrYHh5915fQpLkhodcJ3jv3O0KbA/1C0a
         tRXRIEOo9gUTQhV0DIaSX9bWgOT53dVmiS7GttgxHm0kyzsATuRstwlR4XejnXng0xqd
         T6H5GnRTTVRHXymnkktFXW4PrAD/dqvR+5OCnjqkg5YWfHQM4WyFlnkr9jpj0CwHRdQ2
         R8bo8ML7sb0XI9/RcQO+445adfcqLmDvIbEzKLEsrKb8RyaMdczcc/P0b1LQJve9Th2a
         vAGA==
X-Gm-Message-State: AC+VfDwWyAmDi31+3tu5LBMLG1Q5+QLy8Ov7QkFvZ7QzBp3KnnEFc9qG
        Im8XPiqbXerKrwsdKdnr2czd98rX/ll2CzLKlWn04W048hHjk+pnbKg=
X-Google-Smtp-Source: ACHHUZ4H/VbAY1+pHKI6jnm71og5XCs0SQW7rsBnLfKLTS5Htkp5SGqZr+D6arl2Wej2KL1RrH8fK6wVgFhpuRehc9U=
X-Received: by 2002:a81:6c42:0:b0:54f:52b7:3eac with SMTP id
 h63-20020a816c42000000b0054f52b73eacmr1621497ywc.9.1682514217805; Wed, 26 Apr
 2023 06:03:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230426124948.1072216-1-zhanggenjian@kylinos.cn>
In-Reply-To: <20230426124948.1072216-1-zhanggenjian@kylinos.cn>
From:   genjian zhang <zhanggenjian123@gmail.com>
Date:   Wed, 26 Apr 2023 21:02:25 +0800
Message-ID: <CAOd03yQ98st7KvAkwfFqFvXGBdmWmOZZ-kWAH5DAi7gLd=ngaA@mail.gmail.com>
Subject: Re: [PATCH] fix ___SYNC () build error when PROFILE_ALL_BRANCHES is enabled
To:     tsbogend@alpha.franken.de
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Genjian Zhang <zhanggenjian@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023 at 8:51=E2=80=AFPM Genjian <zhanggenjian123@gmail.com>=
 wrote:
>
> From: Genjian Zhang <zhanggenjian@kylinos.cn>
>
> compiler error (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110):
>
> {standard input}: Assembler messages:
> {standard input}:171: Error: found '(', expected: ')'
> {standard input}:171: Error: found '(', expected: ')'
> {standard input}:171: Error: non-constant expression in ".if" statement
> {standard input}:171: Error: junk at end of line, first unrecognized
> character is `('
>
> Preprocessor expand ___SYNC () macros.However,'if' will be wrongly
> replaced by C code when PROFILE_ALL_BRANCHES is enabled and ___SYNC
> is used in inline assembly.This leads to syntax errors in the code.
> Compilers report a lot of errors like the above.
> Move '.if' into quoted strings to fix it.
>
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: Genjian Zhang <zhanggenjian@kylinos.cn>
> ---
>  arch/mips/include/asm/sync.h | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/arch/mips/include/asm/sync.h b/arch/mips/include/asm/sync.h
> index aabd097933fe..d9f5a87424e7 100644
> --- a/arch/mips/include/asm/sync.h
> +++ b/arch/mips/include/asm/sync.h
> @@ -175,7 +175,7 @@
>   */
>  #ifdef CONFIG_CPU_HAS_SYNC
>  # define ____SYNC(_type, _reason, _else)                       \
> -       .if     (( _type ) !=3D -1) && ( _reason );               \
> +       ((_type) !=3D -1) && (_reason);                           \
>         .set    push;                                           \
>         .set    MIPS_ISA_LEVEL_RAW;                             \
>         .rept   __SYNC_rpt(_type);                              \
> @@ -192,13 +192,15 @@
>  /*
>   * Preprocessor magic to expand macros used as arguments before we inser=
t them
>   * into assembly code.
> + * In addition,=E2=80=98if=E2=80=99 can not be substituted when CONFIG_P=
ROFILE_ALL_BRANCHES is
> + * enabled.
>   */
>  #ifdef __ASSEMBLY__
>  # define ___SYNC(type, reason, else)                           \
> -       ____SYNC(type, reason, else)
> +       .if     ____SYNC(type, reason, else)
>  #else
>  # define ___SYNC(type, reason, else)                           \
> -       __stringify(____SYNC(type, reason, else))
> +       ".if"   __stringify(____SYNC(type, reason, else))
>  #endif
>
>  #define __SYNC(type, reason)                                   \
> --
> 2.25.1
>

Maybe the readability of this modification is not very good. Any
comments and suggestions are welcome. Thanks.

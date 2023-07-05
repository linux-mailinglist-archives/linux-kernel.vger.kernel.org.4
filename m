Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF268747C0B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 06:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjGEE2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 00:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjGEE2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 00:28:25 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C3810F2
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 21:28:24 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-516500163b2so21932a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 21:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688531303; x=1691123303;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eqCyEfc/meiKmyophP6EkBO/+qYFrUQUQP3N97X+Wd0=;
        b=U1iQ+YXT9cSqLHloZJJsF4TMP9CkOWX8W3DNAxPBRaNdoKhogb8x3EPmIip6ECZ2HT
         n/ej7z6hyCoqlCg+TEuL0gwgDoWCmyWGtaiT92vsVB7YJiHTqevNL2F2KkBhsrFV3lCm
         oQt7Su/KlxYiiuoXp1se/j19qURFYN72oTguyahVNuCpbFsbWBUEMYf9jYIwl3d0qd1/
         e9IcbSEsfPV9aUCe+KHB0l6wz+qUuRaZ9W0X1HRWHSGkuLQlo+8tgNKWq6lxB5Q9+OA2
         c1bY1bfWQ/ONJX4hlCwfJyvpdKqCX3vAD2DoQ0YIpOQlkjU2wrEYDL2pT6xWD8Zm/laJ
         T1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688531303; x=1691123303;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eqCyEfc/meiKmyophP6EkBO/+qYFrUQUQP3N97X+Wd0=;
        b=BI3ivX1LMFJV5u0eWbCADRCVrTy6p4pgv4qTBjwdPxoIAfgitM+WnhpyXXd7eJTYax
         CZ/cf/3BmYz2mVl4Nmuw3noCBHkhQdOmZE24WC2woxMMeZSflEwAEai+kt2ETAKxnZAw
         RNZKPqyJktEcj5EI27xPz2MEqtbV8NO/QnYxZTJTbtbVWgh+dnbZq31TMXFOhFycv3nr
         lQUcR32xbh0cYox6tBAQ9C8LFGfJhWaYlkX0PxT6EksiacDhuWsXIn8hSkz77iLvuQLi
         yWs7vOgGYCWxx93cFnS2YbZHTH0JLUnaH32XApKyS6V5ORSIbXlwb3np6KRzkDt0I0wD
         ITIQ==
X-Gm-Message-State: ABy/qLb7IySf6tDuZ2ARLT5tKs795k+jfdV4wnI/NC4UQZ8eli0aSx0T
        cKFA02+izN4OBptBHql0kW9vYeyDYkCk21IVF+UPEQ==
X-Google-Smtp-Source: APBJJlFLoW7TH9a7+C5SKe7FDeowfeUljUyL/txyEr6D99OEXF6XGlwhWi/zj6SVQoBFDsINPya6D5QeOcy5wQRjc3o=
X-Received: by 2002:a50:8e58:0:b0:51e:27ac:8f9a with SMTP id
 24-20020a508e58000000b0051e27ac8f9amr10796edx.1.1688531302794; Tue, 04 Jul
 2023 21:28:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1688460800.git.pengfei.xu@intel.com> <582ab7050597df7a996c11df048f168995b30747.1688460800.git.pengfei.xu@intel.com>
In-Reply-To: <582ab7050597df7a996c11df048f168995b30747.1688460800.git.pengfei.xu@intel.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 5 Jul 2023 06:28:10 +0200
Message-ID: <CACT4Y+aBNX9U7yeH8jz5y82tV46iChCFXufg92gSXrdRubqJsw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] x86/kernel: Increase kcov coverage under
 arch/x86/kernel folder
To:     Pengfei Xu <pengfei.xu@intel.com>
Cc:     nogikh@google.com, linux-kernel@vger.kernel.org,
        Heng Su <heng.su@intel.com>, syzkaller@googlegroups.com,
        keescook@google.com, Mehta Sohil <sohil.mehta@intel.com>,
        kirill.shutemov@linux.intel.com, akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 4 Jul 2023 at 10:58, Pengfei Xu <pengfei.xu@intel.com> wrote:
>
> Currently kcov instrument is disabled for object files under arch/x86/kernel
> folder.
> For object files under arch/x86/kernel, actually just disabling the kcov
> instrument of files:"head32.o or head64.o and sev.o" could achieve
> successful booting and provide kcov coverage for object files that do not
> disable kcov instrument.
> The additional kcov coverage collected from arch/x86/kernel folder helps
> kernel fuzzing efforts to find bugs.
>
> Link to related improvement discussion is below:
> https://groups.google.com/g/syzkaller/c/Dsl-RYGCqs8/m/x-tfpTyFBAAJ
> Related ticket is as follow:
> https://bugzilla.kernel.org/show_bug.cgi?id=198443
>
> Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>

Reviewed-and-tested-by: Dmitry Vyukov <dvyukov@google.com>

I've run a local syzkaller instance with this and I don't see any
additional kernel bugs caused by this and I see coverage in
arch/x86/kernel/* now, in particular, dumpstack.c, perf_regs.c,
signal.c.


> ---
>  arch/x86/kernel/Makefile | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> index 4070a01c11b7..00df34c263cc 100644
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -33,11 +33,10 @@ KCSAN_SANITIZE := n
>  KMSAN_SANITIZE_head$(BITS).o                           := n
>  KMSAN_SANITIZE_nmi.o                                   := n
>
> -# If instrumentation of this dir is enabled, boot hangs during first second.
> -# Probably could be more selective here, but note that files related to irqs,
> -# boot, dumpstack/stacktrace, etc are either non-interesting or can lead to
> -# non-deterministic coverage.
> -KCOV_INSTRUMENT                := n
> +# If instrumentation of the following files is enabled, boot hangs during
> +# first second.
> +KCOV_INSTRUMENT_head$(BITS).o                          := n
> +KCOV_INSTRUMENT_sev.o                                  := n
>
>  CFLAGS_irq.o := -I $(srctree)/$(src)/../include/asm/trace
>
> --
> 2.31.1
>

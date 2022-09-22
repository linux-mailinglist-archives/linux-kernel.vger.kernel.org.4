Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0EA5E6F3C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 00:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiIVWBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 18:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiIVWBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 18:01:02 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28208EA5B0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 15:00:58 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id p202so2640706iod.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 15:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ZW8ngLQwncVL4JlsWyY79eXQGckyqSHpOZGjTmoa8g4=;
        b=mKNJTkG+9zTEF1nC+8SnCcxqCpl+oDPYgrtavI2qnADjB0dM4zPUYLbxevunZP+bf3
         /Y30GdsitvKXOFFHEm7eUut5SThUUVIUAKEUNd75FXYFDKWxKf927E+H1R2lgIfXzq7T
         OwR5hMW+g8PRwwwVriuU7tIIHn6tVHQE0nLcFN7+B8Hn7NF8QEa5FYN65IOxlZ8kJag3
         b8KYMmPG6kR0PdXkV92kd/5AQxUNF/yKzOxPJWXRptoQFlup/XAMY5lemBqQR5AuCakl
         CBGRv0LOLksn48IZuUWqm7EHPSVA9KljmkO4QrLZC4lr+U3TT/asyAI3++bqrBVzClze
         hq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ZW8ngLQwncVL4JlsWyY79eXQGckyqSHpOZGjTmoa8g4=;
        b=pHT+Eb9F0P2ft3QMIJButVLauYkIWNRteNAMi2mq1PRBO3clw8cOkTAW5S5+4gg0LG
         s3E6l9XAeBd6XfyMiiM9hNciorMhG3/Yf3lwhARdMGTKMe5O6oI2KZ1+qiEpmY0B9KDa
         2ooSmng5DOhxKL6PUsxIYDiA3O0pcuAdICiTKLWn4Qf7lY6ZM4jB1/A9/iwjknuGjc3I
         HzQd8n6gKKcpK8f0PIjoUbs0I+Ho00F2hrFEAV7rGwn+TU5OoUC9yjfO99h+82/eMESE
         vaNs5IrSCQ2nRct6FTWwleN1PNfdpktKIQO5mg66TyxDCMaOTvddq1NOoF1ixw7xgb6X
         37JA==
X-Gm-Message-State: ACrzQf1R69WhVROGyRWI1m/OkDhNuA2Sma+dkriONZBr7B2Pxxq0rsbp
        GOTJMLEK3+NHcohFXciLKjjEHqZ78xh5Y9mZ77VdVA==
X-Google-Smtp-Source: AMsMyM7KjbdlHKbrWZTvUu1Sa+2dpPQJKOdOEHzrPnGma1BEtY9u/IoHwJ3ChC9TiWIxMHlHfJkyDwf6fxP2LecJDjU=
X-Received: by 2002:a05:6602:2c01:b0:68b:559f:bbef with SMTP id
 w1-20020a0566022c0100b0068b559fbbefmr2551160iov.204.1663884057461; Thu, 22
 Sep 2022 15:00:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220922215715.13345-1-will@kernel.org>
In-Reply-To: <20220922215715.13345-1-will@kernel.org>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Thu, 22 Sep 2022 15:00:21 -0700
Message-ID: <CABCJKucxpd8_yL5dyUttKNah3kT8znUNJqT=29rdjQ+8jNtusQ@mail.gmail.com>
Subject: Re: [PATCH] vmlinux.lds.h: CFI: Reduce alignment of jump-table to
 function alignment
To:     Will Deacon <will@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Mohan Rao .vanimina" <mailtoc.mohanrao@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>
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

On Thu, Sep 22, 2022 at 2:57 PM Will Deacon <will@kernel.org> wrote:
>
> Due to undocumented, hysterical raisins on x86, the CFI jump-table
> sections in .text are needlessly aligned to PMD_SIZE in the vmlinux
> linker script. When compiling a CFI-enabled arm64 kernel with a 64KiB
> page-size, a PMD maps 512MiB of virtual memory and so the .text section
> increases to a whopping 940MiB and blows the final Image up to 960MiB.
> Others report a link failure.
>
> Since the CFI jump-table requires only instruction alignment, reduce the
> alignment directives to function alignment for parity with other parts
> of the .text section. This reduces the size of the .text section for the
> aforementioned 64KiB page size arm64 kernel to 19MiB for a much more
> reasonable total Image size of 39MiB.
>
> Cc: Sami Tolvanen <samitolvanen@google.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: "Mohan Rao .vanimina" <mailtoc.mohanrao@gmail.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Link: https://lore.kernel.org/all/CAL_GTzigiNOMYkOPX1KDnagPhJtFNqSK=1USNbS0wUL4PW6-Uw@mail.gmail.com/
> Fixes: cf68fffb66d60 ("add support for Clang CFI")
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  include/asm-generic/vmlinux.lds.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 7515a465ec03..7c90b1ab3e00 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -543,10 +543,9 @@
>   */
>  #ifdef CONFIG_CFI_CLANG
>  #define TEXT_CFI_JT                                                    \
> -               . = ALIGN(PMD_SIZE);                                    \
> +               ALIGN_FUNCTION();                                       \
>                 __cfi_jt_start = .;                                     \
>                 *(.text..L.cfi.jumptable .text..L.cfi.jumptable.*)      \
> -               . = ALIGN(PMD_SIZE);                                    \
>                 __cfi_jt_end = .;
>  #else
>  #define TEXT_CFI_JT

Thanks for sending the patch!

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1051658EFA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 17:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233733AbiL2QW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 11:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233657AbiL2QW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 11:22:27 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FAA13DD4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 08:22:25 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id s67so3349696pgs.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 08:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lGyrD0+PhkAL5dbAeObFs9RwoqBo5ONG0NwovuaDsrM=;
        b=dahVygbdXamhJiKEgN7Jyg1lXYgvfTSo1DMUkYl6yXrdIMvfnyRS0HpjAJGhYD3IFg
         E+JY0GnUUwwkM2h9ox2Zgy/UxJJ4gx7kMRbUi8BoQs1MkH7ANMKs27AnO7PEO784TqXp
         ruuAqGepnkn93qVt3OFjdbG1AsqdvffnpusA3lSTC6zFKd8HiqB0qYg9fELjUJN4UbO/
         3lnm7IU3UfXKaT3AUgnmQMHaYpOZ2VZND7TcbraC5FIjkTHVAEIVzHPRo5TQwNIMJbMP
         q3kZJpTtujX11O+tGSd8oHpehkbK7CbScXp9TvIT0cj2FcWn3tOzaHwI3gNMSd/9wBDx
         rNGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lGyrD0+PhkAL5dbAeObFs9RwoqBo5ONG0NwovuaDsrM=;
        b=5I+JMHTGBp/kr9QA0SZgySyHn5bnfQvqyOlrfgATBx+OqtFPkDQr+BPN45cKxuOklg
         DPPXhGCbzs0AlRvde/NQhwEXKqtFOPABYONHr08/nImWmsJWEOeZvm92OtqKswtLrMM2
         me8RF5ZxKbHsYV8WZLSEL5chnW5qFKUaqk9HVIXkGHxibuR3RobBRgGl5AgFLGzGiYFk
         pGjuDUXr9kjmaImTIMeMSIDkGKmlsck0U4j/wmRrWDXFo/3kLBTCtPLpHEF+O/GQQ37y
         EaUU9xYoYaXIqwd8dQyBFZYolv6FruQLEnVCxuWpDGx2LwhRNG9fVQ7Zf3ap/CUwUNuu
         hPYA==
X-Gm-Message-State: AFqh2kogJq5IrR02oE/eNZuUi2Wa1HD1Vw1oVwoyFZ0yVA9CXmh6bm2g
        xP3nkeaix5v1Q6XDxkndAGHRoBw6a5o0aOf8
X-Google-Smtp-Source: AMrXdXvpdMbR8CMYmi4dUk/9PgGNumQG+p4T2pa56FD3JYpViB2+8Ov5fWBEh9VYECa0d3vj+bwoEw==
X-Received: by 2002:aa7:99cb:0:b0:580:d188:f516 with SMTP id v11-20020aa799cb000000b00580d188f516mr22924872pfi.19.1672330945228;
        Thu, 29 Dec 2022 08:22:25 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id x185-20020a6286c2000000b0056bfebfa6e4sm12277463pfd.190.2022.12.29.08.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 08:22:24 -0800 (PST)
Date:   Thu, 29 Dec 2022 08:22:24 -0800 (PST)
X-Google-Original-Date: Thu, 29 Dec 2022 07:53:04 PST (-0800)
Subject:     Re: [PATCH v2] vdso: Improve cmd_vdso_check to check all dynamic relocations
In-Reply-To: <20221221235147.45lkqmosndritfpe@google.com>
CC:     christophe.leroy@csgroup.eu, luto@kernel.org, tglx@linutronix.de,
        vincenzo.frascino@arm.com, Arnd Bergmann <arnd@arndb.de>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-mips@vger.kernel.org,
        loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     maskray@google.com
Message-ID: <mhng-17d41c33-7f33-4a1c-8af2-ae7d07134e8c@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Dec 2022 15:51:47 PST (-0800), maskray@google.com wrote:
> The actual intention is that no dynamic relocation exists. However, some
> GNU ld ports produce unneeded R_*_NONE. (If a port fails to determine
> the exact .rel[a].dyn size, the trailing zeros become R_*_NONE
> relocations. E.g. ld's powerpc port recently fixed
> https://sourceware.org/bugzilla/show_bug.cgi?id=29540) R_*_NONE are
> generally no-op in the dynamic loaders. So just ignore them.
>
> With the change, we can remove ARCH_REL_TYPE_ABS. ARCH_REL_TYPE_ABS is a
> bit misnomer as ports may check RELAVETIVE/GLOB_DAT/JUMP_SLOT which are
> not called "absolute relocations". (The patch is motivated by the arm64
> port missing R_AARCH64_RELATIVE.)
>
> Signed-off-by: Fangrui Song <maskray@google.com>
> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
> Change from v1:
> * rebase after 8ac3b5cd3e0521d92f9755e90d140382fc292510 (lib/vdso: use "grep -E" instead of "egrep")
> * change the commit message to mention an example GNU ld bug; no longer say the patch fixes a deprecated egrep use
> ---
>   arch/arm/vdso/Makefile            |  3 ---
>   arch/arm64/kernel/vdso/Makefile   |  3 ---
>   arch/arm64/kernel/vdso32/Makefile |  3 ---
>   arch/csky/kernel/vdso/Makefile    |  3 ---
>   arch/loongarch/vdso/Makefile      |  3 ---
>   arch/mips/vdso/Makefile           |  3 ---
>   arch/powerpc/kernel/vdso/Makefile |  1 -
>   arch/riscv/kernel/vdso/Makefile   |  3 ---
>   arch/s390/kernel/vdso32/Makefile  |  2 --
>   arch/s390/kernel/vdso64/Makefile  |  2 --
>   arch/x86/entry/vdso/Makefile      |  4 ----
>   lib/vdso/Makefile                 | 13 ++++---------
>   12 files changed, 4 insertions(+), 39 deletions(-)

[snip]

> diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
> index 06e6b27f3bcc..d85c37e11b21 100644
> --- a/arch/riscv/kernel/vdso/Makefile
> +++ b/arch/riscv/kernel/vdso/Makefile
> @@ -1,9 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   # Copied from arch/tile/kernel/vdso/Makefile
>
> -# Absolute relocation type $(ARCH_REL_TYPE_ABS) needs to be defined before
> -# the inclusion of generic Makefile.
> -ARCH_REL_TYPE_ABS := R_RISCV_32|R_RISCV_64|R_RISCV_JUMP_SLOT
>   include $(srctree)/lib/vdso/Makefile
>   # Symbols present in the vdso
>   vdso-syms  = rt_sigreturn

Acked-by: Palmer Dabbelt <palmer@rivosinc.com> # RISC-V

Thanks!

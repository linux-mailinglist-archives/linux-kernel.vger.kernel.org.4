Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C396E510E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 21:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjDQTfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 15:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjDQTfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 15:35:12 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF6213E
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 12:35:09 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id lh8so13974148plb.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 12:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1681760109; x=1684352109;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UXrDQCneSb8jgaB5WOV1RqaoODncwrujP+Iw89BILhs=;
        b=O5dg6sOfwLf72QhLfcA5JPZKGpC9v3EPOX2y0AYcP7Il8gcym2sV8o5lhXHrPSGiGW
         DPGhkhxCJAOGPQHDgIJQWDZgMpZ18zws9m2PU3filA4f04zZ/ATq8zPp2oc0CvIEZOx4
         aS6Dmvqfg1ZBUBAHKCZGkO1qU4Za622yPoSyVVfHHKSW/NNIp8JEewzQlEvRUxd26zgx
         c3D57alEVgMwcn82DCHEwvxiO+Gj6jb3vWycOEc2eSWxLW3VrVDVPARr/jOUFRnCXL2R
         HCsjeToQ1OnDlO+wynHZo/8xZeVoZoCrR1W37oblagNvZ1Qy78o/cJdejEHoycqWtbfQ
         venQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681760109; x=1684352109;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXrDQCneSb8jgaB5WOV1RqaoODncwrujP+Iw89BILhs=;
        b=kqR7GtGLlWLtBdwc14R1WxgxLY6d/Mcub7Ydjbe3X2rWLiNLfJ1Yv/zAKysuwjEIwv
         5aq0IBxcQsFyuOtbOwUr33wo1xtIeVxVR/5t+6SQz8PoMmr4UVsnkwYl8gUkAkqCAGBN
         n/MWBJMgEcYF1lfcG7Ya4MDu8rHWdsVgJkKvMbvxE/Tqfolg+eBfFByBOuYn4ljig5Xe
         UGQ6wbz1Mpv3EjLyZQ1vKvZ1Ab8T1GWtot0uzHDEmod0eeRRn+DJ0RUz9Li2fATkjOsC
         SD50gxEcSf8ZPD4AIkbhBwDylZbTi/pkfTUBuxZV3mtxlK9+OpP0yONVf95N4J2iyN35
         h18g==
X-Gm-Message-State: AAQBX9dkze/WXiMNYSZq3LGp3nh2PZdZhazBAweLOIOlbpmT6nMOXaLC
        1KYESWsnQXnCI6y9+t8e2TN7fA==
X-Google-Smtp-Source: AKy350ZgkvMBwxuvsB2Nzf72S0ZpG/7AYjuh89fy8y1Y+VJOMWc5KS3m/VSnzQO/xLsTnbpfVXYkiA==
X-Received: by 2002:a17:90a:2a41:b0:247:c0bd:b99a with SMTP id d1-20020a17090a2a4100b00247c0bdb99amr597549pjg.31.1681760109163;
        Mon, 17 Apr 2023 12:35:09 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id b10-20020a17090a800a00b002479c36b10esm1828978pjn.23.2023.04.17.12.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 12:35:08 -0700 (PDT)
Date:   Mon, 17 Apr 2023 12:35:08 -0700 (PDT)
X-Google-Original-Date: Mon, 17 Apr 2023 12:34:57 PDT (-0700)
Subject:     Re: [PATCH 2/6] tools/nolibc: riscv: add stackprotector support
In-Reply-To: <20230408-nolibc-stackprotector-archs-v1-2-271f5c859c71@weissschuh.net>
CC:     w@1wt.eu, shuah@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux@weissschuh.net
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     linux@weissschuh.net
Message-ID: <mhng-1ec176a9-ec5d-470b-a278-a4e9cec728a8@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Apr 2023 09:01:32 PDT (-0700), linux@weissschuh.net wrote:
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>  tools/include/nolibc/arch-riscv.h       | 7 ++++++-
>  tools/testing/selftests/nolibc/Makefile | 1 +
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/tools/include/nolibc/arch-riscv.h b/tools/include/nolibc/arch-riscv.h
> index 0d5f15fdedc4..b2ccffcc079f 100644
> --- a/tools/include/nolibc/arch-riscv.h
> +++ b/tools/include/nolibc/arch-riscv.h
> @@ -173,14 +173,19 @@ struct sys_stat_struct {
>  char **environ __attribute__((weak));
>  const unsigned long *_auxv __attribute__((weak));
>
> +#define __ARCH_SUPPORTS_STACK_PROTECTOR
> +
>  /* startup code */
> -void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) _start(void)
> +void __attribute__((weak,noreturn,optimize("omit-frame-pointer"),no_stack_protector)) _start(void)
>  {
>  	__asm__ volatile (
>  		".option push\n"
>  		".option norelax\n"
>  		"lla   gp, __global_pointer$\n"
>  		".option pop\n"
> +#ifdef NOLIBC_STACKPROTECTOR
> +		"call __stack_chk_init\n"    /* initialize stack protector                          */
> +#endif
>  		"lw    a0, 0(sp)\n"          /* argc (a0) was in the stack                          */
>  		"add   a1, sp, "SZREG"\n"    /* argv (a1) = sp                                      */
>  		"slli  a2, a0, "PTRLOG"\n"   /* envp (a2) = SZREG*argc ...                          */
> diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> index 3c8e3a6f8985..0a83ad388a16 100644
> --- a/tools/testing/selftests/nolibc/Makefile
> +++ b/tools/testing/selftests/nolibc/Makefile
> @@ -82,6 +82,7 @@ CFLAGS_STACKPROTECTOR = -DNOLIBC_STACKPROTECTOR \
>  CFLAGS_STKP_i386 = $(CFLAGS_STACKPROTECTOR)
>  CFLAGS_STKP_x86_64 = $(CFLAGS_STACKPROTECTOR)
>  CFLAGS_STKP_x86 = $(CFLAGS_STACKPROTECTOR)
> +CFLAGS_STKP_riscv = $(CFLAGS_STACKPROTECTOR)
>  CFLAGS_s390 = -m64
>  CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 \
>  		$(call cc-option,-fno-stack-protector) \

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

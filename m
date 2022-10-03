Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1515F389C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 00:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiJCWH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 18:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJCWHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 18:07:21 -0400
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367631A80F;
        Mon,  3 Oct 2022 15:07:20 -0700 (PDT)
Received: by mail-vk1-f178.google.com with SMTP id s76so2115624vke.11;
        Mon, 03 Oct 2022 15:07:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=x50O7SJxBCNTdJorKXEesA1j96ookvS+mgoY1FSQSM0=;
        b=ZzPI+ga+x3OLwy7pncb3MAv1hkqaSCXa3rfoYppdqhtdiBghRxJEZIcC0X4ZogHZnC
         78+FTVRkoK+4j+hmsCFH2+Uyhw0ZHMVrWf5FK2yspYpjA0WOpvIZvs5AHszeKll2D3te
         2LF0/mExghOY1gIYe5ANDbljXKAaPRU7Yq1iafIQTLF1lC9TJtgqRu8y7+PfLxuZv3om
         ESBq+cwc+RY5L+CIo7fDDvNyLBm8gbQr2fMLf6UgcMd4BkxJuLlYLZ/vc2ddYAMnenEG
         U6X8Erk61vZpfz5mccxQxnez8shAarw9fQ0FdrB6q6iQNZnjTXnTzg9UCmb9M4udcy0o
         y42A==
X-Gm-Message-State: ACrzQf07mj0j4rzy0xM79SmivdokvRZzMx6HmRk7w+F9UX+T/ZD+jD8o
        WIRO4I7TDl2p6mlMe8jcMEhp9Bsno3oHX4TYfNHOHwd1gmP1jA==
X-Google-Smtp-Source: AMsMyM5+v7SF9UDdJqpVM4ht4G/qzZzigISeVe82/KC7/0l+p4RvP2JsPZ/ZZJ4qu+2ueXDHJ1+LNbha1VbFNmu2sX8=
X-Received: by 2002:a05:6122:10dc:b0:3a3:4904:2941 with SMTP id
 l28-20020a05612210dc00b003a349042941mr9921233vko.24.1664834839308; Mon, 03
 Oct 2022 15:07:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220930140138.575751-1-Jason@zx2c4.com>
In-Reply-To: <20220930140138.575751-1-Jason@zx2c4.com>
From:   =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date:   Tue, 4 Oct 2022 00:07:08 +0200
Message-ID: <CAAdtpL5BQA-y-N0Bc--KbfT9WXok0kNQ17YuF1Yyjg13DHLtgQ@mail.gmail.com>
Subject: Re: [PATCH] mips: allow firmware to pass RNG seed to kernel
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Fri, Sep 30, 2022 at 4:05 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Nearly all other firmware environments have some way of passing a RNG
> seed to initialize the RNG: DTB's rng-seed, EFI's RNG protocol, m68k's
> bootinfo block, x86's setup_data, and so forth. This adds something
> similar for MIPS, which will allow various firmware environments,
> bootloaders, and hypervisors to pass an RNG seed to initialize the
> kernel's RNG.
>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  arch/mips/kernel/setup.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index 2ca156a5b231..39c79f67c7a3 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -42,6 +42,7 @@
>  #include <asm/setup.h>
>  #include <asm/smp-ops.h>
>  #include <asm/prom.h>
> +#include <asm/fw/fw.h>
>
>  #ifdef CONFIG_MIPS_ELF_APPENDED_DTB
>  char __section(".appended_dtb") __appended_dtb[0x100000];
> @@ -756,6 +757,24 @@ static void __init prefill_possible_map(void)
>  static inline void prefill_possible_map(void) {}
>  #endif
>
> +static void __init setup_rng_seed(void)
> +{
> +       char *rng_seed_hex = fw_getenv("rngseed");
> +       u8 rng_seed[512];
> +       size_t len;
> +
> +       if (!rng_seed_hex)
> +               return;
> +

Assuming rngseed="x", ...

> +       len = min(sizeof(rng_seed), strlen(rng_seed_hex) / 2);

... len = 0 ...

> +       if (hex2bin(rng_seed, rng_seed_hex, len))
> +               return;

hex2bin(..., len=0) = 0

> +
> +       add_bootloader_randomness(rng_seed, len);

So we call char/random code with len=0. Is it safe?
Maybe simply safer to check len before calling hex2bin?

> +       memzero_explicit(rng_seed, len);
> +       memzero_explicit(rng_seed_hex, len * 2);
> +}
> +
>  void __init setup_arch(char **cmdline_p)
>  {
>         cpu_probe();
> @@ -786,6 +805,8 @@ void __init setup_arch(char **cmdline_p)
>         paging_init();
>
>         memblock_dump_all();
> +
> +       setup_rng_seed();
>  }
>
>  unsigned long kernelsp[NR_CPUS];
> --
> 2.37.3
>

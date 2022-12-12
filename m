Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F233649FC0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 14:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbiLLNOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 08:14:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbiLLNOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 08:14:14 -0500
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6EA101C7;
        Mon, 12 Dec 2022 05:14:13 -0800 (PST)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 2BCDDvE2032515;
        Mon, 12 Dec 2022 22:13:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 2BCDDvE2032515
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1670850838;
        bh=Qyvr5aZkM+wmdhHKW6aw9JveC938iEMrNt3NYpNMYho=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=b5+lBzaQFXLoYKeSphoB86Oodwyjy3b9I8NHzJQNVZFS+/itGfmkNfo+6WSyINJXf
         qOxsZm/dxLZS7ebxowc1YLekgFybdLtdHsbpR9HBMVw7xln5QsZBqYR0ioRthhzo9Q
         8m6TILZSxsQORWoE0wtaelTgDrHHT2W9hiwu8PunxSWhtHf5vngzVFDh6bWl7eZ8H0
         XUL7sSsoyJh2Vp39ZpHt9uxGQMhZfFe3rVvavOwpizOYgPlSeV8nimuzM+S5UTiYqz
         yJU8M9BQxsrE6XBFgwxDPpbksm8eWxibVXpUM6XHZip6VmNSkNGQTQv9cFWGBh16+e
         U7Qbgz3noIu8w==
X-Nifty-SrcIP: [209.85.167.180]
Received: by mail-oi1-f180.google.com with SMTP id r11so11121028oie.13;
        Mon, 12 Dec 2022 05:13:57 -0800 (PST)
X-Gm-Message-State: ANoB5pkhNFi8K/zWXvLZeyVDJVZBLrG3zJpDv8B7ZjaD8WJqptaWkQlK
        2hqMkONd++DkhCvn6mQG/1Q2hemG4tPkZBqffJA=
X-Google-Smtp-Source: AA0mqf4I3SXFUfc/eWCj/dtwZNLGGSsqlfdozaJ6EZO9Qm+gTzG9smhalmAJvZK7tGN7or7+K+lH+s4AbNqf02TFKSc=
X-Received: by 2002:a05:6808:3009:b0:354:94a6:a721 with SMTP id
 ay9-20020a056808300900b0035494a6a721mr37705245oib.194.1670850836790; Mon, 12
 Dec 2022 05:13:56 -0800 (PST)
MIME-Version: 1.0
References: <20221207191657.2852229-1-nathan@kernel.org> <20221207191657.2852229-3-nathan@kernel.org>
In-Reply-To: <20221207191657.2852229-3-nathan@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 12 Dec 2022 22:13:20 +0900
X-Gmail-Original-Message-ID: <CAK7LNASoHieMNQTwPw6JVYnn6nBm-aPpOTrXeBPGeQKR-TxaUg@mail.gmail.com>
Message-ID: <CAK7LNASoHieMNQTwPw6JVYnn6nBm-aPpOTrXeBPGeQKR-TxaUg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] modpost: Include '.text.*' in TEXT_SECTIONS
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Nicolas Schier <nicolas@fjasle.eu>,
        Sami Tolvanen <samitolvanen@google.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev,
        Alexander Lobakin <alexandr.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 8, 2022 at 4:17 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> Commit 6c730bfc894f ("modpost: handle -ffunction-sections") added
> ".text.*" to the OTHER_TEXT_SECTIONS macro to fix certain section
> mismatch warnings. Unfortunately, this makes it impossible for modpost
> to warn about section mismatchs with LTO, which implies

"mismatches"
Other than the typo, this patch looks good to me.

It was just 1/2 was difficult for me to understand.




> '-ffunction-sections', as all functions are put in their own
> '.text.<func_name>' sections, which may still reference functions in
> sections they are not supposed to, such as __init.
>
> Fix this by moving ".text.*" into TEXT_SECTIONS, so that configurations
> with '-ffunction-sections' will see warnings about mismatched sections.
>
> Link: https://lore.kernel.org/Y39kI3MOtVI5BAnV@google.com/
> Reported-by: Vincent Donnefort <vdonnefort@google.com>
> Reviewed-and-tested-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
> Tested-by: Vincent Donnefort <vdonnefort@google.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  scripts/mod/modpost.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 2c80da0220c3..c861beabc128 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -823,10 +823,10 @@ static void check_section(const char *modname, struct elf_info *elf,
>  #define ALL_EXIT_SECTIONS EXIT_SECTIONS, ALL_XXXEXIT_SECTIONS
>
>  #define DATA_SECTIONS ".data", ".data.rel"
> -#define TEXT_SECTIONS ".text", ".text.unlikely", ".sched.text", \
> +#define TEXT_SECTIONS ".text", ".text.*", ".sched.text", \
>                 ".kprobes.text", ".cpuidle.text", ".noinstr.text"
>  #define OTHER_TEXT_SECTIONS ".ref.text", ".head.text", ".spinlock.text", \
> -               ".fixup", ".entry.text", ".exception.text", ".text.*", \
> +               ".fixup", ".entry.text", ".exception.text", \
>                 ".coldtext", ".softirqentry.text"
>
>  #define INIT_SECTIONS      ".init.*"
> --
> 2.38.1
>


-- 
Best Regards
Masahiro Yamada

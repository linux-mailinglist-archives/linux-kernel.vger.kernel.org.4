Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960F85F626B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 10:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbiJFISH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 04:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbiJFISE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 04:18:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E6A77543
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 01:18:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3A1F3B82037
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 08:17:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B29C43140
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 08:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665044277;
        bh=sPYhHQSN08fPJZJXmiJjpYtAxcNKjsgm0ubxG7uLtzk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tI0J0WnfQHk3JuV8Eq24CSgeSDYJv+GEEjqpHDqS4KWNOPgl6e37MMRL1dHqRmAmv
         IF8oLcgN4nQITykoZuxmIqUEsSouqVUbgoqYcOUQSVeY5K2swQPOlmVZ4la4BYmyA1
         DhmuSda7I+L4XV72hbwXnD6I5na8Jba6TLAFtgYnNnth0f8bHtc/LNu1aRB6FVqmKo
         C0HRW/As50FLmKhowOAzu4lF7+AWM1JBL4UKgSXucMKN8tLa3Ivosfw7k08ORsxIQE
         tJv2PedMdp5K/Tb2KECjkh6gDp2FO/Smaw3O35V9BHAKhSYYh1hfgZeIRHjXI9urIa
         it1EW5pIBIUEg==
Received: by mail-lj1-f181.google.com with SMTP id s10so1352323ljp.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 01:17:57 -0700 (PDT)
X-Gm-Message-State: ACrzQf3Woo+d+fkrVa7SXYBjVbrtVQe7n497WET+bHldjYPPqcOZTYtW
        9BHIwlCVQE/N40q1jh9aLMw0LJ8qzPnf7W0CCl0=
X-Google-Smtp-Source: AMsMyM62fsqxdMGVPNXQrsbsP3/xEv3hgBZrQ63BQpH7bLk3B3O1gEJGiImPdYuXk2ns+3ueyE95/quvsAAb50VuxKw=
X-Received: by 2002:a2e:b7d5:0:b0:26d:e725:bd35 with SMTP id
 p21-20020a2eb7d5000000b0026de725bd35mr1193586ljo.69.1665044275730; Thu, 06
 Oct 2022 01:17:55 -0700 (PDT)
MIME-Version: 1.0
References: <20221006075542.2658-1-jszhang@kernel.org> <20221006075542.2658-2-jszhang@kernel.org>
In-Reply-To: <20221006075542.2658-2-jszhang@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 6 Oct 2022 10:17:44 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEWm9WuvxYN8ks09m3Rv+pt1Hd7=DcXuTwm+Etw2Y-KOQ@mail.gmail.com>
Message-ID: <CAMj1kXEWm9WuvxYN8ks09m3Rv+pt1Hd7=DcXuTwm+Etw2Y-KOQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: jump_label: mark arguments as const to satisfy
 asm constraints
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Oct 2022 at 10:05, Jisheng Zhang <jszhang@kernel.org> wrote:
>
> Inspired by x86 commit 864b435514b2("x86/jump_label: Mark arguments as
> const to satisfy asm constraints"), mark arch_static_branch()'s and
> arch_static_branch_jump()'s arguments as const to satisfy asm
> constraints. And Steven in [1] also pointed out that "The "i"
> constraint needs to be a constant."
>
> Tested with building a simple external kernel module with "O0".
>
> [1]https://lore.kernel.org/all/20210212094059.5f8d05e8@gandalf.local.home/
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/arm64/include/asm/jump_label.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/include/asm/jump_label.h b/arch/arm64/include/asm/jump_label.h
> index cea441b6aa5d..48ddc0f45d22 100644
> --- a/arch/arm64/include/asm/jump_label.h
> +++ b/arch/arm64/include/asm/jump_label.h
> @@ -15,8 +15,8 @@
>
>  #define JUMP_LABEL_NOP_SIZE            AARCH64_INSN_SIZE
>
> -static __always_inline bool arch_static_branch(struct static_key *key,
> -                                              bool branch)
> +static __always_inline bool arch_static_branch(struct static_key * const key,
> +                                              const bool branch)
>  {
>         asm_volatile_goto(
>                 "1:     nop                                     \n\t"

Is this still necessary if we specify the constraints in a more
reasonable manner:

 "      .quad           %c0 - . + %1            \n\t"
 :  :  "i"(key), "i"(branch) :  : l_yes);

instead of the horrid hack with the char* cast and using a bool as an
array index?




> @@ -32,8 +32,8 @@ static __always_inline bool arch_static_branch(struct static_key *key,
>         return true;
>  }
>
> -static __always_inline bool arch_static_branch_jump(struct static_key *key,
> -                                                   bool branch)
> +static __always_inline bool arch_static_branch_jump(struct static_key * const key,
> +                                                   const bool branch)
>  {
>         asm_volatile_goto(
>                 "1:     b               %l[l_yes]               \n\t"
> --
> 2.37.2
>

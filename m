Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B255ED60B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 09:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbiI1H2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 03:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbiI1H1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 03:27:53 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4511A18E25
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 00:24:48 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id s10so13376266ljp.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 00:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=n0yYYWWOm3FM1VkJi0JdAR/s0E5nigR1hAoYI8h0YF0=;
        b=FK7YeUM2hM+3XPSYwmg/icglrYf9VcytTb705GT7JOTIsY/vfzZ0B163zJRG5LmnAY
         yKzg0VzUT8eyLc3tHgXOjQrn6e7882ApK2BuUG3C0muhqwi3F5Rw21f7dOQP8gGrcgTN
         Zs/Lx5u/g7wEbjiRktiE/AzZT3Fzo3pb9BbKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=n0yYYWWOm3FM1VkJi0JdAR/s0E5nigR1hAoYI8h0YF0=;
        b=h3qxu8qBqbzUSWgJk4uRNwTNobMd5EWRGO/kESpU5mnILlX6jfp7ZTl9kYXZFN3TfD
         bI1mz8Px1hWJgJYhIaD34CV+FRepuf5SunnlnaCFWuapFrnOuFlVMCcELpaEoFP43v7K
         XA5/Jiz7jn2bnx1mzjPveJt/FVqRnijqeUlpmX5kLVEcI13qykJ0K0AuR8pIbh7UTgwN
         VqXhQHSbe3QGP+nEvkOj9IE/kcSmcaMgp809dz6e3gpiTradOgOAq2HLfUSD2laYwoXg
         JhB7L0QsN1CIbmBQKWi9AQyl/lLfJ0Xqx/gRa3SObYG0FBCbE0XHmiYaytQH1bqfBPr0
         aNQw==
X-Gm-Message-State: ACrzQf3jSiA8TPbBQLsmx/c2iQk2MpXZuyAxKMeZpKuYxCUSiUcfZVaR
        TMWR6Tkheb8Fj82mjhZN+9RCvg==
X-Google-Smtp-Source: AMsMyM63GFfUWLx+WswRe/My7Oxb+Hk6CQOOXW0M1Do/mXBE2dXH2Bo+83G+sKA0q9y5j21iM8jZyA==
X-Received: by 2002:a05:651c:94:b0:26c:6678:7d2e with SMTP id 20-20020a05651c009400b0026c66787d2emr11389575ljq.135.1664349854960;
        Wed, 28 Sep 2022 00:24:14 -0700 (PDT)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id o22-20020ac25e36000000b004946c99e78asm390685lfg.277.2022.09.28.00.24.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 00:24:14 -0700 (PDT)
Message-ID: <a753c608-813a-f880-67ca-f16fe503b152@rasmusvillemoes.dk>
Date:   Wed, 28 Sep 2022 09:24:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3] x86, mem: move memmove to out of line assembler
Content-Language: en-US
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        llvm@lists.linux.dev, Andy Lutomirski <luto@kernel.org>
References: <202209271333.10AE3E1D@keescook>
 <20220927210248.3950201-1-ndesaulniers@google.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20220927210248.3950201-1-ndesaulniers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/09/2022 23.02, Nick Desaulniers wrote:

> +	/* Decide forward/backward copy mode */
> +	cmpl	dest, src
> +	jb	.Lbackwards_header

I know you're mostly just moving existing code, but for my own education
I'd like to understand this.

> +	/*
> +	 * movs instruction have many startup latency
> +	 * so we handle small size by general register.
> +	 */
> +	cmpl	$680, n
> +	jb	.Ltoo_small_forwards

OK, this I get, there's some overhead, and hence we need _some_ cutoff
value; 680 is probably chosen by some trial-and-error, but the exact
value likely doesn't matter too much.

> +	/*
> +	 * movs instruction is only good for aligned case.
> +	 */
> +	movl	src, tmp0
> +	xorl	dest, tmp0
> +	andl	$0xff, tmp0
> +	jz	.Lforward_movs

But this part I don't understand at all. This checks that the src and
dest have the same %256 value, which is a rather odd thing, and very
unlikely to ever be hit in practice. I could understand if it checked
that they were both 4 or 8 or 16-byte aligned (i.e., (src|dest)&FOO)),
or if it checked that they had the same offset within a cacheline [say
(src^dest)&0x3f].

Any idea where that comes from? Or am I just incapable of reading x86 asm?

> +.Ltoo_small_forwards:
> +	subl	$0x10, n
> +
> +	/*
> +	 * We gobble 16 bytes forward in each loop.
> +	 */
> +.L16_byteswap_forwards_loop:
> +	subl	$0x10, n
> +	movl	0*4(src), tmp0
> +	movl	1*4(src), tmp1
> +	movl	tmp0, 0*4(dest)
> +	movl	tmp1, 1*4(dest)
> +	movl	2*4(src), tmp0
> +	movl	3*4(src), tmp1
> +	movl	tmp0, 2*4(dest)
> +	movl	tmp1, 3*4(dest)
> +	leal	0x10(src), src
> +	leal	0x10(dest), dest
> +	jae	.L16_byteswap_forwards_loop
> +	addl	$0x10, n
> +	jmp	.L16_byteswap
> +
> +	/*
> +	 * Handle data forward by movs.
> +	 */
> +.p2align 4
> +.Lforward_movs:
> +	movl	-4(src, n), tmp0
> +	leal	-4(dest, n), tmp1
> +	shrl	$2, n
> +	rep	movsl
> +	movl	tmp0, (tmp1)
> +	jmp	.Ldone

So in the original code, %1 was forced to be %esi and %2 was forced to
be %edi and they were initialized by src and dest. But here I fail to
see how those registers have been properly set up before the rep movs;
your names for those are tmp0 and tmp2. You have just loaded the last
word of the source to %edi, and AFAICT %esi aka tmp2 is entirely
uninitialized at this point (the only use is in L16_byteswap).

I must be missing something. Please enlighten me.

Rasmus

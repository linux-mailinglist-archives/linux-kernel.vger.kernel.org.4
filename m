Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14ADE65E976
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 12:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbjAELBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 06:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbjAELA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 06:00:26 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4DC54713
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 03:00:18 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id fc4so89116306ejc.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 03:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Wb7N5MVgUC7Ku9UnYSMvHE8kgyp+u0pV1KxACYa0HQ=;
        b=PCVg/1KcwZ+wWRHweUM9ON+5UT98mZ5ud/Dz5UC0UlK4tVKjk915Y73UKgifnYF3gD
         SOQMMHr7CyoGElFg1C91O6M46dMtVqtQ8T1AUhD15bf7zlXYcJtx1ENSaoSQrFgBrPMM
         hL1UPfQYOZN1rYZezqCCYMhNgJEuCsONIELzqVMB2xMKuUBjXi/Ra4R7e6IARTLmhTVP
         Ec2O4gcGhYYwYz/Wgihy2jxMz2EJyyyobgOvKj4jHLB4JuYY65UmOr6P1tN358jIMKU9
         vqwGDylwVRKY/htvLxx+GXXsMU3HuRHoiX+TP/0ntLfjq+UohDPt2MY3YkyxMQ3UJa9r
         1/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Wb7N5MVgUC7Ku9UnYSMvHE8kgyp+u0pV1KxACYa0HQ=;
        b=bsjrSzJqiEUz8b69iaRNYV9o4+ea7UuEu1v8mbBXrO2w4y98eBTpwkFeMUilZqlMq8
         3PQaZsZf0pqZnQcPp9FNCsxLktp02b4c0D2sc1LvLjLNmXmHs5zmvZTbjKNShw6T0LJK
         kAIHOSsGACa0ognUVDEEr1Lq0lRKWRTAh1ThhmAFiW7WrlhygqrTEIigxpDKm+Q/rEZP
         mYuy/ZirX0DnJ0wJt/V31e8dMAy6YRhmY6WkhM8gYjbcJ9epGt9ic6gaKeFDo6pquBD+
         tB71v9OgKubTk921yP57H8gGBGCS8lroiKgNMVK7iI/Hom9QrlsxWYsj4RuG2o5PvyE9
         gW9Q==
X-Gm-Message-State: AFqh2kqJf5/V4BW/3jA8EZdgNaolpmjyPaOUmLdxiaKiV87lvNA8Bk71
        Kw03QhPHSh+XRhqFKvz3LD8=
X-Google-Smtp-Source: AMrXdXs27KJ9X0UQWWrJqvnqbnRzVl6Qb8kgMbTgLXuQmxV/zimoq7sZWB7IjIfPHjK0x3m8ukdqRQ==
X-Received: by 2002:a17:907:d50e:b0:7b1:316c:38f5 with SMTP id wb14-20020a170907d50e00b007b1316c38f5mr44974808ejc.30.1672916416859;
        Thu, 05 Jan 2023 03:00:16 -0800 (PST)
Received: from gmail.com (1F2EF380.nat.pool.telekom.hu. [31.46.243.128])
        by smtp.gmail.com with ESMTPSA id ru17-20020a1709068e9100b0084ce3554f03sm2929850ejc.66.2023.01.05.03.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 03:00:16 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 5 Jan 2023 12:00:14 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH -v2] x86/alternatives: Add alt_instr.flags
Message-ID: <Y7atvpsIOk+p3TLv@gmail.com>
References: <20221219195312.7054-1-bp@alien8.de>
 <Y6RCoJEtxxZWwotd@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6RCoJEtxxZWwotd@zn.tnic>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Borislav Petkov <bp@alien8.de> wrote:

> Yeah,
> 
> PeterZ had a much better idea for doing the split and hacking it in, it
> turned out to be the cleanest and straightforwardestest eva.
> 
> So let's do it.
> 
> ---
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> Add a struct alt_instr.flags field which will contain different flags
> controlling alternatives patching behavior.
> 
> The initial idea was to be able to specify it as a separate macro
> parameter but that would mean touching all possible invocations of the
> alternatives macros and thus a lot of churn.
> 
> What is more, as PeterZ suggested, being able to say ALT_NOT(feature) is
> very readable and explains exactly what is meant.
> 
> So make the feature field a u32 where the patching flags are the upper
> u16 part of the dword quantity while the lower u16 word is the feature.
> 
> The highest feature number currently is 0x26a (i.e., word 19) so we have
> plenty of space. If that becomes insufficient, the field can be extended
> to u64 which will then make struct alt_instr of the nice size of 16
> bytes (14 bytes currently).
> 
> There should be no functional changes resulting from this.
> 
> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> ---
>  arch/x86/include/asm/alternative.h            | 132 ++++++++++--------
>  arch/x86/kernel/alternative.c                 |  14 +-
>  tools/objtool/arch/x86/include/arch/special.h |   6 +-
>  3 files changed, 85 insertions(+), 67 deletions(-)
> 
> diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
> index 7659217f4d49..ad17cda8e5d2 100644
> --- a/arch/x86/include/asm/alternative.h
> +++ b/arch/x86/include/asm/alternative.h
> @@ -6,8 +6,10 @@
>  #include <linux/stringify.h>
>  #include <asm/asm.h>
>  
> -#define ALTINSTR_FLAG_INV	(1 << 15)
> -#define ALT_NOT(feat)		((feat) | ALTINSTR_FLAG_INV)
> +#define ALT_FLAGS_SHIFT		16
> +
> +#define ALT_FLAG_NOT		BIT(0)
> +#define ALT_NOT(feature)	((ALT_FLAG_NOT << ALT_FLAGS_SHIFT) | (feature))
>  
>  #ifndef __ASSEMBLY__
>  
> @@ -59,10 +61,27 @@
>  	".long 999b - .\n\t"					\
>  	".popsection\n\t"
>  
> +/*
> + * The patching flags are part of the upper bits of the @ft_flgs parameter when
> + * specifying them. The split is currently like this:
> + *
> + * [31... flags ...16][15... CPUID feature bit ...0]
> + *
> + * but since this is all hidden in the macros argument being split, those fields can be
> + * extended in the future to fit in a u64 or however the need arises.
> + */
>  struct alt_instr {
>  	s32 instr_offset;	/* original instruction */
>  	s32 repl_offset;	/* offset to replacement instruction */
> -	u16 cpuid;		/* cpuid bit set for replacement */
> +
> +	union {
> +		struct {
> +			u32 cpuid: 16;	/* CPUID bit set for replacement */
> +			u32 flags: 16;	/* patching control flags */
> +		};
> +		u32 ft_flgs;
> +	};

Neat - my only nitpick would be s/ft_flgs/ft_flags - it's more readable and 
we haven't run out of a's yet I guess. ;-)

   Reviewed-by: Ingo Molnar <mingo@kernel.org>

I minimally boot-tested it as well.

Thanks,

	Ingo

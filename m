Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0FD611986
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 19:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiJ1RnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 13:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbiJ1Rmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 13:42:55 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035B722B3AF
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 10:42:54 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 78so5408585pgb.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 10:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JfsRvphlW3EvWZnDHcnWZXBsZELQ/D2t6CyyvyIHHIc=;
        b=NSCXnBqB2QKjiRvwIwtpTaSwwGbwEHBfQ34jvyr5vE5WQvjMeSKhsxOMVHNed94h+0
         Fng8xtp/H43cQCWVs4HBxynPD0RIv8zit3YvQ3Iqf51nJ8GqS6cy60Lsq6IfYugaO+CP
         setWOAYjMbhK2IzyELQmNRhE1E3zGWJEJpJ/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JfsRvphlW3EvWZnDHcnWZXBsZELQ/D2t6CyyvyIHHIc=;
        b=7WbPmIu08vjvcZ4D9e44k0ddResJwZquPGcyz61iq+VZT6ZMyh4YuvN33FzUe7RryL
         FuFoSq8n3PTZ9UmnUoxJXNobeqtHu6kRXgHXUuvyiGfTuGK0W318kHidVw2kBrgvsRve
         lTu5qLYHQhu3q7ZXQsE+0NCx5JMbipB34W0zGZNlxom1NgsJrDwb5MTBZfrrAjl44aHZ
         BZfemalsT7yNtdP+smU1soN6y/w5fDEqOJxBSbJ/syaxh6pjJhnHDaVXpLKi1AUGVIW/
         yeEDidwVDZD4aKzHYvIk+834hQ9s5MLt3NgmIbRLn+jKJJF13vlL42BXON2EK3DSnMrh
         pMUw==
X-Gm-Message-State: ACrzQf0SjObadhu2RWpp+1XxlP0ncrHrx/7CMtx6/bgPh9UKhFhwqZIb
        4Hgeo+Ct1FVllD0r6nFdh1LkMA==
X-Google-Smtp-Source: AMsMyM6PZWzQoDdt3xlTHuY1d2KYMxhJxq8IHiwGUP2ZLkmf1MQgTes+WAA0Jj8tHTJmMjHxUSYQSg==
X-Received: by 2002:aa7:8293:0:b0:563:5852:e750 with SMTP id s19-20020aa78293000000b005635852e750mr370351pfm.11.1666978973488;
        Fri, 28 Oct 2022 10:42:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z13-20020a170902cccd00b00176ea6ce0efsm3327732ple.109.2022.10.28.10.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 10:42:52 -0700 (PDT)
Date:   Fri, 28 Oct 2022 10:42:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 4/4] x86/cfi: Add boot time hash randomization
Message-ID: <202210281042.D12B3A1118@keescook>
References: <20221027092812.185993858@infradead.org>
 <20221027092842.765195516@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027092842.765195516@infradead.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 11:28:16AM +0200, Peter Zijlstra wrote:
> In order to avoid known hashes (from knowing the boot image),
> randomize the CFI hashes with a per-boot random seed.
> 
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/kernel/alternative.c |  120 +++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 108 insertions(+), 12 deletions(-)
> 
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -711,6 +711,24 @@ enum cfi_mode {
>  };
>  
>  static enum cfi_mode cfi_mode __ro_after_init = CFI_DEFAULT;
> +static bool cfi_rand __ro_after_init = true;
> +static u32  cfi_seed __ro_after_init;
> +
> +/*
> + * Re-hash the CFI hash with a boot-time seed while making sure the result is
> + * not a valid ENDBR instruction.
> + */
> +static u32 cfi_rehash(u32 hash)
> +{
> +	hash ^= cfi_seed;
> +	while (unlikely(is_endbr(hash) || is_endbr(-hash))) {
> +		bool lsb = hash & 1;
> +		hash >>= 1;
> +		if (lsb)
> +			hash ^= 0x80200003;
> +	}
> +	return hash;
> +}

I guess this risks hash collision with existing hashes, but meeeh. I'm
glad to have the randomization. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

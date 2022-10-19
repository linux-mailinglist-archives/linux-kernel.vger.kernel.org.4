Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0B5603910
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 07:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiJSFFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 01:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJSFFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 01:05:33 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCD64F1B7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 22:05:28 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id c24so15854779pls.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 22:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O5cc2gsWnnBjYv0FPf3dkEGeVwwaPHC9sLPqs6bLyHs=;
        b=JaIEhOnOHP5kCzoE6IvUupcoZDvRAO4IdizYTRiZuqfoggMzy76eX33VVTJqCQ3cXl
         wo6v+HKvxpOhGIwrPssH/bzXVeFYb7RSipDVAmP6zCizI52EpY4j/vAmsA5kro2qRSfm
         lZhkJVRdQ/MzXgfLv/GxqUKoPpuWJLCg2aVVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O5cc2gsWnnBjYv0FPf3dkEGeVwwaPHC9sLPqs6bLyHs=;
        b=oz5GlhF56eNDKxbVBghlduKKoXgPSnKU29FbNszkFglLRFWptbmjvYFbKUz6gjYLmD
         9ie+z9NJZX+JsZeiW504bVsMdcUDO4cih0mjAoKMuHI59rk9ZeYnQmaFdjqNFkTa6RUP
         B7WIZegP+f64KAad+vjRaFTHBeray9WekuOj70uxtDtsMMQxypPDE9Id9xjwSoi383c8
         mz7so+9V01u0fhdGenZCT/TSyQ/QZeNx8TpQqw5PgTQABIvVN280O0zeXeWthTUyroBy
         hpw5jtQRuC/er63tidPoei0jRCD7QfB8QnORTS2yTLHxcVqj5yEWYuoW+2Ap93bJL+Dd
         y5oA==
X-Gm-Message-State: ACrzQf3nQI7FJrtsWj2AbrKhymrIVgbGNv4IYE1RHH5/8DBPebcCWZAB
        Ow02bGIUyvFnCPCyJBtPldFmiw==
X-Google-Smtp-Source: AMsMyM5Wk92H/BBWRZJ9ScgKjp8F8YKMtHAs9hU2DcMv0HWGpmAX0bBRs88LMyiQ8vOXFGOuyRTmeA==
X-Received: by 2002:a17:90b:1d8a:b0:20c:a6db:5713 with SMTP id pf10-20020a17090b1d8a00b0020ca6db5713mr43661573pjb.135.1666155928454;
        Tue, 18 Oct 2022 22:05:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d18-20020a170902e15200b00177324a7862sm9544961pla.45.2022.10.18.22.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 22:05:27 -0700 (PDT)
Date:   Tue, 18 Oct 2022 22:05:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/ibt: Implement FineIBT
Message-ID: <202210182200.50680AE@keescook>
References: <Y06rtoE9BsERG9uv@hirez.programming.kicks-ass.net>
 <202210181020.79AF7F7@keescook>
 <Y08FhjK3fKsfRAaw@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y08FhjK3fKsfRAaw@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 09:59:02PM +0200, Peter Zijlstra wrote:
> On Tue, Oct 18, 2022 at 11:09:13AM -0700, Kees Cook wrote:
> 
> > An improvement for kCFI would be to mutate all the hashes both at build
> > time (perhaps using the same seed infrastructure that randstruct depends
> > on for sharing a seed across compilation units), and at boot time, so
> > an actual .text content exposure is needed to find the target hash value.
> 
> What's the purpose of the build time randomization?

I was just considering options if run-time was too onerous.

> Find here the boot
> time randomization (on top of my other patch).

Which it's clearly not. :P Nice!

> [...]
>  static enum cfi_mode cfi_mode __ro_after_init = CFI_DEFAULT;
> +static bool cfi_rand __ro_after_init = true;
> +static u32  cfi_seed __ro_after_init;

This is saved because we need to fix up modules, yes? I look forward
to fine-grain randomization of the .data section. ;)

> [...]
> +static int cfi_rand_preamble(s32 *start, s32 *end)
> +{
> +	s32 *s;
> +
> +	for (s = start; s < end; s++) {
> +		void *addr = (void *)s + *s;
> +		u32 hash;
> +
> +		hash = decode_preamble_hash(addr);
> +		if (WARN(!hash, "no CFI hash found at: %pS %px %*ph\n",
> +			 addr, addr, 5, addr))
> +			return -EINVAL;
> +
> +		hash ^= cfi_seed;
> +		text_poke_early(addr + 1, &hash, 4);
> +	}
> +
> +	return 0;
> +}

The one glitch here is that the resulting hash needs to not contain
an endbr...

Otherwise, yes, this looks lovely. Thank you!

-- 
Kees Cook

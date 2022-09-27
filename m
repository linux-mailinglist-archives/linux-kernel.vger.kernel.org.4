Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B003D5ECCCB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 21:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbiI0TYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 15:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbiI0TYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 15:24:00 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF5BD8E23
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 12:23:59 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id q35-20020a17090a752600b002038d8a68fbso16498585pjk.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 12:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=Bys+g6AU0hW4pKg0x/ecVxR/rYZ0Qg+jTvtx/DxcQwE=;
        b=KnoGxcgKb0VeWxeXkDIYTarKak1vYNSDO7qW5/R04eljpGIg/0e8HjBIbg7FNDIKx2
         FRZthD0ou89mxOMItkYaYta0w9DjGI6LsKaVx7i7pHQ1DkDO/LnuyzffLYiZg56S9CiE
         msmmC8h3oOhfbjnulnroI1vY6CniOtCxwpcJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Bys+g6AU0hW4pKg0x/ecVxR/rYZ0Qg+jTvtx/DxcQwE=;
        b=rc9484Pcofl7zIrusGyBG2/70zCX1/38Vx8BfOCjImI+ucD+XsBN47ebuugTLct7tQ
         gN+RoHtIMqlYeJ7O7BJmdkqlAxrzw7NHKinvsJiq6thFjFrZ2d5VaiqpWYvFmhEPubAW
         9EQGyyOZhhWhPffXQDRwQQwqHPBTwOhG2qduhtVE0iDj9HTmWiAV0AUeHm9c3CQ2vSxy
         DAH0JxH0Q6LawQZcqLKHU7wN/4w2We5KduAw+foCeAHfvw2iabJP0nNXS88WC6FyWf0K
         Ar6jazchpsFXNyQZa+Wqga9OvSLSmxvMTqKMPHFiU9vYWF8gOZq+4Ri3zn6zngOjkR6w
         utUw==
X-Gm-Message-State: ACrzQf1CUED54chvi9NHzWzR/S5+4XcJqhj1azW6pDuZ//hXhysFWVNk
        fAyYGU6v+7WM0lrJ8VRVXl1Agg==
X-Google-Smtp-Source: AMsMyM48SUc01nsTvTfZe/V6mOSf+RhShyC4BKrqoxRditRR7MK3A+ALMZ+Nz9C2YnpLtacseLIJIw==
X-Received: by 2002:a17:90a:fe90:b0:202:a345:b7a6 with SMTP id co16-20020a17090afe9000b00202a345b7a6mr6103501pjb.14.1664306639240;
        Tue, 27 Sep 2022 12:23:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q7-20020a17090311c700b001754fa42065sm2009217plh.143.2022.09.27.12.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 12:23:58 -0700 (PDT)
Date:   Tue, 27 Sep 2022 12:23:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        llvm@lists.linux.dev, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2] x86, mem: move memmove to out of line assembler
Message-ID: <202209271143.7B7D15D@keescook>
References: <CAKwvOd=a+0VNP-d=mHnbM4ujdtPrujru4dxHtfDo+EEM+b6deg@mail.gmail.com>
 <20220927172839.3708280-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927172839.3708280-1-ndesaulniers@google.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 10:28:39AM -0700, Nick Desaulniers wrote:
> In addition to having complex constraints that can't always be resolved,
> the clobber list seems to be missing %bx and %dx, and possibly %cl. By
> using numbered operands rather than symbolic operands, the constraints
> are quite obnoxious to refactor.
> [...]
> -		/*
> -		 * Move data from 2 bytes to 3 bytes.
> -		 */
> -		".p2align 4\n\t"
> -		"9:\n\t"
> -		"cmp $2, %0\n\t"
> -		"jb 10f\n\t"
> -		"movw 0*2(%1), %%dx\n\t"
> -		"movw -1*2(%1, %0), %%bx\n\t"
> -		"movw %%dx, 0*2(%2)\n\t"
> -		"movw %%bx, -1*2(%2, %0)\n\t"
> -		"jmp 11f\n\t"
> [...]
> +.set tmp0, %edi
> [...]
> +	/*
> +	 * Move data from 2 bytes to 3 bytes.
> +	 */
> +.p2align 4
> +.L4_byteswap:
> +	cmpl	$2, n
> +	jb	.Lbyteswap
> +	movw	0*2(src), %di
> +	movw	-1*2(src, n), %bx
> +	movw	%dx, 0*2(dest)
> +	movw	%bx, -1*2(dest, n)
> +	jmp	.Ldone

Found it (need to use %di instead of %dx). With this changed, the kunit
test passes again:

diff --git a/arch/x86/lib/memmove_32.S b/arch/x86/lib/memmove_32.S
index 73314a391a72..9e33c9a1c595 100644
--- a/arch/x86/lib/memmove_32.S
+++ b/arch/x86/lib/memmove_32.S
@@ -179,7 +179,7 @@ SYM_FUNC_START(memmove)
 	jb	.Lbyteswap
 	movw	0*2(src), %di
 	movw	-1*2(src, n), %bx
-	movw	%dx, 0*2(dest)
+	movw	%di, 0*2(dest)
 	movw	%bx, -1*2(dest, n)
 	jmp	.Ldone

-Kees

-- 
Kees Cook

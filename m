Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE27F6169D2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiKBQzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiKBQzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:55:47 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8DF9FD2
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 09:55:46 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e741329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e741:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8EFFF1EC0426;
        Wed,  2 Nov 2022 17:55:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1667408143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=/6A2mqeJ0SB5JsRybccxgLRehmIqHFFBa+bNM+vMwrk=;
        b=ofOpsSVX4Ncp9vcV/pFbomxBI0GmT/61bGcujLgRFS6zcJJsPMagV2Ioafwug/w7kJ6R7q
        zY2wBzmhRTm5VN/xay/K5e655pPlv7Hfjw+qhw1Uz/W983/gA5imfbxkesagtaHbuFq6s2
        dTTEy4AX+BvqwSivmYNqYj5QP0+v86Q=
Date:   Wed, 2 Nov 2022 17:55:39 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     YingChi Long <me@inclyc.cn>
Cc:     chang.seok.bae@intel.com, dave.hansen@linux.intel.com,
        david.laight@aculab.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        ndesaulniers@google.com, pbonzini@redhat.com, tglx@linutronix.de,
        x86@kernel.org
Subject: Re: [PATCH RESEND v3] x86/fpu: use _Alignof to avoid UB in TYPE_ALIGN
Message-ID: <Y2KhCyofvfG5W5hE@zn.tnic>
References: <20221006141442.2475978-1-me@inclyc.cn>
 <20221029122552.2855941-1-me@inclyc.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221029122552.2855941-1-me@inclyc.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2022 at 08:25:52PM +0800, YingChi Long wrote:
> WG14 N2350 made very clear that it is an UB having type definitions
> with in "offsetof".

Pls put the working group URL note here, not below in a Link tag.

Also, write out "UB" pls.

> This patch change the implementation of macro

Avoid having "This patch" or "This commit" in the commit message. It is
tautologically useless.

Also, do

$ git grep 'This patch' Documentation/process

for more details.

> "TYPE_ALIGN" to builtin "_Alignof" to avoid undefined behavior.

But you don't change the implementation of TYPE_ALIGN - you replace it
with _Alignof().

> I've grepped all source files to find any type definitions within
> "offsetof".
>
>     offsetof\(struct .*\{ .*,
>
> This implementation of macro "TYPE_ALIGN" seemes to be the only case
> of type definitions within offsetof in the kernel codebase.
>
> I've made a clang patch that rejects any definitions within
> __builtin_offsetof (usually #defined with "offsetof"), and tested
> compiling with this patch, there are no error if this patch applied.

What does that paragraph have to do with fixing the kernel?

Is this patch going to be part of clang? If so, which version?

Does gcc need it too?

If so, should a gcc bug be opened too?

> ISO C11 _Alignof is subtly different from the GNU C extension
> __alignof__. __alignof__ is the preferred alignment and _Alignof the
> minimal alignment. For 'long long' on x86 these are 8 and 4
> respectively.
> 
> The macro TYPE_ALIGN we're replacing has behavior that matches

Who's "we"?

> _Alignof rather than __alignof__.
> 
> Signed-off-by: YingChi Long <me@inclyc.cn>
> Link: https://www.open-std.org/jtc1/sc22/wg14/www/docs/n2350.htm
> Link: https://godbolt.org/z/sPs1GEhbT

Put that link in the text above where you talk about the *align*
differences.

> Link: https://gcc.gnu.org/onlinedocs/gcc/Alignment.html
> Link: https://reviews.llvm.org/D133574

Aha, that's the clang patch. Put it in the text above too pls.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

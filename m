Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361476E97BB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 16:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbjDTOy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 10:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbjDTOyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 10:54:54 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5806410C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 07:54:53 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D397F1EC04CC;
        Thu, 20 Apr 2023 16:54:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1682002491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=0HO1GmpiXco+18n5RL4ti54nLW8RSuSv3Lr8Iuc2+Mk=;
        b=Cx6+m8qmFnqIaOlQycr4UjjghUR936eCdK3z9+lPXmV/H6uSgNYg8MBshEQxJx5A9x4klO
        +iBbE7+Z04NxeMJXWehrA3SpeBTVXzX0Br/gaKXD/MhgXpz3jMtZUJyNnoOMa4wRrUPFty
        gec33RBCy0wDRc8DrY0AThQVkRSX6hk=
Date:   Thu, 20 Apr 2023 16:54:51 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH v5 11/15] x86/mtrr: construct a memory map with cache
 modes
Message-ID: <20230420145451.GFZEFSO6VmvXdK/qi9@fat_crate.local>
References: <20230401063652.23522-1-jgross@suse.com>
 <20230401063652.23522-12-jgross@suse.com>
 <20230420121551.GMZEEs9wkUrvX05nQr@fat_crate.local>
 <d164d84b-6773-36e3-1136-672072e9233d@suse.com>
 <20230420130113.GCZEE3mfOTxcDn6e3/@fat_crate.local>
 <681c5d8e-0e42-07e1-f91c-7696a2360f1c@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <681c5d8e-0e42-07e1-f91c-7696a2360f1c@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 03:57:43PM +0200, Juergen Gross wrote:
> So you are suggesting that prefetching can happen across one wrong speculated
> branch, but not across two of them? And you are not worrying about prefetches
> past the end of a copy with size > 0?

Maybe it will, maybe it won't.

I am worried about calling a function unnecessarily. I'm worried about
calling the asm version __memmove() with zero length unnecessarily. I'm
worried about executing the return thunk unnecessarily:

ffffffff8104c749:       48 83 c4 28             add    $0x28,%rsp
ffffffff8104c74d:       e9 72 2a 9b 00          jmp    ffffffff819ff1c4 <__x86_return_thunk>
ffffffff8104c752:       31 c0                   xor    %eax,%eax
ffffffff8104c754:       e9 6b 2a 9b 00          jmp    ffffffff819ff1c4 <__x86_return_thunk>
ffffffff8104c759:       0f 1f 80 00 00 00 00    nopl   0x0(%rax)

Just say that you don't want to do this simple check and I will do it
myself because I'm tired of debating.

> "If two or more variable memory ranges match and one of the memory types is UC,
> the UC memory type used."
> 
> So technically no problem, apart from lower performance.

How do you come from "Write-combining to UC memory is not allowed" to
"lower performance"?

Not allowed is not allowed. Geez.

> Would you be fine with adding that as an additional patch?
>
> I believe if we really want that, then we should be able to disable such a
> cleanup. So it should be an add-on anyway.

Sure, whatever.

> I'm not against adding such additional checks. I wouldn't like to force them
> into this series right now, because we need this series for Hyper-V isolated
> guest support.

We will add this series when they're ready. If Hyper-V needs them
immediately they can take whatever they want and do whatever they want.

Or you can do a simpler fix for Hyper-V that goes before this, if you
want to address Hyper-V.

> Just to say it explicitly: you are concerned for the case that a complete
> MTRR is hidden beneath another one (e.g. a large UC MTRR hiding a smaller
> MTRR with another type, or a variable MTRR being hidden by fixed MTRRs)?

I am concerned about catching any and all inconsistencies with the MTRRs
and catching them right. If we're going to spend all this time on this,
then let's do it right, once and for all and do it in a manner that can
be improved in the future.

Thanks!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDDAA6EB4F5
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 00:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbjDUWfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 18:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbjDUWfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 18:35:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A487270C
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 15:35:08 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682116434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+xT6n3WApWv7OhmUwRSte3wHtNi3lWiZ0ZaFfUySfsQ=;
        b=PWwqjXUcylEbE9ClUnmk5n/sq9rsuKmpFbGDBFqliIXODhb4dGMyts934wmy0f/1ViOi4u
        wuC0KLOlBydrhGOZGyJn/ub4jzpsxI2jd07cgBy+A7KclE95qFr+ZBvstCJOE5IdsR2aYM
        R3PSsAjl2pIpfgthtRann3kxViEOBKTctac9GDzTb/WQgf5zMtZo6E4n1w82MDuDehL3bT
        P4/RRYgf/pI9OAtEOFi1XflW6y5tGl5Nthd4GKZsHDMD8LIYfybPakpWZaIBVuismts3gf
        wXCZ/Ou/JO5+F0CidbEdhSQAToteL7PSECORa6iJNAaOTYDUnO9aF6jydzRXKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682116434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+xT6n3WApWv7OhmUwRSte3wHtNi3lWiZ0ZaFfUySfsQ=;
        b=lJ7F604/uusQyUKfYfzm8nlcTjDOyIBvNY1opOGVa+fida5bmI3GJtfHg8xsuMsog+zRK1
        2Sqy/V63K1g7AoDQ==
To:     Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] x86/microcode/AMD: Document which patches are not
 released for late loading
In-Reply-To: <20230415142821.24725-1-bp@alien8.de>
References: <20230415142821.24725-1-bp@alien8.de>
Date:   Sat, 22 Apr 2023 00:33:54 +0200
Message-ID: <87fs8s27cd.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 15 2023 at 16:28, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
>
> PeterZ wanted this spelled out explicitly. Add it to the documentation
> so that everyone's on the same page wrt to which microcode patches are
> not allowed to be late loaded.
>
> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> ---
>  Documentation/x86/microcode.rst | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/x86/microcode.rst b/Documentation/x86/microcode.rst
> index 15b52e2b181d..d5ef9184030c 100644
> --- a/Documentation/x86/microcode.rst
> +++ b/Documentation/x86/microcode.rst
> @@ -218,6 +218,10 @@ a fault happens, the whole core will see it either before the microcode
>  patch has been applied or after. In either case, T0 and T1 will have the
>  same microcode revision and nothing intermediate.
>  
> +In addition, microcode patches which modify software-visible features
> +like CPUID bits, MSRs, chicken bits, etc are not released for late
> +loading.

No. Why the heck is AMD any different from Intel vs. late loading?

It does not matter at all that the AMD microcode machinery does not have
the concurrency issues like the Intel one, which just need some extra
care.

The software visible feature change issue is exactly the same and the
problem of late loading is all about that and not about the concurrency.

So Intel got its act together and added a minimal version field into the
microcode header. AMD should do exactly the same and not assume that
late loading is safe by pretending that updates which modify software
visible features are not released.

That's just not true. AMD releases microcode updates with software
visible changes as does Intel, no?

How did all the hardware vulnerability updates, which changed CPUID,
MSRs and chicken bits, get distributed? By not releasing them?

This patch along with the other which claims that AMD is safe is just
wishful thinking material.

Boris, please remove them from the for 6.4 queue.

Thanks,

        tglx

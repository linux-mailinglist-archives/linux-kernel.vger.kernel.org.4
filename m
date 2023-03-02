Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6D36A8047
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 11:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjCBKun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 05:50:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjCBKul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 05:50:41 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67347231DE
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 02:50:39 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E62641EC06F4;
        Thu,  2 Mar 2023 11:50:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1677754238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=tWz6s9l2WCuAQ512Au4zmKPORo5v7ghhLXhY91mwp3E=;
        b=pOHIyZx/ODKTp9XHBtVIavPfqNRRgOZCuwYhA7EBjsj9zhO1vyc9Z2XO246n0OWQq7Z9za
        lQvT7dYs8brvofPKG9cGQPbM6NsiJpmqsi6IDgEaVL8cEiOJhEXDSEOGqI5jm6WyMsYNmV
        bUHQNu206l7qCzrLiZ8LRj3qHePwpfw=
Date:   Thu, 2 Mar 2023 11:50:33 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Hugh Dickins <hughd@google.com>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [tip: x86/urgent] x86/setup: Always reserve the first 1M of RAM
Message-ID: <ZAB/b+FjHjuRqe/S@zn.tnic>
References: <20210601075354.5149-2-rppt@kernel.org>
 <162274330352.29796.17521974349959809425.tip-bot2@tip-bot2>
 <7d344756-aec4-4df2-9427-da742ef9ce6b@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7d344756-aec4-4df2-9427-da742ef9ce6b@app.fastmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 07:51:43PM -0800, Andy Lutomirski wrote:
> This is quite broken.  The comments in the patch seem to understand
> that Linux tries twice to allocate the real mode trampoline, but the
> code has some issues.
> 
> First, it actively breaks the logic here:
> 
> +               /*
> +                * Don't free memory under 1M for two reasons:
> +                * - BIOS might clobber it
> +                * - Crash kernel needs it to be reserved
> +                */
> +               if (start + size < SZ_1M)
> +                       continue;
> +               if (start < SZ_1M) {
> +                       size -= (SZ_1M - start);
> +                       start = SZ_1M;
> +               }
> +

Are you refering, per-chance, here to your comment in that same function
a bit higher?

Introduced by this thing here:

5bc653b73182 ("x86/efi: Allocate a trampoline if needed in efi_free_boot_services()")

?

Also, it looks like Mike did pay attention to your commit:

https://lore.kernel.org/all/YLZsEaimyAe0x6b3@kernel.org/

And then there's the whole deal with kdump kernel needing lowmem. The
function which became obsolete and got removed by:

23721c8e92f7 ("x86/crash: Remove crash_reserve_low_1M()")

So, considering how yours is the only report that breaks booting and
this reservation of <=1M has been out there for ~2 years without any
complaints, I'm thinking what we should do now is fix that logic.

Btw, this whole effort started with

  a799c2bd29d1 ("x86/setup: Consolidate early memory reservations")

Also see this:

ec35d1d93bf8 ("x86/setup: Document that Windows reserves the first MiB")

and with shit like that, we're "piggybacking" on Windoze since there
certification happens at least.

Which begs the question: how does your laptop even boot on windoze if
windoze reserves that 1M too?!

> I real the commit message and the linked bug, and I'm having trouble
> finding evidence of anything actually fixed by this patch.  Can we
> just revert it?  If not, it would be nice to get a fixup patch that
> genuinely cleans this up -- the whole structure of the code (first,
> try to allocate trampoline, then free boot services, then try again)
> isn't really conducive to a model where we *don't* free boot services
> < 1M.

Yes, I think this makes most sense. And that whole area is a minefield
so the less we upset the current universe, the better.

> Discovered by my delightful laptop, which does not boot with this patch applied.

How come your laptop hasn't booted new Linux since then?!? Tztztztz

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

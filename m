Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4EF6A8516
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 16:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjCBPW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 10:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjCBPWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 10:22:24 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69562F78A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 07:22:21 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0419A1EC06C0;
        Thu,  2 Mar 2023 16:22:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1677770540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=YP4Ptg6sjYFhrDNS1ttctzctvUfR/mV6TTV9qVuxWnE=;
        b=DkZ3+GlouZsbe3SPKQXK3tVVaEQRoJz49Ax2m+24EXW3e3VMoss5TMFiVxJONbsJ21O07c
        sYNgvZhVRW46qRDGQBe7RgjG1ibPcIArEpQrbvtLUQzs5dVPX3NiqIQr0HkkemYkG/Saxg
        NkreP9uCZu/e6AsEYBZpHnt8zyag9yE=
Date:   Thu, 2 Mar 2023 16:22:16 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Hugh Dickins <hughd@google.com>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [tip: x86/urgent] x86/setup: Always reserve the first 1M of RAM
Message-ID: <20230302152216.GCZAC/KGPyE9V/rHCK@fat_crate.local>
References: <20210601075354.5149-2-rppt@kernel.org>
 <162274330352.29796.17521974349959809425.tip-bot2@tip-bot2>
 <7d344756-aec4-4df2-9427-da742ef9ce6b@app.fastmail.com>
 <ZAB/b+FjHjuRqe/S@zn.tnic>
 <840dcfd4-0d6c-400a-9cf7-8fe56d55ac7f@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <840dcfd4-0d6c-400a-9cf7-8fe56d55ac7f@app.fastmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 07:06:11AM -0800, Andy Lutomirski wrote:
> There is no possible way that Windoze genuinely reserves the first 1M.
> It does SMP, and x86 needs <1M memory for SMP, so Windoze uses <1M
> memory.  QED :)

Then we need to sort this out first. Because this patch says the
contrary.

> >> I real the commit message and the linked bug, and I'm having trouble
> >> finding evidence of anything actually fixed by this patch.  Can we
> >> just revert it?  If not, it would be nice to get a fixup patch that
> >> genuinely cleans this up -- the whole structure of the code (first,
> >> try to allocate trampoline, then free boot services, then try again)
> >> isn't really conducive to a model where we *don't* free boot services
> >> < 1M.
> >
> > Yes, I think this makes most sense. And that whole area is a minefield
> > so the less we upset the current universe, the better.
> 
> I'll send a revert patch.

I actually replied to the text which spoke about a "fixup patch" - not
a revert patch.

> Thinking about this a bit more, if we actually want to "reserve" <1M,
> we should implement it completely differently by treating <1M as its
> very own special thing and teaching the memblock allocator to refuse
> to allocate <1M unless specifically requested.  There's only a very
> small number of allocations that need it (crashkernel for some
> reason?), and there are at least two spurious users of
> memblock_phys_alloc_range that curently may use <1M but have no
> business doing so (ramdisk code and the NUMA distance table).  But
> let's only do that if there's an actual problem to solve.

No, look at early_reserve_memory(). All kinds of crap use that <1M and
we do special reservations there.

I agree with making it a special region aspect.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

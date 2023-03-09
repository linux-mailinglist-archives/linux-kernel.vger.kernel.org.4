Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100B16B259A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 14:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjCINj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 08:39:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjCINj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 08:39:56 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43B4EBDB2
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 05:39:55 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3D91A1EC018C;
        Thu,  9 Mar 2023 14:39:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1678369194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=VLc25eAd2+rDBm5cmMoscmu24c7mmoaCQZea5e70buI=;
        b=Xvvea0lDwN+ZaGnmHcFGpTJ22O7VfIQNHD9CMhTzUCT6N54b8zjlQHaxCOgIY4h+YTKmTP
        z6sIgqCqU4r07P6HoSjfqVHNvAj33tqb3afOt0yczXeSQJj4XyDhmrhOdl2+XTctx/24f4
        exk4r/wrDTpZu9CRAJThU532fjnOFc0=
Date:   Thu, 9 Mar 2023 14:39:50 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        virtualization@lists.linux-foundation.org,
        "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/paravirt: convert simple paravirt functions to asm
Message-ID: <20230309133950.GDZAnhpnon5fk4Fg/X@fat_crate.local>
References: <20230308154210.18454-1-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230308154210.18454-1-jgross@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 04:42:10PM +0100, Juergen Gross wrote:
> All functions referenced via __PV_IS_CALLEE_SAVE() need to be assembler
> functions, as those functions calls are hidden from gcc. In case the
> kernel is compiled with "-fzero-call-used-regs" the compiler will
> clobber caller-saved registers at the end of C functions, which will
> result in unexpectedly zeroed registers at the call site of the
> related paravirt functions.
> 
> Replace the C functions with DEFINE_PARAVIRT_ASM() constructs using
> the same instructions as the related paravirt calls in the
> PVOP_ALT_[V]CALLEE*() macros.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>  arch/x86/include/asm/paravirt_types.h |  8 +++++++-
>  arch/x86/kernel/paravirt.c            | 27 ++++++---------------------
>  2 files changed, 13 insertions(+), 22 deletions(-)

Right, works with my particular reproducer.

Turning them into asm prevents the compiler from doing the
callee-clobbered zeroing and that's fine as this whole paravirt gunk is
hiding the "CALL" insn from it and you putting them in asm is in line
with this.

And a negative diffstat..

So yeah, I'll queue it soon unless someone objects.

Long term, I think we should continue switching all that pv stuff to
using the alternatives.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

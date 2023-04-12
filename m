Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7FB6E008A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 23:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjDLVMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 17:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjDLVMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 17:12:09 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A116E96
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 14:11:59 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 121FB1EC051E;
        Wed, 12 Apr 2023 23:11:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1681333918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=HJYqs9cEBfoLiSUzgjpNDSfIiv1vg3rOU/H/BIhOsmQ=;
        b=R8zEr/Oa4KDmK/pQH5CGUi9KpIb8XCoBhE2wYNF2Uo/R4gvbvTtcQ6FvEbvUPlK1s2G6jj
        xCbUE2Xb08d++c+Jzhqv9vBK3/pJzPddoBwLx95hfZO3e+fV1NKruUCHKmVve4uodLNanR
        MOvtbYC6+jkvo7S2BIbhERNudPxvecU=
Date:   Wed, 12 Apr 2023 23:11:53 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH v5 09/15] x86/mtrr: allocate mtrr_value array dynamically
Message-ID: <20230412211153.GKZDcemdxs2mhhwuiF@fat_crate.local>
References: <20230401063652.23522-1-jgross@suse.com>
 <20230401063652.23522-10-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230401063652.23522-10-jgross@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 01, 2023 at 08:36:46AM +0200, Juergen Gross wrote:
> +#ifdef CONFIG_X86_32

TBH, I'm not really crazy about adding more ifdeffery.

Wondering if adding a 32-bit only build object:

obj-$(CONFIG_X86_32) += amd.o cyrix.o centaur.o legacy.o

to arch/x86/kernel/cpu/mtrr/Makefile and moving all that gunk over
there, out of the way, would be even cleaner...

> +	mtrr_value = kcalloc(num_var_ranges, sizeof(*mtrr_value), GFP_KERNEL);
> +
>  	/*
>  	 * The CPU has no MTRR and seems to not support SMP. They have
>  	 * specific drivers, we use a tricky method to support
> -	 * suspend/resume for them.
> +	 * suspend/resume for them. In case above allocation failed we can't
> +	 * support suspend/resume (handled in mtrr_save()).

Oh well.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF85E6D20F7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 14:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbjCaMzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 08:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjCaMzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 08:55:48 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1D2199
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 05:55:45 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3FB2C1EC063A;
        Fri, 31 Mar 2023 14:55:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1680267344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=uPa2/Ud1iB+5P4b9t4uXV+laCBDJ/WtIqvondW19vOs=;
        b=eU471Cjt5jAD35CbsemfxcfNE9JqnLXRIwADatzZYPkhFt7GISj5W9KG28DmREHkvJuG4m
        gXqRMRYIqOTyPi8htZiIuBB59yCVsGIHzixqeZWvD1+dyzq9PDD5bICHuCrlp+c/hHtBbP
        3TCu/SdhFYQYjXT7cts2EHo8SpM1TKM=
Date:   Fri, 31 Mar 2023 14:55:38 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v4 09/12] x86/mtrr: construct a memory map with cache
 modes
Message-ID: <20230331125538.GBZCbYSqr8kMP4bpwS@fat_crate.local>
References: <20230306163425.8324-1-jgross@suse.com>
 <20230306163425.8324-10-jgross@suse.com>
 <20230329125128.GAZCQ0UJUj48VKdG//@fat_crate.local>
 <a6c02861-f01d-fcfd-82e0-8c5695f581b6@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a6c02861-f01d-fcfd-82e0-8c5695f581b6@suse.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 03:39:35PM +0200, Juergen Gross wrote:
> No. :-)

Because?

> The final form of the code is the result of an iterative process. :-)

I have a similar iterative process: until it hasn't been reviewed and
explained properly, this is not going anywhere.

So however you wanna do it, fine by me.

> I've reused the wording from cleanup.c (just above amd_special_default_mtrr()).

That got added with K8. K8 is ancient history so nothing magic about
that anymore. It is basically a bit in the SYSCFG MSR which says that

	[4G ... TOP_MEM2]

is WB.

> > Why not in mtrr_bp_init()? That is the first CPU.
> 
> Yeah, but generic_set_mtrr() can be called after boot, too.

That function sets a single MTRR register so you'd have to merge the
ranges, AFAICT. Not rebuild the whole map...

> Umm, not really. I want to do the copy even in the Xen PV case.

How about some comments? Or you're expecting me to be able to read your
mind?!

;-\

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

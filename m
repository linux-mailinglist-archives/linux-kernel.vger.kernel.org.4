Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3882D5EE13D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 18:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbiI1QMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 12:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233749AbiI1QMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 12:12:30 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21AD36DF93
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 09:12:30 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e7ee329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7ee:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9D1671EC058B;
        Wed, 28 Sep 2022 18:12:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1664381544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=P39ljKLiwuQPwtDvDuKVanquI0RYkjP1D8LuyTjtJJs=;
        b=Uao1ZphADuAsv6LM0PXKjLzWHVW6MpllBeF4uvmOQ+nQNKu9+hXBTS4RGyWezPZ0smbv/h
        IGZDd1BS828tjI6dOprjqWP0i4n19k+ZHCma3t7R0BXQ/TawsINhDvqGnP0458LIrxfMZX
        X0HwXQ23W2btK4ibPwovzxoqz5hFSFQ=
Date:   Wed, 28 Sep 2022 18:12:24 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 08/10] x86/mtrr: let cache_aps_delayed_init replace
 mtrr_aps_delayed_init
Message-ID: <YzRyaLRqWd6YSgeJ@zn.tnic>
References: <d3cd5c50-24e7-ffba-de2d-cf00400f6e38@suse.com>
 <YzLo9IFDYW1T8BVZ@zn.tnic>
 <314e3bd3-3405-c0c3-225c-646d88cbfb1a@suse.com>
 <YzOEYsqM0UEsiFuS@zn.tnic>
 <73d8fabd-8b93-2e65-da4b-ea509818e666@suse.com>
 <24088a15-50a1-f818-8c3e-6010925bffbf@suse.com>
 <YzQmeh50ne8dyR2P@zn.tnic>
 <f8da6988-afa3-1e85-b47d-d91fc4113803@suse.com>
 <YzQui+rOGrM6otzp@zn.tnic>
 <c67d3887-498b-6e4d-857d-1cef7835421d@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c67d3887-498b-6e4d-857d-1cef7835421d@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 03:43:56PM +0200, Juergen Gross wrote:
> Would you feel better with adding a new enum member CPUHP_AP_CACHECTRL_ONLINE?
> 
> This would avoid a possible source of failure during resume in case no slot
> for CPUHP_AP_ONLINE_DYN is found (quite improbable, but in theory possible).

Let's keep that in the bag for the time when we get to cross that bridge.

> You wouldn't want to do that there, as there are multiple places where
> pm_sleep_enable_secondary_cpus() is being called.

We want all of them, I'd say. They're all some sort of suspend AFAICT.
But yes, if we get to do it, that would need a proper audit.

> Additionally not all cases are coming in via
> pm_sleep_enable_secondary_cpus(), as there is e.g. a call of
> suspend_enable_secondary_cpus() from kernel_kexec(), which wants to
> have the same handling.

Which means, more hairy.

> arch_thaw_secondary_cpus_begin() and arch_thaw_secondary_cpus_end() are
> the functions to mark start and end of the special region where the
> delayed MTRR setup should happen.

Yap, it seems like the best solution at the moment. Want me to do a
proper patch and test it on real hw?

:-)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

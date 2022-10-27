Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912BA60F3BC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 11:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234685AbiJ0JdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 05:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235305AbiJ0Jcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 05:32:41 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D20A18385
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 02:32:13 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e7cb329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7cb:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BEBEB1EC0304;
        Thu, 27 Oct 2022 11:32:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1666863131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ouw2vjy4BDnURX8dxvYX7E6twRFIgmhbo6FgT0Lf7gs=;
        b=o0eH2Rs8ZmXU6/V84SSO84/nHHjHe92Tx6yF6gMjzPDYo3BjN+32Ilk59lpuJPM3i+PLmG
        LaQyv8G3mg2FHRxrohgXPdU87V2P3XNdO/YRHWf44BQlN7SxUEJFGxuoxsgHLleHRo1akt
        4XmTU94fRc+FgORvh+HkKW0c8LC9Br4=
Date:   Thu, 27 Oct 2022 11:32:06 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v4 09/16] x86/mtrr: simplify mtrr_bp_init()
Message-ID: <Y1pQFjiVi9wajQH4@zn.tnic>
References: <20221004081023.32402-1-jgross@suse.com>
 <20221004081023.32402-10-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221004081023.32402-10-jgross@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 10:10:16AM +0200, Juergen Gross wrote:
> In case of the generic cache interface being used (Intel CPUs or a
> 64-bit system), the initialization sequence of the boot CPU is more
> complicated as necessary:

s/as/than/

> 
> - check if MTRR enabled, if yes, call mtrr_bp_pat_init() which will
>   disable caching, set the PAT MSR, and reenable caching
> 
> - call mtrr_cleanup(), in case that changed anything, call
>   cache_cpu_init() doing the same caching disable/enable dance as
>   above, but this time with setting the (modified) MTRR state (even
>   if MTRR was disabled) AND setting the PAT MSR (again even with
>   disabled MTRR)
> 
> The sequence can be simplified a lot while removing potential
> inconsistencies:
> 
> - check if MTRR enabled, if yes, call mtrr_cleanup() and then
>   cache_cpu_init()
> 
> This ensures to:
> 
> - no longer disable/enable caching more than once
> 
> - avoid to set MTRRs and/or the PAT MSR on the boot processor in case
>   of MTRR cleanups even if MTRRs meant to be disabled
> 
> With that mtrr_bp_pat_init() can be removed.

I like that simplification - I just hope there's not some weird ordering
that is still needed. But we'll see when this hits the wider audiences.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

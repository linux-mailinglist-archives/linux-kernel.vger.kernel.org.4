Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB796DDBF4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 15:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjDKNUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 09:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjDKNUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 09:20:48 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C726DE
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 06:20:47 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AD15F1EC01E0;
        Tue, 11 Apr 2023 15:20:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1681219245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=TGpWdRPZf9Wcr60wyFMsSijL627b/TFZGKFNiWmO9dE=;
        b=MXqJLKdmcaydcvzQwrvJG6Aoyw8JObji4AGnMQrFIGReVXB9liDiCOWhFEJFc4kHgQGkmy
        2SHdhFl+lhDymUSD04XAPHiZcqdtcXbS+0aaopkUsJtX2iUB6EOMlwXX4acxnl6O9su0d2
        zaMbGhSRLPfnMveKncRUnL9MDwFOnZk=
Date:   Tue, 11 Apr 2023 15:20:40 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH v5 04/15] x86/mtrr: support setting MTRR state for
 software defined MTRRs
Message-ID: <20230411132040.GHZDVeqCqATbbgzdXK@fat_crate.local>
References: <20230401063652.23522-1-jgross@suse.com>
 <20230401063652.23522-5-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230401063652.23522-5-jgross@suse.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 01, 2023 at 08:36:41AM +0200, Juergen Gross wrote:
> When running virtualized, MTRR access can be reduced (e.g. in Xen PV
> guests or when running as a SEV-SNP guest under Hyper-V). Typically
> the hypervisor will reset the MTRR feature in CPUID data, resulting
> in no MTRR memory type information being available for the kernel.
> 
> This has turned out to result in problems:

Let's add the links to those problems:

> - Hyper-V SEV-SNP guests using uncached mappings where they shouldn't

I can't find Michael's original report, do you have a link?

> - Xen PV dom0 mapping memory as WB which should be UC- instead

Link: https://lore.kernel.org/all/4fe9541e-4d4c-2b2a-f8c8-2d34a7284930@nerdbynature.de/

> 
> Solve those problems by supporting to set a static MTRR state,

s/by supporting to set a/allowing an MTRR static state override/

> +void mtrr_overwrite_state(struct mtrr_var_range *var, unsigned int num_var,
> +			  mtrr_type def_type)
> +{
> +	unsigned int i;
> +
> +	/* Only allowed to be called once before mtrr_bp_init(). */
> +	if (WARN_ON(mtrr_state_set))

WARN_ON_ONCE() is probably better.

> +		return;
> +
> +	/* Only allowed when running virtualized. */
> +	if (!cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
> +		return;
> +
> +	/*
> +	 * Only allowed for special virtualization cases:
> +	 * - when running as SEV-SNP guest
> +	 * - when running as Hyper-V isolated guest

	when running as a SEV-SNP guest on a HyperV with vTOM enabled

that's a single condition.

> +	 * - when running as Xen PV guest
> +	 * - when running as TSX guest
> +	 */
> +	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP) &&
> +	    !hv_is_isolation_supported() &&
> +	    !cpu_feature_enabled(X86_FEATURE_XENPV) &&
> +	    !cpu_feature_enabled(X86_FEATURE_TDX_GUEST))

IOW:

	if (!(hv_is_isolation_supported() && cc_platform_has(CC_ATTR_GUEST_SEV_SNP)) &&
	    !cpu_feature_enabled(X86_FEATURE_XENPV) &&
	    !cpu_feature_enabled(X86_FEATURE_TDX_GUEST))


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

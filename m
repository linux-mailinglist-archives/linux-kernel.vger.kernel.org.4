Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412CB6C68AC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbjCWMno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbjCWMnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:43:32 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC4A26C0E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 05:43:31 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1D8ED1EC0666;
        Thu, 23 Mar 2023 13:43:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1679575410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=K9/n1rpAwWFTZEJX1IfhukaW5XPdU+nWAbh6D9porq0=;
        b=nrqNQ33NtT7l7CzSbB7aCBMDOTqEvqWLVPXSD5X14u8yn87ok8XDAIJmfZJMhFz6bAxt9q
        ERkh/4ZJF5si3nVU4Cmv3JD656voKZjP4WzeBqHK+1qfv6tsn7OxIf3vVrSmUS3Iokwe7c
        HbajBiKvPygMagiGPuQ+3U52OEcMRO8=
Date:   Thu, 23 Mar 2023 13:43:24 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org
Subject: Re: [PATCH v4 05/12] x86/xen: set MTRR state when running as Xen PV
 initial domain
Message-ID: <20230323124324.GHZBxJbOW1fvHOgiQ1@fat_crate.local>
References: <20230306163425.8324-1-jgross@suse.com>
 <20230306163425.8324-6-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230306163425.8324-6-jgross@suse.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 05:34:18PM +0100, Juergen Gross wrote:
> +	for (reg = 0; reg < MTRR_MAX_VAR_RANGES; reg++) {
> +		op.u.read_memtype.reg = reg;
> +		if (HYPERVISOR_platform_op(&op))
> +			break;
> +
> +		/*
> +		 * Only called in dom0, which has all RAM PFNs mapped at
> +		 * RAM MFNs, and all PCI space etc. is identity mapped.
> +		 * This means we can treat MFN == PFN regarding MTTR settings.
								^^^^

"MTRR"

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A696DDDC5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 16:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjDKO0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 10:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjDKO0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:26:13 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B4249ED
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 07:25:34 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8CCAB1EC0683;
        Tue, 11 Apr 2023 16:25:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1681223132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=rVEhGndmB8oSTS3lqumiTjv9haUKJbHWS1Ki1t/sVSM=;
        b=PDXRsYk+JHdbCji7k/nMw+CnFZZwBwc/CUohrNjxFMaOWyVYqfRzhqS3EaDOmXFzs53cwN
        V2gdDId/0MzgXrB8EhQOpuM1ZtsxSvVp1WsvGRQ6rRDXow4c2RO5G+CF+OZmpfyU9xrjPa
        bailtx9CNz2JmVmvY5DY+rCJw0p5ZDY=
Date:   Tue, 11 Apr 2023 16:25:28 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Juergen Gross <jgross@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v5 04/15] x86/mtrr: support setting MTRR state for
 software defined MTRRs
Message-ID: <20230411142528.GAZDVt2M8cNB7Ebcrn@fat_crate.local>
References: <20230401063652.23522-1-jgross@suse.com>
 <20230401063652.23522-5-jgross@suse.com>
 <20230411132040.GHZDVeqCqATbbgzdXK@fat_crate.local>
 <BYAPR21MB168853F1DD1B76FACC1CFFFBD79A9@BYAPR21MB1688.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BYAPR21MB168853F1DD1B76FACC1CFFFBD79A9@BYAPR21MB1688.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 01:59:36PM +0000, Michael Kelley (LINUX) wrote:
> That's doesn't work.  Hyper-V guests with vTOM don't have
> CC_ATTR_GUEST_SEV_SNP. As previously discussed, the SEV-SNP
> machinery is handled by the paravisor,

Do you see now why I want for all kinds of guest types to not deviate
from doing the proper/default checks for their type? This is a good
example, case-in-point.

All "special" guests would get broken in the future, otherwise.

> I really wanted to avoid calls to hv_is_isolation_supported() outside
> of Hyper-V specific code in the kernel.  The alternative is to create
> another CC_ATTR_ value that is set in the vTOM case, but that reopens
> the naming can-of-worms.

Now is the time for you to settle on what would be the official way to
query those guest types, before it propagates everywhere.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A2362328B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 19:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiKISfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 13:35:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiKISfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 13:35:04 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4057625FD;
        Wed,  9 Nov 2022 10:35:03 -0800 (PST)
Received: from zn.tnic (p200300ea9733e7e8329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7e8:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D73F91EC04A9;
        Wed,  9 Nov 2022 19:35:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1668018901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=sgCqhlYzNFswrSvP0izYLcyc40NMQDlTd1dkj4E/Xzk=;
        b=g1jlMZgLawleBiRBTg5BSP9vPzR1jY+aaGM8VT7WTGKWTq7onsiubqyfMowbdvNC3fUYDA
        JMYvZ/Lbgwus63pqBatvPUMOBTiBO6AECRV7BRxGZFvE6Yw00q2ZB9CPtNmbvN5Q67U1EL
        V8/dJj2nTz78zsvBP1e9b7vI+teUDuQ=
Date:   Wed, 9 Nov 2022 19:34:55 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc:     Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        "antonio.gomez.iglesias@linux.intel.com" 
        <antonio.gomez.iglesias@linux.intel.com>
Subject: Re: [PATCH 2/3] x86/cpu/amd: Add feature bit for MSR_AMD64_LS_CFG
 enumeration
Message-ID: <Y2vyz2OAp1xKedYc@zn.tnic>
References: <cover.1663025154.git.pawan.kumar.gupta@linux.intel.com>
 <034c7f5ac243ee7b40ba1a8cc3f9b10b1e380674.1663025154.git.pawan.kumar.gupta@linux.intel.com>
 <Y2qlyfRKgIc4KVcx@zn.tnic>
 <20221108225141.aikng7veemp25p62@desk>
 <Y2rh6FN+gbD6Vbzj@zn.tnic>
 <1ee02d57-21a7-b18e-6cf9-0667445a6fb3@citrix.com>
 <20221109173720.4ovtb2ao3vuuge43@desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221109173720.4ovtb2ao3vuuge43@desk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 09:37:20AM -0800, Pawan Gupta wrote:
> Looks like we need to restore this MSR too,

Why do we? Is that MSR read-only too or what is the reason for that one?

> and we can use existing X86_FEATURE_XMM2 to enumerate it.

Or 86_FEATURE_LFENCE_RDTSC.

> If SSBD is the only reason to restore MSR_AMD64_LS_CFG then we should
> be able to use X86_FEATURE_LS_CFG_SSBD for enumeration.

Yes, MSR_AMD64_LS_CFG is used in SSBD mitigations. For everything <= 0x12:

        /* AMD Family 0xf - 0x12 */
        VULNWL_AMD(0x0f,        NO_MELTDOWN | NO_SSB | NO_L1TF | NO_MDS | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO),
        VULNWL_AMD(0x10,        NO_MELTDOWN | NO_SSB | NO_L1TF | NO_MDS | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO),
        VULNWL_AMD(0x11,        NO_MELTDOWN | NO_SSB | NO_L1TF | NO_MDS | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO),
        VULNWL_AMD(0x12,        NO_MELTDOWN | NO_SSB | NO_L1TF | NO_MDS | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO),

On F14h it says here:

[    0.278930] Speculative Store Bypass: Vulnerable

simply because it is not present there.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

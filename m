Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5AED6C2188
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 20:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbjCTTc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 15:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbjCTTcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 15:32:02 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B971A96B
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 12:25:06 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 09A461EC0662;
        Mon, 20 Mar 2023 20:25:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1679340305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=NofNeNQg1lmmdEnXRvoK68zMGVPvTFTLjpLUztyGwJM=;
        b=WbhYeEW0YKapRPDOYJRmmWw+YVzyNU0gT618QMfAFCIhXs9OK8CntP7kQ3+2ogwKrUl47D
        1pMt8CkYw+yXE1ElIC2rXSLsW81ezTAnL7JO5Gd/7RaUgH8LpS0esKYCNUnJazpnz+PAui
        ei6B7HFNnE9vhCNZ+e+ypvapf7lOKyQ=
Date:   Mon, 20 Mar 2023 20:25:04 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Subject: Re: [PATCH v3 3/8] x86/psp: Register PSP platform device when ASP
 table is present
Message-ID: <20230320192504.GCZBizEGDjVtGWpNP3@fat_crate.local>
References: <20230320191956.1354602-1-jpiotrowski@linux.microsoft.com>
 <20230320191956.1354602-4-jpiotrowski@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230320191956.1354602-4-jpiotrowski@linux.microsoft.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 07:19:51PM +0000, Jeremi Piotrowski wrote:
> The ASP table contains the memory location of the register window for
> communication with the Platform Security Processor. The device is not
> exposed as an acpi node, so it is necessary to probe for the table and
> register a platform_device to represent it in the kernel.
> 
> At least conceptually, the same PSP may be exposed on the PCIe bus as
> well, in which case it would be necessary to choose whether to use a PCI
> BAR or the register window defined in ASPT for communication. There is
> no advantage to using the ACPI and there are no known bare-metal systems
> that expose the ASP table, so device registration is restricted to the
> only systems known to provide an ASPT: Hyper-V VMs. Hyper-V VMs also do
> not expose the PSP over PCIe.
> 
> This is a skeleton device at this point, as the ccp driver is not yet
> prepared to correctly probe it. Interrupt configuration will come later
> on as well.
> 
> Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
> ---
>  arch/x86/kernel/Makefile |  1 +
>  arch/x86/kernel/psp.c    | 42 ++++++++++++++++++++++++++++++++++++++++

If this is a platform device (driver), why isn't it part of
the drivers/platform/x86/ lineup?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

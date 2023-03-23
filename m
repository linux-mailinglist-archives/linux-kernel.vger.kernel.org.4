Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAD36C6C38
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 16:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbjCWPXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 11:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbjCWPXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 11:23:49 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BFF2D15C;
        Thu, 23 Mar 2023 08:23:48 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0FED81EC0104;
        Thu, 23 Mar 2023 16:23:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1679585027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=w/8FQI5qasdjFSo2KwlvPu/61yY7H92avlsMZAE3JXY=;
        b=jZ9248/gHa0ZVU0XUFKLSq7ZtRVgehhgDPrvRDitHgUYpvBatxlo7Go0EIONe8V0SufF/u
        MrO5vkwYtNKlvGVsSstoVr7ox7lo3YVtWXPCK3tq4BiW5grDb7Wp5FSiyGQsNJk73vPDTE
        ogTtzcX6vRt3ADlsuZ87Kg83YeY1Z2Q=
Date:   Thu, 23 Mar 2023 16:23:42 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        linux-crypto@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Subject: Re: [PATCH v3 0/8] Support ACPI PSP on Hyper-V
Message-ID: <20230323152342.GFZBxu/m3u6aFUDY/7@fat_crate.local>
References: <20230320191956.1354602-1-jpiotrowski@linux.microsoft.com>
 <20230322154655.GDZBsi75f6LnQStxSp@fat_crate.local>
 <1d25221c-eaab-0f97-83aa-8b4fbe3a53ed@linux.microsoft.com>
 <20230322181541.GEZBtFzRAMcH9BAzUe@fat_crate.local>
 <ecf005b1-ddb9-da4c-4526-28df4806426c@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ecf005b1-ddb9-da4c-4526-28df4806426c@linux.microsoft.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 03:46:22PM +0100, Jeremi Piotrowski wrote:
> Not at all. Just to be clear: this lights up all the same bits of SNP
> as it does on bare-metal, none of it is emulated away. On bare-metal the
> hypervisor underneath the SNP guest is unencrypted as well. Here the stack
> is: L0 (Hyper-V), L1 (KVM) and L2 (SNP guest).

Yeah, I talked to folks after sending that email yesterday. Apparently
it is ok to do that without compromising SNP guest security but I, in my
eternal paranoia, somehow don't have the warm and fuzzy feeling about
it.

> ... The communication channel between L2 guest and PSP is secured
> using keys that the PSP injects into the SNP guest's address space at
> launch time.

Yeah, all the levels below L2 are required to do it set up env properly
so that L2 SNP guests can run.

> Honestly, I find it pretty cool that you can stuff a whole extra hypervisor
> underneath the SNP guest,

Whatever floats your boat. :-)

As long as it doesn't mess up my interrupt setup code with crazy hacks.

> Not sure I follow you here. The quoted paragraph talks about what the L1
> VM (KVM) sees. The L1 VM needs to issue PSP commands to bring up an L2 SNP
> guest, and later the L1 VM relays SNP guest commands to the PSP. The
> PSP commands are multiplexed to the physical PSP by the L0 hypervisor
> (Hyper-V).
>
> So Hyper-V exposes a PSP to the L1 VM because it is needed and it is
> compatible with the existing Linux driver that handles the PSP. The way
> it is exposed (ACPI table) follows how it was specified by AMD.

No no, it was specified by Microsoft architects.

So, that same interface to the PSP can be done by L0 emulating
a standard ACPI device for the KVM L1 HV and then L1 can use the normal
ACPI interrupt #9.

What's the need for supplying all that other gunk like destination ID,
interrupt vector and so on?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

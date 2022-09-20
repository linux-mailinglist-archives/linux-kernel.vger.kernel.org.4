Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0127F5BEAEF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 18:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbiITQPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 12:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiITQPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 12:15:18 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8AC44F3BC
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 09:15:16 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e791329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e791:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3A9C21EC0432;
        Tue, 20 Sep 2022 18:15:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1663690511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=l+pagcxPPfGt4bnG69SZ4WMdjJW1JGKDuu84r7EsXIQ=;
        b=o+bW83pBAIN6An904Fi9FAx5BaagIFfgcPt1z9igDWxRSai1vqjiPavfsSUfgnXIZubtXK
        I4XOvwQofvCW9UhlzLfN5molsr0r+qKm7yB3UawFS8ggMy3UAOW4CEGI/0g8tAOe5PsCoM
        +QYN/B0zyKK4rCcs+gRxhM5z5RNmAdU=
Date:   Tue, 20 Sep 2022 18:15:07 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 1/4] x86/sev: Put PSC struct on the stack in prep for
 unaccepted memory support
Message-ID: <YynnC29+dfEdYZ8N@zn.tnic>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <cover.1661437397.git.thomas.lendacky@amd.com>
 <f960146482bbe69259b25741e0aad71463864929.1661437397.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f960146482bbe69259b25741e0aad71463864929.1661437397.git.thomas.lendacky@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 09:23:14AM -0500, Tom Lendacky wrote:
> In advance of providing support for unaccepted memory, switch from using
> kmalloc() for allocating the Page State Change (PSC) structure to using a
> local variable that lives on the stack. This is needed to avoid a possible
> recursive call into set_pages_state() if the kmalloc() call requires
> (more) memory to be accepted, which would result in a hang.
> 
> The current size of the PSC struct is 2,032 bytes. To make the struct more
> stack friendly, reduce the number of PSC entries from 253 down to 64,
> resulting in a size of 520 bytes. This is a nice compromise on struct size
> and total PSC requests while still allowing parallel PSC operations across
> vCPUs.
> 
> If the reduction in PSC entries results in any kind of performance issue
> (that is not seen at the moment), use of a larger static PSC struct, with
> fallback to the smaller stack version, can be investigated.

"For more background info on this decision see the subthread in the Link
tag below."

> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>

Link: https://lore.kernel.org/lkml/658c455c40e8950cb046dd885dd19dc1c52d060a.1659103274.git.thomas.lendacky@amd.com

> ---
>  arch/x86/include/asm/sev-common.h |  9 +++++++--
>  arch/x86/kernel/sev.c             | 10 ++--------
>  2 files changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
> index b8357d6ecd47..6c3d61c5f6a3 100644
> --- a/arch/x86/include/asm/sev-common.h
> +++ b/arch/x86/include/asm/sev-common.h
> @@ -106,8 +106,13 @@ enum psc_op {
>  #define GHCB_HV_FT_SNP			BIT_ULL(0)
>  #define GHCB_HV_FT_SNP_AP_CREATION	BIT_ULL(1)
>  
> -/* SNP Page State Change NAE event */
> -#define VMGEXIT_PSC_MAX_ENTRY		253
> +/*
> + * SNP Page State Change NAE event
> + *   The VMGEXIT_PSC_MAX_ENTRY determines the size of the PSC structure,
> + *   which is a local variable (stack usage) in set_pages_state(). Do not

... which is a local stack variable...


> + *   increase this value without evaluating the impact to stack usage.
> + */
...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

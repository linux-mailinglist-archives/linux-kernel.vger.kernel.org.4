Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A8F616B7E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 19:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbiKBSFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 14:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiKBSFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 14:05:04 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80152F003;
        Wed,  2 Nov 2022 11:05:02 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e741329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e741:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4DC3C1EC0430;
        Wed,  2 Nov 2022 19:05:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1667412301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Ep4poWzvh4BEAYAVPV+8HNyluMMUvJCMlgTBWwttbq0=;
        b=E7zQs/NLK4edogyboQinsYMbiq0yAOWPRwhBwjaS6EBtShq9AEdpxQAXzpjC7wAPDRri/v
        os5dLBrfulfFNGLIEBtiV380bLKXXMyMBMcaiAQIeV/cMy8kacpfhCExGiQL83e584TlbM
        PnOtnsh2KH1ZCKTOplCG+qmgfO5IvJQ=
Date:   Wed, 2 Nov 2022 19:04:56 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5 00/16] x86: make PAT and MTRR independent from each
 other
Message-ID: <Y2KxSGWllUPTikJv@zn.tnic>
References: <20221102074713.21493-1-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221102074713.21493-1-jgross@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 08:46:57AM +0100, Juergen Gross wrote:
> Today PAT can't be used without MTRR being available, unless MTRR is at
> least configured via CONFIG_MTRR and the system is running as Xen PV
> guest. In this case PAT is automatically available via the hypervisor,
> but the PAT MSR can't be modified by the kernel and MTRR is disabled.
> 
> The same applies to a kernel built with no MTRR support: it won't
> allow to use the PAT MSR, even if there is no technical reason for
> that, other than setting up PAT on all CPUs the same way (which is a
> requirement of the processor's cache management) is relying on some
> MTRR specific code.
> 
> Fix all of that by:

One of the AMD test boxes here says with this:

...
[    0.863466] PCI: not using MMCONFIG
[    0.863475] PCI: Using configuration type 1 for base access
[    0.863478] PCI: Using configuration type 1 for extended access
[    0.866733] mtrr: your CPUs had inconsistent MTRRdefType settings
[    0.866737] mtrr: probably your BIOS does not setup all CPUs.
[    0.866740] mtrr: corrected configuration.
[    0.869350] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
...

Previous logs don't have it:

PCI: not using MMCONFIG
PCI: Using configuration type 1 for base access
PCI: Using configuration type 1 for extended access
kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

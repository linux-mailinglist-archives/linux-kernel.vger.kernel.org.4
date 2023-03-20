Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A046C2227
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 21:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjCTUED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 16:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjCTUDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 16:03:55 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D6B2C65F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 13:03:29 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8A83E1EC0662;
        Mon, 20 Mar 2023 21:03:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1679342605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=j7BL55I3olKSqKJW0AnrPo9QCKzyCC02VNxTOw5HY70=;
        b=Zdu7EtHsR5XtTBgjpNoVfdsD0lIobxNtI7bzNovHW3ExQJrfCzvc6RYJ3oWCz3R3ZJL0Vw
        GTfMuLyHzTJIs63Vvr2xt1v5jxTOKR8tIjC5qQBMWhIsDTSimT1Zvi5x2ddOFNUQlQap/2
        eBKeGUWIdzV9tl9RPlPiaBN216GnEgI=
Date:   Mon, 20 Mar 2023 21:03:21 +0100
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
Message-ID: <20230320200321.GDZBi8CXCyE6kD7qSN@fat_crate.local>
References: <20230320191956.1354602-1-jpiotrowski@linux.microsoft.com>
 <20230320191956.1354602-4-jpiotrowski@linux.microsoft.com>
 <20230320192504.GCZBizEGDjVtGWpNP3@fat_crate.local>
 <6d3d512b-55e9-8205-461c-02f1e71f2b63@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6d3d512b-55e9-8205-461c-02f1e71f2b63@linux.microsoft.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 08:37:56PM +0100, Jeremi Piotrowski wrote:
> Because of patch 4. My thinking was that the irq setup requires poking
> at intimate architectural details (init_irq_alloc_info etc.) so it seems
> like it fits in arch/x86.

arch/x86/platform/uv/uv_irq.c:193:      init_irq_alloc_info(&info, cpumask_of(cpu));
drivers/iommu/amd/init.c:2391:  init_irq_alloc_info(&info, NULL);

Also, what patch 4's commit message says, sounds hacky to me. A simple
driver should not need the x86_vector_domain. Especially if it is some
ACPI wrapper around the PSP hw.

But I'd leave that to tglx.

> I also drew inspiration from the sev-guest device in the arch/x86/kernel/sev.c,

Yeah, we've designed another mess there considering we already have

drivers/virt/coco/sev-guest/sev-guest.c

That sev guest thing has no place in sev.c and it should go away from
there.

> which is used in a similar context (the PSP device I am registering here is
> for SNP-host support).
> 
> Would you prefer it in drivers/platform/x86?

drivers/hv/?

Seeing how hyperv is the only thing that's going to use it, AFAICT.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD586C6DC8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 17:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbjCWQgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 12:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbjCWQgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 12:36:24 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674C436448;
        Thu, 23 Mar 2023 09:34:59 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 809A61EC0666;
        Thu, 23 Mar 2023 17:34:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1679589295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=4sg0gkB9DRPOhlMDZ3zP/dpFav3wNu5TRPV6O3JS84Q=;
        b=FyrzPcj0DL33qZdewBbLEPpJ1DHFdxbWP3v7Wcce+2+bLo4VhNzy7gZuttjXvFk7hZBOCS
        ecsQYvzGAW+GdThqAEiKjSgEyu7kLtpNulEsxpV4BP5pH+8qhkKW+Wkp7UdWzULXSTsFwb
        Y4qa5WnyTodkPt4/nRMIX5Ka24ZQZJI=
Date:   Thu, 23 Mar 2023 17:34:50 +0100
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
Message-ID: <20230323163450.GGZBx/qpnclFnMaf7e@fat_crate.local>
References: <20230320191956.1354602-1-jpiotrowski@linux.microsoft.com>
 <20230322154655.GDZBsi75f6LnQStxSp@fat_crate.local>
 <1d25221c-eaab-0f97-83aa-8b4fbe3a53ed@linux.microsoft.com>
 <20230322181541.GEZBtFzRAMcH9BAzUe@fat_crate.local>
 <ecf005b1-ddb9-da4c-4526-28df4806426c@linux.microsoft.com>
 <20230323152342.GFZBxu/m3u6aFUDY/7@fat_crate.local>
 <105d019c-2249-5dfd-e032-95944ea6dc8c@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <105d019c-2249-5dfd-e032-95944ea6dc8c@linux.microsoft.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 05:11:26PM +0100, Jeremi Piotrowski wrote:
> That same interface is exposed by physical hardware+firmware to the underlying
> Hyper-V.

Let me see if I understand it correctly: Hyper-V *baremetal* is using
the same ASPT spec to to talk to the *physical* PSP device?

Is that ASPT interface to talk to the PSP used by the L0 hypervisor?

Or does the L0 HV have a normal driver, similar to the Linux one,
without the functionality this ASPT spec provides?

> So it wasn't a matter of Microsoft architects coming up with a
> guest-host interface but rather exposing the virtual hardware in the same
> way as on a physical server.

So if you want to expose the same interface to the L1 guest, why isn't
Hyper-V emulating an ACPI device just like any other functionality? Why
does it need to reach into the interrupt handling internals?

I'd expect that the L0 HV would emulate a PSP device, the L1 would
simply load the Linux PSP device driver and everything should just work.

What's the point of that alternate access at all?

But I might still be missing something...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

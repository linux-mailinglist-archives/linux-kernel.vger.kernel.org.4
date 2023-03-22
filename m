Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBBFC6C5372
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 19:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjCVSQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 14:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjCVSQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 14:16:10 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8C9664FD;
        Wed, 22 Mar 2023 11:15:47 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6B0921EC01A9;
        Wed, 22 Mar 2023 19:15:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1679508945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=2ORkR6RJSrqaTM/Wmsze7uUB1vZ0g8AFPgDJBNyMQSk=;
        b=kzwFWBuzi5GUFafB7dXy2IlK9aTob3kBQXJEZfppmdLlJg+3sJ1kxS+aC5C14V21aBLEtX
        HglOR+mb1ldzDxCYgDqOh6okUSdmQdHMsSylF5k32kkESrioEBSJQ/tSXqPQLgha6/LRh+
        +o9yTzMJIeULfIMagZ5DzYbLvb2fgRo=
Date:   Wed, 22 Mar 2023 19:15:41 +0100
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
Message-ID: <20230322181541.GEZBtFzRAMcH9BAzUe@fat_crate.local>
References: <20230320191956.1354602-1-jpiotrowski@linux.microsoft.com>
 <20230322154655.GDZBsi75f6LnQStxSp@fat_crate.local>
 <1d25221c-eaab-0f97-83aa-8b4fbe3a53ed@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1d25221c-eaab-0f97-83aa-8b4fbe3a53ed@linux.microsoft.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 06:33:37PM +0100, Jeremi Piotrowski wrote:
> What this does is it allows a normal (non-SNP) VM to host confidential (SNP)
> VMs. I say "normal" but not every VM is going to be able to do this, it needs

If you say "non-SNP" VM then this sounds like purely for development.
Because I cannot see how you're going to give the confidentiality
guarantee to the SNP guests if the lower level is unencrypted, non-SNP
and so on...

> to be running on AMD hardware and configured to have access to
> VirtualizationExtensions, a "HardwareIsolation" capability, and given a number
> of "hardware isolated guests" that it is allowed to spawn. In practice this
> will result in the VM seeing a PSP device, SEV-SNP related CPUID
> leafs, and have access to additional memory management instructions
> (rmpadjust/psmash).  This allows the rest of the of KVM-SNP support to
> work.

So why don't you emulate the PSP in KVM instead of doing some BIOS hack?
And multiplex the access to it between all the parties needing it?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B37687912
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 10:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbjBBJkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 04:40:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbjBBJkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 04:40:41 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5669A234DE
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 01:40:39 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B39641EC0576;
        Thu,  2 Feb 2023 10:40:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1675330837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=6FGC6CLghQn+2SpEYgFIHdFtvjpe1yGQBTwxBAKzsXM=;
        b=ZBsUl31FeI+2iZEvY7iWGaCxNgEVOFtpjpQDu2zJ9W4OuOBjDCDSGEamIFnJwAIoqNJVWI
        dN5STwTZEVdK7tYVZ7HtSRV8Y92rZVlcYUdm2kGnszJz4FJU6UIkJq9+eZ1Z8BI2zZ7BjJ
        x3fc7aNhKO3Gz7KfmERkqf5HUHUsNFs=
Date:   Thu, 2 Feb 2023 10:40:31 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Stefan Talpalaru <stefantalpalaru@yahoo.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Peter Zilstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Martin Pohlack <mpohlack@amazon.de>
Subject: Re: [Patch v3 Part2 4/9] x86/microcode: Do not call
 apply_microcode() on sibling threads
Message-ID: <Y9uFD1PQoq0Ktaol@zn.tnic>
References: <20230130213955.6046-1-ashok.raj@intel.com>
 <20230130213955.6046-5-ashok.raj@intel.com>
 <bfd85699-4b7a-c606-266a-cea7ff336950@intel.com>
 <Y9rqeqMjDOYJKmLZ@zn.tnic>
 <Y9skuAuxozZLDrGB@a4bf019067fa.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y9skuAuxozZLDrGB@a4bf019067fa.jf.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 06:51:44PM -0800, Ashok Raj wrote:
> T1 shouldn't be sent down the apply_microcode() path, but instead
> just gather and update the per-cpu info reflecting the current revision.

As I said previously, it doesn't apply the microcode but simply updates
the cached info. The assumption was that T0 would not fail.

> At wait_for_siblings: Each thread can check their rev against the BSP (yes
> BSP can be removed, but we can elect a core leader) and if they are

A core leader?

The one who succeeded in doing the update?

> different we can either warn/taint or pull the plug and panic.

What about SMT=off? How are you gonna handle that? Who's the core leader
there?

What about the other vendor? That hackery of yours needs to be verified
there too.

So this whole deal needs to be analyzed properly. What would happen in
any potential outcome, how should the kernel behave in each case, etc,
etc.

In thinking about the minrev, I can just as well imagine that such
microcode patches which could cause such a failure should be marked and
not loaded late either. But I'm sure you don't want that.

In any case, without a proper analysis and writeup how that new
algorithm is going to look like and behave, this is not going anywhere.
No ad-hoc patches, no let's fix that aspect first.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

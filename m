Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE97687119
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 23:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjBAWlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 17:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjBAWlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 17:41:08 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B615A2A982
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 14:41:03 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2EDE21EC0589;
        Wed,  1 Feb 2023 23:41:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1675291262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=AyoeuwBBM2ackjOZrWChwx5x8HGPUXUVlBJUm7ryOIQ=;
        b=H6p+CSnDVJIG8Rcs6jgZYfWmN5r1SIQu0HHp2v1Qwl0Ewz7VEdGYK8lb4iSg/OrshD3B/d
        gtoloum+s15DxutSxn3N1geAnRGoafllZ+/nmOHXLsq+giKRI5S5Hduelgo0J2T7lRj8hm
        urKR/BPKEqSyND5XyqjXfKSBu2/S5Ok=
Date:   Wed, 1 Feb 2023 23:40:58 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Ashok Raj <ashok.raj@intel.com>,
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
Message-ID: <Y9rqeqMjDOYJKmLZ@zn.tnic>
References: <20230130213955.6046-1-ashok.raj@intel.com>
 <20230130213955.6046-5-ashok.raj@intel.com>
 <bfd85699-4b7a-c606-266a-cea7ff336950@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bfd85699-4b7a-c606-266a-cea7ff336950@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 02:21:18PM -0800, Dave Hansen wrote:
> That works great, unless T0 experiences an error.  In that case, T0 will
> jump out of __reload_late() after failing to do the update.  T1 will
> come bumbling along after it and will enter ->apply_microcode(),
> blissfully unaware of T0's failure.  T1 will assume that it is supposed
> to do T0's job, noting "rev < mc->hdr.rev".  T1 will write the MSR while
> T0 is off doing god knows what.
> 
> T1 should not even be attempting to do ->apply_microcode() because T0 is
> not quiescent.

Yah, thanks for explaining properly.

So, if T0 fails, then we will say that it failed. The ->apply_microcode()
call on T1 was never meant to apply any microcode - just to update the
cached data.

Now, if T0 fails, then it doesn't matter what T1 does - you have a
bigger problem:

A subset of the cores is running with new microcode while other subset
with the old one. Now this is a shit situation I don't want to be in.

And I don't have a good way out of it.

Revert to the old patch? Maybe...

Retry to application on all again with the hope that it works this time?

What if some core touches a MSR being added with the new microcode
patch?

Late loading is a big PITA. As we've been preaching for a while now.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

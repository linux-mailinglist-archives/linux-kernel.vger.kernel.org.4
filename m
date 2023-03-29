Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84966CD7CC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 12:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjC2Kjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 06:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjC2Kjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 06:39:51 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653BD2135
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 03:39:50 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CB9541EC064E;
        Wed, 29 Mar 2023 12:39:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1680086387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tBSgGfmxjj+m3c/5I3P3uRFAoHIgEnW4i2QN89gLAaM=;
        b=TgHvjHxwrt5zuFHJnf9uk1q+uCoTX+OqzahzTwsN5BUH7r4Px2PdGytyCsrqWWQN7n7DgH
        s+AKg/CTDvtoYjVQEcqok53KtHcjdhwZVOuDRBVok1oB6f5MnxH1Bng9dbKguQ6ZUZaICe
        u0WghcTF6AVbVoPCiqysGMRttBen+Vg=
Date:   Wed, 29 Mar 2023 12:39:43 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Gabriel David <ultracoolguy@disroot.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David R <david@unsolicited.net>,
        Kishon Vijay Abraham I <kvijayab@amd.com>
Subject: Re: Panic starting 6.2.x and later 6.1.x kernels
Message-ID: <20230329103943.GAZCQVb1n3tKlGOAWI@fat_crate.local>
References: <943d2445-84df-d939-f578-5d8240d342cc@unsolicited.net>
 <20230327074952.GAZCFKoDOiJUdtse2H@fat_crate.local>
 <e8d15248-e694-79d7-da9c-b4485b471e14@unsolicited.net>
 <4c660f0f-2845-0e02-ccf9-619958e24236@unsolicited.net>
 <20230328142014.GCZCL3nkW5Qx5jhfsB@fat_crate.local>
 <57385475-c289-356f-d696-fc6decce1390@unsolicited.net>
 <20230328171057.GDZCMfobguhGUFiUuh@fat_crate.local>
 <9ed16be4-051d-c20f-0410-b8a973c4c09e@disroot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ed16be4-051d-c20f-0410-b8a973c4c09e@disroot.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 09:26:16PM -0400, Gabriel David wrote:
> 
> On 3/28/23 1:10 PM, Borislav Petkov wrote:
> > On Tue, Mar 28, 2023 at 04:06:41PM +0100, David R wrote:
> > > Yes, that patch fixes it also. By all means add my tested by:
> > Ok, thanks for checking. That issue is still weird, tho, and we don't have
> > an idea why that happens.
> > 
> > If you could test your original, failing kernel with "nointremap" on the
> > command line, that would be cool.
> > 
> > Thx.
> > 
> I have the same problem, and while I haven't tested the commit you mentioned
> earlier, `nointremap` on the failing kernels(6.1.x and 6.2.3) worked.
> 
> So far, apart from this mail thread I've found this reddit thread with the
> issue https://reddit.com/r/archlinux/comments/11ux6uh/stuck_at_loading_initial_ramdisk/
> , and to them updating the BIOS worked. However, to me it didn't. Another
> thing is that David, that person, and me all use 1st gen Ryzen processors(in
> my case, a Ryzen 3 1200).

Yeah, this looks like something's borked with interrupt remapping and
timer interrupt when the code looks at that online capable bit. I guess
interrupt remapping doesn't consider that bit and still remaps to cores
which are now *not* onlined, leading to the panic.

But this is all conjecture of me trying to connect the IO-APIC
observation to this online capable bit.

And, ofcourse, I cannot trigger it:

[    0.000000] Linux version 6.1.21 (root@epic) (gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2) #1 SMP PREEMPT_DYNAMIC Wed Mar 29 12:00:57 CEST 2023

...

[    0.200425] smpboot: CPU0: AMD EPYC 7251 8-Core Processor (family: 0x17, model: 0x1, stepping: 0x2)

...

[    4.019751] AMD-Vi: Interrupt remapping enabled

So it looks like only some Zen1 client BIOSes are b0rked. Which is
swell, again. ;-\

But let's wait for tglx to look at this first.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

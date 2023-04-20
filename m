Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E6C6E9544
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 15:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjDTNBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 09:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbjDTNBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 09:01:49 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74458659C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 06:01:22 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B1CEA1EC06C2;
        Thu, 20 Apr 2023 15:01:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1681995677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QjWL/zhXWpEzlbncFEwoeOSesexCvyPfRE2spJ0wCgE=;
        b=j6TvHP3b2qkVisBAfO5iruIsC0kUlasyxImTHLUykYHcXnIU7jwH8pgb3JKkwDWWtIjz1M
        ABEvL43pn/d9jC3qLwFu87PGkHOYHLALR3Poy3i/M6hfjxx/yECYks+H2GbAPnCbWTMNgg
        kJKsTa9UOBmY+mKQKPQmntvCqPM42HE=
Date:   Thu, 20 Apr 2023 15:01:13 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH v5 11/15] x86/mtrr: construct a memory map with cache
 modes
Message-ID: <20230420130113.GCZEE3mfOTxcDn6e3/@fat_crate.local>
References: <20230401063652.23522-1-jgross@suse.com>
 <20230401063652.23522-12-jgross@suse.com>
 <20230420121551.GMZEEs9wkUrvX05nQr@fat_crate.local>
 <d164d84b-6773-36e3-1136-672072e9233d@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d164d84b-6773-36e3-1136-672072e9233d@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 02:30:09PM +0200, Juergen Gross wrote:
> OTOH the additional compare to 0 has costs, too, and this cost is spent for
> ALL calls

I'll take the cost of a single

	cmpl    %edi, %edx

for a handful of entries any day of the week.

> while the zero size call is a rather rare case.

$ grep "memmove size" /tmp/mtrr.txt
memmove size 0
memmove size 0
memmove size 0
memmove size 0
memmove size 0
memmove size 0
memmove size 0
memmove size 0
memmove size 0
memmove size 0
memmove size 0

for - I admit a largely contrived map - but 5 entries only:

Current map:
0: start: 0x0000000000000000, end: 0x0000000000100000, type: 0x0
1: start: 0x0000000100000000, end: 0x0000000820000000, type: 0x6
2: start: 0x000050d70000c000, end: 0x000062a60000c000, type: 0x4
3: start: 0x000062a60000c000, end: 0x0001d6d200001000, type: 0x0
4: start: 0x0001d6d200001000, end: 0x0001dd8100001000, type: 0x6

> Regarding "cache_map + idx + 1 is not valid": the standard clearly points
> out that a call with size 0 is valid and won't copy anything

That's not what I meant. Please read again what I said:

"I wouldn't want it getting prefetched from %rsi in the hw when there's
no reason for it".

IOW, I don't want to put invalid values in hw registers if I can. Think
hw mitigations and *very* hungry prefetchers.

> > Current map:
> > 0: start: 0x0000000000000000, end: 0x0000000000100000, type: 0x0
> > 1: start: 0x0000000100000000, end: 0x0000000820000000, type: 0x6
> > 2: start: 0x000002f10000c000, end: 0x000003bf0000c000, type: 0x2
> > 3: start: 0x000003bf0000c000, end: 0x00019fc000001000, type: 0x0
> > 4: start: 0x00019fc000001000, end: 0x0001df2d00001000, type: 0x2
> 
> The map would reflect hardware behavior. Type 0 wins in case of overlapping
> MTRRs.

Type 0 is MTRR_TYPE_UNCACHABLE, 1 is MTRR_TYPE_WRCOMB.

"Uncacheable (UC)—Reads from, and writes to, UC memory are not cacheable. Reads from UC
memory cannot be speculative. Write-combining to UC memory is not
allowed."

That last sentence.

So if you have conflicting regions and one is WC but then something is
expecting it to be UC and that something doesn't want for it to
*especially* to be WC because it should not combine writes to it, then
that clearly is a misconfiguration, I'd say.

> Now this is another requirement, right? Today's MTRR code wouldn't scream
> either.

So are we fixing this right or only a little?

> At least we don't correct such mistakes today. Do you think we should change
> that?

I'm thinking considering how often we've seen all those error messages
from mtrr_state_warn(), we should at least warn when we encounter
inconsistencies.

This won't help with released BIOSes but it will help when they do new
BIOS verification and see those messages. People do use Linux for that
a lot and then they'll definitely look and address them.

And this is a pretty good goal to have, IMO.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

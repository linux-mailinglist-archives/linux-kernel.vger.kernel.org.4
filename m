Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A31A6538F2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 23:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiLUWoY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 21 Dec 2022 17:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiLUWoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 17:44:22 -0500
X-Greylist: delayed 521 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 21 Dec 2022 14:44:19 PST
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3048B1DA42
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 14:44:19 -0800 (PST)
Received: by cae.in-ulm.de (Postfix, from userid 1000)
        id EDFBF140119; Wed, 21 Dec 2022 23:35:36 +0100 (CET)
Date:   Wed, 21 Dec 2022 23:35:36 +0100
From:   "Christian A. Ehrhardt" <lk@c--e.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rishabh Agrawal <rishabhagr@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, len.brown@intel.com,
        drake@endlessm.com, rafael.j.wysocki@intel.com, mingo@redhat.com,
        vaibhav.shankar@intel.com, biernacki@google.com,
        zwisler@google.com, mattedavis@google.com,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [PATCH v2] Add hardcoded crystal clock for KabyLake
Message-ID: <Y6OKOI5QhPws0wgY@cae.in-ulm.de>
References: <20221018190124.v2.1.I918ccc908c5c836c1e21e01d2cf6f59b0157bcc3@changeid>
 <Y1GBtjcetPpTq0V3@hirez.programming.kicks-ass.net>
 <3d65c4cc-c002-9e6a-c6ea-fd776968a178@intel.com>
 <87y1sdqh1t.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <87y1sdqh1t.ffs@tglx>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On Mon, Nov 14, 2022 at 11:58:54PM +0100, Thomas Gleixner wrote:
> On Thu, Oct 20 2022 at 10:18, Dave Hansen wrote:
> > On 10/20/22 10:13, Peter Zijlstra wrote:
> >> And why, pray *WHY* can't Intel simply write the correct information in
> >> CPUID leaf 15h. I mean, they defined the leaf, might as well use it, no?
> >
> > Is the data that's in the leaf just wrong?  Doesn't that mean that the
> > CPUID leaf on these models is violating the architecture contract?  That
> > sounds like something that deserves an erratum.
> >
> > Is there a documented erratum?
> 
> I don't know. The code has this comment:
> 
> 	/*
> 	 * Some Intel SoCs like Skylake and Kabylake don't report the crystal
> 	 * clock, but we can easily calculate it to a high degree of accuracy
> 	 * by considering the crystal ratio and the CPU speed.
> 	 */

Latest (April 2022) version of the SDM clearly states that the
above comment is wrong. CPUID.16h has the following note:
| Data is returned from this interface in accordance with the processor's
| specification and does not reflect actual values. Suitable use of this
| data includes the display of processor information in like manner to the
| processor brand string and for determining the appropriate range to use
| when displaying processor information e.g. frequency history graphs. The
| returned information should not be used for any other purpose as the
| returned information does not accurately correlate to information /
| counters returned by other processor interfaces.

Thus using CPUID.16h to determine the crystal clock frequency is wrong.
This difference is significant. I have one Kaby Lake latop where
the CPUID.16h reported frequency is 1900MHz but the real frequency is
only 1896MHz. This amounts to a time drift of about 8s/hour if the
wrong TSC frequency is used for time keeping.

Basically, I think this commit:
    604dc9170 (x86/tsc: Use CPUID.0x16 to calculate ...)
needs to be reverted.

> so those SoCs fail to expose clock in leaf 15h and then the information
> in leaf 16h is so inaccurate that the calculation is off.
> 
> Sigh. It's 2022 and we are still relying on crystalball mechanisms to
> figure out the damned crystal frequency.
> 
> The specification of leaf 15h is:
> 
>  15H Time Stamp Counter and Nominal Core Crystal Clock Information Leaf
>     NOTES:
>         If EBX[31:0] is 0, the TSC/”core crystal clock” ratio is not enumerated.
>         If ECX is 0, the nominal core crystal clock frequency is not enumerated.
> 
> IOW, this CPUID leaf is defined to be useless and leaves it up to the
> SoC integration to provide this information or not. It needs even two
> fields to chose from to make it useless...

The SDM (now?) has some hints on how to do this. This is hidden here:

    Vol.3 Chapter 19.7.3: Determining the Processor Base Frequency

This chapter contains a table that lists the correct crystal clock
frequencies for CPU models that do not enumerate it via CPUID.15h.

       regards   Christian


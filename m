Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590A0628C78
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 23:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237175AbiKNW7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 17:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbiKNW67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 17:58:59 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847BBC6D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 14:58:57 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668466735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bTCG1rDtKqy4ty/EtEDL8A4i7E+B7a65O4CepWGQnbs=;
        b=v53eJxqNiXGqKvpzUOoBVsteVAkiuvKAmVazj92d5eC7XojYHobOgg4xmhxQLRDhgkpXOf
        p/sYt/XI9PQGPjR/TqMSIyztyM52NTEpK4gq86qlh8b2e38IvjNY5i1ffkc//oSXR0pF1g
        MStioU6epUv/jXsgiY5mSxj6XQ7F1KE/GDYwCL/N3qHHE5Cjm53nhJNDt0X18iCJpIcN0r
        fa6GfzPUuxRQahvy2FfbDkopFv6+6LLpnwLDU4afeEerY9eHEoT7cELT3E55WA7AKHYGZJ
        bGGu98oq/W3QlfkgNIqhW0UM7FSXhii20SSeIeC9iq7EmLUrGQIZLDPdj+kgbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668466735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bTCG1rDtKqy4ty/EtEDL8A4i7E+B7a65O4CepWGQnbs=;
        b=CvfiFiDmAK8NM7gnvQaNAymBR049omgLnwF+E1xLcu/fQllDBFuRS0WWbP1Nh/J4E4LlVn
        Zqcm4q007w9gHrAA==
To:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rishabh Agrawal <rishabhagr@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, len.brown@intel.com,
        drake@endlessm.com, rafael.j.wysocki@intel.com, mingo@redhat.com,
        vaibhav.shankar@intel.com, biernacki@google.com,
        zwisler@google.com, mattedavis@google.com,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [PATCH v2] Add hardcoded crystal clock for KabyLake
In-Reply-To: <3d65c4cc-c002-9e6a-c6ea-fd776968a178@intel.com>
References: <20221018190124.v2.1.I918ccc908c5c836c1e21e01d2cf6f59b0157bcc3@changeid>
 <Y1GBtjcetPpTq0V3@hirez.programming.kicks-ass.net>
 <3d65c4cc-c002-9e6a-c6ea-fd776968a178@intel.com>
Date:   Mon, 14 Nov 2022 23:58:54 +0100
Message-ID: <87y1sdqh1t.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20 2022 at 10:18, Dave Hansen wrote:
> On 10/20/22 10:13, Peter Zijlstra wrote:
>> And why, pray *WHY* can't Intel simply write the correct information in
>> CPUID leaf 15h. I mean, they defined the leaf, might as well use it, no?
>
> Is the data that's in the leaf just wrong?  Doesn't that mean that the
> CPUID leaf on these models is violating the architecture contract?  That
> sounds like something that deserves an erratum.
>
> Is there a documented erratum?

I don't know. The code has this comment:

	/*
	 * Some Intel SoCs like Skylake and Kabylake don't report the crystal
	 * clock, but we can easily calculate it to a high degree of accuracy
	 * by considering the crystal ratio and the CPU speed.
	 */

so those SoCs fail to expose clock in leaf 15h and then the information
in leaf 16h is so inaccurate that the calculation is off.

Sigh. It's 2022 and we are still relying on crystalball mechanisms to
figure out the damned crystal frequency.

The specification of leaf 15h is:

 15H Time Stamp Counter and Nominal Core Crystal Clock Information Leaf
    NOTES:
        If EBX[31:0] is 0, the TSC/=E2=80=9Dcore crystal clock=E2=80=9D rat=
io is not enumerated.
        If ECX is 0, the nominal core crystal clock frequency is not enumer=
ated.

IOW, this CPUID leaf is defined to be useless and leaves it up to the
SoC integration to provide this information or not. It needs even two
fields to chose from to make it useless...

I'm sure this took 10+ draft versions and consumed a non-quantifiable
amount of work hours to come up with this joke.

Thanks,

        tglx

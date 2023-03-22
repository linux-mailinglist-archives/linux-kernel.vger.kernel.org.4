Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5530A6C473D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 11:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjCVKHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 06:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjCVKHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 06:07:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7285A91A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 03:07:28 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679479646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lG0bDjgsBnv7wqrnYudcN24YDMczaF2W6JJRutRlr3M=;
        b=boTMti1+35NZXfd4LHzsrdUrgFOz98zqpOFkO92G7So56LRIfgTQIkaIw8DZaHpbNYG4Q7
        fJxL9rPk7xzMmLdLE3cclShwSEfNYbwJn/oSC6tfdwTVulilYQ0ma9yXWO4mIURRMHil5W
        1l27WBZlblMVFODjeF0nkg0AaH3Rrlogp1xLlE1fK22YIj7tI5Fqoc/PWhfdR49bXqU6D1
        MnfYU06DHBjCgd244x3534y61y3azmUm+8rIBIH5WtXQNUZKi9s9XsRRmGAmlfNrgZQBJF
        tX83ThXTCYxkyNTWckctYG5W50dBjtL9wL3Vc9jW/yWLQEc4Uq2Q81EakHDVbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679479646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lG0bDjgsBnv7wqrnYudcN24YDMczaF2W6JJRutRlr3M=;
        b=UrrQagkOOm6X4CG3bwpnpBrMbmaocZZKEKZ8C8wM9O+izc/FBp96O71P4vIyEwz40wBaG4
        Pf9r2Hb31MCkc8CA==
To:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        linux-kernel@vger.kernel.org
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Subject: Re: [PATCH v3 4/8] x86/psp: Add IRQ support
In-Reply-To: <89c227a5-0db6-7cbe-6beb-4035f58f036b@linux.microsoft.com>
References: <20230320191956.1354602-1-jpiotrowski@linux.microsoft.com>
 <20230320191956.1354602-5-jpiotrowski@linux.microsoft.com>
 <87h6ue9z0p.ffs@tglx>
 <89c227a5-0db6-7cbe-6beb-4035f58f036b@linux.microsoft.com>
Date:   Wed, 22 Mar 2023 11:07:25 +0100
Message-ID: <877cv99k0y.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21 2023 at 20:16, Jeremi Piotrowski wrote:
> On 21/03/2023 11:31, Thomas Gleixner wrote:
>  
>>  1) What's so special about this PSP device that it requires a vector
>>     directly from the vector domain and evades interrupt remapping?
>
> The PSP interrupt configuration requires passing an APIC id and interrupt
> vector that it will assert. The closest thing I found that provides me with
> those was the x86_vector_domain. Here's the link to the ACPI interface, the
> relevant info is on pages 13-15 (it's not very detailed, but that's all I
> had when implementing this):
> https://www.amd.com/system/files/TechDocs/58028_1.00-PUB.pdf

That seriously expects an (extended) APIC-ID so that firmware can fiddle
with X2APIC ICR directly.

Why can't firmware people just use something which is properly
manageable by the OS, e.g. a MSI message or something like the ACPI
interrupt? Because that would just be too useful and not require
horrible hacks.

So my initial suggestion to piggy pack that on device MSI is moot. Let
me think about it.

Thanks,

        tglx



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B5470C125
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 16:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbjEVObd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 10:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjEVObb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 10:31:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5518190
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 07:31:30 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684765889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iYDW733hJIeeOooHbA6x84SGWsyTpt47+lA6eSUi1AM=;
        b=lzfAvHoUl5urqocmKpGWL8jKqSVMhUy0daK+TiSM26lrffmhqAm2mZUG9I1tLYlmjLPDiM
        7YMhVzAS3KPHu9iXgRGRpwfyrgitEZ6deFBwvn1T7Kz/HFaONsfvm1sIOfDdeGXnc4x3He
        8wn7A5I0ZQeUWFa/DKYkdIba7HiU52ru3eWwElWJb9rGngv5nIp0Ok04ki6Nljy0D/PFgb
        o573Ih7PkDzAC4TiExxrv+btwBYSMuMmZL6dGD9fjEn6hxHyarrMsxVkiBY3PePIElOsL0
        Ctd+2wDbHkZAM+SA3+yKX69OmrU3EF4SCyU25TXYiALNdYUzU1E+VJdYo0tgmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684765889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iYDW733hJIeeOooHbA6x84SGWsyTpt47+lA6eSUi1AM=;
        b=f/QSi0VrkBcs9Pp+ofaXf7SWL8FSgjv1cj7Qd5eEQz+p2jipJYWsizA3YVQx3TM6S15r4d
        dit1c4E+IxjKjZAQ==
To:     Feng Tang <feng.tang@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, paulmck@kernel.org,
        rui.zhang@intel.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] x86/tsc: Make recalibration default on for
 TSC_KNOWN_FREQ cases
In-Reply-To: <ZGtnUQJy+1Nrazhy@feng-clx>
References: <20230522033018.1276836-1-feng.tang@intel.com>
 <87h6s4ye9b.ffs@tglx> <ZGssENXFKmOk/zL7@feng-clx> <87zg5wwppa.ffs@tglx>
 <ZGtnUQJy+1Nrazhy@feng-clx>
Date:   Mon, 22 May 2023 16:31:28 +0200
Message-ID: <87pm6swi7z.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22 2023 at 21:00, Feng Tang wrote:
> On Mon, May 22, 2023 at 01:49:53PM +0200, Thomas Gleixner wrote:
>> > Paul and Rui can provide more info. AFAIK, those problems were raised
>> > by external customers, so the platform were already shipped from
>> > Intel. But I'm not sure they are commercial versions or early
>> > engineering drops. 
>> 
>> So its at a company which knows how to update firmware, right?
>
> Yes. And the recalibration may help to exposed the bug quickly.

That should be exposed _before_ crappy firmware is shipped and
validation can use the command line parameter. I'm tired of this
constant source of embarrassing stupidity. It's not rocket science to
catch this before shipping.

And guess what. Making this easy to recover from is just not making the
situation any better because firmware people will even care less.

>> and five lines further down:
>> 
>> 	/*
>> 	 * For Atom SoCs TSC is the only reliable clocksource.
>> 	 * Mark TSC reliable so no watchdog on it.
>> 	 */
>> 	if (boot_cpu_data.x86_model == INTEL_FAM6_ATOM_GOLDMONT)
>> 		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
>> 
>> So its reliable and needs recalibration against hardware which does not
>> exist.
>
> I misunderstood it. When you said 'SOCs which lack legacy hardware',
> I thought you were referring those old Merrifield/Medfield things,
> which may have no HPET/ACPI PM_Timer but an APB timer, and mainly go
> through MSR way (tsc_msr.c) for TSC frequency.
>
> In this native_calibrate_tsc(), which touches the INTEL_FAM6_ATOM_GOLDMONT
> and INTEL_FAM6_ATOM_GOLDMONT_D, I dug out one Apollo Lake and one
> Denverton platform (which comply to those GOLDMNOT model), and they
> both have 'hpet' and 'acpi_pm' clocksource registered. 

So that comment is wrong and that commit log is from fantasy land?

  http://lkml.kernel.org/r/1479241644-234277-4-git-send-email-bin.gao@linux.intel.com

Clearly the left hand is not knowing what the right hand is doing.

Thanks,

        tglx

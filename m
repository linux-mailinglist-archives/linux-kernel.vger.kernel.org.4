Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44E76EE956
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 23:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236315AbjDYVFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 17:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbjDYVFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 17:05:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FBC16186
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 14:05:22 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682456720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/Sdjv3Ai9ptLiWZaNz2T3suf48vJO4ZwZ7Cn/JzuC8E=;
        b=mvlgltDQvuQGt+4zbdNyU2f18sFSfAhgBLjg0sTFaX3ByCueSGk+7SZd4fH6ECOYM+2ntc
        i5yQpEVrQVfag4W+hhc68Ek85RLHtkaiWmyPJqYe/d8P1d7fuXO2T5oqINMba6eFH8MdRL
        dJB+5JjwyzWalmm1RD3gDN5sy1Ox+4PI4D3UXHonN6F5ZHcZI3c2bq4ZohUg1LblN+Wj7s
        +QKIzfULBUojGy6amm1TK2srtPF7MKZFIC9j5l+bn9NVokZPFn/QcTzQHLwRl/TDmgVmKM
        iJAURwN85E9mY1lFTxx88wIvBSNxe72CPM/dMxmpBARqXbnuwBMSGMbsSQo2DQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682456720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/Sdjv3Ai9ptLiWZaNz2T3suf48vJO4ZwZ7Cn/JzuC8E=;
        b=cQl0lV2DqVUjgwDlYoU3pPAbLXKVavv7HkrgYDAoCP7X4bMMZGlvfd95EuDvJQTPqV8Tw3
        wFol969Vf6mMvZCg==
To:     Dave Hansen <dave.hansen@intel.com>,
        Tony Battersby <tonyb@cybernetics.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] x86/cpu: fix intermittent lockup on poweroff
In-Reply-To: <f5c7a104-d422-bd02-d361-e9e9f433d41d@intel.com>
References: <3817d810-e0f1-8ef8-0bbd-663b919ca49b@cybernetics.com>
 <f5c7a104-d422-bd02-d361-e9e9f433d41d@intel.com>
Date:   Tue, 25 Apr 2023 23:05:19 +0200
Message-ID: <87o7nbzn8w.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25 2023 at 13:03, Dave Hansen wrote:

> On 4/25/23 12:26, Tony Battersby wrote:
>> -	if (cpuid_eax(0x8000001f) & BIT(0))
>> +	if (c->extended_cpuid_level >= 0x8000001f &&
>> +	    (cpuid_eax(0x8000001f) & BIT(0)))
>>  		native_wbinvd();
>
> Oh, so the existing code is running into the
>
>> If a value entered for CPUID.EAX is higher than the maximum input
>> value for basic or extended function for that processor then the data
>> for the highest basic information leaf is returned
> behavior.  It's basically looking at BIT(0) of some random extended
> leaf.  Probably 0x80000008 based on your 'cpuid -r' output.

Right, accessing that leaf without checking whether it exists is wrong,
but that does not explain the hang itself.

The only consequence of looking at bit 0 of some random other leaf is
that all CPUs which run stop_this_cpu() issue WBINVD in parallel, which
is slow but should not be a fatal issue.

Tony observed this is a 50% chance to hang, which means this is a timing
issue.

Now there are two things to investigate:

  1) Does the system go south if enough CPUs issue WBINVD concurrently?

     That should be trivial to analyze by enforcing concurreny on a
     WBINVD in an IPI via a global synchronization bit or such

  2) The first thing stop_this_cpu() does is to clear its own bit in the
     CPU online mask.

     The CPU which controls shutdown/reboot waits for num_online_cpus()
     to drop down to one, which means it can proceed _before_ the other
     CPUs have actually reached HALT.

     That's not a new thing. It has been that way forever. Just the
     WBINVD might cause enough delay to create problems.

     That should be trivial to analyze too by just waiting on the
     control side for e.g 100ms after num_online_cpus() dropped down to
     one.

The patch itself is correct as is, but as it does not explain the
underlying problem. There is a real serious issue underneath.

Thanks,

        tglx


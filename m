Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52DBE6EFDF6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 01:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239903AbjDZXUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 19:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233605AbjDZXUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 19:20:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2110435B8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 16:20:47 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682551244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cqBwRcRpy9thQoaQTxzTLbqaPTLeGU5fbTtlKBNAtMg=;
        b=kDWWIM+7Yho7OD3rCwlwgqLCNrvwrOcCWXmvfQS5zFc4BylAMvvCwEyn10B4qKCCsduxO4
        FvfywsU+hgaaItxaESHPE99uZCfs2wL4AXJb54wqsy6dd+atJA1JoxjzMJBk4bAlrBmV/T
        /MYvOOVn2rBEP5/HRWMOPy/V6YmNw1TJcBgG+ExrWRMJZAE6oE8dOObLrs6NYBu0XUlsz4
        PFcn5ONZUX2M0lzn4f+s3kejDYEkT5cZUe2GmWTM4wULjJFhglPHzEgFv2mCNlnB4X2eC2
        WwSnRADSYm7sd5iCowC/PnGhM68LCX277NUAsoiZXjofPW9n0WB/BgT88mMU1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682551244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cqBwRcRpy9thQoaQTxzTLbqaPTLeGU5fbTtlKBNAtMg=;
        b=dGySTZ/hXuhXrnKl7e0OmQjcOuoTDXFDA+eIXTGTPw7lRa7tbbiPTxrY58+MtLJ1HKWHVT
        UrJJPQqCGFZqoXBQ==
To:     Andi Kleen <ak@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Tony Battersby <tonyb@cybernetics.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] x86/cpu: fix intermittent lockup on poweroff
In-Reply-To: <ZEmfYpOyyul4BaKP@tassilo>
References: <3817d810-e0f1-8ef8-0bbd-663b919ca49b@cybernetics.com>
 <f5c7a104-d422-bd02-d361-e9e9f433d41d@intel.com> <87o7nbzn8w.ffs@tglx>
 <5f8a9cb8-70cf-2a17-cfc4-cb31cb658de4@cybernetics.com>
 <87y1mey503.ffs@tglx>
 <ccf57fd2-45b8-1f1f-f46a-55d7f4c56161@cybernetics.com>
 <01a44722-931a-7aff-4f4b-75e78855beb1@amd.com>
 <25dd25d3-2db1-acf6-0814-9bb5bcd65bb9@intel.com>
 <469754ab-d8ec-168a-15c7-61045a880792@amd.com> <ZEmfYpOyyul4BaKP@tassilo>
Date:   Thu, 27 Apr 2023 01:20:43 +0200
Message-ID: <87a5yu5iyc.ffs@tglx>
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

Andi!

On Wed, Apr 26 2023 at 15:02, Andi Kleen wrote:
>> > > This is probably going to pull in a cache line and cause the problem the
>> > > native_wbinvd() is trying to avoid.
>> > 
>> > Is one _more_ cacheline really the problem?
>> 
>> The answer is it depends. If the cacheline ends up modified/dirty, then it
>> can be a problem.
>
> I haven't followed this all in detail, but if any dirty cache line a
> problem you probably would need to be sure that any possible NMI user
> (like perf or watchdogs) is disabled at this point, otherwise you could
> still get NMIs here. 
>
> I don't think perf currently has a mechanism to do that other
> than to offline the CPU.

stop_this_cpu()
  disable_local_APIC()
    apic_soft_disable()
      clear_local_APIC()
        v = apic_read(APIC_LVTPC);
        apic_write(APIC_LVTPC, v | APIC_LVT_MASKED);

So after that point the PMU can't raise NMIs anymore which includes the
default perf based NMI watchdog, no?

External NMIs are a different problem, but they kinda fall into the same
category as:

> Also there are of course machine checks and SMIs that could still happen, 
> but I guess there's nothing you could do about them.

Though external NMIs could be disabled via outb(0x70,...) if paranoid
enough. Albeit if there is an external NMI based watchdog raising the
NMI during this kexec() scenario then the outcome is probably as
undefined as in the MCE case independent of the SEV dirty cacheline
concern.

Thanks,

        tglx

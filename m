Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC97F6EF6F3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 16:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241125AbjDZO5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 10:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbjDZO5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 10:57:15 -0400
X-Greylist: delayed 672 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 26 Apr 2023 07:57:13 PDT
Received: from mail.cybernetics.com (mail.cybernetics.com [173.71.130.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9DF19BF
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 07:57:12 -0700 (PDT)
X-ASG-Debug-ID: 1682520357-1cf439121531ebf0001-xx1T2L
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with ESMTP id kWwyCpHnXbNTdvAX; Wed, 26 Apr 2023 10:45:57 -0400 (EDT)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cybernetics.com; s=mail;
        bh=tuyJ711SZk3ZehA7lomLERiA3j0L1IU9nvrG57ZvNjw=;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
        Content-Language:Subject:MIME-Version:Date:Message-ID; b=EDiZ3iYHi2rfBwa1tKkX
        wCBHWttUjpKO7wxty2BbvyGgAcT0Nz4xmG6iVRtaQ/CMZMYS+WslIjaFobsvcuY/w1moGJLugUp8g
        lwnf0MG8O+b2afxNLokRR1KSfYYm8H2Z/AwJT/l1Lu2ekIV1Sgeugb3V1dd6zMYAYF61HEq+Y0=
Received: from [10.157.2.224] (HELO [192.168.200.1])
  by cybernetics.com (CommuniGate Pro SMTP 7.1.1)
  with ESMTPS id 12591396; Wed, 26 Apr 2023 10:45:57 -0400
Message-ID: <5f8a9cb8-70cf-2a17-cfc4-cb31cb658de4@cybernetics.com>
Date:   Wed, 26 Apr 2023 10:45:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH RFC] x86/cpu: fix intermittent lockup on poweroff
Content-Language: en-US
X-ASG-Orig-Subj: Re: [PATCH RFC] x86/cpu: fix intermittent lockup on poweroff
To:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>
References: <3817d810-e0f1-8ef8-0bbd-663b919ca49b@cybernetics.com>
 <f5c7a104-d422-bd02-d361-e9e9f433d41d@intel.com> <87o7nbzn8w.ffs@tglx>
From:   Tony Battersby <tonyb@cybernetics.com>
In-Reply-To: <87o7nbzn8w.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Barracuda-Connect: UNKNOWN[10.10.4.126]
X-Barracuda-Start-Time: 1682520357
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 2934
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/23 17:05, Thomas Gleixner wrote:
> On Tue, Apr 25 2023 at 13:03, Dave Hansen wrote:
>
>> On 4/25/23 12:26, Tony Battersby wrote:
>>> -	if (cpuid_eax(0x8000001f) & BIT(0))
>>> +	if (c->extended_cpuid_level >= 0x8000001f &&
>>> +	    (cpuid_eax(0x8000001f) & BIT(0)))
>>>  		native_wbinvd();
>> Oh, so the existing code is running into the
>>
>>> If a value entered for CPUID.EAX is higher than the maximum input
>>> value for basic or extended function for that processor then the data
>>> for the highest basic information leaf is returned
>> behavior.  It's basically looking at BIT(0) of some random extended
>> leaf.  Probably 0x80000008 based on your 'cpuid -r' output.
> Right, accessing that leaf without checking whether it exists is wrong,
> but that does not explain the hang itself.
>
> The only consequence of looking at bit 0 of some random other leaf is
> that all CPUs which run stop_this_cpu() issue WBINVD in parallel, which
> is slow but should not be a fatal issue.
>
> Tony observed this is a 50% chance to hang, which means this is a timing
> issue.
>
> Now there are two things to investigate:
>
>   1) Does the system go south if enough CPUs issue WBINVD concurrently?
>
>      That should be trivial to analyze by enforcing concurreny on a
>      WBINVD in an IPI via a global synchronization bit or such
>
>   2) The first thing stop_this_cpu() does is to clear its own bit in the
>      CPU online mask.
>
>      The CPU which controls shutdown/reboot waits for num_online_cpus()
>      to drop down to one, which means it can proceed _before_ the other
>      CPUs have actually reached HALT.
>
>      That's not a new thing. It has been that way forever. Just the
>      WBINVD might cause enough delay to create problems.
>
>      That should be trivial to analyze too by just waiting on the
>      control side for e.g 100ms after num_online_cpus() dropped down to
>      one.
>
For test #1, I have never used IPI before, so I would have to look into
how to do that.  Or you could send me a patch to test if you still want
the test done.  But test #2 produced results, so maybe it is not necessary.

For test #2, I re-enabled native_wbinvd() by reverting the patch that I
sent, and then I applied the following patch:

diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index 375b33ecafa2..1a9b225c85b6 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -212,6 +212,7 @@ static void native_stop_other_cpus(int wait)
                        udelay(1);
        }
 
+       mdelay(100);
        local_irq_save(flags);
        disable_local_APIC();
        mcheck_cpu_clear(this_cpu_ptr(&cpu_info));

With that I got a successful power-off 10 times in a row.

Let me know if there is anything else I can test.

I will resend my patch later with a different description.

Tony Battersby
Cybernetics



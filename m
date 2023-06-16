Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC4C733668
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 18:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345097AbjFPQrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 12:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjFPQrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:47:18 -0400
X-Greylist: delayed 651 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 16 Jun 2023 09:47:16 PDT
Received: from mail.cybernetics.com (mail.cybernetics.com [72.215.153.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE95E4B
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:47:16 -0700 (PDT)
X-ASG-Debug-ID: 1686933383-1cf43967de08db0001-xx1T2L
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with ESMTP id SkuIM7N1ul0zVXoj; Fri, 16 Jun 2023 12:36:23 -0400 (EDT)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-Barracuda-RBL-Trusted-Forwarder: 10.10.4.126
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cybernetics.com; s=mail;
        bh=jSVd+N21Si3niK5uv1uauUUegVQnfC7S0oazR7d7Yw0=;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
        Content-Language:Subject:MIME-Version:Date:Message-ID; b=ocGWbnTPgU7TL9TTWO9/
        rRFILX8EHEb8mPYlH49UgA1QRYVpdm4K97f3eTCIdF5MIxKkPHKFcZBfdFuIGh9tQZjDkTwblTizf
        GV2O1pNU5aCGFzCage0R24wGR0xUq3eS4tQvZUiK5LOXf4Zo46aziWVmJJua6xHOXVh5YLHcsY=
Received: from [10.157.2.224] (HELO [192.168.200.1])
  by cybernetics.com (CommuniGate Pro SMTP 7.1.1)
  with ESMTPS id 12672245; Fri, 16 Jun 2023 12:36:23 -0400
Message-ID: <4f3290a5-7fd9-1d40-5183-2fffcf10b2f3@cybernetics.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.157.2.224
Date:   Fri, 16 Jun 2023 12:36:22 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [patch v3 1/7] x86/smp: Make stop_other_cpus() more robust
Content-Language: en-US
X-ASG-Orig-Subj: Re: [patch v3 1/7] x86/smp: Make stop_other_cpus() more robust
To:     Ashok Raj <ashok.raj@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ashok Raj <ashok.raj@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Eric Biederman <ebiederm@xmission.com>
References: <20230615190036.898273129@linutronix.de>
 <20230615193330.263684884@linutronix.de>
 <ZIvByEFqiJZOyau2@a4bf019067fa.jf.intel.com>
From:   Tony Battersby <tonyb@cybernetics.com>
In-Reply-To: <ZIvByEFqiJZOyau2@a4bf019067fa.jf.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Barracuda-Connect: UNKNOWN[10.10.4.126]
X-Barracuda-Start-Time: 1686933383
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 3086
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/23 21:58, Ashok Raj wrote:
> Hi Thomas,
>
> On Thu, Jun 15, 2023 at 10:33:50PM +0200, Thomas Gleixner wrote:
>> Tony reported intermittent lockups on poweroff. His analysis identified the
>> wbinvd() in stop_this_cpu() as the culprit. This was added to ensure that
>> on SME enabled machines a kexec() does not leave any stale data in the
>> caches when switching from encrypted to non-encrypted mode or vice versa.
>>
>> That wbindv() is conditional on the SME feature bit which is read directly
>> from CPUID. But that readout does not check whether the CPUID leaf is
>> available or not. If it's not available the CPU will return the value of
>> the highest supported leaf instead. Depending on the content the "SME" bit
>> might be set or not.
>>
>> That's incorrect but harmless. Making the CPUID readout conditional makes
>> the observed hangs go away, but it does not fix the underlying problem:
>>
>> CPU0					CPU1
>>
>>  stop_other_cpus()
>>    send_IPIs(REBOOT);			stop_this_cpu()
>>    while (num_online_cpus() > 1);         set_online(false);
>>    proceed... -> hang
>> 				          wbinvd()
>>
>> WBINVD is an expensive operation and if multiple CPUs issue it at the same
>> time the resulting delays are even larger.
>>
>> But CPU0 already observed num_online_cpus() going down to 1 and proceeds
>> which causes the system to hang.
>>
>> This issue exists independent of WBINVD, but the delays caused by WBINVD
>> make it more prominent.
>>
>> Make this more robust by adding a cpumask which is initialized to the
>> online CPU mask before sending the IPIs and CPUs clear their bit in
>> stop_this_cpu() after the WBINVD completed. Check for that cpumask to
>> become empty in stop_other_cpus() instead of watching num_online_cpus().
>>
>> The cpumask cannot plug all holes either, but it's better than a raw
>> counter and allows to restrict the NMI fallback IPI to be sent only to
>> the CPUs which have not reported within the timeout window.
>>
>> Fixes: 08f253ec3767 ("x86/cpu: Clear SME feature flag when not in use")
>> Reported-by: Tony Battersby <tonyb@cybernetics.com>
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> Link: https://lore.kernel.org/all/3817d810-e0f1-8ef8-0bbd-663b919ca49b@cybernetics.com
>> ---
>> V3: Use a cpumask to make the NMI case slightly safer - Ashok
>> ---
>>  arch/x86/include/asm/cpu.h |    2 +
>>  arch/x86/kernel/process.c  |   23 +++++++++++++-
>>  arch/x86/kernel/smp.c      |   71 +++++++++++++++++++++++++++++++--------------
>>  3 files changed, 73 insertions(+), 23 deletions(-)
> I tested them and seems to work fine on my system.
>
> Maybe Tony can check in his setup would be great.
>
plain 6.4-rc6: 50% failure rate
  poweroff success: 2
  poweroff fail:    2

6.4-rc6 with tglx v3 patch #1 only: 0% failure rate
  poweroff success: 10
  poweroff fail:    0

6.4-rc6 with all 7 tglx v3 patches: 0% failure rate
  poweroff success: 10
  poweroff fail:    0

Fixes my problem.

Tested-by: Tony Battersby <tonyb@cybernetics.com>


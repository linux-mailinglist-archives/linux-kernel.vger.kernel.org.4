Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779AE738771
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbjFUOpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbjFUOpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:45:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE04CBC
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 07:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687358671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4VfIt4Fzbnh6aUb6TyZcqNjXNhG3BKZH5u5zEbS39GE=;
        b=K1yk+X3oZAb1BnM9k17T0dWgRCJSdE2WfA1OlWT3rGweGXvYp6hVNfHlP9qR00LJaKg0Gh
        9c656KnqfS4DQFgcjZpBme4k22xVE/ehVGA487BXuTCQh/ppXfBoKqKJ5cKABbmnmiY9xN
        g6ucz0rEx9AxXyObjJ4z3tdxTWaXXHI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-9_xWp-wSOkus_YXxvzQhoQ-1; Wed, 21 Jun 2023 10:44:25 -0400
X-MC-Unique: 9_xWp-wSOkus_YXxvzQhoQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2749D89224F;
        Wed, 21 Jun 2023 14:44:24 +0000 (UTC)
Received: from [10.22.17.140] (unknown [10.22.17.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 704D6492B01;
        Wed, 21 Jun 2023 14:44:23 +0000 (UTC)
Message-ID: <5cb81f3b-45a0-d566-3d63-569b5706e9fe@redhat.com>
Date:   Wed, 21 Jun 2023 10:44:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 2/5] x86/idle: Disable IBRS when cpu is offline
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-pm@vger.kernel.org,
        Robin Jarry <rjarry@redhat.com>, Joe Mario <jmario@redhat.com>
References: <20230620140625.1001886-1-longman@redhat.com>
 <20230620140625.1001886-3-longman@redhat.com>
 <20230621072313.GA2046280@hirez.programming.kicks-ass.net>
 <7f2424df-1846-6c38-e446-b3d5aa693ecd@redhat.com>
 <20230621143602.GI2053369@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230621143602.GI2053369@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/23 10:36, Peter Zijlstra wrote:
> On Wed, Jun 21, 2023 at 09:59:52AM -0400, Waiman Long wrote:
>> On 6/21/23 03:23, Peter Zijlstra wrote:
>>> On Tue, Jun 20, 2023 at 10:06:22AM -0400, Waiman Long wrote:
>>>> Commit bf5835bcdb96 ("intel_idle: Disable IBRS during long idle")
>>>> disables IBRS when the CPU enters long idle. However, when a CPU becomes
>>>> offline, the IBRS bit is still set when X86_FEATURE_KERNEL_IBRS is
>>>> enabled. That will impact the performance of a sibling CPU. Mitigate
>>>> this performance impact by clearing all the mitigation bits in SPEC_CTRL
>>>> MSR when offline and restoring the value of the MSR when it becomes
>>>> online again.
>>>>
>>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>>> ---
>>>>    arch/x86/kernel/smpboot.c | 13 +++++++++++++
>>>>    1 file changed, 13 insertions(+)
>>>>
>>>> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
>>>> index 352f0ce1ece4..5ff82fef413c 100644
>>>> --- a/arch/x86/kernel/smpboot.c
>>>> +++ b/arch/x86/kernel/smpboot.c
>>>> @@ -84,6 +84,7 @@
>>>>    #include <asm/hw_irq.h>
>>>>    #include <asm/stackprotector.h>
>>>>    #include <asm/sev.h>
>>>> +#include <asm/nospec-branch.h>
>>>>    /* representing HT siblings of each logical CPU */
>>>>    DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_sibling_map);
>>>> @@ -1838,12 +1839,24 @@ void __noreturn hlt_play_dead(void)
>>>>    void native_play_dead(void)
>>>>    {
>>>> +	u64 spec_ctrl = spec_ctrl_current();
>>>> +
>>>> +	if (cpu_feature_enabled(X86_FEATURE_KERNEL_IBRS)) {
>>>> +		this_cpu_write(x86_spec_ctrl_current, 0);
>>>> +		native_wrmsrl(MSR_IA32_SPEC_CTRL, 0);
>>>> +	}
>>>> +
>>>>    	play_dead_common();
>>>>    	tboot_shutdown(TB_SHUTDOWN_WFS);
>>>>    	mwait_play_dead();
>>>>    	if (cpuidle_play_dead())
>>>>    		hlt_play_dead();
>>>> +
>>>> +	if (cpu_feature_enabled(X86_FEATURE_KERNEL_IBRS)) {
>>>> +		native_wrmsrl(MSR_IA32_SPEC_CTRL, spec_ctrl);
>>>> +		this_cpu_write(x86_spec_ctrl_current, spec_ctrl);
>>>> +	}
>>>>    }
>>> play_dead() is marked __noreturn
>> There are different versions of play_dead() in the kernel. Some of them are
>> indeed marked __noreturn like the non-SMP one in arch/x86/kernel/process.c.
>> The native_play_dead() that I am patching isn't one of those.
> mostly by accident I think, hlt_play_dead() is, so I'm thinking
> everybody (all compiler and objtool) managed to figure out
> native_play_dead() is __noreturn too.

Well, hlt_play_dead() is only called if cpuidle_play_dead() returns an 
error which is not the typical case. My testing does confirm that this 
patch is able to keep the IBRS bit off when a CPU is offline via its 
online sysfs file.

Cheers,
Longman


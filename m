Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71107745F78
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 17:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbjGCPIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 11:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbjGCPIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 11:08:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C640E6B
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 08:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688396886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AUHibEWJur7T9M8HkspJ2AIEO95dTbGY2F8uwaeIXwk=;
        b=A4iIh0ruDYVZyHAZrRcsgja8+SBtT/jaoU4c7qHNGLn+ddfe+kW4nrF0IuoS+vX9baSyIj
        dFr42bgaD6/jecJPAe/feTIVKAYbG3VnbbEt2yhuKRQ5D+OEImJJOw4Q4jEWA+QYYrscYp
        r22GIxrGbqzD8e0mvFhJVTqUgCaqc/8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-9-NFofb2wYMNu_ZVe_IxIOIA-1; Mon, 03 Jul 2023 11:08:02 -0400
X-MC-Unique: NFofb2wYMNu_ZVe_IxIOIA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B7F891C08DA7;
        Mon,  3 Jul 2023 15:08:01 +0000 (UTC)
Received: from [10.22.17.92] (unknown [10.22.17.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 752C3492B01;
        Mon,  3 Jul 2023 15:08:00 +0000 (UTC)
Message-ID: <5727a163-c72a-9632-b497-1011689aaa75@redhat.com>
Date:   Mon, 3 Jul 2023 11:08:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 1/4] x86/speculation: Add __update_spec_ctrl() helper
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        x86@kernel.org, linux-pm@vger.kernel.org,
        Robin Jarry <rjarry@redhat.com>, Joe Mario <jmario@redhat.com>
References: <20230628022554.1638318-1-longman@redhat.com>
 <20230628022554.1638318-2-longman@redhat.com>
 <20230703102815.GD4253@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230703102815.GD4253@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/3/23 06:28, Peter Zijlstra wrote:
> On Tue, Jun 27, 2023 at 10:25:51PM -0400, Waiman Long wrote:
>> Add a new __update_spec_ctrl() helper which is a variant of
>> update_spec_ctrl() that can be used in a noinstr function.
>>
>> Suggested-by: Peter Zijlstra <peterz@infradead.org>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   arch/x86/include/asm/nospec-branch.h | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
>> index 55388c9f7601..1d363fcea207 100644
>> --- a/arch/x86/include/asm/nospec-branch.h
>> +++ b/arch/x86/include/asm/nospec-branch.h
>> @@ -9,7 +9,7 @@
>>   
>>   #include <asm/alternative.h>
>>   #include <asm/cpufeatures.h>
>> -#include <asm/msr-index.h>
>> +#include <asm/msr.h>
>>   #include <asm/unwind_hints.h>
>>   #include <asm/percpu.h>
>>   #include <asm/current.h>
>> @@ -488,6 +488,15 @@ DECLARE_PER_CPU(u64, x86_spec_ctrl_current);
>>   extern void update_spec_ctrl_cond(u64 val);
>>   extern u64 spec_ctrl_current(void);
>>   
>> +/*
>> + * This can be used in noinstr function.
>> + */
>> +static __always_inline void __update_spec_ctrl(u64 val)
>> +{
>> +	__this_cpu_write(x86_spec_ctrl_current, val);
>> +	native_wrmsrl(MSR_IA32_SPEC_CTRL, val);
>> +}
> Should we also use this to implement update_spec_ctrl() ?

I also thought about that. However, I am a bit worry about losing some 
additional check done in this_cpu_write() and the paravirt support in 
wrmsrl(). I have no problem making update_spec_ctrl() an instrument-able 
wrapper on __update_spec_ctrl() if you think these are not valid concerns.

Cheers,
Longman


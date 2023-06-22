Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF490739553
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 04:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjFVCOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 22:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjFVCOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 22:14:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D5C1731
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 19:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687399989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZrXJwF8ZKTlwhPXSIVwgN09FFhnrhvULSTkbHyhZp9M=;
        b=b3XsClECy+XdExwpLyDsj3M0wFlJrTp3u5/cu4jpYRhbm3WTq1raQbHRTgh4LEXg9DTRfF
        aFGAV39EYWh5i/nk/XlOpI0YvxsYg38I8WlNRO4BcsgLkV9NBCkwszf1rlF84AZ1byCd8P
        cwZ7kIYAbJQVvxVs1mPzrs1uoHlixdw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-662-B7PoQ7nGNbesStlMwdqg3A-1; Wed, 21 Jun 2023 22:13:06 -0400
X-MC-Unique: B7PoQ7nGNbesStlMwdqg3A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 498C788CC42;
        Thu, 22 Jun 2023 02:13:05 +0000 (UTC)
Received: from [10.22.33.143] (unknown [10.22.33.143])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 404FD200BA8B;
        Thu, 22 Jun 2023 02:13:04 +0000 (UTC)
Message-ID: <8df8ea62-11af-fdac-9561-a6bd6a41e83a@redhat.com>
Date:   Wed, 21 Jun 2023 22:13:04 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 1/3] x86/idle: Disable IBRS when cpu is offline
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-pm@vger.kernel.org, Robin Jarry <rjarry@redhat.com>,
        Joe Mario <jmario@redhat.com>
References: <20230622003603.1188364-1-longman@redhat.com>
 <20230622003603.1188364-2-longman@redhat.com>
 <8a1ba9cd-426f-dd59-bb2a-67a0f1af6de8@infradead.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <8a1ba9cd-426f-dd59-bb2a-67a0f1af6de8@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/21/23 22:05, Randy Dunlap wrote:
>
> On 6/21/23 17:36, Waiman Long wrote:
>> Commit bf5835bcdb96 ("intel_idle: Disable IBRS during long idle")
>> disables IBRS when the CPU enters long idle. However, when a CPU
>> becomes offline, the IBRS bit is still set when X86_FEATURE_KERNEL_IBRS
>> is enabled. That will impact the performance of a sibling CPU. Mitigate
>> this performance impact by clearing all the mitigation bits in SPEC_CTRL
>> MSR when offline. When the CPU is online again, it will be re-initialized
>> and so restoring the SPEC_CTRL value isn't needed.
>>
>> Add a comment to say that native_play_dead() is a __noreturn function,
>> but it can't be marked as such to avoid confusion about the missing
>> MSR restoration code.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   arch/x86/kernel/smpboot.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
>> index 352f0ce1ece4..7bc33885518c 100644
>> --- a/arch/x86/kernel/smpboot.c
>> +++ b/arch/x86/kernel/smpboot.c
>> @@ -84,6 +84,7 @@
>>   #include <asm/hw_irq.h>
>>   #include <asm/stackprotector.h>
>>   #include <asm/sev.h>
>> +#include <asm/nospec-branch.h>
>>   
>>   /* representing HT siblings of each logical CPU */
>>   DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_sibling_map);
>> @@ -1836,8 +1837,17 @@ void __noreturn hlt_play_dead(void)
>>   	}
>>   }
>>   
>> +/*
>> + * naitve_play_dead() is essentially a __noreturn function, but it can't
> typo: native_play_dead()

Thanks for spotting the typo. Will fix it in the next version.

Cheers,
Longman

>
>> + * be marked as such as the compiler may complain about it.
>> + */
>>   void native_play_dead(void)
>>   {
>> +	if (cpu_feature_enabled(X86_FEATURE_KERNEL_IBRS)) {
>> +		this_cpu_write(x86_spec_ctrl_current, 0);
>> +		native_wrmsrl(MSR_IA32_SPEC_CTRL, 0);
>> +	}
>> +
>>   	play_dead_common();
>>   	tboot_shutdown(TB_SHUTDOWN_WFS);
>>   


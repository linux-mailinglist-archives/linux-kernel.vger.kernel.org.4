Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1D9745F84
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 17:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbjGCPKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 11:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjGCPKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 11:10:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78F010C1
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 08:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688396960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6g4SgMrAx5lx8sYPsFEruVMXFbKKSUycENj60N3/Gvk=;
        b=HHjQBcdMYJs1cI3sN9TNQinEKLKRW0J+CaV38hEVyq5yn9uabsPZ8V5F4iPJmqXPizOMRG
        evwXoxMkzxmUtG70fM7IrR8XoMKElULv8I4AsxtDO4ecOSAug25/rRT+nbXo+VHk0Bweta
        iO/vrVBkWAB7ePUNvSczOPRRPjkK0HY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-288-JZofT6OTOEG7gcU8sMfiFQ-1; Mon, 03 Jul 2023 11:09:14 -0400
X-MC-Unique: JZofT6OTOEG7gcU8sMfiFQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9662790EEA5;
        Mon,  3 Jul 2023 15:09:13 +0000 (UTC)
Received: from [10.22.17.92] (unknown [10.22.17.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CB2C714682F9;
        Mon,  3 Jul 2023 15:09:12 +0000 (UTC)
Message-ID: <0a4f1738-dd0e-efdb-b137-7a7c9875786d@redhat.com>
Date:   Mon, 3 Jul 2023 11:09:12 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 4/4] intel_idle: Add ibrs_off module parameter to force
 disable IBRS
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
 <20230628022554.1638318-5-longman@redhat.com>
 <20230703103255.GE4253@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230703103255.GE4253@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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


On 7/3/23 06:32, Peter Zijlstra wrote:
> On Tue, Jun 27, 2023 at 10:25:54PM -0400, Waiman Long wrote:
>
>> @@ -69,6 +69,7 @@ static int max_cstate = CPUIDLE_STATE_MAX - 1;
>>   static unsigned int disabled_states_mask __read_mostly;
>>   static unsigned int preferred_states_mask __read_mostly;
>>   static bool force_irq_on __read_mostly;
>> +static bool ibrs_off __read_mostly;
>>   
>>   static struct cpuidle_device __percpu *intel_idle_cpuidle_devices;
>>   
>> @@ -1919,12 +1920,15 @@ static void state_update_enter_method(struct cpuidle_state *state, int cstate)
>>   	}
>>   
>>   	if (cpu_feature_enabled(X86_FEATURE_KERNEL_IBRS) &&
>> -			   state->flags & CPUIDLE_FLAG_IBRS) {
>> +			((state->flags & CPUIDLE_FLAG_IBRS) || ibrs_off)) {
>>   		/*
>>   		 * IBRS mitigation requires that C-states are entered
>>   		 * with interrupts disabled.
>>   		 */
>> -		WARN_ON_ONCE(state->flags & CPUIDLE_FLAG_IRQ_ENABLE);
>> +		if (ibrs_off && (state->flags & CPUIDLE_FLAG_IRQ_ENABLE))
>> +			state->flags &= ~CPUIDLE_FLAG_IRQ_ENABLE;
>> +		else
>> +			WARN_ON_ONCE(state->flags & CPUIDLE_FLAG_IRQ_ENABLE);
> If you're respinning this, you can leave out the else and avoid the
> indent on the WARN:
>
> +		if (ibrs_off && (state->flags & CPUIDLE_FLAG_IRQ_ENABLE))
> +			state->flags &= ~CPUIDLE_FLAG_IRQ_ENABLE;
> 		WARN_ON_ONCE(state->flags & CPUIDLE_FLAG_IRQ_ENABLE);
>
> Same effect, simpler code and all that.

That is true. I can certainly respin that as there is another suggested 
doc change that is pending.

Cheers,
Longman


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCDEC73A11D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 14:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjFVMoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 08:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjFVMoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 08:44:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2870219A6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 05:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687437816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AfdvisXajEYwK7UtGss7j00J0QPTl2ShfkVpaxGjung=;
        b=cpyF71ShPhP1dQt+C8sH1A7dJxySHThXGjSYofMFoAPoiCaUrArjWpMGfhOXTLpLjJlpMd
        Tx/Sux0x+F6DJRycck05rapBmaeEpRaSQ8ljq2Tmu/6gIuzPCKKsRS9TsdvLycEIogG8qR
        BjFpFYcuQlqq/M9Q3ywCASkbPjutcl4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-414-vhU1pIp0NIOHZGNe0Iwzmw-1; Thu, 22 Jun 2023 08:43:32 -0400
X-MC-Unique: vhU1pIp0NIOHZGNe0Iwzmw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E9FC61C0514A;
        Thu, 22 Jun 2023 12:43:31 +0000 (UTC)
Received: from [10.22.17.29] (unknown [10.22.17.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3CC6914682F8;
        Thu, 22 Jun 2023 12:43:31 +0000 (UTC)
Message-ID: <fdd4996f-1542-f227-1130-acc6d9baaa1c@redhat.com>
Date:   Thu, 22 Jun 2023 08:43:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 2/3] intel_idle: Sync up the SPEC_CTRL MSR value to
 x86_spec_ctrl_current
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-pm@vger.kernel.org,
        Robin Jarry <rjarry@redhat.com>, Joe Mario <jmario@redhat.com>
References: <20230622003603.1188364-1-longman@redhat.com>
 <20230622003603.1188364-3-longman@redhat.com>
 <20230622054633.ulrurzzvzjijvdhn@treble>
 <20230622093828.GE4253@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230622093828.GE4253@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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


On 6/22/23 05:38, Peter Zijlstra wrote:
> On Wed, Jun 21, 2023 at 10:46:33PM -0700, Josh Poimboeuf wrote:
>> On Wed, Jun 21, 2023 at 08:36:02PM -0400, Waiman Long wrote:
>>> When intel_idle_ibrs() is called, it modifies the SPEC_CTRL MSR to
>>> 0 in order disable IBRS. However, the new MSR value isn't reflected
>>> in x86_spec_ctrl_current which is at odd with the other code that
>>> keep track of its state in that percpu variable. Fix that by updating
>>> x86_spec_ctrl_current percpu value to always match the content of the
>>> SPEC_CTRL MSR.
>> Is this fixing an actual bug or is there some other reason for doing
>> this?
>>
>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>> ---
>>>   drivers/idle/intel_idle.c | 8 ++++++--
>>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
>>> index aa2d19db2b1d..07fa23707b3c 100644
>>> --- a/drivers/idle/intel_idle.c
>>> +++ b/drivers/idle/intel_idle.c
>>> @@ -181,13 +181,17 @@ static __cpuidle int intel_idle_ibrs(struct cpuidle_device *dev,
>>>   	u64 spec_ctrl = spec_ctrl_current();
>>>   	int ret;
>>>   
>>> -	if (smt_active)
>>> +	if (smt_active) {
>>> +		__this_cpu_write(x86_spec_ctrl_current, 0);
>>>   		native_wrmsrl(MSR_IA32_SPEC_CTRL, 0);
>>> +	}
>>>   
>>>   	ret = __intel_idle(dev, drv, index);
>>>   
>>> -	if (smt_active)
>>> +	if (smt_active) {
>>>   		native_wrmsrl(MSR_IA32_SPEC_CTRL, spec_ctrl);
>>> +		__this_cpu_write(x86_spec_ctrl_current, spec_ctrl);
>>> +	}
>> More candidates for update_spec_ctrl()?
> Both this and the play_dead case can't use update_spec_ctrl() because
> RCU isn't there anymore and all that is noinstr. Additionally, both
> sites rely on preemption being off already, where update_spec_ctrl()
> can't do that.
>
> That said, I suppose one could write it like so:
>
> static __always_inline __update_spec_ctrl(u64 val)
> {
> 	__this_cpu_write(x86_spec_ctrl_current, val);
> 	native_wrmsrl(MSR_IA32_SPEC_CTRL, val);
> }

We can put this into asm/nospec-branch.h since x86_spec_ctrl_current is 
defined there as well.

Cheers,
Longman


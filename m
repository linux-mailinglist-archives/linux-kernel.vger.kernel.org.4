Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7340E63D9C9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 16:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiK3Pri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 10:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiK3Prh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 10:47:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31AF11170;
        Wed, 30 Nov 2022 07:47:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C65EA617C3;
        Wed, 30 Nov 2022 15:47:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9687FC433C1;
        Wed, 30 Nov 2022 15:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669823254;
        bh=Ms6zG9bes1a4dywnpkOvtzh48RrPOPi6LWLATgEHGV0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=g098uW20SxRasYSkI8fyvQx47YyB9NUE3mdEQYw5JBwdboQoEnYgB7mxaHSGyNW+m
         LaDFTnSeyKqNNRx8+hzTf9BjF4uLiVFb7oX4W3jS3GhFVuxlzWz3y0gjUFYvx12Hcg
         o4o9C4r+mHR2nLIWw1YVjY/dl0CVMfSf2GtuqvfDzNA/GzCcR7T7FvjGd4f4zuJ0Pv
         G7KWKje8TNoZ/KUlAHgmXkJVaoKdg2SVq/e41IxMjPuSXRw36QXrhGluzt4rsHxuxB
         mJBQboNgAb4EDD4h0xIQs2KJnCkVK9HzMkMezecZpoQTlbXliYr18pLibLFsS+1eB3
         VmCcRJuRJzE5w==
Message-ID: <700e7f91-00a9-d625-741d-122b9b1e1e1c@kernel.org>
Date:   Wed, 30 Nov 2022 16:47:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH V3 2/3] tracing/osnoise: Add preempt/irq disable options
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1669409262.git.bristot@kernel.org>
 <03d4a8522792fa3a51920c79f8a5074933a2fcb3.1669409262.git.bristot@kernel.org>
 <20221128153919.33c008d1@gandalf.local.home>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20221128153919.33c008d1@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/22 21:39, Steven Rostedt wrote:
> On Fri, 25 Nov 2022 22:20:23 +0100
> Daniel Bristot de Oliveira <bristot@kernel.org> wrote:
> 
>> @@ -1308,6 +1315,8 @@ static void notify_new_max_latency(u64 latency)
>>   */
>>  static int run_osnoise(void)
>>  {
>> +	bool preempt_disable = test_bit(OSN_PREEMPT_DISABLE, &osnoise_options);
>> +	bool irq_disable = test_bit(OSN_IRQ_DISABLE, &osnoise_options);
> 
> 	bool irq_disable = test_bit(OSN_IRQ_DISABLE, &osnoise_options);
> 	bool preempt_disable = IS_ENABLED(CONFIG_PREEMPT) &&
> 			!irq_disable && test_bit(OSN_PREEMPT_DISABLE, &osnoise_options);

Ooops again, that is not exactly what I wanted, because...

>>  	struct osnoise_variables *osn_var = this_cpu_osn_var();
>>  	u64 start, sample, last_sample;
>>  	u64 last_int_count, int_count;
>> @@ -1335,6 +1344,14 @@ static int run_osnoise(void)
>>  	 */
>>  	threshold = tracing_thresh ? : 5000;
>>  
>> +	/*
>> +	 * IRQ disable also implies in preempt disable.
>> +	 */
>> +	if (irq_disable)
>> +		local_irq_disable();
> 
> 	if (preempt_disable)
>> +		preempt_disable();
>> +
>>  	/*
>>  	 * Make sure NMIs see sampling first
>>  	 */
>> @@ -1422,16 +1439,21 @@ static int run_osnoise(void)
>>  		 * cond_resched()
>>  		 */
>>  		if (IS_ENABLED(CONFIG_PREEMPT_RCU)) {
>> -			local_irq_disable();
>> +			if (!irq_disable)
>> +				local_irq_disable();
>> +
>>  			rcu_momentary_dyntick_idle();
>> -			local_irq_enable();
>> +
>> +			if (!irq_disable)
>> +				local_irq_enable();
>>  		}
>>  
>>  		/*
>>  		 * For the non-preemptive kernel config: let threads runs, if
>> -		 * they so wish.
>> +		 * they so wish, unless set not do to so.
>>  		 */

Then I end up cond_resched'ing here in the non-preemptive kernel.

>> -		cond_resched();
>> +		if (!irq_disable && !preempt_disable)
>> +			cond_resched();

But I also want to avoid this cond_resched if preempt_disable is set.

So, I will merge both things:

	- change the preempt_disable assignment to check !irq_disabled, like:

		/*
		 * Disabling preemption is only required if IRQs are enabled, and the options is set on.
		 */
		preempt_disable = !irq_disable && test_bit(OSN_PREEMPT_DISABLE, &osnoise_options);

	- change the preempt disabled if to
		if (IS_ENABLED(CONFIG_PREEMPT) && preempt_disabled)
			preempt_disable();

I tested with both preemption models (preemptive and not preemptive) and it works fine.

am I missing something?

-- Daniel

>>  		last_sample = sample;
>>  		last_int_count = int_count;
>> @@ -1450,6 +1472,14 @@ static int run_osnoise(void)
>>  	 */
>>  	barrier();
>>  
>> +	/*
>> +	 * Return to the preemptive state.
>> +	 */
> 
> 	if (preempt_disable)
>> +		preempt_enable();
>> +
> 
>> +	if (irq_disable)
>> +		local_irq_enable();
> 
> -- Steve
> 
>>  	/*
>>  	 * Save noise info.
>>  	 */


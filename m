Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0641F6A35C6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 01:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjB0AD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 19:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjB0AD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 19:03:27 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643039742;
        Sun, 26 Feb 2023 16:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=+nha29/AKnCiNonhjL1b/Xu2lJjtfS87odZR9H1Cc0s=; b=ArdVyRxKOIKlcRkICMv/DL5jxJ
        celGImU9YTrL6d6N/2lA4YGL2+XddjRfOw9k1xPbrR+swIwvIz4SHMvrcdY2E/Swz7Zs5rZpKoMgj
        LL5jFE72NpjaUbxqC8+Anc/t+5qUn/8HHaF4XSsjnRkdqYL+g1hWX1PlMDSHU+afIY2KGbM1rGv4L
        7GtW41DMrtsuk3iY6fVIlEmi4c9aXQYvs8itp1y6JWv1W7oq/UgBbSc8xgjOGg78eTU+yzlszOR3Y
        EyBr7ajIATLucXJ18843/0nelWMknh6CtQJd/135IexW7ugDIjh21T5SHjeABMIiqS8+sv1L23jXa
        E+r3BtEQ==;
Received: from [2601:1c2:980:9ec0::df2f]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pWQzF-0082zE-9M; Mon, 27 Feb 2023 00:03:25 +0000
Message-ID: <d24bff4c-9426-296a-d43a-f22983ab9086@infradead.org>
Date:   Sun, 26 Feb 2023 16:03:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH RFC] rcu: Add a minimum time for marking boot as completed
Content-Language: en-US
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        rcu@vger.kernel.org
References: <20230225032716.3320124-1-joel@joelfernandes.org>
 <ea03e810-95f0-abd8-2a83-f83174a99dbf@infradead.org>
 <Y/mHpOrr1C8NkMWm@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <Y/mHpOrr1C8NkMWm@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/24/23 19:59, Joel Fernandes wrote:
> On Fri, Feb 24, 2023 at 07:32:22PM -0800, Randy Dunlap wrote:
> [..] 
>>> +
>>> +	  Accept the default if unsure.
>>> +
>>>  config RCU_EXP_KTHREAD
>>>  	bool "Perform RCU expedited work in a real-time kthread"
>>>  	depends on RCU_BOOST && RCU_EXPERT
>>> diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
>>> index 19bf6fa3ee6a..5b73341d9b89 100644
>>> --- a/kernel/rcu/update.c
>>> +++ b/kernel/rcu/update.c
>>> @@ -62,6 +62,10 @@ module_param(rcu_normal_after_boot, int, 0444);
>>>  #endif
>>>  #endif /* #ifndef CONFIG_TINY_RCU */
>>>  
>>> +/* Minimum time until RCU considers boot as completed. */
>>> +static int boot_end_delay = CONFIG_RCU_BOOT_END_DELAY;
>>> +module_param(boot_end_delay, int, 0444);
>>> +
>>>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
>>>  /**
>>>   * rcu_read_lock_held_common() - might we be in RCU-sched read-side critical section?
>>> @@ -225,12 +229,29 @@ void rcu_unexpedite_gp(void)
>>>  EXPORT_SYMBOL_GPL(rcu_unexpedite_gp);
>>>  
>>>  static bool rcu_boot_ended __read_mostly;
>>> -
>>>  /*
>>> - * Inform RCU of the end of the in-kernel boot sequence.
>>> + * Inform RCU of the end of the in-kernel boot sequence. The boot sequence will
>>> + * not be marked ended until at least boot_end_delay milliseconds have passed.
>>>   */
>>> +void rcu_end_inkernel_boot(void);
>>> +static void boot_rcu_work_fn(struct work_struct *work)
>>> +{
>>> +	rcu_end_inkernel_boot();
>>> +}
>>> +static DECLARE_DELAYED_WORK(boot_rcu_work, boot_rcu_work_fn);
>>> +
>>>  void rcu_end_inkernel_boot(void)
>>>  {
>>> +	if (boot_end_delay) {
>>> +		u64 boot_ms = ktime_get_boot_fast_ns() / 1000000UL;
>>
>> Is that division OK on 32-bit?  Might have to use a helper macro. (I dunno.)
> 
> I believe the below should work on 32-bit, but I will test it more. It does
> on 64-bit.
> 
> Thanks!
> 
> ---8<-----------------------
> 
> diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> index cbdad7b46841..2f539c18b310 100644
> --- a/kernel/rcu/update.c
> +++ b/kernel/rcu/update.c
> @@ -243,7 +243,7 @@ static DECLARE_DELAYED_WORK(boot_rcu_work, boot_rcu_work_fn);
>  void rcu_end_inkernel_boot(void)
>  {
>  	if (boot_end_delay) {
> -		u64 boot_ms = ktime_get_boot_fast_ns() / 1000000UL;
> +		u64 boot_ms = div_u64(ktime_get_boot_fast_ns(), 1000000UL);
>  
>  		if (boot_ms < boot_end_delay) {
>  			schedule_delayed_work(&boot_rcu_work,

Joel, this now builds cleanly on 32-bit. Before the patch:

ld: kernel/rcu/update.o: in function `boot_rcu_work_fn':
update.c:(.text+0x4623): undefined reference to `__udivdi3'
ld: kernel/rcu/update.o: in function `rcu_end_inkernel_boot':
update.c:(.text+0x46b3): undefined reference to `__udivdi3'

I don't know what the second one refers to, but it didn't show up
after the patch above (using div_u64()).

Thanks.
-- 
~Randy

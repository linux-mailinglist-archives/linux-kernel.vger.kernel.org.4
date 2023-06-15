Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C407318EA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 14:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343949AbjFOMX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 08:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244312AbjFOMWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 08:22:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423472D45
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 05:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686831606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ej3tCXjr/TYQpn7uiCNnWPg2MFlLuczcmBkJJvm+F10=;
        b=MkJ0Vtd48FevCUX4USgYz1OFTNaxyinVrikEiwhmZY7KtTtesx+YcOLR0EUmbtyXHuYTpC
        6czFldNrnVuH1r77bbK8BFjQjcfzJU9/YONsWXUOvmWU8O7EJ3tC6vSw49r8ZElz2Kel1c
        gOZNXcBhkAdcS05kMBqWpeS2XScDd8o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-645-njiguByWO2izt-U9OBYjKQ-1; Thu, 15 Jun 2023 08:20:02 -0400
X-MC-Unique: njiguByWO2izt-U9OBYjKQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 16B9E185A794;
        Thu, 15 Jun 2023 12:20:02 +0000 (UTC)
Received: from localhost (unknown [10.39.192.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A0B8440D1B60;
        Thu, 15 Jun 2023 12:20:01 +0000 (UTC)
Date:   Thu, 15 Jun 2023 13:20:00 +0100
From:   "Richard W.M. Jones" <rjones@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Mathias Krause <minipli@grsecurity.net>,
        Luiz Capitulino <luizcap@amazon.com>,
        Sven-Haegar Koch <haegar@sdinet.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Bhatnagar, Rishabh" <risbhat@amazon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "sashal@kernel.org" <sashal@kernel.org>, abuehaze@amazon.com,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] tick/common: Align tick period during sched_timer setup.
Message-ID: <20230615122000.GE10301@redhat.com>
References: <12c6f9a3-d087-b824-0d05-0d18c9bc1bf3@amazon.com>
 <c4724b40-89f6-5aa7-720d-c4a4af57cf45@amazon.com>
 <2023061428-compacter-economic-b648@gregkh>
 <20230614092045.tNY8USjq@linutronix.de>
 <4c4178a1-1050-ced4-e6fb-f95c3bdefc98@amazon.com>
 <2a3fa097-8ba0-5b0e-f506-779fee5b8fef@sdinet.de>
 <f5d2cc62-4aae-2579-1468-2e6e389f28dc@amazon.com>
 <23fb8ad7-beb0-ae1c-fa5a-a682a57f79b0@grsecurity.net>
 <20230615091830.RxMV2xf_@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615091830.RxMV2xf_@linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 11:18:30AM +0200, Sebastian Andrzej Siewior wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> The tick period is aligned very early while the first clock_event_device
> is registered. The system runs in periodic mode and switches later to
> one-shot mode if possible.
> 
> The next wake-up event is programmed based on aligned value
> (tick_next_period) but the delta value, that is used to program the
> clock_event_device, is computed based on ktime_get().
> 
> With the subtracted offset, the devices fires in less than the exacted
> time frame. With a large enough offset the system programs the timer for
> the next wake-up and the remaining time left is too little to make any
> boot progress. The system hangs.
> 
> Move the alignment later to the setup of tick_sched timer. At this point
> the system switches to oneshot mode and a highres clocksource is
> available. It safe to update tick_next_period ktime_get() will now
> return accurate (not jiffies based) time.
> 
> [bigeasy: Patch description + testing].
> 
> Reported-by: Mathias Krause <minipli@grsecurity.net>
> Reported-by: "Bhatnagar, Rishabh" <risbhat@amazon.com>
> Fixes: e9523a0d81899 ("tick/common: Align tick period with the HZ tick.")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Link: https://lore.kernel.org/5a56290d-806e-b9a5-f37c-f21958b5a8c0@grsecurity.net
> Link: https://lore.kernel.org/12c6f9a3-d087-b824-0d05-0d18c9bc1bf3@amazon.com

Tested-by: Richard W.M. Jones <rjones@redhat.com>

... fixing this bug which we thought originally was in qemu, then in
an unrelated kernel commit:

https://gitlab.com/qemu-project/qemu/-/issues/1696
https://lore.kernel.org/all/20230613134105.GA10301@redhat.com/

Rich.

>  kernel/time/tick-common.c | 11 +----------
>  kernel/time/tick-sched.c  | 13 ++++++++++++-
>  2 files changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
> index 65b8658da829e..b85f2f9c32426 100644
> --- a/kernel/time/tick-common.c
> +++ b/kernel/time/tick-common.c
> @@ -218,19 +218,10 @@ static void tick_setup_device(struct tick_device *td,
>  		 * this cpu:
>  		 */
>  		if (tick_do_timer_cpu == TICK_DO_TIMER_BOOT) {
> -			ktime_t next_p;
> -			u32 rem;
>  
>  			tick_do_timer_cpu = cpu;
>  
> -			next_p = ktime_get();
> -			div_u64_rem(next_p, TICK_NSEC, &rem);
> -			if (rem) {
> -				next_p -= rem;
> -				next_p += TICK_NSEC;
> -			}
> -
> -			tick_next_period = next_p;
> +			tick_next_period = ktime_get();
>  #ifdef CONFIG_NO_HZ_FULL
>  			/*
>  			 * The boot CPU may be nohz_full, in which case set
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index 52254679ec489..42c0be3080bde 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -161,8 +161,19 @@ static ktime_t tick_init_jiffy_update(void)
>  	raw_spin_lock(&jiffies_lock);
>  	write_seqcount_begin(&jiffies_seq);
>  	/* Did we start the jiffies update yet ? */
> -	if (last_jiffies_update == 0)
> +	if (last_jiffies_update == 0) {
> +		u32 rem;
> +
> +		/*
> +		 * Ensure that the tick is aligned to a multiple of
> +		 * TICK_NSEC.
> +		 */
> +		div_u64_rem(tick_next_period, TICK_NSEC, &rem);
> +		if (rem)
> +			tick_next_period += TICK_NSEC - rem;
> +
>  		last_jiffies_update = tick_next_period;
> +	}
>  	period = last_jiffies_update;
>  	write_seqcount_end(&jiffies_seq);
>  	raw_spin_unlock(&jiffies_lock);
> -- 
> 2.40.1

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-top is 'top' for virtual machines.  Tiny program with many
powerful monitoring features, net stats, disk stats, logging, etc.
http://people.redhat.com/~rjones/virt-top


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9A6731B12
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 16:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345007AbjFOOPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 10:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344994AbjFOOPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 10:15:39 -0400
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CC9296C;
        Thu, 15 Jun 2023 07:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1686838534; x=1718374534;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IjWZFA/uPlQulQ8EVAWQQd9KXy0ALDJz/lMgXQF8Mt0=;
  b=fjHgsL/HHi1ijockecNtlaKghqrjzcSxuXI9nrvKP2qAWjABfZ3Ra7aW
   S0oKDMIABABocAt93Yf4/sK/t6OrnyQf+7vcbDe/TxXQRtq/ryAWFdpkm
   4JdXpPXdLAGYVy/o8Xn1N//tJQtwiosRstISIvqY2grkLZxJEojN9gtJa
   4=;
X-IronPort-AV: E=Sophos;i="6.00,245,1681171200"; 
   d="scan'208";a="566798993"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-f7c754c9.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 14:15:31 +0000
Received: from EX19MTAUEB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2c-m6i4x-f7c754c9.us-west-2.amazon.com (Postfix) with ESMTPS id 8942740DAA;
        Thu, 15 Jun 2023 14:15:30 +0000 (UTC)
Received: from EX19D028UEC003.ant.amazon.com (10.252.137.159) by
 EX19MTAUEB001.ant.amazon.com (10.252.135.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 15 Jun 2023 14:15:29 +0000
Received: from [192.168.29.229] (10.106.179.32) by
 EX19D028UEC003.ant.amazon.com (10.252.137.159) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 15 Jun 2023 14:15:27 +0000
Message-ID: <67e3fcd8-0689-f5c4-6c16-c260d4f7ccaa@amazon.com>
Date:   Thu, 15 Jun 2023 10:15:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] tick/common: Align tick period during sched_timer setup.
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mathias Krause <minipli@grsecurity.net>
CC:     Sven-Haegar Koch <haegar@sdinet.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Bhatnagar, Rishabh" <risbhat@amazon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "sashal@kernel.org" <sashal@kernel.org>, <abuehaze@amazon.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Ingo Molnar" <mingo@kernel.org>
References: <12c6f9a3-d087-b824-0d05-0d18c9bc1bf3@amazon.com>
 <c4724b40-89f6-5aa7-720d-c4a4af57cf45@amazon.com>
 <2023061428-compacter-economic-b648@gregkh>
 <20230614092045.tNY8USjq@linutronix.de>
 <4c4178a1-1050-ced4-e6fb-f95c3bdefc98@amazon.com>
 <2a3fa097-8ba0-5b0e-f506-779fee5b8fef@sdinet.de>
 <f5d2cc62-4aae-2579-1468-2e6e389f28dc@amazon.com>
 <23fb8ad7-beb0-ae1c-fa5a-a682a57f79b0@grsecurity.net>
 <20230615091830.RxMV2xf_@linutronix.de>
Content-Language: en-US
From:   Luiz Capitulino <luizcap@amazon.com>
In-Reply-To: <20230615091830.RxMV2xf_@linutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.106.179.32]
X-ClientProxiedBy: EX19D042UWB002.ant.amazon.com (10.13.139.175) To
 EX19D028UEC003.ant.amazon.com (10.252.137.159)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-06-15 05:18, Sebastian Andrzej Siewior wrote:

> 
> 
> 
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


I've tested this against 5.10.184 (which is where it reproduces quick
for me):

Tested-by: Luiz Capitulino <luizcap@amazon.com>

> ---
>   kernel/time/tick-common.c | 11 +----------
>   kernel/time/tick-sched.c  | 13 ++++++++++++-
>   2 files changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
> index 65b8658da829e..b85f2f9c32426 100644
> --- a/kernel/time/tick-common.c
> +++ b/kernel/time/tick-common.c
> @@ -218,19 +218,10 @@ static void tick_setup_device(struct tick_device *td,
>                   * this cpu:
>                   */
>                  if (tick_do_timer_cpu == TICK_DO_TIMER_BOOT) {
> -                       ktime_t next_p;
> -                       u32 rem;
> 
>                          tick_do_timer_cpu = cpu;
> 
> -                       next_p = ktime_get();
> -                       div_u64_rem(next_p, TICK_NSEC, &rem);
> -                       if (rem) {
> -                               next_p -= rem;
> -                               next_p += TICK_NSEC;
> -                       }
> -
> -                       tick_next_period = next_p;
> +                       tick_next_period = ktime_get();
>   #ifdef CONFIG_NO_HZ_FULL
>                          /*
>                           * The boot CPU may be nohz_full, in which case set
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index 52254679ec489..42c0be3080bde 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -161,8 +161,19 @@ static ktime_t tick_init_jiffy_update(void)
>          raw_spin_lock(&jiffies_lock);
>          write_seqcount_begin(&jiffies_seq);
>          /* Did we start the jiffies update yet ? */
> -       if (last_jiffies_update == 0)
> +       if (last_jiffies_update == 0) {
> +               u32 rem;
> +
> +               /*
> +                * Ensure that the tick is aligned to a multiple of
> +                * TICK_NSEC.
> +                */
> +               div_u64_rem(tick_next_period, TICK_NSEC, &rem);
> +               if (rem)
> +                       tick_next_period += TICK_NSEC - rem;
> +
>                  last_jiffies_update = tick_next_period;
> +       }
>          period = last_jiffies_update;
>          write_seqcount_end(&jiffies_seq);
>          raw_spin_unlock(&jiffies_lock);
> --
> 2.40.1
> 

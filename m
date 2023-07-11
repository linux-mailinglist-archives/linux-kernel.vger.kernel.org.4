Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6910E74F7AC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 20:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjGKSAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 14:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjGKSAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 14:00:10 -0400
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5257410EF;
        Tue, 11 Jul 2023 11:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1689098409; x=1720634409;
  h=references:from:to:cc:subject:date:in-reply-to:
   message-id:mime-version;
  bh=9yPOK7BnNqeb8GutZgVy93yP3NTZhQh0Yi9tzYYJVFM=;
  b=UX0MLWt3GgtxMEgIeZ2zOIBzOEqlYSyBVz7t52lDYLgZfiryDPqFQ6uP
   HBC4CeAf0dLryr153Knk4s2+Tou1fnLKeP1SJwVJpyilT/Ow+lhVhNYDK
   NhrOqIApezCaZYrY76GNrduy9mLAdyyR0hns2+aYVp7BkXt2XEEsDNcct
   A=;
X-IronPort-AV: E=Sophos;i="6.01,197,1684800000"; 
   d="scan'208";a="659285490"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-b5bd57cf.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 18:00:03 +0000
Received: from EX19D007EUA002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1a-m6i4x-b5bd57cf.us-east-1.amazon.com (Postfix) with ESMTPS id 6728F466CE;
        Tue, 11 Jul 2023 18:00:00 +0000 (UTC)
Received: from EX19D028EUB003.ant.amazon.com (10.252.61.31) by
 EX19D007EUA002.ant.amazon.com (10.252.50.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 11 Jul 2023 17:59:53 +0000
Received: from u95c7fd9b18a35b.ant.amazon.com.amazon.com (10.85.143.174) by
 EX19D028EUB003.ant.amazon.com (10.252.61.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 11 Jul 2023 17:59:48 +0000
References: <20230711013621.GE1926@templeofstupid.com>
User-agent: mu4e 1.10.3; emacs 28.2
From:   Shay Agroskin <shayagr@amazon.com>
To:     Krister Johansen <kjlx@templeofstupid.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Arthur Kiyanovski" <akiyano@amazon.com>,
        David Arinzon <darinzon@amazon.com>,
        "Noam Dagan" <ndagan@amazon.com>,
        Saeed Bishara <saeedb@amazon.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: ena: fix shift-out-of-bounds in exponential
 backoff
Date:   Tue, 11 Jul 2023 20:47:32 +0300
In-Reply-To: <20230711013621.GE1926@templeofstupid.com>
Message-ID: <pj41zllefmpbw7.fsf@u95c7fd9b18a35b.ant.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Originating-IP: [10.85.143.174]
X-ClientProxiedBy: EX19D032UWB002.ant.amazon.com (10.13.139.190) To
 EX19D028EUB003.ant.amazon.com (10.252.61.31)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Krister Johansen <kjlx@templeofstupid.com> writes:

> The ENA adapters on our instances occasionally reset.  Once 
> recently
> logged a UBSAN failure to console in the process:
>
>   UBSAN: shift-out-of-bounds in 
>   build/linux/drivers/net/ethernet/amazon/ena/ena_com.c:540:13
>   shift exponent 32 is too large for 32-bit type 'unsigned int'
>   CPU: 28 PID: 70012 Comm: kworker/u72:2 Kdump: loaded not 
>   tainted 5.15.117
>   Hardware name: Amazon EC2 c5d.9xlarge/, BIOS 1.0 10/16/2017
>   Workqueue: ena ena_fw_reset_device [ena]
>   Call Trace:
>   <TASK>
>   dump_stack_lvl+0x4a/0x63
>   dump_stack+0x10/0x16
>   ubsan_epilogue+0x9/0x36
>   __ubsan_handle_shift_out_of_bounds.cold+0x61/0x10e
>   ? __const_udelay+0x43/0x50
>   ena_delay_exponential_backoff_us.cold+0x16/0x1e [ena]
>   wait_for_reset_state+0x54/0xa0 [ena]
>   ena_com_dev_reset+0xc8/0x110 [ena]
>   ena_down+0x3fe/0x480 [ena]
>   ena_destroy_device+0xeb/0xf0 [ena]
>   ena_fw_reset_device+0x30/0x50 [ena]
>   process_one_work+0x22b/0x3d0
>   worker_thread+0x4d/0x3f0
>   ? process_one_work+0x3d0/0x3d0
>   kthread+0x12a/0x150
>   ? set_kthread_struct+0x50/0x50
>   ret_from_fork+0x22/0x30
>   </TASK>
>
> Apparently, the reset delays are getting so large they can 
> trigger a
> UBSAN panic.
>
> Looking at the code, the current timeout is capped at 5000us. 
> Using a
> base value of 100us, the current code will overflow after 
> (1<<29).  Even
> at values before 32, this function wraps around, perhaps
> unintentionally.
>
> Cap the value of the exponent used for this backoff at (1<<16) 
> which is
> larger than currently necessary, but large enough to support 
> bigger
> values in the future.
>
> Cc: stable@vger.kernel.org
> Fixes: 4bb7f4cf60e3 ("net: ena: reduce driver load time")
> Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
> ---
>  drivers/net/ethernet/amazon/ena/ena_com.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c 
> b/drivers/net/ethernet/amazon/ena/ena_com.c
> index 451c3a1b6255..633b321d7fdd 100644
> --- a/drivers/net/ethernet/amazon/ena/ena_com.c
> +++ b/drivers/net/ethernet/amazon/ena/ena_com.c
> @@ -35,6 +35,8 @@
>  
>  #define ENA_REGS_ADMIN_INTR_MASK 1
>  
> +#define ENA_MAX_BACKOFF_DELAY_EXP 16U
> +
>  #define ENA_MIN_ADMIN_POLL_US 100
>  
>  #define ENA_MAX_ADMIN_POLL_US 5000
> @@ -536,6 +538,7 @@ static int 
> ena_com_comp_status_to_errno(struct ena_com_admin_queue 
> *admin_queue,
>  
>  static void ena_delay_exponential_backoff_us(u32 exp, u32 
>  delay_us)
>  {
> +	exp = min_t(u32, exp, ENA_MAX_BACKOFF_DELAY_EXP);
>  	delay_us = max_t(u32, ENA_MIN_ADMIN_POLL_US, delay_us);
>  	delay_us = min_t(u32, delay_us * (1U << exp), 
>  ENA_MAX_ADMIN_POLL_US);
>  	usleep_range(delay_us, 2 * delay_us);

Hi, thanks for submitting this patch (:

Going over the logic here, the driver sleeps for `delay_us` 
micro-seconds in each iteration that this function gets called.

For an exp = 14 it'd sleep (I added units notation)
delay_us * (2 ^ exp) us = 100 * (2 ^ 14) us = (10 * (2 ^ 14)) / 
(1000000) s = 1.6 s

For an exp = 15 it'd sleep
(10 * (2 ^ 15)) / (1000000) = 3.2s

To even get close to an overflow value, say exp=29 the driver 
would sleep in a single iteration
53687 s = 14.9 hours.

The driver should stop trying to get a response from the device 
after a timeout period received from the device which is 3 seconds 
by default.

The point being, it seems very unlikely to hit this overflow. Did 
you experience it or was the issue discovered by a static analyzer 
?

Regarding the patch itself, I don't mind adding it since exp=16 
limit should be more than enough to wait for the device's 
response.
Reviewed-by: Shay Agroskin <shayagr@amazon.com>

Thanks,
Shay

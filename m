Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6C9610D9A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 11:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiJ1Jrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 05:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJ1Jri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 05:47:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E91561C4EC7;
        Fri, 28 Oct 2022 02:47:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FA6F1FB;
        Fri, 28 Oct 2022 02:47:42 -0700 (PDT)
Received: from [10.57.2.46] (unknown [10.57.2.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 26C863F71A;
        Fri, 28 Oct 2022 02:47:33 -0700 (PDT)
Message-ID: <649af0f6-e5e2-c450-879c-e9153e0c0abc@arm.com>
Date:   Fri, 28 Oct 2022 11:47:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [ANNOUNCE] v6.0.5-rt14
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Pierre Gondois <pierre.gondois@arm.com>
References: <Y1o8hqwQKDpOTkNr@linutronix.de>
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <Y1o8hqwQKDpOTkNr@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sebastian,
About the issues Valentin reported:

- [SPLAT 1/3] arm_pmu: Sleeping spinlocks down armpmu_alloc_atomic()
will be fixed by:
https://lore.kernel.org/all/20220930111844.1522365-1-mark.rutland@arm.com/

- [SPLAT 2/3] irqchip/gic-v3-its: Sleeping spinlocks down gic_reserve_range()
was fixed by:
https://lore.kernel.org/lkml/20211027151506.2085066-3-valentin.schneider@arm.com/

- [SPLAT 3/3] gpio: dwapb: Sleeping spinlocks down IRQ mapping
was fixed by:
https://lore.kernel.org/all/20220419012810.88417-1-schspa@gmail.com/

Regards,
Pierre

On 10/27/22 10:08, Sebastian Andrzej Siewior wrote:
> Dear RT folks!
> 
> I'm pleased to announce the v6.0.5-rt14 patch set.
> 
> Changes since v6.0.5-rt13:
> 
>    - Replace deprecated API in the Xilinx AXI Ethernet driver so that it
>      compiles again. Reported by David Runge.
> 
> Known issues
>       - Valentin Schneider reported a few splats on ARM64, see
>            https://lkml.kernel.org/r/20210810134127.1394269-1-valentin.schneider@arm.com
> 
> The delta patch against v6.0.5-rt13 is appended below and can be found here:
>   
>       https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.0/incr/patch-6.0.5-rt13-rt14.patch.xz
> 
> You can get this release via the git tree at:
> 
>      git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.0.5-rt14
> 
> The RT patch against v6.0.5 can be found here:
> 
>      https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.0/older/patch-6.0.5-rt14.patch.xz
> 
> The split quilt queue is available at:
> 
>      https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.0/older/patches-6.0.5-rt14.tar.xz
> 
> Sebastian
> 
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index 9262988d26a32..2c233b59e7d93 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -1305,16 +1305,16 @@ axienet_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
>   	netdev_stats_to_stats64(stats, &dev->stats);
>   
>   	do {
> -		start = u64_stats_fetch_begin_irq(&lp->rx_stat_sync);
> +		start = u64_stats_fetch_begin(&lp->rx_stat_sync);
>   		stats->rx_packets = u64_stats_read(&lp->rx_packets);
>   		stats->rx_bytes = u64_stats_read(&lp->rx_bytes);
> -	} while (u64_stats_fetch_retry_irq(&lp->rx_stat_sync, start));
> +	} while (u64_stats_fetch_retry(&lp->rx_stat_sync, start));
>   
>   	do {
> -		start = u64_stats_fetch_begin_irq(&lp->tx_stat_sync);
> +		start = u64_stats_fetch_begin(&lp->tx_stat_sync);
>   		stats->tx_packets = u64_stats_read(&lp->tx_packets);
>   		stats->tx_bytes = u64_stats_read(&lp->tx_bytes);
> -	} while (u64_stats_fetch_retry_irq(&lp->tx_stat_sync, start));
> +	} while (u64_stats_fetch_retry(&lp->tx_stat_sync, start));
>   }
>   
>   static const struct net_device_ops axienet_netdev_ops = {
> diff --git a/localversion-rt b/localversion-rt
> index 9f7d0bdbffb18..08b3e75841adc 100644
> --- a/localversion-rt
> +++ b/localversion-rt
> @@ -1 +1 @@
> --rt13
> +-rt14

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA4F749AC8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 13:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbjGFLgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 07:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjGFLgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 07:36:35 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837381727;
        Thu,  6 Jul 2023 04:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688643394; x=1720179394;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8zcb7k+92vQ8AkY1CLmC+r+SOKYrdc1egYkxSlfdBG8=;
  b=hUW/W82o/v2dGCvSB3Qq1aX06KAZQmouDJRHddhJGkFoICcr3LrXvXFx
   HXsJI7H0oFUDOhB2cmREcRiUMfabVVHDFBwtBt7nEkOFaocKscEM91qLc
   MW9GVu4xqgzeiRet88VMyfHr07nkyITa8p5SyXPxVSs3Ut+Ld2KCxewgr
   jrnYz8uItlH0ZHxJyOHNGIlUT9EYr8LlzSD1JjA+dNy2hV8CIapoE6xVx
   NzWbItcXdSeCB7kXu+wV2QnmqO55EIuPV7JU1Yekljxuom9YyDeD24mJ8
   wErmvs35G42FWkkIC/+l5lXB2p17VM28ZL4C51vXptFeU6L5kIB6ZYmaF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="348366966"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="348366966"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 04:36:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="832912315"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="832912315"
Received: from naamamex-mobl.ger.corp.intel.com (HELO [10.251.186.106]) ([10.251.186.106])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 04:36:29 -0700
Message-ID: <5ba1add3-c2a0-127b-49d8-509bc0508b59@linux.intel.com>
Date:   Thu, 6 Jul 2023 14:36:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [Intel-wired-lan] [PATCH net v2 6/6] igc: Fix inserting of empty
 frame for launchtime
Content-Language: en-US
To:     Florian Kauer <florian.kauer@linutronix.de>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Tan Tee Min <tee.min.tan@linux.intel.com>,
        Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>,
        Aravindhan Gunasekaran <aravindhan.gunasekaran@intel.com>,
        Malli C <mallikarjuna.chilakala@intel.com>
Cc:     netdev@vger.kernel.org, kurt@linutronix.de,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
References: <20230619100858.116286-1-florian.kauer@linutronix.de>
 <20230619100858.116286-7-florian.kauer@linutronix.de>
From:   "naamax.meir" <naamax.meir@linux.intel.com>
In-Reply-To: <20230619100858.116286-7-florian.kauer@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/2023 13:08, Florian Kauer wrote:
> The insertion of an empty frame was introduced with
> commit db0b124f02ba ("igc: Enhance Qbv scheduling by using first flag bit")
> in order to ensure that the current cycle has at least one packet if
> there is some packet to be scheduled for the next cycle.
> 
> However, the current implementation does not properly check if
> a packet is already scheduled for the current cycle. Currently,
> an empty packet is always inserted if and only if
> txtime >= end_of_cycle && txtime > last_tx_cycle
> but since last_tx_cycle is always either the end of the current
> cycle (end_of_cycle) or the end of a previous cycle, the
> second part (txtime > last_tx_cycle) is always true unless
> txtime == last_tx_cycle.
> 
> What actually needs to be checked here is if the last_tx_cycle
> was already written within the current cycle, so an empty frame
> should only be inserted if and only if
> txtime >= end_of_cycle && end_of_cycle > last_tx_cycle.
> 
> This patch does not only avoid an unnecessary insertion, but it
> can actually be harmful to insert an empty packet if packets
> are already scheduled in the current cycle, because it can lead
> to a situation where the empty packet is actually processed
> as the first packet in the upcoming cycle shifting the packet
> with the first_flag even one cycle into the future, finally leading
> to a TX hang.
> 
> The TX hang can be reproduced on a i225 with:
> 
>      sudo tc qdisc replace dev enp1s0 parent root handle 100 taprio \
> 	    num_tc 1 \
> 	    map 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 \
> 	    queues 1@0 \
> 	    base-time 0 \
> 	    sched-entry S 01 300000 \
> 	    flags 0x1 \
> 	    txtime-delay 500000 \
> 	    clockid CLOCK_TAI
>      sudo tc qdisc replace dev enp1s0 parent 100:1 etf \
> 	    clockid CLOCK_TAI \
> 	    delta 500000 \
> 	    offload \
> 	    skip_sock_check
> 
> and traffic generator
> 
>      sudo trafgen -i traffic.cfg -o enp1s0 --cpp -n0 -q -t1400ns
> 
> with traffic.cfg
> 
>      #define ETH_P_IP        0x0800
> 
>      {
>        /* Ethernet Header */
>        0x30, 0x1f, 0x9a, 0xd0, 0xf0, 0x0e,  # MAC Dest - adapt as needed
>        0x24, 0x5e, 0xbe, 0x57, 0x2e, 0x36,  # MAC Src  - adapt as needed
>        const16(ETH_P_IP),
> 
>        /* IPv4 Header */
>        0b01000101, 0,   # IPv4 version, IHL, TOS
>        const16(1028),   # IPv4 total length (UDP length + 20 bytes (IP header))
>        const16(2),      # IPv4 ident
>        0b01000000, 0,   # IPv4 flags, fragmentation off
>        64,              # IPv4 TTL
>        17,              # Protocol UDP
>        csumip(14, 33),  # IPv4 checksum
> 
>        /* UDP Header */
>        10,  0, 48, 1,   # IP Src - adapt as needed
>        10,  0, 48, 10,  # IP Dest - adapt as needed
>        const16(5555),   # UDP Src Port
>        const16(6666),   # UDP Dest Port
>        const16(1008),   # UDP length (UDP header 8 bytes + payload length)
>        csumudp(14, 34), # UDP checksum
> 
>        /* Payload */
>        fill('W', 1000),
>      }
> 
> and the observed message with that is for example
> 
>   igc 0000:01:00.0 enp1s0: Detected Tx Unit Hang
>     Tx Queue             <0>
>     TDH                  <32>
>     TDT                  <3c>
>     next_to_use          <3c>
>     next_to_clean        <32>
>   buffer_info[next_to_clean]
>     time_stamp           <ffff26a8>
>     next_to_watch        <00000000632a1828>
>     jiffies              <ffff27f8>
>     desc.status          <1048000>
> 
> Fixes: db0b124f02ba ("igc: Enhance Qbv scheduling by using first flag bit")
> Signed-off-by: Florian Kauer <florian.kauer@linutronix.de>
> Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Naama Meir <naamax.meir@linux.intel.com>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C947D746DBD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 11:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbjGDJiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 05:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbjGDJiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 05:38:03 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B332D76;
        Tue,  4 Jul 2023 02:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688463363; x=1719999363;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KzSG8zPwxiuEhCxKa+1sGQKJsFvciwT8AUYmTM/7rrg=;
  b=K8pfJC7dB+QDBB88vvoTNlk2jv7YPSAayNtoU14QXxQaaStMDMvzBPy0
   9tjbBQUzgPW/5LP744ALR3y0bZxfhYlJ1FNVf9wvgE9DLFPwJkfdbtHo8
   0vwHl6XIMkgc3WGOIMEmY9SzSDN0aDJ1m2tRkQmOUQ4Im0SFqx//oODVT
   G8PIY5aQtjHvlIrmTkiUfCsX8AUDiIu3VyHSP+UhGMir11KwzCPebXjJz
   jUuq40hzKJd99Kq8bx/BrnUuYd5ipKG4SpFA/ngyxBxZYIHvtExb0Nb8d
   O48z+nqAaJDXMm+vZ8qS+gBa+RLh7q1k3HkeP3HiRkpOkTLcJYO9S7i3n
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="366564134"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="366564134"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2023 02:35:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="696093980"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="696093980"
Received: from naamamex-mobl.ger.corp.intel.com (HELO [10.13.12.63]) ([10.13.12.63])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2023 02:35:01 -0700
Message-ID: <6136a4bd-1818-f875-5355-547ffb3bd25b@linux.intel.com>
Date:   Tue, 4 Jul 2023 12:34:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [Intel-wired-lan] [PATCH net v2 4/6] igc: No strict mode in pure
 launchtime/CBS offload
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
 <20230619100858.116286-5-florian.kauer@linutronix.de>
From:   "naamax.meir" <naamax.meir@linux.intel.com>
In-Reply-To: <20230619100858.116286-5-florian.kauer@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/2023 13:08, Florian Kauer wrote:
> The flags IGC_TXQCTL_STRICT_CYCLE and IGC_TXQCTL_STRICT_END
> prevent the packet transmission over slot and cycle boundaries.
> This is important for taprio offload where the slots and
> cycles correspond to the slots and cycles configured for the
> network.
> 
> However, the Qbv offload feature of the i225 is also used for
> enabling TX launchtime / ETF offload. In that case, however,
> the cycle has no meaning for the network and is only used
> internally to adapt the base time register after a second has
> passed.
> 
> Enabling strict mode in this case would unneccesarily prevent
> the transmission of certain packets (i.e. at the boundary of a
> second) and thus interfers with the ETF qdisc that promises
> transmission at a certain point in time.
> 
> Similar to ETF, this also applies to CBS offload that also should
> not be influenced by strict mode unless taprio offload would be
> enabled at the same time.
> 
> This fully reverts
> commit d8f45be01dd9 ("igc: Use strict cycles for Qbv scheduling")
> but its commit message only describes what was already implemented
> before that commit. The difference to a plain revert of that commit
> is that it now copes with the base_time = 0 case that was fixed with
> commit e17090eb2494 ("igc: allow BaseTime 0 enrollment for Qbv")
> 
> In particular, enabling strict mode leads to TX hang situations
> under high traffic if taprio is applied WITHOUT taprio offload
> but WITH ETF offload, e.g. as in
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
>     TDH                  <d0>
>     TDT                  <f0>
>     next_to_use          <f0>
>     next_to_clean        <d0>
>   buffer_info[next_to_clean]
>     time_stamp           <ffff661f>
>     next_to_watch        <00000000245a4efb>
>     jiffies              <ffff6e48>
>     desc.status          <1048000>
> 
> Fixes: d8f45be01dd9 ("igc: Use strict cycles for Qbv scheduling")
> Signed-off-by: Florian Kauer <florian.kauer@linutronix.de>
> Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---
>   drivers/net/ethernet/intel/igc/igc_tsn.c | 24 ++++++++++++++++++++++--
>   1 file changed, 22 insertions(+), 2 deletions(-)

Tested-by: Naama Meir <naamax.meir@linux.intel.com>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C404745769
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 10:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjGCIfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 04:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjGCIex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 04:34:53 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D984DD;
        Mon,  3 Jul 2023 01:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688373292; x=1719909292;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7kbif9bfnNgRHrXrFMABWk7zXjF8D6a49xUb4z1x3J8=;
  b=EDgGbf/46vhrppbnxJa+FD1hxPJQF3Ixnj0JzyGit15dtH/CTo3GqRk5
   +YBVilG9wMdsBSeSpVdtxnUbsuelgAbPlTLZ1cCWNkipzy3duPpTAxbxj
   HmWtgsXhIdv+fcplb6wSvngIvHKBHeWrF2yGaSrbgbIhZVCejhCY6PLwW
   qb25/z95k0M8Tbbgr54AOrhlYnUrTo0gjAsow1aSZRhE3plJUsLvqlZHP
   99lnWHYEqonKtaNuw3btRNNYkiG1Yah4ARinIFuVJ9jxwiJ3IO0eYn3uz
   nOjjuPmsjPsnZr6QAMhU0C2LnE3/ZLE8ngm8BBl0TAE/IX2zBfyjN71PM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="426508743"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="426508743"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 01:34:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="788447778"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="788447778"
Received: from naamamex-mobl.ger.corp.intel.com (HELO [10.13.12.63]) ([10.13.12.63])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 01:34:47 -0700
Message-ID: <f14f0d50-2569-0d47-91d6-23c1f99712ad@linux.intel.com>
Date:   Mon, 3 Jul 2023 11:34:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [Intel-wired-lan] [PATCH net v2 2/6] igc: Do not enable taprio
 offload for invalid arguments
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
 <20230619100858.116286-3-florian.kauer@linutronix.de>
From:   "naamax.meir" <naamax.meir@linux.intel.com>
In-Reply-To: <20230619100858.116286-3-florian.kauer@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/2023 13:08, Florian Kauer wrote:
> Only set adapter->taprio_offload_enable after validating the arguments.
> Otherwise, it stays set even if the offload was not enabled.
> Since the subsequent code does not get executed in case of invalid
> arguments, it will not be read at first.
> However, by activating and then deactivating another offload
> (e.g. ETF/TX launchtime offload), taprio_offload_enable is read
> and erroneously keeps the offload feature of the NIC enabled.
> 
> This can be reproduced as follows:
> 
>      # TAPRIO offload (flags == 0x2) and negative base-time leading to expected -ERANGE
>      sudo tc qdisc replace dev enp1s0 parent root handle 100 stab overhead 24 taprio \
> 	    num_tc 1 \
> 	    map 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 \
> 	    queues 1@0 \
> 	    base-time -1000 \
> 	    sched-entry S 01 300000 \
> 	    flags 0x2
> 
>      # IGC_TQAVCTRL is 0x0 as expected (iomem=relaxed for reading register)
>      sudo pcimem /sys/bus/pci/devices/0000:01:00.0/resource0 0x3570 w*1
> 
>      # Activate ETF offload
>      sudo tc qdisc replace dev enp1s0 parent root handle 6666 mqprio \
> 	    num_tc 3 \
> 	    map 2 2 1 0 2 2 2 2 2 2 2 2 2 2 2 2 \
> 	    queues 1@0 1@1 2@2 \
> 	    hw 0
>      sudo tc qdisc add dev enp1s0 parent 6666:1 etf \
> 	    clockid CLOCK_TAI \
> 	    delta 500000 \
> 	    offload
> 
>      # IGC_TQAVCTRL is 0x9 as expected
>      sudo pcimem /sys/bus/pci/devices/0000:01:00.0/resource0 0x3570 w*1
> 
>      # Deactivate ETF offload again
>      sudo tc qdisc delete dev enp1s0 parent 6666:1
> 
>      # IGC_TQAVCTRL should now be 0x0 again, but is observed as 0x9
>      sudo pcimem /sys/bus/pci/devices/0000:01:00.0/resource0 0x3570 w*1
> 
> Fixes: e17090eb2494 ("igc: allow BaseTime 0 enrollment for Qbv")
> Signed-off-by: Florian Kauer <florian.kauer@linutronix.de>
> Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)


Tested-by: Naama Meir <naamax.meir@linux.intel.com>

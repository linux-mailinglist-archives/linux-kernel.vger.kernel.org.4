Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197057468F6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 07:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjGDF3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 01:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjGDF3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 01:29:05 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B7AE52;
        Mon,  3 Jul 2023 22:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688448544; x=1719984544;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Oa4QuauqJ+8TcHeLgAPnDEQ9ZUhBWWVcqLElYpzmNJM=;
  b=IOfYJ16r2o+lJ5GatsgZSd+psAQ0uEflx/gtd2Gi8uCJbhz9W30a+k66
   bxoyZSz9sF7SZZxeVXnkGaum2tZfEh9r6fLt24Qxq+8dLQUmV94oBrkoz
   JdIGbBulJUTurgTAT4j3kXzcxKGbs2ZuNLaxJiw/kZrS8o1kqXdBEkMQN
   99dtrGlgWXxMEXmhMcJ6IAZSkoGCGtyWGsb/FRsKs+om3CXgAzQuAv7W9
   VHXv+EPEcpcXjV6FjKuaD0pEUP2R2gsi5Z82XnlGFfna7YVcSx1NHdonC
   iYZCgJ1A8nQbE8WWO5rDhfA3RbQ/4RDDM6hbsitKQ3Vahci7tJBC2LE8T
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="361899018"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="361899018"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 22:29:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="808794648"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="808794648"
Received: from naamamex-mobl.ger.corp.intel.com (HELO [10.13.12.63]) ([10.13.12.63])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 22:28:58 -0700
Message-ID: <a0f3166c-b520-d3db-6131-fb29809463a9@linux.intel.com>
Date:   Tue, 4 Jul 2023 08:28:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [Intel-wired-lan] [PATCH net v2 3/6] igc: Handle already enabled
 taprio offload for basetime 0
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
 <20230619100858.116286-4-florian.kauer@linutronix.de>
From:   "naamax.meir" <naamax.meir@linux.intel.com>
In-Reply-To: <20230619100858.116286-4-florian.kauer@linutronix.de>
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
> Since commit e17090eb2494 ("igc: allow BaseTime 0 enrollment for Qbv")
> it is possible to enable taprio offload with a basetime of 0.
> However, the check if taprio offload is already enabled for i225
> (and thus -EALREADY should be returned for igc_save_qbv_schedule)
> still relied on adapter->base_time > 0.
> 
> This can be reproduced as follows:
> 
>      # TAPRIO offload (flags == 0x2) and base-time = 0
>      sudo tc qdisc replace dev enp1s0 parent root handle 100 stab overhead 24 taprio \
> 	    num_tc 1 \
> 	    map 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 \
> 	    queues 1@0 \
> 	    base-time 0 \
> 	    sched-entry S 01 300000 \
> 	    flags 0x2
> 
>      # The second call should fail with "Error: Device failed to setup taprio offload."
>      # But that only happens if base-time was != 0
>      sudo tc qdisc replace dev enp1s0 parent root handle 100 stab overhead 24 taprio \
> 	    num_tc 1 \
> 	    map 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 \
> 	    queues 1@0 \
> 	    base-time 0 \
> 	    sched-entry S 01 300000 \
> 	    flags 0x2
> 
> Fixes: e17090eb2494 ("igc: allow BaseTime 0 enrollment for Qbv")
> Signed-off-by: Florian Kauer <florian.kauer@linutronix.de>
> Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Naama Meir <naamax.meir@linux.intel.com>

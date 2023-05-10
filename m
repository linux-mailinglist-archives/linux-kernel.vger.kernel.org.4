Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112EE6FE40D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 20:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbjEJSdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 14:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjEJSdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 14:33:45 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4B14218;
        Wed, 10 May 2023 11:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683743623; x=1715279623;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cZHKy3qFnXzOdsAVgrXfEVaDKKIEoFMoaEr0k1VVZ5g=;
  b=mu/kCrpzpxhuxGzoCbPnoHGrfLpNdfn+D5JVLyrdJcc+G1ZaXlPmHCoW
   aePJOQP7oTc/zo49aITHoZ6TM8VOwG9vrpg3FtZZp7BkxMBIyVxJYQrlG
   ro4U4AteoHOyvoRWDr22A2gz1Irl8YLWzw3ProYTf5TMxihdZX+QJqDZ0
   c8E1XvxpDzIP881BrOQ31cTsFdJ56cqAumShcOGBK0XUdDCQFX4mR9Lgc
   aZIZBzXDoWu3j7oRNyEdxvxfebQh5ognf028Mev8joYTFzIAxQ7D10VbB
   Gj/8+OiRoUBfpZhwr0kORLPfgN92vxOPYfJymNI2Uo1gipJmvUY181XMx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="339542119"
X-IronPort-AV: E=Sophos;i="5.99,265,1677571200"; 
   d="scan'208";a="339542119"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 11:33:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="676943327"
X-IronPort-AV: E=Sophos;i="5.99,265,1677571200"; 
   d="scan'208";a="676943327"
Received: from saideepi-mobl1.amr.corp.intel.com (HELO [10.213.163.248]) ([10.213.163.248])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 11:33:40 -0700
Message-ID: <25fe5313-97de-1528-e13e-f3b6286a8385@intel.com>
Date:   Wed, 10 May 2023 11:33:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [tip: perf/core] x86/cpu: Add helper function to get the type of
 the current hybrid CPU
Content-Language: en-US
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Len Brown <len.brown@intel.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org
References: <1618237865-33448-3-git-send-email-kan.liang@linux.intel.com>
 <161891560955.29796.10811256921836669612.tip-bot2@tip-bot2>
 <55343361-d991-c157-4a88-843947aa45ff@intel.com>
 <20230510181815.GA18418@ranerica-svr.sc.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230510181815.GA18418@ranerica-svr.sc.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/23 11:18, Ricardo Neri wrote:
>> Sorry to dredge up an old thread.  But, where does this information
>> about "If the processor is not hybrid, returns 0." come from?
>>
>> What is there to keep cpuid_eax(0x0000001a) from having 0x0 in those
>> bits?  Seems to me like 0 is theoretically a valid hybrid CPU type.  Right?
> My reasoning was that according to the Intel SDM the only valid values were
> 0x20 and 0x40. 0 was meant to be an invalid value.

That doesn't make any sense to me really.  Just because today's SDM
doesn't have a value doesn't mean that it becomes an invalid value tomorrow.

For instance, there's no model 0xEE today.  But that doesn't make it
*INVALID*, it just means there's not one defined *today*.  Today's
kernel shouldn't fall over if it runs on an model==0xEE system.

> I read the SDM again. It seems that cpuid_eax(0x0000001a) already returns
> 0 when the leaf does not exist.

Right, but this isn't really relevant here either.  A CPU's APICID comes
out of a leaf that can be unsupported (not exist).  That doesn't make
APICID==0 invalid in any way.

> Probably the check for X86_FEATURE_HYBRID_CPU is not needed.
> 
> Still, callers need to check for a valid value, IMO.

Right.  But if they're just going to check the number that comes back
from this function, 0 can't represent an invalid value.

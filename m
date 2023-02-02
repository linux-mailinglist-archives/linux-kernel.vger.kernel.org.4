Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357AC68803A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 15:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbjBBOfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 09:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBBOe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 09:34:59 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98058C1D4
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 06:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675348466; x=1706884466;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=d2Dt32841orMIWS7rMC8gsnrikgsCP7sdIy/OgSWK0A=;
  b=aM2A13yBFFQEdND+CSKBOpMbtYQmV5/W/56fH8NazegdOWZkt5FUSs5K
   itWq0KYcYaAFk7U66EuiITi7O0R+Knxj6XwFslmlypG8UGlxSt2N3fVdQ
   fHO3ZE3wN8YbnUbnMq51+bijZOdgODZ7yaSoJp9spy5m6GpWTnqSLwdB9
   ewa5OJI8M9+54lEh+/v3llbSWKX2wN/LKJIlF7NZPjwNVBUw2vqLNV6xG
   LGoElqQLxfJPPF3g1qcGKbR8zteOGmJTf/UInCZMmLvoaCidCFY7lUbea
   J7yqPhwvgFin/PbB2rJvk9BTzH/GWQjofxLI68HTn+lqrBu4Uj/5rPCyy
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="393038472"
X-IronPort-AV: E=Sophos;i="5.97,267,1669104000"; 
   d="scan'208";a="393038472"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 06:34:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="773912823"
X-IronPort-AV: E=Sophos;i="5.97,267,1669104000"; 
   d="scan'208";a="773912823"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 02 Feb 2023 06:34:05 -0800
Received: from [10.209.74.84] (kliang2-mobl1.ccr.corp.intel.com [10.209.74.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 07D005808BA;
        Thu,  2 Feb 2023 06:34:03 -0800 (PST)
Message-ID: <79807730-73ac-c8c2-fc9d-b7cd00f9336e@linux.intel.com>
Date:   Thu, 2 Feb 2023 09:34:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V2 7/9] perf/x86/msr: Add Meteor Lake support
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, ak@linux.intel.com,
        eranian@google.com, irogers@google.com
References: <20230104201349.1451191-1-kan.liang@linux.intel.com>
 <20230104201349.1451191-7-kan.liang@linux.intel.com>
 <Y9sWImm4v5I/MZId@kernel.org>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <Y9sWImm4v5I/MZId@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On 2023-02-01 8:47 p.m., Arnaldo Carvalho de Melo wrote:
> Em Wed, Jan 04, 2023 at 12:13:47PM -0800, kan.liang@linux.intel.com escreveu:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> Meteor Lake is Intel's successor to Raptor lake. PPERF and SMI_COUNT MSRs
>> are also supported.
>>
>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
> 
> Did the kernel bits land upstream?
Yes, the kernel part has been merged into the tip.git perf/core branch.

Thanks for checking the status. There are two perf tool patches in this
series, which hasn't been merged. Should I resend them?

Thanks,
Kan
> 
> - Arnaldo
>  
>> No change since V1
>>
>>  arch/x86/events/msr.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
>> index ecced3a52668..074150d28fa8 100644
>> --- a/arch/x86/events/msr.c
>> +++ b/arch/x86/events/msr.c
>> @@ -107,6 +107,8 @@ static bool test_intel(int idx, void *data)
>>  	case INTEL_FAM6_RAPTORLAKE:
>>  	case INTEL_FAM6_RAPTORLAKE_P:
>>  	case INTEL_FAM6_RAPTORLAKE_S:
>> +	case INTEL_FAM6_METEORLAKE:
>> +	case INTEL_FAM6_METEORLAKE_L:
>>  		if (idx == PERF_MSR_SMI || idx == PERF_MSR_PPERF)
>>  			return true;
>>  		break;
>> -- 
>> 2.35.1
> 

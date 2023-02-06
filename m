Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B40A68C12C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 16:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjBFPRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 10:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjBFPRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 10:17:51 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A33768D
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 07:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675696670; x=1707232670;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BBUrAInWN7Whu/fLTejVQTFsfI/Yocj5UCdKvaIxvf0=;
  b=btzlCUk2isQxNCuYRvu59lfAsHC0GunKHYq/D1jWfPD1r4nPRDeMCRuJ
   B5AEzNdIkwftC9clxrTKpufSKrmv1a6IzyWJYPUDBnIw0qA4cykPzTVbf
   qd5m2yCGF3f8K9YFdMICvSBO0ajYUlgPMWq4pPSFPGirHoeltH1hU2Kmr
   TVWxc3neJ4/3c/3F6v+oVM/7UnLO4Sq7vjbVfDeZnUj3EHCzqifuJx3Um
   dkNKIMBB6V0bsC7WJLsT4dzY3X9rpKIvMERMYTyyz+9ZOapv1eGSmXgMi
   QKn04Fez1WW1oIa5UF2kAkDmMNfmi/wXPObB7BG1DEi8hlqM+3YBZPEX9
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="331360207"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="331360207"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 07:17:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="696888100"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="696888100"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 06 Feb 2023 07:17:48 -0800
Received: from [10.212.205.76] (kliang2-mobl1.ccr.corp.intel.com [10.212.205.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 1D7DE58068A;
        Mon,  6 Feb 2023 07:17:48 -0800 (PST)
Message-ID: <8e493d2f-827a-03d9-610b-6246502bf92a@linux.intel.com>
Date:   Mon, 6 Feb 2023 10:17:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V3 3/3] perf test: Support the retire_lat check
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, ak@linux.intel.com,
        eranian@google.com, irogers@google.com
References: <20230202192209.1795329-1-kan.liang@linux.intel.com>
 <20230202192209.1795329-3-kan.liang@linux.intel.com>
 <Y+EWWLaBj1OPrkLo@kernel.org>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <Y+EWWLaBj1OPrkLo@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-02-06 10:01 a.m., Arnaldo Carvalho de Melo wrote:
> Em Thu, Feb 02, 2023 at 11:22:09AM -0800, kan.liang@linux.intel.com escreveu:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> Add test for the new field for Retire Latency in the X86 specific test.
> 
> Is this passing 'perf test' for you?

Ah, it should be the original V2 missed the below change.

@@ -100,5 +101,25 @@ void arch_perf_synthesize_sample_weight(const
struct perf_sample *data,
 	if (type & PERF_SAMPLE_WEIGHT_STRUCT) {
 		*array &= 0xffffffff;
 		*array |= ((u64)data->ins_lat << 32);
+		*array |= ((u64)data->retire_lat << 48);
 	}
 }

Could you please remove the V2 and re-apply the V3?

$ sudo ./perf test -v "x86 sample parsing"
 74: x86 Sample parsing                                              :
--- start ---
test child forked, pid 3316797
test child finished with 0
---- end ----
x86 Sample parsing: Ok


Thanks,
Kan

> 
> [root@quaco ~]# perf test -v "x86 sample parsing"
>  74: x86 Sample parsing                                              :
> --- start ---
> test child forked, pid 72526
> Samples differ at 'retire_lat'
> parsing failed for sample_type 0x1000000
> test child finished with -1
> ---- end ----
> x86 Sample parsing: FAILED!
> [root@quaco ~]#
> 
> - Arnaldo
>  
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>
>> New patch since V2
>>
>>  tools/perf/arch/x86/tests/sample-parsing.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/arch/x86/tests/sample-parsing.c b/tools/perf/arch/x86/tests/sample-parsing.c
>> index 690c7c07e90d..a061e8619267 100644
>> --- a/tools/perf/arch/x86/tests/sample-parsing.c
>> +++ b/tools/perf/arch/x86/tests/sample-parsing.c
>> @@ -27,8 +27,10 @@ static bool samples_same(const struct perf_sample *s1,
>>  			 const struct perf_sample *s2,
>>  			 u64 type)
>>  {
>> -	if (type & PERF_SAMPLE_WEIGHT_STRUCT)
>> +	if (type & PERF_SAMPLE_WEIGHT_STRUCT) {
>>  		COMP(ins_lat);
>> +		COMP(retire_lat);
>> +	}
>>  
>>  	return true;
>>  }
>> @@ -48,6 +50,7 @@ static int do_test(u64 sample_type)
>>  	struct perf_sample sample = {
>>  		.weight		= 101,
>>  		.ins_lat        = 102,
>> +		.retire_lat     = 103,
>>  	};
>>  	struct perf_sample sample_out;
>>  	size_t i, sz, bufsz;
>> -- 
>> 2.35.1
>>
> 

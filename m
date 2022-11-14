Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A6D627BE3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236056AbiKNLPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:15:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236758AbiKNLO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:14:58 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B9E21804;
        Mon, 14 Nov 2022 03:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668424244; x=1699960244;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2Ej8ZqKGhtg6fCWt9IDlcrUqusBuzvWifpdUzrFtTFE=;
  b=nJeYsI4shML2w/Ju1v1Y0sbrICNz2wW7+Dl3PzeHyK/fMzlyxyLNE5y8
   D6iFbLARjbPbxhsyZO3UHLPoKSO49wt6rQnZgjKE03lFGHzxyEaTI5/MV
   p4hVV3Ek3INcJ2TcMb2YpWuRlJUqfepRkokwbg5jkUEQH0fdLwwIfKkla
   /vu3bG1E7mejhbMcnoXYRCAFipFxGYkB60ZB4dCo8/CYRcwjfmcGZzD7+
   twzs0pNvmRk5mZmK/u6rfvHG6I8Wl8L3FIcLvafo+LE6Xos3aZ4oOJmZk
   xrOKjv//V3heoxARMt6i5iAAnb2ucRciwkbOe6lKDnqDEcrHGdb3XslPd
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="313088906"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="313088906"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 03:10:44 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="640730133"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="640730133"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.58.157])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 03:10:42 -0800
Message-ID: <dfbeecdb-c97c-993f-da03-5f3d1f141c61@intel.com>
Date:   Mon, 14 Nov 2022 13:10:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH] perf/x86/intel/pt: Fix sampling using single range output
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org
References: <20221112151508.13768-1-adrian.hunter@intel.com>
 <Y3IdnRgEPq2FN/ZX@hirez.programming.kicks-ass.net>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <Y3IdnRgEPq2FN/ZX@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/11/22 12:51, Peter Zijlstra wrote:
> On Sat, Nov 12, 2022 at 05:15:08PM +0200, Adrian Hunter wrote:
>> Deal with errata TGL052, ADL037 and RPL017 "Trace May Contain Incorrect
>> Data When Configured With Single Range Output Larger Than 4KB" by
>> disabling single range output whenever larger than 4KB.
>>
>> Fixes: 670638477aed ("perf/x86/intel/pt: Opportunistically use single range output mode")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>  arch/x86/events/intel/pt.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
>> index 82ef87e9a897..42a55794004a 100644
>> --- a/arch/x86/events/intel/pt.c
>> +++ b/arch/x86/events/intel/pt.c
>> @@ -1263,6 +1263,15 @@ static int pt_buffer_try_single(struct pt_buffer *buf, int nr_pages)
>>  	if (1 << order != nr_pages)
>>  		goto out;
>>  
>> +	/*
>> +	 * Some processors cannot always support single range for more than
>> +	 * 4KB - refer errata TGL052, ADL037 and RPL017. Future processors might
>> +	 * also be affected, so for now rather than trying to keep track of
>> +	 * which ones, just disable it for all.
>> +	 */
>> +	if (nr_pages > 1)
>> +		goto out;
> 
> This effectively declares single-output-mode dead? Because I don't think
> anybody uses PT with a single 4K buffer.

4K is the default size for "sample mode" i.e. stuffing 4KB of Intel PT trace
data into a PERF_RECORD_SAMPLE record that has sample_type bit PERF_SAMPLE_AUX

e.g.

$ perf record -vv --aux-sample -e '{intel_pt//u,cycles:u}' uname 2>err.txt
Linux
$ grep aux_sample_size err.txt
  aux_sample_size                  4096
$ 


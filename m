Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5E9650A1A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 11:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbiLSK2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 05:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbiLSK2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 05:28:46 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF402DC;
        Mon, 19 Dec 2022 02:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671445726; x=1702981726;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=d3Etqv+m4QmEFWZNJVT+7Hf9gJVW9Po0tGZX19YMuvk=;
  b=I+EmuAbzBgeUYiNijVK7U83HrPB8vD7ds2MKJs657JWLHzuL+j5zIVGi
   mRCc2sELv5ACLRScYqZZcqP6boUsD0HMOG46/zbTOPbJMFJFtpJOMxEtJ
   AmVuU0yR6n/jc6tldLdhwI8aZ2E/4gbp1U6TKsE8NmY7PYdIgadobB0yz
   m2KmGRkCf6gc6iSc14oAI5cY00+OG7KX3jumVK/EP3x+hE8XIl7zMeHH4
   wETfBebwvryvKuPgN2WI695fa+rp37H1ZPMyihG4TuILZis/+6Dl2f1qz
   BbjtArdiOD/DHTDHRG6BvxAKeOfwK9YuiCxZA+afQpRXCkYQDko2KLzP7
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="320491234"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="320491234"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 02:28:26 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="792827895"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="792827895"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.60.197])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 02:28:22 -0800
Message-ID: <d2189ccc-26aa-250a-ad43-59d53ef01d5e@intel.com>
Date:   Mon, 19 Dec 2022 12:28:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH] perf tool: Fix output unexpected messages in quiet mode
Content-Language: en-US
To:     Yang Jihong <yangjihong1@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, kan.liang@linux.intel.com,
        kim.phillips@amd.com, german.gomez@arm.com, ravi.bangoria@amd.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221219024911.62741-1-yangjihong1@huawei.com>
 <194c676b-3a73-7f34-1f29-a157b5e4731f@intel.com>
 <7aecae79-5b6d-09ea-dfd5-4d4810875f3d@huawei.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <7aecae79-5b6d-09ea-dfd5-4d4810875f3d@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/12/22 11:28, Yang Jihong wrote:
> Hello,
> 
> On 2022/12/19 14:59, Adrian Hunter wrote:
>> On 19/12/22 04:49, Yang Jihong wrote:
>>> When perf uses quiet mode, perf_quiet_option sets debug_peo_args to -1,
>>
>> Seems like redirect_to_stderr has similar issue?
> The redirect_to_stderr is used only in the veprintf function:
> 
>   int veprintf(int level, int var, const char *fmt, va_list args)
>   {
>           int ret = 0;
> 
>           if (var >= level) {
>                   if (use_browser >= 1 && redirect_to_stderr <= 0) {
>                           ui_helpline__vshow(fmt, args);
>                   } else {
>                           ret = fprintf_time(debug_file);
>                           ret += vfprintf(debug_file, fmt, args);
>                   }
>           }
> 
>           return ret;
>   }
> 
> If use quiet mode, verbose sets to -1. (also assigned in the perf_quiet_option function)
> Because "var >= level" is false, veprintf function returns directly, which avoids this problem.
> 
> However, there are cases where:
>   # perf --debug stderr=-1 report -vvv 2>/tmp/debug
> 
> If stderr is -1, should we redirect pr_debug in this case?

tools/perf/Documentation/perf.txt says debug variables are in value
range (0, 10), so -1 is invalid anyway.

> 
> Because I'm not sure if this is a problem,
> if redirect_to_stderr needs to be fixed as well,
> let me know and I'll submit a patch to fix it.

perf_quiet_option() sets redirect_to_stderr = -1 with the intention
that it turns it off, but it doesn't, although it gets turned of by
verbose = -1. Perhaps set redirect_to_stderr = 0 in perf_quiet_option() ?

I see we have another problem as well: places that check "if (verbose)"
instead of "if (verbose > 0)"

> 
>>
>>> and display_attr incorrectly determines the value of debug_peo_args.
>>> As a result, unexpected information is displayed.
>>>
>>> Before:
>>>    # perf record --quiet -- ls > /dev/null
>>>    ------------------------------------------------------------
>>>    perf_event_attr:
>>>      size                             128
>>>      { sample_period, sample_freq }   4000
>>>      sample_type                      IP|TID|TIME|PERIOD
>>>      read_format                      ID|LOST
>>>      disabled                         1
>>>      inherit                          1
>>>      mmap                             1
>>>      comm                             1
>>>      freq                             1
>>>      enable_on_exec                   1
>>>      task                             1
>>>      precise_ip                       3
>>>      sample_id_all                    1
>>>      exclude_guest                    1
>>>      mmap2                            1
>>>      comm_exec                        1
>>>      ksymbol                          1
>>>      bpf_event                        1
>>>    ------------------------------------------------------------
>>>    ...
>>>
>>> After:
>>>    # perf record --quiet -- ls > /dev/null
>>>    #
>>>
>>> Fixes: ccd26741f5e6 ("perf tool: Provide an option to print perf_event_open args and return value")
>>> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
>>
>> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
>>
> Thanks for reviewed-by.
> 
> Thanks,
> Yang


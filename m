Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEDE6E29B6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 19:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjDNRxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 13:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDNRx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 13:53:29 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB11210C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 10:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681494807; x=1713030807;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NGpumhDzTFB9x+sJGnn8SRI1olyAjGi0EM3Ke6PLXJA=;
  b=BJQ2Yq83PUJ6V7HzAAbCpK1hdF/RUoQ3V5Uao3400IOAinNv9+6EOuuZ
   V2tiFoNecH3NSePy1WfNdMeBlJIl0mPj7CxMgDmKS/85SpE9hwl14ygjt
   fWx2FBCanSmo5k1qLOM4ufF9lpvR2/QHdev5rTS3RhkzHWie/h5qQOeAB
   CjodpPGo6KSXF1gGQKDFlD3byv6WOQcI3L9qv8rkATIeyvwZorbjK+rdb
   oOgAO05SUl04MvLZ/R+CUCoshkM9koE3jo3+aGp4/GPlYWGLQU+Zhg8ZZ
   mNdzxcQkpTaXdk9WHDjzyWQ0wHy1OKtEFtNiD9PWJEdwIRpktLDml6aIA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="343285117"
X-IronPort-AV: E=Sophos;i="5.99,197,1677571200"; 
   d="scan'208";a="343285117"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 10:53:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="754530308"
X-IronPort-AV: E=Sophos;i="5.99,197,1677571200"; 
   d="scan'208";a="754530308"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 14 Apr 2023 10:53:27 -0700
Received: from [10.212.165.245] (kliang2-mobl1.ccr.corp.intel.com [10.212.165.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id DE837580677;
        Fri, 14 Apr 2023 10:53:25 -0700 (PDT)
Message-ID: <085fa11e-ea07-c148-1b32-8a09007ee12b@linux.intel.com>
Date:   Fri, 14 Apr 2023 13:53:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/6] perf: Support branch events logging
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>
Cc:     mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, eranian@google.com
References: <20230410204352.1098067-1-kan.liang@linux.intel.com>
 <20230410204352.1098067-2-kan.liang@linux.intel.com>
 <20230414103832.GD83892@hirez.programming.kicks-ass.net>
 <1d62b865-5d31-ec36-99e0-785844f79199@linux.intel.com>
 <20230414145324.GB761523@hirez.programming.kicks-ass.net>
 <803927bb-6f74-5c09-3c18-2fd5f423287b@linux.intel.com>
 <20230414160945.GC761523@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230414160945.GC761523@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-04-14 12:09 p.m., Peter Zijlstra wrote:
> On Fri, Apr 14, 2023 at 11:56:41AM -0400, Liang, Kan wrote:
>>> If it were to only support 4, then
>>> we're in counter scheduling contraint hell again 
>>
>> Unfortunately, yes.
>>
>>> and we need to somehow
>>> group all these things together with the LBR event.
>>
>> Group will bring many limits for the usage. For example, I was told
>> there could be someone wants to use it with multiplexing.
> 
> You can create two groups, each with an LBR event, no?

If we put everything in a group, that will make the enabling much
simpler. I don't think the perf tool needs the order information
anymore. Because the kernel enables the events one by one in a group.
The kernel just need to convert the information from the counter order
to the enabling order and dump to user space.

But if we have two groups with LBR event, the order information is still
required. Why we still want to group things?


Thanks,
Kan


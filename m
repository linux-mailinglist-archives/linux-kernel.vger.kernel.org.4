Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48F86E593E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 08:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjDRGS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 02:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjDRGS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 02:18:57 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2368469D;
        Mon, 17 Apr 2023 23:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681798736; x=1713334736;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6JBGljYazrmRSE6RvTQW+cpQVI0fUGbUG2iNAadpTAA=;
  b=P+wyJ2O4kZz3e3izmI4EZWWgC2X87wSE1Q53cuHhf4/h0RobLyzFBtnf
   mcMDsEjP9It6fZJBZCoSSBktm2ZrwVEmrnXjKhXLliBi7dWl0D4wiO5/L
   HY9WvnIzDmXLtYQYzGeWTnAdthODN6SLGfXLpNBQmLUH2LppX9Sez/gnf
   tIJoNKZpPJC4+S4kBniwu8McHhfGWN6J9t68zgs/VDuxeOQabkERisL1G
   GvdDbb92jn4pyMQiCt6KVPz706Ym4GwWFcBCO2zQf7rBBQuLIxi3gbky0
   AfOUapCFtwx/45iBUt4QoCwZlvLpqFw454rDVo8Tpk3LN0ttRLxdZ5DgN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="372966305"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="372966305"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 23:18:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="723524722"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="723524722"
Received: from choiwony-mobl.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.32.90])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 23:18:53 -0700
Message-ID: <89733d35-0b71-615f-4fb8-55183585c67a@intel.com>
Date:   Tue, 18 Apr 2023 09:18:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH RFC 0/5] perf: Add ioctl to emit sideband events
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230414082300.34798-1-adrian.hunter@intel.com>
 <20230417110221.GH83892@hirez.programming.kicks-ass.net>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230417110221.GH83892@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/04/23 14:02, Peter Zijlstra wrote:
> On Fri, Apr 14, 2023 at 11:22:55AM +0300, Adrian Hunter wrote:
>> Hi
>>
>> Here is a stab at adding an ioctl for sideband events.
>>
>> This is to overcome races when reading the same information
>> from /proc.
> 
> What races? Are you talking about reading old state in /proc the kernel
> delivering a sideband event for the new state, and then you writing the
> old state out?
> 
> Surely that's something perf tool can fix without kernel changes?

Yes, and it was a bit of a brain fart not to realise that.

There may still be corner cases, where different kinds of events are
interdependent, perhaps NAMESPACES events vs MMAP events could
have ordering issues.

Putting that aside, the ioctl may be quicker than reading from
/proc.  I could get some numbers and see what people think.


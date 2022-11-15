Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE0562A223
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 20:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbiKOTql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 14:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiKOTqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 14:46:38 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2248625296;
        Tue, 15 Nov 2022 11:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668541597; x=1700077597;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=xk1/5xFtTqGQZ2iiZes2xNf1o4Y5lfMfYVeMuWu7n40=;
  b=CgPglVEkTNGYNilnfAMRnuLXg3vzGrwl8IEZmtEqRX8S7Pg15Rj/6LT7
   PXnn5zpl+8FPt9vyTlgzxQZJQOgqs5kyIRrVgpfYIUydQuYgO2EQzjxww
   iSHT7K2x/4KjA2YQxu4oGz0Eb5Iy1xGk554cdkE6V4Sc4pmeCqqE6OU2U
   UIxcuHwcONKM8f9hyelRK9tnln5het7FDx4YUPqc3s5Wg8X6l3OaGihaZ
   LsgSsgFLOHxSpB1qMElxVJs/DOUSFZn6qLer7Vqm6YS4/cPyIM7wjITuF
   G+HFCNr+LeqnwHbcEG4zMZ9+HfAcMptyDqiWIEcaJcQWyfoZWoel1oHBF
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="292744203"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="292744203"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 11:46:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="744725958"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="744725958"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.54.74.11])
  by fmsmga002.fm.intel.com with ESMTP; 15 Nov 2022 11:46:32 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id BC7BF302977; Tue, 15 Nov 2022 11:46:32 -0800 (PST)
From:   Andi Kleen <ak@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf/x86/intel/pt: Fix sampling using single range output
References: <20221112151508.13768-1-adrian.hunter@intel.com>
        <Y3IdnRgEPq2FN/ZX@hirez.programming.kicks-ass.net>
        <dfbeecdb-c97c-993f-da03-5f3d1f141c61@intel.com>
        <Y3I7sIjlhQix81P2@hirez.programming.kicks-ass.net>
Date:   Tue, 15 Nov 2022 11:46:32 -0800
In-Reply-To: <Y3I7sIjlhQix81P2@hirez.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Mon, 14 Nov 2022 13:59:28 +0100")
Message-ID: <878rkcdmqv.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Mon, Nov 14, 2022 at 01:10:38PM +0200, Adrian Hunter wrote:
>> On 14/11/22 12:51, Peter Zijlstra wrote:
>> > On Sat, Nov 12, 2022 at 05:15:08PM +0200, Adrian Hunter wrote:
>> >> Deal with errata TGL052, ADL037 and RPL017 "Trace May Contain Incorrect
>> >> Data When Configured With Single Range Output Larger Than 4KB" by
>> >> disabling single range output whenever larger than 4KB.
>> >>
>> >> Fixes: 670638477aed ("perf/x86/intel/pt: Opportunistically use single range output mode")
>> >> Cc: stable@vger.kernel.org
>> >> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> >> ---
>> >>  arch/x86/events/intel/pt.c | 9 +++++++++
>> >>  1 file changed, 9 insertions(+)
>> >>
>> >> diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
>> >> index 82ef87e9a897..42a55794004a 100644
>> >> --- a/arch/x86/events/intel/pt.c
>> >> +++ b/arch/x86/events/intel/pt.c
>> >> @@ -1263,6 +1263,15 @@ static int pt_buffer_try_single(struct pt_buffer *buf, int nr_pages)
>> >>  	if (1 << order != nr_pages)
>> >>  		goto out;
>> >>  
>> >> +	/*
>> >> +	 * Some processors cannot always support single range for more than
>> >> +	 * 4KB - refer errata TGL052, ADL037 and RPL017. Future processors might
>> >> +	 * also be affected, so for now rather than trying to keep track of
>> >> +	 * which ones, just disable it for all.
>> >> +	 */
>> >> +	if (nr_pages > 1)
>> >> +		goto out;
>> > 
>> > This effectively declares single-output-mode dead? Because I don't think
>> > anybody uses PT with a single 4K buffer.
>> 
>> 4K is the default size for "sample mode" i.e. stuffing 4KB of Intel PT trace
>> data into a PERF_RECORD_SAMPLE record that has sample_type bit PERF_SAMPLE_AUX
>> 
>> e.g.
>> 
>> $ perf record -vv --aux-sample -e '{intel_pt//u,cycles:u}' uname 2>err.txt
>> Linux
>> $ grep aux_sample_size err.txt
>>   aux_sample_size                  4096
>
> Ah, ok. Not as bad then. Anyway, I'll go queue it for perf/urgent I
> suppose.

It would be better to only limit on the CPUs with the bug because
switching buffers causes some extra latencies. So this patch may regress
PT overhead or tail latencies.

-Andi

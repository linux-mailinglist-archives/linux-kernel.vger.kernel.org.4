Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29137682FDC
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 15:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbjAaO4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 09:56:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbjAaO4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 09:56:07 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5EA46B6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 06:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675176963; x=1706712963;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bPUNX2DhdrDuAHaPoymzJIVcqti+Iti/WssrxIiCj+E=;
  b=RiYt03B6XtgXepffKC0QDWoAUvdCLpjUmhUTMbHQlEOaOdvp/wjTrWpy
   mIGecbQiPSFL1AmwDdAWl5QSZaTaesDNXaD3bPWK9dKoQCKCpOFZO+xYv
   4Xx7Xc9pW0qviEzb7njrnTelm4PHmN5WWwD3yVj5DZXCqW/+65qriPwPu
   EfPXHSPsmoexzRi1bKX3ZKDrnSbWobCJOB0qiJga2J05YbpPWlJsmw68H
   0L+Z3SxP5ujVlDKVp051lTGC4c8kymmIi4x5NM+Q0KRL+OVvu1JNpHBdw
   ouAuOPFHSgzCKV5ErsPf/S41+XSRGRBXIqUORABrYpY2frDfQqiahLhoi
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="390221367"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="390221367"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 06:56:02 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="733146641"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="733146641"
Received: from wrasheed-mobl.amr.corp.intel.com (HELO [10.212.241.3]) ([10.212.241.3])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 06:56:01 -0800
Message-ID: <c6c106a2-b180-d3fd-5904-44f9b4949ddc@linux.intel.com>
Date:   Tue, 31 Jan 2023 06:55:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH] hrtimer: interleave timers for improved single thread
 performance at low utilization
To:     shrikanth hegde <sshegde@linux.vnet.ibm.com>, tglx@linutronix.de
Cc:     peterz@infradead.org, mingo@kernel.org,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        svaidy@linux.ibm.com, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de
References: <5ae3cb09-8c9a-11e8-75a7-cc774d9bc283@linux.vnet.ibm.com>
Content-Language: en-US
From:   Arjan van de Ven <arjan@linux.intel.com>
In-Reply-To: <5ae3cb09-8c9a-11e8-75a7-cc774d9bc283@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>   kernel/time/hrtimer.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
> index 3ae661ab6260..d160f49f0cce 100644
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -1055,6 +1055,17 @@ u64 hrtimer_forward(struct hrtimer *timer, ktime_t now, ktime_t interval)
> 
>           orun = ktime_divns(delta, incr);
>           hrtimer_add_expires_ns(timer, incr * orun);
> +        /*
> +         * Avoid timer round-off, so that all cfs bandwidth timers
> +         * don't start at the same time

so while I applaud the final objective, I am sort of wondering if hrtimer.c is the right place in the kernel to fix a CFS/cgroup issue...
wouldn't it be better to solve such issues at the place we want this to happen, rather than for all timers in the whole system?

(also while for performance it might be better to spread out a bit, for power consumption it's obviously the other way around)



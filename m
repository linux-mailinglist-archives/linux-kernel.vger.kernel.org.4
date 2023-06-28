Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0FA74075C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 02:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjF1A55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 20:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjF1A5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 20:57:54 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B9EEE;
        Tue, 27 Jun 2023 17:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687913873; x=1719449873;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GOhtVZ+gS1f2L4bPc+smRnRLYWWs+E1es9SS4PyT7Cs=;
  b=bqnuQ9WMbQIPCWo7omUCepXw4qmyNKx0rjL/BoxgX/IaXFKgjKHlKBbP
   9WDWHkF4sJPt6fICUAKaUFBCblddmfNja9L5F0mtuopXnqPPy2SCQYN2E
   3xXKkQNQNfi+Eeu0JtDup5duB0ictTi1VAH1rMcouTjTDunM8N3sGVoBA
   8itnSCBkuZwJa8G2cx3MN3TKhPvPLtUeebopNSO88xGqAGUf5Hc1LXl1S
   njrGbU3ieyZJS7+40VS1o0ZZQeUI7ks6BILXyJEMoSxBMmpXCHjtI2gnF
   yUXFD4ji4YqwNC+IP1gV0bqV9YvtYLTPcQQJ1tY+e7oHxb5TsNdPGPL67
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="360573173"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="360573173"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 17:57:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="786859385"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="786859385"
Received: from yjie-desk1.jf.intel.com (HELO [10.24.96.120]) ([10.24.96.120])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 17:57:52 -0700
Message-ID: <dd301065-a9ec-0918-daa4-596245baae00@linux.intel.com>
Date:   Tue, 27 Jun 2023 17:57:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] x86/aperfmperf: Fix the fallback condition in
 arch_freq_get_on_cpu()
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yair Podemsky <ypodemsk@redhat.com>, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Doug Smythies <dsmythies@telus.net>
References: <20230626193601.9169-1-yang.jie@linux.intel.com>
From:   Yang Jie <yang.jie@linux.intel.com>
In-Reply-To: <20230626193601.9169-1-yang.jie@linux.intel.com>
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


Sorry for top posting, I should have sent it to linux-pm and maintainers.

Doug Smythies had a good discussion with me about the related history 
and issues in the bugzilla here: 
https://bugzilla.kernel.org/show_bug.cgi?id=217597.

Basically, there are 2 issues here per my observation:
1. the cpu_khz shared for all CPU cores? In Intel's recent Hybrid CPUs, 
what does this cpu_khz read from cpuid really mean? I am seeing 
cpu_khz=3.6GHz for E-cores with Max frequecy 3GHz. We should fix that, no?
2. We don't want to wake up cores just because of the sysfs queries, so 
we introduced fallback mechanism here, what is our clear design about that?

So, before discussing those issues, we should get alignment on these first:
1. What is fallback and When should we fallback. From the comment, looks 
we wanted to use cpu_khz for Cores haven't executed any task during the 
last 20ms, this sounds reasonable, and I patch here is to address this 
issue.
2. What frequencies should we show in fallback case. This could be 
controversial, 0? min_freq? base_freq? or last calculated one? Doug has 
suggestion here but this is not touched in my patch here.

Thanks,
~Keyon

On 6/26/23 12:36, Keyon Jie wrote:
>>From the commit f3eca381bd49 on, the fallback condition about the 'the
> last update was too long' have been comparing ticks and milliseconds by
> mistake, which leads to that the condition is met and the fallback
> method is used frequently.
> 
> The change to compare ticks here corrects that and fixes related issues
> have been seen on x86 platforms since 5.18 kernel.
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217597
> Fixes: f3eca381bd49 ("x86/aperfmperf: Replace arch_freq_get_on_cpu()")
> CC: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
> ---
>   arch/x86/kernel/cpu/aperfmperf.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
> index fdbb5f07448f..24e24e137226 100644
> --- a/arch/x86/kernel/cpu/aperfmperf.c
> +++ b/arch/x86/kernel/cpu/aperfmperf.c
> @@ -432,7 +432,7 @@ unsigned int arch_freq_get_on_cpu(int cpu)
>   	 * Bail on invalid count and when the last update was too long ago,
>   	 * which covers idle and NOHZ full CPUs.
>   	 */
> -	if (!mcnt || (jiffies - last) > MAX_SAMPLE_AGE)
> +	if (!mcnt || (jiffies - last) > MAX_SAMPLE_AGE * cpu_khz)
>   		goto fallback;
>   
>   	return div64_u64((cpu_khz * acnt), mcnt);

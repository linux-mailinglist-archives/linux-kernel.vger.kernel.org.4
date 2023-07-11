Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1ED74F23D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjGKO2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbjGKO1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:27:48 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9200C1BE7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689085632; x=1720621632;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9vDwO4cQ38fRFzhKFvaMLDgAQYGpS/YYi5vOtkUhyaA=;
  b=FidwxqJtjjiozS3XCo1uveAaEnibbKdTWtCzA/SHg9P2jAWoSmkVlD9r
   tRwSBbexLMxV+ua+jfsK9mMJync4KSWNuMIOlr5IZGYwMyu65ezfbZTxN
   yWBrZgPIFz5Kc87dAN0WcUv9t4PwvweSIGICUQCR9rqguFhmSBTEJC74Z
   DsKRe3LW5++LSH1fTPgkVIhUKSe4eiyAeZZGEfuZDNnme557VFrxjyz20
   rn3F6DawSqcbBBnJYEePTSvxKVOG3DdtE80kLk11sNEqR1aeUM/9vwJc4
   vu33LpsInYQObACjOgAXvDsh0fWgpOOyiz+KW0LyjnapmelQuNeEtESBn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="430720717"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="430720717"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 07:26:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="967822080"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="967822080"
Received: from avandeve-mobl1.amr.corp.intel.com (HELO [10.209.94.41]) ([10.209.94.41])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 07:26:26 -0700
Message-ID: <d32d5e3c-2cd9-3339-d6eb-59ce7c3ec55f@linux.intel.com>
Date:   Tue, 11 Jul 2023 07:26:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [6.5.0-rc1] unchecked MSR access error: RDMSR from 0xe2 at rIP:
 0xffffffff87090227 (native_read_msr+0x7/0x40) (intel_idle_init_cstates_icpu)
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Bruno Goncalves <bgoncalv@redhat.com>
Cc:     rafael.j.wysocki@intel.com, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <CA+QYu4qSBdhEgFURu+ouAf2d_JNPbZgCSUaxCLoGzMqDQOLWsQ@mail.gmail.com>
 <20230711112421.GI3062772@hirez.programming.kicks-ass.net>
 <CA+QYu4qzJgiiU1qsjtWb9OU3=C=hb_c-Ag5Y4c=Xp_ObfGH=hg@mail.gmail.com>
 <20230711125557.GM3062772@hirez.programming.kicks-ass.net>
From:   Arjan van de Ven <arjan@linux.intel.com>
In-Reply-To: <20230711125557.GM3062772@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Oohh, this vm-guest mode is new :/ But it doesn't make sense, that
> commit babbles something about waking CPUs from idle to do TLB
> invalidate, but that shouldn't be the case, that's what we have
> kvm_flush_tlb_multi() for, it should avoid the IPI and flush on
> vcpu-enter.
> 
> Arjan, what is the actual problem you're trying to solve any why hide
> this in intel_idle ?

I'm trying to solve to get guests on par with bare metal in terms of all
the idle capabilities -- including TLB flushing before going idle, but
also all the other latency control mechanisms that cpuidle brings.

And yes this is in intel_idle for 2 reasons
1) we use the host latencies for the deeper C state and that needs intel idle information
2) we are about to add umwait support to this as well (patches on the mailing list for
the base infrastructure for this)


the later is arguable not for 6.5 but is hopefully for 6.6


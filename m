Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFEB56EF9E5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 20:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239328AbjDZSQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 14:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjDZSQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 14:16:03 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDE76EAD
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 11:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682532962; x=1714068962;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=s7VMbx8cIE8Pwgd0VjK8we2/lmVTZS2frf1uO4lI0NY=;
  b=HcQpmb11MwlsIwRCNb9j+7/Im7sk2sQCyAyFZOCHTZi/xPyYMpvEq548
   C1foKtDzaUuENYssDvpUM7BtRWmeP4ndzVqDbn0eAUgqBByu9jdBbPWFI
   Za4hvPujCTqU6+lc/2VZyzlZLki8Sun6ck338tPMamhWqTg8jwbHr2xvR
   Fw1/S199piANFxL66adolRgIu5bYpJJIvxyMnVAUUPIl53ss+4OYhlDKQ
   JzO0iSaF2D/EVisfaGNR3t9bQ3bgfxPSE3lA2+ycYy6+9NujveDYnctEH
   jMa9byh8PspRtyflmXVnKm+2AAHDlxazBnHeCWwqkmbMFN4wxaQaG6KG1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="331435196"
X-IronPort-AV: E=Sophos;i="5.99,228,1677571200"; 
   d="scan'208";a="331435196"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 11:16:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="868386061"
X-IronPort-AV: E=Sophos;i="5.99,228,1677571200"; 
   d="scan'208";a="868386061"
Received: from kdaneshi-mobl2.amr.corp.intel.com (HELO [10.209.15.204]) ([10.209.15.204])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 11:16:01 -0700
Message-ID: <25dd25d3-2db1-acf6-0814-9bb5bcd65bb9@intel.com>
Date:   Wed, 26 Apr 2023 11:15:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH RFC] x86/cpu: fix intermittent lockup on poweroff
Content-Language: en-US
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Battersby <tonyb@cybernetics.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>
References: <3817d810-e0f1-8ef8-0bbd-663b919ca49b@cybernetics.com>
 <f5c7a104-d422-bd02-d361-e9e9f433d41d@intel.com> <87o7nbzn8w.ffs@tglx>
 <5f8a9cb8-70cf-2a17-cfc4-cb31cb658de4@cybernetics.com> <87y1mey503.ffs@tglx>
 <ccf57fd2-45b8-1f1f-f46a-55d7f4c56161@cybernetics.com>
 <01a44722-931a-7aff-4f4b-75e78855beb1@amd.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <01a44722-931a-7aff-4f4b-75e78855beb1@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/23 10:51, Tom Lendacky wrote:
>>> +    /*
>>> +     * native_stop_other_cpus() will write to @stop_cpus_count after
>>> +     * observing that it went down to zero, which will invalidate the
>>> +     * cacheline on this CPU.
>>> +     */
>>> +    atomic_dec(&stop_cpus_count);
> 
> This is probably going to pull in a cache line and cause the problem the
> native_wbinvd() is trying to avoid.

Is one _more_ cacheline really the problem?

Or is having _any_ cacheline pulled in a problem?  What about the text
page containing the WBINVD?  How about all the page table pages that are
needed to resolve %RIP to a physical address?

What about the mds_idle_clear_cpu_buffers() code that snuck into
native_halt()?

> ffffffff810ede4c:       0f 09                   wbinvd 
> ffffffff810ede4e:       8b 05 e4 3b a7 02       mov    0x2a73be4(%rip),%eax        # ffffffff83b61a38 <mds_idle_clear>
> ffffffff810ede54:       85 c0                   test   %eax,%eax
> ffffffff810ede56:       7e 07                   jle    ffffffff810ede5f <stop_this_cpu+0x9f>
> ffffffff810ede58:       0f 00 2d b1 75 13 01    verw   0x11375b1(%rip)        # ffffffff82225410 <ds.6688>
> ffffffff810ede5f:       f4                      hlt    
> ffffffff810ede60:       eb ec                   jmp    ffffffff810ede4e <stop_this_cpu+0x8e>
> ffffffff810ede62:       e8 59 40 1a 00          callq  ffffffff81291ec0 <trace_hardirqs_off>
> ffffffff810ede67:       eb 85                   jmp    ffffffff810eddee <stop_this_cpu+0x2e>
> ffffffff810ede69:       0f 1f 80 00 00 00 00    nopl   0x0(%rax)


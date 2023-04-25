Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF836EE91A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 22:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236211AbjDYUfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 16:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbjDYUe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 16:34:59 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF2B1444F
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 13:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682454899; x=1713990899;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FoYV4njjPjrCFblb/bmdYdLpYFE9F2Cb5LQWkKcBRqs=;
  b=KDHmm9GY2PVsG3M1NPco2kxZKgSknppwPjYg8Vyn4y3mk8cTB2hMi78l
   V+TS7NXvhXDTf3P3h67IlFcTHUAN+VSdpb5h3zRUeJax3N7srR3Q1gJQD
   iI60B+vJm6zQk0LcG2NaWFwYZ88CzMOS5h02obOXLZyT4NzRd64nYmdbR
   L/jtDrylcEqA4UFxiiC+JFE+8lpPmrtvrGeID0a/Zy1/PLPeggHZyqKiN
   n0qFl/QqOzjlxx0ZWCYt13iWTxWhVHJUv4TLlcodJEWKnwfJpTxVvT6hw
   8N98f3LMJV3TxDFQ2UxkJyUznekDqkGahOEfaUrwnt2YOYwV94lgVA62B
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="326494671"
X-IronPort-AV: E=Sophos;i="5.99,226,1677571200"; 
   d="scan'208";a="326494671"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2023 13:34:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="1023308293"
X-IronPort-AV: E=Sophos;i="5.99,226,1677571200"; 
   d="scan'208";a="1023308293"
Received: from gchacko-mobl1.gar.corp.intel.com (HELO [10.215.145.52]) ([10.215.145.52])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2023 13:34:53 -0700
Message-ID: <1955637d-b7ab-20a8-558a-6b909b7069a9@intel.com>
Date:   Tue, 25 Apr 2023 13:34:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH RFC] x86/cpu: fix intermittent lockup on poweroff
Content-Language: en-US
To:     Tony Battersby <tonyb@cybernetics.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <3817d810-e0f1-8ef8-0bbd-663b919ca49b@cybernetics.com>
 <f5c7a104-d422-bd02-d361-e9e9f433d41d@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <f5c7a104-d422-bd02-d361-e9e9f433d41d@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/23 13:03, Dave Hansen wrote:
> On 4/25/23 12:26, Tony Battersby wrote:
>> -	if (cpuid_eax(0x8000001f) & BIT(0))
>> +	if (c->extended_cpuid_level >= 0x8000001f &&
>> +	    (cpuid_eax(0x8000001f) & BIT(0)))
>>  		native_wbinvd();
> Oh, so the existing code is running into the
> 
>> If a value entered for CPUID.EAX is higher than the maximum input
>> value for basic or extended function for that processor then the data
>> for the highest basic information leaf is returned
> behavior.  It's basically looking at BIT(0) of some random extended
> leaf.  Probably 0x80000008 based on your 'cpuid -r' output.

Whoops, 0x80000008 isn't a "basic information leaf".  If 'cpuid -r'
dumps all the basic leaves, that would mean the "highest basic
information leaf" is 0x0000000b:

>    0x0000000b 0x00: eax=0x00000001 ebx=0x00000002 ecx=0x00000100 edx=0x00000000

which does have BIT(0) set.

So, that at least explains how WBINVD gets called in the first place.
But (as tglx noted on IRC) it doesn't really explain the lockup.  WBINVD
should work everywhere and it won't #UD or something because the CPUID
check was botched.

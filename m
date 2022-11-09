Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5B262319B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 18:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbiKIRjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 12:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbiKIRjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 12:39:44 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3892E13CF5;
        Wed,  9 Nov 2022 09:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668015583; x=1699551583;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=bEOHMNIrA8juYx3VOItS2P7TeSkyDS6Uvv7P/3S0bt8=;
  b=NGkn8kfyPVcACYEQrWDLLZSFTR3SrQxaHpTzU1DARN4G/o2baZ5UCmyB
   XfZNQ5F7RUO4Qsqf94tJHCyLB39n6pYl1nQWwUJyFuqyvW5M99hU2BfO9
   bLGZGcJC1pknbqY9eDZRloqz1UZhei2CO1dTrRcTtDjqAE4KqNQ2UzDe5
   BgCEn2ME4W8obr0E0+1GOGvP/e3/hKZneI+znlxJHYY6Vyl5kwLipQgwN
   +THug3kDWlLGo5JTLmKXonctB0FJVgDY/d4Z1NOdvzJn17gPvMZCwR+mw
   rVgeckkT/sxDzKJ4UE646KZaR7FXuQIEvplfidwYLZW3lO8/sPy38RDPt
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="298572319"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="298572319"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 09:37:27 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="779431667"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="779431667"
Received: from fluthi-mobl2.amr.corp.intel.com (HELO desk) ([10.251.18.168])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 09:37:24 -0800
Date:   Wed, 9 Nov 2022 09:37:20 -0800
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     Andrew Cooper <Andrew.Cooper3@citrix.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        "antonio.gomez.iglesias@linux.intel.com" 
        <antonio.gomez.iglesias@linux.intel.com>
Subject: Re: [PATCH 2/3] x86/cpu/amd: Add feature bit for MSR_AMD64_LS_CFG
 enumeration
Message-ID: <20221109173720.4ovtb2ao3vuuge43@desk>
References: <cover.1663025154.git.pawan.kumar.gupta@linux.intel.com>
 <034c7f5ac243ee7b40ba1a8cc3f9b10b1e380674.1663025154.git.pawan.kumar.gupta@linux.intel.com>
 <Y2qlyfRKgIc4KVcx@zn.tnic>
 <20221108225141.aikng7veemp25p62@desk>
 <Y2rh6FN+gbD6Vbzj@zn.tnic>
 <1ee02d57-21a7-b18e-6cf9-0667445a6fb3@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ee02d57-21a7-b18e-6cf9-0667445a6fb3@citrix.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 12:45:58AM +0000, Andrew Cooper wrote:
>On 08/11/2022 23:10, Borislav Petkov wrote:
>> On Tue, Nov 08, 2022 at 02:51:41PM -0800, Pawan Gupta wrote:
>>> Looking at bsp_init_amd() this feature bit will only be set on AMD
>>> families 0x15-0x17. Andrew mentioned that the MSR LS_CFG is present on
>>> AMD family >= 0x10 && family <= 0x18.
>> Do you need to save that MSR on those families?
>>
>> Or do 0x15-0x18 suffice?
>>
>> Yes, 0x18 because that's Hygon and that does its own detection.
>>
>> So, do you need to save it on families 0x10-0x14?
>
>https://www.amd.com/system/files/documents/software-techniques-for-managing-speculation.pdf 
>Mitigation G-2.
>
>The MSR exists on Fam 10/12/14/15/16/17, and in all cases the
>LFENCE_DISPATCH bit wants setting if not already set.

Isn't that a different MSR:

   #define MSR_AMD64_LS_CFG                0xc0011020

   #define MSR_F10H_DECFG                  0xc0011029
   #define MSR_F10H_DECFG_LFENCE_SERIALIZE_BIT     1

Looks like we need to restore this MSR too, and we can use existing
X86_FEATURE_XMM2 to enumerate it.

If SSBD is the only reason to restore MSR_AMD64_LS_CFG then we should be
able to use X86_FEATURE_LS_CFG_SSBD for enumeration.

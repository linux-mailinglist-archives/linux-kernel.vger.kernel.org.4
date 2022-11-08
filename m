Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990F6621F8B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 23:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiKHWvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 17:51:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbiKHWvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 17:51:44 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF4860E99;
        Tue,  8 Nov 2022 14:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667947903; x=1699483903;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2yhDaRWzu3W49o6ZiqRcLmYsZfta/SXF/5U9XO1w2w4=;
  b=oDaza5uldgDNgfJRQNHz+UpMJHF+r4AO7u6RTAOdeT0YRGR7Ikf7VJVr
   IjPpgAg5piEGe+WkOqr3wt0FZUOdGadkaPxMq0EFIpFARPZSqCUgFZOuk
   hmwkTXs6ip7Ql3y7du/xANm3gtsmmUma/WaggmW1DtoX0+CP7K2+HNYRl
   9tFJaR2zNuPyzAmMLDHZR/stqm4BpEXVi3/1q61G42DynKmOS8VcljZZO
   EK8SMDHhsJDaoGzSpBt/yhBfnH2xyVNnmrGBbwWEgZuSuIdZ6pG/b2900
   4EljwZO1HyV5TxEC6G8wX3p/iDssk4FM/IdO50KO1gY6MtFza0jHYWMzh
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="312622420"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="312622420"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 14:51:43 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="669721571"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="669721571"
Received: from ehartman-mobl.amr.corp.intel.com (HELO desk) ([10.212.198.244])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 14:51:42 -0800
Date:   Tue, 8 Nov 2022 14:51:41 -0800
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>, hdegoede@redhat.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        antonio.gomez.iglesias@linux.intel.com
Subject: Re: [PATCH 2/3] x86/cpu/amd: Add feature bit for MSR_AMD64_LS_CFG
 enumeration
Message-ID: <20221108225141.aikng7veemp25p62@desk>
References: <cover.1663025154.git.pawan.kumar.gupta@linux.intel.com>
 <034c7f5ac243ee7b40ba1a8cc3f9b10b1e380674.1663025154.git.pawan.kumar.gupta@linux.intel.com>
 <Y2qlyfRKgIc4KVcx@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Y2qlyfRKgIc4KVcx@zn.tnic>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 07:54:01PM +0100, Borislav Petkov wrote:
>On Mon, Sep 12, 2022 at 04:40:47PM -0700, Pawan Gupta wrote:
>> Currently there is no easy way to enumerate MSR_AMD64_LS_CFG. As this
>> MSR is supported on AMD CPU families 10h to 18h, set a new feature bit
>> on these CPU families. The new bit can be used to detect the MSR
>> support.
>>
>> Suggested-by: Andrew Cooper <andrew.cooper3@citrix.com>
>> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
>> ---
>>  arch/x86/include/asm/cpufeatures.h | 1 +
>>  arch/x86/kernel/cpu/amd.c          | 3 +++
>>  2 files changed, 4 insertions(+)
>>
>> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
>> index dd173733e40d..90bdb1d98531 100644
>> --- a/arch/x86/include/asm/cpufeatures.h
>> +++ b/arch/x86/include/asm/cpufeatures.h
>> @@ -305,6 +305,7 @@
>>  #define X86_FEATURE_USE_IBPB_FW		(11*32+16) /* "" Use IBPB during runtime firmware calls */
>>  #define X86_FEATURE_RSB_VMEXIT_LITE	(11*32+17) /* "" Fill RSB on VM exit when EIBRS is enabled */
>>  #define X86_FEATURE_MSR_TSX_CTRL	(11*32+18) /* "" MSR IA32_TSX_CTRL */
>> +#define X86_FEATURE_MSR_LS_CFG		(11*32+19) /* "" MSR AMD64_LS_CFG */
>
>We already have that one:
>
>#define X86_FEATURE_LS_CFG_SSBD         ( 7*32+24)  /* "" AMD SSBD implementation via LS_CFG MSR */

Looking at bsp_init_amd() this feature bit will only be set on AMD
families 0x15-0x17. Andrew mentioned that the MSR LS_CFG is present on
AMD family >= 0x10 && family <= 0x18. That is why I added a new bit for
the MSR.

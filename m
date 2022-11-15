Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B523F62A355
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 21:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbiKOUs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 15:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238362AbiKOUsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 15:48:46 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D5525A;
        Tue, 15 Nov 2022 12:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668545319; x=1700081319;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lztYRjluQ1xzm5255jHZhSxEZVcjuHk08XP3pTKqqCg=;
  b=U2mWwY/NuyE+SS2n0StuScX9+kXzSMAOW8Ebntwo8L5jPSlrkqHT8pgG
   kzFbkYM19+sPakjl4R6JkA+befzhJ6i2vOdjpidzomX5o/3bouN4TmUjt
   ZPMkh2GzO74FmpjEL+MuaKNFc3RC08/udPEXEqQhX9+tHgr5/L3T7NvjY
   TBZxcXh3BRspd9EISjjafkiRd381e99vtivFvctT1kelvumGXorGeH+sq
   LMso1+mCVDN11FRRcXo+ickcNFxj1WpO1KkmyY9O8ULCZAObrm70dYzbV
   JbCq4szN+Ao78zLPiHkJ0EPzzufTWdxMSvsFUSQX2VvJxmFtUsfjcMOnh
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="299891365"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="299891365"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 12:48:36 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="764058818"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="764058818"
Received: from slmckinn-mobl.amr.corp.intel.com (HELO desk) ([10.255.231.2])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 12:48:35 -0800
Date:   Tue, 15 Nov 2022 12:48:34 -0800
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andrew Cooper <Andrew.Cooper3@citrix.com>, thomas.lendacky@amd.com,
        "H. Peter Anvin" <hpa@zytor.com>, hdegoede@redhat.com,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Pavel Machek <pavel@ucw.cz>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David.Kaplan@amd.com, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        antonio.gomez.iglesias@linux.intel.com
Subject: Re: [PATCH v3 2/2] x86/pm: Add enumeration check before spec MSRs
 save/restore setup
Message-ID: <20221115204834.dkb7yecr227lj277@desk>
References: <cover.1668539735.git.pawan.kumar.gupta@linux.intel.com>
 <c24db75d69df6e66c0465e13676ad3f2837a2ed8.1668539735.git.pawan.kumar.gupta@linux.intel.com>
 <CAJZ5v0j6GBAx-UTTx2Oe1Y+bwpRuqifoNx4vBu1Vi9K93TS9JA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAJZ5v0j6GBAx-UTTx2Oe1Y+bwpRuqifoNx4vBu1Vi9K93TS9JA@mail.gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 08:23:35PM +0100, Rafael J. Wysocki wrote:
>On Tue, Nov 15, 2022 at 8:17 PM Pawan Gupta
><pawan.kumar.gupta@linux.intel.com> wrote:
>>
>> pm_save_spec_msr() keeps a list of all the MSRs which _might_ need to be
>> saved and restored at hibernate and resume.  However, it has zero
>> awareness of CPU support for these MSRs.  It mostly works by
>> unconditionally attempting to manipulate these MSRs and relying on
>> rdmsrl_safe() being able to handle a #GP on CPUs where the support is
>> unavailable.
>>
>> However, it's possible for reads (RDMSR) to be supported for a given MSR
>> while writes (WRMSR) are not.  In this case, msr_build_context() sees a
>> successful read (RDMSR) and marks the MSR as 'valid'.  Then, later, a
>> write (WRMSR) fails, producing a nasty (but harmless) error message.
>> This causes restore_processor_state() to try and restore it, but writing
>> this MSR is not allowed on the Intel Atom N2600 leading to:
>>
>>   unchecked MSR access error: WRMSR to 0x122 (tried to write 0x0000000000000002) \
>>      at rIP: 0xffffffff8b07a574 (native_write_msr+0x4/0x20)
>>   Call Trace:
>>    <TASK>
>>    restore_processor_state
>>    x86_acpi_suspend_lowlevel
>>    acpi_suspend_enter
>>    suspend_devices_and_enter
>>    pm_suspend.cold
>>    state_store
>>    kernfs_fop_write_iter
>>    vfs_write
>>    ksys_write
>>    do_syscall_64
>>    ? do_syscall_64
>>    ? up_read
>>    ? lock_is_held_type
>>    ? asm_exc_page_fault
>>    ? lockdep_hardirqs_on
>>    entry_SYSCALL_64_after_hwframe
>>
>> To fix this, add the corresponding X86_FEATURE bit for each MSR.  Avoid
>> trying to manipulate the MSR when the feature bit is clear. This
>> required adding a X86_FEATURE bit for MSRs that do not have one already,
>> but it's a small price to pay.
>>
>> Fixes: 73924ec4d560 ("x86/pm: Save the MSR validity status at context setup")
>> Reported-by: Hans de Goede <hdegoede@redhat.com>
>> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
>> Cc: stable@kernel.org
>
>Fine with me:
>
>Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thanks.

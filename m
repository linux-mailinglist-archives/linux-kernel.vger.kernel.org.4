Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A81D6C9716
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 19:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbjCZRCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 13:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjCZRCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 13:02:03 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB1E5BA3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 10:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679850102; x=1711386102;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fVZ/T0Xll5z45xFx7FBvnYRUxCDHZrN04aKO7XOOUT0=;
  b=N/tGmOrQsAvcV58pIJkG62ZI9Rx0gPwuN5SbQbt0P7FEvq+1NYKNlGr6
   SU7i2nE4I1JNSaL5zhy8sjZnfWr0sEuLfV5pUx9gQTcnCkjjr6B8wecoR
   1ByxXvMZCft4aYIGUJ9g3TgAfBb9lc8pFCRuCRR7beoAUXdi2c5EzN4ft
   2CwPonT7OB8LXpjYeSWBqGY2Ex11KfFcEMXBu+UR0lEGLeks6Q/7XlHay
   FdKK29EjNsdud8WsO77K8o1pAvGMilt1Qdx+Spu02fKSgwAhN3iCNfkwe
   chr8RQ0AHkr3l4XLMACG+cnKettHDFq2o/f99XTT9VSx4FI6xnK5GltWw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="338829154"
X-IronPort-AV: E=Sophos;i="5.98,292,1673942400"; 
   d="scan'208";a="338829154"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2023 10:01:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="633387655"
X-IronPort-AV: E=Sophos;i="5.98,292,1673942400"; 
   d="scan'208";a="633387655"
Received: from crice5-mobl.amr.corp.intel.com (HELO [10.209.3.81]) ([10.209.3.81])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2023 10:01:23 -0700
Message-ID: <b16bcda0-f190-7849-cbbb-412d328c8806@intel.com>
Date:   Sun, 26 Mar 2023 10:01:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] x86: Disable kexec for TDX guests
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230325160128.21857-1-kirill.shutemov@linux.intel.com>
 <ebead33b-0594-73df-56ae-f40473ac0ffc@intel.com>
 <20230325192524.wetlbycbcsxc4plk@box>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230325192524.wetlbycbcsxc4plk@box>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/23 12:25, Kirill A. Shutemov wrote:
> On Sat, Mar 25, 2023 at 09:25:36AM -0700, Dave Hansen wrote:
>> On 3/25/23 09:01, Kirill A. Shutemov wrote:
>>> The last item is tricky. TDX guests use ACPI MADT MPWK to bring up
>>> secondary CPUs. The mechanism doesn't allow to put a CPU back offline if
>>> it has woken up.
>> ...
>>> +int arch_kexec_load(void)
>>> +{
>>> +	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
>>> +		pr_warn_once("Disable kexec: not yet supported in TDX guest\n");
>>> +		return -EOPNOTSUPP;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>
>> So, let's put all this together:
>>
>> 1. TDX implementations use MADT for wakeup exclusively right now (but
>>    are not necessarily _required_ to do so forever)
>> 2. MADT doesn't support CPU offlining
>> 3. kexec() requires offlining
>>
>> Thus, current TDX implementations can't support TDX guests.  This
>> *doesn't* say that TDX will always use the MADT for wakeups.
>>
>> Yet, the check you have here is for TDX and *not* for the MADT.
> 
> As I described in the commit message there are more than MADT that is
> required to get kexec in TDX guest.

I kinda think we should do both.

Let's make sure that all systems that depend on MADT wakeups can't
kexec() until the ACPI folks work out what to do there.

Separately, let's either fix or *mark* the kexec()-incompatible pieces
that *ARE* specific to TDX.

>> That seems wrong.
>>
>> Let's say SEV or arm64 comes along and uses the MADT for their guests.
>> They'll add another arch_kexec_load(), with a check for *their* feature.
>>
>> This all seems like you should be disabling kexec() the moment the MADT
>> CPU wakeup is used instead of making it based on TDX.
> 
> I guess we can go this path if you are fine with taking CR4.MCE and shared
> memory reverting patches (they require some rework, but I can get them
> into shape quickly). After that we can forbid kexec on machines with MADT
> if nr_cpus > 1.

This goes back to what I asked before: is anyone actually going to *use*
a single-processor system that wants to kexec()?  If not, let's not
waste the time to introduce code that is just going to bitrot.  Just
mark it broken and move on with life.

I'm also a _bit_ curious what the implications of the CR4.MCE
preservation are.  IIRC, systems are quite a bit less stable when
CR4.MCE==0.  So, maybe there are some benefits to leaving it set during
kexec() for everyone.  But, that probably also involves having a #MC
handler in the mix and that's obviously trouble while we're switching
kernels and messing around in the guts of things like paging configuration.

The CR4.MCE change is simple enough, but it also _completely_ glossed
over the implications to non-TDX users.

I guess the overall message here is: please try to think of the big
picture a _little_ outside of the TDX world.  This patch's approach is a
bit myopic.

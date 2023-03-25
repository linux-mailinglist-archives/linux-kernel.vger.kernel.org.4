Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCC26C8F6E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 17:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjCYQZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 12:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCYQZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 12:25:38 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D641114D
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 09:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679761538; x=1711297538;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jwQo2o3j71BDLtr4OFKx+Otx015kQ5o0XvirVcMommY=;
  b=jwca3rED7VEUibfZs9SH19atUQqTo/o17Rxw0Tvp98QJganlPWcOiCRA
   lh/AzlYRMLLExf5hCYFEYWdxNpvb/Q3zMSL+ITfeyE+hSmU3R+rthEGbY
   JPq12IX5/frqLCi8FVaUht3rWxrzqQ4/vhezmmkZCcSxdFuQTnP+R1m11
   7kvPeg4mK4R9Aw2c2yNdOfTG+NwIzeVsUr7PcG41l3+mA5cPHF7XTxIKH
   AD6ql9ZDmpdZhtMjbBEs+IdYfjQ2lDQHi1mUZxV3zo4wPwU0cINcGPtAD
   cew2v3mm1yMDdkWGDyAYLY2p94jMyzyzGOCViptJUQxiUWzuqCK5ralsW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10660"; a="367725484"
X-IronPort-AV: E=Sophos;i="5.98,290,1673942400"; 
   d="scan'208";a="367725484"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 09:25:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10660"; a="660402602"
X-IronPort-AV: E=Sophos;i="5.98,290,1673942400"; 
   d="scan'208";a="660402602"
Received: from jsgross-mobl2.amr.corp.intel.com (HELO [10.209.122.137]) ([10.209.122.137])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 09:25:37 -0700
Message-ID: <ebead33b-0594-73df-56ae-f40473ac0ffc@intel.com>
Date:   Sat, 25 Mar 2023 09:25:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] x86: Disable kexec for TDX guests
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230325160128.21857-1-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230325160128.21857-1-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/23 09:01, Kirill A. Shutemov wrote:
> The last item is tricky. TDX guests use ACPI MADT MPWK to bring up
> secondary CPUs. The mechanism doesn't allow to put a CPU back offline if
> it has woken up.
...
> +int arch_kexec_load(void)
> +{
> +	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
> +		pr_warn_once("Disable kexec: not yet supported in TDX guest\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}

So, let's put all this together:

1. TDX implementations use MADT for wakeup exclusively right now (but
   are not necessarily _required_ to do so forever)
2. MADT doesn't support CPU offlining
3. kexec() requires offlining

Thus, current TDX implementations can't support TDX guests.  This
*doesn't* say that TDX will always use the MADT for wakeups.

Yet, the check you have here is for TDX and *not* for the MADT.

That seems wrong.

Let's say SEV or arm64 comes along and uses the MADT for their guests.
They'll add another arch_kexec_load(), with a check for *their* feature.

This all seems like you should be disabling kexec() the moment the MADT
CPU wakeup is used instead of making it based on TDX.

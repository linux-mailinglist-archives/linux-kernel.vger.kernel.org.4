Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085BC6DF8AE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 16:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjDLOh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 10:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbjDLOhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 10:37:16 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134418A4A
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 07:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681310207; x=1712846207;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0SbRgH4B9R0dme4WybUJVxhIP/3Kp+V3KcyD6V1aOXw=;
  b=JOr+Sp2LvbCZ2ISuu4MGWcWxgxEWznGyWHkhNiw2EJwzE1ENTNoz66OZ
   fgLXvhaz+ukZGIkh3WqjAfRXg3b7ItdJUdu2Fc2YAdSvurs60w0ljvLCr
   1qvTs+knlhIJhQvLuouf38ZX6yUMubGYwoUxwBIfZY/B/ZbAkYz2L+3vJ
   kNytzyvE37TFvkX940TmRS4OPy1tmrv9Jan9PtOvmzhjgYIdcTBao+0tR
   FGDZLZOH/t+3208z5Fm89HQm1DntPhOYq2y+wz8VvicuTo2Didq1DsZQ3
   fDaV5tVPerwHQ3wjRTzn8PhKjp5P23KJ+0GhCaN7tRqHACyCjmE+3QtHc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="342669878"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="342669878"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 07:35:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="719392833"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="719392833"
Received: from johnmusg-mobl.amr.corp.intel.com (HELO [10.255.230.24]) ([10.255.230.24])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 07:35:20 -0700
Message-ID: <ab569bc4-df47-819a-4a72-1e1ab696f9b2@intel.com>
Date:   Wed, 12 Apr 2023 07:35:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH] x86/fpu/xstate: Add more diagnostic information on
 inconsistent xstate sizes
Content-Language: en-US
To:     Fenghua Yu <fenghua.yu@intel.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Chintan M Patel <chintan.m.patel@intel.com>,
        Thiago Macieira <thiago.macieira@intel.com>
References: <20230405183942.734019-1-fenghua.yu@intel.com>
 <113918f9-0e44-3d46-8b48-028277ec26bb@intel.com>
 <c716e021-99ad-2cb7-44c0-ec8393a3440d@intel.com>
 <2af114b9-2737-70e5-f534-e60416b52246@intel.com>
 <50e67263-33ba-9921-1bc2-a37b99bc2459@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <50e67263-33ba-9921-1bc2-a37b99bc2459@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/23 18:21, Fenghua Yu wrote:
> In other words, splitting max_features into XCR0 and IA32_XSS and
> showing them individually provide more useful debug info than one single
> max_features value.
> 
> Does it make sense?

Not to me.

>> I still expect some acknowledgment of what is coded here for the
>> kernel calculation details.
> 
> The kernel calculation is shown in
> +        print_xstate_offset_size();
> +        pr_info("x86/fpu: total size: %u bytes\n", size);
> 
> Isn't that detailed enough to show offset and size of each xstate and
> sum of sizes?
> 
> After that,
> +    pr_info("x86/fpu: kernel_size from CPUID.0xd.0x%x:EBX: %u bytes\n",
> +               compacted ? 1 : 0, kernel_size);
> shows how kernel_size is calculated from CPUID?
> 
> Using the above debug info, a real platform CPUID issue is shown clearly.
> 
> What other details are needed?

I was kinda hoping this would be a simple, non-controversial patch that
would get us better debugging info the next time that the microcode or a
bad VMM screws up.  This patch isn't turning out to be as simple as I hoped.

I was wrong.  Let's just drop this.


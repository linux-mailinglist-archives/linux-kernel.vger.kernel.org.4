Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2903B6A4086
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 12:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjB0LZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 06:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjB0LZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 06:25:10 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6841E5D1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 03:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677497106; x=1709033106;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ZhDR9aJN+qcowocsd4XJblbmDE2VcBYat/ivv40dAVs=;
  b=L+EA2tEopWMv81f3BrAo7/iI+FGIRww6NwHUJZGHB6+lcbZnZdCQSpJV
   SjfFZd9ry9UvuawWY5Vyhu/1LzNpIXiE3GmERcMP2pEbH3KN0L81nNVmS
   qH6KZ546WO8YazhQWVtGj57iDLM5NOyJwD42JRQ+63bZSLcTkpAt7Cg1L
   SyblZ0jWg5cINfXCRlKJluZKbXz2un+b1CuMFiqFdFFCDxTS1q13jd6wy
   xVsx/fq+S2PJyBGHzWVSo+BZXyl1zkF1RU5JleUxZHhzwhrq6XkLvBDzB
   iKJkxQUZntm1PKrJoNiS/Tc1gATkPWpw+3ljXXiUfbIcDA82oiEp9l7dl
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="396390236"
X-IronPort-AV: E=Sophos;i="5.97,331,1669104000"; 
   d="scan'208";a="396390236"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 03:25:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="797596437"
X-IronPort-AV: E=Sophos;i="5.97,331,1669104000"; 
   d="scan'208";a="797596437"
Received: from ipu5-build.bj.intel.com (HELO [10.238.232.139]) ([10.238.232.139])
  by orsmga004.jf.intel.com with ESMTP; 27 Feb 2023 03:25:04 -0800
Subject: Re: System boot failure related to commit 'irqdomain: Switch to
 per-domain locking'
To:     Johan Hovold <johan@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        johan+linaro@kernel.org, hsinyi@chromium.org, maz@kernel.org
References: <d2290916-f78c-4b0a-d706-0955ae0aa4ff@linux.intel.com>
 <Y/yNxQADtJJLFY5W@hovoldconsulting.com>
From:   Bingbu Cao <bingbu.cao@linux.intel.com>
Message-ID: <fff4df7a-1c19-72e4-c9ab-aeed27b9bc6d@linux.intel.com>
Date:   Mon, 27 Feb 2023 19:25:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <Y/yNxQADtJJLFY5W@hovoldconsulting.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/27/23 7:02 PM, Johan Hovold wrote:
> On Mon, Feb 27, 2023 at 06:46:05PM +0800, Bingbu Cao wrote:
>>
>> Hi, Johan and Zyngier, 
>>
>> I am using a Dell XPS laptop(Intel Processor) just update my
>> Linux kernel to latest tag 6.2.0, and then I see that the kernel
>> cannot boot successfully, it reported:
>> --------------------------------------------
>> Gave up waiting for root file system device. Common problems:
>>  - Boot args (cat /proc/cmdline)
>>    - Check rootdelay= (did the system wait long enough?)
>>  - Missing modules (cat /proc/modules; ls /dev)
>>
>> ALERT! UUID=xxxxxxx does not exist. Dropping to shell!
>> --------------------------------------------
>>
>> And then it drop into initramfs shell, I try to use 'blkid' to
>> get block devices information, but it showed nothing.
>>
>> I also tried add 'rootdelay' and 'rootwait' in bootargs, but it did
>> not work.
>>
>> I am sure that my previous kernel 6.2.0-rc4 work normally, so I
>> did some bisect and found the commit below cause the failure on
>> my system:
>>
>> 9dbb8e3452ab irqdomain: Switch to per-domain locking
> 
> This commit is not in 6.2.0, so I assume you're using a build of Linus's
> master branch (i.e. what will become 6.3-rc1)?

Yes, I am using Linus's master branch, the HEAD is d2980d8d8265.

> 
>> I really have no idea why it cause my problem, but I see just
>> reverting this commit really help me.
>>
>> Do you have any idea?
> 
> Is there anything suspicious in dmesg (e.g. any new warnings or stack
> dumps)?

No crash, just the initramfs warning message I mentioned above.

> 
> One issue with the above commit that affects some systems (e.g. using
> xen virtualisation) has been reported and fixed already. Could you try
> applying the following and see if that helps?
> 
> 	https://lore.kernel.org/all/20230223083800.31347-1-jgross@suse.com/
>

Thanks, I will try and come back.

> Johan
> 

-- 
Best regards,
Bingbu Cao

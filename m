Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FB06A6B8D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 12:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjCALRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 06:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCALRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 06:17:18 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDE937B4C
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 03:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677669437; x=1709205437;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=kBBN/yQdHk3I6ymsmfggIX2jgFpUV985vN1CFVmhO4Q=;
  b=hj2rP8Xq/hv/UQgZgmt83yoevUVv5tgOoz38PaekHPUlmMTzX3ht8t30
   Gp6nLWQjsDC0wRco6cRXQlk6mfH8M7t3U5mpWgGP95qhPYl1ILcP1kg2M
   YCazMChVH6mAJ0LqYX3pjqVevNI93bXUP7uDdu7A53hLphxpuuZ9Bjgj3
   ZiqokjtcPlg6i2tVLbGwvmqC2V48kYCMwTjC2iDNIvwjfPIS5VrTa84lM
   WdGVwkSTOlxzG3H/8HCg9Xm1ZTCqIpoFL+MzVxzQXHxJBarNmnIPoY1n5
   6W0ArPnkqXS0ajDeiS5RcgQuBM2Jhi+VobZspvqXDqUxcjg8pmw64syrD
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="361962608"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="361962608"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 03:17:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="817525598"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="817525598"
Received: from ipu5-build.bj.intel.com (HELO [10.238.232.139]) ([10.238.232.139])
  by fmsmga001.fm.intel.com with ESMTP; 01 Mar 2023 03:17:16 -0800
Subject: Re: System boot failure related to commit 'irqdomain: Switch to
 per-domain locking'
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, johan+linaro@kernel.org,
        hsinyi@chromium.org
References: <d2290916-f78c-4b0a-d706-0955ae0aa4ff@linux.intel.com>
 <d595de9168d45bb5e863942ab7a78e3d@kernel.org>
From:   Bingbu Cao <bingbu.cao@linux.intel.com>
Message-ID: <32175259-ee22-9288-475c-db0da1ccee41@linux.intel.com>
Date:   Wed, 1 Mar 2023 19:17:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d595de9168d45bb5e863942ab7a78e3d@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/28/23 8:45 AM, Marc Zyngier wrote:
> On 2023-02-27 10:46, Bingbu Cao wrote:
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
>>
>> I really have no idea why it cause my problem, but I see just
>> reverting this commit really help me.
>>
>> Do you have any idea?
> 
> Please provide us with a kernel boot log. It is very hard
> to figure out what is going on without it. It would also
> help if you indicated what sort of device is your root
> filesystem on (NVMe, SATA, USB...), as it would narrow the
> search for the culprit.

Unfortunately, I have not find a way to capture the console log, no
serial for me. I am using a NVMe for my rootfs. By checking the
screen log, I see that 1 kernel message is missing:

[    4.193375] EXT4-fs (nvme0n1p3): mounted filesystem a9e1243b-332f-46ce-a5e7-cea86b44f797 with ordered data mode. Quota mode: none.

> 
> Thanks,
> 
>         M.

-- 
Best regards,
Bingbu Cao

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFAD5FE6EB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 04:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiJNCW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 22:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiJNCW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 22:22:26 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450C1F41AE
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 19:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665714145; x=1697250145;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CaLWbt1c714MnoQu7hYALK9/rhzbTBQ6aO3SLODBGfM=;
  b=b18C/ipa65Bzcpvz1jHWSvSz4wpS9P0Rcu0orfiJOXL5PaqHEEHXQyln
   RTRfXBU/t8wFOXEQ6nv5goVLShnFChJ/b2HuqIPR8ynG8jjSMbZBGqUKB
   G2fU39muT/FZmZ+CiFY0Ayma0QIhHIZUHWUwL7Zk+iL7hEOhEZ80skn2F
   w4Pw+0ED3M6KwVhNxwEz1fobVJIQ3c9bZ4t2f4wLCWqjGAVvwMgcKo2tS
   v/vqCwYS+6PW1U+FBHq//AHdFS1HoI+pMus5KWVQ3yltfI4o72BMPBpHK
   ifiSiNvjmbLheqCZzMNutdS8d3kOlNcBgG/7e7IkdpY1mk9K9A2soTdUl
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="391565716"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="391565716"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 19:22:25 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="769862061"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="769862061"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.210.33]) ([10.254.210.33])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 19:22:23 -0700
Message-ID: <ea7ea775-5b87-82d6-c30a-8e60f1462476@linux.intel.com>
Date:   Fri, 14 Oct 2022 10:22:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>
Subject: Re: [RFC PATCH] iommu/vt-d: Add sanity check to
 iommu_sva_bind_device()
Content-Language: en-US
To:     Jerry Snitselaar <jsnitsel@redhat.com>
References: <20221013153355.2365865-1-jsnitsel@redhat.com>
 <89029bfb-bdf6-43e3-b24c-09c266277f0e@linux.intel.com>
 <20221014021043.4rpzufoleeg7z5gx@cantor>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20221014021043.4rpzufoleeg7z5gx@cantor>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/14 10:10, Jerry Snitselaar wrote:
> On Fri, Oct 14, 2022 at 09:52:44AM +0800, Baolu Lu wrote:
>> On 2022/10/13 23:33, Jerry Snitselaar wrote:
>>> iommu_sva_bind_device() should only be called if
>>> iommu_dev_enable_feature() succeeded. There has been one case already
>>> where that hasn't been the case, which resulted in a null pointer
>>> deref in dev_iommu_ops(). To avoid that happening in the future if
>>> another driver makes that mistake, sanity check dev->iommu and
>>> dev->iommu->iommu_dev prior to calling dev_iommu_ops().
>>>
>>> Cc: Joerg Roedel<joro@8bytes.org>
>>> Cc: Will Deacon<will@kernel.org>
>>> Cc: Robin Murphy<robin.murphy@arm.com>
>>> Cc: Lu Baolu<baolu.lu@linux.intel.com>
>>> Signed-off-by: Jerry Snitselaar<jsnitsel@redhat.com>
>>> ---
>>> drivers/iommu/iommu.c | 10 +++++++++-
>>>    1 file changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>> index 4893c2429ca5..20ec75667529 100644
>>> --- a/drivers/iommu/iommu.c
>>> +++ b/drivers/iommu/iommu.c
>>> @@ -2746,7 +2746,15 @@ iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
>>>    {
>>>    	struct iommu_group *group;
>>>    	struct iommu_sva *handle = ERR_PTR(-EINVAL);
>>> -	const struct iommu_ops *ops = dev_iommu_ops(dev);
>>> +	const struct iommu_ops *ops;
>>> +
>>> +	if (!dev->iommu || !dev->iommu->iommu_dev) {
>>> +		dev_warn(dev, "%s called without checking succes of iommu_dev_enable_feature?\n",
>>> +			__func__);
>>> +		return ERR_PTR(-ENODEV);
>>> +	}
>> If that's the case, dev_iommu_ops() will warn a NULL pointer reference.
>> This kind of error will be discovered at the first place.
>>
>> Best regards,
>> baolu
>>
> It will warn this by crashing the system (example from back when idxd had the problem):
> 
>      [   21.423729] BUG: kernel NULL pointer dereference, address: 0000000000000038
>      [   21.445108] #PF: supervisor read access in kernel mode
>      [   21.450912] #PF: error_code(0x0000) - not-present page
>      [   21.456706] PGD 0
>      [   21.459047] Oops: 0000 [#1] PREEMPT SMP NOPTI
>      [   21.464004] CPU: 0 PID: 1420 Comm: kworker/0:3 Not tainted 5.19.0-0.rc3.27.eln120.x86_64 #1
>      [   21.464011] Hardware name: Intel Corporation EAGLESTREAM/EAGLESTREAM, BIOS EGSDCRB1.SYS.0067.D12.2110190954 10/19/2021
>      [   21.464015] Workqueue: events work_for_cpu_fn
>      [   21.464030] RIP: 0010:iommu_sva_bind_device+0x1d/0xe0
>      [   21.464046] Code: c3 cc 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 41 57 41 56 49 89 d6 41 55 41 54 55 53 48 83 ec 08 48 8b 87 d8 02 00 00 <48> 8b 40 38 48 8b 50 10 48 83 7a 70 00 48 89 14 24 0f 84 91 00 00
>      [   21.464050] RSP: 0018:ff7245d9096b7db8 EFLAGS: 00010296
>      [   21.464054] RAX: 0000000000000000 RBX: ff1eadeec8a51000 RCX: 0000000000000000
>      [   21.464058] RDX: ff7245d9096b7e24 RSI: 0000000000000000 RDI: ff1eadeec8a510d0
>      [   21.464060] RBP: ff1eadeec8a51000 R08: ffffffffb1a12300 R09: ff1eadffbfce25b4
>      [   21.464062] R10: ffffffffffffffff R11: 0000000000000038 R12: ffffffffc09f8000
>      [   21.464065] R13: ff1eadeec8a510d0 R14: ff7245d9096b7e24 R15: ff1eaddf54429000
>      [   21.464067] FS:  0000000000000000(0000) GS:ff1eadee7f600000(0000) knlGS:0000000000000000
>      [   21.464070] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>      [   21.464072] CR2: 0000000000000038 CR3: 00000008c0e10006 CR4: 0000000000771ef0
>      [   21.464074] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>      [   21.464076] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
>      [   21.464078] PKRU: 55555554
>      [   21.464079] Call Trace:
>      [   21.464083]  <TASK>
>      [   21.464092]  idxd_pci_probe+0x259/0x1070 [idxd]
>      [   21.464121]  local_pci_probe+0x3e/0x80
>      [   21.464132]  work_for_cpu_fn+0x13/0x20
>      [   21.464136]  process_one_work+0x1c4/0x380
>      [   21.464143]  worker_thread+0x1ab/0x380
>      [   21.464147]  ? _raw_spin_lock_irqsave+0x23/0x50
>      [   21.464158]  ? process_one_work+0x380/0x380
>      [   21.464161]  kthread+0xe6/0x110
>      [   21.464168]  ? kthread_complete_and_exit+0x20/0x20
>      [   21.464172]  ret_from_fork+0x1f/0x30
> 
> 
> It was doing that to SPR systems that didn't boot with
> intel_iommu=on. They had to either enable the iommu, or blacklist the
> idxd driver until the idxd driver had a fix. The idea here is to
> avoid taking the system down, and just have the driver get an error back.

If IOMMU is disabled, the iommu_dev_enable_feat(SVA) will return an
error, the idxd driver should not call the sva_bind() interfaces
anymore. If the driver doesn't do like this, why not fixing it in the
driver itself?

Best regards,
baolu

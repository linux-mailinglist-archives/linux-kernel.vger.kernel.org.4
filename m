Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A663E5BE5FC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 14:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbiITMgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 08:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbiITMgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 08:36:48 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D1E63F2C
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 05:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663677408; x=1695213408;
  h=message-id:date:mime-version:cc:to:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=wtkAS7KuHKxzGlHg4d4ChJkWAwekXAqu6+rT+/GIgiM=;
  b=ZXwBYFCDhlOZ6W7ehmJnZr49nkXxVF5xwfshfgtSCzEfnLhj9DsDd79Y
   EMauxpYPp5RgZ/tuYQ7MNXyjala4gMuV0XHleE7CXE8Ppev68d1m7WkiJ
   v4RkPAxpP6QUMo4aFaCu2+6EZfQ6d2Q6/HD3w0nvMkLsDwDH50P0ek410
   4pZO/sUbWoKeBihg9s5od7+hnhwyCfe6mHBu7eY9it3XvuMXD8pLbcBcZ
   Yoiqy9cxg+tx46RcOUw9JNF7TTLvwswtjJBy/0lCq3FnyhmQ5nkfR/AfN
   fsdQNFha+6Ah/Dc0ZLRDEeGRVdNrRX87UONvGjEE2dG3TY3Lo3x3DpZMs
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="298405620"
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="298405620"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 05:36:47 -0700
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="614378069"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.208.130]) ([10.254.208.130])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 05:36:44 -0700
Message-ID: <f35fd9ba-770c-7e48-a4d6-22095ea79072@linux.intel.com>
Date:   Tue, 20 Sep 2022 20:36:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        George Hilliard <thirtythreeforty@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        iommu@lists.linux.dev
References: <20220920081701.3453504-1-baolu.lu@linux.intel.com>
 <d2224046-f457-5daf-f944-a13dd4b31477@leemhuis.info>
 <80ec6696-f525-edfb-4dba-dd6ae25c61ee@arm.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 1/1] Revert "iommu/vt-d: Fix possible recursive locking in
 intel_iommu_init()"
In-Reply-To: <80ec6696-f525-edfb-4dba-dd6ae25c61ee@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/20 20:16, Robin Murphy wrote:
> On 2022-09-20 12:58, Thorsten Leemhuis wrote:
>> On 20.09.22 10:17, Lu Baolu wrote:
>>> This reverts commit 9cd4f1434479f1ac25c440c421fbf52069079914.
>>
>> Thx for taking care of this.
>>
>>> Some issues were reported on the original commit. Some thunderbolt 
>>> devices
>>> don't work anymore due to the following DMA fault.
>>>
>>> DMAR: DRHD: handling fault status reg 2
>>> DMAR: [INTR-REMAP] Request device [09:00.0] fault index 0x8080
>>>        [fault reason 0x25]
>>>        Blocked a compatibility format interrupt request
>>>
>>> Bring it back for now to avoid functional regression.
>>>
>>> Fixes: 9cd4f1434479f ("iommu/vt-d: Fix possible recursive locking in 
>>> intel_iommu_init()")
>>> Link: 
>>> https://lore.kernel.org/linux-iommu/485A6EA5-6D58-42EA-B298-8571E97422DE@getmailspring.com/
>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216497
>>
>> Both those reports were against 5.19.y, so this afaics should have a
>>
>> Cc: <stable@vger.kernel.org> # 5.19.x
>>
>> to ensure it's backported.
>>
>> Speaking of which: Joerg/Will/Robin, it seems quite a few people are
>> running into this, it hence would be great to get this quickly mainlined
>> (maybe by letting Linus pick it up straight from the list once ready?)
>> so stable can pick it up.
> 
> As a heads-up, a straight revert is likely to lead to people reporting 
> lockdep warnings against -next, for the patches queued there which 
> exposed this dodgy locking in the first place.

I plan to fix that lockdep warning with below patch:

https://github.com/LuBaolu/intel-iommu/commit/dff18af627a2a76651b74cd6531f3e9357a97072

It works on my test machines. I am about to test it with more hardware.

> 
> Does it work to just move the dmar_register_bus_notifier() call back to 
> where it was, without undoing the rest of the patch? That seems like the 
> change that's overwhelmingly likely to have broken IRQ remapping, and 
> TBH it wasn't clear to me why the original patch moved it to begin with.

The callbacks of dmar_register_bus_notifier() possibly races with
intel_iommu_init(). So the offending commit had to move it down until
the Intel IOMMU initialization is done.

Best regards,
baolu
